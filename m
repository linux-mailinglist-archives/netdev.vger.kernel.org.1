Return-Path: <netdev+bounces-289397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOOgKuI8DGp8aQUAu9opvQ
	(envelope-from <netdev+bounces-289397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:35:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D857C57E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D02E304EF7B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395334A76F;
	Tue, 19 May 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToDkYu5d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DBE342CBD
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186748; cv=none; b=KQdS4JJ0FogATkRKvuI9h6xSu0I+ioHpnHYmnPhUqUYIzq3jxH1h/znPlwnv/YfGiXS0g7zm2X3XO76oHKQbQokiGQ9C+ZTlWJsf8JOWvxOHLJGjxYe29tnGESlljhi440aXw2cQ84OfL3tNL8dFaseCGHldP/UO2HW0iC5kgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186748; c=relaxed/simple;
	bh=TmJGcAWVQo5UOmOu/tga5NoZgiH9iADZIX64dMCrfWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEWngHHcx/SHwdOnA9W0f/O6hMmkmM8kFV1RhJLCP2K2MsczcFdZsLPFH5wgATdTmahP2CI2+ZQBYnv4dkz5qYiYynquhHPyMvrmr1vpP04i9u2Ixtufhs9U9kue/zF1ncXGPUvjKmWn8IpkXolxVDzdm4aTypSMpqrTZm9voF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToDkYu5d; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-47cacb4ed99so2169435b6e.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779186746; x=1779791546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9rzbyO0L/UEGnlo5xdTOZwQ03g+59F1TZtYxaJ1Kbk=;
        b=ToDkYu5dOPfWU6vVcNn+dV/yo8VLTrrww0wXsrb4pOMRRqF73Agg9Pw2bA2InCygWD
         PlEwTNpEWaSOoVZgQIy4Aq7J+nvi7D6I/Do2obzWQpe7kiWSMZHCfTMWL11FspTY7kts
         kNQ17doTjXqocmr9K/fl75PdRwAfO2i9vBWeoWjwMN+LY7U5K4wfnhsEI37xU+JGXI46
         lL86A5RhJ3DnzNRvD5+NiR/xWBHnxjqUYurhdA7gC/hwW6ym1U4mAf2CkTKO63MDt4jx
         +n/4vC2GakgkKZGUS2j4qZZWvGnIazqi1KQ1X58Po63rOFWUEdyI7pcQEIOVY4CcqVvn
         9a3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186746; x=1779791546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m9rzbyO0L/UEGnlo5xdTOZwQ03g+59F1TZtYxaJ1Kbk=;
        b=D1W4PefdXPJXZw35JZpc2hl5XTQC00IZjWS/Nyf0DyJaNtfEazJjPUx5OeSBPyWEtU
         Yxtc8m1ztjVq+hH2xh9HMnB15CjJSKyOrwXJrWIPaos7TpRM2sOschKjeNw8RJNJv9/q
         bkUtdokAGJeLOgj3VtPJREFmeCh/EU/WzGIK2r6WF7leLkB/2L+fJlroIZImafeBdP3w
         g6897bKBqCvw6vEAmPaRVK1+F49OqszQub2/ADbqGtTh3x7GTuA8EGjVGWRqyUm90iK5
         jPHb+yiDbfsiX3rQV1D2i5sD++bV1Il7pypoN5d3IRiC7B8PWSp3VrMGVwNpg2pVsNjo
         l7NQ==
X-Gm-Message-State: AOJu0YxB19IaJtIuadLeDCOez6HWcn+b0wwm65bX9GW64s1jLcdh6kCv
	MvrcPrOaecGr3Q75p2+kD1o0gtfuSMtQWE0Z54A21subvTLQFndvQklOepLL7Wep
X-Gm-Gg: Acq92OEhzDk4l1p2YWtsZGjYTNaLZQkGu7T7d2txly5DZb752N2h78KfO7iJDp4Fh5C
	a8zNpJHn5/cknLNaKxISR/+WcUqcZLIF2MuQTRZvOdWSVkEDih3JOMNBX3l91HnUFtUFFYPbrNh
	ZkPaSjlNYT60oFYIabezvTbMDHNgyw0Dgiajdj6naU4U8e9bUBh5oeKvgHiwFwNeVxG2gxcIy2J
	ZBfBoZ5kOoZvKQFITVcVev9klHUdM/Nh5QFlvxV0Y39Tym3A6PREGFIcLaVLXHd+CUfcBK7fz0E
	imjeGtBPL6IvGkFMy9KSvAxBq6uIWTBRpTJ4ycG0b+m9AtdtjmO27CMc3PkTinjfBKa9ceIdfdO
	q5JIh7PAcnJBehQ+EiQZZiayw215qDQ3M6T7DLgLKlJYmPq4P/2MHRlx/lXmoD3aKhL17GLNonH
	7BuIQYHIt5igXUChU=
X-Received: by 2002:a05:6808:1482:b0:479:d467:1a26 with SMTP id 5614622812f47-482e5bb9669mr12107718b6e.43.1779186745684;
        Tue, 19 May 2026 03:32:25 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee389243sm6360969b6e.6.2026.05.19.03.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:32:24 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aconole@redhat.com,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v3 2/2] tools: ynl: add unicast notification receive support
Date: Tue, 19 May 2026 18:31:53 +0800
Message-ID: <20260519103153.968549-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519103153.968549-1-houminxi@gmail.com>
References: <20260519103153.968549-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289397-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E8D857C57E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ntf_listen() method to YnlFamily for binding the netlink
socket without joining a multicast group. This enables receiving
unicast notifications through the existing poll_ntf/check_ntf
path.

The OVS packet family sends MISS and ACTION upcalls via
genlmsg_unicast() to a per-vport PID rather than through a
multicast group. The existing ntf_subscribe() couples bind()
with setsockopt(ADD_MEMBERSHIP), which does not fit the unicast
case. ntf_listen() provides the bind-only alternative.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index f63c6f828735..04743a79a7a3 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -680,6 +680,7 @@ class YnlFamily(SpecFamily):
     Notification API:
 
       ynl.ntf_subscribe(mcast_name)      -- join a multicast group
+      ynl.ntf_listen()                   -- bind socket for unicast notifications
       ynl.check_ntf()                    -- drain pending notifications
       ynl.poll_ntf(duration=None)        -- yield notifications
 
@@ -748,6 +749,10 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def ntf_listen(self):
+        """Bind socket for receiving unicast notifications."""
+        self.sock.bind((0, 0))
+
     def set_recv_dbg(self, enabled):
         self._recv_dbg = enabled
 
-- 
2.54.0


