Return-Path: <netdev+bounces-277936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMz1Bh0r3GnXNQkAu9opvQ
	(envelope-from <netdev+bounces-277936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 01:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395E3E666E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 01:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9E7230086C3
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF51E2C21C4;
	Sun, 12 Apr 2026 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnstzwoK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7B31195B
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776036581; cv=none; b=eIglq7ONl2jUJAvrH0RU6Sd1IKdIz4f4P5tipNq2jWRPva+jcrF1MGp1K2mxhmp/84o9te4yIG6aalF3THASFgmAOXIPnIADvGb5VhESnOGWD2FAIlHVvDEDcxWOfpSjL/+zhIhQ4My47k12otvtHAfjFeUa8+rzelKJjht7wXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776036581; c=relaxed/simple;
	bh=/Gmm+QJmMLpcfxoQA/vznjcwHHNtb3xnIo3t5EfYKqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMrWXLUd09UNT7h+/DFV/bkcBqsaYc6kTJjPZPDQ7EDl/G6jaS/QNLODg+fuFH74mqzJbAe1WBv7x447SacQuHAFqG2RlEvT38H4Y8FKdkqBj2+sEJBW603Kdqyn3PQIaA++qYB2LVn4cunX8at2NTlVTsu3YBLqn/LJxHPwe9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnstzwoK; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a7109f568so42224747b3.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776036579; x=1776641379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=avs6/SRQ7/UUlH54/dpdYzFVakPjFZI4AMLxPsHNsiE=;
        b=lnstzwoK4EuVa/xJQyt3wyYsn/bW9ScljDoRkS6IwtAXZq7ffq4PFtEz4Ad99q0cNQ
         8cq178MH6AUTa5H8dRWmRHAWPe8yPZu/gMXzrtnv0NX+6h8sP9DBPm+d/HJadcEQ7NyK
         6Lc5o2PUkF0hCd0yucbHb7dA/FeN4h7ZQMLSmuA9162l6MeXSJPxos5bsWTPIEUVwa4Z
         1ZPSEMIn9cnLjLoir4EA9gybxT89H+Rse6KUDryI+jscJClqRHsmLIjBjcfieOKtsePd
         PYhEDSwzs3ti81v9EtQFFp8IAAtIYoE+YrH4ZUmEIdvnffv2az6AnDv1nvQZn72N5NJV
         QqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776036579; x=1776641379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avs6/SRQ7/UUlH54/dpdYzFVakPjFZI4AMLxPsHNsiE=;
        b=E9PyDoR+kYdskGi0tHSLQE7f4yQhif6J4rURFidKmZax4iXsUvFwhZb89nbG2i4JHe
         eJPz7lDrPuaVKuVZfdFeNMt2lJ3cEKFlG/eue3p6ItQfxPfwqEwlXKhshq1D44KMkSy1
         QFeYMXbR68gk2rGl4WZOBn/TnEYO9ByMk1lxa4j8cZX2jKlEo3xWjiMTE6ZX8nwx/ewB
         JmEiGbcGNZZgao4YbnofqG6HQxUalkI/GjAZLinRcgVkbQWMuIC3PhwHdka7+EmQgT0Z
         SLkarV/cwjKcT5khGehaAMghEc1rj5ClCOw4BpVv3SscvnH/p9+fs0WdKtCyIkFQOSQE
         MUkA==
X-Gm-Message-State: AOJu0Yx+644TtALlmObQCNr8FHZJKKlQq6MRRTMm/oE//d6ZbA5x5a0o
	J3URvfZcMNfCBDkLGQ7HeHKylRfdTpVaLwaW6K/e34F3fcHc5EOG7LvXq+zl/TwU6OM=
X-Gm-Gg: AeBDiet75aQhBYa3X9vMlRXucSpk11ei13dsst01ZyKOnmHMkfYBoTgvrOABZHctH7o
	wYtmXiY2I+UPlF++GAYKqXJN0XDnN08hWe4BGNx2nOUJuc2k+irq958wVYTYxxeFv38MEjFcq0M
	hb1o2wmWH/NMqxXlTB5+KmeuYiW7yDTPDXk8LMQUbdgDT1kvVEDJevYgz3UgoPKcAPRo9pJrt/y
	+E0pjvgbK8GPOZ00syMm43iNJmGwEyzHrTXv7Cfa8Zrp+63Apt0fR6fddnNwDX8xIGS2VrUeC63
	iPBMAuY/laK/ErN4zdhslh2O1/l5Jm8KpETBYq1Wuw/3ezA35ZJc+pyzScLglMCOIafn6n0MOEl
	vTsb78BSKsYAIcRAVikXGDQVQ8tGWPs50JZGSQMEI2wMwMq9PC9g9fNtAdruGb0eaOhh8FV54Qu
	bC9wg=
X-Received: by 2002:a05:690c:dc3:b0:79a:dabf:cbcc with SMTP id 00721157ae682-7af71e4fb5dmr119302067b3.44.1776036578988;
        Sun, 12 Apr 2026 16:29:38 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:ba4::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af400ed949sm45337367b3.49.2026.04.12.16.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 16:29:37 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: netdev@vger.kernel.org
Cc: Matt Vollrath <tactii@gmail.com>,
	edumazet@google.com,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	nic_swsd@realtek.com
Subject: [PATCH net-next v3] r8169: Use napi_schedule_irqoff()
Date: Sun, 12 Apr 2026 19:29:14 -0400
Message-ID: <20260412232914.31463-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,kernel.org,lunn.ch,realtek.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277936-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tactii@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6395E3E666E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

napi_schedule() masks hard interrupts while doing its work, which is
redundant when called from an interrupt handler where hard interrupts
are already masked. Use napi_schedule_irqoff() instead to bypass this
redundant masking. This is an optimization.

This is a partial reversion of a previous fix:
Commit 2734a24e6e5d ("r8169: fix issue with forced threading in combination with shared interrupts")
was applied in 2020 to work around an issue with forced threading.
IRQ handlers were run without interrupts masked, and RX interrupts could
be missed in the race, causing delays.

This was fixed in 2021 by masking interrupts in forced thread context:
Commit 81e2073c175b ("genirq: Disable interrupts for force threaded handlers")

Compatibility with PREEMPT_RT also came in 2021:
Commit 8380c81d5c4f ("net: Treat __napi_schedule_irqoff() as __napi_schedule() on PREEMPT_RT")

Tested on a Lenovo RTL8168h/8111h.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..4c0ad0de3410 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4873,7 +4873,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
-	napi_schedule(&tp->napi);
+	napi_schedule_irqoff(&tp->napi);
 out:
 	rtl_ack_events(tp, status);
 
-- 
2.43.0

Changes:
v3:
* Describe the history of this schedule call
v2:
* CC the maintainers, make the CI board green


