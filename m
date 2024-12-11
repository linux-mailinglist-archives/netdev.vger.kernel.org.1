Return-Path: <netdev+bounces-151149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CC19ED06A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF15C1617F3
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941A1D63E6;
	Wed, 11 Dec 2024 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3pTggp2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625C1D63D3
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932153; cv=none; b=g0+xvGFcJ5JHxN57G9rEEPlcpC54hZvrCO/axbTMFn5ZlEbqsDx6XksOBBKM+9ChrTuUlmAKSRFbhkHQHQMsg8BnRJ0CICLGX94SVRuzOq2OYTfPAPwjB/DngPDkTVGSOaZfJoq8K0mcnKlsjcRPjM3FkM+vd2HQyg/i8fzC+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932153; c=relaxed/simple;
	bh=J38ibBNH3Aw6lYafA9TGz9uhaMK3mS6IigwLX9amwzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzZTiVEzhLZp8sZLY62Qx90RCk6lzWb/e2UkM6t4GU4xXPHy4PTFdZ9dwX1/ydBnDCv1UZKZrWZBwoj1UMykCTKFHTGhq15mLa9u4HIlfMW5hpiOrDU10dXBKBWgaecUFfy+80QaWSMp8o+wWs2NIUrWXB4vPEWtyhiQPCaTAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3pTggp2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so4560464f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733932150; x=1734536950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfBv9YP8uyTkbd048cu0wiwdrnwl82wTzZ/vbZn1Plg=;
        b=c3pTggp2Xs/U+kezgNAyKUczbfPw0tUbAoVPukVmqBmTiWgfn4bh1grEGyBQB9DxKt
         fSrI3Tu+OlIpjOCmiREEZBwuL6yLfXAmVJju4J+dBKThpv/RoTwd9gkHEVYnPF5aratv
         KRynGqGnbqD02jhqhMR7DtwmUJOEtQe3V0lwUK3kjY88T9/7R7o6v+4tvgIWa97X69Yx
         d1+/eXGpnhWs8xWjXKNCbgVeI0LNJymIUhmlPVjZ78Jw+q3BZ0X42OfQXZsvSosESbsl
         HrOKSDo+/vrGrm+b3/8K8n63GRB/19vvZze0kqPwTtaJKQLjETYrCHKJ3ShPgl1ZTFJV
         k+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932150; x=1734536950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfBv9YP8uyTkbd048cu0wiwdrnwl82wTzZ/vbZn1Plg=;
        b=vU0qDJL4BlWdykQ9urz0Uc5oOUPNoe4MzwLRLegOQ8/wjhczIcv8O+uj7T67+SUN8s
         uOxm4JWGI+0jZx4vWHyW/6AJC4ywkvlk8lbRjoSFrLu9IXtKKJy2dSHw5XFIOat9xo75
         GmlwVowKZTwEPcLxN2iyEoSAxa/wcdawGFvWEKGy21iqTmkhRkIQAVowLPvvlkgIKI2Z
         QIKWoPE71xQoB+uTRQOv+elsBPNIfwif+og9OBYu/4U0inb8gqbjPMxCFeXsOzWi3ZkJ
         xjbIZnyKYGCqIEG0pQ0IwolpJzMRvvUiPBvKRbRRE5kU6+2ntt6Cz77nSPt33ZQrpioa
         knBg==
X-Forwarded-Encrypted: i=1; AJvYcCX6bv7nJUvmVNpUGaAT8hRjElxAW8qwm0r2ZbJyj/+0C2PmK34zOuA3EMEDckrBKcnEFjV5kmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzreiAgriyFEpdAt2zkCllaEl1StHW8RDMzs8E/yHE0RhtR2h7C
	tqvSKS7q1pJZtxdzsjA2A7DFhtCYmayuWJeqoXL5IGmJVjhzny4FLvjHFDs92j8=
X-Gm-Gg: ASbGncujOWVDrxnP3IQXi+vxWjo6dnN6K0XP/g5ToLxaGz2YZCT7Qcul+MBNBoKSu1r
	UWOib2vnJ7ZwNJSm8BV5oa8KB/6EqmuoYMVk7zW478Y1ioSDrqn2OL5Hyqd02TatPi52cmEr1Nf
	xuFbpSfqRZ+7m5SqBuWUGPlD+CiDNS9B1It5hFJlPiQVML29z31FUtllCD8RR7aKC28+5DDevMO
	hAGzaAvSOA+xtjoFy6OFEIo1kl4dp9NawORC+8VERkb6aciOahSWUPwbeg=
X-Google-Smtp-Source: AGHT+IHgVguIQX7zRdkeSiogpetBA09LUoU9WaRTxjvY87GzH77emXIzHenGyofWFwiTSdXlRShTKQ==
X-Received: by 2002:a05:6000:401f:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-38787688392mr90463f8f.1.1733932150243;
        Wed, 11 Dec 2024 07:49:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ea3sm1550192f8f.28.2024.12.11.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:49:09 -0800 (PST)
Date: Wed, 11 Dec 2024 18:49:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <David.Laight@aculab.com>
Cc: Julian Anastasov <ja@ssi.bg>, Simon Horman <horms@verge.net.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH net] ipvs: Fix clamp() order in ip_vs_conn_init()
Message-ID: <6b363719-0250-48c1-9d89-0d4ae86accf8@stanley.mountain>
References: <1e0cf09d-406f-4b66-8ff5-25ddc2345e54@stanley.mountain>
 <7e01a62a5cb4435198f13be27c19de26@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e01a62a5cb4435198f13be27c19de26@AcuMS.aculab.com>

On Wed, Dec 11, 2024 at 02:27:06PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 11 December 2024 13:17
> > 
> > We recently added some build time asserts to detect incorrect calls to
> > clamp and it detected this bug which breaks the build.  The variable
> > in this clamp is "max_avail" and it should be the first argument.  The
> > code currently is the equivalent to max = max(max_avail, max).
> 
> The fix is correct but the description above is wrong.

Aw yes, it's max = min(max_avail, max);  I'll resend.

regards,
dan carpenter


