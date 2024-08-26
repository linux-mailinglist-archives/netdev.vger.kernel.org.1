Return-Path: <netdev+bounces-122004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649895F8C6
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69932815B1
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697F5198E7F;
	Mon, 26 Aug 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yFPX6pFQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00018FC83
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695838; cv=none; b=u7KVimD7mpjr9wqd9qD3dPvxcQB/0r/0r7ozIhDps3aI7kiVMxQAKi3pK3yE0lO0lgDob2PoBoF53TlU3jeYY+sUpJ81fMDOIPMsT1PKe7jmpg96vg12v/l3QfWxQA1T3Wxx0tqsXBq5ceTun1ktsCfV/NZVMTXgErVAQGT00Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695838; c=relaxed/simple;
	bh=jJ5kI2hX49i8CYigrcaJSvfOivbXEet7r+nJZyEoV+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QPGOOM3JiImH8GGpyRNQTdIc5QANdsBgHI/bY39ZGm46QiWpwKWcAb8sXoKWfd88QY55hhhH+gcZZI10KWyq4gLsGrkOKe6jWICsJ4ihq0eWhd44UfGjmtY+o7NX+bvSJyBLiPeaLP3ixLJfpysVuCYz6oPnKfLlqgW3FM6pKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yFPX6pFQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad660add0fso62813157b3.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724695836; x=1725300636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mTr0RusGy/kkC7ALbroZ0gyeKwH4P5QfJnAsXPvr08g=;
        b=yFPX6pFQIFlRS6z/SnF21wYwzW7pyhLt0d8QP29y+18XO5iPpctrclXrjZBxYc/vL7
         yzCOoe9fi+YMZVGGGZNQTc5trDSlhcrA/na/ycwrTUQMUbYJgn7Q2tMKybybm7gwn37j
         rSocHIlHhnRXrdjoPBoF/HEwDcRU1ubPyhrH7FFDkkEDoxT0XngDe2fod2+CdjWXsg73
         TbmGxO2iEBohkuDhvtj1ChBok6ABK2Qvik7CiWGV04k6UZUiF2z6LSKMcGDZLO0vTMWG
         4jH8uXUol8luXaDq3JRqj5kp3WjZu/ap4gsV5Nq5fRaVLpzvcKUrP10XTi/Py2nWUmUD
         hK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724695836; x=1725300636;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTr0RusGy/kkC7ALbroZ0gyeKwH4P5QfJnAsXPvr08g=;
        b=sTKVuOdXBL8TyLyCjSHRcSlmI6sd2pf9sGlrPnzGZFkB5gm8nfszgseEid2rnkSa9x
         B65iF2ItGxBXqPH8YGHpfgjHFxoTBg+YsLYIyRP6cy7v0NXN09D9yIALQU9VB3HNeehp
         jxo6nmOg+RnGad3e0bsS8vm920xufn2pIlGs0iYkVAnj9PtyI6hGwbEQjnorjkqLyYRB
         QP0QOOCVzp1aUIwZCp9C/6sZmzTgkNQCmItmmrF1kWFacMlkIET8x2io5P3iPQXOq3bb
         oXTHLOu1q7L+y1i2HuzUiLui2mFR/+4M4MsEmTJHvbRni6VHFbDFUG/33YeM6dVg5dby
         Xdeg==
X-Gm-Message-State: AOJu0Yz672NnV1JtG3/F5JjBD0O41n0YMW+XmF2QfhUGA4WzvdKaPoHX
	7oK/51PPwQrODnNNh1n/DcrnMNcxf16bQ1vyCfei8hhIIPZiyM2tDrJN1tB3NlOVMdaYl+B0Wj1
	LxEXwzddyaLyffEnVvg==
X-Google-Smtp-Source: AGHT+IFHyXalfVjOuxjXXsyPmAQk/GYjfxIDGWeV2rNaHSGoyyu+Si9CWtq+Oy8pba0Wr4yolZItnMJDwrKMH1Lf
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a05:690c:6981:b0:665:7b0d:ed27 with
 SMTP id 00721157ae682-6cfb27443b6mr274247b3.2.1724695835824; Mon, 26 Aug 2024
 11:10:35 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:10:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826181032.3042222-1-manojvishy@google.com>
Subject: [[PATCH v2 iwl-next] v2 0/4]
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

IDPF Virtchnl: Enhance error reporting & fix locking/workqueue issues

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
V2:
 - Dropped patch from Willem
 - RCS/RCT variable naming
 - Improved commit message on feddback
v1: https://lore.kernel.org/netdev/20240813182747.1770032-2-manojvishy@google.com/T/

David Decotigny (1):
  idpf: address an rtnl lock splat in tx timeout recovery path

Manoj Vishwanathan (2):
  idpf: Acquire the lock before accessing the xn->salt
  idpf: add more info during virtchnl transaction time out

Marco Leogrande (1):
  idpf: convert workqueues to unbound

 drivers/net/ethernet/intel/idpf/idpf_main.c     | 15 ++++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 14 +++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 12 +++++++-----
 3 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog


