Return-Path: <netdev+bounces-224509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDEB85C21
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850E9582178
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC111314D1D;
	Thu, 18 Sep 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmQWrFwa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22913148CC
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210310; cv=none; b=JrpLi9GCGymcQMAfUDiRJoN+SqAlovu/vbSB9EzDl6bkxLgFNe174a3pO/xVvdB9iHLs77+8tJHuzzWxSEvL9EYIgeHCIGBB7ODa8vADQiOSWbjv/VFa+bIK3Tj/Hvc13gHZi41i78UWzPgcds5N7wTZ3YMwfDuvYemebzHSv/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210310; c=relaxed/simple;
	bh=fmWHKTD0HEp3v4jAbafgMjtiPh74qcGGX1DEtLNknfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovkaym8ohxNJcAEd7DqfoETIrA6X0mi2FbQ21ykvd3/MkvceJZtlshkMctesFFTNyGLcjeNe2Awfyi2Tp2HkHVc7v/chPGVeTRqAF1NNXxWO9kbXGZkdCGak8iPDlHx8S+L473wnmmBKHPiGFr9xNeqNx2vMboygr+rvcokhTk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmQWrFwa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b046f6fb230so231607366b.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758210307; x=1758815107; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmWHKTD0HEp3v4jAbafgMjtiPh74qcGGX1DEtLNknfs=;
        b=SmQWrFwa7DOmbmqdCLwoO5gF1gy5JJLlvihxkgUtQ+WbtQUm6wT31dBa4WNgM8o31G
         yKLyDm2QHBWbGND5VdcLRj02hz/ufyWiz1RZJKJW8NJuZ2RXT8JNXtNBN9ikacxd4ibR
         UIKeQOxaTZwTcKPSK8+m6Bx2XIvTsmNyZHfo6RwTSFgcFGALgUCxYpbWX9BkVJaRUmCK
         4iwxzIKZRm73JLY414z2WlQ8w7KPj7+z8ZVF+g1t5VcIr5XnxkWaJEKmkks1+dATaOX3
         ouV+R6c/ZHJj94WjUnqi+HZToKHAIVf+Nwq7yZZhZxpIFxIfZWr8vh3O1ajVMCqR479I
         jXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210307; x=1758815107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmWHKTD0HEp3v4jAbafgMjtiPh74qcGGX1DEtLNknfs=;
        b=qL1dOJcfOXvAF0nU1RcPJmxAicJ40aAoDmPT+ZDAtsSVO522KJ06fjxCj+QB5aNdsz
         whWZbheC+KZWmwPdf2Wd4G0h9X9GR2bLNhmucJSdd3+9PjVTx4oNHvOFgV7fuPO2M/KT
         4Z/Vmhki/nbQstpVnH8il7hDwMkSIWrF+c9aDzCo+SGVxMrhLFTaPxcKdf0hVYOKiAWO
         a4pBXGwcSckcHs65AdEBYLHQntNHeehpSmBsgpvrdb4kJr9gA94z7pIi/Y5uZrCBsP1O
         HsOjdKFDRg+DugpHPrdOqFMpsPEo1UKNkzQjYPmj9xBVbwr6HjSA3NeynWmv+K+bRaT1
         EPLw==
X-Forwarded-Encrypted: i=1; AJvYcCXRtfc0rePaKtqRb7+OSt7ot5p7CfQx0pnC2BJOsz+mB4bqMJ2bGyON5mNJoeiWsZMjwO7hRrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9ypBX/LT23xf3owewARNPnXq+gPn4IhdSmY1LCRIoHXJS/Op
	E8Te2JcWaG2cPtO6PHBVKhhc2POqzqQMkMaPRKlVrBwCH9pYiH6slWNP
X-Gm-Gg: ASbGnctQ4fCatN4hDp1SlvNDBQnjRz5I3l87VC7hxH9Iuje0nslEIpYkgNGwMHDOYHi
	0bc+5PtUWNLkRXmYC8geKD3llNrsh6VKna7HQ8ToyjFCyRXSSO3SxJTwhasAF5ZupYwTFGiV9FI
	BL4OrmLI+MUbuV/YWkgDreS77pBb+tRZsJV9U5PlG1Bms/Fw/N4/TOUkz1q6Pc0tRID/1d5s/27
	QpVRo8bp35wD7MSEJlSNYOrwmfXsNhr0zgSBxlYUi35gYWhhStyaJeL/hWoQR0QvQ7L4o2cw4/S
	oWJefqNt1UAjLk4VEH3DTF2i2uEAg148XW+xTVceQAxNyslChRIXIulwAhw4093kh9WzKFu/yur
	0TmDZE7JA0bBfz9iBL7HyC7aQbJagrheXhAh0TxYke8gVOVK4yf4/PsYImCys25Panp4+
X-Google-Smtp-Source: AGHT+IHhJpUJxm0JBqQPK1WWHMUOmGprTfN1qsQTFyUzj1uozoUmCz9sEIlUOLodf6VL0JxH0gPMWA==
X-Received: by 2002:a17:906:c150:b0:b04:3402:391c with SMTP id a640c23a62f3a-b1fac8c89d8mr401452366b.24.1758210306797;
        Thu, 18 Sep 2025 08:45:06 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc890cc98sm218393066b.49.2025.09.18.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:45:06 -0700 (PDT)
Message-ID: <869d0cd1576c2ea95a87d40e6ce49b97d62237c9.camel@gmail.com>
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alok.a.tiwari@oracle.com, 	ashwini@wisig.com, hi@alyssa.is,
 maxbr@linux.ibm.com, 	zhangjiao2@cmss.chinamobile.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Thu, 18 Sep 2025 17:45:05 +0200
In-Reply-To: <20250918110946-mutt-send-email-mst@kernel.org>
References: <20250918110946-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 11:09 -0400, Michael S. Tsirkin wrote:
> Most notably this reverts a virtio console
> change since we made it without considering compatibility
> sufficiently.

It seems that we are not in agreement about whether it should be
reverted or not. I think it should depend on whether the virtio spec
maintainers are willing to change it to agree with the Linux
implementation. I was under the impression that they aren't.

I will quote some conversation from the patch thread.

Maximilian Immanuel Brandtner wrote:
> On a related note, during the initial discussion of this changing the
> virtio spec was proposed as well (as can be read from the commit mgs),
> however at the time on the viritio mailing list people were resistent
> to the idea of changing the virtio spec to conform to the kernel
> implementation.
> I don't really care if this discrepancy is fixed one way or the other,
> but it should most definitely be fixed.

I wrote:
> I'm of the same opinion, but if it is fixed on the kernel side, then
> (assuming no device implementation with the wrong order exists) I think
> maybe the fix should be backported to all widely used kernels. It seems
> that the patch hasn't been backported to the longterm kernels [1],
> which I think Debian kernels are based on.
>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log=
/drivers/char/virtio_console.c?h=3Dv6.12.47

Maximilian Immanuel Brandtner wrote:
> Then I guess the patch-set should be backported

After that, I sent a backport request to stable@. Maybe I should have
waited some more time before doing that.

Anyway, I don't care which way this dilemma will be resolved, but the
discussion is currently scattered among too many places and it's hard
to determine what the consensus is.

Best regards,
Filip Hejsek

