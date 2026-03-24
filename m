Return-Path: <netdev+bounces-270944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFnWAs9WwmmGbwQAu9opvQ
	(envelope-from <netdev+bounces-270944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:18:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9B305738
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D213F3001458
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134693D4112;
	Tue, 24 Mar 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="SY+OxM6q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f103.google.com (mail-wr1-f103.google.com [209.85.221.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE653D811B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343703; cv=none; b=UD3dvRHI0oEvj0SeG31qD6BCN8nPRzJEDJPaPqU2d1F8/ESrQF18ofVy4nXhaRRsdySGGgW3rEW1Mn2KNjnH9NEbtn4WtUh6YrKLMBHKZxQK+Rp0xoU3F2/LOQXSr2cwDumTGYlZBJ9jpdff/AoZHxE3XiOdR7mgzRtyheGv8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343703; c=relaxed/simple;
	bh=U4WY8G7sSooM73JR+LFTlTiiRRvYYNEl4edmpbbXse8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c0RkkyOM5j4aV7bekwWytjvYTds7+otId7YXRxkIg5bEVpH0+ZtsZnFNovptOWQYzjQZC4Mlqh+wJ8eOwucWDtIypambll1DytDVQwrlq0lPsM5OKyqiRqkyYW3CevENPisWPovcCMEnsHTvrFkocZjhQ0r1c+Vcl/tAqa/azhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=SY+OxM6q; arc=none smtp.client-ip=209.85.221.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f103.google.com with SMTP id ffacd0b85a97d-439c56e822eso961852f8f.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774343695; x=1774948495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3EYzMqwvHsuEDAWnSD79zk7SSd5ERXWnW/i7fwIB60=;
        b=SY+OxM6qF5yDN+pvNd/TSK5v9V19+pTTDBLQfXlZgTzj63WGtBTjf1I2bqTjTl5dJh
         qvzKVj2qEetqvWS4vE0/o3lWJaYLZayhrOHGvGupBRPlOIw6cpZwwpTO9mZz/LbI9zAu
         3zwszXE9lwKhnzn3dGuO9WyKO9bV07+liTh8ssY87sMxH5b6wc6IoR/4aVsqKGTqA5oq
         tqjr2GJ1uj6Chi3pwBL4cobgtOik0tT5b5GfE8Li5W5hd+3bJiIv5RCphWGymKrTJP/T
         ojMMFMzN2ajF4Ei/06yAtHL/5GbtGzhcHoS+4tLHLPsuX5KxgcAv35v1xXzeOUWQekxG
         m2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774343695; x=1774948495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3EYzMqwvHsuEDAWnSD79zk7SSd5ERXWnW/i7fwIB60=;
        b=MuT7yJTuDso6lqY8d0q1A+c8R3+8hAIghAFLJzXDumW9hQRwfitIDdc2gOT7rJJ8wn
         IW+rgdKBPnExYoU0j/ksBeGGH1PIjP8ewMfh2bBWX9xsFjkM9Lka5kvVNv94TPWtI//r
         LWAJ1cLASxRYPotZKOCQGfPcmxJ8j1dZgFEdq2Y5x2CWKe7ZWH5m16GHqXyvUgaPmk6E
         eBRLNU/pmsjGAXFJHTbI+YRapCS4+291Whe7vBUcIytfCU98DqImreUfhJX6AJeoLo2k
         pUYFMmTpGYM2fcyiX6J3cgleo81UZmYzEUFqcw/Ng9qGWLoQjTEI9SOTYdyIL7wR6gRQ
         oLVQ==
X-Gm-Message-State: AOJu0YxOeNZ2bSgi4f7eFgRFTfVsaAQeb52s1t8sO8nP/caFRglYiWGe
	PAfWOULGSlQh6fpRdIQZJNju3kIOLe7v+g6lakVIcTbYhXQeWzK2Co/ZmMFg9kHJBgW5AvzN054
	lEHw0LT3CPmknkwT8Wby6NjR3S6n3yiIT/OTG
X-Gm-Gg: ATEYQzw4UdhIvsljiAj0cEmBppEkOG8OEESZ+P+XVlfvjdaIvLmR8N5gSgmWO2+rvJG
	C1bdmpojt7yT+YF95rcEW99nVr2eFj2QlPWRYcurtVnjHVrfD7hdTx/FcGtX9xh1cgFCy2Izh0w
	kxHww+DPFhSaEYTOVAgVzohRTkY2kiMlDjnAprFQU9SifBPuGI/w64xtl4xThrxH4Op9dX1e/DF
	m3HpjFZuU4Jq/jhVMsYQjfN3mot5TnXrUR6wnw5Y8DFi1M83H9OdR3qaXPweAqkOPwTzW/fWSvE
	XUApTx8W9GTgPTO+ui6v9KYYOasTD3BvoaNNKT8zb08BsHUuv8/GMLKnjqJB+Vdi2ASXDeKi3C4
	I8gKgSeg22BE/zajthFHvEzAb3M4Xzn9oxqiD4BGyT3Py42peMbhE15fd+NC1yaiH3W1VCDjqIw
	==
X-Received: by 2002:a05:600c:3546:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-486fee28918mr209425725e9.26.1774343695208;
        Tue, 24 Mar 2026 02:14:55 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-487110467cesm361935e9.0.2026.03.24.02.14.54;
        Tue, 24 Mar 2026 02:14:55 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id C46031E27E;
	Tue, 24 Mar 2026 10:14:54 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH net-next v5 0/2] Add support for per-route seg6 tunsrc
Date: Tue, 24 Mar 2026 10:14:32 +0100
Message-Id: <20260324091434.359341-1-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270944-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8FC9B305738
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for the new per-route seg6 "tunsrc" parameter.
Selftests are extended to make sure it works as expected.

Example with the iproute2-next companion patch:

ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
    segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0


Justin Iurman (2):
  seg6: add per-route tunnel source address
  selftests: add check for seg6 tunsrc

 include/uapi/linux/seg6_iptunnel.h            |   1 +
 net/ipv6/seg6_iptunnel.c                      | 114 +++++++++++++-----
 .../net/srv6_hencap_red_l3vpn_test.sh         | 109 +++++++++++++++--
 3 files changed, 180 insertions(+), 44 deletions(-)

---
v5: tunsrc support detection for non-backward compatible kernels, fix two nits

v4:
https://lore.kernel.org/netdev/20260320135909.1729313-1-justin.iurman@6wind.com/

v3:
https://lore.kernel.org/netdev/20260316162955.1253225-1-justin.iurman@6wind.com/

v2:
https://lore.kernel.org/netdev/20260311152845.278354-1-justin.iurman@6wind.com/

v1:
https://lore.kernel.org/netdev/20260310141057.3353333-1-justin.iurman@6wind.com/

-- 
2.39.2


