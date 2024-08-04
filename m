Return-Path: <netdev+bounces-115550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4018946FB7
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887462811F6
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C059761FE1;
	Sun,  4 Aug 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="iwBYOfpK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0D1DFDE
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722786951; cv=none; b=j4vrKZJm9yCdd+9z7fx0kAgczw8bbfdGOFEJ81lUTig2YuF9dN/7pADkrLfT33AnmVmpYDU4mkD4xAKZ0kRg8YTNxHN/0caeNQgUCTBtLtGxWxXj62yFZync424AMcaYP6e/81Wkb+0HvctVCOukrCZolNRMWRia/Ftc0jDM+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722786951; c=relaxed/simple;
	bh=gmWmou15BQeM8KiEfbfcg3ksHhaxQsG29B7T15wT0gI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ax8/YzNjWMR4YDPvZbeCt1ovLbFK+sM2DXeZAk9CLgnd4azSDbU5Biyl23Xd6iyDaIDL9bC/+7pqf8UuSOzKqOTxRKzI0TNzXqcHdu4geiewtj6dTiE+ak/PJK2oO9LtAtdvnSDtWevK+3QbLgnauusANh2k4yP6a60w2CbzKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=iwBYOfpK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd69e44596so34384345ad.1
        for <netdev@vger.kernel.org>; Sun, 04 Aug 2024 08:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1722786949; x=1723391749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlcoaTBcsrsQtYZcDgK2jJzmqFDU8ERsjpdjHOy7QvM=;
        b=iwBYOfpKsSQ3UDYuzBcG3qCi4pEfp/vDjLryGGZ4rr9cN6SjZ1g4qMp4QCykTfj/Ak
         tBmlUeR9yZjGe+9JIy0/fA+hvlrQubzjkLUBNpalvuy3uZQtfJ/mXr4Ead78p+ErPmmH
         jrj6lvUEDsLYgjZ8a2wAOPmnGhVwnc2glzTmnevmeJYH5fuPM6igUUzfu8BK2vi/Ftcy
         KkMT55Dij7fArB5zKG5vGwAOIsS2TW/9wzumWS29UkcphBifYJUOhUgfzlNyY7SUWYNS
         UNPSKzC4IunnaISPumZj/ZW05agptY/33cn3xbhAIFlTTRwthaK92LNSxlRbynTEjlt/
         Q4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722786949; x=1723391749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlcoaTBcsrsQtYZcDgK2jJzmqFDU8ERsjpdjHOy7QvM=;
        b=YuG+EtVehO4Hd9leAAPEfY004wHZQbftkvyeKaAz+oPIMUkiXoJfq9k6kLZvyeAN1M
         kfo36hBSnVUUAAkfo1Jd1XDcZsqLTD9hu5zuMslwU6tTW01+A5c+J1YC9FR8aUcPAdRJ
         90/8ZE+FZcbOQVwDr7jICPVEhF06Gyus3WGgXvJUEjIlz3JpJf/OnR84x7rslpdDkfSO
         mYoLT7RoXD2kjA+5bIqxeB9c2wiRI0gTTBoAwvFWm1W1CGh1oZTq1+y0BikSV7jR69at
         2XIXQPlk8B+MsFDKd4dU0Iofpg+13MYRSTi2A3YGD1nWU4P7wy31cCe05H0Fsm2bLzv5
         EnjA==
X-Gm-Message-State: AOJu0Yw0jkYU8iXs/+MY8xZFk8DZsIyHMVyEVnqoVukr4P5Kr0g1pP9Y
	Oi1hS7/uSDPk7SwNyfMc2dzF7Yqgb+qZ71luE/d52viVbUJxSp39PMo9blmyAvg=
X-Google-Smtp-Source: AGHT+IFaNPAGodJGaKlHtypGTHpyldZLkr6dLtoS08p1dmO24+JnqReK7ewM2TxXuwFcYe6UOYPVyQ==
X-Received: by 2002:a17:903:184:b0:1fc:41c0:7a82 with SMTP id d9443c01a7336-1ff57a05624mr165619285ad.0.1722786948977;
        Sun, 04 Aug 2024 08:55:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f219f5sm51319585ad.29.2024.08.04.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 08:55:48 -0700 (PDT)
Date: Sun, 4 Aug 2024 08:55:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Andreas K. =?UTF-8?B?SMO8dHRlbA==?=" <dilfridge@gentoo.org>
Cc: netdev@vger.kernel.org, base-system@gentoo.org
Subject: Re: [PATCH iproute2] libnetlink.h: Include <endian.h> explicitly
 for musl
Message-ID: <20240804085547.30a9810a@hermes.local>
In-Reply-To: <20240804145809.936544-1-dilfridge@gentoo.org>
References: <20240804145809.936544-1-dilfridge@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  4 Aug 2024 16:57:46 +0200
Andreas K. H=C3=BCttel <dilfridge@gentoo.org> wrote:

> The code added in 976dca372 uses h2be64, defined in endian.h.
> While this is pulled in around some corners for glibc (see
> below), that's not the case for musl and an explicit include
> is required.
>=20
> . /usr/include/libmnl/libmnl.h
> .. /usr/include/sys/socket.h
> ... /usr/include/bits/socket.h
> .... /usr/include/sys/types.h
> ..... /usr/include/endian.h
>=20
> Bug: https://bugs.gentoo.org/936234
> Signed-off-by: Andreas K. H=C3=BCttel <dilfridge@gentoo.org>
> ---

The commit message needs to be reworded.
Should use fixes tag than a specific commit hash value.

