Return-Path: <netdev+bounces-306715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xYfPMPdvUWqtEwMAu9opvQ
	(envelope-from <netdev+bounces-306715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 00:19:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EF73F788
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 00:19:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mwnCiyXm;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306715-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306715-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91F403008740
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6932D42E8D3;
	Fri, 10 Jul 2026 22:19:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58C4279F3
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 22:19:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721966; cv=none; b=k1KqW2SaY39nNyCQP/7pfM3/3ZWk1ZD2RGFzDvib1nbiWCyoTPkholjZ+EtZLZZbsTyQiWjfov6BUGA6tyfsm+d0DDRtA7uCaGaPSIxtE4gN6O87yR+zLyeU0ZAL12C0in/gDxAQJLwz8vZFsaF+ECfUOBXIiwunbbPXYNJzpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721966; c=relaxed/simple;
	bh=rMwXG/xzrygpew45ffALhZX5cO4JIo9QIeLG3lp+VJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jwDxhbYvb1YICjeO86nu2SXmpUSg5EO3jr6cAGLMmbzT3d65gZJFCTwtbaRmc0PmFehkwZFBFuuD+9sLoyn8WmlO9flDBwlV4hA69vNEw6dkPDnEP4419fMZ1sjIgRT64SO68npVF4KojjIO+MWv/2Mnh/e8d/VEnWFCH0Q1xmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwnCiyXm; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47df440fcd5so735481f8f.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783721963; x=1784326763; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lHX1102TV+TIQ6w7Elpz5FAV9Km6tggV36g0BGdy0xM=;
        b=mwnCiyXma9bS/lQ59kjHN5GKJ2pcqdH1XLjqWZGNpEvifLfXjPvzEyFmR6HV3LETxL
         7n9zxK/FUqvjOmuMHrChAlbyo3n2RkNQh4rf+QzTrO/PPWpRRlMOmPDyeHI5PBonIzkj
         mr5X2/s/3ir5oBJXD+U2dXYH6lkjhtTrSMD6vRbUiEj+NPITvTuaTOeiMbFAhXs++Hih
         9H7zXsOp1PEyNYw9M4xEvyUwX7SMpQ+qsiRm6b/7LwEBX6DJfdSaKBdGl/AgKG1mkmuO
         ZgD/yBzoHDBw2XsAgyD9XcG1CNriVLJv7Z45fgsCBP2keQtBv7Y91wwJhww+83iPy5a4
         coCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721963; x=1784326763;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lHX1102TV+TIQ6w7Elpz5FAV9Km6tggV36g0BGdy0xM=;
        b=hm+VyjN4EWeXeV/WxBEvPu1rMDz5s/q3zFpFxZD8CpCjcWNU4AiKWUllTYsqiQ32wc
         FJEZ7hZ0p7rxFLz3KcEZPMLoE7jFQI3s8qQERz4WFxmn8ZXUde28faKzBrY/xsPjHlB3
         mofl6L7quw4VwpIc4DxogT4noghSPsHwmzPsHeTaDPXOpjvQVVGX68zWLG1SxW0YtFo4
         M107e6AhqUWKybABXbXOG+AVVCPbJlzohru2jsms025bB5JA44N4yal6fxws/g3m9u2A
         R1t7j/IU8NC2aXe0hNJNkVWD8DjnZwCXLAMgbO1mp3pVwWXELue+TS7T4ggIme8Qfy8P
         lNOg==
X-Gm-Message-State: AOJu0YyLcyMOOKhQtGG39IHXMEsz9+xj+Zc2PRBq7Il/GzynVKx8+KMe
	t/6oJcXUPrd7Mhgax508mWxcri/pXHH7765m1Zi8QkZaPJ6Haw5ntGWi
X-Gm-Gg: AfdE7ckeOobniqAZiTIH9Lz15O4gueELuWu19kt1e5Qktn9vGWvWZf8cqsO9o6Thv/i
	aGWMWfvKl19l80AvCDcEzY6eY4zrQr6vSFLydF+Y48GNai/3C0jrQfVtM7+QoJxYCJ+qq+2wdw4
	ZMtUbbtiJ55tQezbloAjzDBEIMitA4AuQX0VqyhQGrzyeTgd3P0TW1oBJLWzDAPaKJJaVTX1Lvt
	5Ik+jFQAn0jGBZLEJTtVNinzToOqTV/4FCXOapZp5sdFjYB4s0Ibjy2r7JawG4qFaIUHGxFkQi4
	qaw1uFzn4qbFb1s6cQXv2lp8kMFec7sKxGXE/ExBO42TNrpr8UEfItkvvPKbJ7o4IRGTF2Xsa5N
	92btxHvQa4As8jSPsa3Fafi/oC991B724vrs1ihtEagjoUaLwvOIx2YfLCh/eqZKG7MUsEJmd8b
	LR7B6jPO1BBi+rXI/4om/humsiiY5B8tfJyci5J9epyu4/Xa605rBXJASyRyQ=
X-Received: by 2002:a05:6000:186e:b0:470:7fdf:61fa with SMTP id ffacd0b85a97d-47f2dcf408amr498442f8f.38.1783721962995;
        Fri, 10 Jul 2026 15:19:22 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.204.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm64602353f8f.26.2026.07.10.15.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:19:21 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 10 Jul 2026 23:19:17 +0100
Subject: [PATCH net] selftests: netconsole: only restore MAC when it
 changed on resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netcons-mac-reload-v1-1-3fb1bcc70b4a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2oGkYHz8iriI6R0d0UQyVYTSf
 ze1y3O550xkqAqjYzdRxUdNS27gNx2lW8xXsA6NqXd9cDvvOGNMJRs/Y+KKR4kDS5At9kEO8EJ
 NfFWIfv/RE7U/ndfR3pc70rjkaJ5/dEvm9HsAAAA=
X-Change-ID: 20260710-netcons-mac-reload-f6f5e86f9e1f
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, matttbe@kernel.org, 
 Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783721960; l=1886;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=rMwXG/xzrygpew45ffALhZX5cO4JIo9QIeLG3lp+VJo=;
 b=SgBukk6tUV0LYwGEDip6kQYCMUZWS2uKsj3fj/4xPkk94B+G/72XHpkXzD4Vt7aVi2bxYhd4g
 n2GvezkO1utAhZo8Qpi+kgr5UbwLpMsMH/KBq/lvQVPqEqPc8fm185T
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306715-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,m:asantostc@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B9EF73F788

The "mac" bind mode reactivation downs the interface, restores the saved
MAC and renames it to trigger a target resume. This assumes the recreated
interface comes back with a different MAC, which is true under
MACAddressPolicy=none (as on the Netdev CI) but not when MACs are
persistent. In the persistent case netconsole resumes the target on its
own, and the down/restore/rename flow instead drops it and fails the test.

Guard the block on the MAC having actually changed so the test passes
under both policies.

Fixes: 6ecc08329bab ("selftests: netconsole: validate target resume")
Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Closes: https://lore.kernel.org/netdev/f398373e-2cb4-4649-a491-9763df94d98b@kernel.org/
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/netconsole/netcons_resume.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netconsole/netcons_resume.sh b/tools/testing/selftests/drivers/net/netconsole/netcons_resume.sh
index cb59cf436dd0..d9111f2102bc 100755
--- a/tools/testing/selftests/drivers/net/netconsole/netcons_resume.sh
+++ b/tools/testing/selftests/drivers/net/netconsole/netcons_resume.sh
@@ -44,7 +44,8 @@ function trigger_reactivation() {
 	# Restore MACs
 	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" \
 		address "${SAVED_DSTMAC}"
-	if [ "${BINDMODE}" == "mac" ]; then
+	if [ "${BINDMODE}" == "mac" ] &&
+		[ "$(mac_get "${SRCIF}")" != "${SAVED_SRCMAC}" ]; then
 		ip link set dev "${SRCIF}" down
 		ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
 		# Rename device in order to trigger target resume, as initial

---
base-commit: 1cd23ca80784223fa2204e16203f754da4e821f8
change-id: 20260710-netcons-mac-reload-f6f5e86f9e1f

Best regards,
--  
Andre Carvalho <asantostc@gmail.com>


