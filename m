Return-Path: <netdev+bounces-276439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM/+JFYy1mlZBwgAu9opvQ
	(envelope-from <netdev+bounces-276439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:47:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 146953BAE76
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5563231137C8
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB253B9DA8;
	Wed,  8 Apr 2026 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn5EGrg0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4483BB9F4
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644833; cv=none; b=GYniX+7TySCSDgbr3V/fS7e96GjDMG2KXwBbCAAu+FVIr9yt5Fg0WagYGXzZMoNb4egoTQqLO2vkYMfWivzWUDY17GhPrIwLF/6G9OCNZMubqbQ1U9tSX06RbBGrG9P1i/srpnSBrN/LTN2iLtgouj4XLx5+v13UNCWMJpklBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644833; c=relaxed/simple;
	bh=i8oa7nHtep9/cYT9xh7ivINGzJMGErjtu/4dPDsGG/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kulCw2Onh38HlnJzh5kxa0QwusU025jTbe/eTCnPnBXGstIMkYxXRekQb5K8xnaGX+iZakuUD9eQjKt1QccXXw6tuQKOFjnOf6mtE+1l6QqwJsUdGwNKVE8Tz5dLoKPrglf/kMJ3KWqzfL+U1LQ/llgdDbayTJzWacedeqdrCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn5EGrg0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775644830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ovq55xd1F5RaYA9qv9u/tPBbr7wYAvZIgWnEYMtnN1g=;
	b=Nn5EGrg0C7e3tcnbCrrpOb6jvW5HaBF0GFyfkRCMITx1boccvvKLFGQNa7rMIogZ2WEYar
	9+UjRWNduKyELwuvh2ZM55k35qJUePkQXmtJ09KmAeZsbFYAzq9Wj5XxofBDcvwljZyKKK
	4QJj2cMLcfHXxvbRR/v6+5HAUTexhrw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-PELxzbp1O2WELvyepaLcNw-1; Wed,
 08 Apr 2026 06:40:26 -0400
X-MC-Unique: PELxzbp1O2WELvyepaLcNw-1
X-Mimecast-MFC-AGG-ID: PELxzbp1O2WELvyepaLcNw_1775644824
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74314180028B;
	Wed,  8 Apr 2026 10:40:23 +0000 (UTC)
Received: from thinkpad (unknown [10.44.33.70])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9644B195394A;
	Wed,  8 Apr 2026 10:40:17 +0000 (UTC)
Date: Wed, 8 Apr 2026 12:40:15 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Ao Zhou <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
	Yuqi Xu <xuyuqiabc@gmail.com>, Haoze Xie <royenheart@gmail.com>
Subject: Re: [PATCH net v2 1/1] net: hsr: avoid learning unknown senders for
 local delivery
Message-ID: <adYwjxLBBaLY52Wb@thinkpad>
References: <cover.1775056603.git.royenheart@outlook.com>
 <b053e938014c9bac22f7f687ecc2970f23a2b74a.1775281843.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b053e938014c9bac22f7f687ecc2970f23a2b74a.1775281843.git.royenheart@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276439-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,davemloft.net,google.com,kernel.org,redhat.com,ti.com,ee.vjti.ac.in,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 146953BAE76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 07:30:47PM +0800, Ao Zhou wrote:
> From: Haoze Xie <royenheart@gmail.com>
>
> Traffic that is directly addressed to the local HSR/PRP master can be
> delivered locally without creating a persistent node entry. Learning one
> node per previously unseen source MAC lets forged sender floods grow
> node_db until the prune timer catches up.
>
> Determine whether a frame is locally exclusive before node lookup and
> skip learning for unknown senders in that case. When no node state
> exists, also skip duplicate discard checks that depend on it.
>
> This keeps locally-destined traffic reachable while avoiding node table
> growth from source-MAC floods in both the PRP SAN path and the HSR/PRP
> tagged sender paths.

I see the problem you are trying to solve here, but I don't think this
patch provides a significant improvement over the current situation.
Yes, this will disable learning of new nodes from regular traffic (and
thereby completely prevent the duplicate discard algorithm from
working). New nodes would only be learned from supervision frames. But
nothing prevents a malicious host in the network from spoofing tons of
supervision frames.

HSR and PRP are supposed to be used in pretty restricted network
environments, so the whole protocol design doesn't really expect
malicious actors in the network and doesn't provide good options to
safeguard against misuse.

IMHO, the only real way to prevent excessive resource use on our side is
to put a limit on these resources. In this case, limit the size of the
node table (bonus: make that limit configurable as Paolo suggested).

Thanks,
   Felix


> Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
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
> changes in v2:
> - generalize the fix beyond PRP SAN traffic and cover HSR/PRP tagged sender floods
> - decide whether learning is needed from local-exclusive delivery instead of protocol-specific SAN checks
> - use the normal NULL return semantics from hsr_get_node() instead of ERR_PTR-based error plumbing
> - skip duplicate-discard state checks when no node state exists
>
>  net/hsr/hsr_forward.c  | 23 +++++++++++++----------
>  net/hsr/hsr_framereg.c |  5 ++++-
>  net/hsr/hsr_framereg.h |  2 +-
>  3 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index aefc9b6936ba..15bd17b4ee17 100644
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
> @@ -545,7 +546,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		/* Don't send frame over port where it has been sent before.
>  		 * Also for SAN, this shouldn't be done.
>  		 */
> -		if (!frame->is_from_san &&
> +		if (frame->node_src && !frame->is_from_san &&
>  		    hsr->proto_ops->register_frame_out &&
>  		    hsr->proto_ops->register_frame_out(port, frame))
>  			continue;
> @@ -688,21 +689,25 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  		return -EINVAL;
>
>  	memset(frame, 0, sizeof(*frame));
> +	frame->port_rcv = port;
>  	frame->is_supervision = is_supervision_frame(port->hsr, skb);
>  	if (frame->is_supervision && hsr->redbox)
>  		frame->is_proxy_supervision =
>  			is_proxy_supervision_frame(port->hsr, skb);
>
> +	ethhdr = (struct ethhdr *)skb_mac_header(skb);
> +	check_local_dest(port->hsr, skb, frame);
> +
>  	n_db = &hsr->node_db;
>  	if (port->type == HSR_PT_INTERLINK)
>  		n_db = &hsr->proxy_node_db;
>
>  	frame->node_src = hsr_get_node(port, n_db, skb,
> -				       frame->is_supervision, port->type);
> -	if (!frame->node_src)
> -		return -1; /* Unknown node and !is_supervision, or no mem */
> +				       frame->is_supervision, port->type,
> +				       !frame->is_local_exclusive);
> +	if (!frame->node_src && !frame->is_local_exclusive)
> +		return -1;
>
> -	ethhdr = (struct ethhdr *)skb_mac_header(skb);
>  	frame->is_vlan = false;
>  	proto = ethhdr->h_proto;
>
> @@ -720,13 +725,10 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  	}
>
>  	frame->is_from_san = false;
> -	frame->port_rcv = port;
>  	ret = hsr->proto_ops->fill_frame_info(proto, skb, frame);
>  	if (ret)
>  		return ret;
>
> -	check_local_dest(port->hsr, skb, frame);
> -
>  	return 0;
>  }
>
> @@ -739,7 +741,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
>  	if (fill_frame_info(&frame, skb, port) < 0)
>  		goto out_drop;
>
> -	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
> +	if (frame.node_src)
> +		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
>  	hsr_forward_do(&frame);
>  	rcu_read_unlock();
>  	/* Gets called for ingress frames as well as egress from master port.
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index 50996f4de7f9..2bc6f8f154c2 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -221,7 +221,7 @@ void prp_update_san_info(struct hsr_node *node, bool is_sup)
>   */
>  struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
>  			      struct sk_buff *skb, bool is_sup,
> -			      enum hsr_port_type rx_port)
> +			      enum hsr_port_type rx_port, bool learn)
>  {
>  	struct hsr_priv *hsr = port->hsr;
>  	struct hsr_node *node;
> @@ -270,6 +270,9 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
>  			san = true;
>  	}
>
> +	if (!learn)
> +		return NULL;
> +
>  	return hsr_add_node(hsr, node_db, ethhdr->h_source, san, rx_port);
>  }
>
> diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
> index c65ecb925734..3d9c88e83090 100644
> --- a/net/hsr/hsr_framereg.h
> +++ b/net/hsr/hsr_framereg.h
> @@ -33,7 +33,7 @@ void hsr_del_self_node(struct hsr_priv *hsr);
>  void hsr_del_nodes(struct list_head *node_db);
>  struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
>  			      struct sk_buff *skb, bool is_sup,
> -			      enum hsr_port_type rx_port);
> +			      enum hsr_port_type rx_port, bool learn);
>  void hsr_handle_sup_frame(struct hsr_frame_info *frame);
>  bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr);
>  bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr);
> --
> 2.53.0
>


