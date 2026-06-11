Return-Path: <netdev+bounces-297870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lYdBI14AKmq8gwMAu9opvQ
	(envelope-from <netdev+bounces-297870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:25:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF07866D7F6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:25:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=v22s4GuM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297870-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297870-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1165E30C430B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F0175A72;
	Thu, 11 Jun 2026 00:24:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C71BC2A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:24:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137499; cv=none; b=n82bZB0cAuAgcSk33tqxISoeLACN/v8atBogLBB2zGa/5WIjn6EQNdg5iX8Xox85nWFCpubYAIKkFcWzRq1Cj05YRzo5d+WLbuh6WGfRPDuCi+bHoEMM4ZTEJqG+L2TNcrI+XBELdIO+0FyepuGlkq6pMQ3FMdCAyxC/y1FWF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137499; c=relaxed/simple;
	bh=xBE549hUxlfDUzO3UdRl+STPrbuxhOZnaaDsCdSdW3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ls3Vdiop/0ff1/jWlOSgbBbwoGVThJyrT6fjsebvq/b//JHpJh9lgytefexfJnZk/FaA43CHAo2wj44xmkZix67Th7s0jJZqxrVBym/l5u8UVDEhXdn6D41or+2rNPJGMgeKbBQiJkZBdmAKk7M998sMh0EqAQnBUAB5e3uTFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v22s4GuM; arc=none smtp.client-ip=74.125.82.73
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1383678095cso4917165c88.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781137497; x=1781742297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D/mNN+ZL+7iwwZTVcSxzEBAbL/ejYUDxYrg2Yjp4l8w=;
        b=v22s4GuMHx7ewQN+DmpdrCx322JkF1v3bVQNAIUaGOoMoq969lYgq0XCWefMlagRtz
         rKMOPOeKuaTckb88RvCaRJcPYxgtwQ3QNlBK3NcGpHln1nc3dVyLpN7yluMyoq9SAXyL
         STZWvQ7p4Zjaq11kl1we2YgGe/6Z85WCl7se62o2pkGtr9GigxOcXl22Rqh4EiPFIlDC
         mVyV4hro3wUT6ZJ95gSpf/SWDKms2xT/XTvHC6C0vze1sxbDlWAzKLuwPZ67gGNIjDEl
         3YqFc/f+enotmB27hkLtxOO2CxGj/puW0vITYAXLc//efmxL9qiRv3KeNCGkCUinvUuk
         SI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781137497; x=1781742297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/mNN+ZL+7iwwZTVcSxzEBAbL/ejYUDxYrg2Yjp4l8w=;
        b=ePe5xAy0ZBHvSiGBq3xQ2FxkorFgbkarrbcoznpgDmmmYO1iQ4GNZPJ7LNOWQSgeQo
         2L3jS17OT93MvMztHcRX7rsjhYsJz/8HJBCUxO7tqoGpQpUYgd1MzRlp4yLZ7flFpPyH
         /HjmqMTgjzecZARBKJeVf7uRxogcOh3bBoH66xMPNQ6619Km6zpPAbMtNqOSDSZIceuy
         8PZGPxIzFONHx6hYYnG1pXcowRCq4m6KxHud5vPaxLZXRzEDfrp/sHLxPOtFWGU+UuDg
         AUZbtdyioTat+C21P1bIzxxTHifBuInL1Ox1ta5JEgWR4TzN/KJQvhSBqBw1CU3eL+Mv
         mMaw==
X-Gm-Message-State: AOJu0YxiTa4/cknK3njqLqRGa/p6aoJfSwdZxSaP5iRW0xU/umeE+rPx
	r1ST+9LbG97CSG1M6pvEgbB7vS5NTN+WoXk+uXaaP8ISwj0HPVmhhUmncYASqG04ZS0mt+V5Kkj
	Vbweh2/+qS5ImjQ==
X-Received: from dlbvv8.prod.google.com ([2002:a05:7022:5f08:b0:138:9f7:2b4a])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:50c:b0:137:ef8d:a58 with SMTP id a92af1059eb24-13842119f60mr288616c88.3.1781137497042;
 Wed, 10 Jun 2026 17:24:57 -0700 (PDT)
Date: Thu, 11 Jun 2026 00:24:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260611002437.1671401-1-digonzal@google.com>
Subject: [PATCH iwl-net] idpf: decrease statistics refresh interval
From: Danny Gonzalez <digonzal@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com, stable@vger.kernel.org, 
	Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:decot@google.com,m:anjali.singhai@intel.com,m:sridhar.samudrala@intel.com,m:brianvv@google.com,m:boolli@google.com,m:emil.s.tantilov@intel.com,m:stable@vger.kernel.org,m:digonzal@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[digonzal@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297870-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[digonzal@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,uso.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF07866D7F6

The default 10s statistics refresh interval is too slow for real-time
monitoring and causes network selftests (e.g., uso.py) to fail when
verifying traffic immediately after transmission.

A 10s delay also causes aliasing in telemetry tools polling at shorter
intervals (e.g., 5s), leading to inaccurate rate calculations on
high-throughput NICs.

Decrease the refresh interval to 250ms to ensure fresh stats and fix
test failures.

Tested: drivers/net/hw:uso.py now passes
Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
Signed-off-by: Danny Gonzalez <digonzal@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..e2890d219431 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1364,7 +1364,7 @@ void idpf_statistics_task(struct work_struct *work)
 	}
 
 	queue_delayed_work(adapter->stats_wq, &adapter->stats_task,
-			   msecs_to_jiffies(10000));
+			   msecs_to_jiffies(250));
 }
 
 /**
-- 
2.54.0.1099.g489fc7bff1-goog


