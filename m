Return-Path: <netdev+bounces-44520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D07D8670
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FE828203E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4C37C9B;
	Thu, 26 Oct 2023 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/f7WK+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932622F509
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7BBC433C8;
	Thu, 26 Oct 2023 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698336266;
	bh=GqGU96cGv4bzLC7G+rJUVStRGuDN3/2nMIwE4tBmyBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q/f7WK+4auG/jWzOw9/fHTJhRQVlcsOvFr8g+CjhPtfHkIfi4ryc3cXVrQ9fuBDRL
	 dHm95a+O3oSSL3l3JesMr/Wde+/fxG9DrD80aOUV1Q/j8mHOen0Ojsq0cDZA7p8X8j
	 QfiCNpw7p5bChX8iwSpy66eME0Z1gbKQIcITeC0cu0tYFZSDABq05wOj0pa2bvM/1i
	 /SLop1qqDbe7uVWB5xEl2JupetBFCJtVjBPC0ZfTKUnUYQdsMDqeg1nFy0oXc/yJem
	 4BqBJBMQpd2qyEXN2JTH6prTdyuVypFTYZS3/H3qL+wCv2R7nRlMJMQtdDBGzfIZh1
	 7TWxEBNqVBwUA==
Date: Thu, 26 Oct 2023 09:04:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vincent Bernat <vincent@bernat.ch>
Cc: Alce Lafranque <alce@lafranque.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7] vxlan: add support for flowlabel inherit
Message-ID: <20231026090424.73a49f35@kernel.org>
In-Reply-To: <8adb039f-00db-40a1-bcb6-4379e823fd0b@bernat.ch>
References: <20231024165028.251294-1-alce@lafranque.net>
	<20231025182019.1cf5ab0d@kernel.org>
	<8adb039f-00db-40a1-bcb6-4379e823fd0b@bernat.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 17:53:22 +0200 Vincent Bernat wrote:
> >> +	enum ifla_vxlan_label_policy	label_policy;  
> > 
> > Here, OTOH, you could save some space, by making it a u8.  
> 
> Is it worth it?

I'm just pointing out the irony of trying to save space in netlink,
where everything is aligned to 4B, and not trying where it may actually
matter :)

> Keeping an enum helps the compiler catching some 
> mistakes and it documents a bit the code (we could put a comment 
> instead). In most cases, there is not a lot of vlan_config structs lying 
> around (when there are many VXLAN devices, people use single VXLAN 
> devices), so it shouldn't be a problem for memory or cache.

Pretty sure the single switch statement will be just fine without 
to compiler helping us. Plus we won't have to re-align the struct :S

> Alternatively, we could push this to another patch that would also 
> handle df field.

Meh.

