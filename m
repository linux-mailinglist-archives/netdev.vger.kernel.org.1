Return-Path: <netdev+bounces-152588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B39F4B24
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47A616EEC4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E01F3D54;
	Tue, 17 Dec 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHV8utAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16691D47D9
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439263; cv=none; b=WxmCBkMH9DzHdlPZSHgUrrBKnEPL68ao8eXB86as8dS9wluYorcWVptz/H8yiLCPeNKqwx4MDExgGxWHUy1aCMbDH/Aqdl7wENl0dvH4QMPyeu950XMExBjkZuBS2UeB5gINkUVXh7uEeB6iH3Z8A8OVWgs9PtIyA1kUD2XGCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439263; c=relaxed/simple;
	bh=zktOsVkVxxQOGMhkfdhIaNBA4MeCVA4pyULsaxoa5BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=no2hWg3F4Qpytkwctpx9pzELxyJ7EmV93JF2VkYSzwczYvSzDcx0bUayqPFwa/QWDvp4hVV/LX6X3w2j8rfmOv5vCVt9CgU8TY9jryhE/xaDjm3zq49hkRQLrwtln5FGBpwQRe5Kk+zBfttKVl1XUhe3cU/zOR3AvLKWYa4ewaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHV8utAr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so8910419a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 04:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734439260; x=1735044060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zktOsVkVxxQOGMhkfdhIaNBA4MeCVA4pyULsaxoa5BU=;
        b=vHV8utAr2ZI75QvSNUfVCuVmaBkEyDqsTYZ7eFQGZpu1w3Peey8HR7g0sk2NLAQavU
         BPfVX+OHbELO9oF6J/qb66qA4QGhTQZbA3yD4459MwGUC0PSr6XKzFcQXeI40qdi+wpI
         K62xWySC+dvmtWu7ZiV/7TWw3WtOPe+YSLIXAnoDPChuZQrbE8NIKQ53Ikt3eNP96iCz
         cGZayxOR0AcMf8CbIyja2Ux8A6mmFi3nsq2PvO9mKEcEt6bGwPoq/nald5Jhw04p3BZh
         ebhKWNKZR2rD4D5787GBRyrGAxQ4iK8hk8wndIZtVv+lVdcqfN7i3X27pJD63NsiM0rW
         o1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439260; x=1735044060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zktOsVkVxxQOGMhkfdhIaNBA4MeCVA4pyULsaxoa5BU=;
        b=mj7IvCbgnOzB7myoglA1adDbdGXqD5B0XS/ddCn0a5Y59TYOVNmqADKjPmxXUdG1vV
         Yn5E9WIZ2xMHiMVDI+L6q0rdyr4NzqXhN2M2uEhUHfrZnZuVv6/TPHtMNQhI3HVbpg1U
         E4BlCQpDhDfqWlcRo40RjdzRP3s6XbRHsqo0INktzdMAeSqQjFDEHkRTWdFFxv4HSnSY
         pz709BDFt7rDlMkAExz/NJiDAluqTk2sA3MI8Vy1ptZcN++OivnPvEenrgt23HssiJPa
         KQpjGZ2IHZOqHGsHBIJAFonrtTMaOLmEj84n6+kb8sw7Md2qxc+S07pxRHc27m2U2Rts
         HDXA==
X-Forwarded-Encrypted: i=1; AJvYcCUj3/RW/o0G/iJGgDyUYdPAA/T2b2y7mPCmoo4Gt7wObEhHHf5SnMCgho94+xuHXjY4YuGZKPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnziiBaoKei5EfA8xtZrX1Jul6kisXc8VsqdJ1Sw0IesbYgAD
	+5i0zhpXTFyUzWh4rcys9TXb2PkbzVUqkIq5xYSNeXJc45h0bJKqXzLdN2tAm2bF25b8muzYahm
	FkDXEc2Lk38J21VtZoBnTGt/dSIASMuobbNOG
X-Gm-Gg: ASbGncsg5X0Aud8bF1tyFPGUcirAqlWG0+ppWeeLNYhcomvdcvyuiz4ru67WwQus0Yj
	wgs7YN8vYVgvYATGeRCS2IQZLqOVeXIT1mFo/oxc01gnYsapU6FMUpNQvDdce2XBudbV+euz+
X-Google-Smtp-Source: AGHT+IH3mnMSz1W9u8JOiuZGydso9Cjd9kGw8eKTwmdRl9f7Hcj7+iXrFyrilZSWhlLyhDwpWe8u2Ky8DmHErNw/FlI=
X-Received: by 2002:a05:6402:34cb:b0:5d2:6993:ad91 with SMTP id
 4fb4d7f45d1cf-5d63c3da9a9mr13515477a12.32.1734439259961; Tue, 17 Dec 2024
 04:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217110731.2925254-1-make_ruc2021@163.com>
In-Reply-To: <20241217110731.2925254-1-make_ruc2021@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 13:40:49 +0100
Message-ID: <CANn89iJEE69y=Vi2c_2uE6k2Sb4bM+k+D+4KVfrR4QjMFK-7=A@mail.gmail.com>
Subject: Re: [PATCH v2] net: ethernet: fix NULL dereference in nixge_recv()
To: Ma Ke <make_ruc2021@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, u.kleine-koenig@baylibre.com, horms@kernel.org, 
	mdf@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:25=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote=
:
>
> Due to the failure of allocating the variable 'priv' in
> netdev_priv(ndev), this could result in 'priv->rx_bd_v' not being set
> during the allocation process of netdev_priv(ndev), which could lead
> to a null pointer dereference.
>
> Move while() loop with 'priv->rx_bd_v' dereference after the check
> for its validity.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Inst=
ruments XGE netdev")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
> Changes in v2:
> - modified the bug description as suggestions;
> - modified the patch as the code style suggested.

I really do not understand this patch.

if priv->rx_bd_v allocation failed, surely the device is not
operational, because nixge_hw_dma_bd_init() returns -ENOMEM

