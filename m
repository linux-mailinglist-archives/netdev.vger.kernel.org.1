Return-Path: <netdev+bounces-246219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC839CE63CD
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 09:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F5E30057F0
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DAE2773FE;
	Mon, 29 Dec 2025 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnpxziOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468552773DE
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766996827; cv=none; b=NBxgU/EJVc1PXRZ4HrGIMIGXHFkxxfFkgdCWMDXkTKV8u8nsvWJLH2NEfaxq1r3N6X8PQ+qlwrx5lxLvlVDDUyX7IVOTUrzpfT33ltKYJGLO14XPqH08ZoO46njDvpepSHhe+iy65S4MwPvuYji+pWGxDs9xZiO9iKJtF05w/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766996827; c=relaxed/simple;
	bh=647lf6VAVNPo4jbVzfdbUjVKoklGensiXVWXiHUHlq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KO7q5Z+ov10sIWQzwajXWTf+cF9b3nZCYbut62PCASuhCAu9Jgeo4eOTqtNr2mwjNy/IPRmXGhi8DwUL0PSiCj+XnlEmk8TPO2AKPvttoatp/w0AZuHfWN8GxUV5hRYUEP80m579DW781lBDRUIIUE+RjLnBaQI40ZN3NYBuDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnpxziOS; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78fc7892214so59288157b3.0
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 00:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766996825; x=1767601625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=647lf6VAVNPo4jbVzfdbUjVKoklGensiXVWXiHUHlq8=;
        b=KnpxziOSAHBmLgvgX9ZxwuBUqM5NAQZDrHTJeNmcob+Tc5K+CeadgTT0JygKY48eVh
         6vsvI8i+QoVtfO9s/rEUt6yPUN6Fyq13G2EYGWLGms3ToEHe2tSp4+YwGFuBhS9NdChW
         AT6Q94JB99YnH9c57FObNW0lDSmFMj2zWvMBfIUC6q95iaNUE4SJIB/jtdg26B01pe+7
         XpOiiy4lYhwYV4loSlhdO7n5go92ivNwz67DUUvbd+VvTIzDLE0m1klM4gNi5MSbZVJH
         N1dMP4SVMuElV8ggrZQDaJsNW8g/586r2FPiqRheyIc2LCDX5MiL/CIhS/lEhQ2Bj6T4
         2kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766996825; x=1767601625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=647lf6VAVNPo4jbVzfdbUjVKoklGensiXVWXiHUHlq8=;
        b=Lsjw0iussKs3ljBfya8Z/B0mBKdl2WUgsghJxGoKwYnGI2jkyva8H06icyss3DFko2
         +TDoN//9oOXrQRGt1T/OvRph7y/ctEcO4PB6jOLFUFsQZgX284KYGAB1lXpz6O+laMk3
         9k9FNOyXCl5oLWbP4Sjo729hThVGsQlCNxbhRO+WLXO91xng825F73pBOm8AV1sNvcN0
         NICk3o9trL7zv4HrboMRZIQbWPU8SX7Cb1Ik6oM5mDNbvvOt48V6p90dUcMqCzczjoHf
         nwxKRpSeUJJulJTI77rg/OvxiBzT4+w+ZvfeC/bjF/f3oMtPqht+0JZ7oG00UICXJTft
         eUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW40rXVPtNCOvqo0jEueHaQu91I6zYH1vf1OHJu5Jf3ZR9RElYgFgf/FeREIrWMp7Jia7gYX/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH28qzh/8mVxetVTxHYD8goYgy78yUiwtWrVo67NaYKQ5AFINU
	+DXWFkigui1hf95lUhPU8DCruNV3f+sBgNmJRtrLnIPudE/v5KKS5neRbeRKnh81d+/9mZVjh7W
	qp4Dt/dCJVVp9Mud+FtekDoo02qRQ+zU=
X-Gm-Gg: AY/fxX4iUCT2SDALyzC7m7BNPm7gTcIsKuNwHDLhEoVGIk7yFhL59AmrTdj+5mhPtLt
	RmZZkz5LPbpzyLYUQlNt4/aGuIoHKE5WAHNAjWrr3X9GXvDPxx2CiMF8IhnZ76i+F6Ue7UPErU4
	ZqqyWpJ1223XJuO9TfYeT74zofeC++mC4MAZijl8UAz0tbteVbTpT9W1EU/YFjPHkQU1J6UWthz
	zGolXyDgTIk+i2/sjedsdvtU1yhXa6r3s4VuXQ2C4bXbS1Tdm5v5nFia3o9pQUPXhZ2vA==
X-Google-Smtp-Source: AGHT+IGIQQcH5mNwxfSDnao5taaZa0gRxpMrP/yINzuIEXtXq6e3QsmBdBwE5LDPxyp9Zf425NdMl0WTr4ufVZ1V7p0=
X-Received: by 2002:a05:690e:2556:b0:644:5363:a9d2 with SMTP id
 956f58d0204a3-6466a8bb654mr18503497d50.71.1766996825266; Mon, 29 Dec 2025
 00:27:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217205756.172123-1-jonas.gorski@gmail.com>
 <0be6849b-e309-4131-884a-7b352db6c599@lunn.ch> <3870b562-c05e-4991-8060-826ea32b0e95@redhat.com>
In-Reply-To: <3870b562-c05e-4991-8060-826ea32b0e95@redhat.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 29 Dec 2025 09:26:52 +0100
X-Gm-Features: AQt7F2rLjUSWmmujsBismWEjfFFOXnGG1RIF8ndjVNky9bWo5Gng1Aa5B92945U
Message-ID: <CAOiHx=mrNO2-4p8OMEcDc64PBhXH-4RuTmqyj5_nb3UWWcCeog@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: skip multicast entries for fdb_dump()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 5:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/17/25 11:00 PM, Andrew Lunn wrote:
> > On Wed, Dec 17, 2025 at 09:57:56PM +0100, Jonas Gorski wrote:
> >> port_fdb_dump() is supposed to only add fdb entries, but we iterate ov=
er
> >> the full ARL table, which also inludes multicast entries.
> >
> > includes.
>
> Please do not resend just for the above. I'll (exceptionally) fix it
> while applying the patch.

Thank you, I completely forgot about this over the holidays (and getting si=
ck).

Though I also wasn't sure if a typo in the commit message warrants a
new patch version; I sort of assumed this was more a "if a new version
is needed, then fix this as well".

Best regards,
Jonas

