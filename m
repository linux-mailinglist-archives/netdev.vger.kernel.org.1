Return-Path: <netdev+bounces-138027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A3D9AB90F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD984B23617
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E008D1CDFCF;
	Tue, 22 Oct 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QUA5rFtU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8591CCEF8
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633983; cv=none; b=II3M1xj4kXcepOOK0hVgDtGvjbpmOw9mHbsFjlZfKNgnUd3Rvev9hnVjkbgEdMl/WniiXSUhOfaVMedX67J7PZ/k2IPVEidIeDIMBfZisl6XUjaw7YoIoddPFni/+XkrIlQABomXO5/bAyNfqyjW3tayFjeHn27ZuVnQw40pzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633983; c=relaxed/simple;
	bh=g4AGHfFsmNBHhh+32vEdnyiyGH20LdrZ8q9xYLKZ3/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nD7WYuBa4DF68eBi2gm3MeCiCfHxTe8RjVNJj7CT1PY+Gyzwr+8d37gQb+9pWstgllrdVOP+EKPNFIFfTaZ/mQexfqh1oj6Xn+k0KfJA5jK+q8jU6kqqxLoxMYxmqPVYN/lYU8MEQ7PPFaXkf+Rmt6T4C1oFw7Eu6F4Y3YcaYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QUA5rFtU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e585ef0b3so4648609b3a.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729633981; x=1730238781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWinoD1wO6ePUpgD5DMyiNj/aEcCeyyglRhhpFipWcw=;
        b=QUA5rFtUeK/46sX+7mAIID4pAtWY+t5roORQBtPSJ/FKv+1TcU2jJ/Ql6YobNcamFJ
         mncum8SewPR/k6F9YMsoNVkhlgViVlknop0m2qp2lRi+PWndhnQzHUCS3jShegLxi2EM
         71+shaECltD87Mjrd1OFrDbY+wyxka5yeo90w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729633981; x=1730238781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWinoD1wO6ePUpgD5DMyiNj/aEcCeyyglRhhpFipWcw=;
        b=ZrIoCoeW3bOfadEBt7HSzgscX2CAQiiDBsO/7a4ef+jkFQM1qhzmE8q7exOwZ84TrI
         GipuOflN298SaAl7tOsWcWoA1jLVfspYyH5jFN+P5kYyiTSBOtQ0BFQzH1ewP67fnX++
         kLGWJ4oo96vXokp73jFqocA2GtwHHvyXsKOr4s/2dVIY4UEvqglV/daB5W0ys4hQ+7Xq
         gZwJjIvlG/Vo951PIycBt80jJiP0WgdiKdRdaMBEI6sAp/6G+mq7/YmzEwlDhN2uYPP6
         agut/B7zDZ38eLRppIikmI9sOhnDnQz1CEHX38I/xmm2pCt8YzlfrOcG16vGib0yWBsc
         JzMg==
X-Gm-Message-State: AOJu0Yx9fs+t/YFRD+99ZQpJnkI60FND6Pda5fgrffHUthMgAuof1Xkh
	sOGihC2aNfxh7GSKRMkO0LDSPtEr0MQHoknUneJw4JJ4c3/7C1QhM5t3xE+XHzMHgjU8B9Jr6is
	oy37CNstrinC1BLf74DaOBhpeYDwZxIIpm5Amhcfsq4Adv8jGW2FImg3eHxDitw/OCnw6MNezuu
	lftEv1S3PSja68v8lo+vR7CbHOsBZeV0z22hs=
X-Google-Smtp-Source: AGHT+IEBGKBqCfafdvHpjRzZnehZKZkddBy+EkierZd4IZWl7C0GOGagj0Q5numluvTKArbqw3mVhw==
X-Received: by 2002:a05:6a00:2e1c:b0:71e:634e:fe0d with SMTP id d2e1a72fcca58-72030a8ae4bmr1005608b3a.12.1729633980674;
        Tue, 22 Oct 2024 14:53:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d75b9sm5194375b3a.131.2024.10.22.14.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:53:00 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com,
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
Subject: [iwl-next v4 1/2] igc: Link IRQs to NAPI instances
Date: Tue, 22 Oct 2024 21:52:44 +0000
Message-Id: <20241022215246.307821-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022215246.307821-1-jdamato@fastly.com>
References: <20241022215246.307821-1-jdamato@fastly.com>
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
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
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


