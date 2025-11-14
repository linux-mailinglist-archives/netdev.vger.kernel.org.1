Return-Path: <netdev+bounces-238637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68EEC5C508
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9E43B2A77
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64495306B2C;
	Fri, 14 Nov 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="JFtfHEIF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938F2FE560
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112805; cv=none; b=CZpOI3R1W8EnuRZBDHLYC5YpZnmzsCOwvGnrMadS+fAg0WPo+r1bFWSsZboWk6LzuEEhT3qzqDdXVX8odc8qh3CEd3Voz0TBl0fWNufgm8sMCwGobN17RkPjeQWUiwUt/TVTV3SHa5bCVRbj7JQnUMIjcV0k8yMBA0KVxDGEz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112805; c=relaxed/simple;
	bh=cP1Uwbd4P69+kSey2rH3UQpsOOVItcl5lDKsndp8vUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fsEB/sDMX4A/B/Aczz4LZ3e9vy/b5G29xDQMhVGXTW3X3/+aZcWIM6jfxYLdI2lE/0VAjEvnat1pE3tpZZPmZijBj+kj0yoWl9gN+p1ytfiHO5o541ltXC6ZOdtc9VVfHeIpCk8ce5rh7UDKL2tnzLsIdTs2a0yveTGWYN2uTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=JFtfHEIF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b312a089fso995722f8f.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 01:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1763112801; x=1763717601; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vL1syZRGKYqXrG3P6xtjDK9s9Tpjc4LGTXQp0cOV+XQ=;
        b=JFtfHEIFGvDZAkpUp39IbMhblAHoWjmGNUTYKn0mztcAVLIpn4vlout4ProfvwQ5YN
         4c77WT1h6mcijGMlhUM/zhklPKITzhE0s7UC853CtMZcNZDxIDHL4lDnODuVNxKiu8MM
         +5o1BtjztOEVKLoDqcY+iiCDqk+OpOb4hyHRA0nWdWMU94e8BlPkkc0tl1abH89vB+rK
         /VSvXEM3MYxqMxwNl8+b7UCuUSdYwiohT4XadODcRCowesqgjrgvmtTlfr7WmJp949zG
         WY6S5l9b7A5zTG2GljHwIMpprd5g3zVRpM1rxKRpfUiOzE+CWEXUmiFwDEfTErVS8dHF
         VCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112801; x=1763717601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vL1syZRGKYqXrG3P6xtjDK9s9Tpjc4LGTXQp0cOV+XQ=;
        b=j0jcnqoXxI498OMIaxV1zf/UgLndaq5WIRjGhbxt4Qqyx2gREkJqKcu7pFhOQ1zl5v
         1MyNKxRiQ1w0jNWkfsSPQcdg4K0PcbrnMnPWaNr/4vznQ7YGgHoHS7WZiCuAlNh06PbW
         wREmMSILOGJ1tL14tI0kF27oCUa0fWJM71bkxftLsEBoM7s0+LS23IUrACn1jjuDzxBA
         v7SC+S9dWkzrhbmJvRT/p1Cs4JDkd6YdDj8SCCnq0CVj4UoP4xIWXv3i/YglxAqRZRIQ
         BWG+9QoAVaIpQm4YMJdwCVZO2GK1DkoEfJVmH0nc6N1/XVtgsubN6piVZSKVUJ1R0/Gn
         w2wQ==
X-Gm-Message-State: AOJu0Yzc1K7A00Mu9ITytJ56Fm0upi4SrD3sSydsMIRIRMqaifSlIbo3
	s4eYdcYYbhi9Yrdsfh/Qm4ucPS6EDpoO7hY0a2Q2ip11wFf7MhNFln62zHIOL/6k9ms=
X-Gm-Gg: ASbGncurPXh1Dkj2fjagljdfTViHcmekaCCfUWv3V6PqOfdDT1G1VzVF27nPQBTAHnz
	SC2CqwuovTbPvkxS5X5mxnHtKQuo+pZLvF6bpebyioGxGsVLDQVIJ8/s+MMc80Xolr8XsqCbhJv
	WfjNYn+zV0n+h4Wr57DGhJBHSM612RasFDD7C7DLKQWshcMnRzXcaP9ACe/Hb5xrGxuCSZSM3QJ
	4l6kbS96cOPwD/+3KXT4TO0aTKLRfKhqBE7hBaF+ykbsiQBbiJzjnzUZQf+wqr9HZi8Q+DlRYUH
	PJyfMNVjAerPxQUPlzQXbnb9LBTcxajvh0IK6PHn+YLu8tGq9t9el6X6Web0LG4q8jj/5fLGdR4
	zJSrsxhwu1s/VmJzmFz+a3TD1ek6NonfUyvKIeL1hbG2TfQnOEMS38dyLVRMZ38IxixjJoZiOYc
	S0P5hsS/1e+pZD/+Hd/oH/THfEqdmK4DzFaEKG2KJxznY/5Ai5h10CSu1nZA==
X-Google-Smtp-Source: AGHT+IF6DRiOIV7d0qv4xiGE2/RO76v/o1/6D6Ui9iRQUOaiwE5B3JN+CauubEAP3FVa5V7859Xk0g==
X-Received: by 2002:a5d:5d0f:0:b0:426:d5a0:bac8 with SMTP id ffacd0b85a97d-42b59386b40mr2014141f8f.56.1763112800823;
        Fri, 14 Nov 2025 01:33:20 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f23a1asm8753206f8f.45.2025.11.14.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:33:20 -0800 (PST)
Message-ID: <fd96e756bae9bdbd48aee2e48c1feaed6a7dd70b.camel@mandelbit.com>
Subject: Re: [PATCH net-next 6/8] ovpn: consolidate crypto allocations in
 one chunk
From: Ralf Lici <ralf@mandelbit.com>
To: Jakub Kicinski <kuba@kernel.org>, Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Eric
 Dumazet	 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Date: Fri, 14 Nov 2025 10:33:19 +0100
In-Reply-To: <20251113182515.1b488301@kernel.org>
References: <20251111214744.12479-1-antonio@openvpn.net>
		<20251111214744.12479-7-antonio@openvpn.net>
	 <20251113182515.1b488301@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 18:25 -0800, Jakub Kicinski wrote:
> On Tue, 11 Nov 2025 22:47:39 +0100 Antonio Quartulli wrote:
> > +	/* adds enough space for nfrags + 2 scatterlist entries */
> > +	len +=3D sizeof(struct scatterlist) * (nfrags + 2);
>=20
> nit: array_size() ?

ACK.

> > +	return len;
> > +}
> > +
> > +/**
> > + * ovpn_aead_crypto_tmp_iv - retrieve the pointer to the IV within
> > a temporary
> > + *			=C2=A0=C2=A0=C2=A0=C2=A0 buffer allocated using
> > ovpn_aead_crypto_tmp_size
> > + * @aead: the AEAD cipher handle
> > + * @tmp: a pointer to the beginning of the temporary buffer
> > + *
> > + * This function retrieves a pointer to the initialization vector
> > (IV) in the
> > + * temporary buffer. If the AEAD cipher specifies an IV size, the
> > pointer is
> > + * adjusted using the AEAD's alignment mask to ensure proper
> > alignment.
> > + *
> > + * Returns: a pointer to the IV within the temporary buffer
> > + */
> > +static inline u8 *ovpn_aead_crypto_tmp_iv(struct crypto_aead *aead,
> > void *tmp)
>=20
> nit: does the compiler really not inline this? the long standing
> kernel
> preference is to avoid using "inline" unless it's actually making=20
> a different. Trivial static function will be inlined anyway.

Got it. I wasn't aware of that kernel preference and was following the
esp implementation.

Thanks.

--=20
Ralf Lici
Mandelbit Srl

