Return-Path: <netdev+bounces-277318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKviM0PN2GktiQgAu9opvQ
	(envelope-from <netdev+bounces-277318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:13:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D84C3D57DE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9732F3005D19
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F368634EF0E;
	Fri, 10 Apr 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WWeb5eP5"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E19A3803E5;
	Fri, 10 Apr 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815648; cv=none; b=fPA6OOfJt3drD4o1J+1mlznRQj9h/XKjKWZ0fNNjb61qkuRaC7mHTk+JVowX309b1lhe6oF0Q/hg4jVTdeiLSDqX7c6j7Z8mVImkVFsp8iCc59Q3oGZk5zjUVVESoVsWCONkn0tDIW7Df1ZZ6sPNMvJ9E4FEC3ttpqhUU3crSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815648; c=relaxed/simple;
	bh=HHfWaKwmgAaMOBkG75Ukc+yPMficBnCMFRcj8E2oJZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:Message-Id:
	 Content-Type:MIME-Version; b=ai+Z0SFjm8f7aXEZwp2JMpdVTTc5b6RbN4hA4xm9wVWZHPC4ScxAOIRc3Vm0wLL67tw2TcZfLBz/9GHuwN4x2/Wo1bIteV6dAFv4Bx6w6FtlDEla+aWQyw2gnAtp2b/v9pguw4MpX8aRUJpeUyYOXVbV0xurGqxh0YRYiEKDLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WWeb5eP5; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:To:Date:Message-Id:Content-Type:
	MIME-Version; bh=pQ/iVIlWAwTAhCIlzfMqmmXFE+HOy7fOmkysX4oZXn4=;
	b=WWeb5eP5ikYECg6L8n7TF8th2VqvFfmF/dbaE+j5YyA/7ofiOOVOq9HxawNORo
	gyUD3Y6K0OOWU26mYvMWeV25bKQC8iU30ttqo+dw+vdpvpTQjrxKer8L4R8ZEX09
	zQokb0FHOTvpWRAXi9SFxJtIa9rNaT04hJPBnSVl/hunU=
Received: from 229.199.16.172.in-addr.arpa (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBnTUHEy9hpGMVIEQ--.28660S2;
	Fri, 10 Apr 2026 18:07:02 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
Subject: [PATCH v3] selftests: vsock: avoid races creating Unix socket paths
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Stefano Garzarella <stefano.garzarella@gmail.com>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260410035237.59644-1-create0818@163.com>
References: <20260405195733.86043-1-create0818@163.com>
 <20260410035237.59644-1-create0818@163.com>
Date: Fri, 10 Apr 2026 18:07:00 +0800
Message-Id: <177581562073.13887.468247298173578281@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:_____wBnTUHEy9hpGMVIEQ--.28660S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF1kKF17XrWUJF1xXF4rGrg_yoW5AFW7pF
	yFqr4ktr1fCF1avF1xCw4UGryFgFs8JF47XwsrZw1jyr47Krn7Zr4xtFn8X3Z8WFs3XrWr
	uayvgFZ5ZF18KwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTa0QUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCwAa07WnYy8ZPYwAA3P
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277318-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,meta.com,lists.linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[create0818@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[163.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D84C3D57DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmtest.sh currently uses mktemp -u to precompute Unix socket paths for the
namespace bridge helpers. That only returns an unused pathname and leaves a
time-of-check/time-of-use window before socat binds or connects to it.

Create a private temporary directory with mktemp -d and place the
socket path inside it instead. This removes the pathname race while
keeping cleanup straightforward.

Signed-off-by: Cao Ruichuang <create0818@163.com>
---
v3:
- restore the missing patch description
- add Bobby Eshleman to Cc

 tools/testing/selftests/vsock/vmtest.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886b3..c345fa539d3 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -718,6 +718,7 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
 	local pids pid pidfile
 	local ns0 ns1 port
 	declare -a pids
+	local unixdir
 	local unixfile
 	ns0="global0"
 	ns1="global1"
@@ -736,7 +737,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
 	oops_before=$(vm_dmesg_oops_count "${ns0}")
 	warn_before=$(vm_dmesg_warn_count "${ns0}")
 
-	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
+	unixfile="${unixdir}/sock"
 	ip netns exec "${ns1}" \
 		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
 			UNIX-CONNECT:"${unixfile}" &
@@ -758,6 +760,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
 
 	terminate_pids "${pids[@]}"
 	terminate_pidfiles "${pidfile}"
+	rm "${unixfile}"
+	rmdir "${unixdir}"
 
 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
 		return "${KSFT_FAIL}"
@@ -814,6 +818,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 	local ns0="global0"
 	local ns1="global1"
 	local port=12345
+	local unixdir
 	local unixfile
 	local dmesg_rc
 	local pidfile
@@ -826,7 +831,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 
 	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
 
-	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
+	unixfile="${unixdir}/sock"
 
 	ip netns exec "${ns0}" \
 		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
@@ -845,7 +851,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 	if ! vm_start "${pidfile}" "${ns0}"; then
 		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
 		terminate_pids "${pids[@]}"
-		rm -f "${unixfile}"
+		rm "${unixfile}"
+		rmdir "${unixdir}"
 		return "${KSFT_FAIL}"
 	fi
 
@@ -862,7 +869,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
 
 	terminate_pidfiles "${pidfile}"
 	terminate_pids "${pids[@]}"
-	rm -f "${unixfile}"
+	rm "${unixfile}"
+	rmdir "${unixdir}"
 
 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
 		return "${KSFT_FAIL}"
-- 
2.39.5 (Apple Git-154)


