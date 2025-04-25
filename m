Return-Path: <netdev+bounces-186033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08E9A9CD5D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8AA4A6725
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA727A90F;
	Fri, 25 Apr 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAoe8llb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056E218ADE
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595723; cv=none; b=sCM7vYCFOUOTMAKukL8JXIxImOnADFoq/S/Gpt3jpVQY93hvCN9ZPDVsZH39BQCLS3EmwkvKQB89a8nyxrPxJMtsDI0XQkjvwLRbKA8CHodIgO8NLky7iE5P7Y6KIuNLpx7BanB3AI+4p0BDAzZkwU9/Oy9dujkrCl2MbT28Jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595723; c=relaxed/simple;
	bh=I26TWot4y7BtGP3AD2YOI7J6VeF80YG7GLu9eqiexFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpU+GOzmcuoxt6jPvLuZm+AJpIfXpyBD0GfghMoLDQcTMnWW/TgrkhZle58zabmNjHE0p8X51CdnnxjScgcuIw8CpSL6bIHWVdOkDW+8KUbqmf89k+PEI4ZOwQ+wQqahxmE/ivx6FpXIkGhWsml4Dcjv8M4P8MfiKvzMcHxlszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAoe8llb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so2171077f8f.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745595720; x=1746200520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I26TWot4y7BtGP3AD2YOI7J6VeF80YG7GLu9eqiexFQ=;
        b=TAoe8llbbrEzDtsrXYc3760UvpuphmKcX6lSUt0jSn9OcjRSl2besC2mhFc6mo8STB
         Sxo7UF6GQJrv0Vd2lww/S8zkhLwrkzZ2yBjQEFQq4zHqCksONix8CKF/PlC5mI0cEATT
         ORva5U05iTBXDwVxQNOMmzEDfCswjesz37G5Xw/8YUV1Cf6icOUHQWoH343o62ixyM+G
         QS1hAyKl8K3SX7CARIKin9bo/JmZtiku0esjWGcsdawHJLwiOr/PsZXS6SN3xgoizW7m
         ogFoZ1h2f5pMj8/s0bekXxqTfrZN5GOmvcQMUsUUrd6S5fWJIVETRteLGiI3WvKm0rW7
         xx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595720; x=1746200520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I26TWot4y7BtGP3AD2YOI7J6VeF80YG7GLu9eqiexFQ=;
        b=Q8XCLB2d3c1yI7F+q/kNbgMb1+gAJpxSENkdcbof8j2ANKMEGLNQE4MNzct1yIEc6n
         6mSOWojcTmOJebaVv/e2zq+JtthYOnlKsD9M6yACuYI8v/VfFzdaJMQF88Gemcs5zF+l
         WRM/QiwJJVUtlnqe4n+CtRFBuZ4mLq+jRIOKZu5PIHgnFPkxOx1yl2UQFcA7kL2gzRNs
         tryXlA5ITKqznfWltdUr+uJXctuDTt9se8kW4qwb/8eepk+HScEpYh7AVAJ3X4XbtdCy
         X7r+hNboRyUPHhXyQQoJaBL3/uFoejGx2BklSJ6XyvdGyCx0sKxxF+6AvrJ3/OPix6m5
         4kmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcc1tGzZQAbfEAVoRiH/IGNWjx7XiiOylfvrCVAWPaRBudn6y3HZJiF1RZxtRJUG4OSLGEcYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1cNmvtjsAq9ZNiN6B8R15nrjug8xzV9k4O0eO8JYtLdSf9qY
	NNEUMHncDUpFjV9VIbf7Bbf74FvaVfPUip+P1bhczH2Lat+HeJpJMt4H6dDWeOQgs2dgfAJEbPv
	dztEujg7VvreHVCnJXIu/qNG8FnrXbQ==
X-Gm-Gg: ASbGncvDk/34C6OY1HgHYSCUAyQ5AWlQ3tqxH61LHwzz44u5EYS86Mj/BzJ7+7LjRc9
	WSp9eSKfXXnsgSZbG8SWvOYvftTyaSRv/7Wgjoe7kXRvkSib3M1M3ux74IZYMKgDDrKd/l9lkve
	hNJ7oS/8qP+sPoSAZKCXi+IBHugL7Jb6DyO3YinCHGp6e4CLpt7QQli40=
X-Google-Smtp-Source: AGHT+IG+lYJXnLAPqt0Vn/xelUGLaKdNMHXxWwx9LFJNhTVcQsh6OjvXttWXW22C9gtvdIueQQZqGp7WOuk5iEDDyY4=
X-Received: by 2002:a05:6000:4028:b0:391:2c0c:1247 with SMTP id
 ffacd0b85a97d-3a074e0e4d1mr1989569f8f.1.1745595720112; Fri, 25 Apr 2025
 08:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org> <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org> <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
 <CAKgT0UfW=mHjtvxNdqy1qB6VYGxKrabWfWNgF3snR07QpNjEhQ@mail.gmail.com>
 <c7c7aee2-5fda-4b66-a337-afb028791f9c@lunn.ch> <CAKgT0UfDWP91rH1G70+pYL2HbMdjgr46h3X+uufL42xmXVi=cg@mail.gmail.com>
 <3e37228e-c0a9-4198-98d3-a35cc77dbd94@lunn.ch> <CAKgT0Ufm1T59r4Zn48_8gkOi=g0oqH5fvP+Gtxu0Wn9D5jNdaw@mail.gmail.com>
 <d2c690d2-d0f7-4fe2-9e8f-08e71e543901@lunn.ch>
In-Reply-To: <d2c690d2-d0f7-4fe2-9e8f-08e71e543901@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 25 Apr 2025 08:41:23 -0700
X-Gm-Features: ATxdqUHNKzPrefZVPh1kJSommD_kOHSHKSIckNg7z476T-KH8F-vsPucPjXcdro
Message-ID: <CAKgT0UdtAOU35YSdtvuzW-JbTjxEU45c9j+QVsckheQGdO=+oQ@mail.gmail.com>
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux@armlinux.org.uk, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 6:12=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Part of the issue would be who owns the I2C driver. Both the firmware
> > and the host would need access to it. Rather than having to do a
> > handoff for that it is easier to have the firmware maintain the driver
> > and just process the requests for us via mailbox IPC calls.
>
> How do you incorporate that into sfp.c? sfp_i2c_configure() and
> sfp_i2c_get() expect a Linux I2C bus, since this is supposed to be a
> plain simple I2C bus. I'm not sure we want to encourage other
> abstractions of an I2C bus than the current Linux I2C bus abstraction.

We would just present it as an i2c bus. Essentially all I have to do
is have the xfer call package the i2c request into a message and send
it over the IPC mailbox and then wait for a completion. It isn't as if
the i2c is anything all that complex. Since our operations are all
essentially atomic anyway we can do the read operations without any
issues, and for now we essentially just ignore writes to the SFP cage
since the DAC cables don't have anything to really write to anyway.

The bigger issues will be dealing with page/bank and CMIS when the
time comes. That is likely to be more work then how we deal with the
i2c. For i2c it would just be a matter of making sure our abstraction
we are presenting of the firmware interface can fit into whatever the
model is we come up with.

For now I can essentially just fake it by passing messages back and
forth to the firmware and caching bytes 126 and 127 so that we keep
track of what page/bank is being accessed by the host. One thing I
will have to double check though is how we report back a failure if
trying to set page/bank to an unsupported value. For now the FW was
just rejecting the read attempt as we had to pass data to trigger it.
We may need to add support for a 0 byte transaction to support setting
page and bank just to test if we can set them or not if we are going
to fake the extra verification step.

