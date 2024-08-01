Return-Path: <netdev+bounces-115072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB5B945068
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D892819B7
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F181B3F0A;
	Thu,  1 Aug 2024 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2thyFqR8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138F1EB498
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529322; cv=none; b=czsfT4a1Mxdra/64vPpCvlqHFkYGJOXUfj4eW+xFvXgmLkoL2lSDK3rCJyFWWyZg12EGFp8QrfqNPKyDnHLSshXQghaKYmsqvkVdfkBigPr3g5vVjhY5/ywnW6Q/ZWScybXlNRGiuFsaQ/47bmZcK3ahS4uzGttDmrmNUmon4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529322; c=relaxed/simple;
	bh=234uavgHIBFyCN/c3aq8AyX9eSQ+Tq3G5JptozUJhEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYDeU7HLmnPYyzSdegIsyyTmdi1ev8vUBrB6zUNKQ3IyObAbJgfj3PMUEwX3wD9JKFy+Iz3Am8b1sqV1ePnrOW+r5FqiAlWKL5L3YsQ34G6EzR8GnO0ni5Gp6oN4vmtc2Spbl0wzSQ36RaMxLxBBYVLgDsB/TtKMZqzvlEeGFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2thyFqR8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso5881770b3a.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1722529319; x=1723134119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXAPbL+AnsZVkiuzy6vBy30+2S6eouEGeQuwM0uU4k0=;
        b=2thyFqR8nx/1pCgwzSKhD/U+pPjLtOq4FK0JpufGnb0w9wPEElLRt4vyZftIDUQf5t
         5NHQ2nNbw2BLb+rGJK3qPETKLJjvQd0e6lCiSTfgHCYjrUOITuj9EXZAuM/beJfnDcLZ
         GMdfO2tNynqZ+0ZR2ZloeyDPAQ9hzY6yxWuGVaNpNqtD1Bfo+0nSlJvGJPbKcPNekhgp
         Z0YU0ejf4H1E2L/7/JRg+5mS6IRo+rLGZUsC60BUcWb70pvd9xQz+7xkzZofB1BaHXm5
         cRPiESPTRN9fbIANv2cJLgd5b/im/JfNjCeGPaJ010670vYXbEqBmbFss4dOy4Z/mP9L
         fAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529319; x=1723134119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXAPbL+AnsZVkiuzy6vBy30+2S6eouEGeQuwM0uU4k0=;
        b=LM8/J2D69M8BMV5HrrfTUfsrxoAYl5H2f/hW3+tpkw3KPo0aN9A9FGr4Zv6+XKWtnZ
         x+CG1vASLpPnvhZQ9gKOStYjsfALExh6vVpW1REYEDiePm2paBeN2hI8xnLDknuNnRGb
         ugch0iSPJfV9eM0XGO6oTLwF+CUTtRrCuLliXH9kU9Jah8AVaDh/ZpkCGN2ZO4Qfd3fX
         UjUQ5J2U1YqVtMDN5wtPzi+ORfVp/6pKRBq7f1BVzWGunYpIdQ9NRJ8XVFLpK+RQLcrW
         Tn6JP9aGw9fkDBHv2jqN3oOvO4g6J9L6DnrCg4DLNJHtS9cAkyQ9MGgcq3HhL65kBtbM
         VTiw==
X-Forwarded-Encrypted: i=1; AJvYcCWOTPaPZtTzWVinUHbbi6vPKtnYm8MrJbO124XnRNx8LvyfupiQyx38Ka+0sucesyTpAl6RHlQ7iShM5lDxdy9eDkwfjFoc
X-Gm-Message-State: AOJu0YzgB3G4pdzwL6R8LDL6Ei9O4homBllwVY4cssulJEb8bcBAfTZk
	39RlDpAjUs2yMzfZ3qiG9ouqd1X1SJ8s+eZtz8TiiVUKXtbQbG7fCsWlsrkbpmc=
X-Google-Smtp-Source: AGHT+IGDF+njCgVG1PqRcQFFypdiRI9KB6NqMDbVC90mVeAOQyHBQunQ4jrU2o13qdOxvhaoggbzEA==
X-Received: by 2002:a05:6a00:91a6:b0:706:5cd9:655d with SMTP id d2e1a72fcca58-7106d04749fmr878998b3a.22.1722529318747;
        Thu, 01 Aug 2024 09:21:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec400e4sm21445b3a.62.2024.08.01.09.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:21:58 -0700 (PDT)
Date: Thu, 1 Aug 2024 09:21:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thevlad@fb.com, thepacketgeek@gmail.com,
 riel@surriel.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 6/6] net: netconsole: Defer netpoll cleanup to
 avoid lock release during list traversal
Message-ID: <20240801092156.2bb27a27@hermes.local>
In-Reply-To: <20240801161213.2707132-7-leitao@debian.org>
References: <20240801161213.2707132-1-leitao@debian.org>
	<20240801161213.2707132-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 09:12:03 -0700
Breno Leitao <leitao@debian.org> wrote:

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index eb9799edb95b..dd984ee4a564 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -37,6 +37,7 @@
>  #include <linux/configfs.h>
>  #include <linux/etherdevice.h>
>  #include <linux/utsname.h>
> +#include <linux/rtnetlink.h>
>  
>  MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");

Should the Maintainer part be removed from the AUTHOR string by now?

