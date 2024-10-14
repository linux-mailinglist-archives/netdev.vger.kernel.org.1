Return-Path: <netdev+bounces-135345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D350299D907
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF611F229F4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 21:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C11CC173;
	Mon, 14 Oct 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cN4FCwOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558C1D14F3
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941429; cv=none; b=C5Z/ZArzlOkUWR66M6CjmI9IGDFTV3RsQzWHOCVDH0uCiONEqZYXxeAVBhPfZYzpUhsVma02uWJr/m1eASZQf7f27LjLt99t1VMdnN/xnPQQtLL26h+osQxPKRbSXCNWAkvozpvcC9WAnUAt8VtfJSMg4G6CmVMAdiRLO0AurNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941429; c=relaxed/simple;
	bh=NhnBUa+NT66GgLQKR6RS2ipTJVC0oGB5wNWsZRt72/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jm5+57RWjhGYN1bX/G+qo/5B7K1HP4ffafVs242OJwdLvIRe4GqEnh2VR82GdnGUpP9bJDR8nANgZN6l3eiSiy+9jcxNcyc0RwHwCfRVy6vZk4aNqSjh6OK14UbF6svxjh7bireRFjEQWb9c0VHVcR6rpWEXDMI6fE4LmQpsdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cN4FCwOT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c9978a221so40396925ad.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728941426; x=1729546226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRZU25b73L4NPLcELjGuUGCIZi289xNDkjLoT7pzYSU=;
        b=cN4FCwOT8pCVILtkEs2vo6yXioEmZX3VtAXgIq2s6bMqGY8cwO3dVza2Qu593IIxyg
         uiWCx5RzKu1K9QOh2oISSFBaGgLyhDqYkFZ2cocWjKuldYTHAszVSIY3HMsPBibGW4Uq
         WxMIPfxF+viPORe9Vv9cw7LgaXlL2pAzBzg0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941426; x=1729546226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRZU25b73L4NPLcELjGuUGCIZi289xNDkjLoT7pzYSU=;
        b=fninWS8/twdYV7LLbONLQkc6SNMMaa9MI6ucRJ7vKOoTNdCIpg7qgIFy6LxVvCWeoN
         ChWwCTpGoTM9WO2Q7ylLXA5DHdYhoIElFLxRDuHGvYTikYUK1Otot6IXsobpfNShf30T
         xO1gNafbDwGLY5LMrNIZ9ib1Z2Z3TB4fvHaDyVt+6bi5iwlMicufJmSIdF55u1aAtN8E
         Piw33acpewYq9rsADRcXtyft2U94fEdWeqKFAzLFs0/Hpw8UJaEy4jREXZAIROqMxKHn
         dBYoT8NR41WF18UTn5gfHPeUa6Qwt0T8pjegXvif/dWepcp/2ZsDpR1KZc0T5b+TrLnV
         ZX0Q==
X-Gm-Message-State: AOJu0YyDdhJnYOk90R/Ppqt1u0B/uZwUOwHqGNFCWp/N5SFKjjHX9U7b
	BS1wwr3y6qeH52DRdo1c5ZMQ0XrKjLnJsuu+celTkumiImQ6fe5ozRVZTnbm0qASI3NNIQgjSfU
	y4fSi3n0gMDRDmDt96vYZ3F7DxMmcTZi6VkDlZERFvxEOoc2hbvrAubHqOPgId4aUKrTFlhYk+6
	0nP0fm4v9Fc+i83JWdam/X5AuNU7zPTuqXLGQ=
X-Google-Smtp-Source: AGHT+IEcjB4DnlZM/vxxY6J3w4JYYT/cEkUQKkJgbyxt1yDIhY/TZ2l4L6WNfes5WipW0v5x1pURKA==
X-Received: by 2002:a17:903:2b10:b0:20c:a175:1943 with SMTP id d9443c01a7336-20ca1751956mr191319995ad.40.1728941426605;
        Mon, 14 Oct 2024 14:30:26 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1a54esm70197495ad.73.2024.10.14.14.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:30:26 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 1/2] igc: Link IRQs to NAPI instances
Date: Mon, 14 Oct 2024 21:30:10 +0000
Message-Id: <20241014213012.187976-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241014213012.187976-1-jdamato@fastly.com>
References: <20241014213012.187976-1-jdamato@fastly.com>
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


