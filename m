Return-Path: <netdev+bounces-306524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qud9JADYUGqo6AIAu9opvQ
	(envelope-from <netdev+bounces-306524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:31:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F9073A43C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:31:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bOKSHxSg;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306524-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306524-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D19B30BBD6D
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB6D41C2FB;
	Fri, 10 Jul 2026 11:23:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B122411695
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:23:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682602; cv=none; b=aVwqOWXb7VwZA/SYyuodmF9M9439pjW99wG6Ri5YDmmD98MkiDv3Y1IesRbi64K/Nsk8QlVYW9tmciiV83jsgmmd98ONtB6wsZ3mERaNMzMe0g1Biz3YpnLMbVA/Gn70jCNYltOVEd/3YA2ZY/6/66wuG5mEBtx0Z5+FQb5iCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682602; c=relaxed/simple;
	bh=xtmbTd65LaYxw1rrR+/UJneXgCI1qTcmdy2s9dQ+T8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQdOnngG2MYdctH1Mmp1PajyLL37zvbqxCXHF1FKf+jT//OfVsuufVGYsc6LZlBJxPr3QwWl0Lg1bOJDRzBhBjRmOsvM/cLKIYSc7YDh0MqMeQQIaXD7EhSHqZ5EJF4eYBN/G74L+ybfXMiSu9QSa2Bc3oYAeR8gBBirUEw5eoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOKSHxSg; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783682590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1An98c98xItbXRfuoFzbd/aWjFu9Ub2ZC7pWnp2Ub+A=;
	b=bOKSHxSg748asHgn3f2r7FZYenKu87cjo2iwYGmtdYH0Ja0yMvTD39Lkz0Ep9ByDxuZ/1L
	OmMHLVhSpSck9NBoE5ZwwG0qgxBskq/hE374IUrs9ZRo24b6f1tO9ifekcCXnYc7feCDyb
	n1dCTQgAttIGnhqOw0byJIZyb14+dE0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-x4Nxs5kuPwSsUIfI0dGxsA-1; Fri,
 10 Jul 2026 07:23:07 -0400
X-MC-Unique: x4Nxs5kuPwSsUIfI0dGxsA-1
X-Mimecast-MFC-AGG-ID: x4Nxs5kuPwSsUIfI0dGxsA_1783682586
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3ADE1801376;
	Fri, 10 Jul 2026 11:23:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.56])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFA0B1800348;
	Fri, 10 Jul 2026 11:23:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Bongsu Jeon <bongsu.jeon@samsung.com>,
	netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: nci: Fix wrong size of status variables in nci_dev test
Date: Fri, 10 Jul 2026 13:23:00 +0200
Message-ID: <20260710112300.512433-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bongsu.jeon@samsung.com,m:netdev@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[thuth@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thuth@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9F9073A43C

From: Thomas Huth <thuth@redhat.com>

pthread_join() stores the thread's return value (a "void *", i.e.
8 bytes on 64 bit computers) into the address of "status", but the
"status" variable is declared as "int" with only 4 bytes. The extra
four bytes clobber whatever is adjacent on the stack, which could
silently corrupt other local variables. Use "intptr_t" to declare
the "status" variables with the correct size.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/nci/nci_dev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nci/nci_dev.c b/tools/testing/selftests/nci/nci_dev.c
index 312f84ee0444f..4e7a5856f7ea3 100644
--- a/tools/testing/selftests/nci/nci_dev.c
+++ b/tools/testing/selftests/nci/nci_dev.c
@@ -6,6 +6,7 @@
  * Test code for nci
  */
 
+#include <stdint.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
@@ -404,7 +405,7 @@ FIXTURE_SETUP(NCI)
 	struct msgtemplate msg;
 	pthread_t thread_t;
 	__u32 event_group;
-	int status;
+	intptr_t status;
 	int rc;
 
 	self->open_state = false;
@@ -497,7 +498,7 @@ static void *virtual_deinit_v2(void *data)
 FIXTURE_TEARDOWN(NCI)
 {
 	pthread_t thread_t;
-	int status;
+	intptr_t status;
 	int rc;
 
 	if (self->open_state) {
@@ -585,7 +586,7 @@ int start_polling(int dev_idx, int proto, int virtual_fd, int sd, int fid, int p
 	void *nla_start_poll_data[2] = {&dev_idx, &proto};
 	int nla_start_poll_len[2] = {4, 4};
 	pthread_t thread_t;
-	int status;
+	intptr_t status;
 	int rc;
 
 	rc = pthread_create(&thread_t, NULL, virtual_poll_start,
@@ -605,7 +606,7 @@ int start_polling(int dev_idx, int proto, int virtual_fd, int sd, int fid, int p
 int stop_polling(int dev_idx, int virtual_fd, int sd, int fid, int pid)
 {
 	pthread_t thread_t;
-	int status;
+	intptr_t status;
 	int rc;
 
 	rc = pthread_create(&thread_t, NULL, virtual_poll_stop,
@@ -816,7 +817,7 @@ int disconnect_tag(int nfc_sock, int virtual_fd)
 {
 	pthread_t thread_t;
 	char buf[256];
-	int status;
+	intptr_t status;
 	int len;
 
 	send(nfc_sock, &nci_t4t_select_cmd3[3], sizeof(nci_t4t_select_cmd3) - 3, 0);
@@ -860,7 +861,7 @@ TEST_F(NCI, deinit)
 {
 	struct msgtemplate msg;
 	pthread_t thread_t;
-	int status;
+	intptr_t status;
 	int rc;
 
 	rc = get_nci_devid(self->sd, self->fid, self->pid, self->dev_idex,
-- 
2.55.0


