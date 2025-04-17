Return-Path: <netdev+bounces-183802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C24A920F4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B457B28B1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445D7253344;
	Thu, 17 Apr 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="H3yATVk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFB252909
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902658; cv=none; b=UxpJdCqZDScQHptIjKNilgpdFEQbBHhjtlMJyoF2X1S3yr404/MLuXMet87BDLGHhH1qppY2qg9wUYyv1CoO2h+1hOaosceh4woHVLaP5m8kZcKznD26a7KvHR9OQAKJpAwqwry/xqcoHVjZIyt8U5S0gjpLjiJecXX4Xqj8VHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902658; c=relaxed/simple;
	bh=LiZgga9x8uNn0x7WdTDXbakOF44Ru5INCev66F2o+Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAsaq5LqmKVBDSY4L296UVe9Upfo5vlF2hb3YynJdvaeZC5HQDGJV0j6sMbUnQafvUAnZol9cvMDpczboQ5XyYN+QcbQrBoKow37ZpLjq2Fkp6gyWUpXQi4qnioaXC/o8JrSuFkQGDLTbJ/fwqqPAeTEgQ+PUI1l9oBBEDRRxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=H3yATVk1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227b828de00so10634095ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744902655; x=1745507455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiZgga9x8uNn0x7WdTDXbakOF44Ru5INCev66F2o+Dc=;
        b=H3yATVk10aZqoRI+w4nNhDNAcSrm+D72kf09ipil/lhZBQVG98+L9kHkPcmnSnwazQ
         2l2q7/rcLpNyHl7W14wjQCbWN87G0IAsm+Yej1cduBZyRY+bLzSw3rdEYxijZFieiE5K
         4p9sZvZQrU1T5YW0n/Phw1rSXkT4kX9Je/Pl622+TtYHoFzbnncoMrFYet2UFNdX7dEZ
         Kp5GDmv6d0PucyJocp1zYdAefTVH68d510dC+sFSGKo4O3dpzsf/SX5osPX6hm1NRhbn
         mn8Q/7MwclR7BEHoMAaKF+jTuamIjIVUOtP2h2aefp90oQRbxnCBj4UUds3GxtLFjNgk
         ZaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744902655; x=1745507455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiZgga9x8uNn0x7WdTDXbakOF44Ru5INCev66F2o+Dc=;
        b=gmtghVKCYy6fy4RfMbpCD6Q7liGGZiefAPWhaRSJfba58xI2H3j65FjknTLnnEXOSH
         UWssr5EzM5qm+syJBR6H2QjbThTsdKu3+rKA/51Sm4I+HLUH1rfAWqXBlDHNwBddQS2A
         5UXwzWGdEVZF+va4Q1u4PCezzIZQCHTTYJgIzBfVZM1kPPVSk/MrwcXOkz3NiMQX23SQ
         N7FC4QszxjyIOUpntKDd5wKdmB2FS1J16sX7a8IELDnc6p4/bAlsivObHTD2cxg26g3R
         4AABm9j/mPLcq/06s/zakBkxf3gjkpIwu1DJVFvE/b5RrfSCWT4K4rSyGuammog4L4jX
         j6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPuCyNP7KgC4PEBB1KNs5vVnsGP9bIwOndJy3FHXe0pRMj/QOEUwn1L3Gt7MqhSRy8JLqgtL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9DMf8p6wHAjczAdzZc8zJwwYWLWy6AUpBc5p+vgna93X+/kn
	Flb453P4ipquylVJG19GnSZXaeIEs4Caj8kR1ZgWueG9EwBcWWv24OtosHJc060=
X-Gm-Gg: ASbGnctGWWb7fF/XaLg9FYFyQO5D2SNVikOcVXXL4HaSYeJJNFd3ZI1bKVgn5QTz4+m
	Y07q4TvC6Y2gvRTo0RSX/dwbsOLA8Xq6UHsqF4bdiDnpIQ+wbMNoQkC4x6AebqtOoAX/vDGi8Ul
	MmH4s3wrueay7QS2QFcCCHSr0vykut4XoUylBgGItMDg7AbsAu+7Ib+ZkeZQA7UNyese8V3WbRK
	EgYmJLY0DBc6WOemacgmidlWkO2HgGmVHOQJIMkzfwetcAbHDtyRPMsNTTbZVN6krLd5nzUKVF2
	nHo+g76rMidx60L89Ri6W9mRX1RAztkm1k8Jn7Pij4f1Yz6qAwQxRr2LtVZ6Au0Y4Jn4heZoNz4
	aOwKekYZzcoTi1/Vj
X-Google-Smtp-Source: AGHT+IHIP5FBpE6QRyj07ov+jrBL6Cb9idEsBOVjWQ1/IColpF0qdvEnnkroDFpHC82/JIDmUgRLTQ==
X-Received: by 2002:a17:902:f642:b0:220:c813:dfd1 with SMTP id d9443c01a7336-22c359734c3mr102186955ad.36.1744902655602;
        Thu, 17 Apr 2025 08:10:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c210esm12348763b3a.41.2025.04.17.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 08:10:55 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:10:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 kent.overstreet@linux.dev, brett.creeley@amd.com,
 schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, rosenp@gmail.com, paulros@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250417081053.5b563a92@hermes.local>
In-Reply-To: <1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
	<1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 00:57:09 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> Introduce support for HTB qdisc offload in the mana ethernet
> controller. This controller can offload only one HTB leaf.
> The HTB leaf supports clamping the bandwidth for egress traffic.
> It uses the function mana_set_bw_clamp(), which internally calls
> a HWC command to the hardware to set the speed.

A single leaf is just Token Bucket Filter (TBF).
Are you just trying to support some vendor config?

