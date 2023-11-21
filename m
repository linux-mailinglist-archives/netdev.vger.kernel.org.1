Return-Path: <netdev+bounces-49544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DED7F2566
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 06:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB5B217E7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 05:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD09D19458;
	Tue, 21 Nov 2023 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNAsSSvo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB171944E
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 05:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855F8C433C8;
	Tue, 21 Nov 2023 05:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700545245;
	bh=+sv4sqIwJ1DBN+lAadvJyHjPAOlSCknUKxyhTkdjZXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNAsSSvoYIP2LLgz9Ljev31QZYO5lfnb8DtSqYDH3eLpZ8mXnD7Crwf18A5X37Oeo
	 Bz5ZMOZPuwj/CDkVkomXdfOOCo8zrduMl0spxr2aoD83Ompyke6wcjSsPs89/OHh1Z
	 Fzu4wcDFng8aSFAA0RwDBlAKo8jIvldpjMAt9NIM=
Date: Tue, 21 Nov 2023 06:40:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com,
	Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>
Subject: Re: [PATCH net-next] net: do not send a MOVE event when netdev
 changes netns
Message-ID: <2023112132-crummiest-onion-de48@gregkh>
References: <20231120184140.578375-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120184140.578375-1-kuba@kernel.org>

On Mon, Nov 20, 2023 at 10:41:40AM -0800, Jakub Kicinski wrote:
> Networking supports changing netdevice's netns and name
> at the same time. This allows avoiding name conflicts
> and having to rename the interface in multiple steps.
> E.g. netns1={eth0, eth1}, netns2={eth1} - we want
> to move netns1:eth1 to netns2 and call it eth0 there.
> If we can't rename "in flight" we'd need to (1) rename
> eth1 -> $tmp, (2) change netns, (3) rename $tmp -> eth0.
> 
> To rename the underlying struct device we have to call
> device_rename(). The rename()'s MOVE event, however, doesn't
> "belong" to either the old or the new namespace.
> If there are conflicts on both sides it's actually impossible
> to issue a real MOVE (old name -> new name) without confusing
> user space. And Daniel reports that such confusions do in fact
> happen for systemd, in real life.
> 
> Since we already issue explicit REMOVE and ADD events
> manually - suppress the MOVE event completely. Move
> the ADD after the rename, so that the REMOVE uses
> the old name, and the ADD the new one.
> 
> If there is no rename this changes the picture as follows:
> 
> Before:
> 
> old ns | KERNEL[213.399289] remove   /devices/virtual/net/eth0 (net)
> new ns | KERNEL[213.401302] add      /devices/virtual/net/eth0 (net)
> new ns | KERNEL[213.401397] move     /devices/virtual/net/eth0 (net)
> 
> After:
> 
> old ns | KERNEL[266.774257] remove   /devices/virtual/net/eth0 (net)
> new ns | KERNEL[266.774509] add      /devices/virtual/net/eth0 (net)
> 
> If there is a rename and a conflict (using the exact eth0/eth1
> example explained above) we get this:
> 
> Before:
> 
> old ns | KERNEL[224.316833] remove   /devices/virtual/net/eth1 (net)
> new ns | KERNEL[224.318551] add      /devices/virtual/net/eth1 (net)
> new ns | KERNEL[224.319662] move     /devices/virtual/net/eth0 (net)
> 
> After:
> 
> old ns | KERNEL[333.033166] remove   /devices/virtual/net/eth1 (net)
> new ns | KERNEL[333.035098] add      /devices/virtual/net/eth0 (net)
> 
> Note that "in flight" rename is only performed when needed.
> If there is no conflict for old name in the target netns -
> the rename will be performed separately by dev_change_name(),
> as if the rename was a different command, and there will still
> be a MOVE event for the rename:
> 
> Before:
> 
> old ns | KERNEL[194.416429] remove   /devices/virtual/net/eth0 (net)
> new ns | KERNEL[194.418809] add      /devices/virtual/net/eth0 (net)
> new ns | KERNEL[194.418869] move     /devices/virtual/net/eth0 (net)
> new ns | KERNEL[194.420866] move     /devices/virtual/net/eth1 (net)
> 
> After:
> 
> old ns | KERNEL[71.917520] remove   /devices/virtual/net/eth0 (net)
> new ns | KERNEL[71.919155] add      /devices/virtual/net/eth0 (net)
> new ns | KERNEL[71.920729] move     /devices/virtual/net/eth1 (net)
> 
> If deleting the MOVE event breaks some user space we should insert
> an explicit kobject_uevent(MOVE) after the ADD, like this:
> 
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11192,6 +11192,12 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
>  	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
>  	netdev_adjacent_add_links(dev);
> 
> +	/* User space wants an explicit MOVE event, issue one unless
> +	 * dev_change_name() will get called later and issue one.
> +	 */
> +	if (!pat || new_name[0])
> +		kobject_uevent(&dev->dev.kobj, KOBJ_MOVE);
> +
>  	/* Adapt owner in case owning user namespace of target network
>  	 * namespace is different from the original one.
>  	 */
> 
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Daniel Gröber <dxld@darkboxed.org>
> Link: https://lore.kernel.org/all/20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

