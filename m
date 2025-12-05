Return-Path: <netdev+bounces-243875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC97FCA917A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 20:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3996B30900B4
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 19:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E1F307AD8;
	Fri,  5 Dec 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c02m9Uz0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E62BD5A1
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963428; cv=none; b=idfNCjzN4aJ7y5DSw0kJ/4llcqyl3F6ZvoW+kufXynmZR/dwUahGymPQmxBWGK0i96qvJvPSU5NW2Y9hrjxTLrO7gKLskCy7ygyqmXzl+dx7eNCwMXlr1gtWOstZ72gECz3Ln23TXbmgXZCwg/SflGZ7rCzeBZoAZP8Nzei39AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963428; c=relaxed/simple;
	bh=bK3zAvBUxHnti/eNFOAZf6VNCTYPDWhIixrbSRhCCPc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nLVhGERkr5WWZSaln7mhUbEyPZ10l8n+7OThdQsUbg/lbhgbOLO0NT5zB6qpJOMBM6HwWBSInnI7g5b5CAy/HvNi022bM1C7X/90ArfHUgI3KYeYJVl+ZRqI+0tbcR+JkoLNab5glEGAomT3TZwbeViYEloUaysitiSbOZa05aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c02m9Uz0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7ba49f92362so1535801b3a.1
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 11:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764963426; x=1765568226; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5FyjUIS9qgEZBxRsHEDHxccTlWb8j6jPm6tkMWDSnA=;
        b=c02m9Uz0zX7At2kgtIXJJivYnPtEeLJiJ+f73+IEIc6hCu+an8zh1uf/0yZVhK+d5O
         smG3KRlKX103r54a2xmf2C8jLE8H6/lV4h+gbGncUwU9UAeQaWqBZcp/65A7pztiMS0p
         r9+2C9QGCOzmT1oc9ZKa13rRNJ1zlpo+KJ0zXc4Qc/8al77Yogy7ptfJE/nn7oCiYqK/
         yCUhqXas7mSay6lFqzJ583ZBfGvkp7MveR83r6Hw9eQTun0xdaBV7uSmbkWaafCZ8hJq
         4X91ib8m9qs3vmmu3nFZIdUKXYHaR32x9YoTeHINthKMCL0AZ65raWHVzZ6DTdCHlcRj
         nA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764963426; x=1765568226;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5FyjUIS9qgEZBxRsHEDHxccTlWb8j6jPm6tkMWDSnA=;
        b=mXG9HywNmm+7Y39/mwjynxo2LemWG4WuD5eeoApT93qMHWTR1XjAHlXT+SyAWDJpQR
         MZ52IArtubJUyaQS+dpgbHg//rlz3XcLzJ8242iQMPQVuLI1fXNbWPF31NGhBWiFkCDV
         AqLV8XfZlUkYwG8Sv1DnFk7wW6achP0yqydgiyAG0G1fV+BHsRnUTcN1URCCP77Dvvsa
         eWANEA2xF3pBe8OpkgvFISmggTHAjES3uqB+2bWGO/Y4+tmTeuj1HcIqsp+ASzViM3GB
         s/QYuQ2Jl6VzUXMK/ybZdxKedZfyWYXyM5xEfIgTHsvDDCv+woaYuremUpYCVRVZL3jj
         t+TA==
X-Gm-Message-State: AOJu0YwvfS4dPpgkaEWsdaZ2ahW8MjUttvWctp8cE0fAb0jqjbuu0zx2
	5Yv+xuOCHbou/TXAJxIIcvNGWRSNjSKJPfuMI6VnIcNbIryQU/aYC5kWAHRWTK0qqFLLqIPmvm6
	INpK/JU8=
X-Gm-Gg: ASbGnctSs7BvBSsNksFLbWTFbmMZgHfs21n0qNefIvEAr+rxwb1Q7kod49iVMcvBKIf
	8YyUHLuu2JsYDKwAeMpzfT3DbM5JAG+YLdCJydcf1NN/5j8ZovtxPY4j0G2wVwIQLGYoYlfPIaT
	xdtMhbPHap5RICZi1rruF+TMnP4QPSLvew2nKrgUp6awX0qT7c5x1R9wDRKPX6DtrH0EpglRD//
	sgctWUqwfMKZOzAKyXjDcLhWQ/FXHvFCLjSUeWNH3ohmkSNs6z0CO9QESLm7jthbR31rCyTVTx/
	JqhqYmAfDL+M5Cq6dwVI90jb11vEzXcaXFJ2Bg534UP+4wife7H/Ql5PvlA9jZrs8ITfsKb+X2g
	jloiVCijKWgeuk5OIk3585JUfik8Cs0j8NPLRUupnSQtEWFdmdZQXHnODU5RTKZmGZlRxS3y5YG
	1YRquG+cSwgR/HZ5Jc/DcYdrF/
X-Google-Smtp-Source: AGHT+IFmboq1cPOQFQUpt4igStKoNP93iAYzsyAct4m0Qo8ompK5hGA3Pp66tdfzJKk2IW+LJl9r8A==
X-Received: by 2002:a05:6a21:338f:b0:366:14b0:4b18 with SMTP id adf61e73a8af0-366180292c6mr388534637.35.1764963425725;
        Fri, 05 Dec 2025 11:37:05 -0800 (PST)
Received: from [100.96.46.103] ([104.28.205.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a14f5d0fsm5358004a12.23.2025.12.05.11.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 11:37:05 -0800 (PST)
Message-ID: <dddf6b9b-74f0-42cc-bf1d-5fc8b8d4df8b@cloudflare.com>
Date: Fri, 5 Dec 2025 11:37:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: BUG: ice: E830 fails RSS table adjustment with ethtool -X
Autocrypt: addr=jbrandeburg@cloudflare.com; keydata=
 xjMEZs5VGxYJKwYBBAHaRw8BAQdAUXN66Fq6fDRHlu6zZLTPwJ/h0HAPFdy8PYYCdZZ3wfjN
 LUplc3NlIEJyYW5kZWJ1cmcgPGpicmFuZGVidXJnQGNsb3VkZmxhcmUuY29tPsKZBBMWCgBB
 FiEEbDWZ8Owh8iVtmZ5hwWdFDvX9eL8FAmbOVRsCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsC
 BBYCAwECHgcCF4AACgkQwWdFDvX9eL/S7QD7BVW5aabfPjCwaGfLU2si1OkRh2lOHeWx7cvG
 fGUD3CUBAIYDDglURDpWnxWcN34nE2IHAnowjBpGnjG1ffX+h4UFzjgEZs5VGxIKKwYBBAGX
 VQEFAQEHQBkrBJLpr10LX+sBL/etoqvy2ZsqJ1JO2yXv+q4nTKJWAwEIB8J+BBgWCgAmFiEE
 bDWZ8Owh8iVtmZ5hwWdFDvX9eL8FAmbOVRsCGwwFCQWjmoAACgkQwWdFDvX9eL8blgEA4ZKn
 npEoWmyR8uBK44T3f3D4sVs0Fmt3kFKp8m6qoocBANIyEYnUUfsJFtHh+5ItB/IUk67vuEXg
 snWjdbYM6ZwN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Filed at:
https://bugzilla.kernel.org/show_bug.cgi?id=220839

Kernel: stable-6.12.58
NIC: E830 100G dual port

When trying to adjust RSS table # of queues on E830 with

ethtool -X eth0 equal 8

we see this error in logs

    [ 6112.110022] [ T303140] ice 0000:c1:00.1: Failed to configure RSS 
hash for VSI 8, error -5
     [ 6112.528002] [ T303170] ice 0000:c1:00.0: Failed to configure RSS 
hash for VSI 6, error -5

This command works fine on E810 nics with the same driver.

Firmware/package, and NVM version info attached to bugzilla.

We're already trying this on 6.18 but data not available yet, however 
it's still a bug.


