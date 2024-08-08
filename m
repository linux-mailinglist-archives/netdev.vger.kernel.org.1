Return-Path: <netdev+bounces-116693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA7694B61E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19FD1F244FC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C613984A5C;
	Thu,  8 Aug 2024 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="vl7yHCGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A78138E
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 05:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094123; cv=none; b=nvCjyeNqwc2OfKt6aRz4UyNrRL+Iaz/ZdKn+z+4NRdgrND7SJeLuSvA/+zd+OdmWEYNGaDEK/yayqiVhTGq+3PyRpSoswLFJTa8VZkG00HvaM8tUcOE14uRqso2YS1rX+SqQSJrCUBOndtE7ZVrPb2ydBElNKHImyyitC4RLL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094123; c=relaxed/simple;
	bh=kVnabHZOhMDNye3j8+ZWety3Fhm6qSsrTHS2XyCTl2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caiEHXecnzKM5qwYPRT48PPmUUMTd797qsj1j71oJu6iFSQL+eAN/lIx9F7EKyTiAMcf1Ufbmh6CnwRNib6rZN6yGm1z9ZfVIzdhMei42/4ckenYyjXXyJRtv1wNzAjlBcbrjkruHbr86W/YRNnvkNshe9jm/wIHh/KBdc/bE8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=vl7yHCGH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc65329979so6453895ad.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 22:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1723094121; x=1723698921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gCYMW6BX47BMiZ8q+ZnNYJeKQod3YJhuLO/EcKtXbo=;
        b=vl7yHCGHOo/c9j1mOqZs4N4fwP8KNoe8gev91DXz+TzpoN8zyhhN/lNYQLVGGZtD7d
         olbeNokSZCpslCwuD83OikJSkVq9aznFfpPKs+q5RREIcMXo1owBZs8tyu+dEjG/df6z
         0xFnKWGlws5a8LPdvhOP1bBxh7lzlRKrRHFqJsKk71+UQct+et7/7COl7pKpzzxrHjfl
         WGqqi0hx90b+93tGtGH441OyOk8rUBZV8NmbfypmWwvHV0SASKqpBbKyWaXbA+4RHN/h
         sVAyb6gboD53eTd1nY4l3u1eYC+2WqTnI16eOL7QV8zvn19RFWkVcjAzJuUtVqM1D7ZA
         oeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094121; x=1723698921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gCYMW6BX47BMiZ8q+ZnNYJeKQod3YJhuLO/EcKtXbo=;
        b=IMVTg8GZJW40YulpJNpw2wOwgoOAee0SkjRsnWUM4nvsgj8z9EShWYqFYURenpzXBv
         pKKMMIPb/oscqe2xYW7q660/6LRJV9nGtyvobPLni5RXIGgQW5CAAob4Iu+lf7VKJDXT
         diJiyzM8jzrSl0QUa4tA5L2ERRX65H4/vZTyks7a/Q0wwVIGBHv1SC73mj6YiNfuENdl
         7N4oB94iXVBy4+4LjTke2l02TUAULlE2zp/b2ygK6YD8nyMM+bls7qUTMHxMpnTsc/UD
         beWt9Qh+c7h9E6jKYeQqEWxc8gceKRAAbeKJlmSDDGVtu1F8cfBv0WmA+bzWfjkLv19u
         OaSA==
X-Gm-Message-State: AOJu0YzAimAhQ2EQPe5gRTzhNui2SAg7wHv+t4iW42+C29On6yF37Buv
	zv0Ps1eUKVABpZNDxtiJnPOrhAL841oZnq10PHAqDgB8qm5HxHT3mvQ71dwX+VwnLfsLh+/4oTf
	H
X-Google-Smtp-Source: AGHT+IGnMTyhj2hfjC3V0pJPczP5t7lV5UIbpgU5CFB/brmKI61zvp8VBqJzvU0k8MmxavQrjRgF6Q==
X-Received: by 2002:a17:902:e80c:b0:1fb:715d:df83 with SMTP id d9443c01a7336-20095224979mr11844885ad.13.1723094121352;
        Wed, 07 Aug 2024 22:15:21 -0700 (PDT)
Received: from localhost (fwdproxy-prn-035.fbsv.net. [2a03:2880:ff:23::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59058d67sm115572715ad.169.2024.08.07.22.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 22:15:20 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v3 0/6] fix bnxt_en queue reset when queue is active
Date: Wed,  7 Aug 2024 22:15:12 -0700
Message-ID: <20240808051518.3580248-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current bnxt_en queue API implementation is buggy when resetting a
queue that has active traffic. The problem is that there is no FW
involved to stop the flow of packets and relying on napi_disable() isn't
enough.

To fix this, call bnxt_hwrm_vnic_update() with MRU set to 0 for both the
default and the ntuple vnic to stop the flow of packets. This works for
any Rx queue and not only those that have ntuple rules since every Rx
queue is either in the default or the ntuple vnic.

For bnxt_hwrm_vnic_update() to work, proper flushing must be done by the
FW. A FW flag is there to indicate support and queue_mgmt_ops is keyed
behind this.

The first three patches are from Michael Chan and adds the prerequisite
vnic functions and FW flags indicating that it will properly flush
during vnic update.

Tested on BCM957504 while iperf3 is active:

1. Reset a queue that has an ntuple rule steering flow into it
2. Reset all queues in order, one at a time

In both cases the flow is not interrupted.

Sending this to net-next as there is no in-tree kernel consumer of queue
API just yet, and there is a patch that changes when the queue_mgmt_ops
is registered.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v3:
 - include patches from Michael Chan that adds a FW flag for vnic flush
   capability
 - key support for queue_mgmt_ops behind this new flag

v2:
 - split setting vnic->mru into a separate patch (Wojciech)
 - clarify why napi_enable()/disable() is removed

David Wei (3):
  bnxt_en: set vnic->mru in bnxt_hwrm_vnic_cfg()
  bnxt_en: stop packet flow during bnxt_queue_stop/start
  bnxt_en: only set dev->queue_mgmt_ops if supported by FW

Michael Chan (3):
  bnxt_en: Update firmware interface to 1.10.3.68
  bnxt_en: Add support to call FW to update a VNIC
  bnxt_en: Check the FW's VNIC flush capability

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  50 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   7 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 389 +++++++++++-------
 3 files changed, 300 insertions(+), 146 deletions(-)

-- 
2.43.5


