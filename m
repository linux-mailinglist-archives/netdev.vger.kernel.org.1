Return-Path: <netdev+bounces-265121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIbzC/AErGkxjAEAu9opvQ
	(envelope-from <netdev+bounces-265121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:58:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1F922B3EC
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F87F3012BD8
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B329734B1AB;
	Sat,  7 Mar 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S19RtV/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294E33C19C
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881132; cv=none; b=Iv6L3H8gPftF2d+gmZLzJaHLHrigibzDd8ZZ8NoDONx0plRmJqwqYCkV0R+a0f2wldwgrhY34kKxkRvqulVn/Kw1651abcy76S1zBCECddj19WCkfzfttsl28RQXHa/mm355uvTwSI+JF6SsOsP/4TsZiZPo8+pyPixhrdZkDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881132; c=relaxed/simple;
	bh=gJU3t9Qn2NBIARn/PgaIfQQyjoZtt5mzQ74cZQSEMk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoMeVyz2Sv5bKGyi2oKCUGWdAAnHd4NJ/HYNRlcLap6A38S/OmlX2NUPxd/JB4ByEr6mAqmQMBoxAd20pXDYCjrElXciDrtSMPZumgVytCfsAAQ1+B8I7MaxPdpxpmcPzvugoEnlXfsktv///E4IeWibCiI0DmEQxsmq7Dlw1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S19RtV/8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb3bae8d3eso933922085a.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 02:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881130; x=1773485930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vum61NAHRNR11lhX8He1XuJfBT6qGxIimD8lYF/lOZ0=;
        b=S19RtV/8KbgKTixpjH2lAjg6t7aaxlIkdZbdHydnRnvi5lU8hnqI6rv94aNXMrtE9n
         kiswhJ/HwDVe1dMfgQOQ4uQdMMIvCEECLcxn7+dgXQQUlhogdo1ijTHIAI+AuhW692qg
         tguxyMOKc8tDf5Cdshk1l/xMK+oLMO4sNzvmgwkKsirOruI/nCNXgdTSyjmXkY5OT/AT
         W7KfF+pNbFfAH3wyybYBwMcZkGuphUGcw8scwQRdRi8GSTuTfgEkAb8YwoHcWin5aIKL
         pRQF+LKlCbvrobRBK82E9CZO4VozlMJyDAA8QYkAIz3tvqZRHG3PiNgZfLyo3RVQnCBa
         nW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881130; x=1773485930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vum61NAHRNR11lhX8He1XuJfBT6qGxIimD8lYF/lOZ0=;
        b=ICt7MEn8lbq5srkpg6JHNV4vcKge9VPCJkOdBfA08Y9FF6MDO546jUWHWG9lYgFp1u
         r23AmzPgJzFooOv2yilgWB2AVs/MXrPs/erv5zDRy5abEGJ3mVtDVhOsE0cQs9ENwWF8
         xQha1haYTrnJ7QeQoFfctFfxtfsYWMqUpJHZp9x5qZo+Udf7USksPN1QWuVdlbkCPTLN
         +mbTWpDLCJw1xBOMRsXzT9k3SPYcXD8fQZTpsWXLO679za9HJozx46/V2NVF3oajV8n2
         l5fOi++ZokgorfYUn+13K4ZJor7LqWrozhNJR7noI1AiAWuFcX3NAKqXzjEAbQRB/QmL
         eDJg==
X-Forwarded-Encrypted: i=1; AJvYcCUVJBV8NGlzTu5qXr/PjsBn9YWir2I4y0Dyk1aMKbn2bYXZRYmMcVfEt6GarQuB18vOvNe+cJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgdQeMQ5Ef3HhwPGEKDZ23vge4/HeJS6HwLXmQBdsTdSTjrkN
	vCau75AvXnqtRQnQUFbUHgY0938iPfCzDzoiv7MhrNBBHrzz4zAdXPIy
X-Gm-Gg: ATEYQzxWgSFI4VK3pQWlqKX2KM3qfFe9UkPx7x1zwFAw1TTyNFt8X/BBTyAXJ+z9xPD
	o0cn9f/aV+9k7EsLhzuL5EX3PPOgNRbuw0JyvJ0E0nJjyS26rGuF+DnXqTEjeaNQUCZ2bnvR3sF
	/SigvzjcfdjViLFBaMIzZ9IwIPSxac2FlzwRBxM42S74i0JQkr0nn/UtWXYdjhgt0PiIVtIXtVK
	7K0fb2NvdhpcOhJJWu5mnF9gBoI6Uxbm6fslPNDNe38Wga1Lom5LzThiQ+zFu3CKCSZGhqS2xrP
	9sHctZPLQSwwq4VRCSGb9/Z+YGEphCJBRh0bSqHswcMkj7eGaG8xWx1w5Gs8jhOWoK+R2jDNd/0
	vNXeuOZFmGijDuB+IsHBYo4jX45e84Ws9tjeLMBLglKfEIoysQ2Q+jfI4sW5ejnBcRmVhToiBpF
	xYF2LphNi1AkhELgPbtxHHNZpKjEORARLy1Yq/0MGNvupyCmldv+JFojrF
X-Received: by 2002:a05:620a:1085:b0:8cd:75d5:544b with SMTP id af79cd13be357-8cd75d55d48mr235483885a.58.1772881130231;
        Sat, 07 Mar 2026 02:58:50 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4a2fdasm293278485a.17.2026.03.07.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:58:48 -0800 (PST)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lee Trager <lee@trager.us>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/5] eth fbnic: Add fbnic self tests
Date: Sat,  7 Mar 2026 05:58:42 -0500
Message-ID: <20260307105847.1438-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD1F922B3EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265121-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This series adds self tests to test the registers, the
msix interrupts, the tlv, and the firmware mailbox.

This series assumes that the
[PATCH net-next 0/2] Add debugfs hooks [1]
is present.

When the self tests are run the with ethtool -t:

        ethtool -t eth0
        The test result is PASS
        The test extra info:
        Register test (offline)  0
        MSI-X Interrupt test (offline)   0
        FW mailbox test (on/offline)     0

Mike Marciniszyn (Meta) (5):
  net: export netif_open for self_test usage
  eth fbnic: Add register self test
  eth fbnic: Add msix self test
  eth fbnic: TLV support for use by MBX self test
  eth fbnic: Add mailbox self test

Link: https://patch.msgid.link/20260127200644.11640-1-mike.marciniszyn@gmail.com/ [1]

v2 - add enums for test return codes 2/5, 3/5, snf 5/5
   - correct placement of fbnic_nic forward in 2/5, 4/5
v3 - add missing enum in 3/5
v4 - use kzalloc_obj() vs. kzalloc with sizeof in 3/5

 drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c   | 128 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  19 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  93 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 100 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  27 ++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 154 ++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   | 276 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  27 ++
 net/core/dev.c                                |   1 +
 10 files changed, 857 insertions(+)

-- 
2.43.0


