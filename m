Return-Path: <netdev+bounces-280684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAIkDqjr6Wm2nAIAu9opvQ
	(envelope-from <netdev+bounces-280684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:51:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFA745007B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E83FC301DE6D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24E3E51CC;
	Thu, 23 Apr 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jK/n6907"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ABC1A3029;
	Thu, 23 Apr 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937314; cv=none; b=ezyqXS5OgA78zgOjvkADAJPsTX1Wez2Ys6ngyhLlP44WxLkt1xjMYybaYpm5NO3o8hx+n4XPe7R3LYUnFp5fOqFgpywYQK2SMLPwZMomaIj8CkJd4l3cJQhq8iBRiWrPase+qNDBGKe+wMKYTqWWfliIuHUe+VTVnaDSm4CohqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937314; c=relaxed/simple;
	bh=8x4At0Do1Cty9ND3pfccFdX93y605DyeVEobD7GXeIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vDCWvhx0iPHg7uJ+LMK4Zj1+NkBhknIBeWbb440uqdMZ+MB0/hY1YjQgTx9689rv5ChLvTToO3fHg+jbetu3zU5aemMD5tUUKWMmUqSIGWIueKOP3pYr/DXZytmdcvulSJsgi6SA6Cc5My7ZKOQ+ELyBW7BPKyDCBOK/cBct4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jK/n6907; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=TZRmeG+bR/YyfZlhGH05MuZ+5F0a4B1qU8O0L01XVj4=; b=jK/n6907M5fXF3wYR9usnwZb2C
	3mM/RLNoW0Sg+0v7ltEMfTkWc6qGUBwFeY+8ME4cmrab+eeHEhOWv/dfSHk4eK/GsYJcTEs6EmClp
	QyTM5IYdlO4GF3eIQ5oUROGp7olR17IJHOZF4OX1y44H5rDipghnyovV9Sn+OcD4FUykBuhWtbPYR
	dTGAfMDS/Y+TaVfFMS8DcF80iq9ZBvbi5oHLKmTngNzA+s+qu+PIGGtpztdjiVlpY/eqp1JPAXvzi
	OxwkJXsIye2DPWqlAklqmSBE8xVoOgYgaCY51AQn2/5p4ZffSDyfYE//2eX6k+vbHxX5SHL5/41SK
	K8nrKntg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wFqZC-002J3i-1I;
	Thu, 23 Apr 2026 09:41:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 23 Apr 2026 02:41:15 -0700
Subject: [PATCH net 1/3] netconsole: return count instead of strnlen(buf,
 count) from store callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-netconsole_ai_fixes-v1-1-92b8b7de9a2c@debian.org>
References: <20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org>
In-Reply-To: <20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Keiichi Kii <k-keiichi@bx.jp.nec.com>, Satyam Sharma <satyam@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wood <thepacketgeek@gmail.com>, asantostc@gmail.com, 
 gustavold@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=5252; i=leitao@debian.org;
 h=from:subject:message-id; bh=8x4At0Do1Cty9ND3pfccFdX93y605DyeVEobD7GXeIk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp6elU9B3p/s7nH8ntQXG9AoaqBeT/fsrIFrimx
 OaJLls3YRiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaenpVAAKCRA1o5Of/Hh3
 bfbuD/44XiPCG8w9x753hrFon9TF7n5y0z+MOGov18bIHTM45iFjxai2rXNoRt6eUCYUyN3C2r9
 Ya+DXRz8TT77xA3EbS+/K3Hktu99Z2f6V/vzgJsWSl74Ow9xuvPdLtap/NAkwsZu0j3h99iQkMi
 3/fdE3ekoCG9COb6VCB/3clptKHrkSKX5Q7U9+cj0ZhTblJqLFUOrt6kIr9ZCFiuuOA2DZ4+RVa
 XL0spbCnQf6aQAmCp3/YhPH2NxUEuyPW0cl8DoRS2M74Y5W58siT+4ok1iswv73JlN58qY2aBx/
 b1+S6OYzja1tAntfTK+syGmVoQkZzU0ac4Nic5cwrTgot+8WiYMfors1iILbofq2jqaDc84j/E/
 x002IriVtaqfrwgImS77cRyWWq0SANKO6dbw3s97v/SpWnRgoTbu7rQZNN4hqYVS+BHu9zL07Vh
 xsLTPN8hdCOpabpLf9eO+cr+W9JKcwyMvbQOiVOOAIw7VOhhbCW/zifnyyHbNeD2Lg2GXJHZ+cs
 iD98p8DElrOo7dDwLgF5gnAfgY+xtL4dl/aG6DHeLgkzyA9ZpXS/j9MnFxzsd57wf1t21IFf5gU
 iwITppAiAWtppwWNrsnbLek7cgF3PrWxVWil6aJAh+g5dv8tCiOhtQ2xgqX9c1Gdr2jATXS1cQu
 bX2QWq74vw8+1AQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280684-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CFA745007B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3c9acd6e49e86..5713cb3783ef2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -750,7 +750,7 @@ static ssize_t enabled_store(struct config_item *item,
 		unregister_netcons_consoles();
 	}
 
-	ret = strnlen(buf, count);
+	ret = count;
 	/* Deferred cleanup */
 	netconsole_process_cleanups();
 out_unlock:
@@ -779,7 +779,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 
 	nt->release = release;
 
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -805,7 +805,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 
 	nt->extended = extended;
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -828,7 +828,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	trim_newline(nt->np.dev_name, IFNAMSIZ);
 
 	dynamic_netconsole_mutex_unlock();
-	return strnlen(buf, count);
+	return count;
 }
 
 static ssize_t local_port_store(struct config_item *item, const char *buf,
@@ -847,7 +847,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	ret = kstrtou16(buf, 10, &nt->np.local_port);
 	if (ret < 0)
 		goto out_unlock;
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -869,7 +869,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	ret = kstrtou16(buf, 10, &nt->np.remote_port);
 	if (ret < 0)
 		goto out_unlock;
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -894,7 +894,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	nt->np.ipv6 = !!ipv6;
 
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -919,7 +919,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	nt->np.ipv6 = !!ipv6;
 
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -955,7 +955,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
 
-	ret = strnlen(buf, count);
+	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 	return ret;
@@ -1131,7 +1131,7 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 		disable_sysdata_feature(nt, SYSDATA_MSGID);
 
 unlock_ok:
-	ret = strnlen(buf, count);
+	ret = count;
 	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1160,7 +1160,7 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 		disable_sysdata_feature(nt, SYSDATA_RELEASE);
 
 unlock_ok:
-	ret = strnlen(buf, count);
+	ret = count;
 	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1189,7 +1189,7 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 		disable_sysdata_feature(nt, SYSDATA_TASKNAME);
 
 unlock_ok:
-	ret = strnlen(buf, count);
+	ret = count;
 	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1223,7 +1223,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 		disable_sysdata_feature(nt, SYSDATA_CPU_NR);
 
 unlock_ok:
-	ret = strnlen(buf, count);
+	ret = count;
 	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;

-- 
2.52.0


