Return-Path: <netdev+bounces-146353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011D59D3051
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 23:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86669B23982
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555F21D31BE;
	Tue, 19 Nov 2024 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcoc4TmE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161D1D2F56;
	Tue, 19 Nov 2024 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054440; cv=none; b=uiwDwTu9H5/n4ycbVMv4+Z/rAPR4fnDVpsP4Vi8+YSBPj68IroaRGKExwDIdqmL1OU+eXfTPeV4wUXQ0/u6G1GSzvziaLQAPrdv98rR+BgzDwBx6bFQDlKuUIwfLjytFpI1XPJd3jkqOy7mbacyLIEEO+rMjumweBtl7L/YKwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054440; c=relaxed/simple;
	bh=8/mQFCXNKJUEmN3qVhUBboV4Da+6g1Q7JeeLhIrhgVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QtMG8M24pVMWT4Y3hYpH7fiLjnF/3Vojm0Q/S2jtS77lwbM1h6gK64Czd9mATGuU1TKtbVLkfavARBEjziLDA4FttkWWHE2pcBN65d2ZbIo6y6oMtmoDalWTGIy25tBh2jhZtvKCRtiPlZb7z86PrE9he/r0x4AJJYRS6k3e1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcoc4TmE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so4588418a12.3;
        Tue, 19 Nov 2024 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732054437; x=1732659237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U60DPgJUp8r4y1ZJ64enchMXWBfY8GruknuA2goRidc=;
        b=Tcoc4TmEg+hnJq0nry47dr8xu/zLd+h4diMQ96RgL+LGqzHfhAcT9zaRb0hZxe4Zwx
         o8QUtXFKXzNIe+kQ1qltt7BGftfz2qLotpKBeOj4UYKEYtkOf5pT5SmWCdV0iuZAk02T
         k/85VqMwRcar6a/6wOgVlOgC7ZMW0v37/fYK6d+fsrN3uDJzX/2Fw4XmKrWnRwwCO0rh
         SUzzpX9ckOVZFMNTVrHzj2kMtTZp6QTlh0sq6Hxb6U1H8+3d+m1MG+9qAfGxNw50HJKe
         2TL+/ylJJR3cBrvQbBShPf0MRHTfjGbgyaly3Yo4aSnQ1M7ybpk2H4DkAzueZGJ5njps
         +jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054437; x=1732659237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U60DPgJUp8r4y1ZJ64enchMXWBfY8GruknuA2goRidc=;
        b=Ale75kZANJCYPbTl5aHFGGrOWWwdwYW6DiZI5JsH2gTnBLFvDs8l03nHe+dBO21Kk3
         kLY8RmwXtbCUBofB0Cf+G0/pzZFedbK+R13CzbHbbSRPS6d2/doIQRR5MbLLi+uLcZjp
         xqlUM5Aghb0iebKNxcIT9a81hvAEXa6Dp6L63+82howpKCKrhpvKW3Dpj4zwmUQFFpzL
         b6eymjFobV120Tj5GTL9htY4cAgj5iPnqOM9UWjhciejQjkHZBh6i0Koabbjy2Jma40S
         8NXM4UzxkB3XRjn0KikB7lmFDi/DXyKRWZuoNaPR+bJhYuGt0USi2phRxV7Pa8LE0GiG
         oTYw==
X-Forwarded-Encrypted: i=1; AJvYcCUF4HaeLEeVpnf4WuRZU+fO4MbzJAgD1YY0QHnzMLIPhiJXyJF4a1PYDCKov12Sk9+5obAUA+UGQap5xN0=@vger.kernel.org, AJvYcCXZv1CDZgDGDzBa7NtB8yQCDKtr/UqiXV7htJFJnURUxDlmMgUzLFBge07MRb8CFlAx692w3z76@vger.kernel.org
X-Gm-Message-State: AOJu0YxOgFgvhsr3z9595qPovwHModbyrlU/IQxNEVk9wflPGs9hWmuC
	BdScjFnaxqZr3GPl0acviT2/JJzP0zNbJASibjZ2NxJ0E4la7uzt
X-Google-Smtp-Source: AGHT+IEP8CTztdDgQ6Ybv6QMs20fzzvjo1rH4j5yKMclMT5FbHvGlgQEMPNxW6+9nCJDgw+dlcW4ow==
X-Received: by 2002:a05:6402:5ca:b0:5ce:bb32:ccac with SMTP id 4fb4d7f45d1cf-5cff4cb5887mr175398a12.26.1732054436645;
        Tue, 19 Nov 2024 14:13:56 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff45504fcsm133484a12.89.2024.11.19.14.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:13:56 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>
Subject: [RFC v2 0/2] vmxnet3: Fix inconsistent DMA accesses
Date: Tue, 19 Nov 2024 23:13:51 +0100
Message-Id: <20241119221353.3912257-1-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We identified hundreds of inconsistent DMA accesses in the VMXNET3 driver,
stemming from the handling of the `adapter` object. This RFC patch series
proposes two alternative fixes for this issue. For an overview of rules
related to streaming DMA access (violations of which lead to inconsistent
accesses), see Figure 4a in [0].

*** Issue ***
The inconsistent accesses occur because the `adapter` object is mapped into
streaming DMA, which means it is "owned" by the device. Any subsequent CPU
access to `adapter` without prior synchronization (e.g.,
`dma_sync_single_for_cpu()`) may cause unexpected hardware behaviors.

*** Patch overview ***
This series includes two mutually exclusive patches:

1. **Patch 1**: Apply if `adapter` *should* be mapped to DMA.
    - Adds synchronization operations in `vmxnet3_probe_device()` to ensure
      consistent accesses when initializing `adapter`.
    - Note: This patch does not cover all instances of inconsistent
      accesses, so similar synchronization will need to be applied
throughout the driver where `adapter` is accessed.

2. **Patch 2**: Apply if `adapter` *should not* be mapped to DMA.
    - Removes `adapter` from streaming DMA entirely, preventing any
      potential inconsistent accesses.
    - It is unclear why `adapter` was mapped to DMA in [1], as it did not
      appear to be mapped before this commit. I welcome any insights into
why this change was originally made, as I am not deeply familiar with
VMXNET3 internals.

*** Request for Feedback ***
Only one of these patches should be applied, and I am seeking feedback to
determine which approach is correct. Thank you for your time and feedback.

*** Changes ***
- Changes vs. v1 [2]: Jakub points out that applying both patch 1 *and*
  patch 2 is odd. Thus, I changed the patch series to apply patch 1 *or*
patch 2. I also made other minor fixes based on his reminder to run
checkpatch.

[0] Link: https://www.usenix.org/system/files/sec21-bai.pdf
[1] commit b0eb57cb97e7837ebb746404c2c58c6f536f23fa ("VMXNET3: Add support
for virtual IOMMU")
[2] Link:
https://lore.kernel.org/lkml/20241113200001.3567479-1-bjohannesmeyer@gmail.com/

Brian Johannesmeyer (1):
  vmxnet3: Fix inconsistent DMA accesses in vmxnet3_probe_device()

 drivers/net/vmxnet3/vmxnet3_drv.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.34.1


