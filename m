Return-Path: <netdev+bounces-216510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B17B342EA
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCE716810F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E92F6593;
	Mon, 25 Aug 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kegO1Kg7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7E2F6572;
	Mon, 25 Aug 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131338; cv=none; b=CGYRnBMFMkdHoHxtkxyik696qCZRorBYfebMA8CBerWYmPIZ5gl/1x1jn7ZRzurgohs4bg46Na/jJg6w+2WHhxuz8XniYr2yFpIlq2g/XNy941VKcF3LdwfgZI+lpbjUcY9cEoFdIhfyL+jVRhC+XWbG6EJRl7WLsVlEy/NwuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131338; c=relaxed/simple;
	bh=lPbSBg/HZD4mkzSOvmio9GUHRaKTggiGyiEtzltqpl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE6h56xMUZqEZyVtHDvHL/D2xs5n31k0+/aM1LFDYX2cpo3rtRWJTRoMqY8/nXNrQgGs09JcQqbq1uoWFhWZ0ssszImmdh0vOVA7CtLdsOOJ7jbsru12trUTSDDJvV8fc8rSuhzlnRDTAViq0kUxXnCyVSZqJpe/LA3RNXDTB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kegO1Kg7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so304401a12.0;
        Mon, 25 Aug 2025 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756131336; x=1756736136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPbSBg/HZD4mkzSOvmio9GUHRaKTggiGyiEtzltqpl0=;
        b=kegO1Kg7P44nbbGE6x09NGxE69yhGTyRQuHPq3gJy4rZRwzEuK2l7iK2D/hGPWmspF
         b+i9CzzkCI/HhA1Ks17ItItMVSBqfbcEl2Onume7BQ4Ofln8s5oMESoal8oMM9UirqyQ
         KidZ7F+VZz7z+vRWN976vg2elfE5l3h+/eeDul/eA10GWP4i2WENdNyoMrg/Cxc0PDqD
         6Z+2peYmkxIzLfl3CXjiEiOMOaYPY7O31LHxw3BwJTC4wWMapLCqWgo5P+s2G/JYZObo
         zMXoWUL4b4IfM1B7LweOM+vVH8L9KOZv1kb/VGAPMXjJ8FhXPZxIRyAfUptibs+h86kJ
         mSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131336; x=1756736136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPbSBg/HZD4mkzSOvmio9GUHRaKTggiGyiEtzltqpl0=;
        b=iqC0Nt11E3AK/88NZwxOyc+LIbLWCtD/QHkN/a6V8P3d9MGoV/oKe1joeYksaMplhG
         XXMDUC771MC3DVjiKJUpW44Ffj95CvLdEQz+RRIlc2QyTTAHEBayhyQk3fRw5Q1YUyYz
         fx0JJhzWgkIyjIkwrWozSvgAWrIt/zWoqt1OaxtsKg/QgeK7eGyZsH9QUC08E5NqZ30p
         FpTt7KJRg654eFp7ej45ibYrgHiNOu4B/nR/ZDtjUP6PrVCPbPixls3lvFTq6/DMZoA+
         FjPTigeF/RxxSkRUBMmEY2OSFMUc2W1XIlrLeGfLvamfs4B80ej1r2I5AnAMWWtHkfFN
         AmJg==
X-Forwarded-Encrypted: i=1; AJvYcCVJABBPwhnQywlG/ESFgvJMtY9dUN+xqLQUsqImNlqlOUKVY7m0F/V9QvbfCo/xkfWlTnhxZ9qk@vger.kernel.org, AJvYcCWiXn8NlCaHyx5Fo/Jqn18F9jB4JryJkFvjABCPq3mM2ZSablhACXO87rg9lIMeQFXAhS7y5KpD2Gj2@vger.kernel.org, AJvYcCXLsQKtYm3ma3Vzcq9zCJjcIrbxLySwI1qYaVZL4TStV9XJW+94pgbyrcNkBZv71M46OoY6Yc+UngnRIshO@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdzLN5O9w2n6JHtH7VoufAFdjR5of2GqlAltTtgeihkrwtaRz
	2OKHaTNbuGWI7nZKljF/qyM+2qm6rhQ0+0SjJcqRwAGoh1ep05D7D0FzA1ZCfYO6IvkH/zAOtjo
	FYimof2QC7pkr3G4kv/nPSPLXQCv1WQk=
X-Gm-Gg: ASbGncvDS1dnu6g/Cu5bf6T9c+QFLRD/imF3Y3J9yGtOcfOxN6pbqsePgXs/sAnSKFZ
	pAq7IIjUKBTsyWLe34RAtkmOny51AsRWKS2M0Gmedu6mHgR7ICAv4cUBdW3UFZq9ci2gA4dQL02
	EeieGB0WugvRUaG3zf5yzvjS+5tCOAGA+PZoz6ozdla/5pqL1TmT0Pm2EQELfVmRkRXArUKxBPA
	BBNhbRb7MFf8h3vPGZHm1vc235Q0v98LcTn0hb0
X-Google-Smtp-Source: AGHT+IG9xxdJx93iYDQX/6SZ6WjyjVrCHNliEzb/AcDE2CBxa/sVl1b/VT2POs8qj5NrrwdFtcJ93grxcdcul8ysWPc=
X-Received: by 2002:a17:90b:4a81:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-3251d49713dmr14093421a91.8.1756131335631; Mon, 25 Aug 2025
 07:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824005116.2434998-1-mmyangfl@gmail.com> <20250824005116.2434998-4-mmyangfl@gmail.com>
 <ad61c240-eee3-4db4-b03e-de07f3efba12@lunn.ch> <CAAXyoMP-Z8aYTSZwqJpDYRVcYQ9fzEgmDuAbQd=UEGp+o5Fdjg@mail.gmail.com>
 <aKtWej0nymW-baTC@shell.armlinux.org.uk>
In-Reply-To: <aKtWej0nymW-baTC@shell.armlinux.org.uk>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 25 Aug 2025 22:14:58 +0800
X-Gm-Features: Ac12FXxbis4qzSLpapWtF5EldTFXL44GkD5DDrIiURWKiYRn5HHmlminAhIXoBQ
Message-ID: <CAAXyoMNot+aZ35Xtx=YiTEmGk_c8XT7VGiQ-DUn8T1vPUnO-9Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 2:14=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Aug 25, 2025 at 12:38:20AM +0800, Yangfl wrote:
> > They are used in phylink_get_caps(), since I don't want to declare a
> > port which we know it does not exist on some chips. But the info_* set
> > might be inlined and removed since it is not used elsewhere.
>
> The problem is... if you have a port in 0..N that DSA thinks should be
> used, but is neither internal or external, DSA's initialisation of it
> will fail, because without any caps declared for it, phylink_create()
> will return an error, causing dsa_port_phylink_create() to fail,
> dsa_shared_port_phylink_register() or dsa_user_phy_setup(),
> dsa_shared_port_link_register_of() or dsa_user_create()... etc. It
> eventually gets propagated up causing the entire switch probe to fail.
>
> Again... read the code!

What would you expect when you specify Port 0 in DT when only Port 1,
3, 8 are available on the chip (YT9213NB)? Probe error.

