Return-Path: <netdev+bounces-290214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA0fNz5tDmqN+gUAu9opvQ
	(envelope-from <netdev+bounces-290214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:26:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE259E0F8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9669330FF8A9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA683672B1;
	Thu, 21 May 2026 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q72sCya5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D936403A
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330049; cv=none; b=Nx7Xwljs8FBrEZ7IhDToCqZw78WpRZr3inI3fH8exR+1U/tqNQq9XWQeOwy0U08RxQFy4MlXk3zjHUfGM+q7DN5/tkJzm83bA+A0l0/+BdqidqZpRVOFpITR1vHOcwJV6Hgk2L4t4ynMSCpz7J5NOdk3bCWoSYMmLtprgmvekoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330049; c=relaxed/simple;
	bh=7gkdh/lnQTTuxx6/JFj8kOO5YpwKC2TFQ5qQwabdOKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpG6W4b2Rgh8i2LoODyJm3IwsgoE/5Vd/Go7EfYF426lvReG7uaKi+sm928CMqwgiD2AYNnWszRZbOi3hZcyrcf7o5ZKdaqkVBkTbmfPQ4LeBKtZGkZ8RZdvnDqDia9oRmObI0IE2HU+mWik3h01Sl0k2+Lw02TOqCIpefV2w6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q72sCya5; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e5c85b47c6so2325058a34.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779330030; x=1779934830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD6WSICs4pvbiObFP2CkxZsFp4/ZZorDEVJ/W/n+3iQ=;
        b=Q72sCya5xDFFU6D8EtDNrSh6IH+0xFUNbu6FNIQbdPqQsTRJC4reOSZBI/XnDJ4Slh
         9n02l8rg9y16pYhvWW+XoofKtwctsNxTzSRUun4O3o3X7vdYyAo1eVS0y0xECctska1H
         19DBBGAwDhnW2uRwCHgRQeCmV0PcjsFzau9XB/B4+dZr2tNRnW2MPrWxFbkX85Nn+JlR
         QZwy9X+Exz6/lVHKgmBKHC/98UOkAeIfNoVROr7FRfKqwFR1N1CZWmEvb0t+NzTFJdw8
         dEA2GaS+j4nY00bItUHt/1uOAMbtWnd0C6WBMMyEPWsUsdw8yuzSNf2698t4osoZuArR
         Tz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779330030; x=1779934830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VD6WSICs4pvbiObFP2CkxZsFp4/ZZorDEVJ/W/n+3iQ=;
        b=X6IUQ1kwK/Ej3KyPnnv96FEQ9RP6dlf3gTcCMix/Z8B5tZ6w7JTkNf8Yt0KYQWv4Xc
         siekKxaxsXeGHEToyx0HDXWW3F435INJVf58W/b/+/NUGxq0NUvbfFHBawIlTT5pJPPi
         BGa2Ut+5XFE0DYoBycl//Kf0iJ/C8BZSwE1Okc9vkkZhyCLOglpMUYSmu3yV3cV52fX3
         18m0ThFXDLizJTi9r20cBSwqVFumMrHQ3xysIw6jz4AQQ+5a07NTBQ5VNpZLAQqjBGxt
         69yg490FMafkPvj7fGU47CBdvo9ELyBpFo9tDKBx08gXR8C0+WUEkD3gpz4gD2W3bn9X
         zNQA==
X-Gm-Message-State: AOJu0Yw3mcglEPuIRWdS0PfCGXEWcOaP9FYX/ZLVgeXyRP+sAONjvjCw
	U7kGZ1ILTTJRk9qEOIQEgChI9+4W5PVmHqUZIybbdsJGk6XeoKfzmDXk0nefK6/E7Xs=
X-Gm-Gg: Acq92OE8c8ARCyI2EgCA2r+4+ACblcQPrW+4Y3WVnkZO5/HinJqZnNeC3Co2SLqUoVV
	blCG+QQL4Kz0xPKEMGPaNs7SZaUN/VjklCNa9rfBYrKC8T2cHRwo1gtYGXYxRDBpT2Bb1qoA65E
	LBCVo8kBQn5TM5h0gkVwkQ8JuAZGez8Uz8l3FmpqVj0nDIHPxiLYA0TvcD4rWFPTtHOMhuDqIOT
	+A8t4Ax6KFUVoaOwTeuYrZQXrLritOHNJAoXW0jJnhvBpkQLaKwwYCXHdHAMpY2r9sg/WYUOYdD
	THaOAGbwBzkzYd5aO97rcwf0ZDtC+pdUCesblXrfD7njOETKZi709bgOGh24d6GWW7v8Y67wJrx
	9Omhy0Vzx/slRPXqwcoayNY7K4Y+bXMhtvyhrbCtlq8o40XYde6LS+ya64ur0d/z3p9xY2OnxQ+
	lYsMFc7PTYcx8J2pT2AE85CrNuBw==
X-Received: by 2002:a05:6830:2654:b0:7dc:d601:a69 with SMTP id 46e09a7af769-7e5ec5c461cmr395491a34.20.1779330030212;
        Wed, 20 May 2026 19:20:30 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c6b38sm13791720a34.2.2026.05.20.19.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:20:29 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/2] tools: ynl: add unicast notification receive support
Date: Thu, 21 May 2026 10:20:02 +0800
Message-ID: <20260521022002.879334-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521022002.879334-1-houminxi@gmail.com>
References: <20260521022002.879334-1-houminxi@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290214-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 63FE259E0F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ntf_bind() method to YnlFamily for binding the netlink
socket without joining a multicast group. This enables receiving
unicast notifications through the existing poll_ntf/check_ntf
path.

The OVS packet family sends MISS and ACTION upcalls via
genlmsg_unicast() to a per-vport PID rather than through a
multicast group. The existing ntf_subscribe() couples bind()
with setsockopt(ADD_MEMBERSHIP), which does not fit the unicast
case. ntf_bind() provides the bind-only alternative, with the
address defaulting to (0, 0) but exposed as an explicit argument.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index f63c6f828735..3cf6fa96347f 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -680,6 +680,7 @@ class YnlFamily(SpecFamily):
     Notification API:
 
       ynl.ntf_subscribe(mcast_name)      -- join a multicast group
+      ynl.ntf_bind(addr=(0, 0))          -- bind socket for unicast notifications
       ynl.check_ntf()                    -- drain pending notifications
       ynl.poll_ntf(duration=None)        -- yield notifications
 
@@ -748,6 +749,10 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def ntf_bind(self, addr=(0, 0)):
+        """Bind socket for receiving unicast notifications."""
+        self.sock.bind(addr)
+
     def set_recv_dbg(self, enabled):
         self._recv_dbg = enabled
 
-- 
2.54.0


