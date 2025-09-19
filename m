Return-Path: <netdev+bounces-224876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE88CB8B28D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A413BBF32
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E5264627;
	Fri, 19 Sep 2025 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6kV3lHX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE834BA3C
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312046; cv=none; b=G2ljjWnG9JMjdWlJXTUOjIy8UZViZ3w6d+3BbcFd+EqH59lTOUqc2Eqk6riwTa9kmwOewcW0jVIMUC+/QChVFSLEUlrNjI8QHoDnYe67Hq1dkKixtD47XoQ3iAKyBPHQwhOOGPHOzrMof2Qt9c42KdunIWBvbPK905hVBiEFa6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312046; c=relaxed/simple;
	bh=mUyhu5Ib1FnKppXOvrrqiSnIjb16ncn2O1iIgAZRVsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSrqJg/Lr2jJIYO/4rd5l1PA8MNFh7PY+MEPjv4I+AyCvP2nFSBY+32fUbGMbl4SfrI2ccUGEu3PRgzPaW9LW/5e42Ymt7WyalQpY5CdR4SOFH7FIbl1706jS1H3HvpVY9/rg3EMQVPdAu+A//4Kk9i8gb6Gx/YqrVrsLLUfByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6kV3lHX; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b38d4de61aso33137191cf.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758312044; x=1758916844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp/m6uTz9B3XRHACC+VVqzRN8m54e23vlXvsETQm1ho=;
        b=J6kV3lHXqPAS8KQw0cJ/CCMdgkPrwFpprw2cT0uhgVsdorLC/6VG7//InWwSDPDu18
         hjT4bqKJtgjT+e7u+qTkdPm8xDAoUwJl7PaBteyrSleRiL4FjR+OsDxJnlALKslNokIM
         ZD97FUWEwy8khomI1th2DK5JpGQaPtZoML7Lfv3V0ch8iP2iSjYgfsp5cjr+PHufDlq5
         mSAac7Ql3V2TseUFHm0W9jQO6JLAG6vm8MVfcnFddj6k/rQUR+MzE6I9OKinNMWc9YFp
         uBYDH1XAuLFkDMzhnr8JA2uihuOE6I0Y4MIySEetQWr0fzzEWqKExfiSquqrZYXInV7n
         nj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758312044; x=1758916844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp/m6uTz9B3XRHACC+VVqzRN8m54e23vlXvsETQm1ho=;
        b=nbX8LeecXu9a9f/WMt1KrmEkq9NQNWZl4amvYpHpz4nHlyVNDS3m7mXHRFv3yiHShV
         pBW5CpntoDxxnTdZni8iJnMY2JpC5usPSxh6uIYkaMxHx4dcyBNFmcVCYjBzY7bfFh63
         81DgxfKWewQU8jrRlKkbsHB1sin4vvDUM9rjAyfrPZUlJETuCL3DStSL5NEGLREUgaxE
         1y+ht+D57AaaRNPJhy78SE8PAjCUufZojbi7BUZ/jXCe6GMk3M3zpi0p8uhmtQ5TcnL1
         7NjhSekljwo7ROA5pX3zUuQzyeaZYuxfut4eP56aJEdnQkc28nCEBfAt4g9R6UjaX3iR
         V4EA==
X-Forwarded-Encrypted: i=1; AJvYcCWq+mz1BnRouCghA0igBM1TCzls4DpsSlQDkzPJeVUdXa3+O3abqK84rVuvEYDluJKU/TvcYtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEwiQd8v6oi/bcvCT0pS1mVMbYpXPpAAQoK4HP+vYjrnUc8PB
	Pdfi1lJQ2m9QRI4aAE60p5jYClFQtkONih05iYr+Krgq61X27f8M7NOw23Z4zCSbrBzGGOUsZOL
	+42aHzdzixLOdJdHMuD546olx8b6tSNrXg2C2tP84
X-Gm-Gg: ASbGncuUO6XYQx7kGnkETrR3ywFYCiC387GjDGhkU/ZTzTEDAD7piC287W7g+HltGwI
	ovuSRRa5ITuJjS9UYNYJSWL4e9GBrg6Ox2rPo6FTJ9sbhBHUC6e6WMb8nhBGd4DgSgvHdV0InV7
	03h8aXL1zqbvGv637LNFWtIWT8GEIRRfMHuJWQltO9ife+Wdbxm99T1Gnt7vxrHI5+drBBGUDZS
	7ePlw==
X-Google-Smtp-Source: AGHT+IF3ZI2PakK5vfRLTA9vbrVBSGGqN8qKvTGqG6nCslabpr86PGk/bBecwCjRguQygRFK4vQJnSEe79LLY7h/VLc=
X-Received: by 2002:a05:622a:54a:b0:4b7:a7b6:eafc with SMTP id
 d75a77b69052e-4c06d67e991mr65850331cf.13.1758312043211; Fri, 19 Sep 2025
 13:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919173016.3454395-1-wokezhong@tencent.com>
In-Reply-To: <20250919173016.3454395-1-wokezhong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Sep 2025 13:00:31 -0700
X-Gm-Features: AS18NWCOYkxk_9vEU9rqYC-HLCcGEi5xhsjCte00EyRLLFSQcndBSvS9Zql3p08
Message-ID: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
Subject: Re: [RFC net v1] net/tcp: fix permanent FIN-WAIT-1 state with
 continuous zero window packets
To: HaiYang Zhong <wokezhong@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, wokezhong@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 10:30=E2=80=AFAM HaiYang Zhong <wokezhong@gmail.com=
> wrote:
>
> When a TCP connection is in FIN-WAIT-1 state with the FIN packet blocked =
in
> the send buffer, and the peer continuously sends zero-window advertisemen=
ts,
> the current implementation reset the zero-window probe timer while mainta=
ining
> the current `icsk->icsk_backoff`, causing the connection to remain perman=
ently
> in FIN-WAIT-1 state.
>
> Reproduce conditions:
> 1. Peer's receive window is full and actively sending continuous zero win=
dow
>    advertisements.
> 2. Local FIN packet is blocked in send buffer due to peer's zero-window.
> 3. Local socket has been closed (entered orphan state).
>
> The root cause lies in the tcp_ack_probe() function: when receiving a zer=
o-window ACK,
> - It reset the probe timer while keeping the current `icsk->icsk_backoff`=
.
> - This would result in the condition `icsk->icsk_backoff >=3D max_probes`=
 false.
> - Orphaned socket cannot be set to close.
>
> This patch modifies the tcp_ack_probe() logic: when the socket is dead,
> upon receiving a zero-window packet, instead of resetting the probe timer=
,
> we maintain the current timer, ensuring the probe interval grows accordin=
g
> to 'icsk->icsk_backoff', thus causing the zero-window probe timer to even=
tually
> timeout and close the socket.
>
> Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
> ---
>  net/ipv4/tcp_input.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 71b76e98371a..22fc82cb6b73 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3440,6 +3440,8 @@ static void tcp_ack_probe(struct sock *sk)
>         } else {
>                 unsigned long when =3D tcp_probe0_when(sk, tcp_rto_max(sk=
));
>
> +               if (sock_flag(sk, SOCK_DEAD) && icsk->icsk_backoff !=3D 0=
)
> +                       return;
>                 when =3D tcp_clamp_probe0_to_user_timeout(sk, when);
>                 tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, when, true);
>         }
> --
> 2.43.7

Hi there. Seems reasonable, but could you provide a packetdrill test ?

Also, what if the FIN was already sent, but the peer retracted its RWIN ?

tcp_ack_probe() would return early (if (!head) return;)

