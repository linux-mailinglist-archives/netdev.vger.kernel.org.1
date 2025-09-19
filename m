Return-Path: <netdev+bounces-224892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05919B8B4D7
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3948C7BA99E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B72D3745;
	Fri, 19 Sep 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VeSwBV2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E792D0C99
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316527; cv=none; b=ccfeXwxaRBS0WfuJWzNog9X3qF2DXOomQN0SlqZBac2LFdp860996GQKhvHZBCngbyiShn5Om00q8sJz2R2X++4ezIoufcIDT9KJ7QpFRJa5PSSc4xrfeoBUqc7b8hyNeeZuP+uC9UG5liJe15pFuDOF4NOtOgsFw/FBUgV+JqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316527; c=relaxed/simple;
	bh=pzH6qdNu8Tu+i2wPkMgbq2DoOKv+uNWSj1swbLydr8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dca7w4J5fppSjTRRIDNZnZ0JOvJ40A4h8xs28dPIqEM2H92hB6p4g/Aj8lM8dUgg0K+MYLwens0QPm+Dt5p5zUBjD/Iyk6b6cGVBu+QF3LH261sm9jN4LRuBLop3zIwKaALbTfGhmwsagn3VlNv8HQoF2wdO3m5PlUdraPVDETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VeSwBV2C; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-327f87275d4so2752596a91.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758316526; x=1758921326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzH6qdNu8Tu+i2wPkMgbq2DoOKv+uNWSj1swbLydr8k=;
        b=VeSwBV2CBhAW0euX6IVFOgWeKm0N0qzsdNge2XWzHqB9lIHQtP668O8m6aIsowBDXe
         ZEkyPGN09bupZ/Eot1gNrr9PeOmqdB+zcTu9QayhOlj/3Z5DxhOOCQAiZlY2EDifiWoF
         UtCaPo6Iokk4j7waVXUVNG+KkQxhgCouB/0gi8E3Po+XOgN2mqynZjc17DryuQZoKD4Q
         EuzGUGT2nnhWc388I93pMCw6D7IB3PH1TPZiTNr4soeEY2d0p5JEIoeISFD+rf4BgmYr
         iUCXJWTc8FXmpO12ZznT30d6R3OLB/rpel1fMoM0qrLzaeJcvoKnQyJ9bVnMQo6CrRWl
         cYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758316526; x=1758921326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzH6qdNu8Tu+i2wPkMgbq2DoOKv+uNWSj1swbLydr8k=;
        b=WMBpM2/fhNDBodnF3Siw0sqfebwdB9WmqsvIoZSxGfSMSO1RA5qQBqg8mpLBPaDtsP
         bulVFTxm4cMHQj8X+l085In6n6ANVAZKgt7h76agZ/v00Vhz1h28CLrGS9TNk/QqX5oz
         T8Fn2KhitnvOo4HB3bhDYBJCs7ucY+vpZJIITOrusNTaXsBsg95WaY9+bEmRE3ovTu2x
         KXDYYu9XpamX3EPSEP2wv3Bv3EWfWNYZ/+7Uqf7dP124X7/C2k9Y/b2XoYv6Gzs3JPVP
         71iLvij+vQ6zN+jnQ/Z0nk2BlBa5Dx7+b1AGJ8ZEEWFkZ5g9ljaG3yuReMc2WGu3dlVl
         04cg==
X-Gm-Message-State: AOJu0YxY84KhlIOz63ABuz2Ew0UXuZVm0QmZOIAFnN7j2tVPaqCXshBd
	kNDV16++Nmil7eA1OWZkEwaXbW989T+HL4Ap31ASJIxTFktHPczBLL5hwRRfznVct5kqhaTk7F2
	ysGSAoeqn8rcVksNEpoxfXfbDThp8PCC4LsmnmKTb
X-Gm-Gg: ASbGnctN3yXtF/Yhyom/+ClQ6Ys1Ar5ujCg8EsN0/nPKZ/Ea/DXMiLbGha2mIlkjfzl
	opvXDnX9VOTk/uIMwvM7n79ujuODl+SGOOosW0DdqbjW6Eoh7RAK20LPtGcol9yhAO0XhZSRd3D
	L58wVG6GCvs3I7M/MhLvyaVJMVcujZt7ygs5w6EGtdxdmKB2XK2xWCKSfxO2nb8y12sM5Y0P2vp
	8QM9qYDNN2sEtamSsCNNLTI1Me8JnVVLipXM5Jv
X-Google-Smtp-Source: AGHT+IGn6kwgtmuUTWOSncAWxydXgSGDwE68kUyjAocqj9OKIov6CZAsRl6AOL4GPPa6igrXLhtipfVfeqd1BqsT2B0=
X-Received: by 2002:a17:90b:5109:b0:32b:c9c0:2a11 with SMTP id
 98e67ed59e1d1-33097fdca66mr5040923a91.4.1758316525522; Fri, 19 Sep 2025
 14:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917-update-bind-bucket-state-on-unhash-v5-0-57168b661b47@cloudflare.com>
 <20250917-update-bind-bucket-state-on-unhash-v5-1-57168b661b47@cloudflare.com>
In-Reply-To: <20250917-update-bind-bucket-state-on-unhash-v5-1-57168b661b47@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 19 Sep 2025 14:15:14 -0700
X-Gm-Features: AS18NWDags2S63UJQ0PWBhXODFfSwT2n5r85IW7VoaLCg55WKmNfHexsNwPBYA8
Message-ID: <CAAVpQUCi-LaX7tEKFOc=0ctbLqdYAhtXAPHHpHoqrnq9u+oBqA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] tcp: Update bind bucket state on port release
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
	Lee Valentine <lvalentine@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:22=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Today, once an inet_bind_bucket enters a state where fastreuse >=3D 0 or
> fastreuseport >=3D 0 after a socket is explicitly bound to a port, it rem=
ains
> in that state until all sockets are removed and the bucket is destroyed.
>
> In this state, the bucket is skipped during ephemeral port selection in
> connect(). For applications using a reduced ephemeral port
> range (IP_LOCAL_PORT_RANGE socket option), this can cause faster port
> exhaustion since blocked buckets are excluded from reuse.
>
> The reason the bucket state isn't updated on port release is unclear.
> Possibly a performance trade-off to avoid scanning bucket owners, or just
> an oversight.
>
> Fix it by recalculating the bucket state when a socket releases a port. T=
o
> limit overhead, each inet_bind2_bucket stores its own (fastreuse,
> fastreuseport) state. On port release, only the relevant port-addr bucket
> is scanned, and the overall state is derived from these.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

The update in __inet_bhash2_update_saddr() looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

