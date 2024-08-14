Return-Path: <netdev+bounces-118374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E39516C0
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AB01F2481F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A41913DDC6;
	Wed, 14 Aug 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCmjeBUg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA913AA3F;
	Wed, 14 Aug 2024 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624777; cv=none; b=npnL9qAUN6FS+xT351ZadpAhSXr6NJF3PLrdb0MUNhNqi+/7RqO9orMwRPCSVOGzQBC1cSaTDoK7X/k99P+0IZhth0DWdSd8seKb3BvvUDBBZvops3f2A0wTMTp4pmvLqftM/27vbj5zYvCWZwfPMz+cT1JDOQ5/AQ1IxveXF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624777; c=relaxed/simple;
	bh=AOPlYY+8p8X8RIVKKr0X8rLqeQU38zBzWXGYpg7Y4h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2c5DTGhfLXXly+EmQ6uWyRGbtfI9ijrvhFCQpZzAazGBSEfrGh0Y8aBG5XE6qHrKiUYpBxM7tH3zzN9DHTtQx6qVRai4yZRK+IrF0GuoI0h0nrnwze8OZBvkOPLKXEIqf0OSLga/W62ye71pbirZ3urGs1ZnL93NIlecUyKdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCmjeBUg; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-824c85e414bso81730139f.2;
        Wed, 14 Aug 2024 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723624775; x=1724229575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqTdzUJ8A23uwIshPcAL1ToclT0WdBurmuB64ZXO01w=;
        b=eCmjeBUgT+7FXRwApdAz9OEFUpTrt/ela8mNNRn6qqGb+po//tMwDPJYjrTa0Efx8b
         1Wtk2WCRJocI/JX5tumTAgrJ9JQuf91V/1npq6yHtx1FG46aBZApPPVjdMg5eADwpgXR
         NV7YaZmhWzet+aPpXbzAH6rXxIeHS5CobZMWF7T5mvZkyDg9YZygin2Djiz1opsuwmNb
         VVwTanofNq8EP6ht+ZzTnJB9JHn1UPdL1o4aRbMBCMiq6hxHXsIgcVgGrr4oszLKJX1e
         ARB00QrVm/fxiIZhxix/Mn7MGlaoargZ+CedIYY58xmSUZVad4s7Lk7OAFJslw4ZHmdk
         z4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723624775; x=1724229575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqTdzUJ8A23uwIshPcAL1ToclT0WdBurmuB64ZXO01w=;
        b=pdc9sNTh0dNh9uj1CfBoBDhclcdlmyxXunjOYdApYdboVTsU36y9pDBBIT8d02u0mG
         eY/NhU5BIZYJanypX2rAO6zIaVWaXuTiffpkppjPt/ZKTiHVjtMeY8vNt21DOil01wue
         ClX0x8M1TKeQwprJ5cG7BW/x7IZ801UctXTN02NDoAC+mhMUdmNKknnniF+K2KeHCOTK
         MwJJ/G0mQHB4JLxQnTy/4+kExmk615ajATDWEGsPN22qbsxk6JE/qtFL8jK8B88vwB9B
         KmcPkuhMLg19UhqiJxQBj/Uv3I2txAGw4IZ21D3FlPMEhq+PO8TYezmkBRoAFs2Ujd0T
         AEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX5kwwj2MCEnLwQInCR4yWFpviaWMgq3/V2B7SGgbSdpEgu+VELF97sjlrH94+rOQwzgMUsqTED7gTp1r826wgR15HRJwVv73XPjCWKy9QZn7xfKzENlqmz3kosK0lIYtQ8PrW
X-Gm-Message-State: AOJu0Yy5trnLCEdkKMTRB5ZF+8kBCuZkgefPT0YUuU8Gd+cJGDhRDYuw
	UHW3EWSWmQZwCLM57DZnizek3G58rY9TORlA6m2Vmo5DmxxN6X1fhiEG/VAazkKyS0yYgBWgQHa
	cdIVDoi6jQ36M10kbQVNDAewiuR8=
X-Google-Smtp-Source: AGHT+IFNRgN/5ysYtwS08+Z6UJYR53XR0cvgT1/Bbf9cq6hRd0esfQmcKFE12uIRiyO88vnfkEOrYvnRv0jUeIvSIGw=
X-Received: by 2002:a92:c24f:0:b0:382:325c:f7be with SMTP id
 e9e14a558f8ab-39d12440c9emr28847195ab.4.1723624775524; Wed, 14 Aug 2024
 01:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812105315.440718-1-kuro@kuroa.me> <CAKD1Yr3i+858zNvSwbuFLiBHS52xhTw5oh6P-sPgRNcMbWEbhw@mail.gmail.com>
In-Reply-To: <CAKD1Yr3i+858zNvSwbuFLiBHS52xhTw5oh6P-sPgRNcMbWEbhw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Aug 2024 16:38:59 +0800
Message-ID: <CAL+tcoCTv_T8Q-sBFwR3+7aFdo3XVYS0hKaf5-2CpxRgDU-V0w@mail.gmail.com>
Subject: Re: [PATCH net,v2] tcp: fix forever orphan socket caused by tcp_abort
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Xueming Feng <kuro@kuroa.me>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 3:35=E2=80=AFPM Lorenzo Colitti <lorenzo@google.com=
> wrote:
>
> On Mon, Aug 12, 2024 at 7:53=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrot=
e:
> > The -ENOENT code comes from the associate patch Lorenzo made for
> > iproute2-ss; link attached below.
>
> ENOENT does seem reasonable. It's the same thing that would happen if
> userspace passed in a nonexistent cookie (we have a test for that).
> I'd guess this could happen if userspace was trying to destroy a
> socket but it lost the race against the process owning a socket
> closing it?
>
> >         bh_unlock_sock(sk);
> >         local_bh_enable();
> > -       tcp_write_queue_purge(sk);
>
> Is this not necessary in any other cases? What if there is
> retransmitted data, shouldn't that be cleared?

This line is duplicated, please see
tcp_done_with_error()->tcp_write_queue_purge().

Thanks,
Jason

