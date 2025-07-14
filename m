Return-Path: <netdev+bounces-206761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3EDB044FE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED937AC254
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287525C827;
	Mon, 14 Jul 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYPcbROf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E7234984
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509100; cv=none; b=JhlIeXe+qz6MOMswbGvnz33+DYHBV3Gl8tLkp86jJK45ScyhlEymw4dQQePw5sw8Jk7vg/f7tDFlyis3J2yKG7ND1wwuwIu8Oe5QdPdbsAiqO9I1I1l8pTBa4YIrQ+/P3Yic7hmxQZPf12NerhVr/Hgh2BN9aEmNxmdFT5T/e10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509100; c=relaxed/simple;
	bh=WWzx5aab5CL9bflyjquScC+a2vdJcPtrOjAPEp87Pvk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZB7z7KS8xSAqX0NDv11NxbGT8m6bugBw1lz3FPAZRN8u7GCWCmJNeFSBd3expPxdrDtBp/XrHJCpZVJlUC/tOEG+4h9N60t9aYZgHgcNtjrNI9lZuIv7HnosfoHjNdVhZLNMThXwiWcz58rbUuwFG8zWo7hvBy3eYakTyvuuuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EYPcbROf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748a4f5e735so4347753b3a.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752509098; x=1753113898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i83umX+MZr3KIx4tRfymCzj3p93d6SJbJecFRm5qqH0=;
        b=EYPcbROfIzTsAP46vhhdGV9uRbRpH7UQnz5pKuLG/spcjeeOzWATXHY0rOa3HvZTYH
         DqcNmTqp4i97Ps/GbX9wLxFUUW/62zZskAR1Iww/dPP0aqnMup5qq/VoGIRf5cfTWZSw
         c3girz9dJK5tV/PIL0KWTf4Qn7njnOIb4YFcLQkximLK5Zq6NpaGNTDVp1pLBpeh9Lye
         u8fcsPSS1oj2K2H8F/DLvg8kYIsGd+K/vxwHHU+l5JU5Qn540/4DurwexWJFRDHDYLwN
         3EPvdBhaiqjLZubxBi3H1qGlvxKU4U9l/VDVeIgB/sXDq5klzSPSnjLSyTlDE9fp/JOa
         iy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509098; x=1753113898;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i83umX+MZr3KIx4tRfymCzj3p93d6SJbJecFRm5qqH0=;
        b=aMw7/A5SB1G3SvASPoDDLhCwlZO7RnsICx+1h+pO2HSL0PYZv9ambGU3B24FgNa7xU
         SQrqaPfPdqDRQST4wRKm3V0LJoGMVvF5UYCTaYddvJCso+/ojpHGYJOdWgF0ca25Czdc
         fydSfbz2IAM7vKmRoUAZUquEHT+lsLs2VUkdibhbGl2Ve63dM7E2EV8rR1IwvhgyrySr
         w5mgLTMGOxe1vy8B43S29EEcOnCGpgLturhu4m6JmzGJ3LH/gKQvh15yhlimCAMq8U9n
         tiZXrefWPBEHQo9AIyVTBuXDLC+T2udco8PznewJ3CDorlig00tYYADVQZ8hDrlef64N
         EMhg==
X-Gm-Message-State: AOJu0YxFbOI/vSF01XXGcP6dzwJjE2HKOdYZHKgmGTN7CeMmJVMeOIK8
	Iove70L0bWeqmplc0gCu0uvsPIXgz/KzFrKGMge7pLO2aG8AwsByw+tNxfjAvqD/rDWL89y93ai
	geXZ0ySjeRFkpFEnE3VC4+/kyW8ZidEI9GtEAK1N95rnnJX+nHRyrgP8a7vkgfwJ19e5zxygy3r
	KaSd7Igo5Z0YgDQG0pFHrlrZ2wGUIih1drFSYqtgXQ7A67Mi0=
X-Google-Smtp-Source: AGHT+IHsk6tDW9pPMmemXtqNIHsTLYhvEjjs17jEHkzJWODCI09CR2L3GRSeGSrj8R64BvZjNEVzQxTlGBrltA==
X-Received: from pfbdn21.prod.google.com ([2002:a05:6a00:4995:b0:748:8e9:968e])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:398f:b0:215:eafc:abd9 with SMTP id adf61e73a8af0-23135050bc3mr22204021637.14.1752509097976;
 Mon, 14 Jul 2025 09:04:57 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:04:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714160451.124671-1-jeroendb@google.com>
Subject: [PATCH net-next 0/5] gve: AF_XDP zero-copy for DQO RDA
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch series adds support for AF_XDP zero-copy in the DQO RDA queue
format.

XSK infrastructure is updated to re-post buffers when adding XSK pools
because XSK umem will be posted directly to the NIC, a departure from
the bounce buffer model used in GQI QPL. A registry of XSK pools is
introduced to prevent the usage of XSK pools when in copy mode.

Joshua Washington (5):
  gve: deduplicate xdp info and xsk pool registration logic
  gve: merge xdp and xsk registration
  gve: keep registry of zc xsk pools in netdev_priv
  gve: implement DQO TX datapath for AF_XDP zero-copy
  gve: implement DQO RX datapath and control path for AF_XDP zero-copy

 drivers/net/ethernet/google/gve/gve.h         |  24 +-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |  24 +-
 drivers/net/ethernet/google/gve/gve_dqo.h     |   1 +
 drivers/net/ethernet/google/gve/gve_main.c    | 235 +++++++++++-------
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  94 ++++++-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  | 148 +++++++++++
 6 files changed, 425 insertions(+), 101 deletions(-)

--
2.50.0.727.gbf7dc18ff4-goog


