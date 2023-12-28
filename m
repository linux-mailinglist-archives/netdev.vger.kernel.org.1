Return-Path: <netdev+bounces-60426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8A81F377
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECB0283C23
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 00:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40B15B1;
	Thu, 28 Dec 2023 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CKcA1vP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98115A8
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3e05abcaeso26230825ad.1
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 16:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703724407; x=1704329207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5E5nLNcycNMWIOlLc5m02oqddkJ2d2zO7rkId0H/TE=;
        b=CKcA1vP4dkHd8M2XfoUjVw43rdi8snel/IEf4A04bGt7MxpYgHwFa5PVImPlLWY0lp
         6lMvp0k5fnzUa0yBff3D5XE2sAYk/e1hHodESYXhb8xTU8KjSCmtNg6hhtdNZADLvlxL
         IbTIfI1ZV4E3U0lm3DEInEp09B3Zh288M3Ape162HL2I/sslgOU3tGLSpBpPQfpxJ47M
         nCnctdw/64znpZZo03WZaaVw0nKgpJDQyKi2U140l+Qxnjkbsxfc6oonbMuuCy19MZHH
         RE2XlLa8eOMiZGFwGU2cKPoiZl2fwIkGuqnKVqMyS3iNmhVcZptFmYAcwwMZN5+SoRO2
         qdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703724407; x=1704329207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5E5nLNcycNMWIOlLc5m02oqddkJ2d2zO7rkId0H/TE=;
        b=BsVTh/sfZVbQoh/bBN/fMi7FJFkNaBXkLhkowL10O5joHZCGVmRYloAwHYEtgEfEry
         8HJVY4O3tXRQFvf3SwTeRHDBWEFtqFdAJJAl0cX3BqRhHMwzJrD7LuxfOuKARP+7dg1k
         48F71BoIJhXyl7zc4J0N5Gxql1vvAug/jRwahUGFumV8V1/PU0uNbYxlrjC81FM+0mF2
         O5QWbDZW5w7lSNbzvTNP0MtvaKRN91/TFqYJ8k2bfB2mbY9fq0GwGAjoPOoCTM3sH4Z+
         aCxdlOh+mIdtKpN4lTIJp2IZ8xD+smMY/f9/3UMIdQoY0QsQy/NdQJlzaDmwWMuADs91
         gdpQ==
X-Gm-Message-State: AOJu0Yxam57bHTsM3d1YofamA8jmcKnLOnzR40QSSTP2M0MB3ZTRWvsv
	FwQHUbv1Lc1CC6RyP1aU5CeSrO8JZXWZKA==
X-Google-Smtp-Source: AGHT+IEgyfMr8s/EWXbRUQQoThuo5KRGP7cURRML0RBVpvfVHEUgQGoGDt+6qgD0gwhfSC5RAuBsgA==
X-Received: by 2002:a17:902:ec84:b0:1d4:3dfb:5960 with SMTP id x4-20020a170902ec8400b001d43dfb5960mr3268654plg.90.1703724407308;
        Wed, 27 Dec 2023 16:46:47 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902ed8f00b001cfed5524easm12612143plj.288.2023.12.27.16.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:46:46 -0800 (PST)
Date: Wed, 27 Dec 2023 16:46:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eli Schwartz <eschwartz93@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 2/2] configure: use the portable printf to
 suppress newlines in messages
Message-ID: <20231227164645.765f7891@hermes.local>
In-Reply-To: <20231218033056.629260-2-eschwartz93@gmail.com>
References: <20231218033056.629260-1-eschwartz93@gmail.com>
	<20231218033056.629260-2-eschwartz93@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 22:30:53 -0500
Eli Schwartz <eschwartz93@gmail.com> wrote:

> Per https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
> the "echo" utility is un-recommended and its behavior is non-portable
> and unpredictable. It *should* be marked as obsolescent, but was not,
> due solely "because of its extremely widespread use in historical
> applications".
> 
> POSIX doesn't require the -n option, and although its behavior is
> reliable in `#!/bin/bash` scripts, this configure script uses
> `#!/bin/sh` and cannot rely on echo -n.
> 
> The use of printf even without newline suppression or backslash
> character sequences is nicer for consistency, since there are a variety
> of ways it can go wrong with echo including "echoing the value of a
> shell or environment variable".
> 
> See:
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
> https://cfajohnson.com/shell/cus-faq.html#Q0b
> ---

This is needless churn, it works now, and bash is never going
to remove the echo command. The script only has to work on Linux.

Plus, the patch is missing signed-off-by.

