Return-Path: <netdev+bounces-115554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52612946FEA
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 18:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E0B1F21347
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF541EEE3;
	Sun,  4 Aug 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="C9Ephj1d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62872FB6
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722790696; cv=none; b=BR9eL3pFxC2xOUkIzSXaqCJZVqTYQ+kuiPpuNQk0t+bjgaJ1NYRZ9kkL3nT1Vss0eNE3hZqGiD4Ei5oQr527NPeIAOY00JpHVgfdo1WMdO4wCJ+xowG1LfabItoqBR5+P5FgRJ3tN5u3RagfAiXYKxWf7FDj8vbrshwHUtvl4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722790696; c=relaxed/simple;
	bh=6uBL/tq9SKdZsvDvpB5GN6GcWNLTGoVadBwh9/OEGaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ5DMq7Akt49TzFhl6lcLZMmWzjm+IfZfEYBBEV0SHio8cbU+L4BA86HvRo7H5bI387J1AEDraHaocVw9G19qZPT5GP7jgM4BFRCf9X8+TCV4L3+MR0vn0t/ODk+CBv9b8JLrgllrMqvA3vAlZiHDLAd8zbnY1mNvwLv0ixJyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=C9Ephj1d; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d399da0b5so8392540b3a.3
        for <netdev@vger.kernel.org>; Sun, 04 Aug 2024 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1722790693; x=1723395493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uSAexPT+UBMQ/P59Su3X7SsGosI1/vHVlsz8s4B4LM=;
        b=C9Ephj1dZ2SPbYwWCP+cfl4T9+9UWlQFdm7l8TFXyJ4pJfRKxoHgk4wYxsddzixcbL
         sH/lDxN7KguDzq/HOkZOSyg2Qt1HN8Uah5YhhW34Dfc/FYm73Mkqq0nOXwRZj3qLz7af
         byaCvtkepr2S8VWPPnv8aeK1Zfs1/az2vTs7YYOHoeGBOLrfLZXpwYjf79FG8vCBW2ht
         dGelVHH9PKo3IiXVkfS9TOBvpsUyaBnjvJt6uynA2PDkQ7qPfIw4EOfnK0d60X7jckSA
         cZdePMdKYWT0MM19wqSwIFt3jQVbo0xknncR7mKuMFf/OHb/tsExa9K+3pkxs2osmFe1
         J9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722790693; x=1723395493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uSAexPT+UBMQ/P59Su3X7SsGosI1/vHVlsz8s4B4LM=;
        b=bwOIlWwtdDaEiz0lg1IqtomHmW6CsYlBP0qMXJacM1Ef8LLrcEJ3fYwLzRguYc22HT
         FoTHPPmCMfsobUocDOQ/5R5g3tjxmum+i/RrFW2flSI793zfFFpkla7feTs37Urj466/
         4qZ13oaO6mwRLyx/XN/2Gn959fA44xT7KsnpYa5V68azEW99YK2MPHPYJ4oAmrfRZjNu
         5yeZt0Xr++tc1zcsaL0mHQnR2r/5W7PaIZAp7nsLqFF9XJd8M5tpwC39EO4zujYvDE1/
         efQFzZc3VtcSrr5ksiVM0e4piaQ1eNm9gBJiotQPIQYqPcDvk5xhPPWJFcgnUA+tJtka
         OYig==
X-Gm-Message-State: AOJu0YzNsosPrS2hA30qI5NBNNnZ3dqUfiIwYjrpGCqjyO4OCTwljICW
	W8MzwbiAo4TrKHr84Fe8Hc3mH40kyr/eLgu8o7AFQY228PZIiM2zHVGFKuzaHQM=
X-Google-Smtp-Source: AGHT+IHPkkvDocCDAtoeKQ2JoTejJ09H+DIk3CAlg5AhdMG5619o079csX1P1gFfBvwdnRamQmrVjg==
X-Received: by 2002:a17:902:bb95:b0:1fb:701b:7298 with SMTP id d9443c01a7336-1ff572b9f5fmr101937995ad.32.1722790692973;
        Sun, 04 Aug 2024 09:58:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19ca6sm51982955ad.49.2024.08.04.09.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 09:58:12 -0700 (PDT)
Date: Sun, 4 Aug 2024 09:58:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Andreas K. =?UTF-8?B?SMO8dHRlbA==?=" <dilfridge@gentoo.org>
Cc: netdev@vger.kernel.org, base-system@gentoo.org
Subject: Re: [PATCH v2 iproute2] libnetlink.h: Include <endian.h> explicitly
 for musl
Message-ID: <20240804095811.04600a4d@hermes.local>
In-Reply-To: <20240804160355.940167-1-dilfridge@gentoo.org>
References: <20240804085547.30a9810a@hermes.local>
	<20240804160355.940167-1-dilfridge@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  4 Aug 2024 18:03:23 +0200
Andreas K. H=C3=BCttel <dilfridge@gentoo.org> wrote:

> The code added in "f_flower: implement pfcp opts" uses h2be64,
> defined in endian.h. While this is pulled in around some corners
> for glibc (see below), that's not the case for musl and an
> explicit include is required there.
>=20
> . /usr/include/libmnl/libmnl.h
> .. /usr/include/sys/socket.h
> ... /usr/include/bits/socket.h
> .... /usr/include/sys/types.h
> ..... /usr/include/endian.h
>=20
> Fixes: 976dca372 ("f_flower: implement pfcp opts")
> Bug: https://bugs.gentoo.org/936234
> Signed-off-by: Andreas K. H=C3=BCttel <dilfridge@gentoo.org>

Other parts of flower code use htonll().
It would have been better to be consistent and not use h2be64() at all.

