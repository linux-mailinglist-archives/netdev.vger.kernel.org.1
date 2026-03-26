Return-Path: <netdev+bounces-272094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDUxCvtGxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:47:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA1E336FF3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F319B30ADA7B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D840148E;
	Thu, 26 Mar 2026 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuTWC7cJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240C3FB04F
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535351; cv=none; b=fCAKxFLejUeAMTau6hidzq/qYvZp9MgWB2wfmJA3uBHvWziaSPerC6JbQKwrv0xbFzd+NyP44tKPHn6qbVTl5xUvuuEexMGJoo16//Z1vVwIeRTo4OB29c/6+FluwS2kTqFPoFicVgISQ2E/5c62bWViDFqGFKIQJvgC7FD9gak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535351; c=relaxed/simple;
	bh=TWMDHjK43CZBkCdui/jDDwj8ypdONgcYUQvBswkauIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfZI5tFpCtQgMc/IgD7ugW4Y/b59eOqDDjDpZ+PENMUVZwmdXeI3TFi6Xq/9j55DmnErJaSBL3i00m18b5Mgqv9+xrDSD/s4c/4NkALJrnf24wV0Lb2MpaJGhjBOjzG9LuuUT8ZcTwyO3fussGxqU5/TcFKOM14ncQr2Yxir5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WuTWC7cJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774535349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oqjdQvImZ07aDEMTzYz+Yaz9Uc4/vZT8kN4P2JGyxf8=;
	b=WuTWC7cJlDeNf0NnY+rFKiYm6me2CLAiLGx5VoEmSdBGui44NpA1/zCUn3xaUW/YWJWMU6
	+TeOpu13LuVJhk45guNtaygXBVAKJTwvxqw0yzoyhS8X5rmX1CZJv+Lq4BKN9dhRyy/q9y
	AWwgemdxSRhaIbhi0QimqTh2lNJNIEQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-7WbmrYqgNzadJVaqmBDayg-1; Thu,
 26 Mar 2026 10:29:02 -0400
X-MC-Unique: 7WbmrYqgNzadJVaqmBDayg-1
X-Mimecast-MFC-AGG-ID: 7WbmrYqgNzadJVaqmBDayg_1774535340
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79BAC18CD298;
	Thu, 26 Mar 2026 14:28:53 +0000 (UTC)
Received: from thinkpad (dhcp-64-111.muc.redhat.com [10.32.64.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C7321955E9E;
	Thu, 26 Mar 2026 14:28:50 +0000 (UTC)
Date: Thu, 26 Mar 2026 15:28:47 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	liuhangbin@gmail.com, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/4] net: hsr: serialize seq_blocks merge
 across nodes
Message-ID: <acVCn6DmcFPOoWkR@thinkpad>
References: <20260324143503.187642-1-luka.gejak@linux.dev>
 <20260324143503.187642-2-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324143503.187642-2-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-272094-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 8FA1E336FF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:35:00PM +0100, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> During node merging, hsr_handle_sup_frame() walks node_curr->seq_blocks
> to update node_real without holding node_curr->seq_out_lock. This
> allows concurrent mutations from duplicate registration paths, risking
> inconsistent state or XArray/bitmap corruption.

I'm not sure if I see "duplicate registration" happening (without a more
serious problem in the network).

> Fix this by locking both nodes' seq_out_lock during the merge.
> To prevent ABBA deadlocks, locks are acquired in order of memory
> address.

But I agree that this is probably a good idea, as long as the node with
wrong macaddressA is still in the node table and might still see updates
in the sequence number tracking because we can still receive traffic for
it. I originally didn't consider this to be too bad, but if a block is
reused we could be dropping some valid packets.

Reviewed-by: Felix Maurer <fmaurer@redhat.com>

> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  net/hsr/hsr_framereg.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index 577fb588bc2f..d09875b33588 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -123,6 +123,40 @@ static void hsr_free_node_rcu(struct rcu_head *rn)
>  	hsr_free_node(node);
>  }
>
> +static void hsr_lock_seq_out_pair(struct hsr_node *node_a,
> +				  struct hsr_node *node_b)
> +{
> +	if (node_a == node_b) {
> +		spin_lock_bh(&node_a->seq_out_lock);
> +		return;
> +	}
> +
> +	if (node_a < node_b) {
> +		spin_lock_bh(&node_a->seq_out_lock);
> +		spin_lock_nested(&node_b->seq_out_lock, SINGLE_DEPTH_NESTING);
> +	} else {
> +		spin_lock_bh(&node_b->seq_out_lock);
> +		spin_lock_nested(&node_a->seq_out_lock, SINGLE_DEPTH_NESTING);
> +	}
> +}
> +
> +static void hsr_unlock_seq_out_pair(struct hsr_node *node_a,
> +				    struct hsr_node *node_b)
> +{
> +	if (node_a == node_b) {
> +		spin_unlock_bh(&node_a->seq_out_lock);
> +		return;
> +	}
> +
> +	if (node_a < node_b) {
> +		spin_unlock(&node_b->seq_out_lock);
> +		spin_unlock_bh(&node_a->seq_out_lock);
> +	} else {
> +		spin_unlock(&node_a->seq_out_lock);
> +		spin_unlock_bh(&node_b->seq_out_lock);
> +	}
> +}
> +
>  void hsr_del_nodes(struct list_head *node_db)
>  {
>  	struct hsr_node *node;
> @@ -432,7 +466,7 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
>  	}
>
>  	ether_addr_copy(node_real->macaddress_B, ethhdr->h_source);
> -	spin_lock_bh(&node_real->seq_out_lock);
> +	hsr_lock_seq_out_pair(node_real, node_curr);
>  	for (i = 0; i < HSR_PT_PORTS; i++) {
>  		if (!node_curr->time_in_stale[i] &&
>  		    time_after(node_curr->time_in[i], node_real->time_in[i])) {
> @@ -455,7 +489,7 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
>  				  src_blk->seq_nrs[i], HSR_SEQ_BLOCK_SIZE);
>  		}
>  	}
> -	spin_unlock_bh(&node_real->seq_out_lock);
> +	hsr_unlock_seq_out_pair(node_real, node_curr);
>  	node_real->addr_B_port = port_rcv->type;
>
>  	spin_lock_bh(&hsr->list_lock);
> --
> 2.53.0
>


