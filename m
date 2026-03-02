Return-Path: <netdev+bounces-262742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CYsHgm/pWknFgAAu9opvQ
	(envelope-from <netdev+bounces-262742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:47:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A86461DD2C7
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD39B303B7C2
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E94421880;
	Mon,  2 Mar 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WWARWsAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CE218ADD
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469632; cv=none; b=e0fdafGKYbsPGKNyWNitwIUpTrDH2/nUj44h96ATz0aph6SnMuvh2gcrGgMVhmSMdGf3Pc+giRL0X9NITc+xP6ROiHmYyGXddDE6OKo/1WTY7VpTolUDgDJKbT656Je2lvKKtHEQRz5hL2P8p4pNzD/RROvy/oqSELUWGENx59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469632; c=relaxed/simple;
	bh=fjsc9vyZ19KtkwnKH8TjW0htsBZuXq/E0/oa7rIXL88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dk6vrji6kkUl2sWN8q0SuBiiinVOK+O7G3U7dN+avwsA3Jy71FP4G8sA2SvrwZEzKodWv8xFgTa8Yej+UlXLxBcjupW2Csvmz02xuMYj9dbexUZVsN4+gWT/ep5uTCQAsaZ/4aYnXnC2IztJKbwyMVwQU65IeXTcK964ROVaexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WWARWsAp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso4370416d6.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772469630; x=1773074430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DM9NFuWETcIWlEM/IPDNqxvAmEH49hmaVXstn1YxIuw=;
        b=WWARWsAppJJv5LwI7gW9FbNgFZmB8oy8BdeAJRisXfqFF8ACS1INCVGHKx2otfFnkg
         BRQqXx88HS0W+G6VW9D29orM63SaI53QJi/texs6SBa8tk2rGYRyRH4uVktygTr6zGxy
         j5BENM2TECn268cuvFTwxrdfMY9VIA7htapA8s2pYhMh9Imndfz5EY8hStfXt4pbUgap
         LL5I2MWAYLUZoQEhgYfpO3dB0xBElLzsEdWe/9jU5ewNoSKFTAvqbt3Q61nL4BpsTdho
         NQ/zj2Kqu0ykIQ9SH4b0A0hJL0c+ZIMh7xo+mzMTek1uP65h1MESpInzLGJ0yGphmENa
         7aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772469630; x=1773074430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM9NFuWETcIWlEM/IPDNqxvAmEH49hmaVXstn1YxIuw=;
        b=tgRUMGQOq0fi/+Nu67K9H9DdDOIUuIB5jTRku1wBpCr+R/CHtWOsqjyixPeMnCpJaO
         eQufT4+XuqR4Kh+b9R+vsga5RJ9r5EZipJwmY77y2aJFC41RM2bCeqfLwjYVi7e5NVBW
         adn2/dp0MhiTjp80FnMCKsqfqcW3vae/T3k9+cmf4Jgk8dLxDEta5wyqIbNDH+yjfoYG
         zGwqVGjR2wSfifL1BJKAz5y4KrL0KwLHrXpUxTHuCU2pnm+FjKtIYf7uS0fGAuAxikMs
         3qBAWaQ5NqPtG+qFHy7cDl9GcxRhmUXKd2lHIa15txiPN+E1hkh9ISXzcT/NTPlOdMwV
         On9Q==
X-Gm-Message-State: AOJu0YxwfjZ6jNc4BpXPn5s6ejQv8lu3X8YksdXXMfvzo6ho4VoEWPy0
	wAl/gXjb0rhORS0IzD5RVJEYicsFHuhhLCH/qUGoTXZEvALaMdlUuaDrQfMEKDuueD5QDtv+tmm
	SM9GxGa0=
X-Gm-Gg: ATEYQzzWax8YeXQ1MGzBPx9VL34h5tf6WVkQVnmrTGzNP83SXkt8cGT2o28GCREyrVF
	OCY5HwBZ+DpiO0rK95FLf++d0TjPrq3Xp5QO+YvZKo5lZpUO3zlp3T8y0CH7t7UJu7x1lV7f/Iw
	etzRuUEVtoAWt2d6qkNQTF4+aO68hpNSgjlQs0J+x2gkojSg1SBWDds3pslVjmH2fEOh337XavY
	7mBG7IEew5H55NCbqcDGvIKGj3ZZe7W1KR+RzMQufykGCbfX77pvT39fWB9n6XN1LiUOhBI6nzM
	gJx7Cn8XVqwCT+ghUUGX4jpU7sXAwiTPGyd1u+jJg2k2X8QrTFjyKB5tfKnWonHwzl0lBAbXoEd
	Hwl4H9qByFCaPe53kKaoaak/8SZ2WwML3h8kKNkaBEt6J/9iKYyyrxS3bsIpXlfWcpAiCbkdl5L
	Jy25PobkfrFZdCFfUuteB8+IYjWwLS5bzI3qfX54yis1xYXrNkagvev6HzluPs5g==
X-Received: by 2002:ad4:4ea5:0:b0:899:fab4:7301 with SMTP id 6a1803df08f44-899fab4752fmr65529336d6.35.1772469629891;
        Mon, 02 Mar 2026 08:40:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0684c1d2sm5180336d6.21.2026.03.02.08.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:40:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH iproute2] remove leftover references to /usr/lib/route2
Date: Mon,  2 Mar 2026 08:40:07 -0800
Message-ID: <20260302164026.112728-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A86461DD2C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[networkplumber.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262742-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Since commit 962692356a1c ("Makefile: use /usr/share/iproute2 for config
files") the path was moved to /usr/share in Makefile; but there
were leftover references.

Reported-by: Yedaya Katsman <yedaya.ka@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/utils.h | 7 -------
 lib/rt_names.c  | 5 ++++-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index e0a9c780..adf6a581 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -39,13 +39,6 @@ extern bool do_all;
 extern int echo_request;
 extern int use_iec;
 
-#ifndef CONF_USR_DIR
-#define CONF_USR_DIR "/usr/lib/iproute2"
-#endif
-#ifndef CONF_ETC_DIR
-#define CONF_ETC_DIR "/etc/iproute2"
-#endif
-
 #define SPRINT_BSIZE 64
 #define SPRINT_BUF(x)	char x[SPRINT_BSIZE]
 
diff --git a/lib/rt_names.c b/lib/rt_names.c
index 7dc194b1..3dba9642 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -208,7 +208,10 @@ rtnl_tabhash_initialize_dir(const char *ddir, const struct tabhash tabhash, cons
 	snprintf(dirpath_usr, sizeof(dirpath_usr), "%s/%s", CONF_USR_DIR, ddir);
 	snprintf(dirpath_etc, sizeof(dirpath_etc), "%s/%s", CONF_ETC_DIR, ddir);
 
-	/* load /usr/lib/iproute2/foo.d/X conf files, unless /etc/iproute2/foo.d/X exists */
+	/*
+	 * load CONF_USR_DIR/iproute2/foo.d/X conf files
+	 * unless CONF_ETC_DIR/iproute2/foo.d/X exists
+	 */
 	rtnl_tabhash_readdir(dirpath_usr, dirpath_etc, tabhash, size);
 
 	/* load /etc/iproute2/foo.d/X conf files */
-- 
2.51.0


