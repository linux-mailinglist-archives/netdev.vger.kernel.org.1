Return-Path: <netdev+bounces-217211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A13ABB37C31
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE0818813D0
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E02F60B6;
	Wed, 27 Aug 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/6jqAYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CF31CA42
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281043; cv=none; b=BF6XkiSp/p5/HPBI3bwgRX7/JLngceNgggCOTo6nzj/lRTLWNA/k1p9Ouo0MccsCIyMpD/ZtZURFcMrw5hKoQIgdiKl6Xt+1r1mzHUuceACCg2TryW86sDCIZiLDlCHnM2nCBH+3II8NPX3Q6oLKFCfshUSouP6gsyyBPGkqXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281043; c=relaxed/simple;
	bh=rKzArrpjxa/Lq0kefQY0MeR2/PKN5QtZoFTBYUdkchM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnyEojWqKRdl94lqQCgqr1jFUjyLIFtN7La+q6f0m5URdaCwXyXz6OrlZPFHfusQm8uwOhUpQRELIU1xHZRDRPYn2ClwZPEnBjmomlNv8LqYynP7B5Fw42dHe1GKPZqsNIKMg0xZx+oTZvbndkQnsydkDSjUkjH8x1a9LDqCn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/6jqAYJ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b1258a3d71so72400721cf.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756281040; x=1756885840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vazTG+jUIqFROmWwd6b3nHdEYOXrR8g9m3k15ZXCIZw=;
        b=b/6jqAYJq6L8dEUSiDJl6R91ZNMVZKaBE9y9plVJBcd/bYbuoQHWvx07tgKGwAJcr0
         g00VwkR1y3c9U5r8cUY1+B9IY1zCczhaDV+RGuXxo9L0DOEbNLOwQePPZRlJiFqAj1Oz
         ehaBSxJ0H57AW3ZLHk1zAUWKtSbdmkGUAOPnh9Uz8+HlddBTVuus1Qoon25kHTIco2YR
         ve6CzRuDgJ0ecTk3btYOVkwMzREvTMI+KQu02ILkaT5XhTAt5jQ1UQIrapayUsxxbvQe
         1rNCn136ARUnEpD/9vLrHsXF2W0p1uM1v84i2mezoKs5eSyc/7KLnSlkrJgYSnkJTh+l
         v0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756281040; x=1756885840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vazTG+jUIqFROmWwd6b3nHdEYOXrR8g9m3k15ZXCIZw=;
        b=PHBKPYUDkBoieEakhRBe9yYrEC0GqD7qp+ON5LHStgHwujfD/1WdqF5ZAbGQgENBOQ
         ynIA5mk19P2H50G/ZujIZbvnGjotQLhpN6H8t4zpdIv2AwdlWsT84hvQ+qJgIBoRPzHF
         X5ZUnMHrr9ghZkiSGhjB8+tjn/rM6LVDOEUjrfSsPkqET1CaPEbhzyaov5vAIjkOXvDK
         4X0FxB75u5lujrVtaL2QluDo3M22VrpddqLApMIn17bAn9n5mHHJ1wvWoQP5Rez7Wrrq
         wr4Nrof+J6YcNNHOHds+lIgObDm6bV7m+NSCwyiaCJ/nGw7BcNB3z1FVzTCB585p69yo
         zz9w==
X-Forwarded-Encrypted: i=1; AJvYcCXQatbHgsmTbG7/T4g6bLuyGa5kicCXuk0S1Fd+xemRtvu5fvdqlSER3W6srDQ2LuhZU5ZwRMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjj9y3Ti1l2D0p06IDQsg3051PZ3WL1bLUJ6IKNuQraUEtfIIv
	hxfs1YmB+QeECULmcKCy2Ppbz1Ykf2+p3vruU0hiLJwyrz0m0d6QQqu7GSV/ACZMKYv9mjyZKAp
	tjTM3+TEvCo6WCzFzRjYJf5eVckMf2LZWgb6+46Xe
X-Gm-Gg: ASbGncuiny1CSaH8Gl3/b3IHbQlKn4A0U0n/oE+LpPcmRuTPc5w6NxdvbK4DxekyBkD
	q81ugPvMC6z4a9sis7feg1h+UV17HYs3Uk+sKdQU4nEgeHI6UrsTMG2bC/AcRX7kZkSBLa8aeEC
	UfbIAoqQm0Plb47BNWu2llw09fGZYJPPS8WBLnGAWjd76OxF2HaGFswZUWA0YcSpF9FZrEAFgzm
	zYRy7/ow0I/SA==
X-Google-Smtp-Source: AGHT+IGntaJmdIqvh+6j7/jxL3REciPKkOKmbPQVXlTso2X7mImO23KWb5HDF9Ug45l2zI1Y+TwLyOjxL3xSnAvzq0g=
X-Received: by 2002:ac8:584d:0:b0:4b2:83d8:4e19 with SMTP id
 d75a77b69052e-4b2aab2f2b4mr222861061cf.67.1756281040226; Wed, 27 Aug 2025
 00:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-0-5527e9eb6efc@openai.com>
 <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-2-5527e9eb6efc@openai.com>
 <CANn89iJ5brG-tSdyEPYH67BL1rkU5CKfvUO4Jc03twfVFKFPqQ@mail.gmail.com>
 <CADg4-L9GdJUVcGBoR3+jAt5QsSEwtiQptx2KY7UF8ga1yA7SWQ@mail.gmail.com> <b5k5gan4nwyrjm5pm76oeyll55u2om2chnvx4tekgsw2y3zqpm@pa3e3hhfbpjf>
In-Reply-To: <b5k5gan4nwyrjm5pm76oeyll55u2om2chnvx4tekgsw2y3zqpm@pa3e3hhfbpjf>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Aug 2025 00:50:29 -0700
X-Gm-Features: Ac12FXzfaI2TRnCMsm7MgToJl9Ml2QUToSzADe4M1Wh9cAdCZ7NW7drK6Q4jWXk
Message-ID: <CANn89iJnUDCfjeDg91jomVmiFSTDSoSc-mPiSS+opTEB-7+A_g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Christoph Paasch <cpaasch@openai.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman <gal@nvidia.com>, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:08=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:

> What are the advantages of using eth_get_headlen() besides the fact that
> it is more exhaustive? It seems quite expensive compared to reading some
> bits in the CQE and doing a few comparisons. Even if this cost is amortiz=
ed
> by the benefits in the good cases, in the non-aggregation cases it seems
> more costly. What am I missing here?

Let's not reinvent the wheel, and add more potential bugs. Please ?

Why spending hours and ending with some ugly/wrong things like 'TCP
headers have at least 12 bytes of options'

  } else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
+                             CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
+                             CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA)) {
+               /* ACK_NO_ACK | ACK_NO_DATA | ACK_AND_DATA =3D=3D 0x7, but
+                * the previous condition checks for _UDP which is 0x2.
+                *
+                * As we know that l4_type !=3D 0x2, we can simply check
+                * if any of the bits of 0x7 is set.
+                */
+               hdr_len +=3D sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED=
;

Either do not pull anything and let upper stacks pull one header at a time,
or call the generic helper to make a single memcpy()

Real costs are the cache line misses, analyzing the 'CQE' will not help at =
all.

Really vendors need to stop adding useless stuff in their receive descripto=
rs,
there is no way they can cover all encapsulations in modern networking.

I find it very annoying that Mellanox in 2025 still doed the overpull
thing in mlx5, considering
I fixed mlx4 driver in 2014.

This is the major and well known issue.

