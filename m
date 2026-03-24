Return-Path: <netdev+bounces-271134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMx/BzewwmmRkwQAu9opvQ
	(envelope-from <netdev+bounces-271134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:39:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC0318360
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5BBC307A9D6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D79397E98;
	Tue, 24 Mar 2026 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjVdc/Jj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7E3921E9
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366436; cv=none; b=RxG0uA1KLltWK7XcZYw02cSdxweKZO7prKDc8besXQYGmSgeLD7U6NzX549xYQwL8VaRlsNaELDFUEL9Z3WnmnJo6IWTEQ9XgyFJlthqaCXKiuGlb4mKwbZhJCzEAldcC/oDYGyPB0GM4nMtHMen80lDs8JtzqQULwjdLCqIErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366436; c=relaxed/simple;
	bh=kfjm5yZGiCfEtrhK2jWybCcIIFl5EeW2xNwPyeDQtzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k9C/jy4Ful0uOrVBGL5GzguiP+RH5ymE6xe/wl0hdCDNSPa1b+p2+Ui8eP3WucEaJyQT7oAkp2y+4RzKj6JZUYg2qhjNEegMwtVcKNsNNjegds8e5RHGjfLsS1egjLQH9GAoRq5xO/2TdWADPIBgx1ruIlEMCxvZJjS14Y28Kp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjVdc/Jj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774366431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2IIGMuAO+ucZPfz1QK9xPIoH0lITs2rYPhG8mHOgNI=;
	b=ZjVdc/Jj08qP3GIW2Bo2AFHY++vSe0MdTfIdjxpmHgSOCaTRKMucbD86Pkqska0wZ8Tghf
	InAW9wEBjDTRi7LHUe5I4sf07zTH5KIqcbdkSF169eo0rS0CSK6tVfcCsO/s5C5kSLRTM9
	yKRbc5I4d17zuqFkG4c/1j2cRIAKJ0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-pBWjeCHiMBykKOn1hjiBag-1; Tue,
 24 Mar 2026 11:33:46 -0400
X-MC-Unique: pBWjeCHiMBykKOn1hjiBag-1
X-Mimecast-MFC-AGG-ID: pBWjeCHiMBykKOn1hjiBag_1774366414
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78E541800372;
	Tue, 24 Mar 2026 15:33:33 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.17.17.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EADC19560B1;
	Tue, 24 Mar 2026 15:33:29 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,  Peter Zijlstra
 <peterz@infradead.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,  Eelco
 Chaudron <echaudro@redhat.com>,  Ilya Maximets <i.maximets@ovn.org>,
  Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,  Xin Long
 <lucien.xin@gmail.com>,  Jon Maloy <jmaloy@redhat.com>,  Willem de Bruijn
 <willemb@google.com>,  Samiullah Khawaja <skhawaja@google.com>,  Hangbin
 Liu <liuhangbin@gmail.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  dev@openvswitch.org,  linux-sctp@vger.kernel.org,
  tipc-discussion@lists.sourceforge.net,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] net: Use trace_call__##name() at guarded
 tracepoint call sites
In-Reply-To: <20260323160052.17528-5-vineeth@bitbyteword.org> (Vineeth
	Pillai's message of "Mon, 23 Mar 2026 12:00:23 -0400")
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
	<20260323160052.17528-5-vineeth@bitbyteword.org>
Date: Tue, 24 Mar 2026 11:33:28 -0400
Message-ID: <f7ttsu58con.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[goodmis.org,infradead.org,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,ovn.org,vger.kernel.org,openvswitch.org,lists.sourceforge.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271134-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Queue-Id: 95CC0318360
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"Vineeth Pillai (Google)" <vineeth@bitbyteword.org> writes:

> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6
> ---

As noted before, I think we can just eliminate the guard in the
openvswitch module (and that would probably be a more understandable
fix) rather than replacing the call-in.

>  net/core/dev.c             | 2 +-
>  net/core/xdp.c             | 2 +-
>  net/openvswitch/actions.c  | 2 +-
>  net/openvswitch/datapath.c | 2 +-
>  net/sctp/outqueue.c        | 2 +-
>  net/tipc/node.c            | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 14a83f2035b93..f7602b1892fea 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *head)
>  		return;
>  	if (trace_netif_receive_skb_list_entry_enabled()) {
>  		list_for_each_entry(skb, head, list)
> -			trace_netif_receive_skb_list_entry(skb);
> +			trace_call__netif_receive_skb_list_entry(skb);
>  	}
>  	netif_receive_skb_list_internal(head);
>  	trace_netif_receive_skb_list_exit(0);
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba7..3003e5c574191 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
>  		xsk_pool_set_rxq_info(allocator, xdp_rxq);
>  
>  	if (trace_mem_connect_enabled() && xdp_alloc)
> -		trace_mem_connect(xdp_alloc, xdp_rxq);
> +		trace_call__mem_connect(xdp_alloc, xdp_rxq);
>  	return 0;
>  }
>  
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 792ca44a461da..60823de201417 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  		int err = 0;
>  
>  		if (trace_ovs_do_execute_action_enabled())
> -			trace_ovs_do_execute_action(dp, skb, key, a, rem);
> +			trace_call__ovs_do_execute_action(dp, skb, key, a, rem);
>  
>  		/* Actions that rightfully have to consume the skb should do it
>  		 * and return directly.
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index e209099218b41..2b9755e2e4731 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_buff *skb,
>  	int err;
>  
>  	if (trace_ovs_dp_upcall_enabled())
> -		trace_ovs_dp_upcall(dp, skb, key, upcall_info);
> +		trace_call__ovs_dp_upcall(dp, skb, key, upcall_info);
>  
>  	if (upcall_info->portid == 0) {
>  		err = -ENOTCONN;
> diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
> index f6b8c13dafa4a..4025d863ffc84 100644
> --- a/net/sctp/outqueue.c
> +++ b/net/sctp/outqueue.c
> @@ -1267,7 +1267,7 @@ int sctp_outq_sack(struct sctp_outq *q, struct sctp_chunk *chunk)
>  	/* SCTP path tracepoint for congestion control debugging. */
>  	if (trace_sctp_probe_path_enabled()) {
>  		list_for_each_entry(transport, transport_list, transports)
> -			trace_sctp_probe_path(transport, asoc);
> +			trace_call__sctp_probe_path(transport, asoc);
>  	}
>  
>  	sack_ctsn = ntohl(sack->cum_tsn_ack);
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index af442a5ef8f3d..5745d6aa0a054 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -1943,7 +1943,7 @@ static bool tipc_node_check_state(struct tipc_node *n, struct sk_buff *skb,
>  
>  	if (trace_tipc_node_check_state_enabled()) {
>  		trace_tipc_skb_dump(skb, false, "skb for node state check");
> -		trace_tipc_node_check_state(n, true, " ");
> +		trace_call__tipc_node_check_state(n, true, " ");
>  	}
>  	l = n->links[bearer_id].link;
>  	if (!l)


