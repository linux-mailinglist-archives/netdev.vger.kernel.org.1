Return-Path: <netdev+bounces-230764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A0BEEEB9
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 02:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86AD189693D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA326946A;
	Mon, 20 Oct 2025 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdN8T2LH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D85184
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760918420; cv=none; b=S0Q8LBew1EATH4ROundUWSt5WOadi0ie2LfuF/juUOvpLxGXgziyMItxJwyHz++y+uOCinkEnMxGaPllRSiHzEIpCSEY85KHlHWP/2NAXSNhW5cmhvKcNyVBHArKYrQibchxtwqyD6UzmB1PbPl2WM0b0INLVCylmoigdHc5pV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760918420; c=relaxed/simple;
	bh=ezMN77l/qcVaMgmJJ7bxGKgebH9Xy6zHK2EiL+Mja6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M3P9WJS4Sa5TZAcDPWJdgyL05pBGLfbf9JKzL4JyAaeoTSj/1xu7FxLdUtyc71lTl21MHq3jRLhSn7jGg2Y0Hp/GXEiFQh3ytAGdN2Gr6E9zE/6oyN5weiJmlk95JXzreXPKMp1HqNL8I2GfD+CByaRuN5eH4HEawru7JuZw1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdN8T2LH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so47361545ad.0
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760918419; x=1761523219; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VaiAWLD4XNNKUuKlNpoWsuUt8QnNRZuGQMftj6fdN74=;
        b=kdN8T2LHmzKckBMEPGtkUkWjbogtRZAwPdlIHx57qD83musWmtd0xsxOSKzPMPL8do
         TnhzIB+vYpaFYF8BQRmmGF3KPqnaR77lQJCt64yhAypRca6ptgkqYdHpIxPhvaaaUA1F
         aCvySa+wsBaL7xrgZv00qyviGhIm+V7WxHWChnS44ZZuwoPn9Z+Rb6xoDs9hEXJMm4oI
         KRsyz1XYy3C03ZxwOjGUqCvxk3X4qsvXbX45ire5Hu/1eTS0NRg0JfYkSHMbiOnubiJH
         AXWwhJbp0eZx/6Ok2HIMTnaPgSlW477iMJ7sz2EEB5zEIADJ33l941LHqabfUdEI8OrZ
         pMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760918419; x=1761523219;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VaiAWLD4XNNKUuKlNpoWsuUt8QnNRZuGQMftj6fdN74=;
        b=xM8YkMR2dxs+JYZZgjdaHIKWnriorVFBoelNowtkYS2kWDrV5c9OQjK6/dnPssW/tq
         2MzPOl2NnhR6CV4A+oKcz7DnbBm6VAq3UVJMPfEqzVRzRyr377u/EiqZvB6S9bfknm1t
         KjRQZIIDw7ImC5fw3fa5+7j8My//jhczk7OMP3x9fPxP91NObtU5+ByPlriPuEP2Lgt1
         ZUMHppdPSsNAeCK5qCNT3LLJQlbx9AmIrxKeJXPGVOKj9cU1fMpviBiMx71TpkqAONwo
         tB5MIIhB4sA5sL1cNOtlR+ZdnHxaR2mETAG5wvMg2+2yMjTepneRymc82PeXFdLuYMl/
         upPA==
X-Forwarded-Encrypted: i=1; AJvYcCXITvjCjqISWZrIQA6vbxKS4j8bAsafUl8JX426oE4WvURDUHrldKZFclF1DjjP9WE9LGYekDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzscSQEAaf37uN8eAVmk6HjOml2m5DFofCa0FNoWT9IGbSob6q7
	eOUZO2dibnuNGo+6FqsJAMOjuyKjw64TQdKafEegIW3oprftuGMfQlmv
X-Gm-Gg: ASbGnctcQ3lGBZrbARxdL6bFegfBBuqAIg4hwNVX33yPG7Pkt+v0Nnxr0CwYJRTIQBw
	HmfYseO+qe8xLOB7ScBaLa55O5Ph6uLrml6+V7g52MxQdghvwvAU+9DUvbGeSdUwk512849P4PY
	AQGKuxHmucMjZRYFMzX86dU/Pj+x/3X3H2NE8W9NB1fIc+UgYwaB34ScxHBXN+RaNSTwDqyYbSD
	yF9lW1+1fyF3gBpgnvFt9RsBF6Kh0RekuRA9twct9HxnkEuDzQ5+g1lsVIndqjHzUTYuRCVj6sE
	gwApXeMPNvVut7Y23A/8nI9Ed7FenFWtTeI7gVulO6PnMZa8I1T4PB+jEpiplcmINJr54xsijXV
	47oJ38IW6JvcHS1N0UIXe7UEQb5vd8SmHQWKP9Vykgfs9tFAgjGmtQnnYv6PvnFcarWi6jIPEIR
	NOtZzwxMmMfJvDsArCTlRtdMmrFw==
X-Google-Smtp-Source: AGHT+IFcYo/fAegdA2C1gTxKem+CDCv348ZEZtfdFlF8lK+pytqmCXrWbosTkVJ1I3pvpi+J3kCQTA==
X-Received: by 2002:a17:903:98f:b0:277:3488:787e with SMTP id d9443c01a7336-290c9cf8e7fmr138965325ad.12.1760918418408;
        Sun, 19 Oct 2025 17:00:18 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdee2sm63726695ad.92.2025.10.19.17.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 17:00:18 -0700 (PDT)
Message-ID: <f0f97b8980fb141849861e67132dfffdfef4771a.camel@gmail.com>
Subject: Re: [PATCH net-next v6 1/2] net/tls: support setting the maximum
 payload size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	 <corbet@lwn.net>, John Fastabend <john.fastabend@gmail.com>, Shuah Khan
	 <shuah@kernel.org>, syzbot@syzkaller.appspotmail.com
Date: Mon, 20 Oct 2025 10:00:11 +1000
In-Reply-To: <aPAjm1tKMKxIdUlj@krikkit>
References: <20251015015243.72259-2-wilfred.opensource@gmail.com>
	 <aPAjm1tKMKxIdUlj@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 00:43 +0200, Sabrina Dubroca wrote:
> 2025-10-15, 11:52:43 +1000, Wilfred Mallawa wrote:
> > diff --git a/Documentation/networking/tls.rst
> > b/Documentation/networking/tls.rst
> > index 36cc7afc2527..dabab17ab84a 100644
> > --- a/Documentation/networking/tls.rst
> > +++ b/Documentation/networking/tls.rst
> > @@ -280,6 +280,17 @@ If the record decrypted turns out to had been
> > padded or is not a data
> > =C2=A0record it will be decrypted again into a kernel buffer without
> > zero copy.
> > =C2=A0Such events are counted in the ``TlsDecryptRetry`` statistic.
> > =C2=A0
> > +TLS_TX_MAX_PAYLOAD_LEN
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Sets the maximum size for the plaintext of a protected record.
> > +
> > +When this option is set, the kernel enforces this limit on all
> > transmitted TLS
> > +records, ensuring no plaintext fragment exceeds the specified
> > size. This can be
> > +used to specify the TLS Record Size Limit [1].
>=20
> Since this is now "max payload" instead of directly the record size,
> we should probably add something to describe how to derive the value
> to pass to TLS_TX_MAX_PAYLOAD_LEN from the record size limit:
>=20
> =C2=A0=C2=A0=C2=A0 For TLS1.2, the record size limit can be used directly=
.
> =C2=A0=C2=A0=C2=A0 For TLS1.3, limit-1 should be passed, as the record si=
ze limit
> =C2=A0=C2=A0=C2=A0 includes 1B for the ContentType.
>=20
>=20
Good idea, I will add this on.
> And possibly mention that TLS1.3 record padding is currently
> unsupported, so whether it should be counted in the value passed via
> this setsockopt or not is undecided. (I'm not sure we need to go that
> far. Jakub, WDYT?)
>=20
>=20
> [...]
> > +static int do_tls_setsockopt_tx_payload_len(struct sock *sk,
> > sockptr_t optval,
> > +					=C2=A0=C2=A0=C2=A0 unsigned int optlen)
> > +{
> > +	struct tls_context *ctx =3D tls_get_ctx(sk);
> > +	struct tls_sw_context_tx *sw_ctx =3D tls_sw_ctx_tx(ctx);
> > +	u16 value;
> > +
> > +	if (sw_ctx && sw_ctx->open_rec)
> > +		return -EBUSY;
> > +
> > +	if (sockptr_is_null(optval) || optlen !=3D sizeof(value))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_sockptr(&value, optval, sizeof(value)))
> > +		return -EFAULT;
> > +
> > +	if (value < TLS_MIN_RECORD_SIZE_LIM || value >
> > TLS_MAX_PAYLOAD_SIZE)
>=20
> For 1.3, should we allow TLS_MIN_RECORD_SIZE_LIM-1? The smallest
> valid
> record size limit (according to rfc8449) is 64
> (TLS_MIN_RECORD_SIZE_LIM), so after userspace subtracts 1 we would
> get
> TLS_MIN_RECORD_SIZE_LIM-1?
>=20
> (but this would bring back one "are we 1.2 or 1.3?" check :/)
Yeah I don't think there's a way around this...? I will update the
description to specify these details and add the limit checks. I do
think the payload size approach makes more sense, since, it could be
used for reasons other than just `record_size_limit`.

Regards,
Wilfred
>=20
> > +		return -EINVAL;
> > +
> > +	ctx->tx_max_payload_len =3D value;
> > +
> > +	return 0;
> > +}

