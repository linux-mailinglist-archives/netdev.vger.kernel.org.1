Return-Path: <netdev+bounces-272891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AXJ6M1sgyWkDvAUAu9opvQ
	(envelope-from <netdev+bounces-272891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E14352053
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866C0300A8F0
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6A23603EC;
	Sun, 29 Mar 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmLqOMDT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A923A99F
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788696; cv=none; b=t139EdhTH4UROb2JiDg/aCqIGf2/pZ79AyxExJdVRxggPXmOD1NSu4iEDtFdLNECJxyybno5DD52ng021VUyNPWbn+GXjAnqTuOUsvOASgq7OnIe/HsKxFxvrxBQ25Rk1qJ+L0lD69GWMmqqKgz7aNBdpcuNmyWrQUderIF/FBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788696; c=relaxed/simple;
	bh=rQ5IgEx7vSEOACBcYD2az2IKo8vqUJCFsREwUTjrtW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZWBsJLOW6Ks4xKySSFmS/61JoaZdI0zxVXxjgclnWPWG/UkCa+Svq2a3rY8aSngmtph94nnCbW6XTlJ7/11qQSAto10aKV6wlkPVMbNmyA9wepQkk3MTT42KUQr4wysMh+Zrb+7nNYwEl8w0SNAkixA50ZxPEZf5GH7FnlvWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmLqOMDT; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c54c68db4dso841598eec.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774788694; x=1775393494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHrJ+YBkWKslJsnTGwRqOoIlf9dJU7ItmGu9dzV1w6M=;
        b=LmLqOMDTl0SbkrN/T8cIPmz+hrObPl8KnL3nuMj9ZFT+cZtYJ6H+Jd1gfJTzyU31P+
         jjD6Ads/I3FTdyDXipa1HfyyLOCob42jzl5i7F67B+imugNzu5o031fIXMv/1y8KUTY3
         PFVMXQ0fp2flUI0Rfuo+ITWg+OvrQeoYAqrS7cQYDyRLSsuVrCq3GJYp3a7LUVSlgBBq
         8mYZFmSGZ4uxgwE0bLAnGOgCVXwo/kpHv+kNjrv54uvuzY7qCq1oC2GPOev66cL2HnVl
         0rWfViI3fy39EYId8O1XHx6OGiObwbGQbBQwrhhw32PmP6G0hOu0qOl02Juo4JHNm/fl
         j58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774788694; x=1775393494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHrJ+YBkWKslJsnTGwRqOoIlf9dJU7ItmGu9dzV1w6M=;
        b=H4sL6iZbfOHh0bHRaCztG3DJBjw/JkYhJvExij/3CvNMzvGLsGNDAcgBY/0ch+YsIh
         aeop8qnDZGmFI4ixHKd8Uwy/AODhU3S/m6h9PDo3GwbdMVhQ7w53yGK1QQQKJbN0Opbb
         3WCSgbPbKb4koJnTOKCwWjHTneaxwYVazgnbIO8wFeuga3gWmHq8wSbidU8xksA6f5lQ
         5HaIDWTqlxAZJv8JhrGEjd04xa4Bfct6BJbR4pnqsbT7ajj0ubrjY+abdbxCLYnoTp4K
         5hpqNKVZUcetW80bxjBJg3m/9tq3MO0Pqpa1kWVd9YOtwb/Xg5wfPFyC/uMxydRnUTii
         MwYw==
X-Forwarded-Encrypted: i=1; AJvYcCWXdTFU/EgBmOclJowI3HE54PA3jP7HvyUxzz7563kiqM13Pk/8U0FCv4ng15n58ucZT24lGAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/euZ5FaP+aHKIvB18+5pcdt9CoLDBM9dkQAlqqMLATIGSqlr
	asqCYYbcPejCKFERr6+8MiAYBau7GN6yA0nIvXzjXs/MN6qGvm80AJkQ
X-Gm-Gg: ATEYQzwcqgwgFn2pUWfi12jQimdIjPCE1Q3FOlZK+e7xqlMdhh4mjwrcTMvi+aTvlOW
	aSTi8yM/y11jLF/SlZWr+Y64c8or7SkWE5JQkqT6AXVoNlmurqjyPqVg7dz9OOOkCBliSDeLMuw
	7l0XZRLHTMikaZ8IF2ojyu4rTjRgaAJFIalvc8ZFFUTX0Zs8xSIjCC6bgn2Y6kutzvaDKu08w4/
	Zv+ISW6jApgRQRiRAA4aTubOFgBYhh7GOXI/aT4ByCXy4IWVhgZbn3UWOxYbI7+w1NX/znuFYGc
	uBA6J31KdVG5+H+26DsZKPfAqHrXoC+If9qd8I/X/M4qPNc/Q8hETY+dsxQQN6W3UEIVqJf5qG1
	HJP5vNgd+vObVsl/JiMK+G3JxJOWUL4n4xZv8+KdJq5s0jVujOY9CTvENaxBIHobxjh2EiuJ6Xs
	xH48+4eXIR2gZqvvo5/T3PtghQLuOjbEbcc0U3zD+V9NUAWgM7fLdKLW6Y/RZBB4YaKNfA8qwsd
	cw0ZECnuU3vjLY9HY7jRYRQq6GypWgdpR2oJG/jbfjj/9eSrliatvkebC4rlnOTnGU=
X-Received: by 2002:a05:7301:1e86:b0:2c6:31f0:9fe9 with SMTP id 5a478bee46e88-2c631f0b2b3mr55002eec.28.1774788694146;
        Sun, 29 Mar 2026 05:51:34 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c41c1547sm4529655eec.7.2026.03.29.05.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:51:33 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Subject: [PATCH] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
Date: Sun, 29 Mar 2026 20:50:56 +0800
Message-ID: <20260329125056.1909087-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272891-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25E14352053
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bpf_prog_test_run_skb() derives skb->protocol from the Ethernet header
through eth_type_trans(), but it does not verify that the provided
linear input is long enough to contain the corresponding L3 base
header.

This can construct an inconsistent skb for test_run: the packet can be
recognized as IPv6 while skb_headlen() still only covers ETH_HLEN
bytes. In that case, helpers such as bpf_skb_adjust_room() may compute
offsets based on the inferred protocol and operate on bytes beyond the
initialized linear data, which can trigger KMSAN.

Reject such malformed IPv4/IPv6 skb test input early by checking that
the linear head covers both the Ethernet header and the corresponding
IPv4/IPv6 base header before running the program.

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/bpf/test_run.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..65cfb408f52b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1118,6 +1118,25 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	skb->protocol = eth_type_trans(skb, dev);
 	skb_reset_network_header(skb);
 
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (skb_headlen(skb) < ETH_HLEN + sizeof(struct iphdr)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (skb_headlen(skb) < ETH_HLEN + sizeof(struct ipv6hdr)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
+#endif
+	default:
+		break;
+	}
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		sk->sk_family = AF_INET;

base-commit: cbfffcca2bf0622b601b7eaf477aa29035169184
-- 
2.43.0


