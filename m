Return-Path: <netdev+bounces-257593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEDmGAAMhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:42:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D212FFD87
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C81833004071
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8A52C11E9;
	Fri,  6 Feb 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq5n5QcI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073862BEFE7
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392569; cv=none; b=GBA35liXUiY7rN+9biia1GV9E/mI5YjO6oRWSVgikVJZDHYDH38tmhCnwPlErbTm+1ew8rv7gCbHNhWqC7lt8bEqucCHzR9LQxDnlFMy+m9xTjOLiGUXK7+YlHOJGMWyXxB1i3hFASSsj7wZbHFE+Plosh65422GlCsT+pK5Fxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392569; c=relaxed/simple;
	bh=2KJtKvL2ahrdjrvevTxKPQq1Jlom8zjMlMifSSAmnzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csb0fv966RXdm2bXDDB1g4MrvgzE8SJg++I1jo0DTnWrEM30cllj2nSV6hUvD1aGZNAVDF6kb/cjj6QoeRv5JCD7xelEVs5vTTU9Xemc+6qywiuzzJTxsotR9f9+/UsT+fC9OvQk6eDZD+8SBVCVtgfqCZGu84iIEe4K7gM7UgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq5n5QcI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6af798a83so230136485a.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392568; x=1770997368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rMZSnw0zfq1ZVYFggejX3e1LSUrSYvX3K2OrFUaLcak=;
        b=Eq5n5QcI4wtfXcomUqo0u6zkQHcs+ZrI6SaP6Jaqub4Im1zPKgVjF+cjvipPQSu7jk
         57MnGbp6idYkiGEUGaR5ziu/yUXPtNrIsot22hPNB7ruKDdcVeCiHmTgmHoCNbhWk7SL
         jbnqHN6sRr/kGM2zhahZrQ9bRxiL0XUs8SsiyPvGaDkl0V0jalQXrlRpfATjqddHNiQk
         v0ZNAVhe/Crj3LUcdZApN/Y2a2AAkLYfXtuWHWeBW2WukpCk1Ie81mFZAHd8cdIP2AQr
         Sd+BBQNlWoQfcDJXwvwkbo+wQY2q4c00ryWXX419b9mkHWn7cjx0l0gNcsJXekbFzYrg
         Q+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392568; x=1770997368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMZSnw0zfq1ZVYFggejX3e1LSUrSYvX3K2OrFUaLcak=;
        b=vyBBtBZ/LA2feHxmF1Fc4RpNm+BUfIYMCAOqjKt97Ie471oeoFjygJW/7WCQg2SbO+
         X4iFavm4OBx/kMqyzm1vtwkBKT7sM+DPHVwGLqE68jpwhaakbZUYTXWfV0aG2g20GfO5
         aLQ5qeiv3su4JKl3CrszjIlzW8KPGkf/u3u48eqb+MumAR91nVORFpQj8zTOTLELpFfr
         sHtQkmN0VRBRUnB2NgYRIAvS0N0Cp/XGA6+k7RymqnCpsOUfdZEqdbjoYk6oMacBCJdT
         vAMjsp3CJYXYh7sl/BJUc4XKitPINoo0rFjOX0UZvpBRWAENRUbaIJqTxn5iNMwipLwg
         w5Xw==
X-Gm-Message-State: AOJu0YwBnm4N/Mi10HSg9QlAMQnKn4HRhU0fTdbS3fn0NTzxeBjpSCfM
	O689IW0XVfAJSzW3pkB7cCv8i7IAB+RAhlKp+ZYoNmv4Re6EqY3WXzTM
X-Gm-Gg: AZuq6aLxIIFwOMaHNBBQDbZA6BVz2e3x0J3CyiCbUVvEMx11KdJtCcsS16POsLf5hGN
	SQVIMH1KwxWkACOM0vQ92HrDRKrhJC1GUQFTCRO7zC/k4JjvUwrptG16EdOQztlYNcxZgpwcNTa
	k7uj6C/8uWH77GO0xc9TTAdN/Ej0+oeGXqnMly7pCLSL+hWsST0WLQyZGQXGbMVLI9Eab6CRSvO
	0WLQS8zOf3pg9ZzNAbqwj2ZN+fuVDD8e6mozZ7/aOeHoUZYmwub/B+nCX9X74C7P5r5+aIKD1yf
	2Rmqi7Ffm2EPCtfb99JlIbnNZGUrpGkI6YUZj1LpQREY7Q3Uw7+qiF3AXQBqHv/Vuvdj10WmVH2
	E1aHQXg27FedAytYS9FrvLxR1GFk0THtCujavGe63NqleFcVEX82bvlGiA7eXwugBTGHO18H+fA
	v/olryX5ZaXbyO39CkLrYmFBakMnqGeZFgayykSCS4jh57
X-Received: by 2002:a05:620a:2805:b0:8c9:ea05:d15a with SMTP id af79cd13be357-8caec0c9922mr398903685a.0.1770392567755;
        Fri, 06 Feb 2026 07:42:47 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9eea0c0sm181499185a.42.2026.02.06.07.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:42:47 -0800 (PST)
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
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v12 0/5] eth fbnic: Add fbnic self tests
Date: Fri,  6 Feb 2026 10:42:40 -0500
Message-ID: <20260206154246.814-1-mike.marciniszyn@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257593-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D212FFD87
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

 drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c   | 126 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   4 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  93 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  92 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 154 ++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   | 276 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  26 ++
 net/core/dev.c                                |   1 +
 10 files changed, 776 insertions(+)

--
2.43.0


