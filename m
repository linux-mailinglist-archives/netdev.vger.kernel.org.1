Return-Path: <netdev+bounces-225832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DB8B98C08
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10A84C3647
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C75528313B;
	Wed, 24 Sep 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnp4wJ7o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11C281520
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701270; cv=none; b=rrMzGWOCC5o2lLbxE5jPuYNoyHei6bfDT54hVl5NqeO2zbK7UZn3DU6/m2+8j1q7WFBLeEUs3yTM0PJ9UBNrpQ7jnC4JwzHAE4y0NW/IjG/1ugH/qH41rRpb3Jza1gr7x/xi0ewrVs//0D4FhwBLZESZFwZ6Aw1q6NtirXB0m3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701270; c=relaxed/simple;
	bh=CPJFhlS86lHjQ8Ti2XaTHsWA+1yz9pSmmfGw3hKwYcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+Ho4NIGVSidJQPKpx1nhTUoRA/tH1qNUVOflZVOP7CGWlm/l6O31cTJsmko9dFGR5OyHkF+LuGXMnlGOHO8E8+v1BUTRdrsfLtvF7Kp+wDld5XDVUi8LVkc6h9ktFh7az4Ltt45MNUm5Q73elRW4b0HFuoYg16EQLw83p4xKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnp4wJ7o; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2e66a300cbso499029466b.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758701267; x=1759306067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPJFhlS86lHjQ8Ti2XaTHsWA+1yz9pSmmfGw3hKwYcE=;
        b=fnp4wJ7opiJX1+q2nsrQptUKXzAnZRKZg4g8saYB/aUadbuHQV18LvkD45Krh3hDRz
         kz+GDpHiyI0VBc+MayLeOnRzjJ7IXYB6Pod2t8XJkOtQfa9qg82Z2JuP+RfPfnf/AiRV
         grH3iZPSRT4EEfNc8/2MZhihK9H/SqM+FC/R1IItW4+i38QU0Ct0Gmkd+ODtRhocuQHz
         ZnK2BRTNDWnEhz+2Hj7LX2agSpMjUgO3tvjUwCRCB9eO4huo5J4iqtcQ7Tz1zMHr9lUP
         1bIGafWHzsGQ39i6FuQDJxluLVIqWk4ws7B/s4sg+kYS1LNgF8vrYmfpLCRCUTj6H+Au
         +Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701267; x=1759306067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPJFhlS86lHjQ8Ti2XaTHsWA+1yz9pSmmfGw3hKwYcE=;
        b=pqBQzrlLxb8EZjCE72qaCMkH8m5RR+5zV0MxV10DeC8tp4buP1ILpOOFSD++qNHnmB
         53IGzjes4ZILtKLEhSioDyOUGpTROZIDIUrLWgnojFKLtTqme2hd6SCLwzoOMX0Xkk/9
         n/mIkociT5A4f2KOumil0kfBtMN3vQFeljEFwInZTVw3LyX52E1kytqLiqI69Cv9++yZ
         OWFCZMQg2dpPvZrI3PF0xle1q0pO5015+VBjFuBEt9LyNN1T5pfXSmjWXgfqBjO2R+Oi
         LvlVl7wGq2bSU5RU8qlMvpcNXX2w4A7/1fIcGCxV1grGu2vy6jyNjYoZE4Bcyjdu/eGe
         q+tg==
X-Forwarded-Encrypted: i=1; AJvYcCXvenwUKl3MjLcwKKv7tHlyDq57tKznTZ97liXQm9WI3s7qdfSr7H6HzXZpMhivUQsiLtwPGys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnGYXMLBYRo+R1PnBl9mjqZk0vGHIKJgGfD4zwR6aK9lC99y5
	NELSb2FgWv/eKUf2l7VFcC+q3Hh0Fd4DEgcf0hXyiF4arDhI5Jur79ExtpKUrvvHND4e6seGKz3
	ZUQUIgSe/ZL5RP1p0Q1KKcz9C/Jpujnk=
X-Gm-Gg: ASbGncss5cMVJqu+h9bJ1dfjkbT09vcmpZ5vDj5X74mHOV4MZ5u8sjCY47ZPGmNVPiH
	E3vIrM+7BUy6qCyRQoJMUXrHWpXo57TA4wiTK2D6W3YIfnsIN5bxU442Y+D2tW9Iddr36xEQS6s
	RHI9kfeCrqcG4ZZ0hkO2xkEA3TDteaB/uHKuCXx0CouGVsEwALDE8QeKcC4Y7Re9pQZCwfdfM/Z
	KSgFw4We7lSwle85JHyceysVC+DLNpy5+L0OflBZt+PaoP+iKQnQw==
X-Google-Smtp-Source: AGHT+IFWa4lkAHwf/4SArdm61wLTC4F7gQbf86GEjLZLwo2VefWv8FFXmP8OkTgdIk6qtNPTw6EZddqMonym0lxMhp0=
X-Received: by 2002:a17:907:26c4:b0:b2b:a56f:541a with SMTP id
 a640c23a62f3a-b3027260835mr530198366b.7.1758701266609; Wed, 24 Sep 2025
 01:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923022205.9075-1-viswanathiyyappan@gmail.com> <20250923164916.5b8c7c28@kernel.org>
In-Reply-To: <20250923164916.5b8c7c28@kernel.org>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 24 Sep 2025 13:37:33 +0530
X-Gm-Features: AS18NWCT-FjALMCOah9bf_auRuFbM1Q3yx9_Iw8e7RGCWur-FeBhqSVRINH2d0w
Message-ID: <CAPrAcgOzf4XYGA8X6TneRrmVwYVYgF=KvnpmRbT6XA+D9HR6jQ@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: remove rtl8150 driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 05:19, Jakub Kicinski <kuba@kernel.org> wrote:

> Thanks for sending this one.
> Based on Michal's reply I guess we need to wait a bit longer.

Sorry, this version breaks the build.

I will submit a v2 that removes the driver properly

I hope we won't need to apply it.

Thanks
Viswanath

