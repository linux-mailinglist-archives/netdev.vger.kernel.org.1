Return-Path: <netdev+bounces-237349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE5C49597
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E5524F2D85
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5ED2F616E;
	Mon, 10 Nov 2025 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YX7+DKvC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F762F6577
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808331; cv=none; b=CYET09UGHJROWSRFeHXGGE4dJDn8SLyaFZv3mn1lFkfB4CXYJsJm/k7jYdhl7xCGkck0ADJGMul8hgaVukZoQrElQUoaiptIjMZ2dUhRfyRmFwQRYNi0e/e89hRnnBbfdq+ZkjSm3VNnIWkHT+913jF7QGI6M6EdLbbayrFr8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808331; c=relaxed/simple;
	bh=B0tu5HKnKF3FvVdokFFssqR9C8sJEU7TcOiIpVa5V+I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PEAf3utRBodamEKC92+lCQ+7v9ehsIAumtsgeBbWC7co+KV8xrPJ2tsuFdEiWwXloBOXnSo+YN32VVSdVDPU36MCL1+gK/OmLfKJSfc31UDYXX2tPZzO4EQzMhN5/ZwpIkAJLExAKuj6rA3ilS9NEV9cWwSmXppGGQmcGwPxTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YX7+DKvC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3407734d98bso4515831a91.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 12:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762808329; x=1763413129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTDq9jeaQo0wOalgK/xieMtHrhoMAPHOMHOfOMk3yEo=;
        b=YX7+DKvCbXIWmylCrbttRLrjwnAjbdrimGJjabgMsjJ0rdJWhaFVZk5WzJd4t0XBWx
         775DHK/+xtmOUjytxG3zx6NyRYhIMdZI0vrh2MCV2L0C+qLflEJj5ZERCL635FXBhOzY
         Nsq/nQyburmwg4WdtoRl2mpOc/WqsIG4UW2jP+a8PWFUGMAdZm9gV0NMYIGj+5XLy7I7
         syEuoAarHFfsLR2QsVhtlqqToDpTW8TpaTsLXdtzj8OBGhCTl3+qwDNGbmINOg4vm7kg
         kyU/wvKV95w5/h4U5wDF8cgeS/qsENvQtGbnNJbPlzCAhhRfYgTp41dn+SrDAk/pcYfJ
         XoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762808329; x=1763413129;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTDq9jeaQo0wOalgK/xieMtHrhoMAPHOMHOfOMk3yEo=;
        b=oQYIIPgHspqZhvh7T+m/bfk/S7huCwEdA0UY6X5alg24efb60lkvI621rAZzIxENGW
         sM/PjENFT2Nnnw/LpRuU0++goIQGSA//J0GUB1WGdL6U6Ct+XEfZylJ0nx/F+GQL24Ly
         Um9bmrP5EfEu9+098xQd6U3/wSRETF5E6jdlO4Yf+q37tNJ/ltd3Jr3TgT4Q/ftrVT7y
         IL4HlUyBBh5hL3ZoFdyQiNiog+CLz0LnEx4maXuNC3Qb2y/l1kvLBywpqdwQbB/BB1RZ
         Hv8peUC+IRevhMGw9LCCvRTB+yqJePaFwJiYakPTO887GFlH7XKkFsmjSC4wpSK2j1QU
         EzJg==
X-Forwarded-Encrypted: i=1; AJvYcCUkd32DmjGbv7e1vyyzfJiO8jNAic3aOfH7kcHvYAd4CQG4aCiVZIc7H0774GOkq9jr8WWASoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQ0W0IA7jgm0+aFfliHGfASv9JZn6aN/eLRvQuIOQ9ac5iElj
	ulRRMaViq6PgZke0kIzlCJVomfjssYrN5b4Dp9Ca8M3rwoRXKD4RBGLT0ESvceH8TrpWuovOOUo
	eK7u6XBaI7w==
X-Google-Smtp-Source: AGHT+IHvzBtOuQaT0QbtsDDe5GbIuvBIJRBAx2LgnXxO3WuRHCzu/LTGZ6OKcVN0BcGwSzLApG60io4lmv5I
X-Received: from pjbsc8.prod.google.com ([2002:a17:90b:5108:b0:343:8627:1010])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5588:b0:340:be44:dd11
 with SMTP id 98e67ed59e1d1-3436ccfe211mr9734686a91.27.1762808329392; Mon, 10
 Nov 2025 12:58:49 -0800 (PST)
Date: Mon, 10 Nov 2025 20:58:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110205837.3140385-1-brianvv@google.com>
Subject: [iwl-net PATCH] idpf: reduce mbx_task schedule delay to 300us
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, emil.s.tantilov@intel.com, 
	Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"

During the IDPF init phase, the mailbox runs in poll mode until it is
configured to properly handle interrupts. The previous delay of 300ms is
excessively long for the mailbox polling mechanism, which causes a slow
initialization of ~2s:

echo 0000:06:12.4 > /sys/bus/pci/drivers/idpf/bind

[   52.444239] idpf 0000:06:12.4: enabling device (0000 -> 0002)
[   52.485005] idpf 0000:06:12.4: Device HW Reset initiated
[   54.177181] idpf 0000:06:12.4: PTP init failed, err=-EOPNOTSUPP
[   54.206177] idpf 0000:06:12.4: Minimum RX descriptor support not provided, using the default
[   54.206182] idpf 0000:06:12.4: Minimum TX descriptor support not provided, using the default

Changing the delay to 300us avoids the delays during the initial mailbox
transactions, making the init phase much faster:

[   83.342590] idpf 0000:06:12.4: enabling device (0000 -> 0002)
[   83.384402] idpf 0000:06:12.4: Device HW Reset initiated
[   83.518323] idpf 0000:06:12.4: PTP init failed, err=-EOPNOTSUPP
[   83.547430] idpf 0000:06:12.4: Minimum RX descriptor support not provided, using the default
[   83.547435] idpf 0000:06:12.4: Minimum TX descriptor support not provided, using the default

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 52fe45b42095..44fbffab9737 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1313,7 +1313,7 @@ void idpf_mbx_task(struct work_struct *work)
 		idpf_mb_irq_enable(adapter);
 	else
 		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task,
-				   msecs_to_jiffies(300));
+				   usecs_to_jiffies(300));
 
 	idpf_recv_mb_msg(adapter, adapter->hw.arq);
 }
-- 
2.51.2.1041.gc1ab5b90ca-goog


