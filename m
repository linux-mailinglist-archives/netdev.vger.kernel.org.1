Return-Path: <netdev+bounces-237691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C95C4EF05
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9288234CD13
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDADA369983;
	Tue, 11 Nov 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TICV6wpo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1F171CD
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877388; cv=none; b=p3TMoJ+69F+vcPTB6YNOGM/IF06Jqw70I8nFyChemVXQ3TNVt7cZtmj8ceTB+ln7ueIpPDfc9/VjsCTbDyCkZEbJ4K4SlY1CCrNtCmCIh0S4YsZLFlujAGpNWzS8JSQon8/MoT1Bvmm6odRq7bGC0zSo4m8EnD189mPgfrI035k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877388; c=relaxed/simple;
	bh=Lat0alu0FCTyIB7YnLHcMBkjYoJQOxvA1wa3KwFLGwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFT9g4RLSbPuATfYDiAkIELUbi3la5ebVsrJ23rmOPGkp3GrxXAmLTbQhGMePV+EHpJu1mIVMs5UxPWKPTCs9+Lg5F/YUKZSt3yKBlYTJzclSnKpZS1c7ieyBHLSQDI4Yb6oqc1VNFPvsL+lM5XREaLuigE52IKRLjAh1pUt1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TICV6wpo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b31507ed8so2715976f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 08:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762877385; x=1763482185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XtQm3PfaAtG6zbYvcssAPgrHwEtY1x9PZyboMkAD9Q=;
        b=TICV6wpocIzc8Hsm2iWDWzh8L7Qk81/0frY8b/qkHuySRM424htrEhpr0jQ6H6cGPx
         TqukjXlwSVv6tsuE6ojqE5/7oV+ZzPLeXbevZ9JEoizy4QsrKAn5bJ0LtTKloKU7ZhcB
         Q7123ekJonYeMGvrO2uTz8T6oUWPDHV0nHUkeGlRaXumQ1PDF9UVF4RS/CiZlag+Lsnb
         CqG4zh1xuXqND5Zqt6SPiW6W9aYXwuAkaP9W82Qj1dSXW4akWsrBNHsBFMtj/Z3U5C8e
         icYKVsfUrlGwNjG8NO/saXYy1S82rrolEC9DWnLBu4tdHQiEIC7SnpYTeY5D0bcjtbn2
         TSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877385; x=1763482185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1XtQm3PfaAtG6zbYvcssAPgrHwEtY1x9PZyboMkAD9Q=;
        b=q+RIMgjWsIbKa5HDy6wSPvLLiqJKob0+Fn6oCDeXmqDyAt4EcXCQPW+7N+zy7zmFCm
         qYXLYzQbovZIwWjRkL/B6MBL63dTFCCbbJZPr5LrhufnbLXtsTBTfjNhud0FjLDTj0TT
         UMb1M2tiIbcr4PET1FE3tFWTdXbeoxSTdCLoUAuiU8zFXb6gzm1oZufhx780gHDgeCeA
         N2Omw6ZoRmf/v0CMQRNS44ew4cDVaE73k0z6OL9uXvWIX9IAfl4oTPIzAcsbAc43IqSs
         i6+NaxALvxUIs/Md1C3zfIA80/fYJFv6748WPyGthS/cacxXRjN0d801b2efQMGNE3uG
         0tZA==
X-Forwarded-Encrypted: i=1; AJvYcCUYtowkSeIpzgM6bbBi4PnGqVm7gKrIqUi/Atg3WaMwz0L8q399vnzqOfYbZ6NUW86U1YCG+lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw094jk4CxDVT/dUDzIERxM6qBULSAWLHV9D+G3yu9W8SsHOsQ
	FO/8v5jr8k8lrJR9UohMLFbPbGfHcwYeXU2oiIZe3QUWUUWEVBP6cdccRDhQakdTtLDEGpTQTbZ
	QLtwyA5st47HCkxcI3q04Ouw84SBIwp7Wkg==
X-Gm-Gg: ASbGncu9i6KAC/Sj/vFUHfcZPCeLORsIJSTHmgJ/OrTj5+A7TgacWygrhmGehzaE3QD
	SFyV+AUu0dmXZgKN6yTyygNDJNrCpQt5RtT1PxAinLQSZS3QopYFHpPsMLay2RwgmRDHVokMpOW
	gB5l/5F6SQ5nA7bfg7iQX5ZeMfWutA3ilJgQKV+gfgFfLk7c9Zq0fHkyrjq3HkKc5+05ODGUEp5
	whYOvSUg/edaZIeFF6eOv58oPi2hphmWPquJHPKHagidEkjWulaXFd7vAZSivY8/nTH44UQ3aSX
	w3lq7Iel2Xy3eSbkXgLKnSWcPSv/FTRkzekBXuQ=
X-Google-Smtp-Source: AGHT+IE6baVU1hNEowIS7TbzM4CujfutlrL7adPdluMPO2r6XX7FXYcxeAUsh7o2UVGgbDtgZIz9T2grZg3swnQqdv0=
X-Received: by 2002:a05:6000:2002:b0:427:813:6a52 with SMTP id
 ffacd0b85a97d-42b2dc7f5ccmr11288031f8f.41.1762877385205; Tue, 11 Nov 2025
 08:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
 <6037c80a-ab5b-45ca-ae5a-31ded090e262@redhat.com> <20251111072310.5af24441@kernel.org>
In-Reply-To: <20251111072310.5af24441@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 11 Nov 2025 08:09:09 -0800
X-Gm-Features: AWmQ_bn6asCATMPjDzKG8DR5wMKlaaDNQKyOQ03FNf49S-0aYk0Stvcekcwdgqk
Message-ID: <CAKgT0UcUEmvn38K1JvtjUqirYpd6bi0Jh7B2nVgzFouz4b0ocA@mail.gmail.com>
Subject: Re: [net-next PATCH v3 00/10] net: phy: Add support for fbnic PHY w/
 25G, 50G, and 100G support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, kernel-team@meta.com, andrew+netdev@lunn.ch, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 7:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 11 Nov 2025 15:23:21 +0100 Paolo Abeni wrote:
> > Traceback (most recent call last):
> >    File
> > "/home/virtme/testing/wt-25/tools/testing/selftests/drivers/net/./xdp.p=
y",
> > line 810, in <module>
> >      main()
> >    File
> > "/home/virtme/testing/wt-25/tools/testing/selftests/drivers/net/./xdp.p=
y",
> > line 786, in main
> >      with NetDrvEpEnv(__file__) as cfg:
> >    File
> > "/home/virtme/testing/wt-25/tools/testing/selftests/drivers/net/lib/py/=
env.py",
> > line 59, in __enter__
> >      wait_file(f"/sys/class/net/{self.dev['ifname']}/carrier",
> >    File
> > "/home/virtme/testing/wt-25/tools/testing/selftests/net/lib/py/utils.py=
",
> > line 273, in wait_file
> >      raise TimeoutError("Wait for file contents failed", fname)
> > TimeoutError: [Errno Wait for file contents failed]
> > /sys/class/net/enp1s0/carrier
> > not ok 1 selftests: drivers/net: xdp.py # exit=3D1
> >
> > even if I wild guess the root cause is the removal from the nipa tree o=
f
> > "nipa: fbnic: link up on QEMU" (which IIRC is a local patch from Jakub
> > to make the tests happy with the nipa setup).
>
> Yes, let me queue up a version of that patch which applies on top of
> Alex's series. QEMU does not seem to get link up. I need to get around
> to updating the build at some point..

Yeah, the old QEMU is missing the pieces for the PCS needed to handle
the XPCS driver. I have had to make a few updates to get the XPCS
driver working with QEMU. Specifically the old QEMU doesn't report
link via the MDIO_STAT1 register, and the BaseR register was reporting
~0 which was treated as errors triggering reset.

