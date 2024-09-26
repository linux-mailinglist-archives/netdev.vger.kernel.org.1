Return-Path: <netdev+bounces-129878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87532986B2A
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 05:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84EA1C2165F
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 03:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731D17C990;
	Thu, 26 Sep 2024 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="aXpwI+Pe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AAF17838D
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319646; cv=none; b=dQnhIydjKXS5V895DJ8G71yGpUIQFsD6sLcJPu9/SKynTMJpOTUPut/J0sYvdLW03BKbTzGGGYd2uexn01EmMiiPLiWrMBkeiaxaF80TNrk5aoxXgfkA1HBWqiiBoZl6TasJOKao6Z4KL2znkoK0HOzyU52ZMy0mA2G/Y9Nl/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319646; c=relaxed/simple;
	bh=ke7VjoLC8SeGZeHWg/3wGeF+yuAtJBY3g55jc8f75O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nf5btwvbxonek+b7kXKQfhhGyAkeKJhfs4993AM1HcIVeelBFp7Hfc/McJY74zNMET4V8dP/MJcsqqQ1uLLkRRR6QB380jxEsty7w7n4jrO1rQV0sUJtL1jqR57LDpRM1yEvq/F1Mle77N6j3DHnHU7hkecgnZdPp8bBqKvoOIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=aXpwI+Pe; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so487104b3a.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727319644; x=1727924444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFH9E5BI155gM3Rr+uFGb1WMCMDmhX6ED0N/YxAEGrI=;
        b=aXpwI+PeHK6HwQNrXsPrSi6WwskDe5cv6wIz1KcTTSF9EguQGpEL8TDJEHCsNHwWGL
         QycdSoy52w8rIemIFIxzVPcichyF1DY8Cw2QCsZfmSCjJw8gXHBeIVc7XE8YNUpcDqXa
         3V3Gq9FgKBjiq0cyAMFykFpIboeLT80GUJIJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727319644; x=1727924444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFH9E5BI155gM3Rr+uFGb1WMCMDmhX6ED0N/YxAEGrI=;
        b=pyflrf7/ZZfs5pOErEGDdsKr/DIdkH4+cFySS3AGCPk1LxCeoAWjzf2OhHZ7ymNHIO
         tSPQo8vee5AYmvd6PjfO2VpflT0uIIRX46CicnKV7EQMS4D4AWBSKMXIUWogDWj/7scq
         Q8Bqod3OmtZY2rd5rwZcf96WELXCreMw7kO1Em+dAhOL40wMP+VPY/oUHu8KHeW/XlbF
         ndsILXTUWL3tqjTPneeLz0QXy+xdtKCl4Zy15xmnl9JMoqzQkWr53yoco00LfIbdGERR
         Crn0oRcf6MmXX6ebNkz7vPxP/hWC/Oit9JYdqk4mbbFiAyTVO/ZZz6+pdu24GNfPYr5j
         NP1w==
X-Gm-Message-State: AOJu0YzcjtYv7KIgg8NNYH5uoKk5rOaK0P2iof5mf27x28PDXqRgdPYK
	4yEiDx27FkxEinLuDHipJ3jb44aDtiXCX8+t60gOhc26JYvazkBDI2rdyLC8qilEeS23yitg7AE
	k+aIDtZs/jFgXsOy96HCaAwUKUyykWEIXNFqBX2tMCcfZluybReL3jiE0oVvHnHkNUzmsxiCSrZ
	gdTAX2k52+9PMKPj4MifSfKE4g9OfK0UWzRLU=
X-Google-Smtp-Source: AGHT+IFwXhiKp92OtV3zKXtfySxHUFQ6ffBh3po82IyoEmF7fZbfZbFLz2IsWR+8MIdi2e/0d9XDBw==
X-Received: by 2002:a05:6a20:e18a:b0:1cf:55e:f893 with SMTP id adf61e73a8af0-1d4d4b8609cmr6114351637.36.1727319644364;
        Wed, 25 Sep 2024 20:00:44 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97c2a8sm3354111b3a.163.2024.09.25.20.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 20:00:44 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 1/2] gve: Map IRQs to NAPI instances
Date: Thu, 26 Sep 2024 03:00:21 +0000
Message-Id: <20240926030025.226221-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926030025.226221-1-jdamato@fastly.com>
References: <20240926030025.226221-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netdev-genl interface to map IRQs to NAPI instances so that this
information is accesible by user apps via netlink.

$ cat /proc/interrupts | grep gve | grep -v mgmnt | cut -f1 --delimiter=':'
 34
 35
 36
 37
 38
 39
 40
[...]
 65

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'
[{'id': 8288, 'ifindex': 2, 'irq': 65},
  [...]
 {'id': 8263, 'ifindex': 2, 'irq': 40},
 {'id': 8262, 'ifindex': 2, 'irq': 39},
 {'id': 8261, 'ifindex': 2, 'irq': 38},
 {'id': 8260, 'ifindex': 2, 'irq': 37},
 {'id': 8259, 'ifindex': 2, 'irq': 36},
 {'id': 8258, 'ifindex': 2, 'irq': 35},
 {'id': 8257, 'ifindex': 2, 'irq': 34}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/google/gve/gve_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 2349750075a5..30fef100257e 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -111,6 +111,7 @@ void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_add(priv->dev, &block->napi, gve_poll);
+	netif_napi_set_irq(&block->napi, block->irq);
 }
 
 void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
-- 
2.43.0


