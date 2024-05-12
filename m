Return-Path: <netdev+bounces-95785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E216D8C36DE
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 16:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B823281313
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B630286A6;
	Sun, 12 May 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="dcOku1iw"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC025634
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715525252; cv=none; b=YYt8tEVb5dwtI++U+zTqfqwrOC4AtVXdyC5ST1k7rz3Gagje1K9ruKfP2ckPHqZp9EWKmKqlgoXhhUWSeCt/i9g23PjmJg8yfTzBH8W/oN3g8UJBSZXDlcX6NzQTE02H7axjxMM29Q8YxrdFO/nEjgy8gUSGDW2Un42VGcxsRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715525252; c=relaxed/simple;
	bh=2h73f+YoVF20maKnKYlAZePCDDWtdY1CTLXHGhRiLlc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vvlogi872tcn8V+vK6mJGEK8jayV+V4uPXmhOjbWIwewsOWtiscHaUudeikYP00QToQFjziptcz8gad6YyH5HQRxQhPrMemUOYi28Dkq6q0ocXW5ONr3Hcnt8oRiROv5FBdTvA6wCDZT1esvEYvCrq2GLULunfdmtiSPVsGGnGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=dcOku1iw; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s6ATr-009lKq-Uv; Sun, 12 May 2024 16:47:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=GFfvTZkwZFzDKo3CbPkWJqVb8zZQKoB69i1Hzgya63E=; b=dcOku1iw2UdAh4RAjQz8gIjy1w
	Ew0FHchPJsRU00i8rJYr4VYetclKKtVs2FmaAnGkjBh0lNIwjDHFjcua3ukGB3vSS5n6MsMhGGXuP
	gl5wn7AfTFG6Tj3EreLHwypWSQlIZZBHVOr3YKECQTavuxIIStxBuH0cYy/dvtlKXpPyGIA49GLFg
	L3Pmuy8Z0M8cyq0ieqcApAZ/r3ERU7Gq1LMSPj1y7uHLA1VSp8RXNnFjVGCeo5giVNQ2pyqBOEXQb
	icZMYWL6HlQ4pyp3Tz+8uK/D5hwwriCg4krnqhqOeCSrqerUAK+Vl8nB0TA8dsC+ZYZBszLx6knTL
	VG5Q7Zxw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s6ATr-0003bk-2D; Sun, 12 May 2024 16:47:15 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s6ATo-003PPY-CW; Sun, 12 May 2024 16:47:12 +0200
Message-ID: <5670c1c4-985d-4e87-9732-ad1cc59bc8db@rbox.co>
Date: Sun, 12 May 2024 16:47:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Billy Jheng Bing-Jhong <billy@starlabs.sg>
References: <20240510093905.25510-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20240510093905.25510-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 11:39, Kuniyuki Iwashima wrote:
> @@ -2655,6 +2661,8 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  		consume_skb(skb);
>  		skb = NULL;
>  	} else {
> +		spin_lock(&sk->sk_receive_queue.lock);
> +
>  		if (skb == u->oob_skb) {
>  			if (copied) {
>  				skb = NULL;
> @@ -2666,13 +2674,15 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  			} else if (flags & MSG_PEEK) {
>  				skb = NULL;
>  			} else {
> -				skb_unlink(skb, &sk->sk_receive_queue);
> +				__skb_unlink(skb, &sk->sk_receive_queue);
>  				WRITE_ONCE(u->oob_skb, NULL);
>  				if (!WARN_ON_ONCE(skb_unref(skb)))
>  					kfree_skb(skb);
>  				skb = skb_peek(&sk->sk_receive_queue);
>  			}
>  		}
> +
> +		spin_unlock(&sk->sk_receive_queue.lock);
>  	}
>  	return skb;
>  }

Now it is
  
  spin_lock(&sk->sk_receive_queue.lock)
  kfree_skb
    unix_destruct_scm
      unix_notinflight
        spin_lock(&unix_gc_lock)

I.e. sk_receive_queue.lock -> unix_gc_lock, inversion of what unix_gc() does.
But that's benign, right?

thanks,
Michal

