Return-Path: <netdev+bounces-291676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE6FOymLFWrUWQcAu9opvQ
	(envelope-from <netdev+bounces-291676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 951785D53C5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 493B9306465C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E113F5BF1;
	Tue, 26 May 2026 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmXaG9YP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5862DECBA
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796413; cv=none; b=sc/wkqptGRCD2BBlUD/D3p3KVBUMtF6PH1Ib3NsAtVePQYNIRCReGibcJSW7nqVZ2VPfqwpsXTJKhg03rYY/c6A4b7AqH+gK6Sj+e3As2KbrKhN42KvSPUEcphUKGMTF+PPvaY4UkrzLrgfapri4KY0sB6OkrmezpQkxhVEimAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796413; c=relaxed/simple;
	bh=KjmpvAeajvE9YZ000KyjG8WJREg2SmwFqMZWNgAhdoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWoXBJh6x3md6Z78fiwLb2DQxjr64TW/1vz1z0i0AtFrVs5fzTvEOBk0Qr6wZFFBidkeFk9KWMmAf5LeCeooSKldQH2lRCPN3KHtEjXfw3BQmQkTxnX878SzKFX+Zcyjmj2WVpm5+a/RzG9G9ryQX/5llfWsXR+vUOJe+yuINCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmXaG9YP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779796397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UrR+gt5qD8VpIhaopEdRFyak3walqwuiDVZwivfSB+4=;
	b=KmXaG9YPpVyEX/cDuIAuaSEanAFxtuc5mjO24SbOdhhRTQNCd5WLZCQ7VdsbkOnJv0nUax
	FeQ3qhRzslGBTqL7Hy+GA6Tqwp74/Bw7ncTDFxlbKdMYulZP65wa7GoW8h9wnqjNFQ9YSQ
	22RGDLN58Ogo2gb07HO5LvBlyi4KhNQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-SCCnuH8rPD6W2Vfie-RP9w-1; Tue,
 26 May 2026 07:53:14 -0400
X-MC-Unique: SCCnuH8rPD6W2Vfie-RP9w-1
X-Mimecast-MFC-AGG-ID: SCCnuH8rPD6W2Vfie-RP9w_1779796393
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 570ED195605F;
	Tue, 26 May 2026 11:53:13 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.33.232])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84B321800352;
	Tue, 26 May 2026 11:53:11 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org,
	dsahern@kernel.org,
	stephen@networkplumber.org
Cc: ivecera@redhat.com,
	vgrinber@redhat.com,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next] dpll: man: restore Frequency monitor status in device show output
Date: Tue, 26 May 2026 13:53:09 +0200
Message-ID: <20260526115309.64850-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291676-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 951785D53C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dpll(8) merge of main into next (commit 62d1e70fa85a37 ("Merge
remote-tracking branch 'main/main' into next")) resolved the conflict
in the "dpll device show" output bullet list by keeping main's three
new entries (Supported modes, Phase offset monitor status, Phase
offset averaging factor) but inadvertently dropped the
"Frequency monitor status (enable/disable)" entry that was
introduced on next by commit 12954bc7d2c3 ("dpll: add frequency
monitoring support").

The frequency-monitor feature itself is still present (parser,
device-set documentation and pin "Measured frequency in Hz" line
are intact), only the corresponding bullet in the device-get output
list was lost.  Add it back so the listed attributes match what
"dpll device show" actually prints.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 man/man8/dpll.8 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index 74f4fdaa94eb46..92d4ead0010bc6 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -140,6 +140,8 @@ Supported modes
 Phase offset monitor status (enable/disable)
 .IP \[bu]
 Phase offset averaging factor
+.IP \[bu]
+Frequency monitor status (enable/disable)
 .RE
 
 .SS dpll device set id ID [ PARAMETER VALUE ] ...
-- 
2.53.0


