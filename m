Return-Path: <netdev+bounces-287181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP3lJyc9A2oq2AEAu9opvQ
	(envelope-from <netdev+bounces-287181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:45:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02332522D86
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5906C31BFDCB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F23998BE;
	Tue, 12 May 2026 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaQIleSe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290239A4B0
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593958; cv=none; b=JsBkTkPfSMUgCNuR0aIyBVM1eTiZPMyCYL21NHgznfbhNzD7jAJYZou8A4RwYH1QHaUoa9vzeE27jsbohs8+YSAPGokbYZoIm28RY8EugUT924fGBQ4AwrZzba6ZmfBd+oHvy94ezrkQ8tahSs6wUftnMeZt9On/xJIQSX0uEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593958; c=relaxed/simple;
	bh=Nwraq/5O5MDQq4IfSGzGqkP5vL4BUgaDHI+Io9WLuu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4GzYtPLSbzAkK67yjug4ufxxvjgm9HnHVp02M8g5p/fO05X8X0Zon1V9gjvXSr+qcuI6YNw35hj/2SelRVkZ56brRgjm7Kf5/jzFNNCGDO1n92/4mWC0FB95Jz1NaZaUx2nbBslhUyzjswinMkrdRgKbdSMTHFbDOcxSIQNdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaQIleSe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778593955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Py7d7WTO4Wg4qp7SNmGJsAvlx7I7iYmUQcga1ICSagQ=;
	b=PaQIleSeXNmHudIuAV6Ucgf++4P42Q+j9NMqOGRJDmHS2y+emdwT3qzNwWqI7dPrVC756b
	9HqhGlDgKaLTfPWuGdB2P3EG0LqtSdibTddcM63OcOaLHHk4vqU99NbVbARyxcDNisgMrx
	sHBckUI6+ZAjwrvlD8NSVV9uSiAB0hw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-ZtF9qN99P-WX9cipnejvRQ-1; Tue,
 12 May 2026 09:52:32 -0400
X-MC-Unique: ZtF9qN99P-WX9cipnejvRQ-1
X-Mimecast-MFC-AGG-ID: ZtF9qN99P-WX9cipnejvRQ_1778593951
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96C4E1955DE3;
	Tue, 12 May 2026 13:52:31 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.50.226])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EB2719560B1;
	Tue, 12 May 2026 13:52:29 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	vgrinber@redhat.com,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 1/2] dpll: align help and man notation with actual option parsing
Date: Tue, 12 May 2026 15:52:24 +0200
Message-ID: <20260512135225.167158-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 02332522D86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287181-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

dpll uses getopt_long(), which only accepts long options with the
"--" prefix.  The iproute2-wide "-X[name]" shorthand used in the
help text and man page implies a single-dash long form
(e.g. -Version, -json, -pretty) that getopt_long does not parse;
only -V/--Version, -j/--json and -p/--pretty actually work.

Replace the misleading shorthand with explicit "-V | --Version"
style so the documented forms match what the parser accepts, and
drop the redundant second usage line in help() that listed only a
subset of the options and implied dpll could be invoked without an
OBJECT.  No functional change.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 dpll/dpll.c     |  3 +--
 man/man8/dpll.8 | 12 ++++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index febf2a5d1fbdf4..81caa510078830 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -534,9 +534,8 @@ static void dpll_pr_freq_range(__u64 freq_min, __u64 freq_max)
 static void help(void)
 {
 	pr_err("Usage: dpll [ OPTIONS ] OBJECT { COMMAND | help }\n"
-	       "       dpll [ -j[son] ] [ -p[retty] ]\n"
 	       "where  OBJECT := { device | pin | monitor }\n"
-	       "       OPTIONS := { -V[ersion] | -j[son] | -p[retty] }\n");
+	       "       OPTIONS := { -V | --Version | -j | --json | -p | --pretty }\n");
 }
 
 static int cmd_device(struct dpll *dpll);
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
index c0d4b9caef2a6c..6b52970972f41a 100644
--- a/man/man8/dpll.8
+++ b/man/man8/dpll.8
@@ -27,9 +27,9 @@ dpll \- Digital Phase Locked Loop (DPLL) subsystem management
 
 .ti -8
 .IR OPTIONS " := { "
-\fB\-V\fR[\fIersion\fR] |
-\fB\-j\fR[\fIson\fR] |
-\fB\-p\fR[\fIretty\fR] }
+\fB\-V\fR | \fB\-\-Version\fR |
+\fB\-j\fR | \fB\-\-json\fR |
+\fB\-p\fR | \fB\-\-pretty\fR }
 
 .SH DESCRIPTION
 The
@@ -44,17 +44,17 @@ internal oscillators.
 
 .SH OPTIONS
 .TP
-.BR "\-V" , " \-Version"
+.BR "\-V" , " \-\-Version"
 Print the version of the
 .B dpll
 utility and exit.
 
 .TP
-.BR "\-j" , " \-json"
+.BR "\-j" , " \-\-json"
 Output results in JavaScript Object Notation (JSON).
 
 .TP
-.BR "\-p" , " \-pretty"
+.BR "\-p" , " \-\-pretty"
 When combined with \-j, generates a pretty JSON output with indentation
 and newlines for better human readability.
 
-- 
2.53.0


