Return-Path: <netdev+bounces-108225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A891E71E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAAA1C21976
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89616D31E;
	Mon,  1 Jul 2024 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z07Cvyo4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA114BF8F
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857265; cv=none; b=O3i6ugs+5ffim/vEQoNcF+uZlaYERgL886NBNNvjmtOq2X6EyGeWhxgAACNAM7ZyRWmOqWcO+hI70yYhWihEtODa5ILjna+TnWLvi6mBsTYJTTOMgH+1Vvjicqa81h6Gsi2WAB3cRVM0G0RXLPE+iiteGvwIvAMpQDJD+Vk9QjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857265; c=relaxed/simple;
	bh=0WJK0DQDMfrrm9aLm0I8hI63X3HOuwUlbMdXiHGcn8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gsN9uskhTRDaZmmeo/rzn7272kB2uBeB5y3ac+vDH9reAXz34hS2Ax3YRQs8iwVdWhulovA3+nKWDoaxc/KL601BpKA6AAPkkWRROKm04/YhcGaQ9cEWokEaD1edJ6uLXStruvbc+N0meHEsriyEjtANvmuRUsxcndDVk6/rxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z07Cvyo4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719857263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=slpaHcT+KzFuwGQ23ExD/xCBjj0LGNVOshtAT3iwP8k=;
	b=Z07Cvyo4JMgHUo0iPQdcEuQ+kAtSBfYEoQH/xH0/InG64BhIZRF8JhpJ6TxcLkafik/1gz
	yyjelNTqTKYBStbpEJF3ncdTHxnyaLYd5AwPiNB35TDzXFPydEi7PxPfzsf70/6G0j1kL6
	awIklrUC5m1bsNWhzwRFUXBXk+5vVq0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-b7wbM74EMFWBdPyQ0W8ugg-1; Mon,
 01 Jul 2024 14:07:40 -0400
X-MC-Unique: b7wbM74EMFWBdPyQ0W8ugg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FA3C19560AE;
	Mon,  1 Jul 2024 18:07:38 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3063C3000218;
	Mon,  1 Jul 2024 18:07:34 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Ido Schimmel
 <idosch@nvidia.com>,  Yotam Gigi <yotam.gi@gmail.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 03/10] net: psample: skip packet copy if no
 listeners
In-Reply-To: <20240630195740.1469727-4-amorenoz@redhat.com> (Adrian Moreno's
	message of "Sun, 30 Jun 2024 21:57:24 +0200")
References: <20240630195740.1469727-1-amorenoz@redhat.com>
	<20240630195740.1469727-4-amorenoz@redhat.com>
Date: Mon, 01 Jul 2024 14:07:32 -0400
Message-ID: <f7ttth9vvdn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Adrian Moreno <amorenoz@redhat.com> writes:

> If nobody is listening on the multicast group, generating the sample,
> which involves copying packet data, seems completely unnecessary.
>
> Return fast in this case.
>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

>  net/psample/psample.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index b37488f426bc..1c76f3e48dcd 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -376,6 +376,10 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  	void *data;
>  	int ret;
>  
> +	if (!genl_has_listeners(&psample_nl_family, group->net,
> +				PSAMPLE_NL_MCGRP_SAMPLE))
> +		return;
> +
>  	meta_len = (in_ifindex ? nla_total_size(sizeof(u16)) : 0) +
>  		   (out_ifindex ? nla_total_size(sizeof(u16)) : 0) +
>  		   (md->out_tc_valid ? nla_total_size(sizeof(u16)) : 0) +


