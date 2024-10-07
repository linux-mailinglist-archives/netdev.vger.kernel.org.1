Return-Path: <netdev+bounces-132802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD3899339E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D878287851
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C951DBB3C;
	Mon,  7 Oct 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="d9QaOaVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6EF1DB373
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319154; cv=none; b=qWekuTAcZkpkt8H6VS2ghsjNGHel+XXCmaY1pbPsnuWyvnXxUg0in6KgW0N0rxnLzplnWDLoGz4iUm4PSoRpYqsymLFy/rOJlRvMIFFlN8rrVV5s/JuwN4yEEa45Qwrwx7Xvoo4u4CZ1PZ7mT1YSfdBAw731Vnu5ixcm1GqlfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319154; c=relaxed/simple;
	bh=5kSchx6lq8m+AgwXuUQA/TeosOSLv6yImAWfDG7gJ/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jr10at+jLFeCMuc0esUR3KCExq11FATXRrj//5vlw7X3fjKR054SQgjhNlYDBqwJr8U0TlAlQtn/SUkTDAJyHUy0SMNVGTZtkueGuLufXvgGNDhIzAERJo2KDlePklyr1BOpkFn6jFkQxEp1iZ2R4Y4xbljpDt4BLcI/ID3kT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=d9QaOaVA; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e260b266805so4267239276.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1728319151; x=1728923951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kSchx6lq8m+AgwXuUQA/TeosOSLv6yImAWfDG7gJ/k=;
        b=d9QaOaVADhSatQfXRAd8EuYxI9qSPj2mnRamsUAXChIG8UUX3nZR9dtyfRULq9+Qws
         Cuf+ET+0h1+UKjggjD4N5C3aWjdDgwXTqbyDoNQLXJ+bmBMhkhmViS1Fmw8TCoHhAzuW
         ouuP4ms5+aEKC61hhfr/KlvvfsFkpjnL5G5i8WcOkB68mCZaWKJqFejta04/U3iQuSkv
         cY4z/yZ5fctyKljVH2cyopYumvB7ipggBDEsFpbu+VgXsbA2ANdfiPAP2U62/yEyseOm
         oKiW4dLeAf3veduY9zojZAvFugIgjgCWhCr0IC3V7wAc5ol4UccFOOBRLi1xom8naqDF
         C6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319151; x=1728923951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kSchx6lq8m+AgwXuUQA/TeosOSLv6yImAWfDG7gJ/k=;
        b=cuRiWQITMuW/shi1itqps4ugveadYMdIw7Jke7JvteG7cggYUBkN8kAIbSOmUe0OCX
         Cuzheji1eJ9JisOUu6HY7mqbYjEFh7iTqpyNKvfakZ7tgvxLBzju4PFDcjR4mHwXmT+3
         EtgxxWG31kHetIHmXZTQjn67VU7TBQuWvHPipwPlh6C5qpJUz1RDsj//sLS+qsNixgV6
         yh9fy6qfgBKSxDCxlySaoLXiEqvmtC/8/zHuJdgjwUi8yrjypqujIqE4s6IGByqHY9hH
         AQLwdj2NSzkxIPERkthS2HLTekrZPr0XYZPUnsA4J1eJqhnSEHgcD/5+N41kuV2eDM0Y
         knWA==
X-Forwarded-Encrypted: i=1; AJvYcCXaa6GD7qAXiHFPMH3Rae7c1cz/3JjU2ZHJIFDq5eSH5yzflP3YWC8GP3efsousWibeAcBfznA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB80Np9rMed+2WEeeFg1ra+NYVvSY1N9QLKmkzUMgte4TvRg0X
	/p2NM7Y93492cwrEBXOqtYVq59lW4KaciYevLwY7Xt6Vm1L92GBE7meWCuo6pRlnPzLgAINO46b
	B8ZTEt009Ffvi7wjgy1o9g3jlBAoI2q0nkKuonQ==
X-Google-Smtp-Source: AGHT+IGVHfa0Imx231sJnOBuoe92zkuhYXnw1oVdVHbQtk8cEuUjipp2aWJ66W3Pqtgo5AbrAyW9cZWVR4KX9tMqDjk=
X-Received: by 2002:a05:6902:704:b0:e28:eab7:b647 with SMTP id
 3f1490d57ef6-e28eab7b8bemr111736276.11.1728319151351; Mon, 07 Oct 2024
 09:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004213235.3353398-1-tharvey@gateworks.com> <a9467e93-3b35-4136-a756-2c0de2550500@lunn.ch>
In-Reply-To: <a9467e93-3b35-4136-a756-2c0de2550500@lunn.ch>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 7 Oct 2024 09:38:59 -0700
Message-ID: <CAJ+vNU2Hdo-J8HxVXG63AEauBXUdnuRViwmMmE1mNj30NcyF8A@mail.gmail.com>
Subject: Re: [PATCH] net: phy: disable eee due to errata on various KSZ switches
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Robert Hancock <robert.hancock@calian.com>, 
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>, 
	Tristram Ha <tristram.ha@microchip.com>, Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 9:46=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 04, 2024 at 02:32:35PM -0700, Tim Harvey wrote:
> > The well-known errata regarding EEE not being functional on various KSZ
> > switches has been refactored a few times. Recently the refactoring has
> > excluded several switches that the errata should also apply to.
>
> Does the commit message say why?
>
> Does this need a Fixes: tag?
>

Hi Andrew,

Good question. I couldn't really figure out what fixes tag would be
appropriate as this code has changed a few times and broken in strange
ways. Here's a history as best I can tell:

The original workaround for the errata was applied with a register
write to manually disable the EEE feature in MMD 7:60 which was being
applied for KSZ9477/KSZ9897/KSZ9567 switch ID's.

Then came commit ("26dd2974c5b5 net: phy: micrel: Move KSZ9477 errata
fixes to PHY driver") and commit ("6068e6d7ba50 net: dsa: microchip:
remove KSZ9477 PHY errata handling") which moved the errata from the
switch driver to the PHY driver but only for PHY_ID_KSZ9477 (PHY ID)
however that PHY code was dead code because an entry was never added
for PHY_ID_KSZ9477 via MODULE_DEVICE_TABLE. So even if we add a
'Fixes: 6068e6d7ba50' it would not be fixed.

This was apparently realized much later and commit ("54a4e5c16382 net:
phy: micrel: add Microchip KSZ 9477 to the device table") added the
PHY_ID_KSZ9477 to the PHY driver. I believe the code was proper at
this point.

Later commit ("6149db4997f5 net: phy: micrel: fix KSZ9477 PHY issues
after suspend/resume") breaks this again for all but KSZ9897 by only
applying the errata for that PHY ID.

The most recent time this was affected was with commit ("08c6d8bae48c
net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)") which
removes the blatant register write to MMD 7:60 and replaces it by
setting phydev->eee_broken_modes =3D -1 so that the generic phy-c45 code
disables EEE but this is only done for the KSZ9477_CHIP_ID (Switch ID)
so its still broken at this point for the other switches that have
this errata.

So at this point, the only commit that my patch would apply over is
the most recent 08c6d8bae48c but that wouldn't fix any of the previous
issues and it would be unclear what switch was broken at what point in
time.

Best Regards,

Tim

