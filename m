Return-Path: <netdev+bounces-174109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF9A5D835
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671877A2520
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34DA1DE3A4;
	Wed, 12 Mar 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXJaJ1K9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6123BE
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768256; cv=none; b=dX9XbrOrfbKs+GPW8sSa+fOSALMlqETdYUtLLoq80z9JBdUzLG8z/wRPS6Yco6gdvZIHfuyImAYGqCQtCrJgwEYRlgLHXAsB61yHQfnmB4IRO3TxeZ3227pDLA+hpjyyjUEivFB2n01xuRnsuIode5rhSfZi7UaD29eS70eXWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768256; c=relaxed/simple;
	bh=Se55z5Hxa5Ndar56yY1whgqYy7BKYwf3jhljRKKiHhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n5kole1HJhZHC9YeTFnvJEQiQYm5139+JjIii49xoXnZNsot5SU8LYwLZgewt5Y+twxafqIwZILSgyc6CnRv9LL+/aBBa3TgnxvSjwCzQdOCjlY7eC/fKPvvbf51OqXsWgEJb8hCoa8/rzk8LFjuvGr6r+ZaS6/cyzMn9/xGYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXJaJ1K9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso23022375e9.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741768253; x=1742373053; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpvKUoPsT/Tz5mhoUjTMBD5rPv1V71LMirlQSUfpWB0=;
        b=yXJaJ1K9CvG+OMxkd3NLIb8Fo++vywvj2/xumYcfQIHlaKrlRtyiI63JRDq5Vbk+JA
         FDZ57Nk/w8bRz9dqxT8fsRfWwfR1cH/a5TNy7IkE9RCY47PE5srXxOorh7ZjX0LTB0rb
         slUd+Exk7J1QkhjJMuYOIpfIlM2RiO/jLa8maGcICQnxNtQitMxWmh0ros/FKHbqacoj
         PvFsNpPGDvLy7tfcm3BOtq/+vmJLuwvraf0XxOScBUocfHtpvJFlul7jhv/rDfOO99kO
         fr50E0vB+slqXBg4EwRJVpUL8H3+IUgW8rLYJovljrS+pTbKMRkNhSm2AVp9s8NYK9iN
         W/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768253; x=1742373053;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpvKUoPsT/Tz5mhoUjTMBD5rPv1V71LMirlQSUfpWB0=;
        b=EwGHaUV4RRnQiF81Z4lIo3UtKXgYNF3Kp+XyO6/J1eLWgEVEyKMKxr0mWEChnXAVlS
         kc3skm7Qmkq5bgpkWQ//eytGowYJmh4Gy0pSsRpnsEIZYJGmMr5YmeHcnKfb+rT5G0Zg
         MIarbV3depkL5+T1ftogkkfR3mR/aypAB1+zPKLfPjaRRYBIOAYgJ8p6zjQ2fRHkbDoA
         ++9EhsdDqTM0Rb2Tti0a/nKBzgqZ+KbtU0eHzHWelBbAIIHhv55LYjc1fSIuKqToGn6a
         4Y3TDx5MhLRs/XeqbRYt1wnEPQc9COruSqh+zImnOZVqSLG+N3JQrUgl6zGQ7lcIf31L
         tgng==
X-Gm-Message-State: AOJu0YwZ4z2Rf5BY1u5F2WJr62F0oM0OG+KcGeTowOQ9kD44IKtZdPpO
	1By5TCRVydUBG31r2W1RdVV8jDAPUdq+J/zK/2fMLtTBs6rTxwwc9yNbIIMfQbQ=
X-Gm-Gg: ASbGncvC6f5Haz0sHc1I2TmXOTOMwE4vpCeNl3DtL9hCzzSkZkirJRekpGU0sHkLyRL
	MA9I8HjOG8d/jb6GIB3tFZLjTuM56G9veHCl+KzCYE8w3i6VvuzfVWNd03RuoPvY6W11McW09+4
	AZ352P17ogK8C/HLHANUg7aTIRD1gJykuRuwIVfPL+CAnRPat9gTxvahUnTyYOSLe98G6UVX++i
	QULBcGVG+QV/Ni+EmQoYEwotK2pKmhsmfjYl/INjf1ZW+Vli0F+6jlYmSYFFkUV5yDuGm/7KEk4
	4rlIluu2iyMHmSRxbeWU2GAcbZSe3O4r7ZypSxbXz8UHiHBxVw==
X-Google-Smtp-Source: AGHT+IHAnBukGscy/5+yGwZ52BFbHLIQ5yWeGUK10XuvKjbREbYSS98Nj4GjbCkK6GCE+SOzGpYarQ==
X-Received: by 2002:a05:600c:19ce:b0:43c:fb36:d296 with SMTP id 5b1f17b1804b1-43cfb36d60fmr83636625e9.25.1741768253190;
        Wed, 12 Mar 2025 01:30:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d0ac26758sm12322285e9.35.2025.03.12.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:30:52 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:30:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: ti: icss-iep: Add pwidth configuration for perout
 signal
Message-ID: <7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Meghana Malladi,

Commit e5b456a14215 ("net: ti: icss-iep: Add pwidth configuration for
perout signal") from Mar 4, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/net/ethernet/ti/icssg/icss_iep.c:825 icss_iep_exit()
	error: NULL dereference inside function icss_iep_perout_enable()

drivers/net/ethernet/ti/icssg/icss_iep.c
    815 {
    816         if (iep->ptp_clock) {
    817                 ptp_clock_unregister(iep->ptp_clock);
    818                 iep->ptp_clock = NULL;
    819         }
    820         icss_iep_disable(iep);
    821 
    822         if (iep->pps_enabled)
    823                 icss_iep_pps_enable(iep, false);
    824         else if (iep->perout_enabled)
--> 825                 icss_iep_perout_enable(iep, NULL, false);
                                                    ^^^^
Originally icss_iep_perout_enable() just returned -ENOTSUPP but now it
needs a valid "req" pointer.

    826 
    827         return 0;
    828 }

regards,
dan carpenter

