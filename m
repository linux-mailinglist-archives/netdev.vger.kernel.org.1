Return-Path: <netdev+bounces-171078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A71FA4B604
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 03:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C597188B461
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 02:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF313C9D4;
	Mon,  3 Mar 2025 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCF+StKA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC402E40E
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968223; cv=none; b=c0hgs5CK5oGl/MojGO/qw1oBad3skC21/Q56SbHgQX7HqHyj2YtsoahFLoH6xcKqTqjpu7C30Zx93wx7dpsNHv4FC8S0i+pWMRG9umIXVHm/D2yTAWHA7/7GkvgrNhNsDOlg7csD1nz0/FNG9SavEEmSAD9ZxmP+pc5ss8lWnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968223; c=relaxed/simple;
	bh=9TlSEQcNlyYnFinooHJbDdyQDU2xS1zOEsLKeQkcQkE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=km60HjIBkNCxXIRpfizVqsRj3Gg8vzbLhy6NyLK/QqAtQ0qsUNrabq8++UW1vVi1s6XRlT1N3mRt9Js2roge5fRgiQWJLx3lJHt6rrvaHDIs68uQB2THE+sR+Q4nTWjVqJGkoRPdkipr4JVud1kW2Q9MElzoJ54RMv2Xnk79gio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCF+StKA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8c3a0d468so6619626d6.0
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 18:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740968220; x=1741573020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAPmK0DZHwzaWqKN1Px77dSFNv0SWbdawOnekURekyc=;
        b=MCF+StKArv0MfVOhKTAXt74uSyYtqoh0HYQOfZIVf1rtpf8vq19c+WzdoMmzTnKTQH
         6uxrlxoFkl+/K0ym/aSJ25wT6EdwdRWBg8J9s5n81/mx3Z3Qs+wQPBJq7ajUC+D+va/+
         ZoZ5pJyxv0Uj6LPMpHz26TlJ8h6DJI49hM0xyHJQgyMTqTarkdXixKmmCM/h8HGu064N
         NvaxC1MNZ1JFwOaINJ7JJtesMUSE5+Bbjl3LwtMUGCV+mIPhxnTwgFNh/R00K1/d0Uet
         sudbamDt8QkqtLKXJrxopY2g1i2+A1rQJSPlgibJYAQrdLlVats1On/cFh1DcqDPFvZq
         SsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968220; x=1741573020;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZAPmK0DZHwzaWqKN1Px77dSFNv0SWbdawOnekURekyc=;
        b=dyf41mucd9rV66/hpop6WCQqvg3KSjZ21PcUvO5+8+amvr6A0p2MQijIG5nEuHpFRi
         Rx1PNR8icyI6gFcYK4EnkHTuv3Oby4RZVG3DBre3Q50x80y3ugFe82ZMcbIkpEtxBhae
         nBEFZ14l7cxhIxmiFxf9xgacxt98NlPBrGuWjGbI0cEIOi6ETrGah14ZWYVCm7IT+4uH
         3eMDFm9lc+UcDSDW40l5Q3tYI07FobX+cbEe6uYcfxQ41Sv4P2JzOpfYE9TxzW2/RqdR
         ZwBq/A0YHAR0gBS2XL8lK4UhTBe0nItGbifT6EWItJICbEPKkpLqWXGSjMBxwwV9fUTu
         Tuew==
X-Gm-Message-State: AOJu0Yw1DnNLh+wCLaij+DnMWG4889NFH3mvIm/3nQu0uJSbPfOekDUb
	vYr13c8TM2iRqbg3qtvxqovL2zwlsDg+JXpkCF96yi3MsshKhy6a
X-Gm-Gg: ASbGnctV4leBM8Bv7Pp871AygTwBage3vREIYQAsGE31qvU+1GV+KrLwICxc8BjBU3a
	PCXMH0shm8iefyZrSvcK0fEMjOI1NmegR0ewblckTwBCUMwqlE8cVBrJrYMau7LxEP5Rg4ZG0Zv
	Qa51gEpukSjpAFj3j0af7zFJNRpNObW1GCwVP4+N44nnjdg61SHdYkN6iE/77AEwA51ltdylyQ2
	uaSwMBeJLhxJlVxMQLj7i3LvGJO1SNN9oxnjFMA2le0wCWyCuKq17YDixdXs/1XhpYYa2XCh9bw
	qawjEHu2p7pe5bvwMeWO3grHRv4aPpd0O/1Y0lgKa/MbOpwM5cAG8C7CJsCcWADaeKEuKSYb3MI
	1yMLhmf48wrDYSwbE5sftYw==
X-Google-Smtp-Source: AGHT+IG/oTFW/l2XwsCqde2419EiMdhH+gjxx8sMm/WPFw94Wk6+UKCRPvkh+cQVqrjHdvt0LBwA6w==
X-Received: by 2002:a05:6214:e67:b0:6e6:6b5b:e559 with SMTP id 6a1803df08f44-6e8a0d85e9fmr160400346d6.34.1740968220399;
        Sun, 02 Mar 2025 18:17:00 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a11fdsm52930241cf.15.2025.03.02.18.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 18:16:59 -0800 (PST)
Date: Sun, 02 Mar 2025 21:16:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 kuniyu@amazon.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 willemdebruijn.kernel@gmail.com, 
 horms@kernel.org
Cc: netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67c5111ae5754_170775294fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250228164904.47511-1-kerneljasonxing@gmail.com>
References: <20250228164904.47511-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: support TCP GSO case for a few
 missing flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> When I read through the TSO codes, I found out that we probably
> miss initializing the tx_flags of last seg when TSO is turned
> off,

When falling back onto TCP GSO. Good catch.

This is a fix, so should target net?

> which means at the following points no more timestamp
> (for this last one) will be generated. There are three flags
> to be handled in this patch:
> 1. SKBTX_HW_TSTAMP
> 2. SKBTX_HW_TSTAMP_USE_CYCLES

Nit: this no longer exists

(But it will affect the upcoming completion timestamp.)

> 3. SKBTX_BPF
> 
> This patch initializes the tx_flags to SKBTX_ANY_TSTAMP like what
> the UDP GSO does. But flag like SKBTX_SCHED_TSTAMP is not useful
> and will not be used in the remaining path since the skb has already
> passed the QDisc layer.

Unless multiple layers of qdiscs (e.g., bonding or tunneling) and
GSO is applied on the first layer, and SKBTX_SW_TSTAMP is not
requested. But SCHED without SW is an unlikely configuration

Probably best to just drop this.

> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  net/ipv4/tcp_offload.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 2308665b51c5..886582002425 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -13,12 +13,15 @@
>  #include <net/tcp.h>
>  #include <net/protocol.h>
>  
> -static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
> +static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
>  			   unsigned int seq, unsigned int mss)
>  {
> +	u32 flags = skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
> +	u32 ts_seq = skb_shinfo(gso_skb)->tskey;
> +
>  	while (skb) {
>  		if (before(ts_seq, seq + mss)) {
> -			skb_shinfo(skb)->tx_flags |= SKBTX_SW_TSTAMP;
> +			skb_shinfo(skb)->tx_flags |= flags;
>  			skb_shinfo(skb)->tskey = ts_seq;
>  			return;
>  		}
> @@ -193,8 +196,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
>  	th = tcp_hdr(skb);
>  	seq = ntohl(th->seq);
>  
> -	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
> -		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
> +	if (unlikely(skb_shinfo(gso_skb)->tx_flags & (SKBTX_ANY_TSTAMP)))

no need for the extra parentheses

> +		tcp_gso_tstamp(segs, gso_skb, seq, mss);
>  
>  	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
>  
> -- 
> 2.43.5
> 



