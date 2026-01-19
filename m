Return-Path: <netdev+bounces-251207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB86D3B4EF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E1E3045DC0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1474729BDB4;
	Mon, 19 Jan 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkwg8RUx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0C224AF0
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845313; cv=none; b=t9U+mW4IrssMbxAqqMzscsr+8pPRMS03HrpNB3bA9VOZs8QJyIXKOnlKkeTPoNFO1//Ous2coiGrKUyQ7YSH1y5o7l4YLp50tv2H7icpihFCVUhe7TF4gkpa1B9/SlJ0R9BBIx09zAHxQlqy9Rf6enpea7ecQ1dLepTYFd4uPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845313; c=relaxed/simple;
	bh=78apE6QDQFXHCk78vSNGl4G1wcUc/cubI9J+4istziY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GsbhKDMoekEjZ14M0YXQDcHPwC0boI4C1sPOTwBbTE/B4+VpRRTphbh6XrqqVuC+aU/G/3DsLhqLb13E5Xg3RnGa5a00tlSw5FGCdSp0CO4iCBuIFaszF7DeHlpXF9o7aMb25foPLyDdGDSqtGHwVka7QjsrbXdhvHhbWw/rbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tkwg8RUx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432755545fcso2546161f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768845310; x=1769450110; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGYHe/UIiw9sHb9OX9ESyD3Q3OvR6ABMCUV+kc7Ihrw=;
        b=Tkwg8RUxjVPvtLa44aeeorJUrak56I+quGqW4wo7E/OIP9XQ4eUTYfX88nvsHkAaUN
         d1cUcmoBPT/8+RMm3M3V/WKgOyZbPNZBtUgu+nV+PmspMujPDT9YBsSYcdgWLqTqoye/
         lzhftXT0PALdgnfEnN/oBIm7S8ECcoM/MwpuothFy61z8eHnios0dUZj8spO0vDyjlBf
         1m9ry3nWI6oLzhFpsBbgtAud2gEAadHiYX15B/0sbiU3PXNCvSklRp/Ad3WhcittVtto
         b3X26gboYsWsiPyudibHkfxLGVZHVQoYAs+QM7xoo8jEHY1811sJ1rCdeN7i3IXRqKDL
         eU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768845310; x=1769450110;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGYHe/UIiw9sHb9OX9ESyD3Q3OvR6ABMCUV+kc7Ihrw=;
        b=XiFqHCOHosVcLJnk9jV+EdrThracF8bL31/I59GoB2xF/F0KYzwlI4H5unYB0YEBVq
         gx3ZGdE8IVU/u1IU06H5LuzYHKjV2t9FWvBxL4ouyu6kaciSmuJdvfoQ4Tx8PIcn7cvV
         qRQtepZlVhFpFUL4i3L3c2dcoA+y2xp/c3sl9bnNKofc5/V3q5PEAeDP6kX5q9KTu9I3
         pMyq/0tEs4q6+V6fr3N6BSMn2PtVhFik6z0dYjFRKp7gw/Pz16tXwVNjCkJ5UbVm4JYJ
         MboHnFjj8fRIN+mNxw8kzgIG0MSfn0W+Q5A+Hg7wQsmds/pxqLN9VukihfJf7riszGhz
         Pz2Q==
X-Gm-Message-State: AOJu0YyX0i3YmxqzKrdtgRe5aStT03GDR/feGwDlmdx6n0ZuQ8cWrSw2
	qkLh9jUnYjupLRKsALvh1pA2UP1JKJ5wcj1bf1rgbOzJQlvgquTLR9WclkRz2Q==
X-Gm-Gg: AZuq6aJWkL3STmN4qcqB8crDu4d3c44OeIYKlhIADpK+nG8oDd9pyl1cPAgibf+Q8lX
	qVwLc0irL+ektfvBk+K2JGSmz8Evvs0t9F8TpXaO6vyh8SuLJTIdE3pDVyLh3ZY1cnGfTX3nJdM
	Axmx23QmC2YrQn5JPi66tMm7RiSL0SFj/AFgLt61+KShKQOUHc7wfifwv5Dk2SSDtgnh5lZ78J4
	zc0XRy4JIKroqiuniAyhgRI/7s5iNS9vmjl9/AJgJa2Wr6ZPqiLiZm9XiT9bLqYz1jxtBQKmuaf
	036If90YE/49HdpSQW/mJ/3wwLxvnQ4edMdkLtuNhI4KXuZXepC3zBizh4fVFF0L6pymyvt4OjV
	Us9DxS/uUUQI0sXcl4SX6p4HeAoVAkGStVcC2BrXQH8bo90LnByakhKTjt825Wl52tNDq/ke1Hr
	6kiTVCkWA5N/bFFJ2mj+JK52kwDIMZloFEQ+NXDPm7j/U=
X-Received: by 2002:a05:6000:1845:b0:431:266:d138 with SMTP id ffacd0b85a97d-4356998b5ffmr17127203f8f.25.1768845309680;
        Mon, 19 Jan 2026 09:55:09 -0800 (PST)
Received: from smtpclient.apple ([2001:912:1ac0:1e00:1c4e:5f16:dd3a:1cf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569926ff1sm24334242f8f.13.2026.01.19.09.55.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 09:55:09 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 1/2] net: phy: realtek: add RTL8224 pair swap support
From: Damien Dejean <dam.dejean@gmail.com>
In-Reply-To: <bde1d3a9-6378-49a9-bcc2-00f4038f5558@lunn.ch>
Date: Mon, 19 Jan 2026 18:54:21 +0100
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0EE90427-54F7-40BF-81FF-B7DA76544338@gmail.com>
References: <20260116173920.371523-1-dam.dejean@gmail.com>
 <bde1d3a9-6378-49a9-bcc2-00f4038f5558@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>,
 krzk@kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hi Andrew, Krzysztof,

Thanks for your feedbacks.

On 16 Jan 2026, at 19:10, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> Does the PHY support auto MDI-X, where it figures out a working
> combination at link up time? That allows you to use crossed or not
> crossed cables.

It does support auto MDI-X, it=E2=80=99s possible to read the status of =
it after a cable is connected. However this is different from the swap =
mechanism I=E2=80=99m introducing here.

>=20
> Anyway, the DT property you are adding seems to be the same as
> marvell,mdi-cfg-order. See commit:
>=20
> 1432965bf5ce ("dt-bindings: net: marvell,aquantia: add property to =
override MDI_CFG")
>=20
>> +  realtek,mdi-pair-swap:
>=20
> Maybe call this realtek,mdi-cfg-order and use the same binding?

It looks like the same mechanism, thanks for the reference. The aquantia =
implementation looks more straightforward, let me rework the patchs to =
have a similar implementation.


> Changes to DT bindings should be in a patch of its own.

Thanks for the notice, I missed that when I ran checkpatch.

Damien


