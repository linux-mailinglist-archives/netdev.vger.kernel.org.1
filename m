Return-Path: <netdev+bounces-49314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF617F1A4F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1ECB2173F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1B210F9;
	Mon, 20 Nov 2023 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Vkv5rDtJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1910C1
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 09:35:16 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b709048d8eso4062631b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700501716; x=1701106516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDDPuUZnZdMKmQdUKdIyreDp7J0qQAcUgBVUsxEmnZo=;
        b=Vkv5rDtJRsN1Q2xaA6v0i2LpErcbuGhZO7vPwUg8z6NqqplSL7yZuzFE8B0QFW7BqM
         iSWj2G33G5PGLM+ctFiJkg5CYP014bNdpXwfF/CldDG/bGXGq2trIxUzyrP+wB55oNwh
         N9Vg+z9BIEBEjZzaugzVbjVPLLxDAVBVC2IWAyIi0q++D8vHvMkIF1s0bnCAHtl3FaTb
         J11RpTo/CosIOct6O6U7O8lWMGwMsPg9UOZLPkL/Vb2Ro9MLBd0dN0q3RBQT1hXhjwrg
         jgNTGQf+HULuagbKTo7lcTGqBqrTeDXbIXFw60/nezSUtNNIwQ86Zxzp1FwrN8Gu7Ii1
         cmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501716; x=1701106516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDDPuUZnZdMKmQdUKdIyreDp7J0qQAcUgBVUsxEmnZo=;
        b=Sk47BW5FcqzwI+2wyzgHWt/c3n9511pIOLl+48QJnCxSUcN+mbWaVx6UAkpSHUPtJH
         E7IN7SsqXwKptTGM/LMqyZH4xdTwaViYEO7yEAYPt6Hx0lkI41m89gEHxT307L/G/RKE
         7sz+mFEj46o5m78GE6P0phC+sICr+RQlLVauvFp+3BECiiPmKwgiMvfNZPRN5oxuhIna
         MCLvGE8Wi8kvnQgjzGrUcjjEYNFpE6F8jiVzv7f4jHPGXUfqnE/xuykf0bG0B2GAHn+f
         nraqL1uKKIxlecrnFOozA38QPee84KpOW3PpkyMERayeRTWVqBAGMuXUyx3R5iFCItbZ
         BOPg==
X-Gm-Message-State: AOJu0YywFwAi61IQ3mx3B0XiyWn9Di63ybct1CM7CtAcdaJ23r4QxWX3
	/9m+HZM3c+ynOyFUA0jErX4JboigSyoVMJ4XAws=
X-Google-Smtp-Source: AGHT+IG2qQnI6wrVfQYRi7bWXfz5T8E54VkqY0glDVXCCy6Ndtl4eaLmJ7Eq+codM0SZCi0Vgsy4TA==
X-Received: by 2002:a05:6a00:887:b0:6bd:2c0a:e82 with SMTP id q7-20020a056a00088700b006bd2c0a0e82mr7872076pfj.7.1700501715971;
        Mon, 20 Nov 2023 09:35:15 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b006c107a9e8f0sm6281129pff.128.2023.11.20.09.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:35:15 -0800 (PST)
Date: Mon, 20 Nov 2023 09:35:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: rjmcmahon <rjmcmahon@rjmcmahon.com>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: On TCP_CONGESTION & letter case
Message-ID: <20231120093514.24a5bedc@hermes.local>
In-Reply-To: <5dca57c7a699ac4a613806e8c8772dd7@rjmcmahon.com>
References: <5dca57c7a699ac4a613806e8c8772dd7@rjmcmahon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Nov 2023 10:36:03 -0800
rjmcmahon <rjmcmahon@rjmcmahon.com> wrote:

> Hi all,
> 
> Will the CCA string in setsockopt and getsockopt for TCP_CONGESTION 
> always be lowercase?
> 
> Sorry if this question has been asked and answered somewhere else.
> 
> Thanks,
> Bob
> 

The convention has to always use lower case since this is what is
used by many other places, filesystem types, queue disciplines, etc.
In theory, mixed UglyCamelCase is possible but would end up being
bike shedded during review process.

