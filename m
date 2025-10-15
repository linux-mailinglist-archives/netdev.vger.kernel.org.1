Return-Path: <netdev+bounces-229687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A5BDFC5F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEAF3C502C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489C63376A8;
	Wed, 15 Oct 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtMWLhjd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A291E2834
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547129; cv=none; b=WWgq260w2SnDioTkTnnpnOCStbHo9vycZxevJTUlBq+8Ls1GRkjvm4CzzxN+j6hVmqaZZQkTSIX7bwDUJNLJvsIH5gpCZurGvM61DP/Oq7lnQ36ZNTM+pszRGK8qboAC3Pom+MQjiFuCzo7Yeb6Jl8yuwRFHtNyW5QWcIG0Djno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547129; c=relaxed/simple;
	bh=wbxUTvPZYOO+jnUBOwHP6vqN2Y8d3Evx6zjpDRrIqFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8gomlhrEMlYdBsvQoQoETTBrlajH8rdQN9fI5Ysbk6m1wSFR+vxSg0tOmyO8R8PEeyqIxmvOO2L+aGRhApytWgLEw6jP6ITVozbogf8pZFyDYDc4OGXx3ZB0kxsC7PRCQ4ydPYNVJAKFCECTON64y718lAcILIO8dPxcRuZy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtMWLhjd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b463f986f80so498381466b.2
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760547126; x=1761151926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=neLd0+dDQvDA5L4vv0sP7kK28bvW/poi2lRWCeQYViM=;
        b=XtMWLhjdHBLttzyRnOCk7fT64rZUtawKBK+fiZaUyhESgZ9m6tHtmI9JH2d4POkSRS
         siVFJpZuQ3KJM2dcTkF3oakGLjiYm1dyxklbPiw4zQuAIShZj76zxGDuJ3iQIzRz+QEy
         Ov6cjUJD5xUQ7CrOSK3Tg5+CsIX8wICe8y3Z3fUbTBdcGmxCNw0qweKuvBrskgBKBMm8
         8QZEryxebdFxQhzCZcMFhwbwS7VCK0bwtNaRrTDUymXo9H1qQrRWjEnGaCzetcPLU0rn
         Dxm8V7hkg9sO+HRGrv0+g8wWJRWTwlZzXbBi0NGqgo92OoPkRXyYp/vsHaPjc5Da9G+S
         UxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547126; x=1761151926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neLd0+dDQvDA5L4vv0sP7kK28bvW/poi2lRWCeQYViM=;
        b=Izf+yU4J8JpJ1LgvbYX581ce9E7w5hATyk+GmWVGnM1/c7PcnayCLpvsmV8efGTjjn
         FZ5QkZvnT2KEOWc+tkZLrAB0P2ZJZ8gDlPqdu/1d3NYUWr/tM9y401pHRzyBacLu+LqR
         vPFcqtBR/zvqEqKT5nCJb1PfGXEBsnXYRGSlNfHsUwBISdUeJUPZo5cp05mDtyp+4CpQ
         exDDUNT7ORdv937gVqTIMPmrH+6xnKhDXO2Mq0A4biFSE89sjM7jwpRQBARSmCD3j1ZP
         m95iBB9s3flHLcsIqrEaB9yw+s3yEduLFbEwSNwyB0mzVmH5H7cMuAelQtGecC3DvmmQ
         Mz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2O4iQX941TKxfSlyPq2MboFSK16x1q1tD+7qudJ78Up4WDEZkcjAV9AbzYA0lgYAo2TyavX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTPs/vP1GwoRnKQdZAhp/tu97AGwNo/JzH8/u1q9sOF9TJJYM9
	xXMQqb+fWMZNMDTJ4nRkbx9MJgCb04M4ipdDIlmHQm+vjbxlsxPtG0RtRwBMwP24PAaJGC0y8zd
	AMS1ki4EXj33pgn/RgE+0lOlpF77o5wM=
X-Gm-Gg: ASbGncvYL4iUo5EnKh73JhcYEMELKwM8qXRuO7LPfjK7f1+yfuSuRLyeBFw2qdJK8Ej
	httgR6ZE+KFlOgSpdF7N3Dgz1b7VY3bTfVsJNHOf++tyvSAX7uZ+nka9WZAIzss0fn6bZoMFi7q
	sgwtJGkg5w80FfqBzm7UT+AqXrqQYI2d2CjoAXo2wyoSLpZlgWmRPc7c5CIxype/UuqHI23dUgS
	bBwshdAeE7RsFGhmM27jxiy9w5bMCTIbHC1Dt8XVytu5UJfGYFm8Y4+S1hmW2NHh9XZWqMgyECv
	o/PjPfTRag==
X-Google-Smtp-Source: AGHT+IGsOnSPE3hz5ZfYzWJNVjtUVgW/EHP33IR6zBRV5g9gSsqBcciCEwgcZlf2wmO5rhi1e9vsERWWoOP5SCZzdpg=
X-Received: by 2002:a17:907:7f13:b0:b45:e09c:7e66 with SMTP id
 a640c23a62f3a-b50aa8a5bfdmr2998830266b.28.1760547125501; Wed, 15 Oct 2025
 09:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013181648.35153-1-viswanathiyyappan@gmail.com> <1adfe818-c74f-4eb1-b9f4-1271c6451786@kernel.org>
In-Reply-To: <1adfe818-c74f-4eb1-b9f4-1271c6451786@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 15 Oct 2025 22:21:53 +0530
X-Gm-Features: AS18NWA4RJCcpLPYd5taRLYmabL4v7fT9byYpjgnUo14PKi00TibSEE5yn4bNKs
Message-ID: <CAPrAcgPs48t731neW4iLq3d+HXEQAezHj5Ad9KR8EK+TNu5wbg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: lan78xx: fix use of improperly
 initialized dev->chipid in lan78xx_reset
To: Khalid Aziz <khalid@kernel.org>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 21:25, Khalid Aziz <khalid@kernel.org> wrote:

> How did you determine this is the commit that introduced this bug?
>
>  From what I can see, commit a0db7d10b76e does not touch lan78xx_reset()
> function. This bug was introduced when devid was replaced by chipid
> (commit 87177ba6e47e "lan78xx: replace devid to chipid & chiprev") or
> even earlier when the order of calls to lan78xx_init_mac_address() and
> lan78xx_read_reg() was introduced in lan78xx_reset() depending upon if
> lan78xx_init_mac_address() at that time used devid in its call sequence
> at the time.

The commit a0db7d10b76e introduced the dependency on devid to
lan78xx_read_raw_eeprom() and
lan78xx_read_eeprom() and ultimately lan78xx_init_mac_address() and
lan78xx_reset()

In lan78xx_init_mac_address()

Only lan78xx_read_eeprom() depends on devid as

lan78xx_read_reg() and lan78xx_write_reg() do not use devid

lan78xx_read_otp() depends on lan78xx_read_raw_otp() which depends
only on lan78xx_write_reg() and lan78xx_read_reg()
and hence doesn't use devid either

is_valid_ether_addr(), random_ether_addr() and ether_addr_copy() are
net core functions and do not care about driver specific data

The devid read exists in this commit (was added in ce85e13ad6ef4)

a0db7d10b76e was supposed to move the devid read before the
lan78xx_init_mac_address() because of the newly added
dependency but it was a tricky detail that the author failed to see

Thanks,
I Viswanath

