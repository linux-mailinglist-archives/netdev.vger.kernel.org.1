Return-Path: <netdev+bounces-71487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA8853949
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D01C267B2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6660DD3;
	Tue, 13 Feb 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YmQdptuL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB160DC8
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847061; cv=none; b=J8NMHxnA56GLEfr3F6JfdrH3PKqnEEyEVuQOdhU/y3xI367WfLKyM69hhQDirXDfSm11PvVwmR9Hv7Dm3q0wHMsaJVPpbbi04y5rNF0y+eYR4zgRv7qaatJf5ZnjwWVNfEmtFYrrqQlLZQbFgtj+G7xr7odmWINGIflZvdNstI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847061; c=relaxed/simple;
	bh=mzkb144e0NW42eo6oZ2glolC5rnBygkOh58rUHmMWV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsLGLwLLJBrEFf2VVAPwaynKsxkjPVtBQbSGKkXu+CGCWVlu6MdEcBDAYmSIirrS7jE1kmj+VDnrr7rXete1nhekcRpsfLP5mlO0f52gubqQPCVUVf/pCxsjVy2kkynf0639sORLsxNHwTT9cZ8ANU8nom805M6HlmP3GdisMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YmQdptuL; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2e44aad03so1420377a34.2
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707847059; x=1708451859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TosQgHYmNmcrCVsxzpW3Hrt1D9gkfZ69Zo+egpu0V9g=;
        b=YmQdptuLCXabp8CBE3bXlx4ztiuOGG1RpNjKzOmXdy959hslBnI577jNeerLurdZFo
         lmRoiFj14zJ/rXQrrEyzopvgIVSy0dZhK7mOYu7KMSEdh2iHyHB7qLq5kvQfzA+/ch8s
         euvwnwdONU+wIuweujRh/+nZmEyd2ySyVO9Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847059; x=1708451859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TosQgHYmNmcrCVsxzpW3Hrt1D9gkfZ69Zo+egpu0V9g=;
        b=ast93jljr1nJIROAaLV9RpDbeLVv47KdjepnTRFF+Xw2SzsoPLUAMoALh06fAbzYQ7
         mXk+SKvPnkd5qsSx5++JNexJOk6+SxS6uwNqvcH0vVTpUUiwc53jkPGxiRdGRsMZ7La8
         ydD4RRX5ZfBwL9PLkctqgsrNcfg4qEyv9vHjFNEHvv4i+44yYT1xRod2FprPMc8tfyhP
         xPe3IgiT8aeZOqWO345G/E2W36z1HBQzaFzpLbjAuKn9tEfS7yKSt4w26Oyg/z21+ZmA
         MigDZFd/xjvBzfXwCrUrtkALkc9idOIkzvsVPOCS/FgQQZUhNlTLd/c6jOP8zSb/e4uh
         mREw==
X-Forwarded-Encrypted: i=1; AJvYcCU9pS+ii1fWEpN1+T2EltZTfmKgH7nFsctebiDqCxg6Vj0QVjo6a4mMv1q/MchGJgWYNsvb7po75bh91ltoknpNDcWCSJgw
X-Gm-Message-State: AOJu0YyIW410xp0Ni32CiRyDFt3wMTjsidwh4/TiCFA0SqF94MKuwiBL
	dLf9WaZ1bYCLcQnmYRZrsJ1ZktpETJkOyCPK4MmwYpqt8ogkjciAvfW7AUmn5w==
X-Google-Smtp-Source: AGHT+IFCbZM+b104gnRGdedYpGNTS4oBTTu0IiBU9Iwu/rIirgHxDAHg0987g8ZzLYF9cUwgBDA7Kg==
X-Received: by 2002:a9d:7755:0:b0:6e2:f432:29c8 with SMTP id t21-20020a9d7755000000b006e2f43229c8mr367759otl.15.1707847058743;
        Tue, 13 Feb 2024 09:57:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdGxW2ftWMHh0JC3cGkEcY9/lK1HpWR+bRy1IS644SeaJqbXnH5g4VAoHN7BgBiHA/BAsLKLcDHowUL5KgUS6iv0jUuyhQLdbUsTAqR/DGq/GEcQNwrJgTtVRoKM6avc6UEMBbwsuFfi+MwVNzU5u0wx7ovsQxPF2BgwDBqQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m186-20020a6326c3000000b005d34cf68664sm2747606pgm.25.2024.02.13.09.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:57:38 -0800 (PST)
Date: Tue, 13 Feb 2024 09:57:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next 4/4] selftests: ip_local_port_range: use XFAIL
 instead of SKIP
Message-ID: <202402130957.769D44F@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213154416.422739-5-kuba@kernel.org>

On Tue, Feb 13, 2024 at 07:44:16AM -0800, Jakub Kicinski wrote:
> SCTP does not support IP_LOCAL_PORT_RANGE and we know it,
> so use XFAIL instead of SKIP.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

