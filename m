Return-Path: <netdev+bounces-200802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877ACAE6F30
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B4D1BC57B6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B923F294;
	Tue, 24 Jun 2025 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="kquHlrsy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7384170826
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792077; cv=none; b=fn+vroq1ERw9ZYVxPBWSc0ctboFowIoLnIYfie1Y4T9UBB5OuOcTdC3qMVGlqEWoX8S7LDqsWS3bpOKeOY1W2RWommlHmvKFPAW5sr6qUzDgTvJFi+IKxvU2pXYWWNb5cBe8oIraj0pY9jR7YgxPi34mcjP6ivOoN8KIkL+x/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792077; c=relaxed/simple;
	bh=sxIRZ7U7XYll/So+u7OsleqjjWxUynavdKFiDTxCkKU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=OYC+MD8sWX3OxxBszZrmz0l/JrWYXFdcPs2S7sYJgimf5dtAhhDFJqXh8e0mruo1QJDseghA2+op/3BFn9oi2KOnPrHoSdafmQ0MmJImI4pjZ4QjhviXvB/X4mcOqYI4y/j/4L0CqfhFIueabv994ZH/7Z/825rOvJ/4eoKIkDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=kquHlrsy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso1609600a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750792074; x=1751396874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJQJ0Vu8gTyCcrO4fPQFn2fQBjqLwI2YwZex6LvwDks=;
        b=kquHlrsyZNigQeEcwCrzO0nX88AcfO9ed6AGqBtxnCtCaQdu9XbkrUbXTzJOH+YTOS
         rvmXRTYESsAVyhKA9eUAZN8mL1DeVAMo2UH55Npb2UZxCH+QRsPd7Gmvbj4DtWuP3EzC
         VPhyYYIJNVqemC7PYEGAd+jxhvBnYoEPRxE7rrI1ffTXIrJ4rdD9wnCseCLnOLe+EIai
         6HdRDcR4DWLg3GQGApNGm0WpWj6Vqxwy0IqIFYZ2YF8hw4QzLXVEKf5dTZdMK87jFO/a
         w5tQg0O19hr01r0DjnVHg2sNXleGpX89WwEdbbK3kDZd6XBao+64D6ekDhVKoIHMpxZH
         afgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792074; x=1751396874;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJQJ0Vu8gTyCcrO4fPQFn2fQBjqLwI2YwZex6LvwDks=;
        b=VCATsKvfh3XfgENelVNE1wTfNvxCGDxmfNxUt+Htd4yRJQmTVxeXDxOwo0iUIWqvpE
         1jqBON5MNQldfbFw6is8+OFLDeDm4aId+DUrplLlVf49Wtv45cvb/JkKK3zZfK5MUgdt
         UhyIo3mLmahnRz900zW1C0J8cVABzAeBGRC8O4wV8b/uRmXZBRHG0/ohqwLPePObmqHT
         2mWK09lE5YZYSu3LjKuHtfBkPUJXGvhMWXNUTaFG1y642VrS3g0AfOs7v6m0wYArrZEI
         QILU5y15IXdvwj8FT1089m4ra0xcZNS4FUk6WZ4yvTHb7fou7A+gVrQq0bDzt7jiBB/A
         szYg==
X-Forwarded-Encrypted: i=1; AJvYcCUcEUaaDMlw39kbG17HC1OwV1/E58XJsFT3OI7nidwRuqiUppqKSPXWhLJ/NemFehZCbb+q5XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9s3Y7QkRoy27LB0Hs6Jn/G5+TVMr1tIVDjbKDrSfFj+JqgU4F
	wMqqpdSpNu3d6uicB0kejXgteoKmWWACFAQH1gOCXfkrOnRjaQdjZ4n+bTn38v0VRA==
X-Gm-Gg: ASbGncthDY02hu/GroEi2y7ysWK1DEdSKOO+B/x/rZVWfMMI5Wel2s9fuKcRcM1X/fk
	Zm+PMjOXcR3Vp8dttycrc+Us4u/SeyQHGMUAdSWdM1wVXDnUBJz3GfFEKGLRr48zaOUD+Wc1k3/
	ehNWo0zwdhZ9emv+6QeBSzcGMvShBq84W0yoxBDchyzKu8eM4P2k/WYRvqrf4W39HsksLo8a7hd
	l1P0qSDCuxfJrUAiRYnMdlDgsmRQHnuU2P1j/4jjadNo5ul/L9MXOl40t/POUQcdvHmM6gwsy1g
	q3n12wxpsjmioeF628iFJTbSYVPcDB4reP1OSaHGAtKkYjfO8IAVvxDxt3ZHoPVn7RWexnj6d8Y
	=
X-Google-Smtp-Source: AGHT+IGdso6nJiUlE/UjdgGSmYH2YhJqVjspC86fwFUyasVpFQXUKxKTYUHp5V8lCpYT3UTfmnZPNA==
X-Received: by 2002:a17:906:33d0:b0:ae0:66e8:9ddb with SMTP id a640c23a62f3a-ae0be86cb38mr41522566b.19.1750792073935;
        Tue, 24 Jun 2025 12:07:53 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b7f473b0sm63844466b.6.2025.06.24.12.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 12:07:53 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <91030e0c-f55b-4b50-8265-2341dd515198@jacekk.info>
Date: Tue, 24 Jun 2025 21:07:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/2] e1000e: disregard NVM checksum on tgp when valid
 checksum mask is not set
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set. Since Tiger Lake devices were the first to have
> this lock, some systems in the field did not meet this requirement.
> Therefore, for these transitional devices we skip checksum update and
> verification, if the valid bit is not set.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
Cc: stable@vger.kernel.org
---
v1 -> v2: updated patch description
v2 -> v3: no changes
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 364378133526..df4e7d781cb1 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4274,6 +4274,8 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 			ret_val = e1000e_update_nvm_checksum(hw);
 			if (ret_val)
 				return ret_val;
+		} else if (hw->mac.type == e1000_pch_tgp) {
+			return 0;
 		}
 	}
 
-- 
2.47.2

