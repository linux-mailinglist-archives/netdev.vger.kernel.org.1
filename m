Return-Path: <netdev+bounces-238438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A2EC59443
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24D20561798
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BF328620;
	Thu, 13 Nov 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="meXn2O5V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F991EEA5F
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051566; cv=none; b=ZQHY2Q1YLedQOxXKP3BihAAmue2nYZcCrrX64YYy94PXtgb2cJQ6jBtzM++5YBXOpCIpth+H05ZIqojdUjmog6N29SKESq0VDi2ToOwnYrjAkOpdqel1pxnsofLshPkIDYwXMZap/NvpVRTyS7bikJsSfmq+fgWFxJztnQgZkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051566; c=relaxed/simple;
	bh=A4sx7YUeD3fO8/Yv4HHEyzNCLfzv5jGzvARBXVbjTzs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FtTs1VW++x9PKsqZtiuw4E79u6sOjSWNJDjk9xbW9Os7BhqvAnro0SJC5khgG6+BJjClFfwRqoWd8Zx5RkFnLL1yt9vUt/xSbEzbpmTqKzoFDTENqWuwMW8Xkseec08TXz2JWSwPCzimmzKp8j7DGygATyoZHs0Fw6PysFoRC7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=meXn2O5V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47777000dadso7887935e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1763051563; x=1763656363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BDXhrF3jmCsik0pVpflFinqzPLyBF5bBUKarlz+FDeU=;
        b=meXn2O5V/Uhduf7rxM0IOoqNW2Y4GNacb1Z3M1b87JyEztcKLIBELazBZpu8doEoTx
         QJQ4UX0NtjB0M0oolT40LflfWogzub2OhvvygilSagZRIbkxuPNq2+Ufmvjk4ZC37CGq
         blaio40QD5hJkfZxDtBRGbreXNcf5PDi2uqBOCW8VkW45bo9UPh3NdbqTwY/qnHkEKsD
         TBQhhYEWy0FxjzSHjWToZqI/7MBJZq6r3zHJbqLwlsdg7TNzoht9KsKGsm7ZB89RazqJ
         H3FZWTzX397PcCFSFMsKYkwc/RBPWGgmjuFXCKVC9vhmpLuPI4DMGovnPXo6h+G1YE3d
         dnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051563; x=1763656363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDXhrF3jmCsik0pVpflFinqzPLyBF5bBUKarlz+FDeU=;
        b=fcEaNLU//4Rk0JWMmTXlupfgII5jik3OjoeNIHar6dUnwnYK2W4i1fL3hRS+c3aj2Z
         njiCF8CUEX/efDxTSlfp4gyETsXt1wLGgsYHPqYuV1oNxxBUi24r/MZkdLJhEI2Jei8G
         Z4FcKlsINUL9ahvFynIqVNKzghhO7Jg/cBazmMyiGb+ETplwXl2oMvbKANv+lEH1+Wxc
         jQnWP9+6cG6VVJ+euXyRXuPffmTj62BpZdBbMtFwIurO0kCDaNdGpiWD2NFyUaucDIzY
         kjqW5WnfSltHvRAnzOhnJs9w98HzInbrTZ7neQC/XbfCE9zsPjLQqkQD0JHEiUVetDrg
         EM/g==
X-Forwarded-Encrypted: i=1; AJvYcCX/j1mTRHeyaL4lg0pCCDu8TADKXDDHQYGHNZ67bhij5Wnsbz5FuZIfqHB/4fLXTfVWaKjm5Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLsHG++EGh93S2YuGZnW9ewk0RO5M1SjVmIrkYgjIn8lWA1JL
	v36GCNoHUS7SqfVBQDxTzTecBHi00t3lxhq14eYsles+pmy5nMQCF4ZMwj2Y93iUhRk=
X-Gm-Gg: ASbGncv1XK/MCZjV9UWUQfDBlXiuSQmjQwql3Az4pU+sam4HII5jcKdnhXMMFy74Km5
	Mdx8rN7R7Hr2dj7C+UJcLZDvVmDj1fxjeQAsvvqrlgh96pYhN5Bnto/VVnjck0rrxlDV3WsLPke
	fAYweW84S2ZcV/DgDg4TgA+vBGdyG2WzeoXoYI+2JiFPEi0kpXPigYw8R1JXIMEMDC/5kC0Mfwl
	Jnbine94ivII9y5GyEYUIAtbZ1N8ek0NJp1UIfcO9dPRWYQwkvX1M5wovqUuVvS1tH+AEJvW1+d
	g5MFYroGwsmlK9mqO+dxAMcs/L+5KL9Ms04gaazN9a/Mphg4DoZjOlEbkSTwTTRp8apDIIEbpPh
	mp76Uz20AB+gzxRuMvi22NTVUNykOhx2LumWXtwVXD6EVPqqhXo4RzlcOlGeWK2v9vQWCJQii22
	tOOScJDTLEtItfqN1OhNiM5rh0jZsBPBrrjL+FowE6yeHHF7Q=
X-Google-Smtp-Source: AGHT+IEJSd77CW4XgrN9WTg1QdiwHG55no6Jxrml6vSOBqrTjHS8POZLoCMJXjaTuiRM5/WAf8JRVA==
X-Received: by 2002:a05:600c:45d4:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-4778fe7f6d4mr934365e9.18.1763051563085;
        Thu, 13 Nov 2025 08:32:43 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17291sm4707184f8f.32.2025.11.13.08.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:32:42 -0800 (PST)
Message-ID: <34c250472e36c5b506aed9416420d608a9b3969b.camel@mandelbit.com>
Subject: Re: [PATCH net-next 6/8] ovpn: consolidate crypto allocations in
 one chunk
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Date: Thu, 13 Nov 2025 17:32:42 +0100
In-Reply-To: <aRXhsFpwTEfne0vF@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
	 <20251111214744.12479-7-antonio@openvpn.net> <aRS13OqKdhx4aVRo@krikkit>
	 <7315d47ac4cd7510ad9df7760e04c49bddd92383.camel@mandelbit.com>
	 <aRXhsFpwTEfne0vF@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 14:48 +0100, Sabrina Dubroca wrote:
> 2025-11-13, 11:35:07 +0100, Ralf Lici wrote:
> > On Wed, 2025-11-12 at 17:29 +0100, Sabrina Dubroca wrote:
> > > 2025-11-11, 22:47:39 +0100, Antonio Quartulli wrote:
> > > > +static unsigned int ovpn_aead_crypto_tmp_size(struct
> > > > crypto_aead
> > > > *tfm,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned
> > > > int
> > > > nfrags)
> > > > +{
> > > > +	unsigned int len =3D crypto_aead_ivsize(tfm);
> > > > +
> > > > +	if (likely(len)) {
> > >=20
> > > Is that right?
> > >=20
> > > Previously iv was reserved with a constant size (OVPN_NONCE_SIZE),
> > > and
> > > we're always going to write some data into ->iv via
> > > ovpn_pktid_aead_write, but now we're only reserving the crypto
> > > algorithm's IV size (which appear to be 12, ie OVPN_NONCE_SIZE,
> > > for
> > > both chachapoly and gcm(aes), so maybe it doesn't matter).
> >=20
> > Exactly, I checked and both gcm-aes and chachapoly return an IV size
> > equal to OVPN_NONCE_SIZE, as you noted. I just thought it wouldn't
> > hurt
> > to make the function a bit more generic in case we ever support
> > algorithms without an IV in the future, knowing that OVPN_NONCE_SIZE
> > matches ivsize for all current cases.
>=20
> IMO there's not much to gain here, since the rest of the code
> (ovpn_aead_encrypt/decrypt) isn't ready for it. It may even be more
> confusing since this bit looks generic but the rest isn't, and
> figuring out why the packets are not being encrypted/decrypted
> correctly could be a bit painful.

That=E2=80=99s a good point, actually.

> > Also, there's a check in ovpn_aead_init to ensure that
> > crypto_aead_ivsize returns the expected value, so we're covered if
> > anything changes unexpectedly.
>=20
> Ah, good.
>=20
> Then I would prefer to just make ovpn_aead_crypto_tmp_size always use
> OVPN_NONCE_SIZE, and maybe add a comment in ovpn_aead_init referencing
> ovpn_aead_crypto_tmp_size.
>=20
> Something like:
>=20
> /* basic AEAD assumption
> =C2=A0* all current algorithms use OVPN_NONCE_SIZE.
> =C2=A0* ovpn_aead_crypto_tmp_size and ovpn_aead_encrypt/decrypt
> =C2=A0* expect this.
> =C2=A0*/
>=20
>=20
> Or a
>=20
> =C2=A0=C2=A0=C2=A0 DEBUG_NET_WARN_ON_ONCE(OVPN_NONCE_SIZE !=3D
> crypto_aead_ivsize(tfm));
>=20
> in ovpn_aead_crypto_tmp_size, which would fire if the check in
> ovpn_aead_init is ever removed.

I'll go with both to clearly assert the assumption.

Thanks,

--=20
Ralf Lici
Mandelbit Srl

