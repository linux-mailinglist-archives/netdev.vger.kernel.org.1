Return-Path: <netdev+bounces-73489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5D85CCF9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AA81C20D8E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FCA1841;
	Wed, 21 Feb 2024 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lE0dubW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623317D5
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476620; cv=none; b=mn5Kl0oEar+ZbNzL/BbOL1yNhzLMrSbSS5b4RAeGYicb7AIN64HnNbasB5vRqWhe4zT3V91DEsqEO09qvaHtV0m9kYLLYiNXULMuro/C3D0DGRXAzNXMD7paMCn7UcGc60OTN8gvB/ZSHdMSCAdAxYwcTtOK0ALASBKWt1Nv5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476620; c=relaxed/simple;
	bh=f9TmN17be0BaI4aB4G2ImJIieb6TnIzTskoR+maJi9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddvdHUAuHuLC7etSkZKwlTc6Fu6Zy9Vt3iw9t/M0qgHWCMVfcQCqx8AhVbtzOhl0mbjYS6nlZol93Qahmc4reok37ADfPKIV76xMiD739Ok4i0/Sq+6hpOCxeeJgkusEYkbYMKf4kQDiYsssjTCN6YwwFVlLfWJs2teByGMUVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lE0dubW5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d93edfa76dso37775845ad.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 16:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476619; x=1709081419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKM5GL8m3XPROV8hICjNZ8s5cqcbwcRO2YeI2T2e7Ec=;
        b=lE0dubW5kPAvNG0fg01b8yevuMMXGZdrQ0IfjtD25Otmsy2zKUackh8v8Jwi/fTUq1
         sCyxU9NM5j5egrHrsW9VBZ6zbKMLJ0Cfs725Chds6rECRRybcCFMsQU4776s6kZwDNY0
         3nmQmMA9j+HJUuV7NVGt7Lw/a0wCFfZ6N0Wv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476619; x=1709081419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKM5GL8m3XPROV8hICjNZ8s5cqcbwcRO2YeI2T2e7Ec=;
        b=IYrsbN+6aBassYTvHkus/olC/3fBwl/JR2Pvm520S5CajlsbJm5u+xcR2D81yD7bZo
         gK1tRGTEmu87hAnRsoj9ooar5ybeJua/xhy9UuMmaBuvDylCJIsDoxpDLEwMxy+bLihz
         DiwyIEq9uB1VQA9N+WjgjXYBjldcKEuUtrlNBeDLBJG64PwvAISwH/Q3cvX7obbHO2rl
         gWasQNsaKqqXDaHsbnGcEerlTeVGx4ejdgWWb66S01I268UrZx+ixRuIOCNJdatJPptw
         Iv62ImS5hf6vwu6/46MKxPCfEcY2VSW7Fs5dH1C7tXF64yJ4hO8L6kPcWB3pEDToq8a4
         IY4A==
X-Forwarded-Encrypted: i=1; AJvYcCWgqgeY6YSF73B6Tj2HYmVjCz5g0hxg7dIPKADBt7dz3wt78j7K040Jhjy6OQr2OAxOGhUr3Z59vznPEPTymPlhLmqrlr/B
X-Gm-Message-State: AOJu0YwxyAQo+bCZz66FxBqpaFnO5PEK1D+/dN3hum3RnnG9GQZ9C6b0
	jRf5CHIrJbhAeFhDVDuNr5pGQ++nuMeTWcwGYzx8McwtAR12/G5s1WIlV0Oz4w==
X-Google-Smtp-Source: AGHT+IEazzxps3jRajILlFOY+5/E6qDJS761uzHL3rRBg0GvHV+XLM76OnqMweREN/0hvlp4UejQSw==
X-Received: by 2002:a17:902:f68f:b0:1db:ca53:41d with SMTP id l15-20020a170902f68f00b001dbca53041dmr15021488plg.31.1708476618971;
        Tue, 20 Feb 2024 16:50:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kx11-20020a170902f94b00b001dbad2172cbsm6863205plb.8.2024.02.20.16.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:50:18 -0800 (PST)
Date: Tue, 20 Feb 2024 16:50:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 07/11] selftests: kselftest_harness: print
 test name for SKIP
Message-ID: <202402201650.5B12F716@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-8-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:31AM -0800, Jakub Kicinski wrote:
> Jakub points out that for parsers it's rather useful to always
> have the test name on the result line. Currently if we SKIP
> (or soon XFAIL or XPASS), we will print:
> 
> ok 17 # SKIP SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> 
>      ^
>      no test name
> 
> Always print the test name.
> KTAP format seems to allow or even call for it, per:
> https://docs.kernel.org/dev-tools/ktap.html
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Link: https://lore.kernel.org/all/87jzn6lnou.fsf@cloudflare.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

