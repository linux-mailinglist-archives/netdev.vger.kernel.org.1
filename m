Return-Path: <netdev+bounces-137308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4A9A5542
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132DD1F21745
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781CF1946DA;
	Sun, 20 Oct 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NebCeSQg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E9191F6F
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729442461; cv=none; b=jqTKz4d8evS7x5cjLA+FU+gy09j+1FRgN4eDP0e4idk1f/qen4cYi7WXhtlKqrxn3aArKw4pOsXlgk3cRRHGSkFy/Wl2YdafTiBrRIuojDip33BGmpVDMWi2ftIyyJK9R9AvEY78RGEpyReFrfNPS1FqlI30gDaWOQPgJGizUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729442461; c=relaxed/simple;
	bh=/wBg8B3REsY0emmkPoFfym2TGbVt8d5z3+1LIuoS+rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePxUJnsUxr+hENzLc1OaWklIJlhobxWPq74JKj2hl3r4ovKVl93abJnam9IQKMsnv1rCFGOOiAGA91q9En0OES2m5pSrrlwnm64vhh5Vr05g87kzZyFj/mEGoXHaGrHdUw65MdV6MqSJ9vDx13495FNJy90zU1S82yRweDT8SAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NebCeSQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D38C4CEC6;
	Sun, 20 Oct 2024 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729442460;
	bh=/wBg8B3REsY0emmkPoFfym2TGbVt8d5z3+1LIuoS+rI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NebCeSQgW7Q1Y8YLjvlkJ4sWkes4jKrT4/0ciJTlzh1CbR8O6h056htpuYLZtltwv
	 pSPmuYDeKb4fCUX9mb4AlHM7S0gAFwzn8BQ5FbQTjnOiVPlN4E+nsV1Ko1Ip3zxGEa
	 /1ANuHPHregoqt6v3Hb+EuIvOOVHgo4L5Gr/3/wxX9NrCzSF5WqBRw6VX0hbjAsQsM
	 MRQstw9wmqeuJd7h0Fuz5LiXT4s+QOJIGHyig3xUat0IXnYC0IxxYStNEnJJO1H8+h
	 4r5p0rrjbh9SOh4wiAPWHu2tliYbywHCLQ5LIEfBxWgBF8gLZkDHULxBIIdY/6Jxj+
	 hcK30XYgv+Wsg==
Message-ID: <65575e53-c5b8-47a9-a0e8-034f42211844@kernel.org>
Date: Sun, 20 Oct 2024 10:40:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tcp: add a common helper to debug the
 underlying issue
Content-Language: en-US
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241020145029.27725-1-kerneljasonxing@gmail.com>
 <20241020145029.27725-2-kerneljasonxing@gmail.com>
 <38811a75-ae98-48e7-96c0-bb1a39a0d722@kernel.org>
 <CAL+tcoByVRMTt5r1WPN8ovwQDW0fO-ksWya-MCMw2v_93DOCLQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAL+tcoByVRMTt5r1WPN8ovwQDW0fO-ksWya-MCMw2v_93DOCLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/24 10:34 AM, Jason Xing wrote:
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 739a9fb83d0c..8b8d94bb1746 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2430,6 +2430,19 @@ void tcp_plb_update_state(const struct sock
> *sk, struct tcp_plb_state *plb,
>  void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb);
>  void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *plb);
> 
> +static inline void tcp_warn_once(const struct sock *sk, bool cond,
> const char *str)
> +{
> +       WARN_ONCE(cond,
> +                 "%sout:%u sacked:%u lost:%u retrans:%u
> tlp_high_seq:%u sk_state:%u ca_state:%u advmss:%u mss_cache:%u
> pmtu:%u\n",
> +                 str,
> +                 tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> +                 tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> +                 tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> +                 inet_csk(sk)->icsk_ca_state,
> +                 tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> +                 inet_csk(sk)->icsk_pmtu_cookie);
> +}
> +
> That quoted line seems a little long... Do you think this format is
> fine with you? If so, I will adjust it in the next version.
> 

Format strings are an exception to the 80-column rule. Strings should
not be split to allow for grep to find a match, for example.

