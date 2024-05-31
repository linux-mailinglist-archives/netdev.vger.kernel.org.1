Return-Path: <netdev+bounces-99730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6F78D6193
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0442E1C23D05
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974AE15821A;
	Fri, 31 May 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibMV7ZhP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C8158211
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158002; cv=none; b=bv2aEkG6sWp0Rt4Q+IScyKAIYXfJMoy2cnm504P4gyyV16qWies8iOveBTw444MwHRJn2fQiYYqC/9NFuU/TccSN5jHCdVFLJFkFKFSND6n2fflLcQQSLGUFpcx6seyr9668nPKa11q/E6Oww0p0N3AA0dVzG9LYqTWtfaZSwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158002; c=relaxed/simple;
	bh=Qrl8gBlWBojs4bs6Hkd0zqpMO++HCYgwKyzuuzzRa1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKj0nvfYyY/XR3WD+jf52obJPRxY4Per/MlPmMkGnXXO4RW5vVuglGjzPaDj4Z73dVaAAt06gsEgv1C9xMDQCvoZQaFgxsFevPXL/gloaORlLiOLtb7597j3jWhwJ+rSgpEPG5UD4Kh4Va0QKoJeZfLyDKMpFPF749MUGP3uywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibMV7ZhP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso9940a12.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717157998; x=1717762798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOMKLwenqrk5rHW2S8BctzzIxhLD4LfISuvmBO2LQGw=;
        b=ibMV7ZhP2AZjWsjQQn6bM3JLcldqHdVGP5w2c2IvZ/1lL8GqILWvxZZa3GqRRgn5LZ
         fmbXNjqz9KhAl8wYC8BLSuFd09jtGgTUqH2ARSiyKQq2sNjhBOhswBPDMbBEX8tv1sU1
         eZpQbOKxXR7c+HbLolVMIvASANWySO28gPDQKG/0VF0z0ib/0W4feB1LY0PcJ8exjegc
         fVZLCOvID1qz+/k9NAxZmtfHKSJVyS5iZXVjMFxDYm2U/VjofxNql30ydWnSxXRqOQOS
         j6DHhBkW8Wv9OFTAk9UUEbzYgiz4lH/UWd1LUK7vl5X2y024ZUkQMFF5LUTWWSHhq9pU
         WKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717157998; x=1717762798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOMKLwenqrk5rHW2S8BctzzIxhLD4LfISuvmBO2LQGw=;
        b=LEr+rWspZ1HArnZ00yTf9N4U13bUFtOBYAKCBrirrPBQmHUwhpqr4o2/TzFGoQKGSz
         HEewd+kT7GCfSO3RSyXPKOfGJUgglQEUH6RbzkGjEItJEhLntkcT3yahoWAyWwz5TPyg
         nwqv2bVVFY+oUX1jG1r+aC1ZLoTIK6snk73tKWrWdp6JnepYkFLRxOrlFVxPOumb3uKO
         8hIj9VMkVeGB3oXkTcNlRt5N034STe36L7Rb+EDf2RDnSUVPvT4q9+Zk6NKYIHoYLcFF
         7mkdMZmiJyXiLbX1nYo3BLZgNKLr3NG85hxUwMMYaYcgIeqOx33u6HrmbAJcvNgC7OUI
         Drig==
X-Forwarded-Encrypted: i=1; AJvYcCXQEwX4RPjgASTibzyMMNWhS2OciEfzZPajw7uCYINSgNw1EjiGptpbEpo5ilT0fp1umQlkBsb7TpW8F9hwiTqjKFUYSk8E
X-Gm-Message-State: AOJu0YzFblliW2eCQuQHs09nBv2JHF+PKNr0D2Cvx3g28VOzXy6rfUc9
	QCaqZFgZ/K9ywJ4FiN5CmoG/f+kbPQsOG7X9fm4dm1iQjWZLgR4QPAiZI9u4OET9NrcxQjcFzSD
	t1U6jwH7wA84TRehxbGJ1OWvUisyaHNk46HWm
X-Google-Smtp-Source: AGHT+IHWkB7C1ICo7tCMgw38WM+5BRZsljwQEM0wyfiPjI7e1m4UmfbnH2mLqGzVVvLxxsIB8vOUTC8Yx8oK2lqMTrY=
X-Received: by 2002:aa7:d6cf:0:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57a33693e06mr168102a12.0.1717157998054; Fri, 31 May 2024
 05:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531083840.2644162-1-jiangyunshui@kylinos.cn>
In-Reply-To: <20240531083840.2644162-1-jiangyunshui@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 14:19:44 +0200
Message-ID: <CANn89iLPYoOjMxNjBVHY7GwPFBGuxwRoM9gZZ-fWUUYFYjM1Uw@mail.gmail.com>
Subject: Re: [PATCH] net: caif: use DEV_STATS_INC() and DEV_STATS_ADD()
To: Yunshui Jiang <jiangyunshui@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:40=E2=80=AFPM Yunshui Jiang <jiangyunshui@kylinos=
.cn> wrote:
>
> CAIF devices update their dev->stats fields locklessly.

I disagree.
chnl_net_start_xmit() seems to be called while the txq spinlock is held,
so your patch is not needed in TX path.
Look for spin_lock(&txq->_xmit_lock), called from HARD_TX_LOCK()

I can not yet comment for the receiving side, can you add evidence to
your claim ?

> Therefore
> these counters should be updated atomically. Adopt SMP safe DEV_STATS_INC=
()
> and DEV_STATS_ADD() to achieve this.
>
> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
> ---
>  net/caif/chnl_net.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
> index 47901bd4def1..376f5abba88d 100644
> --- a/net/caif/chnl_net.c
> +++ b/net/caif/chnl_net.c
> @@ -90,7 +90,7 @@ static int chnl_recv_cb(struct cflayer *layr, struct cf=
pkt *pkt)
>                 break;
>         default:
>                 kfree_skb(skb);
> -               priv->netdev->stats.rx_errors++;
> +               DEV_STATS_INC(priv->netdev, rx_errors);
>                 return -EINVAL;
>         }
>
> @@ -103,8 +103,8 @@ static int chnl_recv_cb(struct cflayer *layr, struct =
cfpkt *pkt)
>         netif_rx(skb);
>
>         /* Update statistics. */
> -       priv->netdev->stats.rx_packets++;
> -       priv->netdev->stats.rx_bytes +=3D pktlen;
> +       DEV_STATS_INC(priv->netdev, rx_packets);
> +       DEV_STATS_ADD(priv->netdev, rx_bytes, pktlen);
>
>         return 0;
>  }
> @@ -206,14 +206,14 @@ static netdev_tx_t chnl_net_start_xmit(struct sk_bu=
ff *skb,
>         if (skb->len > priv->netdev->mtu) {
>                 pr_warn("Size of skb exceeded MTU\n");
>                 kfree_skb(skb);
> -               dev->stats.tx_errors++;
> +               DEV_STATS_INC(dev, tx_errors);
>                 return NETDEV_TX_OK;
>         }
>
>         if (!priv->flowenabled) {
>                 pr_debug("dropping packets flow off\n");
>                 kfree_skb(skb);
> -               dev->stats.tx_dropped++;
> +               DEV_STATS_INC(dev, tx_dropped);
>                 return NETDEV_TX_OK;
>         }
>
> @@ -228,13 +228,13 @@ static netdev_tx_t chnl_net_start_xmit(struct sk_bu=
ff *skb,
>         /* Send the packet down the stack. */
>         result =3D priv->chnl.dn->transmit(priv->chnl.dn, pkt);
>         if (result) {
> -               dev->stats.tx_dropped++;
> +               DEV_STATS_INC(dev, tx_dropped);
>                 return NETDEV_TX_OK;
>         }
>
>         /* Update statistics. */
> -       dev->stats.tx_packets++;
> -       dev->stats.tx_bytes +=3D len;
> +       DEV_STATS_INC(dev, tx_packets);
> +       DEV_STATS_ADD(dev, tx_bytes, len);
>
>         return NETDEV_TX_OK;
>  }
> --
> 2.34.1
>

