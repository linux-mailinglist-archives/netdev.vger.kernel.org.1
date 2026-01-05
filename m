Return-Path: <netdev+bounces-247169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C91CF52EF
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C38A3009680
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6DD321434;
	Mon,  5 Jan 2026 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcI2THXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED729E110
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636795; cv=none; b=EI0/mGQBO4p6qKv9DNLrS2AUK3Xt5nj0PxRXKcG/wg7L6aJpw6B8HbQSSlIMxS+jk0CLu2asu0gWwOdI6PhRdf6mkoGQ988iMi3xei7o/PgrIyKDoHLQWXeW2ld7U+G3m6o/ZkaQsw3N8L3GcVVx1IoSMe54J4T6Or3ZR/ip5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636795; c=relaxed/simple;
	bh=AxsNtW7F2bFULsfvzoCdSkWwUqf03UkhpL1ZuvUARS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpVSgjs6TgrkGpTS6lAE23zgWJVGDZ3uuXqicflcjQ2j+u9QBK+S8RjQW43+Qu14BiHAs9EE4S0TALheFgYiZcqO/w/lAXgaSA4i1MsvEnLdr037sPV/QLFdOg3bDGV4CWw0JSJnsLjqI27dRFSCMp9oHt6BiRlliEFY/OdN/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcI2THXL; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a35a00506so1770836d6.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767636793; x=1768241593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVQVt6gSgy+Mn6U5bd+n6K1V0swCxotuYlZNDyyC5QY=;
        b=QcI2THXLM5Jau8rKFQhWbsayXMJTla0JjFXo/IFCZ+wJaoYWvC+hH6Oe/dLYlg02H2
         oOdFS0+Tj2WPwQ/sZRTBcT0H5DKXiZMMabT4a7Vd1PV2TnOPLq4kbNSmu3l3+r0VhW0L
         7omvb3nRT2fxkLSRpEc6ixg95waowX0uL185SGlNhfUTvyaucTepjcNu+iHw6CqPfsq9
         qM3oVRZtHRfrp/7ZTTfmgun4DRydGzMaaf7MI5XbZp6JzBY3bSNWa/heUjz5TpV3VJep
         GRZbXufp1zPVLRgvPQ6TLIHNhTdRmBuZLd7IPO37IHC7XO/KqwDESf00aVHxe8v+908m
         /ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636793; x=1768241593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cVQVt6gSgy+Mn6U5bd+n6K1V0swCxotuYlZNDyyC5QY=;
        b=v74ORNMIWyGYAWeK1/WxgfupNchiuTlxKp3NJcXGSkQyIUJamsMnzxl9M5R66gzAbJ
         yvGvZIDttc6QOdE/3HfhNfyh8t12qBMWYIWrGREM7lfI+2Sjdzf1mXTj0LfnE2+hIqIa
         /9y4XNscQ73w9bG/Oc3MIt6//jhhDi8aozhpzduAd7qyFTnLZ+8n5hzz8Kp0B2kaEdWc
         yMxol/06Ixf20Usm8yCwp6FblCVwQq7BVPg4Z9shT83p7tNr2QfzFfj6gtDXJSg/EVTj
         HYb8BTwQMoXRrRkdJZcasZNPbULMl1zg5q/WAmMyKd3E8YzrdQCOWV/UUXpXfNfUDRaX
         npgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxZ+WQU+bHKICUoFB9bIZQ981NFmbtkV/xNmBiKqOTX+fe7HRFyb4cXf0oyZijQVbTcN2hb7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13qseWu8xZL459+BDYUtmamnAQn7ruly5uAtna5x6Eo9trU++
	I79QwXdgmmxcHtIxb/JMXhMwhTn6MUMqHDIGWYuLtf5RoPN4cQhdwdzxAPwpg9jwVpsdm+4HJlS
	QDZ5I0ZsOFxF2Zu+vA44ahbzMm18qzvjSdpATPjwY
X-Gm-Gg: AY/fxX5Iirx2WiLlikpMJWYVK8Fbxk++0eSLFC/X499tyjjXzBTdhZy4Ma4nFRrxtZR
	fq5tZFbLJUPs+J+aL25JlNo3trEwhHg7i7ZVY9LxfbjbdXSdV1dEg6+qUk74RiXGccqBO8/SZi+
	mTyneSISORcJuO/i3LoEPQ/57r0KhcLH/KwwjihrX5N0gyxIoXEIleTF4to+DeFmEgEga9hSN0d
	XBXXPvGrjqrOTJ52/lwbj5pW/NpJbGGPGiRLD/L/g2MwyD5OubGpRxyb38egSyky2K5jH5A
X-Google-Smtp-Source: AGHT+IFU4D9IUPpGO3djQTNdrDxJzdR4bRgx7H1Ci/Nj5vabK00V6Gq4wgWg6VZCAQQDo0wtcIvGBKvjiOMQvX+nSLw=
X-Received: by 2002:a05:6214:246f:b0:889:7c5b:8134 with SMTP id
 6a1803df08f44-89075e2a974mr7465266d6.27.1767636792454; Mon, 05 Jan 2026
 10:13:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105175254.2708866-1-fangwu.lcc@antgroup.com>
In-Reply-To: <20260105175254.2708866-1-fangwu.lcc@antgroup.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Jan 2026 19:13:01 +0100
X-Gm-Features: AQt7F2qJqiElSpacw9AGzXU6JMiQSC_ZhSUC0fVz1SuZF4NfyOrVY3QFG0LEMDU
Message-ID: <CANn89i+A1FDBt70NG_VDExQTp5fzJpVMSAwngdbv-dwRPPfCqQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix error handling of tcp_retransmit_skb
To: =?UTF-8?B?5YiY6IGq6IGqKOaWueWLvyk=?= <fangwu.lcc@antgroup.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, kuniyu@google.com, dsahern@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:53=E2=80=AFPM =E5=88=98=E8=81=AA=E8=81=AA(=E6=96=
=B9=E5=8B=BF) <fangwu.lcc@antgroup.com> wrote:
>
> The tcp_retransmit_timer() function checks if tcp_retransmit_skb()
> returns a value greater than 0, but tcp_retransmit_skb() returns
> 0 on success and negative error codes on failure.

This seems like a bogus claim to me.

tcp_retransmit_skb() can and should return >0 in some cases.

Time to provide a packetdrill test I guess.

   0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>

 +.02 < . 1:1(0) ack 1 win 257
   +0 accept(3, ..., ...) =3D 4
   // Set a 5s timeout
   +0 setsockopt(4, SOL_TCP, TCP_USER_TIMEOUT, [5000], 4) =3D 0
   +0 write(4, ..., 11000) =3D 11000
   +0 > P. 1:10001(10000) ack 1

// TLP
 +.04~+.05 > P. 10001:11001(1000) ack 1
   +0 %{ assert tcpi_retransmits =3D=3D 0, tcpi_retransmits;\
         assert tcpi_backoff     =3D=3D 0, tcpi_backoff }%

   // Emulate a congestion  - no packets can get out for 3 seconds
   // Check that we retry every 500ms (6 rounds) w/o backoff
   +0 `tc qdisc replace dev tun0 root pfifo limit 0`
   +3 %{ assert tcpi_retransmits =3D=3D 6, tcpi_retransmits;\
         assert tcpi_backoff     =3D=3D 0, tcpi_backoff }%

   // Congestion is now relieved - the next retry should show up some time
   // Hopefully qdisc in the future can inform TCP right away to retry.
   +0 `tc qdisc replace dev tun0 root pfifo limit 1000`
 +.21~+.26 > . 1:1001(1000) ack 1
 +.02 < . 1:1(0) ack 1001 win 257
   +0 > . 1001:3001(2000) ack 1
   // Test the recurring timeout counter is reset. The backoff counter
   // remains one until a new RTT sample is acquired. We do not get a new
   // RTT sample b/c the ACK acks a rtx w/o TS options
   +0 %{ assert tcpi_retransmits =3D=3D 0, tcpi_retransmits;\
         assert tcpi_backoff     =3D=3D 1, tcpi_backoff }%

   // Emulate a longer local congestion - the next ACK should trigger
   // more transmission but none can succeed.
   +0 `tc qdisc replace dev tun0 root pfifo limit 0`
   +.02 < . 1:1(0) ack 3001 win 257

   // Socket has timed out after +5s of lack of progress as specified above
   +5.1 write(4, ..., 100) =3D -1 (ETIMEDOUT)


> This means the
> error handling branch is never executed when retransmission fails.
>
> Fix this by changing the condition to check for !=3D 0 instead of > 0.
>
> Signed-off-by: Liu Congcong <fangwu.lcc@antgroup.com>
> ---
>  net/ipv4/tcp_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 160080c9021d..4fbb387e7e7b 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -624,7 +624,7 @@ void tcp_retransmit_timer(struct sock *sk)
>         tcp_enter_loss(sk);
>
>         tcp_update_rto_stats(sk);
> -       if (tcp_retransmit_skb(sk, tcp_rtx_queue_head(sk), 1) > 0) {
> +       if (tcp_retransmit_skb(sk, tcp_rtx_queue_head(sk), 1)) {
>                 /* Retransmission failed because of local congestion,
>                  * Let senders fight for local resources conservatively.
>                  */
> --
> 2.17.0
>

