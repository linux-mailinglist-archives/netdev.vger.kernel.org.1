Return-Path: <netdev+bounces-242886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 201F3C95AFB
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 05:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECA074E0540
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 04:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455281E47C5;
	Mon,  1 Dec 2025 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKX24BN1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291413A88C
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764562082; cv=none; b=fi9eUtWGrhXUMmGQbdt/0XSm8elwLMEeavSWVdq75ylpkEYEuveY54XBaj/1oW7p9dY5ahCtC4Gjm+bWY2uEaViUkSPQFNZ7uomIKzBmaaNblhoy82WGzC+exC5xvMMCrRYiTd+1l+iUFd6xYQUL1AbUQ55gHJqtCQHsOEi6pMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764562082; c=relaxed/simple;
	bh=I5WnbEMYMvxMMyC0dGDFfkJkD1UwMDR1rRygcGxyK70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E86Il+mFKzqAzgL20HdKvfAl8tjLPk4OkUGO49GyV1B12ip+BXXbWHMQIaI6tlXrazidy4hmZu0YOR8bi9GO9iOYO7MqIwyANAsGTCQxcWOzpwTgPnBbeRhnvBe9TErzOWY/XeQsPKxSVszupaFQS19H1vgMhRMyTigGUtx4kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKX24BN1; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-343ff854297so4899697a91.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 20:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764562080; x=1765166880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHYB6uxWCS1cMIYtl4torJ0Vkz15tXZo+qs17i5jW2c=;
        b=PKX24BN1VHfnGnfG0wJANp/3qY8+b9GPJ+0AcBC1Fe1R3x4daGkWoKtcDjEe7UN376
         l0pxh9HFeafIYzxMot56Iorg+NhxGv6svrxCFpmHahOdE/2uw7ugRDbYpL3pwVtn989o
         aTNOB3RlhDCmfTq5D4oNMFN46oN/adtnu963Mk+WDAIkI2XboVyWHkZsAPVmM1unqzrL
         sdVZHsmgRrhd0K6MtCRf3l08cgDC+mvkSMhGCATkgChLFKCq1+AIudQiq5AC5naKwAcx
         CxRVutgH6i1TX9oZMWO6dEG1bXCCwqpk4GbjPScr3hAANWvyU+w1hGhQeeLsNOaY+fXu
         W5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764562080; x=1765166880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHYB6uxWCS1cMIYtl4torJ0Vkz15tXZo+qs17i5jW2c=;
        b=c9s1uyGEYsmealdMzLGvil3iN3WNGNQn6AU5kIruP0fa7Vy7nUMbIXQEoFlD4YFB1q
         pgUnL1pJEfTi2Q+K7dtgDqtXjvXWjKr4fcbZu9JTC9IByb5H8P0UPL/ZeQlWVU6m241g
         ve4TSrR7Z9xaScwB30S4yXk1C7jYiduINS94tGq635CmNfdLNJLvbqPVYv56TPp4VTa8
         EGzoh8YdAAVx/qrbgc5JPk6TPDrOLihYuy5cjZ3gbrsHPjKsLhTOR5JYUplsaaHmVnna
         sczGXUHlep3vkvZ8npEEnyUqTIy4T46QkueRQ5kXXB4g7UjLuRKqUdTRNYpvbJHCEWBY
         kYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWxKw2850K1eJyF//KV5fzgB7bttxeBhNINdfPEZyjd9mz15H+kWIpX5TTJyL6fi+dOltR+gA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6y5Ab/T/gyye9BUXR3Ve2aJ8qu7DqBCCtKyav+5UzFkQ6flMf
	CD04fWb0p6nLe/hyI+aSPXEOeJi9X0lr0MO0f2EOCuBmqKmu8zJvc07N
X-Gm-Gg: ASbGnctnCQoUGrjap1w19oMa56pRuEXVeobodmJ+ZtZ0396UqqGZhnfOQwnhXuZqWzW
	/g5IKqTd6HTlBZ5H9SYEfUEAlPSmaLHHIX4bfo7cytlTfIBmxwwlrjUVJ98oe8Zq2VsxD2cZsvg
	MS0L5hoHnx2rYDx1k3t3NoGrH3eHd0gxTnNfIn6WN3Th8eanHlJiBThEiLcGAUhaqKtkGiS4EZX
	hlMvUOWO74ZJtVnWiGmxkbGRSBSKPDN/IWnAixC9gkAvqSiTu9ftLxUr9iXrRFVAymjS4U9rfyT
	vhT+J7Z3fiQ5pEr4iWkm/dU4viYoswwAT/tqVR6fJf9+4h390yneo3e4eyNx5t303yRSB8kMdBP
	EwvQUWmkZ4u0WVM3EjP6no3X7vfkdWWrUfvMHS/xSePyB0N9djgXfSthDpwkXrJ4VKC01j4YWgH
	LTKglKIgBtINEedNeXlF8Z+6JhZgCucSyjNl83go5U
X-Google-Smtp-Source: AGHT+IGPl5jq66QKAxKuT1zbMmX7cVCg83U7Ow4OS33Os0vlctAPTudYRAxHElLQlJEOckDjjbES5A==
X-Received: by 2002:a17:90b:48c5:b0:345:badf:f1b7 with SMTP id 98e67ed59e1d1-34733f3eb64mr33856675a91.28.1764562079912;
        Sun, 30 Nov 2025 20:07:59 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477aeb88a1sm11486769a91.0.2025.11.30.20.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 20:07:59 -0800 (PST)
Date: Mon, 1 Dec 2025 09:37:50 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: mptcp: Mark xerror __noreturn
Message-ID: <aS0UlhHP5aEzDZlv@fedora>
References: <20251129043808.16714-1-ankitkhushwaha.linux@gmail.com>
 <632d57cf-becd-4d09-bb21-0e3db6776c49@kernel.org>
 <20251129174133.0e369f80@kernel.org>
 <d4656eca-3c65-407b-a487-0a1816c38036@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4656eca-3c65-407b-a487-0a1816c38036@kernel.org>

Hi Matthieu, Jakub,

On Sun, Nov 30, 2025 at 06:09:18PM +0100, Matthieu Baerts wrote:
> Hi Jakub, Ankit,
> 
> On 30/11/2025 02:41, Jakub Kicinski wrote:
> > On Sat, 29 Nov 2025 19:13:08 +0100 Matthieu Baerts wrote:
> >>> +$(OUTPUT)/mptcp_connect: CFLAGS += -I$(top_srcdir)/tools/include
> >>> +$(OUTPUT)/mptcp_sockopt: CFLAGS += -I$(top_srcdir)/tools/include
> >>> +$(OUTPUT)/mptcp_inq: CFLAGS += -I$(top_srcdir)/tools/include  
> > 
> > I believe this is being added via MM or kselftest tree at level of the
> > main ksft makefile. Since this is a false positive, maybe let's defer
> > fixing the issue until after the merge window? When the -I.. flag
> > will be implicitly in place?
> 
> @Ankit: do you mind sending a v3 without the modifications of the
> Makefile, and supporting die_perror() in a bit more than 2 weeks or
> later, please?

I will surely send v3 patch after merge window with the requested
changes.

Thanks,
-- Ankit

