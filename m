Return-Path: <netdev+bounces-93250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B158BABB3
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 13:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5214C283AE3
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D0152535;
	Fri,  3 May 2024 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="aL242Nno"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59BCC2E9
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736183; cv=none; b=r7TQVIBwp82DaPl7WD2dZXwut/l7/yh1dV2vpFj9TFVn+2K3UyTK0964KZzJ5wQKBDYTpwl6FXBb19rRtk5tSwjGdYHyY/BaHttXP+EN3WBwaFNnEF9DgToRjXNu0xHz5wRwBgAppI//4KUfMOD1vy7g0PRlgBcr1/MVEOyvbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736183; c=relaxed/simple;
	bh=QIzZPTSqoyoSUu2mc2IX8mGO+0q4QX5mx2657041zaw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=eQ0Up5NdJZC41Jvt4Fv3Lik3r9vGcot/nJRVy7xpdi2YvmQwA313LnqQ4EtsmAMJMbXXNhF0oY+tYVhfkSJYC8GovP3PKhCbP6dNuXe2U/hofC2c5+xpUTKUXo/DnGlR06k9Y4UIojG8YI+gesxQP+YVIC0mdX3t0PjSsKdq4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=aL242Nno; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:f8c1:ac3:4d22:e947] (unknown [IPv6:2a02:8010:6359:2:f8c1:ac3:4d22:e947])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id C06347D8BA;
	Fri,  3 May 2024 12:36:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1714736174; bh=QIzZPTSqoyoSUu2mc2IX8mGO+0q4QX5mx2657041zaw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<ea4ddddc-719c-673e-7646-8f89cd341e7b@katalix.com>|
	 Date:=20Fri,=203=20May=202024=2012:36:14=20+0100|MIME-Version:=201
	 .0|To:=20Samuel=20Thibault=20<samuel.thibault@ens-lyon.org>,=0D=0A
	 =20Tom=20Parkin=20<tparkin@katalix.com>,=20Eric=20Dumazet=20<eduma
	 zet@google.com>,=0D=0A=20Jakub=20Kicinski=20<kuba@kernel.org>,=20P
	 aolo=20Abeni=20<pabeni@redhat.com>|Cc:=20netdev@vger.kernel.org|Re
	 ferences:=20<20240502231418.2933925-1-samuel.thibault@ens-lyon.org
	 >|From:=20James=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=
	 20[PATCH]=20l2tp:=20Support=20several=20sockets=20with=20same=20IP
	 /port=20quadruple|In-Reply-To:=20<20240502231418.2933925-1-samuel.
	 thibault@ens-lyon.org>;
	b=aL242Nno0V0j0aK2xvNnJnxk5NADTpZkZMhjlAbeLdZBFPHyYNHy4SrnSeLqMlJng
	 aXD9Hd770ao7srDMjcAVNthME1Mhqhlj6yvKCfn8FsvfVmC/c+lB9CAc8ksjw00QDL
	 s4AwAfspRaM2YjAzGGzXyOJqO1QGVjqmytfpRspD8m5U9r9PeEFERYbLJXSafand+h
	 nZ1DfY31HDgw6zzLcGkBYfuhtH5FsUm3QCKPHpS30SMTDPLscehj1NpnNEER033ykb
	 MnwFMVP0e8HrsIaRlbP56Fa8aQEsrg7rSwZePymTkT63V4lAMhZnnIqPGF4Vf6BEzU
	 fcFe7pFJ8e18Q==
Message-ID: <ea4ddddc-719c-673e-7646-8f89cd341e7b@katalix.com>
Date: Fri, 3 May 2024 12:36:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Tom Parkin <tparkin@katalix.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
References: <20240502231418.2933925-1-samuel.thibault@ens-lyon.org>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH] l2tp: Support several sockets with same IP/port quadruple
In-Reply-To: <20240502231418.2933925-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/05/2024 00:14, Samuel Thibault wrote:
> Some l2tp providers will use 1701 as origin port and open several
> tunnels for the same origin and target. On the Linux side, this
> may mean opening several sockets, but then trafic will go to only
> one of them, losing the trafic for the tunnel of the other socket
> (or leaving it up to userland, consuming a lot of cpu%).
>
> This can also happen when the l2tp provider uses a cluster, and
> load-balancing happens to migrate from one origin IP to another one,
> for which a socket was already established. Managing reassigning
> tunnels from one socket to another would be very hairy for userland.
>
> Lastly, as documented in l2tpconfig(1), as client it may be necessary
> to use 1701 as origin port for odd firewalls reasons, which could
> prevent from establishing several tunnels to a l2tp server, for the
> same reason: trafic would get only on one of the two sockets.
>
> With the V2 protocol it is however easy to route trafic to the proper
> tunnel, by looking up the tunnel number in the network namespace. This
> fixes the three cases altogether.

Hi Samuel,

Thanks for working on this.

I'm currently working on changes that address this for both L2TPv2 and 
L2TPv3 which will avoid separate tunnel and session lookups in the 
datapath. However, my changes aren't ready yet; I hope to post them in a 
week or so.

Please find comments on your patch inline below.

> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>   net/l2tp/l2tp_core.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 8d21ff25f160..128f1146c135 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -794,6 +794,7 @@ static void l2tp_session_queue_purge(struct l2tp_session *session)
>   static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
>   {
>   	struct l2tp_session *session = NULL;
> +	struct l2tp_tunnel *orig_tunnel = tunnel;
>   	unsigned char *ptr, *optr;
>   	u16 hdrflags;
>   	u32 tunnel_id, session_id;
> @@ -845,6 +846,20 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
>   		/* Extract tunnel and session ID */
>   		tunnel_id = ntohs(*(__be16 *)ptr);
>   		ptr += 2;
> +
> +		if (tunnel_id != tunnel->tunnel_id && tunnel->l2tp_net) {
Can tunnel->l2tp_net be NULL?
> +			/* We are receiving trafic for another tunnel, probably
> +			 * because we have several tunnels between the same
> +			 * IP/port quadruple, look it up.
> +			 */
> +			struct l2tp_tunnel *alt_tunnel;
> +
> +			alt_tunnel = l2tp_tunnel_get(tunnel->l2tp_net, tunnel_id);
This misses a check that alt_tunnel's protocol version matches the 
header. Move the existing header version check to after this fragment?
> +			if (!alt_tunnel)
> +				goto pass;
> +			tunnel = alt_tunnel;
> +		}
> +
>   		session_id = ntohs(*(__be16 *)ptr);
>   		ptr += 2;
>   	} else {
> @@ -875,6 +890,9 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
>   	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length);
>   	l2tp_session_dec_refcount(session);
>   
> +	if (tunnel != orig_tunnel)
> +		l2tp_tunnel_dec_refcount(tunnel);
> +
>   	return 0;
>   
>   invalid:
> @@ -884,6 +902,9 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
>   	/* Put UDP header back */
>   	__skb_push(skb, sizeof(struct udphdr));
>   
> +	if (tunnel != orig_tunnel)
> +		l2tp_tunnel_dec_refcount(tunnel);
> +
>   	return 1;
>   }
>   


