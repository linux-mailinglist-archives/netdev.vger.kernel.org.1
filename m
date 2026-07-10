Return-Path: <netdev+bounces-306655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FwFVInE5UWoFBAMAu9opvQ
	(envelope-from <netdev+bounces-306655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:26:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E430873D5B0
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:26:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="TV/7UsOl";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306655-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306655-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8015C3011BCB
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5385537702C;
	Fri, 10 Jul 2026 18:23:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4E35AC07
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 18:23:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707828; cv=none; b=NMbylGug3YQyKRRgaqvqikYYaVwBN+TNogvVoZb7mLxvUJD+6x591oAD3BTU7RhsPqw9oDZpv8ojPq0prsaCCx84t8Utj47aXPF3HKOsaifR3w6OsWE9YugnhlgXiFlvNs+c4QpbDT/SAXxobpQ45szkEnd+lRdiV64zYWJsygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707828; c=relaxed/simple;
	bh=OwrnCwQOhMDuGnx9pE7dZOEyMC8AyvBKRK+CfPd0rpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N40w15IVywgQboL8JcwXNfTWpFDu1feRPELYIEmz6xsFp1rBOomiq3IVnTY4LvvAfwN9elEhnBBLNhPCboUNTrJVE/LiuM4QzbhYpD6Q7is3ExtKR008V5uSA9C2P7YdbEBCDw9a9B5BNhNjyqZQeM7vF5CSmHr/Y03JvqsPBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV/7UsOl; arc=none smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ff88549786so12073826d6.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783707825; x=1784312625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4FH0W5s30/m3phVMwbdnAjH+UYTF+M+YW+Mbz2wNV4c=;
        b=TV/7UsOl7jbzTkFJyVsrev6F4HxcjMyz1QyZ9mh4igcuem6Y/kkMgn03E+A7EdCBbD
         4zXw5BhLOkPSDBpB5CXlPRx3SrtQs9ODHAdcpHmFgaA8aFOgMPkwRSpm8f9IKQFmOn6O
         HEXizeyUHHRRGBMw98CXqdb2mFOWA5bpZHjGr+YTXAjTfaq5ktJoRlEswxzRiX05Rvgt
         KUDe76/WQp3+LBOd4+tFtTbf76VUYOzgQ68YEYWc8TLweXbZzmSwEihGD/OesqOSWDUA
         H1Ex4M6OfHc9Q6GHo4+gDFmvxPiMod2EA49FqSpyo7JjwHgJRU6gAWG7bc5nfynbGLUl
         bfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707825; x=1784312625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FH0W5s30/m3phVMwbdnAjH+UYTF+M+YW+Mbz2wNV4c=;
        b=SKSy6YsjF2VyUUFijs6OkTZgTQm9jzla4w36Xo333lXjYi1nYOxKSeIEq9MGPiO4OX
         vFAfcqckaLAelx5dCglmY15Mir1RmthJsaNTHCz30okTqm5XpJODd/872avYvq4SFVpq
         wQf/FpKYnlsQ5ZkW450GXSDyj3K1oflf/K1NnBwZxO1DFBey8L2PZYReJlCkp2rrRBRU
         h1VtG8tsmgA1UNodl2zfI5m/o2tr3fCNKuPs7Y5DsGof2Z8V8kPcd6GZDeaj6HzFPk3B
         F/YS06ue7WYhSEo/l/IbUn8cbKaabnixaEJZftwTG/wjifebPF3IhCxhXaWrZ0NNveN1
         CZ/w==
X-Gm-Message-State: AOJu0Yxt6X6vmyLb9O3SJJuzKF7odwXeOY0DIRNfd5AjX8dnclj4SzUy
	w6+4Tso7icOMNtf1FkWWX2tiJ0Y5u2BH8RfSTVvWr0VEw0+anee3LEFozxXSRtPW
X-Gm-Gg: AfdE7clz1x624f6xTmgzi4JqmxL73HDoMSM/MX+K+eS/2nl4xeXPnupgmsDvvTfoD/I
	ntRI6b8CKAuY6nrhnePY+eDdEQIOSCSmMhLVZof3Z24Gnl+jpvV3Jr122dgsYyEOCIVDnXP5dnp
	JBw1rAxVgT/EoDojyIdAC1CN35aXhNrsGisgX5lVw8TKx7h1jPgOS2Gv6bTddAed7zU7NDBfoiW
	Ds8hu7R7wUwH4z5TCDxHd1NQqMR469ewJ8SaRVdto3nkeUnHcYbokMgD5DKIM8pqWIhcvdhkHl9
	XxGz0TcUN86+RoV1Te3lVfvxk3VFRr2GrHd9VADk2OrKTEZONF3EYHZ2gx1dyi4Cw/daCc04xPK
	Td2pqkLt5A226XxqCHzB3g92RUPHxZDDLJ5UhTY6SqYc8QApvUd0IP1w5oa/FoDge9Lb7S6Sf5K
	lYmz3q9t73o/nAGgqdua0QZlQbsdk2Wpy3f/hb9rSP3GE3GVpnAVsxA/FtFH1vwRJ7RkPtBrS/v
	vdAwWil0mrcZD1dQI+5XgeJvQtFUU0sgYFC107ZtCTuR1kuIh4iFBo=
X-Received: by 2002:a05:622a:10a:b0:51b:fb82:67d1 with SMTP id d75a77b69052e-51cbf12b97amr688881cf.20.1783707825087;
        Fri, 10 Jul 2026 11:23:45 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cbd8efab4sm2932851cf.1.2026.07.10.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:23:44 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: fix addr_wq_timer race in sctp_free_addr_wq()
Date: Fri, 10 Jul 2026 14:23:43 -0400
Message-ID: <5dc95f295bdb5c3f60e880dd9aa5112dc5c071cc.1783707823.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306655-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E430873D5B0

sctp_free_addr_wq() previously removed addr_wq_timer using timer_delete()
while holding addr_wq_lock. However, timer_delete() does not guarantee that
a currently running timer handler has completed.

This allows a race with sctp_addr_wq_timeout_handler(), where the handler
may still run after addr_waitq has been freed, acquire addr_wq_lock, and
access freed memory, leading to a use-after-free.

Fix this by calling timer_shutdown_sync() before taking addr_wq_lock.  This
guarantees that any in-flight timer handler has finished and prevents the
timer from being re-armed during teardown, making subsequent cleanup safe.

Fixes: 4db67e808640 ("sctp: Make the address lists per network namespace")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 587b0017a67d..cf335494bffe 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -663,8 +663,9 @@ static void sctp_free_addr_wq(struct net *net)
 	struct sctp_sockaddr_entry *addrw;
 	struct sctp_sockaddr_entry *temp;
 
+	timer_shutdown_sync(&net->sctp.addr_wq_timer);
+
 	spin_lock_bh(&net->sctp.addr_wq_lock);
-	timer_delete(&net->sctp.addr_wq_timer);
 	list_for_each_entry_safe(addrw, temp, &net->sctp.addr_waitq, list) {
 		list_del(&addrw->list);
 		kfree(addrw);
-- 
2.47.1


