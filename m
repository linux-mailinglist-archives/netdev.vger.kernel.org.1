Return-Path: <netdev+bounces-306217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EvhyFw6bT2qZkwIAu9opvQ
	(envelope-from <netdev+bounces-306217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:58:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E79B7314FB
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:58:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dNpaFvnJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306217-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306217-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FD2230622F9
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE8224234;
	Thu,  9 Jul 2026 12:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4142217704
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:48:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601285; cv=none; b=WYYL+wtkFEcyjHaX+bwVS7ot2SJfg1tgnfAKqw6N4zhx3HhE6Of8PrSQubzFTz4Sg6GufqZWuQRrPRwIMglMeCWmiEMEpl15MIKbsKCCMSKey2dXF/7MpwnOziH+w5stLg3Knvabkr/FzP/WxFEgm+Bziu5V7mAhm4bcvp/16ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601285; c=relaxed/simple;
	bh=bkF4GfGRO2193VruODqTB0dP9e83z2vY/L1X+ODPWls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzLVI4ovE38G2/eRn+0Yl4scAIRbSlI3pMVQT+IDzlej40FR3dmlm/uRYEtnroPzFUP30tOzchuUJ7HlG0qWL9HGHQTAU+SgOSZ70KijpNigC8iX1zFpQpHdolKAdfnI+DCDyXOpal4rgn0HdA2xzdSfMfyWhs61kYilHQiwES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNpaFvnJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43751F00A3A;
	Thu,  9 Jul 2026 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601284;
	bh=Q6Mlt39Ut7sHqvigekvF3xBOxxRM0OiOteYZGDXWL9U=;
	h=From:To:Cc:Subject:Date;
	b=dNpaFvnJMBqT6xZavGOqvFGI+rtyz0gvUyTeqUpxZLVrteBo8qEpo+wntW0iycqcL
	 5m20eFAZW5lpy73qqK2fPxRqVuuvBLE1TBwqINoADe8W2S35svlLHFJtucofgxzwUu
	 cKDQT7eC9sU85Y5xFr+sr/2LQOqNj/PlCXIcLIn+mMnIUUDqlwC5L209RfScFziIjb
	 +6c1v0BlmTONTE9uaRrXLydxOJ1x/uVClatSmRSZNLaCHjpzwm6+zuvmZqnrMxz4iu
	 X+/rbW40c9cdPZ0y9FrknpYNsTx2IXsOb+GcM3N0Yabcv40qgTCSsOLX9MGH/IYfys
	 Ev/Nl/kyM3vxw==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] geneve: fix hint header definition wrt endianness
Date: Thu,  9 Jul 2026 14:48:00 +0200
Message-ID: <20260709124801.140632-1-atenart@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:atenart@kernel.org,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306217-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[atenart@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atenart@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E79B7314FB

Bitfields are packed differently depending on the endianness, take it into
account in the GRO hint header definition.

Fixes: e0a12cbf262b ("geneve: add GRO hint output path")
Cc: Paolo Abeni <pabeni@redhat.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260529144713.780938-1-atenart%40kernel.org
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 drivers/net/geneve.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 9afff7bcaa0b..b25b0c4de4d1 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -43,8 +43,17 @@ MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
 #define GENEVE_OPT_GRO_HINT_LEN		1
 
 struct geneve_opt_gro_hint {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 	u8	inner_proto_id:2,
-		nested_is_v6:1;
+		nested_is_v6:1,
+		rsvd:5;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8	rsvd:5,
+		nested_is_v6:1,
+		inner_proto_id:2;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
 	u8	nested_nh_offset;
 	u8	nested_tp_offset;
 	u8	nested_hdr_len;
-- 
2.55.0


