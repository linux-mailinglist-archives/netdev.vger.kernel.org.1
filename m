Return-Path: <netdev+bounces-130398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8398A5D8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7921C2090E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361E190667;
	Mon, 30 Sep 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0aMMRuE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776019066C
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704161; cv=none; b=Wpw2ertvWZzybBDWOk0mkocsFtTeMps5NyD+2RZuUHoeHB9p6tOzMpZUB6Q7RoYDhFes04bDwCDVHzKUz3MKpeXIhPLZuL+pX8TALjDWVkbjRD9blq8iU3aehuxfcFSL3uT5eUHDG70zxPMjLPW6NzcfeAZ+npcQKtHBD5qy3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704161; c=relaxed/simple;
	bh=iAY23aWOOsyJMUA/nWXdzD/Nwwn4NcYDh8c6HO9gb4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwLnn4C8Jksa3E2lqt+QHySdOYXEzkQ6uJtzsZw0JMFRtjA8iagyqZ39+zTSIsjMCbmdU0dxN03Ak2An70RH3DYVEIuW3M5a1EZqKicpVsj9TCXri2TpmxexrG/6LA2C9YyrIKyO0OH9FcI2iN+5c6fuMYELJkiD1ev3AZEvgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0aMMRuE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cdac05af9so2374012f8f.0
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727704158; x=1728308958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pynn0g74zuxrj7Q027m/zD65d/tO53+N2Y5wruDnGpM=;
        b=p0aMMRuEEXQlzLLV+nk6TcUWLG4wQcrub2zgDKTF1/JtArAgusLyhi2Nlbtgf4l5ky
         XD0rY12sCOzGo42660to/yj917kxmOyzf0GPa6w4II1gtYtSkATxPPwixtq2YxmzDn0n
         FerP4MAaGtlitfKN9MhCn/3BoQyLD3VXU0H0TcOJ/zaBHa43kyTqR4GoZYR7UprdSksH
         fXrBzmSejF6IUp0dlJncTqwqUUi/5EVyDJdAnj3qkQGjcHm5tXliN2Eqnhy9erwWhBzf
         0T3SVakLL3VvM6ytVFKm3UZhTLBp0vQBjTOEblkuvfizAT0T6zinYfyQmHrXoNZQDGua
         D7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727704158; x=1728308958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pynn0g74zuxrj7Q027m/zD65d/tO53+N2Y5wruDnGpM=;
        b=BZggQ4tzdhkYxOn9sALboXt2W+CX99PPAspo2U7jUAENPhJxOKlb4G3AYDIas3woxh
         dqrOtQ/NEC764wDpKqrs9ve0eU+6k9J1GSu1BoF+5KRvTMW9VctpqyaIwJqV11FuhlIL
         6CXfnPxmKyJeHv3Hemu3/bswjE3hztSLoWA2gRcDqjUzqfbtrzGV9y+5Je/n6AzIjMlc
         X+h3q0meGzTs+IONVMwvCMS2BHSAhVRvBabDfdkUfz9Wcvhg7cLwpPKIpQTEXXmvVQtJ
         Kp7eWXh5kknJzjw/Xp2CIeFcHtbnPGfZlwgNXa5hUdaPk0dpSKmw5ntN2AG2U+76NYCf
         ggeg==
X-Gm-Message-State: AOJu0Yxye7khe4RT9zL0AIWW2pfImQPtHSDHR6XMRzpPMtuxPqu85hv5
	rolygpXAYwFyTpg/NfB8NiHX2zAbhBTM3B6E7GDjI54pSSZN04mFp8r+mWl5nm2UyucqfC5fRtQ
	eDT3agYxOYrqxLG5rVj2M5LSpYdYPn+8SxWke
X-Google-Smtp-Source: AGHT+IFqHGRHxY83tqPMozKUpDAfuMhlx0eNb9UemNnE6JQ8ziEiZUjTObPYwXhqVAgAYDQy66MmoZ8RHqaRXk6suOE=
X-Received: by 2002:a05:6000:d0c:b0:37c:c871:e6f2 with SMTP id
 ffacd0b85a97d-37cd5a699b5mr9866011f8f.4.1727704157751; Mon, 30 Sep 2024
 06:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930134038.1309-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240930134038.1309-1-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 30 Sep 2024 15:49:06 +0200
Message-ID: <CAH5fLgjWZ+yBf6YgdA8e7BbRkzp9Lrf4OXPa92uZDp4jVc6_rg@mail.gmail.com>
Subject: Re: [PATCH net-next v1] rust: net::phy always define device_table in
 module_phy_driver macro
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:41=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> device_table in module_phy_driver macro is defined only when the
> driver is built as a module. So a PHY driver imports phy::DeviceId
> module in the following way then hits `unused import` warning when
> it's compiled as built-in:
>
>  use kernel::net::phy::DeviceId;
>
>  kernel::module_phy_driver! {
>      drivers: [PhyQT2025],
>      device_table: [
>         DeviceId::new_with_driver::<PhyQT2025>(),
>      ],
>
> Put device_table in a const. It's not included in the kernel image if
> unused (when the driver is compiled as built-in), and the compiler
> doesn't complain.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

