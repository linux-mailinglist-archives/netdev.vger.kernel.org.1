Return-Path: <netdev+bounces-202219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D7AECC18
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 12:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEF43B1539
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029001DF994;
	Sun, 29 Jun 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A9sBVcZc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9FA93D
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751191784; cv=none; b=JjvxlS9q6Pg/XSIlW91K2MJuKo8UHRt66Wg2L4F+17qn7xrw88DmCywMilUWxylItcNeT23yHQJKDH63d1/+A/AnbgqjnTWgpP7li5vZ9MxIK2bvwc2rmOg/XbFVmPj6vtdtFqSWnpx3laxGUMJOvM28oL3FpI3cSB4M7GzOvzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751191784; c=relaxed/simple;
	bh=Objn0qkkDOaz6NCNuPx7j09YEN0QasjHDxNQrM+Klvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy+DIG06YG48lOH1TmCyRCXSk+6Z8BE/SbB3ScurEYu0Usi9g6Fw5r1IA6QqL6iaTcBp4T6gbv9pqpzIcK49U/y6CMF4rn2eT/QMqXfh5I5z83Ddv1CP9uuaJlL8vY7zNM13m5cGTe6zHAPYv79yXpvX8c2cMeEo+xKK586avXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A9sBVcZc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so7395545a12.1
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751191779; x=1751796579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3lhF8Ko0I6L/wnaOj8OO3hWgcZ+KtGsArNvPGKpoSg=;
        b=A9sBVcZcF6niT5gMlh3wSbLIr+AZiXw1SjW3TSst3CRIBCPfoPTU/4C83BnjIZSAIM
         LDqP7R7vwcdr14R9oH48lsi4qVyoUgree65eE1nxczK1xyKFgTcD807jITHqJ3Dvks1O
         LmBS/l0e75uXOtun61xuCioMWVG/T6/7TbXhcLWPHwKOOjx8XoJ7LhTloyh7B/z6zTso
         sIfRyWdtG17Ulo3Iz26FHqPDMM3fGb2BaZZxeMX5xdPE0ROuGBZDwZS5IR5s3kQ8aSY3
         kGcm5Bfbf/Jx0qcNiHPBKV3AKSjTzQC7tVLmBIVYZ6zDvgLXkgS/yETN6oPgyHGSaaHh
         JoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751191779; x=1751796579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3lhF8Ko0I6L/wnaOj8OO3hWgcZ+KtGsArNvPGKpoSg=;
        b=xOsqdlJlN0W5x3uoUB8A/GBYC8akqRTvcjW3OF0vN616fEIRy2yMW31qKoKNTkPG41
         ivfySJ2hRHt12I5JlET9dN5gjfcgwC7lpI4lh5AXttYKKIJkcInGSLWO2x3kP4ZzKKQh
         MmfW2IIezr9QAi2QbnMtVmD2arID2jZiYTPCTb8TFhgPbeKT3gJqbq6ra+Fh2oZzvjb6
         ulHVyz7/RDxM9Wq4fq9trR1UCxLwlqXa6WTlr1oNQpo0PpJmxs0YVqIuR4SJC7gJZbcE
         wKgvX03FY1ShIzKbRwj9S3TkA53B9d0Erw0b87sxkKcwY7YtfVFKRdd9pDndYBs2D9Lv
         Qb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1f4dEcykRs+EuNTB+NaP9lpSg4uh44HnRrxYv2xjZX0JzqBGThisuPTHvt6ng88q2NUwFUJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/Qo164gAR1z63mnaMTxs8O19YCzkWAryMKp2PgH2VTTNfe1B
	EUwzOcJ0PTWy3SSafITGbOBdZ5UUdGjqMtsU/1Gccy7M/5PgvspgtlNKiOZeG6HbmFZD7+e+yuH
	0rIYL
X-Gm-Gg: ASbGnct2AIJfChJNip06ZjoIuH2bV65EjGkxHMWLfb+lSnDP2FLyfrEIvWMMrst9D7W
	Dzy1gRMpNLSZKOQP6ywGrymu080/VNcXnqsjdvL93ZWf/RL/Kalg1pW+4v5R3k9EilMr2zi2pvz
	f+J9yvLHjqbUnvRiQ9XtLFsEDcjCleQi7f0BWbX2IFSywmMi8RJnKmQxnfXuHj0qZFyomIZDiWA
	ml+8CZeOEf02cipB2NVgJd1KnUObgDKxwmjSfGcnKwW6j3gextp9Pk7uUkCOa2lkzda88Je8/ub
	iwLBHgLStStj8Qt9HobuNFr5M8JYhjFf3/dCb+A68ILUD9sueCdCWqhTH3KTIvLu0q0=
X-Google-Smtp-Source: AGHT+IHX59f5eZ5DuWfM4j43TQIKm9gkCD7DITVR2ntH5B8idPSfwFsT1XuIFCaYQ0RvSF+jsBcusw==
X-Received: by 2002:a05:6402:3514:b0:604:b87f:88b4 with SMTP id 4fb4d7f45d1cf-60c88e858f2mr8055235a12.2.1751191779121;
        Sun, 29 Jun 2025 03:09:39 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c828bb60fsm4128515a12.3.2025.06.29.03.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 03:09:38 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:09:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Igor Russkikh <irusskikh@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Loktionov <Alexander.Loktionov@aquantia.com>, David VomLehn <vomlehn@texas.net>, 
	Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>, Pavel Belous <Pavel.Belous@aquantia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: Rename PCI driver struct to end in _driver
Message-ID: <atr3nxbqeor5azeajgk5qwmnxuxm7q3qsn3pk53j4mbzvqsdc3@qxa3cgbfxdbc>
References: <20250627094642.1923993-2-u.kleine-koenig@baylibre.com>
 <20250627163652.01104ff4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrttdanqafyp3xwq"
Content-Disposition: inline
In-Reply-To: <20250627163652.01104ff4@kernel.org>


--nrttdanqafyp3xwq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: atlantic: Rename PCI driver struct to end in _driver
MIME-Version: 1.0

On Fri, Jun 27, 2025 at 04:36:52PM -0700, Jakub Kicinski wrote:
> On Fri, 27 Jun 2025 11:46:41 +0200 Uwe Kleine-K=F6nig wrote:
> > This is not only a cosmetic change because the section mismatch checks
> > also depend on the name and for drivers the checks are stricter than for
> > ops.
>=20
> Could you add more info about what check you're talking about or quote
> the warning you're fixing? I'm not following..

If you do=20

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers=
/net/ethernet/aquantia/atlantic/aq_pci_func.c
index ed5231dece3f..2ee5900337bb 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -208,7 +208,7 @@ static void aq_pci_free_irq_vectors(struct aq_nic_s *se=
lf)
 	pci_free_irq_vectors(self->pdev);
 }
=20
-static int aq_pci_probe(struct pci_dev *pdev,
+static int __init aq_pci_probe(struct pci_dev *pdev,
 			const struct pci_device_id *pci_id)
 {
 	struct net_device *ndev;

this is buggy; so it's justified that you get:

	WARNING: modpost: vmlinux: section mismatch in reference: aq_pci_driver+0x=
8 (section: .data) -> aq_pci_probe (section: .init.text)
	ERROR: modpost: Section mismatches detected.

=2E However if the driver struct is named "aq_pci_ops", the warning is
suppressed due to

        /* symbols in data sections that may refer to any init/exit section=
s */
        if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
            match(tosec, PATTERNS(ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS)) &&
            match(fromsym, PATTERNS("*_ops", "*_probe", "*_console")))
                return 0;

in scripts/mod/modpost.c.

Best regards
Uwe

--nrttdanqafyp3xwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhhENsACgkQj4D7WH0S
/k6whAgAu6+On8DMXZrNQE/D/SCWkiyNrP6ZOavkGXobKMfkZaSCK4EHoFCUgORw
IGMWKpJotjbldrrNwbuCliXPdlZyGtOPRTRshoE5cP4Z0RvhLJbuhPh6NqC/kC6E
zJJjc/6pU/PtH+54553fc7w7WHsOeEOsUm01PLAcw+sqcldg2NROQLGaV7Mne2vm
dSRic8sEg7FaMyjk1pt6k3iI7F7tqDYtRuaew9IhVNrOCORhfOBWr72mn7rJaitg
qWdz0OtOYX6eyMVeEZqCXWogBSd4JZgV7gikWA1GNZ3ZP6uzu2VgiUNTJ+PWSBBf
lXW06KhwO19tLB1gsDXVhO9TBksp6A==
=mS1g
-----END PGP SIGNATURE-----

--nrttdanqafyp3xwq--

