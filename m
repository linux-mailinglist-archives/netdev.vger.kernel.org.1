Return-Path: <netdev+bounces-224581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E5B8655D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E482F566053
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20853284888;
	Thu, 18 Sep 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnq4B7rO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDF283124
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218218; cv=none; b=kONv1/Zn0Le9ez+hbeBYd4ss6TpAJM8tfBNZdaSA/bSD0R4uluefpMkbSAvSBIb2PO/WpXM87kAWc0p3XyHqjl30NzUsANxqbpjfZDdc31A3iI4Qs0pHwaBFkkHQjX4L/ijaW+U/XEww8aGiWjvA5mgx3pqiHu3qsiIqk5dUDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218218; c=relaxed/simple;
	bh=nvt1N+FfJ8oCTeJ8U8dYalDQG1N6tXfbrPHZYCDYP+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oepfo+dA2ZA1YzuwVD1vcnWz5+if/o5EBGQrH0wxftcddpeSjjEFsAm6vHZedry8O/Cs/5VQB4qoLnsjmBGD0cW3UzvmNjFodmxUW128QPWyaUZkndHli8qTA1HaqNOkg5Fy3QCGkTIP5DUSZCMdN94JPFH6F8X65OWh2Hytdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnq4B7rO; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54b3cafdcaso897638a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218216; x=1758823016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w/9PvTdoGLy1Z6oVI4h1Hm25FtASw/ANcmPy9rvAMw0=;
        b=dnq4B7rOLWvTqRvjhFRIHxBBm/TNY+6L/Ol809yFwJU568xtCxF5+mtQneQJAuWYwL
         oVuw5t85x1ee6hZV+vH0tiwD1/dh9LExbg1lI1GU4WGd9s8b44CLBRc/s+WDQXWdqNBs
         ZC3eXl/+mV8AV1ekl0VzK3t2ZNzmCMyTHfLkc9jcEDhsFT68Vykt5w60ZxvIFaR7/diD
         wc9prLV4mXU7ABub4s/MUYuvFavIsWRwJXwxWNDsdXgv6krzKxRGbKXLp8iz4ELvEUVz
         fhJ1W5i8HdNRVxeM8wKNFDzyPrjX21jlMA2aF/0bdEsWgmAK4XnxBqdzXsC9E4apXM8J
         zFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218216; x=1758823016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/9PvTdoGLy1Z6oVI4h1Hm25FtASw/ANcmPy9rvAMw0=;
        b=Z++eWxr809F7g96bWQDKwxXxGiczaqIKFv2Mm9lEZYodFMjPYrL8emfVdEZ60Jp76Q
         hs8OsJX4j6OdlR1BFSXSGhQFDf1avB2kznZlER8kQJfZCmZ+aWe5SLYvX1ZHPOlyqNoU
         NpkOS56rPlZFNX7TE1fHXCiwO8XQRAdcadvNbJbfYtWO49jYUeIeJwyHs5GpVXd9Rb8T
         QS7HoAC7WGFbbaY03SePLzZegOXLuOnAGUCiGYzS39bQfA8x3+JK7grlhvD2zJCpu9sk
         LAqErE41E6UiPyBomE07fCaN2HRcE0Sn5UhLm0smIch/iw0CK/C91JwO/rzaLyNy00TF
         2rrA==
X-Forwarded-Encrypted: i=1; AJvYcCVp1fog6EJTWNOVPUQNHcXTMOkmhwkCRIO++rhVhZrtcyitR/l4Yhdr7RPOzsj7o91xbt6FR7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXtg5J9XlQREkw6pvm/o4ILCVbATSBjy3GF9NccJBN94Gci3no
	er7mA9iAKSrbK6XIobsKCm9Q2jWJxadq9ToWmBPTGcUfYA9f4dN+ig+Ft7at2/7bdr/fBjTP3Op
	mTBXLaRGANPkzw8pfqV1oTeMCZkFoduM=
X-Gm-Gg: ASbGncs/+7Kvfz5WUcUtKy/j5W2seZLmbSExw+pW7kUOFuGAIgxswTcizd6XLYkEO1T
	rZJ1d8uD2P37YNVpO0j1g9781NG4qjDXkZ+HlgaiGKnxaaIBhm58ltrD0Mi3KJ6Pk5DBNITd23y
	98Tqeas3OSuW4Yw5by/IaZ6eceXt410ZwS/oB3qVvekRJHyPWyfHdBKRMXhAP7PUTUlfdmKXtGv
	0POtH6MMjlhQ2uMDoRI4x0V0fzKx4stqgJFQV/nVu7aHFbNLrPmX44parNvoh5g84mdGxB3eW2S
	BE7zwok+lcOOde4YtvBQYAuom8O9+rW13kkNBKGXFlQ=
X-Google-Smtp-Source: AGHT+IFrdV9xtNvQ00qw8ejVimn0SAJnKLs2YQ/ftQEUZgyyC+GdEa5vG+miTDdMCErkwE6XbvwteWaIWbFoeg34tRo=
X-Received: by 2002:a17:903:1ace:b0:269:8fa3:c227 with SMTP id
 d9443c01a7336-269ba3f5f6bmr5885115ad.8.1758218215833; Thu, 18 Sep 2025
 10:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132007.325299-1-edumazet@google.com>
In-Reply-To: <20250918132007.325299-1-edumazet@google.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 18 Sep 2025 18:56:44 +0100
X-Gm-Features: AS18NWAE1sBJzaGrZNdoWdR5ryp-4-kWsJptwJ-bAg8nu5OpKPCF52RZGu7-yy4
Message-ID: <CAJwJo6Z5+W2hDMOwPTnRWqLoGLqfwezZd_mOCmbMEnbvK-VBDg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: prefer sk_skb_reason_drop()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Daniel Zahka <daniel.zahka@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 14:20, Eric Dumazet <edumazet@google.com> wrote:
>
> Replace two calls to kfree_skb_reason() with sk_skb_reason_drop().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Zahka <daniel.zahka@gmail.com>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>

LGTM, thanks!

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Side-note: I see that tcp_ao_transmit_skb() can currently fail only
due to ENOMEM, IIRC I haven't found more specific reason at that time
than just SKB_DROP_REASON_NOT_SPECIFIED, unsure if worth changing
that.

> ---
>  net/ipv4/tcp_output.c | 2 +-
>  net/psp/psp_sock.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 223d7feeb19d4671fcbc9f21caf588c661b4bbe0..bb3576ac0ad7d7330ef272e1d9dc1f19bb8f86bb 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1586,7 +1586,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>                 err = tcp_ao_transmit_skb(sk, skb, key.ao_key, th,
>                                           opts.hash_location);
>                 if (err) {
> -                       kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED);
> +                       sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_NOT_SPECIFIED);
>                         return -ENOMEM;
>                 }
>         }
> diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
> index d19e37e939672c1f8fc0ebb62e50a3fb32cc8d25..5324a7603bed64d3f1f71b66dd44f622048519a6 100644
> --- a/net/psp/psp_sock.c
> +++ b/net/psp/psp_sock.c
> @@ -37,7 +37,7 @@ psp_validate_xmit(struct sock *sk, struct net_device *dev, struct sk_buff *skb)
>         good = !pas || rcu_access_pointer(dev->psp_dev) == pas->psd;
>         rcu_read_unlock();
>         if (!good) {
> -               kfree_skb_reason(skb, SKB_DROP_REASON_PSP_OUTPUT);
> +               sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PSP_OUTPUT);
>                 return NULL;
>         }
>
> --
> 2.51.0.384.g4c02a37b29-goog
>


--
             Dmitry

