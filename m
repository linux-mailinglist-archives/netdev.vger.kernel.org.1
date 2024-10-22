Return-Path: <netdev+bounces-138006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362399AB740
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFB7286E8F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D961C9ED4;
	Tue, 22 Oct 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SJgKj3aC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1471CC164
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626989; cv=none; b=CCXn1el8frxXayd3222ReGlECmGBi7hTh0Em+M7qVwh2MynzV8lOwcUV9aP8ZaLMpDxxndyJVYaxIkQRlyigAD9CtfUNGEEBdxV7p65Bndm7G6B9s2JuRGMwCbTXKIBnv1DCx3Sf2BsIu/nCRfJyunjlzgJMzZUYgRLXwP4Ek4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626989; c=relaxed/simple;
	bh=NUcFn6mFtOa7rHBDOj5IecPsHfIB6lDZN3NXWGC35i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF0A7QDddM0xmxsFmcxVYAwiQfhZ090PTEbhuzn7/SSRSo558+vvo5GjAMZInfq/h+kE9EYY+0C7b8VIugYv78CtKzsN+hjEPdRYkd8/YeTsgpz6QF+ipB2WGhjJnE1jt/zXtHIkP3YzPbvIY1Bw430COZXA5mBJv7xThYNUDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SJgKj3aC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8c50fdd9so1340795ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729626987; x=1730231787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UawTMyUUfhWZcmo1Kge9J5E+nLwRozmuTN7w5UWRH40=;
        b=SJgKj3aCAhEWeMtgeGi1hsg97M4QWa5LEncv7EsaMrWpwx8TsorY8u0vBRU62iQdFj
         2t+A2+6BselSRDkF88HeFH+ox38pF1ongVZkrYQ+84AXdPYVdaQvAF2HjDTEMnhkz5cl
         3czRZm0gm1x36Qi2vCiFOM68RCOWYRILdaCi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729626987; x=1730231787;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UawTMyUUfhWZcmo1Kge9J5E+nLwRozmuTN7w5UWRH40=;
        b=BK0pbSunsCJJBvulTgU5TMYTkIvFxJop6UkOEnDjKa2utsm6tAQ3d8V2MstYb0PcVu
         5mYaePSCwc5UFCXY+vvHYEOabomOf33f68dYH+DzO1Kw4Hi6xpZFvc+WWtxHmJx3q1fZ
         9Y+JFBi0JGHHsJeYZajfUtZDMlH5CxmpPhLlMLYdK+X7qGbXWTe3KgkN4lDUF4aHKrud
         by4vvvnyIP/xMcswVg2eR4tpoBPmbYpT+3TbKeYPSZ56pD7Wdr3jFktiRsckOaYGCSYQ
         o3yDcJ8tcWyHxY1fl/FIf8wD/pFFaLv1jwN2d/H7ASidGA0z576AfkyfaLRTL1fyY1nU
         F1jA==
X-Forwarded-Encrypted: i=1; AJvYcCVrBRxSubVQM4gch1zFY9ey+SMnGcNrANGv8oi47xXqG8onlUUKjnU2C1x0RFUxF2x75zQuQZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDsuRCmxaLoJTt+HP93GgT1HF6wcbPBuH0zHyRAlPRk66fAdY
	3UWzQjAjUFeaOswIKPONdLtBPIzFvk7Oy8Y0RDAymNE8B2nhzphecTJdtwvKHLU=
X-Google-Smtp-Source: AGHT+IHNId3oPh+cqT0dBbP9dEZlZUOiyMnmOXHnp6phbW/urg+QFzsulG3ONqa4XWa4vLSX2dRC4Q==
X-Received: by 2002:a17:90a:7e8a:b0:2d8:3f7a:edf2 with SMTP id 98e67ed59e1d1-2e5db98252amr6452232a91.12.1729626987110;
        Tue, 22 Oct 2024 12:56:27 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad516f2dsm6700061a91.55.2024.10.22.12.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:56:26 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:56:24 -0700
From: Joe Damato <jdamato@fastly.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: RTNL: assertion failed at net/core/dev.c
Message-ID: <ZxgDaBPGQrwEo0RR@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru>

On Tue, Oct 22, 2024 at 11:24:45AM +0300, Dmitry Antipov wrote:
> Hello,
> 
> running around https://syzkaller.appspot.com/bug?extid=b390c8062d8387b6272a
> with net-next and linux-next, I've noticed the following:
> 
> # reboot -f

I wasn't able to repro this myself with e1000, but if you have the
time and desire to test a fix, the patch I sent here:

  https://lore.kernel.org/netdev/20241022172153.217890-1-jdamato@fastly.com/T/#u

Intends to fix the bug you hit. If you do test this patch and it
works for you, please let me know.

