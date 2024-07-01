Return-Path: <netdev+bounces-108226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B498F91E730
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD30283E0C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D791216EBE6;
	Mon,  1 Jul 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFKlwTwH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225516EBE7
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857447; cv=none; b=Bjv2NT3C3XgpshWT3qNC3SgoaxABeTbcmCywjonFQZIwWyvPrq6E0A5qI6QUT0J3Sh0pe8iTpqLmbnsePj/1+72tGW2Qm14zhDt/Jgv/HAE2w/I3PIaxhGFb0uirhQg3xLsyEMCmFtXYc7TruTYFdaSe+yGbo7BMX0rpzSRddgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857447; c=relaxed/simple;
	bh=ub7wy9wbVGLRWhSD/YbjKzEHraTvzBQPoST6f7ZZa6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nhz7stiF8btH74cgqOD76+Mn1NCMQSM7avY+ROmt7/y/zB9X0Kn7ro5Sn0GuoZX587GSVINR5m0Ti8eAB9iJaTkOIoeJc2Jr6jp8pWKOE2esE6JgRHyPcj4an6HlsfDSBq9PDbVQTUZ2wouE4kA34UIrxF1CUNfPILB80ttD6X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFKlwTwH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719857445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JM1W3lT8X94kstTVgU0L4T7iVYaF/txP6qsNDPjlfkI=;
	b=FFKlwTwHvEf+tAUeBJ3U3iFWEYa6ykFOXuiN5dsnWVOBIS13owPJcw0uHvLS3QsV/SXjHI
	3A/8R8FWOGF7h59w0XRuPaQK6ZzLAXYTBIkDSI7awu3wNmLh1Jel5JLwriPP49Nan9jbDh
	VhrfjILFHAwx5YiDLvyFhw2YXeuJvcQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-HmKSMqD2MvqWr_YFd2CCXg-1; Mon,
 01 Jul 2024 14:10:42 -0400
X-MC-Unique: HmKSMqD2MvqWr_YFd2CCXg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E74CC1955DCD;
	Mon,  1 Jul 2024 18:10:39 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9332A19560AE;
	Mon,  1 Jul 2024 18:10:36 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Ido Schimmel
 <idosch@nvidia.com>,  Yotam Gigi <yotam.gi@gmail.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 04/10] net: psample: allow using rate as
 probability
In-Reply-To: <20240630195740.1469727-5-amorenoz@redhat.com> (Adrian Moreno's
	message of "Sun, 30 Jun 2024 21:57:25 +0200")
References: <20240630195740.1469727-1-amorenoz@redhat.com>
	<20240630195740.1469727-5-amorenoz@redhat.com>
Date: Mon, 01 Jul 2024 14:10:34 -0400
Message-ID: <f7tplrxvv8l.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Adrian Moreno <amorenoz@redhat.com> writes:

> Although not explicitly documented in the psample module itself, the
> definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
>
> Quoting tc-sample(8):
> "RATE of 100 will lead to an average of one sampled packet out of every
> 100 observed."
>
> With this semantics, the rates that we can express with an unsigned
> 32-bits number are very unevenly distributed and concentrated towards
> "sampling few packets".
> For example, we can express a probability of 2.32E-8% but we
> cannot express anything between 100% and 50%.
>
> For sampling applications that are capable of sampling a decent
> amount of packets, this sampling rate semantics is not very useful.
>
> Add a new flag to the uAPI that indicates that the sampling rate is
> expressed in scaled probability, this is:
> - 0 is 0% probability, no packets get sampled.
> - U32_MAX is 100% probability, all packets get sampled.
>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

>  include/net/psample.h        |  3 ++-
>  include/uapi/linux/psample.h | 10 +++++++++-
>  net/psample/psample.c        |  3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/psample.h b/include/net/psample.h
> index 2ac71260a546..c52e9ebd88dd 100644
> --- a/include/net/psample.h
> +++ b/include/net/psample.h
> @@ -24,7 +24,8 @@ struct psample_metadata {
>  	u8 out_tc_valid:1,
>  	   out_tc_occ_valid:1,
>  	   latency_valid:1,
> -	   unused:5;
> +	   rate_as_probability:1,
> +	   unused:4;
>  	const u8 *user_cookie;
>  	u32 user_cookie_len;
>  };
> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
> index e80637e1d97b..b765f0e81f20 100644
> --- a/include/uapi/linux/psample.h
> +++ b/include/uapi/linux/psample.h
> @@ -8,7 +8,11 @@ enum {
>  	PSAMPLE_ATTR_ORIGSIZE,
>  	PSAMPLE_ATTR_SAMPLE_GROUP,
>  	PSAMPLE_ATTR_GROUP_SEQ,
> -	PSAMPLE_ATTR_SAMPLE_RATE,
> +	PSAMPLE_ATTR_SAMPLE_RATE,	/* u32, ratio between observed and
> +					 * sampled packets or scaled probability
> +					 * if PSAMPLE_ATTR_SAMPLE_PROBABILITY
> +					 * is set.
> +					 */
>  	PSAMPLE_ATTR_DATA,
>  	PSAMPLE_ATTR_GROUP_REFCOUNT,
>  	PSAMPLE_ATTR_TUNNEL,
> @@ -20,6 +24,10 @@ enum {
>  	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
>  	PSAMPLE_ATTR_PROTO,		/* u16 */
>  	PSAMPLE_ATTR_USER_COOKIE,	/* binary, user provided data */
> +	PSAMPLE_ATTR_SAMPLE_PROBABILITY,/* no argument, interpret rate in
> +					 * PSAMPLE_ATTR_SAMPLE_RATE as a
> +					 * probability scaled 0 - U32_MAX.
> +					 */
>  
>  	__PSAMPLE_ATTR_MAX
>  };
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 1c76f3e48dcd..f48b5b9cd409 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -497,6 +497,9 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  		    md->user_cookie))
>  		goto error;
>  
> +	if (md->rate_as_probability)
> +		nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> +
>  	genlmsg_end(nl_skb, data);
>  	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>  				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);


