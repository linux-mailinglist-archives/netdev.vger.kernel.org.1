Return-Path: <netdev+bounces-131827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E2C98FAAA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6576F1C21249
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C2F1D07BA;
	Thu,  3 Oct 2024 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ph+EI6vV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBAB1CF5C0
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998747; cv=none; b=piu24yc9VYJ7z8h9NWhkaWLU+9lEFmanXSTQUHbn72VEvQoELWHVOJIGxUxN4gTbBw5sGenOCxkFEGYHb7Nm0oqVVNxq6Z7SmVfaC9REfYY9jd93/6x4yNRFpatr3PQ2CAHzbDJRHp32skMcgsdwEeFL4JQyR3gKJEF3o0Cet5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998747; c=relaxed/simple;
	bh=aOPeijS4l9gs82itlGqmWgc4L9/VH7+qNqQbZnpSjfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duzOtxn2jv2hcq4Jzt/PqAI5VyDKsY6qV0Sslp8aVKraK9WZCY6KlPsGDAQBAjL0x4IJ+rfEf8Kb36z1QtXQhSA+8Rus4L6gBhsDAZKXolH4lzVWR7Ee42JSqn6go6HaZZJiUUxK60pJ9IpFTp84fTXl2ZNlt1hsYCu1OFQhpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ph+EI6vV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ba8d92af9so11701045ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 16:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727998745; x=1728603545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhYp0DiSsQbpO6IwfgRG0/juZs6Inw4x8enD4rVfZ6Y=;
        b=Ph+EI6vVHnN5Qki1onLS7NYJbUNz87WGE85rlcb12TjnB3CkTI94OYooLrYoY/Jhdr
         LvI2kNIbEzkkC5pMHqDyI4G9E4dOa+4piOHro2TCj4FACHP1Bm+KCk7NX3X9T2dlBC56
         QOs+U47ZkdxfLc/hQbjaQAaH8U7MdDHosRzYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727998745; x=1728603545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhYp0DiSsQbpO6IwfgRG0/juZs6Inw4x8enD4rVfZ6Y=;
        b=eKVDw0JXQ8ye4QftCQrxIbfZRAOTEZNkENRKpdwAlrtjcD8jUkNCze8Dw6fXwc4nF5
         EuFKzfHm4PHJ/6rNRCxq5V8Z+u/uX4QkRHZ25YDkl4Aku48hhjw6OuCCJf+ym689nm96
         xYYYXhaZF/Wz+Xy9c+FKT3v6ecfG2hih3WpORbq9Za336CskTxXan+eQoV1PIsy/GZIb
         Z3XfWx8jfIPqzBuOUnmAjiGCTYNjQ/06dUuTX893io7u4fWbU+VI0YZDdHfNdXcKe9uN
         fXRs4n5FecwJlZSiZHWiScSFiU7pYZnRLVD2RvNsZdEvMZroR2RDBuX2ZDHzS/OYqqM9
         9Tlg==
X-Gm-Message-State: AOJu0Ywy8xS7J2WOGz0avZgmvbzDs1uLqhBDJFcBdf2Q7IgEV/lZx0Tj
	UWejvKUVkGACzJ5BpXaeuWji7LUT632CZ0YDd/+VzWbrS50QSMGfsRe/wM6DjyOv1H0oR8Yqq/E
	vDux96N8syp9wjiatpzPlI+9aun6xUzvwT2GBUsHBss77NXbsxLv4wnuZ8vh3Tx6ebJwDaFZtVK
	GA60mgnfXAB31AJh7HtY5goxgFU9YJQhf69ao=
X-Google-Smtp-Source: AGHT+IGTpJ2+WaujujgDrlAgiMjkPmANHMw7/ysggq4USb76kJULVyruSiv/pbcSPf0FW7LJGb0RPw==
X-Received: by 2002:a17:903:2a85:b0:206:ae39:9f4 with SMTP id d9443c01a7336-20bfdfc6ff8mr15955935ad.20.1727998745106;
        Thu, 03 Oct 2024 16:39:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8ec6bsm13960705ad.158.2024.10.03.16.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:39:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 1/2] igc: Link IRQs to NAPI instances
Date: Thu,  3 Oct 2024 23:38:49 +0000
Message-Id: <20241003233850.199495-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003233850.199495-1-jdamato@fastly.com>
References: <20241003233850.199495-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances via netdev-genl API so that users can query
this information with netlink.

Compare the output of /proc/interrupts (noting that IRQ 144 is the
"other" IRQ which does not appear to have a NAPI instance):

$ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
 144
 145
 146
 147
 148

The output from netlink shows the mapping of NAPI IDs to IRQs (again
noting that 144 is absent as it is the "other" IRQ):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'

[{'id': 8196, 'ifindex': 2, 'irq': 148},
 {'id': 8195, 'ifindex': 2, 'irq': 147},
 {'id': 8194, 'ifindex': 2, 'irq': 146},
 {'id': 8193, 'ifindex': 2, 'irq': 145}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index eac0f966e0e4..e757ba53f165 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -593,6 +593,7 @@ struct igc_q_vector {
 
 	struct rcu_head rcu;    /* to avoid race with update stats on free */
 	char name[IFNAMSIZ + 9];
+	int irq;
 
 	/* for dynamic allocation of rings associated with this q_vector */
 	struct igc_ring ring[] ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6e70bca15db1..7964bbedb16c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5576,6 +5576,9 @@ static int igc_request_msix(struct igc_adapter *adapter)
 				  q_vector);
 		if (err)
 			goto err_free;
+
+		netif_napi_set_irq(&q_vector->napi,
+				   adapter->msix_entries[vector].vector);
 	}
 
 	igc_configure_msix(adapter);
-- 
2.25.1


