Return-Path: <netdev+bounces-168308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D3A3E767
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3888119C0A09
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D11EE7DD;
	Thu, 20 Feb 2025 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xQPSCB4+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710781EC00B
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090050; cv=none; b=q8R1nTnexCpzeDHQ2QY7U0PV245E4/IbLDCcQkbuHjkdbTuHnrZralUrcywTfNrEc9UBoUkYbC/ClafDahuSXTrD6SS9G3Wnn0MsKd31wkrMcRxFGYlqUX3mldOR1BYP0W0HYTcdQEPvtQarLcHEvFOXvlb+rQ4JUZ4CBHiaP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090050; c=relaxed/simple;
	bh=m53XDRRj5XWElq4UYrfkPAwWLouQlqlp1DjklflPBgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHyvAkrYHIWk2w6iqWPxgVkR6bPggnvdMywplOhnhNzG1Hiz0cdLNksO9V7reDR9YabXDqOWQC/ps3xKGIe1hcG75g9n8KlzAGCR0PUbsnN5vnRnFAMAnA+0qKY8oY17SE/EaFxOAnpg1p05g5kfltsyh4K+UHYepsApjyF+rG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xQPSCB4+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so3009194a91.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 14:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740090047; x=1740694847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiaJd5WLTIGG8W5RqlpBZuK7yjAZOHOL4qO1x72frzc=;
        b=xQPSCB4+j3wmtxnjWYtcTj5WjNe11LBYPNZAlfHJICNR2rZ/ExAxSpZNiKb8UmLWsO
         5BjJzYi3P5jjYa9wfQKtgtlp6RFLRE4u5ypD1Es6IhdviAm2TCOUYAAuahZSjRbJCEp7
         9jBLjjFM2c7mg4j7l9zdveaqXa/gtYo8jqaLnNb+wymgUHlNupA7Pv7ZpR7A4OmE4lSO
         9/xyh4IiQFtb8ppTLt6sdM6T6LCEP4Ot7vwXbB8xkPZaYDQqbNRL3mCtwGDGIU46HAKn
         IahIbJAoMB8istZg5Q44EH19N6syBn8CJUKe3meOWpQlXsQ9VnnSYCHSLrotGMEQsY8/
         jvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090047; x=1740694847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiaJd5WLTIGG8W5RqlpBZuK7yjAZOHOL4qO1x72frzc=;
        b=Bb1DJLeH28B6GCvThvgh9RfOHwBpbBPPeOTgj06f2EU3COmXDzxDZHqCJPQHpVtwni
         /u0gpaZZNg8QxKrzkwPCRL8irHuBRi2WIPsw5Bx23f/3ggnI1+1x8VUEisq2VVbldAuz
         xrjpRMYAUr1FOMw43i0RNWS11Mp20dn915/8gZnC+Ii0NxfWZZrMO+S2BVTZCQXe7mdS
         6alX9wZ8JP+c5dJ9y4xNrMPpkcAQtgRs6DVm7yHVXwDZC7NbJf45DNb6dUEdQgIrDKyb
         Gh96wi7fpFQFjgG6kg1s17DJr0ct57QFFUGw6TQM5tnOhyBI0fgLE5b2JsiGDAleAQ9Q
         iwYQ==
X-Gm-Message-State: AOJu0Yx9Ugwmb4pq7xWWbWWnniPhzisPkmVQkTOYScSFjZLQVob9YYxr
	yfll/Et+QgS8VZeExVR7rdLKlqlgsE0kHd4+1e6ng6yazxIx9/+8bLea0zHcczc=
X-Gm-Gg: ASbGnctR/ZKBokfko4k8Y/QYtla3pdcuUZuGlGsuleJoOZHWl9bvEpaY5Id7IVS7Bsr
	ZVvjcaFASd7P4Z8e8fRgcmGURPtrE/6/ju2E37CKEU8a4+24B+1QJRMBvmaBBrv8Cuqrnnctmpt
	j4zGMsE8pqdvePHhFiVf3+ovxsETO0Ja61+ygh2fqoxxWqp+NGJLXx6tBsD0z3X+rozZGPusPn9
	jLtXxg17DGYflSN1Rv0aKAWI33dPKg0HzkmS3KmCOAe49WiCUhqan++SoKLkh1FDPelpxodxuVX
	DV6anxqJF5vChIOHv6tlWb5v/SRedSmV8qCJAbdXLn3FquWtSMcv+G2CdlbWyFBX73ZP
X-Google-Smtp-Source: AGHT+IEFBy0dtz+sD4IHoE5u/AJiF8492iuTp25oCjZnkw+WmBLSfMoBQAOx6q/Gk5BiBXCtYZSq6g==
X-Received: by 2002:a17:90b:1344:b0:2fa:2252:f438 with SMTP id 98e67ed59e1d1-2fce8740eb3mr670380a91.30.1740090045685;
        Thu, 20 Feb 2025 14:20:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fcbaaf3f38sm2248734a91.1.2025.02.20.14.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:20:45 -0800 (PST)
Date: Thu, 20 Feb 2025 14:20:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz
Subject: Re: [PATCH] ss: Tone down cgroup path resolution
Message-ID: <20250220142043.21492b4c@hermes.local>
In-Reply-To: <20250210141103.44270-1-mkoutny@suse.com>
References: <20250210141103.44270-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Feb 2025 15:11:03 +0100
Michal Koutn=C3=BD <mkoutny@suse.com> wrote:

> Sockets and cgroups have different lifetimes (e.g. fd passing between
> cgroups) so obtaining a cgroup id to a removed cgroup dir is not an
> error. Furthermore, the message is printed for each such a socket.
> Improve user experience by silencing these specific errors.
> ---
>  lib/fs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)


Patch looks good, but will not apply since missing Signed-off-by.


