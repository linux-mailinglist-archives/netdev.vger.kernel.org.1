Return-Path: <netdev+bounces-302109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 53nhEL0lPmreAQkAu9opvQ
	(envelope-from <netdev+bounces-302109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:09:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7116CAD51
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:09:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=VqNt3WOT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302109-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302109-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4839730FE29E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2F3DC852;
	Fri, 26 Jun 2026 07:05:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971843DC4D8;
	Fri, 26 Jun 2026 07:05:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457508; cv=none; b=OXOK7x9stAeNjzZ4MdpoNgVxPCZKelizvTceHn12qF9bYOCK7yzcCAQN2Alpq6jYpiyySalyLpx1lrf03YokcDhUN6f1AnBIQ/Tc/U5SVvuB4DcuPbt80MKYi8K76OJ9rWTzNszDXlNvpqMsBhLSMViV6jPDCxb+uLxPvknEOoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457508; c=relaxed/simple;
	bh=RW1jPPYUb7bCu9ec/0Fv/4Q/N/7nYv7QouMskKa0t6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UpKakUm+t4JVd1LSdVvIGccrKDnEDgpiy3i4/9IlV0wnvoTT1uNiLWZa25gpnVRr3zx4FnUkabh26rVUfAp5/HN1A6Z1gJxPa7T/9jm3FMh/I6SdeJM4M/zfOYGEwnIZaiJA9Oi5QugQTfTdgg1fniuLONzNVS3t4ofhTOm2bvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VqNt3WOT; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6+
	fhL15IpXELWBk5X5Yj6nvB2KblT0bo0DI5mw+pYgU=; b=VqNt3WOTTzEg46+myV
	qEGM1V/jAIWA0OG52dQI20qc6XZ0nANoMyXXdrI+sBDZOkDHsNoQ/4BPZLubhZ3N
	d/Z9PvN+rSx8nbgb3SYYwkFW5UixLkpTXi/TzQdxBatrSkQNiiI38jCcloCT0FfM
	aJAYFc206obsV0QNpvsD0eVwc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXH_GKJD5qqPCwEA--.52186S2;
	Fri, 26 Jun 2026 15:04:43 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH v2] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
Date: Fri, 26 Jun 2026 15:04:38 +0800
Message-Id: <20260626070438.59149-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCXH_GKJD5qqPCwEA--.52186S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF18Jw1fJr1rKr4rAF43ZFb_yoW8ZF1xpF
	Z7K3y5AFW5Cr4jyan2yrsrW3W8u3WfGFW0krW293y5CFn8Xry2yFs2kFW2qwnrWrWrJr13
	AFn0qr15JFWDu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUrc-UUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzQxWy2o+JIx8MQAA3t
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302109-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:pabeni@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangyufeng@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[r4o5m6e8o@163.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r4o5m6e8o@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD7116CAD51

From: Yufeng Wang <wangyufeng@kylinos.cn>

The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
at argp, which is the beginning of the features array, overwriting the
data just written by copy_to_user(). It should start after the copied
elements at argp + copied * sizeof(u64) to only zero the trailing
unused space.

Use size_mul() for both the offset and length calculations so the
arithmetic stays consistent with the surrounding code and remains
overflow-safe.

Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>

---
Changes in v2:
- Use size_mul() for the offset calculation as well, per review feedback.

Link to v1: https://lore.kernel.org/all/20260526080336.61296-1-r4o5m6e8o@163.com/

Note:
Thank you for your review and suggestions.

I tried to add a switch in tools/virtio/vhost_net_test.c.
The switch is meant to use VHOST_GET_FEATURES_ARRAY and
VHOST_SET_FEATURES_ARRAY instead of the legacy versions.

However, when I ran `make virtio` in the tools directory,
the build failed with an error: missing asm/percpu_types.h.
I fixed that error, but then another error appeared.

Would it be acceptable to postpone the submission of
this test case until I have sorted out all the build
errors?
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 77b59f49bddb..4b963dafa233 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1784,7 +1784,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 
 		/* Zero the trailing space provided by user-space, if any */
-		if (clear_user(argp, size_mul(count - copied, sizeof(u64))))
+		if (clear_user(argp + size_mul(copied, sizeof(u64)),
+			       size_mul(count - copied, sizeof(u64))))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES_ARRAY:
-- 
2.34.1


