Return-Path: <netdev+bounces-170958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575ECA4AD90
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3E218963E5
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88491BD01F;
	Sat,  1 Mar 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRJrWpOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF71C3C18
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740858406; cv=none; b=BFz17vzuR9KRe63r2gg+Llld3+1aW+nfQHREbRvVU5GuTSd/xVeuk7NWd0NpzrDbpMaMsOY1OvlLGGnW+E0J7A8H3flBWAAF4PAfgZX7R3KssJHgU+Pjy2D68aqknK6KPWgKQ6pWFwzKuUbJhOLxm8rHNbi/IucXJpjNfAzjTdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740858406; c=relaxed/simple;
	bh=Y0aCW5z4PNKPKVssqHaNGy2TtOzfvP7xk/AK+EZRZqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kopUlQTw1fQ5jLvTKJnzrTE1fvz04XWhRD+Kl40u3/bSI0+v6nUp0VWQez+OjhUDR200MhmT6sper8dDDXgSdoC93YDtywkN5Wpn2IgXzleGHTo7ZdpIia6H0akOtULt8J6vOG+bDqiWW9aVOljX0vCxC6tTNoFxFgjgTr69syA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRJrWpOP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fd6f7f8df9so1817607b3.1
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 11:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740858404; x=1741463204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xDSMc7UpEutfjfsW4VqPr6kJcz1JqjoRHVEoP0/xWnY=;
        b=hRJrWpOPHCmWmo64j6Gx3Rt2Iw/CdvmRlbV9ZKEr7FsJTtI9f9erAlqQuhWzn9Z9A1
         7QmZAJMVpXddhC8ty0Jc5N6bWn25dbLpUM8xSF00gnX8546R1NXM52lxPsY88J8+R3pG
         02NGID38UY2HbX1b90HBMbCJimooSgXdrsDEqH7c38yTPJ8vSy6J495b48mLfph4IRhB
         Y4NICv+K62JHNOz2zTCuQua+5Hz9UHBZvYRIQQHf/D1Z71YUc6pTsQPz3Z7Tb/qbB1q1
         qklKXs2XA+rovU2EA7ywidLU9W4zx4vU1kWgVlFwoUzYLsCzBOR2d1zn2YHB8geG3Dlk
         omrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740858404; x=1741463204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDSMc7UpEutfjfsW4VqPr6kJcz1JqjoRHVEoP0/xWnY=;
        b=W869CnoX5f+NSxdo6RJqJPWQo1cCVreoRddM+LjZQ9nYd1QTVvXWwiFs+IFjiKNIqG
         UwBGmYnoEl78xzAY8LZX9NsxzD7JBcC56HRbRlkAGZUatITimcVTSBokn3eDXWo5Nb+I
         UXwTo7p5r9p1mFy+qGdAZiVj/id8h48A+T8sTt7PjwDoYE4toCZGMP5KKhjnI1BKNqPN
         EzrRdTvAqDZbk72kyMuzUOtMvVLjERjv2uUwGzPNH8uaoUoksTLacklZhHrqarm0ZlDv
         0tBBniibYDaI/rLbF/R3EmfgbLtyrQQcQ0csjUvgBCDW09S426xD61JbOvNtjEwYAozp
         2SgA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ycg39eFholSguTxqYvKinzsczs30UHdBrABdI1se+E9SPk3KehdBa7pRJdnizt1XJ+Q+e+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+snWg3+/0Ft8AVMgTScpn1kiscOPAmFZOLjrbZvO6Mk4UYS6
	JU0DeARtVOKuaWsUjGWdTSXZL+e4pssR6nyHBNFZ5op469O6TpZRwuKPNjdLE7fU9ntPO1M0p5a
	1LVjG/V6rG97pcQYs4XiL66Gq6g==
X-Gm-Gg: ASbGncuKB8JXB1CjtuzuBX9g1t/NVIBBoXtupZELsV6eYv1SCuWdyEkRRJu8qllBsbT
	T6IRfzM+z1Ioow9hSu4Ntg5DrtjWiFes/hlUIvBoJ6uJdIL6xE3gXxMwUW5cjJtcMF6+mp8R5gR
	63lL4geRS7pVEei2fmPwE6fRUZaDCvOAfCDxtfpw==
X-Google-Smtp-Source: AGHT+IHMNSUCxYkro1Gd3x8r6+IC0r/FekZK0XywzSW6nv2kBM79qVs4Ye/DFbmOIHBDEjkOyqJJgkaUyhMKHGv0RlE=
X-Received: by 2002:a05:690c:3001:b0:6fb:904c:d9c1 with SMTP id
 00721157ae682-6fd4a239491mr97191897b3.12.1740858404157; Sat, 01 Mar 2025
 11:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228173505.3636-1-rsalvaterra@gmail.com> <ebe829ef-342a-4986-975a-62194a793697@gmail.com>
 <CALjTZva9+ufCR5+QhJXL+7CHDRJVLQqb4uPwumEO5BqssGKPMw@mail.gmail.com> <4c9c1833-0f5e-4978-8204-9195009edb33@gmail.com>
In-Reply-To: <4c9c1833-0f5e-4978-8204-9195009edb33@gmail.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Sat, 1 Mar 2025 19:46:33 +0000
X-Gm-Features: AQ5f1Jrk2cyQZYPRVVSnSyv1ixOgEaSP6QRd9IdQNtAfgBO5LiqnBMpO7llSPp4
Message-ID: <CALjTZvYeKG=VdOg9XoJEfCXVOLd8mBWnk9xqYOOSOG=1wC9M9A@mail.gmail.com>
Subject: Re: [PATCH] r8169: add support for 16K jumbo frames on RTL8125B
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi again, Heiner,


On Sat, 1 Mar 2025 at 14:12, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Depending on the kernel version HW TSO may be be off per default.
> Use ethtool to check/enable HW TSO, and see whether speed improves.

I'm running Linux 6.14-rc4 with my patch. Output from ethtool, when
the MTU is set to 1500:

tcp-segmentation-offload: on
    tx-tcp-segmentation: on
    tx-tcp-ecn-segmentation: off [fixed]
    tx-tcp-mangleid-segmentation: off
    tx-tcp6-segmentation: on


When the MTU is set to 12000:

tcp-segmentation-offload: off
    tx-tcp-segmentation: off [requested on]
    tx-tcp-ecn-segmentation: off [fixed]
    tx-tcp-mangleid-segmentation: off
    tx-tcp6-segmentation: off [requested on]

Which means my test, with a MTU of 1500, was already done with
hardware TSO offloading enabled.


Kind regards,

Rui Salvaterra

