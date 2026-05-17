Return-Path: <netdev+bounces-288705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGbjGOV9CWqVcQQAu9opvQ
	(envelope-from <netdev+bounces-288705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:35:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0A055FFF0
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CE01300CC25
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562C13469E0;
	Sun, 17 May 2026 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqF4JxpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C333F8C6
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006869; cv=none; b=i2AvBgYR/5c2cMFIDuhnps8WOG31Vj2TU6KXibPYh+AyWb903wW/S3ffqMnFnsZ9UceVBLnjaWFm8hDKulavORR3nfp5WbNoauIX3DYD9Ar4/QJ48KfrCQcepxFoa/buEPpEARER9pSR7OVdsZMYDunywdCe25uACnyxCLfewqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006869; c=relaxed/simple;
	bh=tNu1q+k3kNpMkU+h1HzMzpn06Pa3jAV0Kk3zKRy+wQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuLyZ31KGHvnYDUNK5njJwd6EwwIL8m5hz71/3jNscAFz7z9whB83CPN7bMUh0nYOwFqNOPOSUrE7XQP5xiS8NtcQGlADFxW2cbKmHC9KmgF0Ht3PspMlUkSbUqbGNtZIbpCamGEy6z/TZPD5ilPHS4zhFHbm0g6eDrcrhdmL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqF4JxpN; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dea20cf21aso1504270a34.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779006866; x=1779611666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ7T24h6C2KWf71uTZiV7KRUU4xs5Ab9gDHIZEPT4Og=;
        b=gqF4JxpN36FjilYHp0SjM6NYMkiXSw89XN9OVqWr30PVMqx/w/Y2ymiQ7hFGl8TsIq
         Gmjm4HtLzR54WDdTDFdpLizIKX83b5HxRl6Sxz0f7h1/fAlVe+wWPMkz+8UMoAiEktIe
         Wu91znXqkErvKj/dTN7/fHyPoeQsP95Bh7nOSaUTniEAH/+gZdj0+8B8Qt05+D/pFpDq
         +tnxYnqAEORqVHZbHB0hWiz7FmQBynLdSDGYF14mjaY18hBbZDIRI8qgmIpUJhqyFjYA
         hw00JV5IX3F80cFPzpjRXjURtP3S7pLwD9/dVR/kGgRT/ZHUsRWjfQM8yiB5tuRH1uDj
         IniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779006866; x=1779611666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQ7T24h6C2KWf71uTZiV7KRUU4xs5Ab9gDHIZEPT4Og=;
        b=TvbCu4QVk64mdg4tGvbVNbz9w1YpS0RVGqh96pceJA7mQcpd9h1x2x2/pEfMxcK5cm
         DJyoQABv9svfeEksxAN1EAa4RR7JPX6LzgVaMkFECZUrlHjIU0j70LSZrYQMf8wSYkff
         tz71NggQpKJ4U/0bO88diS8MXu4JcJcSI2TYxA8oQFNx/odZR452c+3WmUDxagAuD+Xx
         XnVXpTG9WJssjm0a02LdsQVh0mMNMAlLAVniUHjtBaB6g31bQRfDBAW1gAX3Szaw9+oa
         ZvrFfGJP6L4FeMkhnEidZrHscMrZu75ruYPsQmB5sLjF+keN9lrQmvZ2a+yuyCw59kVH
         xMEw==
X-Gm-Message-State: AOJu0YwVBPd+VpKtOxQ97p/tEgzCZZdRVA/q2dIlGCjftfvn57FOgTkR
	dRMbafNitxNzNkWozYBzKN+5G3DG4vWy1XwNYIdLqObGLsul3LQHDxXYEr+nluM1Irk=
X-Gm-Gg: Acq92OEXI6HajExYhIIyoSrO6U5B1NlR1ZRXEIO754DRJaH3wWPXZK5a8hD7swW+Q6M
	lPOscBx1/47Vf3/MmtaaZiXS0qTQJcv/rpsby4GlFO8oI++Hiq5AYY7JTB/yRmiLTGT7z548B5/
	6rXDq8a7Ta0T2BDLMurDQIYQN0T1wdkg2qDxvG95kF1mbvdTVrezTC9JvBAGdY3xCuxZpqYHPZf
	GUr7a2UODskOMo5bwabUZtfkRqTCFnnEMQeL238B5O/Zffr7tQYsMqDe3LYiZ//RIi0Ek2D3vLJ
	bJENoIMv7br6nGb3b3wg6bQz4sZyEeu8ugFWoAMZ0k+/g1DPb+JyydpDUi+Dm1gAUVOXD/P3GNY
	OtxCHZJ/n/kqFPY2/1pBPo1aSvdm0LF7Tz3yRsbtZlawovZcy+HTMJ2we/Y/lZMcDt0L4AJbnHt
	uYEg8eauahSbrA9uoPA6OiNv5DiA==
X-Received: by 2002:a05:6830:2801:b0:7dc:cd0b:58bc with SMTP id 46e09a7af769-7e4ea04a33fmr7512068a34.7.1779006866584;
        Sun, 17 May 2026 01:34:26 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd0bd6sm5345191a34.13.2026.05.17.01.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 01:34:25 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH 2/2] tools: ynl: add unicast notification receive support
Date: Sun, 17 May 2026 16:33:58 +0800
Message-ID: <20260517083358.2088599-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517083358.2088599-1-houminxi@gmail.com>
References: <20260517083358.2088599-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC0A055FFF0
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288705-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
 tools/net/ynl/pyynl/lib/ynl.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index f63c6f828735..8f526c683f99 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -748,6 +748,10 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def ntf_listen(self):
+        """Bind socket for receiving unicast notifications."""
+        self.sock.bind((0, 0))
+
     def set_recv_dbg(self, enabled):
         self._recv_dbg = enabled
 
-- 
2.53.0


