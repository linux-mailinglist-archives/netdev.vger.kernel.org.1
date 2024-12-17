Return-Path: <netdev+bounces-152600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D557E9F4C63
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99C11884DA0
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E031F3D41;
	Tue, 17 Dec 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciOv8CiU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A521F3D29
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442037; cv=none; b=AKFTm4jBxceDupbnLzRMvK59GRQu4a4h9XelBe4tRxEjJ0mDHZgW/lUD4E902RAKJTVoqUZSUdWuneKUn0cvzcUxaG0pDWHdURg5MnBohV3195DCbWbnH2qjTaU0OR0veqt+feXRQMcnCo36Xllk9tAq8zAg67S3XX+874D0o3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442037; c=relaxed/simple;
	bh=oXu9vyR8bEvz/6FdRmpHZsnE9d8Gvkxr2zsBDjlNIDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZmWPEmg4KbN/D9beXIc6Z9z/qvmOb3Q0YqNkvNZpt0Vc+eCErY+io4jdFItShmzfI7FEii2NoZuG/QVW26hJtNyeQ2A+WzywhnEaHIWjoP3vsQSpdxE/qAMN4hrdSmBN3/QM8b5wTctp0Fl8rq5OdkrNXB4f45keTnodY5BHMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciOv8CiU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734442034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k09JBCTkQ8smzatbd5fY89UwRwfw+yFRHrgaj7+5wvE=;
	b=ciOv8CiUeVPkTIaHH+ibDI55OTbiaQME2UDfm64kfeuTrH+PXIOarS9mc7IrucqBHqdjEC
	6qoi58wWyVDKPnyNIfXEY4/2iVEAZMy/7CyPQOQIOPxjmE3Dwm7NHKk3bxNrHLe7O45a95
	+B1FcQl8X52DuwPAM6mD45+Wgu76DMs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-oB4ynsq5OumJKMnUNPZI7g-1; Tue,
 17 Dec 2024 08:27:09 -0500
X-MC-Unique: oB4ynsq5OumJKMnUNPZI7g-1
X-Mimecast-MFC-AGG-ID: oB4ynsq5OumJKMnUNPZI7g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 134601956087;
	Tue, 17 Dec 2024 13:27:08 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.98])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46C7D30044C1;
	Tue, 17 Dec 2024 13:27:05 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  Yotam Gigi <yotam.gi@gmail.com>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Ido Schimmel <idosch@nvidia.com>,  Eelco
 Chaudron <echaudro@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] psample: adjust size if rate_as_probability is set
In-Reply-To: <20241217113739.3929300-1-amorenoz@redhat.com> (Adrian Moreno's
	message of "Tue, 17 Dec 2024 12:37:39 +0100")
References: <20241217113739.3929300-1-amorenoz@redhat.com>
Date: Tue, 17 Dec 2024 08:27:02 -0500
Message-ID: <f7ty10etp7d.fsf@redhat.com>
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

> If PSAMPLE_ATTR_SAMPLE_PROBABILITY flag is to be sent, the available
> size for the packet data has to be adjusted accordingly.
>
> Also, check the error code returned by nla_put_flag.
>
> Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

>  net/psample/psample.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index a0ddae8a65f9..25f92ba0840c 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -393,7 +393,9 @@ void psample_sample_packet(struct psample_group *group,
>  		   nla_total_size_64bit(sizeof(u64)) +	/* timestamp */
>  		   nla_total_size(sizeof(u16)) +	/* protocol */
>  		   (md->user_cookie_len ?
> -		    nla_total_size(md->user_cookie_len) : 0); /* user cookie */
> +		    nla_total_size(md->user_cookie_len) : 0) + /* user cookie */
> +		   (md->rate_as_probability ?
> +		    nla_total_size(0) : 0);	/* rate as probability */
>  
>  #ifdef CONFIG_INET
>  	tun_info = skb_tunnel_info(skb);
> @@ -498,8 +500,9 @@ void psample_sample_packet(struct psample_group *group,
>  		    md->user_cookie))
>  		goto error;
>  
> -	if (md->rate_as_probability)
> -		nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> +	if (md->rate_as_probability &&
> +	    nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY))
> +		goto error;
>  
>  	genlmsg_end(nl_skb, data);
>  	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,


