Return-Path: <netdev+bounces-244457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB8ECB7E5F
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 06:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42E5D3035A62
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 05:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7321CC79;
	Fri, 12 Dec 2025 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="eXhWPDva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C652940B
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765515797; cv=none; b=Aj1kVpYzli6vxmOjhsx66Q5Vx+5lHYi2vfiKfThmKQMwl+3brNF1h6JaYlG0dexdWDKLig2R4gGFTQ9XvWlyx11vcltXDkLnC0tRE20zhdZgg6PKOg1KnhVagpu54pjtYSDgLg2jHLPHxzPoLcG6Tx4jjsrftcCJMRCdjU/TJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765515797; c=relaxed/simple;
	bh=lvvhVvYqnyd38+35xpYZxyOZJV49/5HUQBeD4ufxZU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GU7JWyPFVr7Ff7Fh6NWyMIMueX+KBD8vCDDS6jR7hglvzTbzB1QMtgmuscKOBCcDgpZ3QTf44FzdfDpLWxOqAbJgnMyCxtIBdtNlCE2CYskLeDg5/M7hZ65TSiSbLv97BX0K71iPDCNNu4+JHzfcXNMZNxSVUpHsrY3SvqID1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=eXhWPDva; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-349ae58a7baso704610a91.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 21:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765515795; x=1766120595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvvhVvYqnyd38+35xpYZxyOZJV49/5HUQBeD4ufxZU4=;
        b=eXhWPDvaV8MBwFNnTOIp8lVyKsimtDW5EyrrwiyLMHAeh9UfzLr93+uM3s9a9gwZf8
         r68ydhniEUB5t/NB8tuTXAuYwf5HpRB7CvoJlvkAbRvhn/yLWAGSVrC3UrU16AylABYd
         xVSZ0bmQ57GqSwPLtLPz9b7+uU3Hdf2etkWJxL4mw9fACgEXfiyvwQFQxW4rqpw4w8vK
         OrHlP7rns8YqepUtvwsHX/4gHFZ6EtQih4qseULHfyZStATtldwKfl+R5AxLZ1CQY4sY
         Xqw1u4ma+kxIb28CRj+KgT2IEwzwF2clpy2sJH6n1WIPiFIZpBpu52ygWk12lnXQJxzS
         A+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765515795; x=1766120595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvvhVvYqnyd38+35xpYZxyOZJV49/5HUQBeD4ufxZU4=;
        b=Z8MBPNvW1hUfiNK7Oda6KtJ3DIk/3XObWR1zv5X0LeVnzuiKwz6WK2zyF7GBaXZmPc
         eK4qUYss93WY6amGOGs95N6D/I7G2h+z3autbdKIXQL8MXPvq4Cf8YMyaEaZaHennpph
         O+/T5bgTLzeKcbRqQq3YzsEwapYySHrXPgPhGSAZPBzQtI2hM2w/RmbswFdG+b12c3E0
         EK/UHSLt7y3Drq0xwt4mEMAbVdeTHGpccKr/xPEYHt8RfSlZWdGwp2WW7+ytMuXzzEmz
         1Aq2H0AEF8ZDuN5DfEYbNv/SS564C6jsSasRrBqk43BO0VPN5DmJ339mIcp7n0dyQHUI
         3a4w==
X-Gm-Message-State: AOJu0YyqMgTn0hGjPQ7I54AHEerY3A98rpp3tfb+iC2Bq6bO5Sf97vHe
	qQqtIHQuxFOoH8ZUdrP3o/Tvy3QoOMPxSSPum+bM4wHd2LcScaMbDE0UboRDoLPvU5tN7RRSLEI
	zu+hj7ZE=
X-Gm-Gg: AY/fxX5y1e2giXc+w0uiqrESSsj5AJbN29Lvmm2pfhBrh64AieOcnzto1fVzWWY6XGw
	xBXwKqF1ipMENpogT/uZYwe5mise6KPDXfzvp1BNtJifJzQyYQQ9SBqQEj1lZx4w4BHhkX9VtXl
	60onItoo5peM39RaRCeN55lI9eLHI3HxC+xxJi0FeOPmfswjmqIAezHBCVesT86tHgWKUanjh1t
	vbhdTxggiHDGbayA6lntUKi14Zszx/3W9+gmN4P5/5sVyT0ffR+ekX1KbG2/M4rODiKCTiqM0Um
	wiYbuE8S/JuAeqdgXEZXNwWBdi21wQV02HNqkJeeqSVDsSJYppB+UUnv4a3nOYoNVaiNlJu5CJr
	44LeHyag+1YkZIEdZJqTDlCbpK/SRnS8QNvSWM2yVPkhKXZOjcaFdZRZzYfQ2A/kP+tRFtidtft
	f/G3FLOEJn+DS1t4x4cY4FOiUVnMefKnK4anMAT68rr8cWn8McUYPx1OVO35Y8
X-Google-Smtp-Source: AGHT+IEY3x368K2GmX370IZTVEkBvaWefN1VtU7ify4Q5B6BHvaJbMZZN1odybhvGPMMkvvp9PDJqg==
X-Received: by 2002:a17:90b:2788:b0:349:2cdf:8d40 with SMTP id 98e67ed59e1d1-34abd7e76d4mr886843a91.3.1765515795102;
        Thu, 11 Dec 2025 21:03:15 -0800 (PST)
Received: from stephen-xps.local (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c25a871desm3699685a12.4.2025.12.11.21.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:03:14 -0800 (PST)
Date: Fri, 12 Dec 2025 14:03:09 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 0/1] lib: Align naming rules with the kernel
Message-ID: <20251212140309.75c84ace@stephen-xps.local>
In-Reply-To: <20251212042611.786603-1-mail@christoph.anton.mitterer.name>
References: <20251212042611.786603-1-mail@christoph.anton.mitterer.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Dec 2025 05:18:12 +0100
Christoph Anton Mitterer <mail@christoph.anton.mitterer.name> wrote:

> I made a small test and compiled iproute2 with its `check_altifname()` si=
mply
> always returning true.
> Turnes out, that the kernel seems to accept any name (i.e. including whit=
espace
> and `/`) and I didn=E2=80=99t find any check functions for altnames in th=
e kernel
> either (okay I didn=E2=80=99t look that hard ^^).
>=20
> Not sure, but maybe altnames should really be allowed to contain anything?
> If so, we=E2=80=99d of course need to change this patch.
> OTOH, e.g. systemd already assumes that certain characters aren=E2=80=99t=
 allowed in
> interface names (see `Name=3D` in systemd.link(5)) and e.g. `nmcli` uses =
`:` to
> separate fields in its machine readable output.
>=20
> But then again, the kernel should perhaps check altnames?

The restrictions in the kernel are because interface names also show up in =
sysfs
which can't allow invalid filenames. The altnames don't show up in sysfs no=
w.



