Return-Path: <netdev+bounces-177247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A46A6E67D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03B53AC2AD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9D1946BC;
	Mon, 24 Mar 2025 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZhbQFx1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B573143895;
	Mon, 24 Mar 2025 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854941; cv=none; b=XPP7Y1aFGDmUy0l8IYDIpxT73/53Mi/VmxckfHFOlbZ3wm+vk0FTMqUesqb1XJBJdNniL+qTVP2mi17VShKCSBjmqqJT1taeo1Pe1csVwrE3LjYlNAopQXTnGKdhcOZc+JlN9OAQK5wWF5XXi/paeeKZrLHw8eS3SMZkiw3w+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854941; c=relaxed/simple;
	bh=36O/04zHoF+wQxX2Ckb3NLz0Ilkpuh+YIk10NNNkv2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2GnMu58Tes+WErwLYGmG2qd3JCan3iRo5nXjnA+yt9+knViG/iMCMeeZUriI2OCdDHL7X6zRxH0MPE1T7JnMk9el1EgcjrkSrVh9TitbGkw4JFT0I/Ie0IMt9h9uiKix29L4Lz7CcEAt3tK3I5y6KjjW3Gdr+Zhnv7I5oV3+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZhbQFx1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2264aefc45dso82651035ad.0;
        Mon, 24 Mar 2025 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742854939; x=1743459739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eS3RjMaLCNqgiJaSVm2ywS8sGzGuV/kwQoAzrZ5qh+E=;
        b=CZhbQFx1EFWk97XxXJLA31hxyl091uzzigdSXJBAUMv4FunyA0OJIjSqIRUjSeqM4u
         sgX5MbyDphX9EXZCiR/8swNNrkE1NlLK1LvfByE+MfjigtVf3VlLefi1e4CJIt441hL/
         TJ4wqmm5G4CG6HQcjhsJBg95qtG+NCKyS9odoL8f87KlKHOtME2aWAWczdMlbdH+8yUg
         pWUm9umNGDpEMhNUmkspyvyTLiqEFQuGfuIzzWu92RhOSi1Bi+2ouhYuKJYYAIErpazN
         bmmqTJTeQgwcCJEEztCFmUfO1e+AYg2eApBw2+WBRdN0bQ1HbPeh/iAQzZcORG3XmsgY
         3yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854939; x=1743459739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS3RjMaLCNqgiJaSVm2ywS8sGzGuV/kwQoAzrZ5qh+E=;
        b=ct4w+Wy3cKz931nwp1Uit5LlyZjysm4kJih3H+C3ZmCUb6W1HQgzzTorXTmfoEggi3
         DQBorX9tZz2pJ2SHnN7rSPNeVUXbEHufodYDokvv8YH9pUNyMFNLsZiFjJFbUc75Ia1b
         OcdY7mB+zpb4Q1jvQwr0FRT3xWTGARtYZbCmgaco+pFOoJzseRylrfkjELRe47PWFAsK
         qYqzhFtsqkuHqbwvSOMgYYq4lE26yhVVqZHKQR00/1XfIKIjB6DKfAd1EmwyLe44i72g
         fHqelqDfSbQ1UuTUc0YpVAaFf86gm6w/PTvL4fYmswtK2t48+F6fE/nsVoqBL6eAaY1s
         5HgA==
X-Forwarded-Encrypted: i=1; AJvYcCUnYpSwjObtupz3XyLVe5YYG892Y3BeGm1Sj+hjfkmUGrgIbpQtnrbuqENhQNRlUxffsIvCdcrd@vger.kernel.org, AJvYcCWNTxDCDX+3jJPTymqAHX9BabH+f4seJCGMZCuvnikpI9GZrPF2Y+2o+7pWhHM7fLMCw6J3ST/iLfTuYzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo78to8dXgZkMpGaVSdf0/qUFodHBgC3/fRffXL1+Xy3r/7pt3
	f8N5b7NSF3+I/G34e/T9ZoDT/kSTn9rYr41Ied4lBBvL94NCDcQ=
X-Gm-Gg: ASbGncsxQm8TqaW+UY+EBJJ0sZHD+xFJYMvEaV5bnbZWnYWzt+xSpBgd4KpydI1ekHF
	3ZbZ6Ip2wCmne0Y6CDjBTgEo6Ph8GpPk8E0O43VsWU0UJcFD9+yxK3t8SuczPXYpTLf9MskaBbv
	uVV766EscOa8oGtGWgqGsxIYEVxKxVapJW0sxPsdfYYWotiChbT5I5cendvnRKeynBGYrs/iaoM
	g9bzzttL50yX/j3CUsEZ/irrbGOky5F9WVbLTWkE1r+r2LH8IrZaWmTh00BZSQZRTwGrlI01uZa
	GEBkGLTo4hsv4r5LkK7og9aEYa2iATlnV8SehuQfOCrA
X-Google-Smtp-Source: AGHT+IECCXC+ptBi040j35MfNJo5JtUv9wBBHlu+wU953vEwOW2eurI9K3olTMdLbIb/AUlddVbpZA==
X-Received: by 2002:a17:902:cec8:b0:223:668d:eba9 with SMTP id d9443c01a7336-22780c5587bmr295483215ad.10.1742854939234;
        Mon, 24 Mar 2025 15:22:19 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f3b493sm76522685ad.34.2025.03.24.15.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:22:18 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:22:17 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v2] net: hold netdev reference during
 qdisc_create request_module
Message-ID: <Z-HbGR1V9-1Fwf0H@mini-arch>
References: <20250320165103.3926946-1-sdf@fomichev.me>
 <20250324150425.32b3ec10@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324150425.32b3ec10@kernel.org>

On 03/24, Jakub Kicinski wrote:
> On Thu, 20 Mar 2025 09:51:03 -0700 Stanislav Fomichev wrote:
> >  			rtnl_lock();
> >  			netdev_lock_ops(dev);
> > +			dev_put(dev);
> >  			ops = qdisc_lookup_ops(kind);
> 
> I'm not sure if this is a correct sequence. Do we guarantee that locks
> will be taken before device is freed? I mean we do:
> 
> 	dev = netdev_wait_allrefs_any()
> 	free_netdev(dev)
> 		mutex_destroy(dev->lock)
> 
> without explicitly taking rtnl_lock() or netdev_lock(), so the moment
> that dev_put() is called the device may get freed from another thread
> - while its locked here.
> 
> My mental model is that taking the instance lock on a dev for which we
> only have a ref requires a dance implemented in __netdev_put_lock().

Good point, didn't think about it. In this case, I think I need to
get back to exposing locked/unlocked signal back to the callers.
Even with __netdev_put_lock, there is a case where the netdev is
dead and can't be relocked. Will add some new 'bool *locked' argument
and reset it here; the caller will skip unlock when 'locked == false'.
LMK if you have better ideas, otherwise will post something tomorrow.

