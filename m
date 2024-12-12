Return-Path: <netdev+bounces-151564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5969F0034
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 00:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79CB162053
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEBA1DE3BA;
	Thu, 12 Dec 2024 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyFEk7bZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F5313BC26
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046439; cv=none; b=nfYvjszLHY+vIg5UtSkIxBYgtUNWYPxPUrQkMgGmt5wIOxwURVAOckDI/ND/fZeLlfHY/0XCL1t++ZCc4lODlpKrbHRnu+KIvL7mF+MW4D2PHXUoiPcorR6shSyQrU0CE82scPOZU4+Nwgxs8Sg0RX6fzxke5osddtAUWA0elPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046439; c=relaxed/simple;
	bh=jEJnjScO/YSbRCtvxKFizyayCq8HRzZLyh/em8BEj5k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c03TveA5LlkuEh/Afs6lDmnYVsJ8xQCNVFN3n60I46VQhNxTIj7cUW2PQwnGykvJ0bg6o/VfqSK9TDyI86WygwdtxMTiUSXLqhoHpvTCIdoggwQR56xOJQxFqIIZr0NScnhhgtrv/kD6j3p2PgENrZlVzgezquIjnD66EsNJj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MyFEk7bZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725cf06e7bcso1036755b3a.3
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734046437; x=1734651237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gLVftiiQq4akEB+OBVvUaxKCKfRMsg/7Sv0m+78/QB4=;
        b=MyFEk7bZxW1aGPcb7a/WlOl8aQ+tAGvbclQ4UXDOMgshUfTFyG+YsEHcOO2CnK8SkM
         cEXY6xZJfibjBSd3CJEZQEm3LzUUWVMuKobeesSJrq/7a/j9sjhpCcMwZbldTTKLJ2ZW
         3clIc/g14r3Ff91D3lijc38isVe0+7T71LxQK6yIM8iDxlDbateSQVT/oQRzSbfC2ojH
         u6j8RdsbEuOE2l1El4tOX2WBrwAc4J+PWOtoy4CTjAIPKdBGavEKYtAG8u9ew/F9epRu
         7SH7AkLi2hEOXX2nscacxdCvS25qEl/9wr+JsBEWZ8PKDjyRShPjIiPTyQVGqaFCULqn
         vwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046437; x=1734651237;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLVftiiQq4akEB+OBVvUaxKCKfRMsg/7Sv0m+78/QB4=;
        b=BHp65IN8enzmo7OajXIMgNuu6HoD5EKLXWiSlhCvXDAsL2xNUf+4jWtm7xk5AECAPG
         2lWFIAbmGrsampDYVQMx+wBWh0nQAIAIvSmUIKeIWcy22v5J5Z/l0bEEWPQPBrn9M1xG
         O+9D6IIrw5q13HDXnIfRys6mwZNQd3PUgH956byRFI7CT3lFNzOKDORDfSPI7pB+uk1J
         x/SxeOF3llLItx+493xG9VZhufdThP2t8GmxJOBi6NYMyk/2A57tMh4WcnR9E1wi8edL
         QM4Tx137SMr2MfnoDr2CSPKWCbMvy3Ge8BRbzteTdhtSxU3qoM6zgKbL6CcgfXC1rlMn
         2TBA==
X-Forwarded-Encrypted: i=1; AJvYcCUXNqa/uckNXW9pmNGaY3bHF1C2Lmy7QIN959bzaTpo5emqZ6xjIPbaGNppYk23pEwI0Orb1CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbEGRBQS1o9LCte9H2i7w2HeUvBqNkN5+ISjfBTR2tsAatxIE
	rvbS0QAc3XNI7ki69BNC+seZMjY3XxDZujKKqw+EP0uZa+//lAcWxf78eba3sD9vDVHHlBm4ZR0
	KmP7cKA==
X-Google-Smtp-Source: AGHT+IGEXM7+fNeWc2fIXBSFJ8pi3T0k9Tu+WFppiiRiTyRZ3FGf2nCxK3Dn/BUITxXbwDo18e0BTVZea9s3
X-Received: from pfbhs6.prod.google.com ([2002:a05:6a00:6906:b0:725:9e76:b700])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:895:b0:725:d9b6:3932
 with SMTP id d2e1a72fcca58-7290c1df088mr644347b3a.15.1734046437615; Thu, 12
 Dec 2024 15:33:57 -0800 (PST)
Date: Thu, 12 Dec 2024 23:33:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212233333.3743239-1-brianvv@google.com>
Subject: [iwl-next PATCH v3 0/3] IDPF Virtchnl: Enhance error reporting & fix
 locking/workqueue issues
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Vivek Kumar <vivekmr@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series addresses several IDPF virtchnl issues:

* Improved error reporting for better diagnostics.
* Fixed locking sequence in virtchnl message handling to avoid potential race conditions.
* Converted idpf workqueues to unbound to prevent virtchnl processing delays under heavy load.

Previously, CPU-bound kworkers for virtchnl processing could be starved,
leading to transaction timeouts and connection failures.
This was particularly problematic when IRQ traffic and user space processes contended for the same CPU. 

By making the workqueues unbound, we ensure virtchnl processing is not tied to a specific CPU,
improving responsiveness even under high system load.

---
V3:
 - Taking over Manoj's v2 series
 - Dropped "idpf: address an rtnl lock splat in tx timeout recovery
   path" it needs more rework and will be submitted later
 - Addresed nit typo
 - Addresed checkpatch.pl errors and warnings
V2:
 - Dropped patch from Willem
 - RCS/RCT variable naming
 - Improved commit message on feedback
v1: https://lore.kernel.org/netdev/20240813182747.1770032-2-manojvishy@google.com/T/


Manoj Vishwanathan (2):
  idpf: Acquire the lock before accessing the xn->salt
  idpf: add more info during virtchnl transaction time out

Marco Leogrande (1):
  idpf: convert workqueues to unbound

 drivers/net/ethernet/intel/idpf/idpf_main.c     | 15 ++++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 16 +++++++++++-----
 2 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


