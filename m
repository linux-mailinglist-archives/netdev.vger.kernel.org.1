Return-Path: <netdev+bounces-117545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58A94E3D2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 01:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112A3281387
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 23:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5FF15F41F;
	Sun, 11 Aug 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ah6n414O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994E4C7E
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723418757; cv=none; b=HvqFBntS7eHHZxJp3uB/btheHrVcfMxoVPGhCcX+oK7f8OPfCYhzaGHivyUx7XRnH+VB6tMnno5rCg5CiP9uAcI/9yAD+xJkaZTPVjplJqfm74i1iKmf4Uamko0ysPuJiFzCnxKFe9skvxQYlcUT0a4vPi4IzD9jptzxQYS730M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723418757; c=relaxed/simple;
	bh=21uNYBL79526K87et3nISNBIXjuieKYVGFCVBi8v0ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nW7OjunU5WuWYlGgp1tnorWOHLRwnJQUAAhs98/rLmhW8QtOxuXrEtOlytS8cI0IDIs5DKI0Gjy8g+tOJRSLXHKeK+pbL05HIZ3ZYo5/A1Ap6/WL6KUC0Ys1/1X8G3oFYR2Aez2yBOxph+Ztyq7mNp+la0YV0ByMDVLi+csxaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ah6n414O; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7b594936e9bso2650940a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723418754; x=1724023554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21uNYBL79526K87et3nISNBIXjuieKYVGFCVBi8v0ZM=;
        b=ah6n414O/KIWk2pzQe4vX3aU5VT65Rlo3ic56sCwEq/sNeEkzp3Fcy6Dw5h52xZmT5
         8oXuN0zG9EBlakA5+uSnppWu0J3LvUJNQdWjv6nPLHAQvR9FfcRZIo9rjlo1eazRSTH4
         1AknNE6mT69WXM6wwgSXAUSyEYZQeUcRxF6Ii5SmTjvOoHgcFg2zmrS9QpSKLfCVxzn4
         +DcToapHZXkAB74StWeeEMLUG59Fl3B8oV+LHtsF8okUSuzFv/RdiKYMnr6MC+9eeQTm
         IyoT7JsjPPAi5i6eoZNr3mWU5wIN4SR10hxJGrNslyRJEn5YA64/ty7JiVff/LUf/ELT
         kXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723418754; x=1724023554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21uNYBL79526K87et3nISNBIXjuieKYVGFCVBi8v0ZM=;
        b=W894oRSwLfEDwr9CfLyazKatOH/HYdBwX9rGD9D9ZuXQh+4CkCBld89L/FG2KVb5I2
         shS8jZPNv4ts2hVsCRrK0pdmPeyYLz0HE1Tw/6/T3ixtgjVIZs5xY/JO95oG1foQzqL/
         iUpp3MqPODg6UjPh+IaMg2nWO4x4ESr3JDrFvU97wAzCSypGwR8LxHSzAepM8wNyvk4O
         tmkQGvkFULdjJ1wuXqJ5xI4kenMG7fI8TJaWH9iFtDrbe6vkz57js4mnB/08tse+sb80
         khmtMUNWlJcWvajqG8sKGSNJJRsAqLTstIIuHLkYhRRQ67Aq2x/6hFgjCH08+hPRgHuE
         sI2A==
X-Forwarded-Encrypted: i=1; AJvYcCWjWYctnwBX8azMbX4trrstQr6PuVkXjzbKdrHd5HIBp+X48xBQD6B6knOdPcUPQBOH7ysEgZlck41ui8L8ORBDE0ZA4kOm
X-Gm-Message-State: AOJu0YzJI5b1FHyU+Nxd7zrK2fGyXXPz3l/Cs2dRa8RwkE/OswHXv7py
	WSwI99e7XlJ/isTn+CwJzOuB0MzJXt4z7ljFImF7Rh/ryHY/Ma7mxkr8t7SJmEk=
X-Google-Smtp-Source: AGHT+IHaIB9HGl+ah2LAWk9f+yhb2Giy+NGy0Htf3qWc/M+ZQyZMZFJRABOn6uaX33Y2AawbungXgg==
X-Received: by 2002:a05:6a21:151a:b0:1c4:8da5:219a with SMTP id adf61e73a8af0-1c89fe720damr9520617637.8.1723418754129;
        Sun, 11 Aug 2024 16:25:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed06sm26680995ad.186.2024.08.11.16.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 16:25:53 -0700 (PDT)
Date: Sun, 11 Aug 2024 16:25:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] iproute2: ss: clarify build warnings when building
 with libbpf 0.5.0
Message-ID: <20240811162552.75adee22@hermes.local>
In-Reply-To: <20240811223135.1173783-1-stefan.maetje@esd.eu>
References: <20240811223135.1173783-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Aug 2024 00:31:33 +0200
Stefan M=C3=A4tje <stefan.maetje@esd.eu> wrote:

> Hi,
> when building current iproute2 source on Ubuntu 22.04 with libbpf0
> 0.5.0 installed, I stumbled over the warning "libbpf version 0.5 or=20
> later is required, ...". This prompted me to look closer having the
> version 0.5.0 installed which should suppress this warning.
> The warning lured me into the impression that building without
> warning should be possible using libbpf 0.5.0.

Why is using new iproute2 on 2 year old distro going to add
anything here? Especially when BPF has under gone breaking API changes
over the recent past.

>=20
> I found out that this warning came from ss.c where a conditional
> compile path depends on LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION.
> Newer libbpf versions define these in libbpf_version.h but the library
> version 0.5.0 and earlier on Ubuntu and Debian don't package this header.
> The version 0.7.0 on Debian packages the header libbpf_version.h.
>=20
> Therefore these defines were undefined during the build and prompted
> the output of the warning message. I derived these version defines
> from the library version in the configure script and provided them
> via CFLAGS. This is the first patch.
>=20
> Now building ss.c against the libbpf 0.5.0 with ENABLE_BPF_SKSTORAGE_SUPP=
ORT
> enabled, triggered compilation errors. The function btf_dump__new is
> used there with a calling convention that was introduced with libbpf
> version 0.6.0. Therefore ENABLE_BPF_SKSTORAGE_SUPPORT shall only be
> enabled for libbpf versions >=3D 0.6.0.

Might be better just to drop support for old libbpf and also
the legacy mode. Having multiple versions means there is more code
that doesn't get covered by tests.

Also, configure shell script is getting to be so messy, it is time for a re=
do.
Maybe give up on make and go to meson?

