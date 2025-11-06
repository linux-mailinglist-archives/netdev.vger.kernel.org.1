Return-Path: <netdev+bounces-236439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525EC3C3B9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933D65604D2
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE8133C50D;
	Thu,  6 Nov 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjSrNNk3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F8343210
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444656; cv=none; b=sj6ViBzjwUA9/zadA2Ed22b3MFVxnjtbDy1Wg9hLWcVFh0IWW+36xuEM+63fainBNn9zpC3H6jpSmFEWhRsT+jOtaB+EVUw1MV/ooWmHpldfTU7We4qk8Yov4uwMAJcdHfi+7Mvm8IaCah8GiA9zSd3E/BslQwPyguqeNIa2Iio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444656; c=relaxed/simple;
	bh=FaEDcX+yF4BxPwdP6/q2hnGhQm5ut6F1EYzFGB8o8Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=op73LapvylKUoCUD5355Zz/vBJkU/3R6oByCfU+KfYXDkObwpjdx32d41vtbDZn+myoM/bKcFRbxePH/GW7iMerwE+/VhPHotWffpuCOP9riee5GzZgBM2L+tEdzOhl/KMZU9t1huNnOdqA6n/jV2J1RHOqWTJi3+hUxa+cz0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjSrNNk3; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed6ca52a0bso312831cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762444654; x=1763049454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaEDcX+yF4BxPwdP6/q2hnGhQm5ut6F1EYzFGB8o8Mk=;
        b=LjSrNNk38wiZ8tfKXvWNVk+sqRNdADXwtcgqBmMKlaGDp2N+q+6KnWCMK5a/EOO9se
         51M2xrSqHywcWRD/AivAi9u37bRBPbeBeHdxW4hBeclnf4IyD1wA/KooCENcRivCePBE
         az7HuCVqrY6hChmoB7EwqA/7DSVowqIyWNgKtG5WsOqmm5lqB9hkYJMpCOQW1/dkIvOG
         i5MF9XwYdeEHVMRNrUT3wzTF0YjnAIOSV4/+dCZvifawB995Mgdofue5qqAN1uspFi5M
         /fKYICLZrKp0xT/gyizglSXNJ0UqQRqaqc5RkRCFT9Zl2x5PjhE3zFVtQ7/9W8bXtjCC
         4Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444654; x=1763049454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FaEDcX+yF4BxPwdP6/q2hnGhQm5ut6F1EYzFGB8o8Mk=;
        b=AiTE73XcU4dnEihiQVRhclmTK8AkiWnDSquRfZTn26MepcgO1VBLwBLpZ08H7yeblI
         KxkRPE2pmycq3j5VNu94s4Lf8S++MHWmky3g2dFwYgO3nIMUs8CN+vkQns77vwwMAcZU
         +iILtDmmHLbmLDB+SsiSd+3r7AwsDp6rz3+h1lwzv58bXMer4fdaE16YfJu4TIUSmmyp
         jD95HBZO9x95R1rXxhCLsSgRZYMlbc9Z0lU2I0CjXld1+f/+t70350Vos4yA/QkRnLMo
         bMSgW31N4xdSHgKlaaXPk6kvvQvrDIzgH0NV0qSv7yuiRLJpsyDZKmfbGBD8+OAbYE5H
         S2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn57XZ4kqenRVlSCw1CekYNaVrRAGS0xkT1gtCW4tJk+HD5bXMQVuCYdhUk6rF2NL74G7nNpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznoEYVC2XZkkdUPl2nWPyOMkHW9oPAZH6SUF8V6wXCuCdLehte
	yZy6s/pz7lVZxGcI17m2dLPcGLYZcoOer8BgDqBmyWZjbnOVFtvU92EsVk98PDwOMGdS+EEovO3
	AiMShLJGbB4zWQWdvwRKihM3mttVnbAfSfgACFFr7zIHdNvP4KUedCtDnf2Y=
X-Gm-Gg: ASbGnctCbKndcWkzD/wBgCjvIOxHOJqPKB7kXXksTB8Nup2SnMmiYT19AAC/vanI9+z
	tpKjqcUcsxALyLjwEEHXIDgtAtfUcpQroaLYwr2J3iE3hDOJOqzWlYnMwRqUGwloOy6Jhki0lvP
	UcLcaT582hOSzP+kzsNz45WEVRc3N31Qu6WsVID/ud99utVzW5FxV9kIDOwtV6LfJpZI7rOTGtx
	1U/5k7p+BpSi0KWQ76qOgyJM76/uMvRM8e23tzrEDfYyq43BtvLML5bvbr18fCGSesE8aMzZvmH
	uKuniKxvo1/vdHjlMcZsSzmclvKth/mbmlcZD8r+mAHGmbj9Xg==
X-Google-Smtp-Source: AGHT+IE6dFK0t8Pe06PNEmE8fBu8EWs7lk3/LVgooQWOTIxDg7emwNtIGH5fxcKtfyctcEpR+bUBP/ZAjONtYSKEVfk=
X-Received: by 2002:a05:622a:54b:b0:4e6:eaee:a944 with SMTP id
 d75a77b69052e-4ed813e2c86mr7033631cf.4.1762444653735; Thu, 06 Nov 2025
 07:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106115236.3450026-1-edumazet@google.com>
In-Reply-To: <20251106115236.3450026-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 6 Nov 2025 10:57:16 -0500
X-Gm-Features: AWmQ_bkV0SFnWgM7Cpa76gtUCloxCd_Rx4oAUD7Ly-d2KLtG5dPI9ehbilObDuo
Message-ID: <CADVnQyneLJrkGBotQdf_eqhOY2cGmN0mw1FEfPE+kd8mkQ3guA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 6:52=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> TCP SACK compression has been added in 2018 in commit
> 5d9f4262b7ea ("tcp: add SACK compression").
>
> It is working great for WAN flows (with large RTT).
> Wifi in particular gets a significant boost _when_ ACK are suppressed.
>
> Add a new sysctl so that we can tune the very conservative 5 % value
> that has been used so far in this formula, so that small RTT flows
> can benefit from this feature.
>
> delay =3D min ( 5 % of RTT, 1 ms)
>
> This patch adds new tcp_comp_sack_rtt_percent sysctl
> to ease experiments and tuning.
>
> Given that we cap the delay to 1ms (tcp_comp_sack_delay_ns sysctl),
> set the default value to 33 %.
>
> Quoting Neal Cardwell ( https://lore.kernel.org/netdev/CADVnQymZ1tFnEA1Q=
=3DvtECs0=3DDb7zHQ8=3D+WCQtnhHFVbEOzjVnQ@mail.gmail.com/ )
>
> The rationale for 33% is basically to try to facilitate pipelining,
> where there are always at least 3 ACKs and 3 GSO/TSO skbs per SRTT, so
> that the path can maintain a budget for 3 full-sized GSO/TSO skbs "in
> flight" at all times:
>
> + 1 skb in the qdisc waiting to be sent by the NIC next
> + 1 skb being sent by the NIC (being serialized by the NIC out onto the w=
ire)
> + 1 skb being received and aggregated by the receiver machine's
> aggregation mechanism (some combination of LRO, GRO, and sack
> compression)
>
> Note that this is basically the same magic number (3) and the same
> rationales as:
>
> (a) tcp_tso_should_defer() ensuring that we defer sending data for no
> longer than cwnd/tcp_tso_win_divisor (where tcp_tso_win_divisor =3D 3),
> and
> (b) bbr_quantization_budget() ensuring that cwnd is at least 3 GSO/TSO
> skbs to maintain pipelining and full throughput at low RTTs
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: changed default to 33% (instead of 100% in v1)
> v1: https://lore.kernel.org/netdev/CANn89iJpinbbrU2YxiWNQa9b2vQ035A75g00h=
WFLce-CAJi9hA@mail.gmail.com/T/#m5047025977aaddcd2c1b2ed0117fd2177898fa87

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

