Return-Path: <netdev+bounces-275903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHTKJQnD1GmWwwcAu9opvQ
	(envelope-from <netdev+bounces-275903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:40:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EDD3AB761
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAB0130143C5
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B393382E8;
	Tue,  7 Apr 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+oFPDZ6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLxbqCa7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F344B3290D1
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551237; cv=none; b=Tc4YxlL+C9HVO3Dwt39YXXzJGolgMebKN1czOoPhV95B8RZHbdH67omAILnmXEuyDtZxSIA7giLzFOZRJEQM15uSHWHD2XqXsShErBQWP8ZavJT7mD69o0UkNx7tH1/sWs+wiBOSOWoSN/JjGS5f20WzUNmq1IG8V+zc2dI7JFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551237; c=relaxed/simple;
	bh=ejmEyywK2WSRIPaYPbkntLAAetY4O7LbO5K5Jq9jH0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idBhugimYRGTyZ2PJtgMgh5Tv6mAuPsXiJNvLR1pEjNEHMbS70vybTFc5Y08Uyy/Lxm0Glcxw+7mw5co7SoGarLcSEoYCXibuz0xmmAgthRlWcIxYgYzwmJ4anHihhKwz1f6c8ADHSZSkWCAuvZpRAoBBGz+fJQLpCDyhq9E0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+oFPDZ6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLxbqCa7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775551235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaedIHx4F/c1NkqfnnSCEIMN223CyA6ym5PGRvlRg54=;
	b=U+oFPDZ6j+TIhFjAd95n7MWHm0Nr+0fGC+ryS6ySKrX/bqSmJX+/yhtnrJK4gNwSawgqEQ
	GdGb0Ka/b6c0/xyKTjCIiRzKvd/RMEe57Gwm7srOqPQujRM8ZmDuuZhQ1nEkhXtYvSNcKz
	lc0lsnRuGJLkG+83B0HmaVRvQrCkZGk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Qm7Z8clQOy27WmCwSyY2Jw-1; Tue, 07 Apr 2026 04:40:33 -0400
X-MC-Unique: Qm7Z8clQOy27WmCwSyY2Jw-1
X-Mimecast-MFC-AGG-ID: Qm7Z8clQOy27WmCwSyY2Jw_1775551232
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b8f9374dfso3872440f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 01:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775551232; x=1776156032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OaedIHx4F/c1NkqfnnSCEIMN223CyA6ym5PGRvlRg54=;
        b=RLxbqCa7oWv6dCKM0TGS26SX3HF3nxYXSaDNHIh2bmA+a260VIOEsS3l0tcOUGJ01U
         g6nMzB0LASAIHxKUubUT/H1FV57j15I7EbsTcKhYQQR6Jd1Wikogjg6B60OzgnSQhEAR
         Z1Im6kVEZ7uCaSJ6c+Iov7q8PYNwStq8THbV3eroAMi1Q7yWoJh4tQl2yxyoL0lK4OMl
         GrFBH2nzDeZPGg0/yoUA+ZBEYE6i43pjt0MzK6X4HmD2vwgVmCkGSvIfSo9wBO+Za4FC
         Pm2WNgC8MoZPwi3ojPKq0iSHjIJ2YkIYFC++SaKLGN0MdLa3JxOFuel27F4I29sDBVR5
         IKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551232; x=1776156032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaedIHx4F/c1NkqfnnSCEIMN223CyA6ym5PGRvlRg54=;
        b=RMb9zbYPEpyalSJvuKuIA95xb38EDCLmieRcPgz1KCyvTqK63tOOG9Xjs/nfJ+m+r2
         clx9thZkkrbhX5UUCEJ/RP03gZjyXOQ9J32mfUD4V0+JutHZ4KNK3mR5V30Oy/uxKmEv
         luXzKYF/4MN/40zQn0r9R9Px1MY86K4IxO/JGYWCGh6+vr2gv84z8S00LtPFV8bnXRJ5
         pJoWfpzViOv+0k0yLx6D/FQvnXRbRw2EDeYG84boZ9QmWVBKw2QjJaiwnogUyglNdxoE
         JIPAqUJXKmo49dmlm0zPIwNi12gtF+R5SdWaIaCD4HUEaE6IjUsWssI0p0g1H7W9QkYo
         didw==
X-Forwarded-Encrypted: i=1; AJvYcCVM3qdx0SyjJW8JQJC2+Rq8UKab3FwX1XYfQ4MB0Ed7GUacOzz4tGWvS7nsBIGvqwE0EvoK0Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAFC320dx/qd4xii4mSi5FBNUyKkYsPDrXxq4gUt8BPjU4pA9
	tNkr0ct3v4nNL8FDGIV1xMpDTY1rzHKyPfDTYv/pZSvAsIZ5PQQi26fh7w7rGyurHlMppKJZ4hy
	ffC1jevcAO6ziqysQbxxJ7JddaMdhcyIfdNcPCrB0WQ3JrdRx9wJ81dx/ow==
X-Gm-Gg: AeBDieuFVzNlFAcgyMP2cFgNMeeHjHyGJo4g7gmvx5vjEvTSGdg/BJe6wAhCf78vz67
	TWG2xhlWj9cgYLiJx1GwCTr2e6c0YAbo8CCu6DRRYw1BZKRsSJKtYkguYMPOATKzyRKBCD/GWDd
	fATJYLDfXGtXtwVz2Jn1EJBNVlej/vnKI4RKo5JQWFACzEheDijvzWyCp3Amv1daGvv3VY/SJjx
	G2nLyJcgxQUy+CXIle/SmlMmIM4lFvSPBybOm5fgJVuMu4pKv5TsQ2taXNfpvi4+kFAS7Y+OIqy
	dFm5vsMMbEHXx4qGHM/sEbYkKiypGLrJ44k0J/Ccp/kQPx7hidXxmPMUH3umBLthQeQGM3jh8if
	O4Ev7y1/f+mGCWIBWmN7FyWNP5UVVend2hlccBpS/Sf6WfqBRAroyBr7m3A==
X-Received: by 2002:a05:6000:470c:b0:43d:184:8a89 with SMTP id ffacd0b85a97d-43d21283f3cmr24868411f8f.30.1775551231711;
        Tue, 07 Apr 2026 01:40:31 -0700 (PDT)
X-Received: by 2002:a05:6000:470c:b0:43d:184:8a89 with SMTP id ffacd0b85a97d-43d21283f3cmr24868367f8f.30.1775551231184;
        Tue, 07 Apr 2026 01:40:31 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e52a0sm46236697f8f.30.2026.04.07.01.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 01:40:30 -0700 (PDT)
Message-ID: <11d0f631-2a3a-443e-8694-e8fd4dafe717@redhat.com>
Date: Tue, 7 Apr 2026 10:40:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: hsr: avoid learning nodes from ordinary PRP SAN
 traffic
To: Ao Zhou <n05ec@lzu.edu.cn>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yuqi Xu <xuyuqiabc@gmail.com>
References: <cover.1775056603.git.royenheart@outlook.com>
 <9c88b4b7844f867d065e7a7aba28b2c026386168.1775056603.git.royenheart@outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9c88b4b7844f867d065e7a7aba28b2c026386168.1775056603.git.royenheart@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ti.com,ee.vjti.ac.in,linutronix.de,gmail.com,lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275903-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 10EDD3AB761
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 4:18 PM, Ao Zhou wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> PRP slave ports accept ordinary SAN traffic and forward it to the
> master device without needing a persistent node entry. Creating one
> node per previously unseen SAN source lets arbitrary source MAC floods
> grow node_db until the prune timer catches up.
> 
> Keep the receive path for ordinary PRP SAN traffic, but stop learning a
> new node when the frame is untagged and does not carry a PRP trailer.
> Continue to deliver the frame locally and only keep node state for
> actual HSR/PRP senders or nodes that have already been learned.

It's not clear to me what prevents the rouge sender from always
including a valid PRP trailer, thus still causing the issue addressed
here. Some rationale needs to be included, or possibly limit the amount
of newly created nodes to some configurable maximum.

> Fixes: 451d8123f897 ("net: prp: add packet handling support")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> ---
>  net/hsr/hsr_forward.c  | 14 ++++++++++----
>  net/hsr/hsr_framereg.c | 16 +++++++++++++---
>  2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index aefc9b6936ba..5fbfc42997d2 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -403,7 +403,8 @@ static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
>  	int res, recv_len;
>  
>  	was_multicast_frame = (skb->pkt_type == PACKET_MULTICAST);
> -	hsr_addr_subst_source(node_src, skb);
> +	if (node_src)
> +		hsr_addr_subst_source(node_src, skb);
>  	skb_pull(skb, ETH_HLEN);
>  	recv_len = skb->len;
>  	res = netif_rx(skb);
> @@ -699,8 +700,12 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  
>  	frame->node_src = hsr_get_node(port, n_db, skb,
>  				       frame->is_supervision, port->type);
> -	if (!frame->node_src)
> -		return -1; /* Unknown node and !is_supervision, or no mem */
> +	if (IS_ERR(frame->node_src)) {
> +		ret = PTR_ERR(frame->node_src);
> +		if (ret != -ENOENT)
> +			return ret;
> +		frame->node_src = NULL;
> +	}
>  
>  	ethhdr = (struct ethhdr *)skb_mac_header(skb);
>  	frame->is_vlan = false;
> @@ -739,7 +744,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
>  	if (fill_frame_info(&frame, skb, port) < 0)
>  		goto out_drop;
>  
> -	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
> +	if (frame.node_src)
> +		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
>  	hsr_forward_do(&frame);

I *think* the hsr_forward_do() could unconditionally dereference
node_src in:

hsr->proto_ops->register_frame_out -> {prp,hsr}_register_frame_out ->
hsr_check_duplicate:

	node = frame->node_src;	
	if (WARN_ON_ONCE(port_type >= node->seq_port_cnt))
	
/P


