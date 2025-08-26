Return-Path: <netdev+bounces-217003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D9B3702C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144EC683306
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C530BBA9;
	Tue, 26 Aug 2025 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSzEix6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146912BE7DD;
	Tue, 26 Aug 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225524; cv=none; b=em1TpklfXeiWyqw2UoIVJ6QjzdgaA0PVC9pRh0aDDsc6p1kPAyZ6aG6LmwQQgwDTKyqu8XBTCO1qlIVdqU/FuHRIbfBxLL0KgbBVVv21yBn3je6sQukH1sK7ui7TBfjtSO5/TuZ2v7KSBCNQ5BiGfZ9IXX6No5QAM63Zg70Yf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225524; c=relaxed/simple;
	bh=ke9w2PS1ILArXMo8oJty01ETax0KHAEkfxohtDRM9C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjK77XBs7rjn5Vz1/ubOTyS9ri4A3Eh7Z2LVqaASslUShAKqIwvNrKHjJTfK1GJ/BexgRlpVahMrGxxkjJc0+xKkAbs+4LFyfl6acR76P3rhwsFnphCGvEav4XkODCazaf3i02mmnLsMn7utPDp4E18/jF4RvjvKKYoUlBDgyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSzEix6g; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244580523a0so57506225ad.1;
        Tue, 26 Aug 2025 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225512; x=1756830312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fR5vwrJbbj/HV2dnidcan/snaQbDkfj7Zbi5rY84dV4=;
        b=cSzEix6grDDBi3b9bj9x3NaDfm2ogkPQ5WjtS1t6ufIpZwtCrf720Lg4O14IJv8dpS
         IyuttY9RJHyYqb3o7YFUQfaUmdqUGYErVusW+p6BUr5/KW7ufi2dw88VOlkSC0aDCVmp
         vmBnf7+ZE9AfpsT2J8R5EIlgFWzWPOr5ZfLiCKg6ogVMi/2+JdcrONWc7EDePTSEIg/p
         jDo0NUv8zLIWFrLXHh6waNIL/rtBPPCWAXvChDJlc38SWrqTe2RgyCYq0lYRS24WZ39Z
         ot6y6/BoVyuCQJuF6H/4IfpOejvpQwCzVw8BDYASLQ4K3Dq/WbIFP9938Xtacbap1qM8
         wE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225512; x=1756830312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR5vwrJbbj/HV2dnidcan/snaQbDkfj7Zbi5rY84dV4=;
        b=rPaN9G/iEo1vxhHqgKT7D3u1pIXIIJXhpGIg8ktG+LmuxuOthAsa78KEK/H9KBK+LQ
         4B66B23v7cfReNzvNRRVSjVdWtlN6x9ZcTcNcnPbC85Gj80ZaVMV5FbpO/iOYzeps1l3
         YzBcvv6bjLiEEUDy4Pcgi24Kk9In+9XIi9oOvysTnQbR1A5IKFbVQF3mz9n1lZ2R/1Kx
         75cXcaMCGId49u3MIP9pVZvtu5HGaTjvW9aULqOwRLoyNiRpKk2mAh/pFaWY4ph0+TpE
         emlJwsWJqlTosNDdRIr2WWH8dY9mvp7Vw25D5tDGZyI7N9wlKiCvLAkGx1NbGRriNS9D
         zRpw==
X-Forwarded-Encrypted: i=1; AJvYcCV4BgXf9mPpJF+twvGLbv6kNqCUPBJh/WRjkcepIQzQ0yxsOH62aK9y2q53MGLLeFT/mIj7pXxXQ9vkYjE=@vger.kernel.org, AJvYcCWwQBLRM44wmXh0/D5w9AlfbsxuDbvbIl8G8O8zPi0f+fsTAZ/wSFctujCUHvWyuI4fSEGwHaXc@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+Th3jNW+U/ae3Cg+d0eKdcEF5w0fxe5MF1uyZRsHFdgWUpr3
	U+fCpBBbbEIXKvXmsmN+tuLDiPBJ2ZvHZYHffdTIaQ0oPRLyVh660dU/
X-Gm-Gg: ASbGnctYaXwVhghjxu+VCKkt/hXgQTMsXDL3wjksPpopZ7gMmFRBgGLgpX8hj4W3vsn
	D0NvqPGKBZQ1DycvvXcUWMG+gwac8XNf++VxTFeWDujh+nK9H1rTIQXbvkwPhUFb//ANClypc6u
	0kVHsXmvJ9D0ADrIZ6V9c5GgAeQ0NuK/QviXdtaK4/tOBNL9X6iH5lrhy3xTbqEXQGuTkV9yWoJ
	nbBDuqitsTy4xBpf4qaXWI5f5kvwIaxikQLxwO+Ums8CFAS4ZLAT+5j01JYyVcBpsTDsclxhpFK
	s9cmN7TpGKV+cmU4U4zDSh5X+N13qmRFVd4Dlm5/F/wvR1vspYE2C8udYGuJfC25QEV1n5Uyq0F
	pSeet0dq6iRAJ+ShK7gmhLQpmYU9vUwIg61Bkb//f2j6To3z3PD0pfLZx44ejQM8fLCC6b+h95B
	bQ
X-Google-Smtp-Source: AGHT+IGrN0ZWHT5Q17mya96qh+0DIr6EHO/QaLIVBEYM8Df7t9SSax0fsSOgoRV5P/RBv24IT/MdZg==
X-Received: by 2002:a17:903:8c6:b0:240:3eb9:5363 with SMTP id d9443c01a7336-2462ee7390emr193734845ad.27.1756225512211;
        Tue, 26 Aug 2025 09:25:12 -0700 (PDT)
Received: from localhost.localdomain ([222.95.6.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2487a5cc611sm13600195ad.114.2025.08.26.09.25.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 09:25:11 -0700 (PDT)
From: qianjiaru77@gmail.com
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qianjiaru <qianjiaru77@gmail.com>
Subject: [PATCH 1/1] Reference Counting Vulnerability in Linux XFRM PolicyManagement
Date: Wed, 27 Aug 2025 00:25:00 +0800
Message-ID: <20250826162500.34292-1-qianjiaru77@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianjiaru <qianjiaru77@gmail.com>

A reference counting management vulnerability exists in the 
Linux kernel's XFRM (IPsec Transform) policy subsystem. 
Based on variant analysis of CVE-2022-36879, this 
vulnerability involves improper policy object lifecycle
management in the `__xfrm_policy_check()` function, 
potentially leading to double free conditions 
and system instability.

## Vulnerability Mechanism

The issue follows the same pattern as CVE-2022-36879 but in a different code path:

1. **Policy Reference Acquired**: 
`pols[0]` contains a valid policy with acquired reference
2. **Secondary Lookup Fails**: 
`xfrm_policy_lookup_bytype()` returns error for `pols[1]`
3. **Partial Cleanup**: 
Error path calls `xfrm_pol_put(pols[0])` but doesn't clear policy array state
4. **Caller Confusion**: 
Calling function may not be aware that `pols[0]` has already been released
5. **Double Release Risk**: 
If caller attempts cleanup based on incomplete state information

## Comparison with CVE-2022-36879

**CVE-2022-36879 (Fixed)**: 
`xfrm_expand_policies()` had double reference counting issues
```c
// Original vulnerability pattern (now fixed):
if (IS_ERR(pols[1])) {
    xfrm_pols_put(pols, *num_pols);  // Released references
    return PTR_ERR(pols[1]);         // But didn't set *num_pols = 0
}
```

**This Variant**: 
Similar reference management issues in different function
```c
// Current potential issue:
if (IS_ERR(pols[1])) {
    xfrm_pol_put(pols[0]);     // Releases pols[0]
    return 0;                  // But pols[0] pointer remains unchanged
}
```

## Attack Scenario

1. **Policy Lookup**: 
Network packet triggers `__xfrm_policy_check()` 
with sub-policy configuration
2. **Primary Policy Found**: 
`pols[0]` gets a valid policy reference
3. **Secondary Lookup Fails**: 
`xfrm_policy_lookup_bytype()` fails, returns error in `pols[1]`
4. **Partial Cleanup**: 
Function releases `pols[0]` reference but doesn't clear the pointer
5. **Caller Misunderstanding**: 
Calling function may attempt to use or release `pols[0]` again
6. **Memory Corruption**: 
Double free or use-after-free leads to system instability

## Proposed Fix

The vulnerability should be fixed by ensuring 
complete state cleanup in error paths:

```c
// Current potentially vulnerable code:
if (IS_ERR(pols[1])) {
    XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
    xfrm_pol_put(pols[0]);
    return 0;
}

// Proposed secure fix:
if (IS_ERR(pols[1])) {
    XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
    xfrm_pol_put(pols[0]);
    pols[0] = NULL;   // Clear pointer to prevent reuse
    return 0;
}
```

### Alternative Comprehensive Fix

If the calling context requires more extensive cleanup:

```c
if (IS_ERR(pols[1])) {
    XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
    xfrm_pol_put(pols[0]);
    memset(pols, 0, sizeof(pols));  // Clear entire policy array
    npols = 0;                      // Reset policy count
    return 0;
}
```

## References

- **Original CVE**: 
CVE-2022-36879 (xfrm_expand_policies double free)
- **Linux XFRM Documentation**: 
`Documentation/networking/xfrm_*.txt`
- **XFRM Source**: 
`net/xfrm/xfrm_policy.c`
- **IPsec RFCs**: 
RFC 4301, RFC 4306


Signed-off-by: qianjiaru <qianjiaru77@gmail.com>
---
 net/xfrm/xfrm_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c5035a9bc..50943fa4e 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3786,6 +3786,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			if (IS_ERR(pols[1])) {
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
 				xfrm_pol_put(pols[0]);
+				pols[0] = NULL;           // Clear pointer to prevent reuse
 				return 0;
 			}
 			/* This write can happen from different cpus. */
-- 
2.34.1


