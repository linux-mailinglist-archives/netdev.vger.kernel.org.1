Return-Path: <netdev+bounces-24455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E139A770392
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5401C21738
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80EFCA43;
	Fri,  4 Aug 2023 14:51:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC57BA3B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988B0C433C8;
	Fri,  4 Aug 2023 14:51:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qi9Z/5EM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1691160680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CNx4B7jKqdun6rWxJGZZ3MFbO2HnBObuNpFaYMyH6rw=;
	b=Qi9Z/5EM+Lumf6OMor2kibjJ+bTlAgvoGY4rdz70u2FBWWReA8Sl7MIiwpLM4+Jn14OGdf
	1fDRLwp/AMXrtACsLdiH+fSFyLqS1c0mmre4rogaeh9DOf5TCpineVwe7dlYTc08zjisnu
	eCacgjn7umwuXaX+3wyRvpL/8RbZHr0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 707e327c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Aug 2023 14:51:20 +0000 (UTC)
Date: Fri, 4 Aug 2023 16:50:05 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Subject: Re: [PATCH net-next] net/tcp: refactor tcp_inet6_sk()
Message-ID: <ZM0QHZNKLQ9kVlJ8@zx2c4.com>
References: <16be6307909b25852744a67b2caf570efbb83c7f.1684502478.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16be6307909b25852744a67b2caf570efbb83c7f.1684502478.git.asml.silence@gmail.com>

Hi Pavel,

On Fri, May 19, 2023 at 02:30:36PM +0100, Pavel Begunkov wrote:
> Don't keep hand coded offset caluclations and replace it with
> container_of(). It should be type safer and a bit less confusing.
> 
> It also makes it with a macro instead of inline function to preserve
> constness, which was previously casted out like in case of
> tcp_v6_send_synack().
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  net/ipv6/tcp_ipv6.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 7132eb213a7a..d657713d1c71 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -93,12 +93,8 @@ static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(const struct sock *sk,
>   * This avoids a dereference and allow compiler optimizations.
>   * It is a specialized version of inet6_sk_generic().
>   */
> -static struct ipv6_pinfo *tcp_inet6_sk(const struct sock *sk)
> -{
> -	unsigned int offset = sizeof(struct tcp6_sock) - sizeof(struct ipv6_pinfo);
> -
> -	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
> -}
> +#define tcp_inet6_sk(sk) (&container_of_const(tcp_sk(sk), \
> +					      struct tcp6_sock, tcp)->inet6)
>  
>  static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
>  {
> @@ -533,7 +529,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
>  			      struct sk_buff *syn_skb)
>  {
>  	struct inet_request_sock *ireq = inet_rsk(req);
> -	struct ipv6_pinfo *np = tcp_inet6_sk(sk);
> +	const struct ipv6_pinfo *np = tcp_inet6_sk(sk);
>  	struct ipv6_txoptions *opt;
>  	struct flowi6 *fl6 = &fl->u.ip6;
>  	struct sk_buff *skb;
> -- 
> 2.40.0

This patch broke the WireGuard test suite on 32-bit platforms:

https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf442577ed2f2a8eb87a06f2/i686.log
https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf442577ed2f2a8eb87a06f2/arm.log
https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf442577ed2f2a8eb87a06f2/armeb.log
https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf442577ed2f2a8eb87a06f2/powerpc.log
https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf442577ed2f2a8eb87a06f2/mips.log
https://build.wireguard.com/wireguard-linux-stable/bf400e83708d055bdf442577ed2f2a8eb87a06f2/mipsel.log

The common point of failure in each of these is something like:

[+] NS1: iperf3 -s -1 -B fd00::1
[+] NS1: wait for iperf:5201 pid 115
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
[+] NS2: iperf3 -Z -t 3 -c fd00::1
[    8.908396] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[    9.955882] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   10.994917] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   12.034269] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   13.073905] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   14.114022] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   16.194810] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   19.074925] wireguard: wg0: Sending keepalive packet to peer 1 (127.0.0.1:2)
[   19.075934] wireguard: wg0: Receiving keepalive packet from peer 2 (127.0.0.1:1)
[   20.273212] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   28.682020] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   30.593430] wireguard: wg0: Sending keepalive packet to peer 1 (127.0.0.1:2)
[   30.595999] wireguard: wg0: Receiving keepalive packet from peer 2 (127.0.0.1:1)
[   45.315640] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   55.560359] wireguard: wg0: Sending keepalive packet to peer 1 (127.0.0.1:2)
[   55.561675] wireguard: wg0: Receiving keepalive packet from peer 2 (127.0.0.1:1)
[   77.961218] wireguard: wg0: Packet has unallowed src IP (::2:0:0) from peer 1 (127.0.0.1:2)
[   88.200150] wireguard: wg0: Sending keepalive packet to peer 1 (127.0.0.1:2)
[   88.201031] wireguard: wg0: Receiving keepalive packet from peer 2 (127.0.0.1:1)
iperf3: error - unable to connect to server: Operation timed out

For some strange reason, the packets appear to have a src IP of
"::2:0:0" instead of fd00::2. It looks like some kind of offset issue, I
suppose. So you may want to revert this or reevaluate the calculation of
`offset` here, as there's something screwy happening on 32-bit systems.

Jason

