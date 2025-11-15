Return-Path: <netdev+bounces-238809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B638C5FD80
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F04E1B41
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 01:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6E71A5B84;
	Sat, 15 Nov 2025 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCfYI3Gl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0619EEC2
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170982; cv=none; b=kxk1bseP+XyAvg1YsBPHcfnoRXpevPG8O8CTYgJKPWaRNUUnqxvWcEDSouvz1+xKpKw0iSWaH6RCHUzROnW/i3G/4h5P5wwePOvm4CoApdasxpDtW3683vOn6CrpT/FFXe7DfE+o4YiPYvV2y/75SXJeEYxqbFcQ5XpWWp2NvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170982; c=relaxed/simple;
	bh=mZeiNyAAeCCHRXIvIYjT2BfUDo1bbzD/war5aQ1XPKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDDIZpJgIc3FiwtCwPcbba4W5DbBbnMkbodoprCOeI4oKSz8uXaR6vxz6fRfSGj8RdJHKqkUIBqwBCPaD8X8tFrujn8mpgQb+4gB9AZqsR1R1FYD0tWn/w66yaHZXxV5c+qUqXFsb440nATvdzWI1beGIYr2gvpnO9B+oL3ib58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCfYI3Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E17C4CEF1;
	Sat, 15 Nov 2025 01:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763170981;
	bh=mZeiNyAAeCCHRXIvIYjT2BfUDo1bbzD/war5aQ1XPKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WCfYI3GlwJh+nEBlPsQPBBQRhF5gcgVQBo09zNf7I8w+EmVYbfbrlacc56BV8p/e8
	 KIV2DlmPqOVaf7JUVzm8Qce+NI/RYKFnwWJelfA0MEAVFmZRVbsnVqqzjdGGRN/Og3
	 XCKXls/0ESlakFlUd6Zvh/dk2aCQXYlK2Agai/UWMWAmo6uEGe8FPOaPz2E1884S3j
	 hAV0gj/9DDUH2kWdzcD3u51fedWq6z6b0l8k8A/iKyuRdlLKQJAUAYrkME1RgL+1DL
	 2L/yiMtnDlCAuAPHuAQ05JH/OswAfLwUnyVHnYFH1tQL/hQtBJ+4EpB0vkYC7MfHkf
	 b8zRKiE73N6mA==
Date: Fri, 14 Nov 2025 17:43:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] tcp: reduce tcp_comp_sack_slack_ns default value to
 10 usec
Message-ID: <20251114174300.19e9e2a1@kernel.org>
In-Reply-To: <CANn89iLJGwBunzho9+Q1aRDgA3ihw=OrEuT3cBDiZn2QmVNkWA@mail.gmail.com>
References: <20251114135141.3810964-1-edumazet@google.com>
	<CANn89iLp_7voEq8SryQXUFhDDTPaRosryNtHersRD6RM49Kh0g@mail.gmail.com>
	<20251114080305.6c275a7d@kernel.org>
	<CANn89iJr4R4dgFmqCPtSWqgvPiY5YB4svD_4D7tO1BoZr=Y1-Q@mail.gmail.com>
	<CANn89iLJGwBunzho9+Q1aRDgA3ihw=OrEuT3cBDiZn2QmVNkWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 11:35:12 -0800 Eric Dumazet wrote:
> > Makes sense, or expedite/force the IPI if these skbs are 'deferred'
> >
> > I did not complete the series to call skb_data_unref() from
> > skb_attempt_defer_free().
> > I hope to finish this soon.
> 
> In the meantime we could add this  fix:
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index f34372666e67cee5329d3ba1d3c86f8622facac3..12d65357fc7f83cfa9f8714227c7b69035441644
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1480,6 +1480,9 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
>         DEBUG_NET_WARN_ON_ONCE(!in_softirq());
> 
>         if (skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
> +               if (skb_zcopy(skb))
> +                       return consume_skb(skb);
> +
>                 skb_release_head_state(skb);
>                 return skb_attempt_defer_free(skb);
>         }

Queued locally in the CI for now.

