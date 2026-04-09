Return-Path: <netdev+bounces-276767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOYPAMgB12l3KggAu9opvQ
	(envelope-from <netdev+bounces-276767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:32:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD033C53F3
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E4CE3011A50
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 01:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9C22E764D;
	Thu,  9 Apr 2026 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlhMBosz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C62E7635
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698372; cv=none; b=FcdDQoUwhPz9Q2OJ12Du99Gy0ly5Byz6P6Om8v3vK1HDoVy2dXQmS6Tsd7Pealz9lsN/by3vlWeOOLV+ZJtu1yS7OMTzyHNEw4lHZNdvBw69LVWitTtiqdL7yE2UTjDP3PuDFKyrYfMKq4y3BP0BNzp2FqArR3ti8kyv52NkTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698372; c=relaxed/simple;
	bh=ceurvPD39uZmHE7ZYdMljcXED72ZrKuWYWfD67F9jN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UA9q/c2ycBQVS3JtweptkT6+hJVCkQrVmyJiChZhDBosOmOaii1gNNfM7EwkUkOpBpn6locvGMLGX+X2lukIIwptdzbixIt4ZkoY8O+6zbFBsmcQ+bCOUrgYq3NJ8JTk2LdATCzRufNxwkX3gNc0Z5gin+TUbpBMSGEFXKqgx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlhMBosz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89fc349b5ceso6067476d6.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 18:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698369; x=1776303169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmlLOlUfJ6gKKRXnCcVenCQOaaM3E2xjVjNERB+O5uE=;
        b=YlhMBoszOyfNkLK8a0iUlX5ugTskv5BeK0APHX7+6hrgTU5NiKNJde1AJIFDzQ3dyd
         w3nT83Igq5FfX8RQAF4yljdCwjEJYhY0NqZuMvsShpJVSTQzJvjAf6HGjDHWB5MJWAk2
         jhXBzCPlJtmyv5cWr6igQTamlasatTKFntB0gHVhb3K2uPCW9/a5LAfPR3M6+E30zTGW
         h/+Vun2E45OZ6+2R5ngZOa/kVZtrVloO5gObKoqUmi7/JBx1/fLvmsjqPcqo5Q14pAou
         wc51sbLX/Rqa7eoCrSqUaDf76HtHy3Exg7IFfykhuer1gzAuHyrra5PIxP9eYzXlu60+
         t60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698369; x=1776303169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmlLOlUfJ6gKKRXnCcVenCQOaaM3E2xjVjNERB+O5uE=;
        b=Xm8PKOZNAve6qfkiTdG8bdrKQ8y6wO+EebupwLMgdGSUFg1bue7MHgYF0oe2h6Fz/q
         PwXQdpkpv9Rq+pqQadpR13oXYwUenNfMwacKZ5Qg828JFO1NDUDYtRI9t+eQQrqSQQfA
         ovPuaR3UBhmyujYd50VmFtIu4ZmSyxQoRqK11qs2E5N2jzqXYH2e0c3RYv5CL/eJAC0l
         Nn1OxYEmT03612TuLjBQPLQjy5xZI2rGwgUUtE6vR1uCIwgTtko5wI9CdkY28s7gnS0E
         umox6cQXtJFFH0NBbubGqU8Veegkbck8pHw4WnacmpYY1E2TAbyeGvNqjjps42fw7puY
         +aqg==
X-Gm-Message-State: AOJu0YwFXVEKqlR371n53fzDnMGv+JJD0dwhkxWtrv2B6vQU4m1oIYJ4
	pp07Id6s1BuYIRyC3oAf9E8e4S5aAxkZfJY0+SaPx/S9XMvpER+LQy4KH65VTKGJ
X-Gm-Gg: AeBDiet0zxxRcTH36T9Tk1KzJJN0T4uksnXuD5fjh+kJvsIvUerEvfItpkgERproFkV
	K99Obvi+o/CX6TkAFd63DwrwA2cKBQCULW6Fz+cy38xuL1EFC0IvVUSjRWH5XNjYX+Y3ESNxn2O
	Yr7xNjjmbxnOcwyOZ2TSD76tOwCiwrhl1pPUEV4SDr6eppO2myJFEIOBLeKPvB9w1GwCSoecB+2
	oT2oDQXzkKV4+/BYQy/rsHo+XM2zQMxp8cMEgnZamBBM5lJuqHAF9V3rCkfIrQsiQbA0Bv078zv
	967OLDkQtzfERrGiqxnsMEVvYqEgYxegDIa+J7uiZZK+mOVr6ek3XpnvmpSzS8CuoovS3fttzgL
	SY/si238qhk0zIPoAxrz3Al/1nal6Qu/Qhmuax1Ve1rCJATIFNtXhPWQQ2V3Hf9zoAAn7r19nCz
	Baerk3IeexXX4vMghmrxoEGSA2N4/FInvTOb1xcH/5+UCNS6EOBwo1Bbdru/c7LQBauPj2fsGKG
	4Z+/jz9mi4UCql2+NDyaOK4Ka3dt6hG6RPWXKs=
X-Received: by 2002:ad4:5c4c:0:b0:8a5:104b:e37b with SMTP id 6a1803df08f44-8ac7441cc2dmr30872916d6.42.1775698368709;
        Wed, 08 Apr 2026 18:32:48 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593cec807sm186681866d6.19.2026.04.08.18.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:32:48 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] rose: fix OOB read on short CLEAR REQUEST frames.
Date: Thu,  9 Apr 2026 01:32:46 +0000
Message-Id: <20260409013246.2051746-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276767-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6FD033C53F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rose_process_rx_frame() dispatches to state machines after calling
rose_decode(), but does not verify the frame is long enough before
doing so. All five state machine handlers read skb->data[3] and
skb->data[4] (cause and diagnostic bytes) when handling a
ROSE_CLEAR_REQUEST frame, yet the only upstream length check is
ROSE_MIN_LEN (3 bytes) in rose_route_frame().

A crafted 3-byte ROSE CLEAR REQUEST frame (bytes: GFI/LCI-high,
LCI-low, 0x13) passes the minimum length gate and reaches the state
machines, where skb->data[3] and skb->data[4] are read one and two
bytes past the valid buffer respectively.

Add a check in rose_process_rx_frame() that drops any CLEAR REQUEST
frame shorter than 5 bytes (3-byte header + cause + diagnostic),
covering all five state machines with a single guard.

Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 net/rose/rose_in.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index 0276b393f..1ac9a6aee 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -271,6 +271,11 @@ int rose_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 
 	frametype = rose_decode(skb, &ns, &nr, &q, &d, &m);
 
+	if (frametype == ROSE_CLEAR_REQUEST && skb->len < 5) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	switch (rose->state) {
 	case ROSE_STATE_1:
 		queued = rose_state1_machine(sk, skb, frametype);
-- 
2.34.1


