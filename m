Return-Path: <netdev+bounces-262384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ0jJbQdpGlkXgUAu9opvQ
	(envelope-from <netdev+bounces-262384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:06:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374F71CF422
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00F4C301A728
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08A73002DC;
	Sun,  1 Mar 2026 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik4qE+zQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A342430B98
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772363176; cv=none; b=P/ml4IK4mfeuQnUasUP8GF914rR4SAGAGL6KdjxNEKNVfiwDn6QnIPKBIiisrWGYV3Hg4tSSm1A5fwk9CibOlisPaf5GaMtxsvyMo5efR3/RsKoReVuRpOuBwwunMbS7WEZc74Bf/mN/qAosqBl7urdIBVwMQluoHJTKCJCXmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772363176; c=relaxed/simple;
	bh=wNqAgB/S/27suUsd4e4PngyAsu3U+JyPCh9FRL/8ItU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I35pHHDbn+GAGY2MlsEw7gdZkmXREg2KohwAVmsaFdS7i9QWEZzwqFPVko/CbScb3XRdjURaFVT1vgCLa5a1X72NIueLhxgp3rr2WUIzWA6dLUwPAa96VP3K2Is6hReCbcqI11yd00wj1iBcbWmB9SD4Vq5z13+QjvJiArTw35M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik4qE+zQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506989e8516so32353051cf.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 03:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772363173; x=1772967973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B4PKMD+3oeR5WUNsx7cQ5Q1H4j4gSgGWFIdbOijhI2g=;
        b=Ik4qE+zQ4uJV5jbrBRrE4riepIEjS9/wpOUVXtLfgLKG0A/oWjN2cuKxuRogubXKRM
         SOv1HI2OVhCfe4rIqiJ+TgTotpwOdMBmKequo9FNIXDMZ7GC28uTMKuO8RCv+oV+RMxM
         uzq6Lk1OEjdYisKM4WBdQ1Td/84D0xiJKeE7sETb7oB1QYpc19sV1mmOy7Q6VKa9tv7/
         sVF7EMnTyWUqzxVptIG2T9qXPOFcObE47Kb20xetZso5lgMoKYw2bT0PQXO1nWZ1rfh0
         c/EluLlpmo4WmZPx2VzjfwnQKBP5VJyBWcWB4W8VHxj0aqIs/zlu4HMJk9z5nU6uoT5S
         jvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772363173; x=1772967973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4PKMD+3oeR5WUNsx7cQ5Q1H4j4gSgGWFIdbOijhI2g=;
        b=kS6h4cQi3Uh/3b5gO2sqZkb24pRJd6RuGNt27/T9tsqtDBXdxTIuKgGFI33RyjwlOE
         uLCZugdfaLStNbNy5NJV+mischxZsIm2H34cVjqRyRFrYX9RDVR8f3hHuiOHRVeRRG1s
         Hi1wyJPVBJuMwcdbYkAk4oLLgtAAw63qUqNjtqp17lxaCgXhvbdFhimQoRutzgDEsZuP
         54tcopkfN3OD1pLT37tpgNazPyQQ+Xs4Ww+bqP99d9/YVtiNIgetgneMz6s6Qr3Ncekw
         Jt5eBFp74UXFSZx+ANVV/4txf40GSD2psJJUQ9HEk+LTQyKzdTkRRngaiygP3Oeq/3Xr
         QFng==
X-Forwarded-Encrypted: i=1; AJvYcCWtI6kEAeQEZyFwtL1Lt7vx7BZthbHJRMa0hNeynws/oLn9FGiEz5lVYqoyztL31s3lygfoP10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2lRUO4bU3chUrQIPbN982Itf2AGTQEmfin6FCm0pNUl5iyGhM
	cOFvtBHmlFIWGUvf8Xu7hTfrL4WMruqIFgk9XMk2xmelbbiRMW9nTJSE
X-Gm-Gg: ATEYQzyXwCLGSLzyEir3JjZaC9QPRLLx/nrJzRrH95kNc1yPc2otnUT4P7uEWJldSRV
	0s9+v5/02u6aOHt6TelOSO0tc5pnnTwEaz1WQBEK0kSp2AMJqhNOUsB2fD+17Klj/1k/2zu/0rY
	h3mJCzgE0UvTYdGSBwHHk/pv9J7DcH4hImdVjK7UNkaL+9txev8S2ER+8xEX3knuB59TanZcToP
	JqLd6rilgiusFfidT5LPnrGpvxSoRw75IIMQGcWNdLh6mfk90RLgz6/RQoeSLW7KLeLpYDikgjK
	Pcp67Z/P2zQTdNU1dW6tGry9N3W6WCKsSlP96dCxbuTkA35AIMcIrnHJVfT/Gfbb4t2h2UFIJph
	dRohZKS17gUPfg7Pcn+ZYzsNU+00i/QN0bJHE0zLW/ayxBO1xydW8dP8yB92qbmxUyoPKXobgJ1
	zne9cJeClRT4Au1gXv4LuajE+qXn03zD/X4eA/ir6LK2J2FgxsEqB4wlDn/w+7gp0AQnHyXhnPB
	RTtqnaPXYnEq9bA
X-Received: by 2002:ac8:5f0f:0:b0:4ff:a40d:d2b2 with SMTP id d75a77b69052e-50752817c8amr117952411cf.16.1772363173436;
        Sun, 01 Mar 2026 03:06:13 -0800 (PST)
Received: from PF5YBGDS.localdomain (70.15.25.19.res-cmts.sm3.ptd.net. [70.15.25.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm83888876d6.15.2026.03.01.03.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 03:06:13 -0800 (PST)
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
	Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2.2 0/5] eth fbnic: Add fbnic self tests
Date: Sun,  1 Mar 2026 06:06:01 -0500
Message-ID: <20260301110606.3739-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262384-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 374F71CF422
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
 10 files changed, 855 insertions(+)

--
2.43.0


