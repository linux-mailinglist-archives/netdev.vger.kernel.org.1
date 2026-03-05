Return-Path: <netdev+bounces-264452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI7dHECeqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:16:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD87F2144AE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5D1930BE4BD
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81239C63E;
	Thu,  5 Mar 2026 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKhg4fa/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A563BD658
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723398; cv=none; b=K63Wyia85OxJ1bq9vlF59GHgWoYut8b6aFuqRemHRi4DIH3ulvLAjt2dg1Lx8pAzqv5+Fl2d4xGrUzNmFCIPvcTLviva0Ts83+o4LSYBHEtGENvO9tjxbdNs3QAewvHu9ic0HVZtz4XyvfuwmY3mbIIdod2u+97f7x6GdBy2/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723398; c=relaxed/simple;
	bh=jMWRSRxVWM2jenNTKgoHLLuPIR4kQfzTVgj8rCnnS8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bf3wBYFuu0hFyCY1cPMJsix93a9fifdzEU9sVojzREKjg8tkNPULRb5GAtqlLutZp8T6KdYMU4PDtr2DC9JxeBnjTm2IYDFNo5xTz8dka6b3LHzvu2gxrT+nH1vrfVdv9IdpArpy8NNHkJzBU0C66rh0KV2CLzsVhn7a7S7jmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKhg4fa/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a321cc53so90550721cf.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 07:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772723396; x=1773328196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFxaXyZquLt6/p42eiThRQrXWJSbB2BATDuNgCg81jI=;
        b=jKhg4fa/uN1QVk5EgySYW6NOQj4uQxLH1Iy1poz4mPjW6t89f5NatVtJQMiCp0OU7+
         0AnBI1me2Eu2o6CpJn4qQhWZqXEw42+AckHxxNjIT8rXjJ5JIHFwwtMLa7GBvBWgEexV
         QdO2hXBKpzkE8H7ZpOkv8k1aUsO5lSn1HBhc6p2vw1P1K+FImR7fvYsAYEHPL9iGcmd4
         tBaHcNgYMbtn+lFJXQ4MrbU4uOqGZxzmvG4UABLnfl4+ld0FsvxpRu/8gNU0dx8GiJlJ
         lFt/Q5scpcpTnplpZNN2tGowVupBXY37Z54c6y3gGHan2p7/NJXYv8m2h+pku0zGCdye
         OoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772723396; x=1773328196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFxaXyZquLt6/p42eiThRQrXWJSbB2BATDuNgCg81jI=;
        b=HXsV/fE4hbUGDTxeZGNOVK2/rteAFO5qg6l1DQIQM2OGVPX0q0rBHHkYr890fiGMrf
         EiE6Afii2FTitibvO/PUFuQ3QBtBp/4htD9PVbKQ1n81xkPIhM2seN15B+5UQUSKVC7t
         ih3NOf7KpHu54T3vdy0nBrhs/mraNd+5DisXDZntlRdr+oDWzTIO2iqkNhNi/a0AIZpz
         R9JPgSc03aT70GAXi5qNhRljbXaY6E9KYDenPk1DKAlfu4xULDLnU9lRJTOj4HIFwi9x
         LkT4axULedPJujEtSACYDnd9u3D5cfYtj1qMso9pv8LFNoluj8FLs1ajXS0JOkzZbpUl
         r9jA==
X-Forwarded-Encrypted: i=1; AJvYcCW2gHA0DWvu6ogIg5DEgmY6F9pPoE3zRyFavFOWvCDR6URjHVFDP4ynvYV99HaMMrh13zq3uj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBOlJKPA8EgB2gw14Syt3e1/BmtJONAuPpTRVLsyDH1EuKudw
	k6+YDg2uvjY9Cbj/I6wA6yjpyZ1ZidIFdDQ8ZRVP98MFlFDK7Lk8LHu+
X-Gm-Gg: ATEYQzydiB0UHFGw4ydaiY2Cuj3uc6dyAp77GeiNeryDur3Bkyg4LNjIxcH8itx/RjX
	ecy745OAPiir8tiNA+Madboz2n33I9cdbkpuVYTtbSmPSWSiZac7SvhTTBxlY8gubbbFWEi2Qua
	ROInyozA2SKyvzfMm47VOLKDOY7elYmXX2n+f2g+edcGt8DqhNhsAjGRf2lIRQj8jtDxjv32l+m
	/unYaD98Yvx30G8aipIFEQZ3est7TP2TURQ3cOXP0yj9TfeN4Qn6Hpv27KmiVine/vXIUbONc/1
	4Xev//36Ly8AcHEwf91XU2CNXLzBM56ejKf/gjUbwSPxvWV7/h3M2frLAHapAdiwarEp3o9ayEW
	anjzLRP4qFhoxUBrDU/Kq/b9DSsA0Tvm31Jx55CwU6f9Th1+yXaT+PA2/OqgxrLDGnp4lnWdafO
	FVJes2g76tSuN701YkCMaFu35AlBCS85Si6XhezpM9YpOwA/00Mbo9ivEwOATjZGNsi3MmSKufW
	24L87y9ZELLSZjM
X-Received: by 2002:a05:622a:180d:b0:506:6e65:2334 with SMTP id d75a77b69052e-508db24b97dmr81999441cf.7.1772723396183;
        Thu, 05 Mar 2026 07:09:56 -0800 (PST)
Received: from PF5YBGDS.localdomain (70.15.25.19.res-cmts.sm3.ptd.net. [70.15.25.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0bb6e27asm64183176d6.2.2026.03.05.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:09:54 -0800 (PST)
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
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/5] eth fbnic: Add fbnic self tests
Date: Thu,  5 Mar 2026 10:09:42 -0500
Message-ID: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD87F2144AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264452-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
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


