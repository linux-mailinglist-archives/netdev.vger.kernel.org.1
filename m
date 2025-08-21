Return-Path: <netdev+bounces-215491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA9B2ED0F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E716C171486
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC5327280F;
	Thu, 21 Aug 2025 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="h1mehDaf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04B1519B9
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750887; cv=none; b=UJDaMERrA1bgm8GgBc8nr7y6x0Zb0wRvHlO1b6v2zpMD4C/XG8yBJBiO8JeHoVEr6u38YtQByKSkWk+c7oMbzY77etRLROpjxtL0i4Q45ot9nueI2WF6KW5+SpXGjEIk9vsV2arlJCLRaCpqRxRheHFcHKZe5DcCMbRg4DsMEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750887; c=relaxed/simple;
	bh=yfeZVr1pRzye7G54OsLyepHb2ayn0nFCe4UT4R0J3XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mwzp+6FPMiA/KCzJMmH3nP/XQquagjq13UgHBJui5tnwDbeUvYZyoUGO1ze7fydpAes9SJyZwv+iwMHDMnwAG+tPlbkcBuNCVh1l2hpZhNfdNY32CKShUCZM5aj+kJO9/DWT3DkEWpdTw8foSWaVkjJrWKIIHj83T345O4e/YWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=h1mehDaf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24458242b33so5958305ad.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1755750884; x=1756355684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7PWT1n1N4cyQSckEn5Wpu3GsvwmXkrGb19jgGrs7Ns=;
        b=h1mehDafYJtmFlGMtYOgup6xd3B4eVgNTnVa5cNgbkVbz5wPytmHmLMLvhZBge1ZiD
         uFnv1YxmMpoLKOlc47JDKG5IxzX/EMX7VsVHmIj8+Xe0FAhARX1KV8iXuCmfWOhCbE1T
         c3sAQMTbpnbY4pB85Ny3BnHCaqrN2gfBenFs4cEfvugajeTUud2zoNL7/2T7jaRYAZ/G
         BMIAAlfgKctrwm2dM0hWSJRuHlelPecUoQLQhSF+YfVodKb6JLTO3vYcYNjliHwzhscL
         EiyrIBxGBC64jDKKtO0yr5bD6le4C0G+2UHwnXO5QF1HMDnSHxesCtbwBeFoE9D0i7jc
         B9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750884; x=1756355684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7PWT1n1N4cyQSckEn5Wpu3GsvwmXkrGb19jgGrs7Ns=;
        b=B0F6lOHt/7uXFcaFGpYpJZaNC5feHxsCmdOjXy978Q1bFYURh1MmwuuO2LG+m50I7H
         yxhaj6JVlmYmyhMHOfkZRR9G00e/1hJ3RRiiNVVnHzF8UmxKg+DIhg+/gt+0hBnl3KZq
         vEAjHHXb8SuxlXdLLSFeFPjSNHNf7O+ig5hi9+MOZ7kb5swvb0werdbQPGb1t4YIpUdd
         J1VmPop7eJfagT6HBEeCm3rB/87PD5cXV1zKTWyn9l88pg9ljCZ1dHaMYZsztjmNsK0g
         F+QUbe3fWcEaVXKfqc1XiaNhXLXBUlhQ+ZjOHHFmO7stZYejPT5up6h4zh1k7OuQ3zN1
         P0pw==
X-Gm-Message-State: AOJu0YxQAMKZkUbzMTZHHez2yfPjQSmK75reAkWQioSYOQY1UNKKsC15
	bGcE8fJJqfKNlz+2CDU/dB2pw7PA4vPkjcfmppR/TGeG8rFGuO3EBUQPs902VLR+jJwE1IPv7dD
	qaW/JeD7lBrXJZlzPycc/UM0HgTQ6eA8zr4yPjHaQ
X-Gm-Gg: ASbGncsjxH+fh+SSFV95/QLn4/ZKcAldr2Wlp24NzkSVfTCJCocbtm/vX9cYk3WsjVy
	uLwlrvy16BvnrLFUYTCUV8AFWdc1bc36tgrm1D8xrum8xNDiq13j28gm9FXHraibgw0omJixI82
	3VM+fVUgiksrkipqznv40GPgodBugzwh7MKl/Akdj2dwIssCDhx94O+Ru5KiTepvy4LTJqtbWVD
	cz4c7g3plGVG27skQ==
X-Google-Smtp-Source: AGHT+IF2uX3R0FJ0688NehvbSjH2/2NnoTL70Kelr3vhFTBhyv8AqQI6QOZ8aXvGG29cjcHHl2y1SkDgmJpqMr7/ji4=
X-Received: by 2002:a17:902:ce11:b0:240:9f9:46a0 with SMTP id
 d9443c01a7336-245fedb7bcfmr15868455ad.38.1755750884304; Wed, 20 Aug 2025
 21:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819205632.1368993-1-dw@davidwei.uk>
In-Reply-To: <20250819205632.1368993-1-dw@davidwei.uk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 21 Aug 2025 00:34:34 -0400
X-Gm-Features: Ac12FXy02Kiv8XXTBqIGE51vmT1B3rufwhtpH4cdORhMijefPWS7bbx20adJ-3c
Message-ID: <CAM0EoMm06em6GKDyDP94oQ_RPHv4PQ3dK19YZU9jxCiNh2S8rg@mail.gmail.com>
Subject: Re: [PATCH net-next v1] iou-zcrx: update documentation
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:57=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> Update io_uring zc rx documentation with:
>
> * Current supported NICs with minimum FW reqs
> * Mellanox needs HW GRO explicitly enabled
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  Documentation/networking/iou-zcrx.rst | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/networking/iou-zcrx.rst b/Documentation/networ=
king/iou-zcrx.rst
> index 0127319b30bb..bfc08154e697 100644
> --- a/Documentation/networking/iou-zcrx.rst
> +++ b/Documentation/networking/iou-zcrx.rst
> @@ -41,6 +41,16 @@ RSS
>  In addition to flow steering above, RSS is required to steer all other n=
on-zero
>  copy flows away from queues that are configured for io_uring ZC Rx.
>
> +Supported NICs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Zero copy Rx currently support two NIC families:
> +
> +* Broadcom Thor (BCM95750x) family
> +  * Minimum FW is 232
> +* Mellanox ConnectX-7 (MT2910) family
> +  * Minimum FW is 28.42
> +

you missed the intel dpu/idpf - see:
https://netdevconf.info/0x19/docs/netdev-0x19-paper13-talk-slides/TheBattle=
OfTheZCs.pdf

cheers,
jamal

>  Usage
>  =3D=3D=3D=3D=3D
>
> @@ -57,6 +67,10 @@ Enable header/data split::
>
>    ethtool -G eth0 tcp-data-split on
>
> +Enable HW GRO (for Mellanox NICs)::
> +
> +  ethtool -K eth0 rx-gro-hw on
> +
>  Carve out half of the HW Rx queues for zero copy using RSS::
>
>    ethtool -X eth0 equal 1
> --
> 2.47.3
>
>

