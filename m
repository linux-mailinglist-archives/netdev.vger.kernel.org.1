Return-Path: <netdev+bounces-258027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBW1BxWwimklNAAAu9opvQ
	(envelope-from <netdev+bounces-258027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 05:12:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ADF116DB5
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 05:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF39330060BB
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0651330F7E9;
	Tue, 10 Feb 2026 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWUK/2sj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76482F9D83
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770696720; cv=none; b=NMAJZzk9owiYtlJuzLbx7C0fgirfQrrVTJrTnyCOymO8bGkhiC4DR9HNUXTygckMELOInx1yg8JWRrki3W0wXv7b++a2fq8qusZAnhX/opIJGcP8RXFVpqJDZM6VsPqPX83R0uaY4HTWOKVRtXc8hVG1NGfnycZh+HPrWR2YVq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770696720; c=relaxed/simple;
	bh=TX5OH9yf6boJdIVgDFQizKukPtJYDByRCTLVX2NZtZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nhW8Q6tkYE4rZlERHC3ViIaP735G/vymGgOxkerq8yBlZ5Xp2y4llYnBtEfZYgDcnKzmbZ2W03Mfm0QkuwnHiLSNr75hPOopsvmjxaPQy5kUe39ucJAZPxbSgjZGj+eTbHtEB00tjeTQxRKdGX7ZS1XkKF/JKa8UUd2hBzvuFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWUK/2sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60BCAC116C6;
	Tue, 10 Feb 2026 04:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770696720;
	bh=TX5OH9yf6boJdIVgDFQizKukPtJYDByRCTLVX2NZtZg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WWUK/2sjoDbsJaIRt6HTipehR9g1JLruF6M9MS+I6HAjOHdWvjJKzUkRGnWHBIlh+
	 YtLNItnUc/VOCVK9GVEL7l+ze69E+SJ3Q1XPD9pe19CSVxQ11EhIcVOxf7MFAVbDKV
	 +ZgVeJdfj03n0L7pFesEiCEKsJBGMa/Yls4IA/ZnaRrsqI9E6yTSYdfOy38+epsk7L
	 aTpeX14nDaNi9HJKImzEEnuBCyCAe9D0KbNSo3QwooNzLzC4GjPwojewl/+WrI5wyZ
	 zFCLVFNzIxYCJ/6M0/BkC7R3xeZBgi9YY1lV1OfFAZLxhOIJ8tPwYj8BGV4qEJ55kp
	 qjgZx2YFrU6uQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5675AEB28F7;
	Tue, 10 Feb 2026 04:12:00 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Tue, 10 Feb 2026 12:11:48 +0800
Subject: [PATCH iproute2] ip/netns: avoid redundant mounts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-netns-redundant-mount-v1-1-0b1ebfc1c79f@black-desk.cn>
X-B4-Tracking: v=1; b=H4sIAAOwimkC/x2MwQoCMQwFf2XJ2UI3oIK/Ih7i5qk5mC5pK8Ky/
 27xMjCHmY0qwlDpMm0U+Fi14kPmw0TLS/yJZDqcOPMp85yTo3lNAe2u4i29Sx8UYb0fM2Q5K41
 2DTzs+/9eydYovYHptu8/5ghXWHEAAAA=
X-Change-ID: 20260210-netns-redundant-mount-aa2db50eac7d
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
 "Eric W. Biederman" <ebiederm@xmission.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2918; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=pkHF5Nk056iz6cX7ZPs/GUkucBvOzuk3aVzB4W2jRvY=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBpirAHQMZWwAJg+lOXcFdOw0Vc+e9dq2odQ1N2A
 KlGtoeX1LiJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaYqwBwAKCRB2HuYUOZmu
 i8bzD/sESGWezbpLhUYPgMmAgaQebzITr6zZqiftWUJDlCyt1gBMzBf+WaF7TzYkgndTQA0nao0
 YdGo9s+5oXoZz8qiL6y/8DQ/xc8bO2RpEwSivFn9CrOCnFw1qkKCg2QK5ZMgSaHUQh+h3i9lL/F
 Kg0J3ciGFS8rMkM5A2tffTZRIjrsrLckt06SVeJprJLQ7oC61Drz3slrL/WM3b8EVLCoFLU48YG
 IpeGXjHU6FaT8xmXQG55+X97/thilNG6TUCxkuSJTdpF//eeujoPRKG1eNUb/mVActlCVXZU6eT
 UKB9HV99V/wk1MveAJ6QVKxUEppBgREmxEPUqrVFTwTDf+8/6pgTk8E9+i2oA0lhzAW6T0QKA1o
 /XRRCtx8digBCXfKBvUubB4y+E3rWtBQFIqZyTLGirUkF9h6eY7lkn13zHghVkO0YBM+ERRLcHA
 c4m+JI4rSIsQFM5/y/ILZos8IeKai/ll4zHkdTKg09HGMJr/YfM3VKRw3EjW1mX3WaEa15DVWuy
 4bB6Px2jaXhZcnbkj+VO3g7v3ELz94lD1jSZ3R+KRnDS1fWM7ZUA9MPdspxUzFndT6FD9LoFM0u
 G63cH1bqFqNhjYPDpbmiUJArXNc3S5H/jWsdlo90WfizOsxGJ9DQc86lo8vhIYft9N9hRIvTy3E
 CT9i63tvyHdfFbg==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258027-lists,netdev=lfdr.de,me.black-desk.cn];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[me@black-desk.cn]
X-Rspamd-Queue-Id: 39ADF116DB5
X-Rspamd-Action: no action

From: Chen Linxuan <me@black-desk.cn>

On Ubuntu 24.04, I observed redundant mounts after adding a netns with
the commands below:

	sudo ip netns add xxx
	cat /proc/self/mountinfo | grep /run

Output:

	29 31 0:26 / /run rw,nosuid,nodev,noexec,relatime shared:5 - tmpfs tmpfs ...
	...
	203 29 0:26 /netns /run/netns rw,nosuid,nodev,noexec,relatime shared:5 - tmpfs tmpfs ...
	6443 203 0:4 net:[4026533578] /run/netns/xxx rw shared:917 - nsfs nsfs rw
	6444 29 0:4 net:[4026533578] /run/netns/xxx rw shared:917 - nsfs nsfs rw

There are two mounts (6443 and 6444) related to the "xxx" netns created
above.

This redundancy occurs because systemd changed the default system mount
propagation to "shared" since commit b3ac5f8cb987 ("mount-setup: change
system mount propagation to shared by default"). Consequently, mount
propagation of `/run` is shared.

Link: https://docs.kernel.org/filesystems/sharedsubtree.html
Link: https://github.com/systemd/systemd/commit/b3ac5f8cb98757416d8660023d6564a7c411f0a0

When `ip netns` makes `/run/netns` a mount point, a new bind mount (203)
is created and attached to the same peer group as mount 29. Since mount
29 and 203 are in the same peer group (shared:5), any mount under 203
propagates back to 29, resulting in the redundant mount 6444.

To prevent this, `/run/netns` should be placed in a new peer group. This
can be achieved by reconfiguring `/run/netns` to MS_PRIVATE first, and
then to MS_SHARED again.

With this patch applied, the redundant mount is no longer present, and
`/run/netns` is in a new peer group (917):

	29 31 0:26 / /run rw,nosuid,nodev,noexec,relatime shared:5 - tmpfs tmpfs ...
	...
	203 29 0:26 /netns /run/netns rw,nosuid,nodev,noexec,relatime shared:917 - tmpfs tmpfs ...
	6443 203 0:4 net:[4026533578] /run/netns/xxx rw shared:918 - nsfs nsfs rw

I also verified that mount propagation to containers remains functional.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 ip/ipnetns.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index a20cd8bc7cb8..3a33a3adacee 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -846,6 +846,20 @@ static int netns_add(int argc, char **argv, bool create)
 			}
 			return -1;
 		}
+
+		/* Reconfigure NETNS_RUN_DIR to MS_PRIVATE recursively and later
+		 * MS_SAHRED again to make sure it is placed in a new peer group
+		 */
+		if (mount(NETNS_RUN_DIR, NETNS_RUN_DIR, "none", MS_PRIVATE | MS_REC, NULL)) {
+			fprintf(stderr, "mount --make-private %s failed: %s\n",
+				NETNS_RUN_DIR, strerror(errno));
+			if (lock != -1) {
+				flock(lock, LOCK_UN);
+				close(lock);
+			}
+			return -1;
+		}
+
 		made_netns_run_dir_mount = 1;
 	}
 	if (lock != -1) {

---
base-commit: 72f679c0d07629fe9e462c2c52bbe48aaeaa7f83
change-id: 20260210-netns-redundant-mount-aa2db50eac7d

Best regards,
-- 
Chen Linxuan <me@black-desk.cn>



