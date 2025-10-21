Return-Path: <netdev+bounces-231086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E5BF4AE1
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D1818A1C18
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 06:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1037221D96;
	Tue, 21 Oct 2025 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECWE7VUr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7CA86340
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761026889; cv=none; b=CswkGRvc4eM1qny2TBoiuqON9a7yHVPbE6nLP4F1dvo5MLWyhyA0ZenDfdrNy4E9AIBIAjuQ2V8+hiyHcKXEnWs+1qib3b4m/qneE1KpQ8AI+Wg/gzNt4Gl3w1UnWSs0Cbr2WQCYgUnIUMZZ76zn16XvtuTgbmk12L8DdomDvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761026889; c=relaxed/simple;
	bh=kW2jruBPRdBctRqeeJSdxdO8emjkjYgWUJ5leR1MrbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apZvW+d6IQ4yeJn3tpiVVLLwzOVxVW4J/o/xQYc/9UMIwAwaWs6+w9Y2kFR5hPOP14SYpx2Jd5faAy1b3Dqno/9+3TtqUWfBTNQm0rX/fuhhdVMOLm/bauXAA+qbDMxNiEnkAUctwl/okWvG8TJWUH2Wm3+S//5KuaHoWU/1ojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECWE7VUr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290d14e5c9aso47368675ad.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761026887; x=1761631687; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JZA0Ue2GDfrkpsuZqD2YR0mNW99OBGr39IQjyVNFxn0=;
        b=ECWE7VUrglEpzM83eh39Qc+5J/kTs+JP/EltRvS19uQb8DkTJDXiXMOvbIU3o2bGgT
         N6ANg193AbaOVNP1d/H9+3A8sBQsvbtgAOpW7SnY+ncQA81biJfP0qieekR05Ul9V24R
         +nfZrBEMG8gDCfDc5LwJ6391UGg1v18NUbWq0IZNeqPGZ4AnoE3tkux6+ATDI0tOIFeX
         a1ms99DtpPDFN/r6SIZEbLOzxjRwDmLsVACda+6JPX7UwFxzd3CttuV4vchYOZPXwGNA
         qM16iWMZyAgYLSU0geD16Hj0gG4TDyruD/AP0TqJii6tCeP6fN3pwpaEjGUUdjeTK7+2
         P08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761026887; x=1761631687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZA0Ue2GDfrkpsuZqD2YR0mNW99OBGr39IQjyVNFxn0=;
        b=VkkYZz7mZI8ef447rrLsjsgIgbgOJxKi1NTtoItWB9ltUdtVVhTDMr0oCxt1Z9C5bt
         dYqyze78uRlfwORQamKq33JW+XZTn3pBLYFzpKd2/bORV6hhBooE+UmLxUTIixz5/+3h
         rF/+Jmnyh8qqXiDDUEEi7rmtezgvJHCLJD2OGkMiPrq7JXhgsekBr2JszztlYQJdDu1R
         HXTg6WUpJsUNZoBAOOlJd2rVw/Bmhk0LBZloaBh27OM84v/mWp72DkJwWu6JROB1w/UP
         Mq2J504NK3SUBJ3+sFebqKqu1sKarprnoWrVdNJ1LkDuvBwFN5H6r96x7/vpOfQ7i3OJ
         0IgA==
X-Forwarded-Encrypted: i=1; AJvYcCUG7qjbUtw1NFolzwDGmH0jPOxWB0Ie+54v/dDkCVnN+xlB0lgh8yN4dwsR+KPUePTE3Als9lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvyqLXo/r8obVgNFkqquNNPqHLaPzKVF/2iP6VTyS4UEKdhAim
	j7cX9cAuqaMFcEEjL0QFpmMv8M/zK3aN7fJADHsZAnwJa201mdI8oaLx
X-Gm-Gg: ASbGnctVB70GQ4v2lj+HvRmMv1CNTrSknMgEw+9T43do9D9aeFmtJ45nzVdXefFK+RG
	eYc9XCKxTmg9wVMVRwQGBW9LvWES5Qlw065RkalA20ovvEKj7vIJ6l6+4yOlVIaFHgau6KmD/k2
	j+4MihO6mf3MXd46sSv0gWy8fijNjss79hWTfeJYOUNZY3wIXNq0zsMPjdRlCTak1+4VOhapx0/
	dwvoSXy1DRwN+ksUo9RzAmTtLWKOI9hInVI6VlQ1LXKo02OQxvVerUMrXQ0zhQZ4lRLwSqusxWK
	eGfIhCVG4g1PA3GRpcIgwKZ0J/gANLZ+hpL+XiVIZmArMOzt61O06OWtvZ9EmCXvP5isk6Lv4/M
	a/Mt2qcneEafFbKNbAa0kmb74D3Itdjbmd0iGeNjE5EB24ZXeCbUDgDmZbxGen0fVJRRYjdxP1q
	pJgFtnde3mqGMz
X-Google-Smtp-Source: AGHT+IF4szidgImMy6JtzmNhdka6GXzdHSmzfeJ02cyoVnK4ZTTiJvVSBgJubN/2RJ99DIpJ5YgyIA==
X-Received: by 2002:a17:903:2b06:b0:269:b30c:c9b8 with SMTP id d9443c01a7336-290cba4e91fmr191618565ad.56.1761026887086;
        Mon, 20 Oct 2025 23:08:07 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:65c6:c7c0:4ab8:5af3:6a1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcd7sm98252465ad.77.2025.10.20.23.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 23:08:06 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:37:59 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: --cc=andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	i.shihao.999@gmail.com, kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH  net-next v2]: 3c515: replace cleanup_module with __exit
Message-ID: <aPcjP24rdKSLmM5g@fedora>
References: <20251018052541.124365-1-i.shihao.999@gmail.com>
 <aPYxbwjIlyPHrTY3@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPYxbwjIlyPHrTY3@horms.kernel.org>

> Thanks for the update.
> The code changes in this version look good to me.
> 
> One minor nit: the whitespace in the subject look slightly off.
> There is probably no need to repost because of this.
> But I would have gone for:
> 
> Subject: [PATCH net-next v2] 3c515: replace cleanup_module with __exit
> 
> But overall this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks, Simon

I’ll make sure correct  whitespace formatting next time.  
Appreciate the review. Thanks for your time.

Best regards,
Shi Hao

