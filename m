Return-Path: <netdev+bounces-224160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E36B815B6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24771C2559E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBF52FE581;
	Wed, 17 Sep 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="f/w4ebSq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C726D4C4
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134239; cv=none; b=U2QujBVIK4OHk/ZdpAw4+nYMFOF038VYut4SXVEMjSHqAN801LYzZNDi2d5Al3jryJkHSatajThihTL5ShJtDW8fdJt5TnSjFqbL3qrsolK8/PclVHmOQSg+x7u2vazKYtEqgB4BjvvVZWzMFAQ211Rw5+/0DKr5MrRLzKqhJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134239; c=relaxed/simple;
	bh=d/cXv9TJ2gZky00AHUpOB7Iu2f9ruX+BgUBAGnFflZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPTz9DVaQPsToDmnqjhl4RM04y40MFwetIhzmKLZIwZvO+3KDSmM6HlzR5BohpAaF9HmW5667GBLo8WqXJuPPoI9AJJJZghHvHefyAT5/kJFcEydQbgemFCyOQWCepm4+UcTm/SiG1tAlyKYhsOuNlYgbFtfGLNjJ8l3U1HtaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=f/w4ebSq; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-81076e81a23so18371085a.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758134235; x=1758739035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALzpm41EAiaTvICdkzCMrTUL/bFHqE33rx1kUd5U0Ig=;
        b=f/w4ebSqe+BTueM9YV71jV3S84EEREnoSyuAgqxob46nbh//Zm1blCQhp31IduMWij
         eUynh9aK8WvqtFgX/mOgTSx9Z9cHPLhz4v3KnoD6EQsj3HCI5Q1blqn3FChatpdYvhuD
         eeflJhhsQFV184y20Fu4U1LUrYVw3F7wZ9F1kFW20C/K0J8nHIus7Ji7X6W3tRojx3l1
         DeiQGMBvr61O5hHIwg29sjQZy5yK/pgDd1t4tr1sIOCTxAyuOPbUFzZv4fa4c94gJXWI
         WVtbCITbHOu9j/qUpqisNlM1YqFZs2IjYkvBXJOG7IRrtuNci+MqxMJsfbYsxF9OeldG
         6QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758134235; x=1758739035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALzpm41EAiaTvICdkzCMrTUL/bFHqE33rx1kUd5U0Ig=;
        b=YbqPpmyHgqJ1c9H43vhVK/IU8bwKGa+sFmysCRnYSPKaVGzScZfhcLnp8dZFBho2m4
         iv4q66zg1d6YQ8XZ5xFhAAynIv3eRWyZFpHycqGnxWxcy4HejYn2UE2LyxlRugyygD/e
         o/tBgaJQAKYlZ4hepXhvvAuN/C8jWYZ11qxPjZDAgF1bCFPQoUzNduR5fGf+OohTUUKZ
         WKMUJ4LebAfnsaqHJP4+Vly8Wv6QeJ+qz9ufFa1Ver96vEWN9vFqs20pYNNDtCuE7/XX
         yYacoIlxybLg+0mKlluAYNm8+z/MWyKAfT7Vlx620LzArhzCeOoz6jty9UBIYfw7TbJJ
         HPcw==
X-Gm-Message-State: AOJu0YyZYNi3t9OJv8Kj+THZYjhP1i605LnOPhSFo7lgkCzGFU7p7iYb
	Dpn7hZpt0v6G4kMk/HFO7Fu7VUhnekWvOtrJhhBBGf6ZpNNcyE/z+9uVeiyCOUIYhE5sk7Z7mw2
	JFfdw
X-Gm-Gg: ASbGncskqzHvUMS//BIaVpND2QpF5paAL8g8RRXPWYsekir0n4fQI9Il/4QR7Cnq69n
	5JzBh2Kx2Qg9TY/v3DlLVuPgPketc9VRuocNM57LrJmk8+Xv8m8zt7L4fK23wbi+vy/Lk6od5LU
	iESLxHdy1s0vpT49MrgU+VLnWJoLOaS1f8nXj8wOqr8pdQjsWD8IfBMpzxPXHpCvjyZ3H6MhZ1p
	IgSneOnQc+i7rf8eGPO2WchUSfnXOxBQFnOeRP6Ta3fuRyNiRyaPxccATQfYtvWyRG+V03rJy1Z
	zcbG1koeaPlpvdl13UjHiQJoP5NpvsoeYokTVTSDqJwzy8G8vfymhToXaMs1/pdAT/ebQIUDkwO
	rSJ+KsKCb143eK8osQKWQq5cOt7+I1vOzaaMIn+HM1+neBOY/o8yEZS3CnPPVuyATwmER+Ox6GU
	A=
X-Google-Smtp-Source: AGHT+IHIRQvwEpq0oA/caQr65AoRiReE6U3a9fBAd+cRFw59ch8vIjUp8BduzOFrExFM8w5vXd7ZGg==
X-Received: by 2002:a05:620a:199f:b0:82a:7a99:6650 with SMTP id af79cd13be357-83115bb0cc0mr390825585a.65.1758134234910;
        Wed, 17 Sep 2025 11:37:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83627d7d9c5sm27392685a.20.2025.09.17.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 11:37:14 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:37:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Malat <oss@malat.biz>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, sbhatta@marvell.com
Subject: Re: [PATCH] ethernet: rvu-af: Remove slash from the driver name
Message-ID: <20250917113710.75b5f9db@hermes.local>
In-Reply-To: <20250917071229.1742013-1-oss@malat.biz>
References: <20250917071229.1742013-1-oss@malat.biz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 09:12:30 +0200
Petr Malat <oss@malat.biz> wrote:

> Having a slash in the driver name leads to EIO being returned while
> reading /sys/module/rvu_af/drivers content.
> 
> Remove DRV_STRING as it's not used anywhere.
> 
> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index 0c46ba8a5adc..69324ae09397 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -21,8 +21,7 @@
>  #include "rvu.h"
>  #include "lmac_common.h"
>  
> -#define DRV_NAME	"Marvell-CGX/RPM"
> -#define DRV_STRING      "Marvell CGX/RPM Driver"
> +#define DRV_NAME	"Marvell-CGX-RPM"
>  
>  #define CGX_RX_STAT_GLOBAL_INDEX	9
>  
Please add

Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")


