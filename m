Return-Path: <netdev+bounces-281380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEaeHUF072kcBgEAu9opvQ
	(envelope-from <netdev+bounces-281380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:35:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFEA47478D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22A43048557
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6427FB1F;
	Mon, 27 Apr 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dOTuTZc1"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C272777F3;
	Mon, 27 Apr 2026 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300257; cv=none; b=CtysA6JEHrbZYTqxGTEmAEGH90pLiCYNy55pXjfkkvCnp/t2BmnCZLSZ6ss91PUH4c2aL5PdlPWGdLdgVywRMGHHKw3+EiHLxzPEDu7rJrWgmRVg5DSHp5WO2u+cVRbBZQ0iwgy0cNljWNdmw7qqLw3mZqPXdxCh9vZ13s8IBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300257; c=relaxed/simple;
	bh=rT7wv1OJRw4kOZrgDt+N6diYoUEjWWzAzeRJgzAKsNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PjPrrdForSZj0E68AYRpqMp1LKH5A2vdRV6LW/xw5isP6/Rmo1q+YtpjkBRs0LasZqNjIodTInze/cxZ703tvgcZrkSaVWwgyGMZe8xy7H5UnAlRYjuw9r0VjxgJn7imEGJN9qd0o3MMfMvoLt5LhrVExiBd5UHjvylzAgO7CyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dOTuTZc1; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=hkq35yjTpGqW8KKdFdXwyAd3IzepkaLH2TT1IS7RR0g=; b=dOTuTZc1AM4+HhYVQBaKascq5W
	3rN6KLP2/ViwAmHoyjhLYLiypncptspdgJ5/xAAov0eAKujGZUYsf3vFn4vxAPPPnhL1va2yCP4KF
	LNJa68AMJ1/I7ft7o1CbjaUt7ERXT6eyEH2jyQO7Z2yan55n4+VXAs8M3+J2l1PwjRL3wDONgYnGD
	wjxzW0hJhmWXcgL2EMOi30NQcezR/pq4ci0iUVaUEHKyAGm0ui0ZtkJDG0N9t/HyvNSbJWPNUppLM
	WJDhdSfrZAXsXNCvw1mvsy9vlsEHszDf6HA6nPoX8HvnpFNyp+pCKR/lYg1F6tfbxNhr2gZcoPyv8
	JYHb00sw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wHMz7-005Xwj-1o;
	Mon, 27 Apr 2026 14:30:53 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Apr 2026 07:30:35 -0700
Subject: [PATCH net v2 1/4] netconsole: return count instead of
 strnlen(buf, count) from store callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-netconsole_ai_fixes-v2-1-59965f29d9cc@debian.org>
References: <20260427-netconsole_ai_fixes-v2-0-59965f29d9cc@debian.org>
In-Reply-To: <20260427-netconsole_ai_fixes-v2-0-59965f29d9cc@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Keiichi Kii <k-keiichi@bx.jp.nec.com>, Satyam Sharma <satyam@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wood <thepacketgeek@gmail.com>, asantostc@gmail.com, 
 gustavold@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=5298; i=leitao@debian.org;
 h=from:subject:message-id; bh=rT7wv1OJRw4kOZrgDt+N6diYoUEjWWzAzeRJgzAKsNg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp73MSX3XfBkpiWAN/78kZDKbMhaq0dVxPxuNI0
 WOCIbaNodWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCae9zEgAKCRA1o5Of/Hh3
 bYDmD/9IKn+rqV33g7Ipr7hvsCvlOpetrCc3Rq0q6n+4JSBv+noyF0ZRyZML8NuYn2qYjEgE7eg
 Z+hbogsUmq4h6qqyOzgYWcvYN3TWWNtSKWUPyOemMkz4T9Ny8kGBs5LD7e5+EnY21Ia33tHxa9Z
 euZ5xElm0aFdYq12jofcRbCKrghBnKDv+K0FD5RyU/L9WxYUEEYXZR1iO5IZFPChahhclFoCCIr
 y/RfjmwReVDyJg8CaRTjfZvQOsvPLlQnpydlY4mGT/vx678+iyCi9qQLoqtu+E3IbRuMSswYcRN
 5ptLSMziv6yMlD26IDBbyEmZts2pvCpr/0XAcnqjeoloWoJX008pe/xPWu0VDNaTV0+jdybceKW
 z12MzdSUoVP9vA87u82/6JZTxt/J6u6oe9joI0jNTiyCz3HcMX84LppJ5BRvVYMchCQyZ2xkHPB
 ZgIfz+rrH6KVb5iEQ02gc1oC1qB9xtrKuDxJb6NuejdsUp1dRrP3ltmacbcI1XepqzRKCz+NGr1
 /U8rH3QdGjAOnfVncyvH2Qo0gW9ymgFAlgCmCjfTpfRXIcUfHxN06hIDxjGdgy4P1B4E2gAKQNm
 jamVqKeDcdSHFMTFpr7MGxnwTFlNq00KMsGdJGjxx+/ppFHqyKX4I4r4QOuD8GOJwERwUg3ihz+
 giDHEp2OC0MK+4Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 1EFEA47478D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281380-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Several configfs store callbacks in netconsole end with:

	ret = strnlen(buf, count);

This under-reports the number of bytes consumed when the input
contains an embedded NUL within count, telling the VFS that fewer
bytes were written than userspace actually handed in. A conformant
partial-write loop would then retry the trailing bytes against a
callback that has already accepted them.

Every other configfs driver in the tree returns count directly from
its store callbacks once parsing has succeeded, including
drivers/nvme/target/configfs.c, drivers/gpio/gpio-sim.c,
drivers/most/configfs.c, drivers/block/null_blk/main.c,
drivers/pci/endpoint/pci-ep-cfs.c, and the rest of the configfs
users. netconsole was the outlier (along with
drivers/infiniband/core/cma_configfs.c, which has the same latent
issue).

Align netconsole with the rest of the configfs ecosystem: return
count once the parser/validator has accepted the input. The numeric
and boolean parsers (kstrtobool, kstrtou16, mac_pton,
netpoll_parse_ip_addr) have already validated the meaningful prefix;
any trailing bytes are padding and should simply be reported as
consumed.

Fixes: 0bcc1816188e ("[NET] netconsole: Support dynamic reconfiguration using configfs")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 205384dab89a6..76d7fbf9e1883 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -752,7 +752,7 @@ static ssize_t enabled_store(struct config_item *item,
 		unregister_netcons_consoles();
 	}
 
-	ret = strnlen(buf, count);
+	ret = count;
 	/* Deferred cleanup */
 	netconsole_process_cleanups();
 out_unlock:
@@ -781,7 +781,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 
 	nt->release = release;
 
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -807,7 +807,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 
 	nt->extended = extended;
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -830,7 +830,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	trim_newline(nt->np.dev_name, IFNAMSIZ);
 
 	dynamic_netconsole_mutex_unlock();
-	return strnlen(buf, count);
+	return count;
 }
 
 static ssize_t local_port_store(struct config_item *item, const char *buf,
@@ -849,7 +849,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	ret = kstrtou16(buf, 10, &nt->np.local_port);
 	if (ret < 0)
 		goto out_unlock;
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -871,7 +871,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	ret = kstrtou16(buf, 10, &nt->np.remote_port);
 	if (ret < 0)
 		goto out_unlock;
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -896,7 +896,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	nt->np.ipv6 = !!ipv6;
 
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -921,7 +921,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	nt->np.ipv6 = !!ipv6;
 
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -957,7 +957,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
 
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -1133,7 +1133,7 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 		disable_sysdata_feature(nt, SYSDATA_MSGID);
 
 unlock_ok:
-	ret = strnlen(buf, count);
+	ret = count;
 	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1162,7 +1162,7 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 		disable_sysdata_feature(nt, SYSDATA_RELEASE);
 
 unlock_ok:
-	ret = strnlen(buf, count);
+	ret = count;
 	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1191,7 +1191,7 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 		disable_sysdata_feature(nt, SYSDATA_TASKNAME);
 
 unlock_ok:
-	ret = strnlen(buf, count);
+	ret = count;
 	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1225,7 +1225,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 		disable_sysdata_feature(nt, SYSDATA_CPU_NR);
 
 unlock_ok:
-	ret = strnlen(buf, count);
+	ret = count;
 	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;

-- 
2.52.0


