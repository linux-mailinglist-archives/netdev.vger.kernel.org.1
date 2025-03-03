Return-Path: <netdev+bounces-171185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39905A4BC96
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6BB16FD0E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE311F1506;
	Mon,  3 Mar 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyLaojJ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0101E5701;
	Mon,  3 Mar 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998480; cv=none; b=G5Yi8AeMl5DiMflrJAq62pRMlTo5m1n2O4zy1QrlVohH7RgI0A/EGBS/yuU8Mk7aS7XVXGr26fK9STwkUK9EZNEcJBqWejVoR/xlFSc6Jgz+tfveNgArH3QSMgV/hMNYIZuspEASSpOxNpkrnpj63JDhlQnsKlWH1rNDowlneQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998480; c=relaxed/simple;
	bh=wRfeu3myA8DlcG7L0jyMzYQHF2TQYvmkJlMq4oW/No8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=bgJxxMs46ES/lvPzz86aFu3xtXzb49F4I49+50JP26Z6Uhbe3iEz7kRMlDDDmwQ/KbZltiKLqQxZaUXv4nd7Evc+seO2e2Qt1KV4tMyNAtGuTK5iaPcVFG7WJ+2aY1nEW6r4+WaumaG0XqAycHmRzu8tsurE53oIHR3cVEJ7GK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyLaojJ/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223378e2b0dso59332495ad.0;
        Mon, 03 Mar 2025 02:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740998478; x=1741603278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ0o17tx16nh8ROJW+wum1WUOBWBmUVIaZRfqxjse6A=;
        b=UyLaojJ/xQDOcTop57u6S58tEFJ1G4eJwFBZm6QrWf9Z0XnGFlzMlFbast1ssrkGKP
         OfmfOulobWqGqtnh3vsvwYbAlkA7ILA8dTmT+/iKtk+XZ/uiSE+0Wk8CK/qr+hlTxMq+
         s0HmMnX0mnIQ7d9luYWemBXPViO9wPNX6fpm26vU5+QNOmPPYiXksCSLU718BUoi3Aic
         Ssb7KIP0acyaO5nEvgEKpZrgrU0xBlWKdQipFvQLUXGVmVQn7Nbkr9KOSLl//ufqvxfQ
         G1Ptq32mHFjmWvvh9J+7ixdp/37CdH4W0N/7imso19MPcq4gZlonrb0xryjm04NBs7FU
         10AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998478; x=1741603278;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sQ0o17tx16nh8ROJW+wum1WUOBWBmUVIaZRfqxjse6A=;
        b=X67WwReTeW9+ABYs9AH8jRVJtNMsduhXTNdWiK57vTBsnCwBkRws9CFwrR9uZSGHJj
         XQE7PlpYVF7N/qdixc8Qa20yjoSSh/fy9WNMi29LjpIF03ovMRxsgoWsIWYlYM0GQ61M
         W+HLfjyg4IvX5uyDeCwBn/HeyDcXAYgRkEjjbcqNJg8yVyz/LvukiDWXUidOU9KSnggt
         PRqLJr704+Cv7Yt5leEnKsNdaUWqgl3pWc9R0LtORKRVG/ilf8Yru53jWqBYu7GGOhVw
         1qzcLswJD0IasZCAj8FzD4OsiDhD2lkLadS7cbO6gmvW9oUS6/YxRBCaEP51q85ZQ7l+
         deFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4rnlQxqFGZh70OpVL5klCDeUDmKdVZX7AB3BfZ4DYdAppgSBvhwWrJfKHvV8x7dZ9CcwBv8z2qEBkMes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiILZRzVMvHPAuza0pA/LBi6sPWfSlBTaBC8LgpXMCIoRe/MX
	iQVvWxMkbfHtLqHZmA9bsV2/W6uz14VpsLwOM4dxTEXBMmjbWNkHN58AFsId
X-Gm-Gg: ASbGncswNUM4Y3idiU+HpRwz/3k6NQl8qsCuoezgebBvmmff47+V6e99gQcSXFF7oEQ
	ZWDzC2Lhrgtrcax5wZK1QNiw7CojcHBR6tOyJf5hnhAKyCVJLIu+gUrANI2nZEjT4oFIxztX3ep
	NIGXJRQ2i1EtlYzcswKDTfOcKAiol0676KmrQLYiyQ11Bu9RMw0puW53YuCXvRtScOjvxCmO6SX
	dNHD2fRHlC4dy2RksDScqpPKQbyMNjf3NN55k1Be3mv0U3ODvRSRUxQ2TKbjP8tmmAUeon8Vg+n
	bSIS8GWg0M+wtl93M4ZdErn14/DLcr5Q+65KkXuqMiku0eHBHB8HERY=
X-Google-Smtp-Source: AGHT+IE3azibPuRjx310yW152ViH2FUwBPLDMP0MX06wsixQ7iCeGtZokWJyylVXVkiCQO5dq5ySWw==
X-Received: by 2002:a17:902:ecc8:b0:21f:61a9:be7d with SMTP id d9443c01a7336-22369223651mr236845335ad.49.1740998478067;
        Mon, 03 Mar 2025 02:41:18 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050fca1sm75018875ad.211.2025.03.03.02.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:41:17 -0800 (PST)
Message-ID: <987ba865-3517-4e2e-8e32-6e46482d019a@gmail.com>
Date: Mon, 3 Mar 2025 19:41:14 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kyungwook Boo <bookyungwook@gmail.com>
Subject: MMIO region out-of-bounds access in bnx2x_init_shmem()
To: Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, 

It seems there's an issue in bnx2x_init_shmem() that allows an MMIO access
address offset to be set directly from the device without either range check or
filtering, potentially leading to an out-of-bounds MMIO region access.

In bnx2x_init_shmem(), bp->common.shmem_base is assigned from an MMIO read:

bp->common.shmem_base = REG_RD(bp, MISC_REG_SHARED_MEM_ADDR);


This shmem_base value is then used to calculate an address for another MMIO
read:

if (bp->common.shmem_base) {
    val = SHMEM_RD(bp, validity_map[BP_PORT(bp)]);  // Out-of-bounds access here
/*
   in bnx2x.h, 
   #define SHMEM_ADDR(bp, field)	(bp->common.shmem_base + \
			offsetof(struct shmem_region, field))
   #define SHMEM_RD(bp, field)		REG_RD(bp, SHMEM_ADDR(bp, field))
*/

If shmem_base was set with an unexpected large value, causing an MMIO region
out-of-bounds read access.

Futhermore, I think similar issue could occur also at shmem2_base case:

// in bnx2x_get_common_hwinfo()
bp->common.shmem2_base = REG_RD(bp, (BP_PATH(bp) ?
				MISC_REG_GENERIC_CR_1 :
				MISC_REG_GENERIC_CR_0));
...
if (SHMEM2_RD(bp, size) >
	(u32)offsetof(struct shmem2_region, lfa_host_addr[BP_PORT(bp)]))


It seems that a range check patch is needed for shmem_base and shmem2_base, but
I am not entirely sure what the correct range should be.

Could you check this?

Best regards,
Kyungwook Boo

