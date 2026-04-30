Return-Path: <netdev+bounces-282604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPTJH6vA8mnktwEAu9opvQ
	(envelope-from <netdev+bounces-282604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:38:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D749C682
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC248301ECE3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B02BE656;
	Thu, 30 Apr 2026 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKWRDhVb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A862853F3
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516592; cv=none; b=f4R1yBawzkSSA8XYzK8FDqk47XXjwupRYAoay1HSVFPJ5RkBP9fAG1E2DEOSJ1LWBahyN34lQ6z2RUx6KZIBLVaMmxkY3N2W+qSCAV57o2FGcWJx+puYzNoLW3Ox4lpcpZvD9T2DJF38vdCDsMWEnyDUbAs8FUpQ3E57ARcMDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516592; c=relaxed/simple;
	bh=z3UFk9DXs9/npEsMInOp5FxYmpvj18QiiM9uzHepGmw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rlL0becFwqAxmcFcQlRg0NeQEmIu34sToKrYx5wPZJvqT25SpAvqrw9vZzgPxyydzBNOgd/2no3FcT7+itAql94SO3VDue6S9hxo7VCeZkB33+vErARxat20i+VL+XaYVSh0cBCKmlhJYbFrxs29m5DL5WXR++6nYyw9MBWo9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKWRDhVb; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8aca4660827so13448846d6.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777516590; x=1778121390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oCWVLnOfJ6oLkzlLj6HLhBZ5ZOfcOhnTya7EkvSjzy0=;
        b=LKWRDhVbE+pfXtACPIuJUnGSon35Wc44N1R/HngY5g/ZkiwsgCJ95JtQcqyDDuJna/
         LpHkabu78KuKGTWNTlRe4src603cMBmygxJIWUUV86Zr2hujIDdY4Rt9HVl7Uy/FaF22
         /9EM0DVFac8ztuPz6Aj3teffQlrKV7l50H/YY79/IMqiPz24YxElDpcuzXcCJjaQZs3G
         JxSZ24RjqneVL6UyOggJHbcQAlNZ5RhJli10i+/HZYfHiHZ3kvjc5tztz9UOsNPjUG5Y
         Y6eSpzGIHLYOt/gruX2Q38nyMdOYzfUOlk6lAimpBt96IQqgX0WudEvI2pWEeVJ03kg7
         1/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777516590; x=1778121390;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCWVLnOfJ6oLkzlLj6HLhBZ5ZOfcOhnTya7EkvSjzy0=;
        b=gX750dZ4uozfojZKjziK7hj39fZAHhfBBPCQnprJjZI5reerpzIrR1tfDt3qpLFBx2
         25mtgtfcuYXVKa+U153sv/5BGTfiCGxXrg2ylkAG3pPs0z3S1FBr95jYKLR9uuoKussR
         4bTAof8kQHN2ZEhi1fMCJtPIY4vJxxadZNm3qOzjgCKHuygZ1bAwLMuBcWyDAh8s4nup
         hQkh4ezJhdmvlh4ZTM6JhufKYu7MQayNxVJ00UDKr1skK7MOzbg3dCXtifj+B5QagBpg
         gbJJjKUxMlrKOJwWa8UMr/ItLq1uMlusXcZS1Yhi+EiBSCg1AXlSyX+I2dFrwkMGJgiy
         FCZw==
X-Forwarded-Encrypted: i=1; AFNElJ/i2mjiTFGVtJPEPo1zZCWtn/iRWNo+eGBy9O8YWqrFAHBnnBRSVMJgAAxtRk5lpJOv5JbAQ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVJ6yglNmdrAuMegrsE+a2C1F1Pkw5ZZg8ebzd4KsyTiv9Yaa
	dbxWdpcsUvR9ggGcgNgWiX5YSRM2MqF1H4/R81hjMALiNWsNIryLJgzbFWDEie7CmpB9Av6G2DJ
	5CbTJtUufQcJR2Q==
X-Received: from qvab10.prod.google.com ([2002:a05:6214:610a:b0:8ae:5fcc:a3ef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3d9e:b0:89c:e7d5:4b20 with SMTP id 6a1803df08f44-8b3fe765fddmr17789536d6.15.1777516589895;
 Wed, 29 Apr 2026 19:36:29 -0700 (PDT)
Date: Thu, 30 Apr 2026 02:36:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430023628.3216283-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/4] net/sched: tc_dump_qdisc() optimizations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E73D749C682
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282604-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Before converting tc_dump_qdisc() to RCU, we make the following changes:

- Use for_each_netdev_dump() instead of for_each_netdev()

- Only dump qdiscs of a single device at user space request.

v2 and v3: addressed Jakub feedback (thanks!)

Eric Dumazet (4):
  net/sched: propagate tc_fill_tclass() error
  net/sched: tc_dump_qdisc_root() refactor
  net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
  net/sched: speedup tc_dump_qdisc() when tcm_ifindex is provided

 net/sched/sch_api.c | 127 +++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 60 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


