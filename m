Return-Path: <netdev+bounces-139630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B365E9B3AD6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A8EB21E70
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C81DFE0F;
	Mon, 28 Oct 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c0br2KGz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4AC190049
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145181; cv=none; b=Z8YgHKQCKtXTZOp6Xr3MzO3zkL5dYz/gjZhEKAoXTDD6rrsi8aGCBlwvOUvD9M1eISaNZ0U2wu35S0nJ7Y2EI/0OeACgw289mEF4oUsk6Xv/MCDZX9R+iPuU7Ok+/2l/eqAFs8eqwUDGirxJM3+7uDC7NC5DhFtmhHLbQGgSk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145181; c=relaxed/simple;
	bh=TkyMtBwnExphazd2Rw0O4yKWDDIIf2oIvYArO20I2nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jva4Tl0QHAT9PRa0a+ihidXa4aLViU0kl02IKuA6tJhECSqW8ldq92NEKHYqo7rnRWmnrQnOKN5X6uDZ4qApH8NwZFgQLGoOcY30oCiEMt8gCEjJIULdAjvSHqkmiIhzlSmnq9Nnf1OtsauK83nBBEtK0b35NmLzHRaf0lWYf04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c0br2KGz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso3378500a91.0
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730145178; x=1730749978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzv4tUYcTG10nCYawdfXAqsh2XlyQDuHmZvQ4r/SQEI=;
        b=c0br2KGzV+GSlSlXKikB4L1E15l+/zJOii9DQ4y5+SQgT2Hm72pliSOi7T6IbOppa6
         bTLsjQbulO1H+Kds4XpIPi3E3SMHshgpju6q6UFOIxUfoEi08+n727XDdt0IfnuVyyI8
         8TsqtRkSlKb+n/X5/7BZXEJ65h/eyCNyjtjYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145178; x=1730749978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzv4tUYcTG10nCYawdfXAqsh2XlyQDuHmZvQ4r/SQEI=;
        b=eyPj1HV/4cqGg+3mJZbICIoos8WBT7O03Jsn1W2jmpXVXzNXfFBevEeNT96wPpjUso
         HFhTJ34iEP99sORMs7fyMMPOvuEKk8RzBgaREqqZpbcG6Iuqt1edapXYj/VkuL5poF34
         P67NOz8A8Ejy9KQfxqL2oYLCkCN7LuPTjsdHTdTseJXddfT9kH0prTp+rvGlcdrHFMA3
         gfnVxoJhcmhbQECF1jlurRhj4rWEPIz7rC9H3j/ZbJW9hndSBvRRtyF2TDG8X7H8HNHO
         XBAsxspTNDeA9fdS6kd1c4ROi5HbjdXa0r/RaZAFgyh+BDBgCvmtRYGxsF1HyUXn1usU
         k8/g==
X-Gm-Message-State: AOJu0Yz9M3S4h565VvQUgsCHg5ZbJDzGKoOR6l1VcM82h7v4XGkMzdFp
	CyLyQAy95Hvs56hc4Jz1hqxwPf++p4gq5Kdl2RY9vICJ0Q6SE40Pl75XBdouggIh3UPz99lRur5
	CqjSyE5RyAI/JBLI6ijL4HlJ8OLTwv4UEd2O3z0Slr7IeH4Lyfs3QJWzogz/MUuc2nMfYA7jkcl
	FKQWstWwQG4wM7YUMdaMdSV0N896mzE3TQJCk=
X-Google-Smtp-Source: AGHT+IF3b8V4O/+wSZXl5oSD4rRWeHrmI8p3REOwFvhYeIEQrlFb40BEPTWGzSfzMi4dJRV69l6Qyg==
X-Received: by 2002:a17:90b:1202:b0:2e2:d1c9:95c with SMTP id 98e67ed59e1d1-2e8f105f207mr11133265a91.16.1730145178235;
        Mon, 28 Oct 2024 12:52:58 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771e64sm7695247a91.50.2024.10.28.12.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:52:57 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: vitaly.lifshits@intel.com,
	jacob.e.keller@intel.com,
	kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-next v5 1/2] igc: Link IRQs to NAPI instances
Date: Mon, 28 Oct 2024 19:52:41 +0000
Message-Id: <20241028195243.52488-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241028195243.52488-1-jdamato@fastly.com>
References: <20241028195243.52488-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances via netdev-genl API so that users can query
this information with netlink.

Compare the output of /proc/interrupts (noting that IRQ 128 is the
"other" IRQ which does not appear to have a NAPI instance):

$ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
 128
 129
 130
 131
 132

The output from netlink shows the mapping of NAPI IDs to IRQs (again
noting that 128 is absent as it is the "other" IRQ):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'

[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8196,
  'ifindex': 2,
  'irq': 132},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8195,
  'ifindex': 2,
  'irq': 131},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8194,
  'ifindex': 2,
  'irq': 130},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8193,
  'ifindex': 2,
  'irq': 129}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v4:
   - Fix typo in commit message (replacing 144 with 128)

 v2:
   - Line wrap at 80 characters

 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

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


