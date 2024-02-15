Return-Path: <netdev+bounces-72205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D8856FC9
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 23:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3940C1F2392E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2584913F001;
	Thu, 15 Feb 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGcT8oe6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E3913AA23
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034821; cv=none; b=D9d1lHssS7WhR522n1O2lmRVLvZjtV31+BolmBYzIbheFFJPmfLJC62WYH+P42TQqInL1syZqzLqditbg5SYW+I55XImyIrJRhWEi+I6NOGpFyq1lnYuuB4OnGu9OsMIpXyHE4TProWw2OEN9cxD3tRsbnoNJcr1C6vaZyF5oI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034821; c=relaxed/simple;
	bh=ZgvelDU9KNPB5cTVF1BKnDjpvbagWvhWEorW/eraFZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPduX9Nis4UXr3cs3RBTWLt5euseKU1QVwVOzCKjNdK3KlT3gd7Ruyp22pUdWszMgs3rOqExweQdDD9e2tiKsg9tgM3NfxCUyqu6wsb92gx/jY8djeO14wcKvg691dAKPL1AaHX1ailGiVOGplmQQdPAfbigM3Js4RTLF+QPqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UGcT8oe6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1179413a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708034819; x=1708639619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrSil7hRhvX+wCbBcD7NKiANESmwe8FMH7EDhSO+8kg=;
        b=UGcT8oe60TrSWVFuGg1neWWlhDhaqt1Oqp4TnE6lOr//+hYlUk5DRe9RoJQOl6s9PZ
         4zVVgEtAviODTzyMPbJre8A6ldXzPTNwUnXH6i7MYm+lvq4rD2yiTpxfvpSvqFXWFBOe
         A101RaUgdb4SyYS6qq87datMk56NbKuYFLI4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708034819; x=1708639619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrSil7hRhvX+wCbBcD7NKiANESmwe8FMH7EDhSO+8kg=;
        b=cnYWwsSN3161IK7yLOQJ5xCXtjkWtQIKDCp/gmki+jqPs9Kdpxag04PfI9GYZnybso
         XOGc5vltlbBx6QeURtrsZ8oUAkO3PTaGai85n5/1b28pDxMW75qkvuL6j1FsGPMGZUPU
         bKkk6gbNENbr53enB0Zp35dnnj10G5Ega74MSUF2DS/nyfANlZfzWXsJ0u0e61glLcpn
         Ugf2xMgd/1m7brNFR2TiHnQC6rYMEskvXMm0UD9JcoCMWh/1MnTFIBEMq/3BJgIbVsar
         fjMRv8Qorr3fo1jvrfSv4kd0vKw01k1oQt9XTqIY3vTRREuQQQRC+5qkX7YbhD+ZTVB4
         kvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk0SgNghS8QSjDzXvlSosnPoJJ0882BQ8v04YWlsYV3ZFHgwDIexS+yGocFt5yFBawMEA+eD4eWOEcZC8dFy8zJ41V3ydj
X-Gm-Message-State: AOJu0Yy8CVvCAffRWODf05HWcXd1VnplDR2op0U/mjRK05qeCikNNKsz
	iza48kQqtWUxTWB8AjZ5dd0rSif99T+lJXG5ahJc9FlmnQWC6iHb0LMfZxYk08nIcWXh6gDRZDo
	=
X-Google-Smtp-Source: AGHT+IF1w86S40JOuV9Ny84Cmq3IFz/IIrVBGVJ+EuByYSVgI/HIO9Ky5h+Gd+VtLDwwoSrmxxcjdQ==
X-Received: by 2002:a05:6a20:21d2:b0:19e:cbe9:63a with SMTP id p18-20020a056a2021d200b0019ecbe9063amr2464783pzb.28.1708034819038;
        Thu, 15 Feb 2024 14:06:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p29-20020a63951d000000b005cfbdf71baasm1913015pgd.47.2024.02.15.14.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:06:58 -0800 (PST)
Date: Thu, 15 Feb 2024 14:06:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next 3/4] selftests: kselftest_harness: support using
 xfail
Message-ID: <202402151404.0CAF526@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213154416.422739-4-kuba@kernel.org>

On Tue, Feb 13, 2024 at 07:44:15AM -0800, Jakub Kicinski wrote:
> [...]
> +/**
> + * XFAIL()
> + *
> + * @statement: statement to run after reporting XFAIL
> + * @fmt: format string
> + * @...: optional arguments
> + *
> + * .. code-block:: c
> + *
> + *     XFAIL(statement, fmt, ...);
> + *
> + * This forces a "pass" after reporting why something is expected to fail,
> + * and runs "statement", which is usually "return" or "goto skip".
> + */
> +#define XFAIL(statement, fmt, ...) do { \
> +	snprintf(_metadata->results->reason, \
> +		 sizeof(_metadata->results->reason), fmt, ##__VA_ARGS__); \
> +	if (TH_LOG_ENABLED) { \
> +		fprintf(TH_LOG_STREAM, "#      XFAIL      %s\n", \

Oh! I just noticed this while testing changes to use XFAIL, there is an
alignment issue: one too many spaces after "XFAIL" above, which leads
to misaligned output.

		fprintf(TH_LOG_STREAM, "#      XFAIL      %s\n", \
                fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \

Compare the position of "%s" above...

-- 
Kees Cook

