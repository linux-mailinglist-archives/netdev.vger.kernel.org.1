Return-Path: <netdev+bounces-128706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA097B1E7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35F5B2A8FF
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A31A254E;
	Tue, 17 Sep 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="JZUl+WGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24A1A0B0F
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585867; cv=none; b=rFdDRQ9MthmlArpa3SsggLGCCjEcchv0BqORxb2Cu0fFp0SqXsyBO9uRMv/z99luWPUqLHqMNF4N/y+vAzypqSCLjTFuBSgTwAwmWTuejOeWDfZGqqXLEAACnYvdQTiPxHQ8RYM8kyOaZFrCio0PSwpS0WmMF4PieLcaslJ22Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585867; c=relaxed/simple;
	bh=QJqdg3mCTTIPZJaFZoRu0Cb8q0EEc2JOCRrVUS47lQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3sbhr4K8nrk6VSyCINgwR89GV3yRTIdp1SHEzvqywSjnfWZXNhsAu4KRsV78GdYHCTtTocDbYqXx585Ek+UFUkzYwfcUZHZwSf9Vx5GAcnnA7zrraBr6oybLPhecTnVFlP3pPrbx9pa2+B33/vWa7fYWlDNKidaa/KulhiouwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=JZUl+WGZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71970655611so1318564b3a.0
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726585864; x=1727190664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9rNEVt2jOcimLquZWGjPGhFCb5bWPDRIN+36HfVruM=;
        b=JZUl+WGZt9qCrjhnfLixbGEzjBEFsXGBlgz+YuIKCVTP6lAxqvRId9RITEqtRZj9XF
         x7NAgBfvla/ypzi2U5btB5vAbUbJLd23eved+G5q4GW7nz9iWiUSOZu6JbHZaRN4d9EX
         pLw1Bd41drx+819Z8Q+ce+vwm3ZTLxw5QJKNZCO9p7JhvSVt/aXODjdZDDrfRNjifrzq
         QF2Oc5L4Uh9x5vMr/s5nFnEqxKNdsRsg44pYGUZnhQ7UzlLSwfjzSi1BxnShzATvpoYP
         imRNg/Xh/olObiHqn+gl2CNxp7n6I65JjV3N9dSRTtml4VVhGOOC80kHWLnRaP4UDhU0
         mszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585864; x=1727190664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9rNEVt2jOcimLquZWGjPGhFCb5bWPDRIN+36HfVruM=;
        b=s+Zk3/CvORdL7mPtJZ+hBLhdHwFzjzcKslF2TxHHg6vUG0F0ExHBa0RkfGDD/xOL8W
         02/VYRKgdCKOxUdGEATKFbfd5+AMJ+f+ppF58ZJGhAjNqNujKGlBImMh4yCDhK3ycnfX
         Ip5vY5DJTmWz79Z1gNZi9J+hj/3p+CLyMbV5eo34MJBikthnzyj7G7G4PpjrYnhsb6CV
         K1SZV9HrERtSPN4o4W71ew1LYiTTtDqbZdcOggQsEurxcE74uxS0ZMb9gh6k0kGOBXbI
         Yvt4u6Xeah242wcXnn0BcF5WrSSN/yIPc3D6FVQ68Jkfz6hA8f90JU7DRu4ukLmF/E9l
         eOuA==
X-Forwarded-Encrypted: i=1; AJvYcCUB76hEwvNT7mMC5BiQkR8Ok7YIpzwuqPuTDSApHnkoireZjxNiG6ah8ZihwBmH+HMPFNVKdUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8zQF4OjisH+TQOq5tl671m5tAKBWBKNOUWDd5w4wKisO7p9oE
	g53Hb0OjEkJ/QWpdqgg3/nhgtShRj8ymZt6+NsJ5yLhnST6u8aP2E109/4tF5qE=
X-Google-Smtp-Source: AGHT+IF4LlaYYW/YwkTLitDr2k6cgSDsdYS54GIRRz1iGaxVrxIy96jm3+NUHulXR12VNxTBaeig9g==
X-Received: by 2002:a05:6a20:c90e:b0:1d2:e888:fcd1 with SMTP id adf61e73a8af0-1d2e889024fmr2276571637.33.1726585864516;
        Tue, 17 Sep 2024 08:11:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980casm5288879b3a.28.2024.09.17.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:11:04 -0700 (PDT)
Date: Tue, 17 Sep 2024 08:11:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, Alexandre
 Ferrieux <alexandre.ferrieux@orange.com>
Subject: Re: [PATCH iproute2] iplink: fix fd leak when playing with netns
Message-ID: <20240917081102.4c00792f@hermes.local>
In-Reply-To: <20240917065158.2828026-1-nicolas.dichtel@6wind.com>
References: <20240917065158.2828026-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 08:51:58 +0200
Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

> The command 'ip link set foo netns mynetns' opens a file descriptor to fill
> the netlink attribute IFLA_NET_NS_FD. This file descriptor is never closed.
> When batch mode is used, the number of file descriptor may grow greatly and
> reach the maximum file descriptor number that can be opened.
> 
> This fd can be closed only after the netlink answer. Let's pass a new
> argument to iplink_parse() to remember this fd and close it.
> 
> Fixes: 0dc34c7713bb ("iproute2: Add processless network namespace support")
> Reported-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Tested-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> ---

Maybe netns_fd should be a global variable rather than having to pass
to change all the unrelated function calls.

