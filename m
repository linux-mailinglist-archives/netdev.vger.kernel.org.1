Return-Path: <netdev+bounces-128524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B1897A219
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4ACB24279
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456E154BF5;
	Mon, 16 Sep 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="bnS+h/EV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088E154423;
	Mon, 16 Sep 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489388; cv=none; b=JSQ4YQ2+1cVXYMaGOZv4oQf2ambndT+E+tfsbXnHy9LMANJJ95FDOuGnxGHewL/h5Ux8Bh+n3pw80WPDN66mOLqARTx/pWHjaP5HB7keflKINShLaZOT3IoNkjsniz+bGbYzSVpCfhH2S/HSgP6Rt8QtbKBE9OccMp95/xSAihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489388; c=relaxed/simple;
	bh=XhhH5JTAOwmpDbnqPFnomF2y96t11dWpqCZt2RjGRaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FL3wuAlW/uvX1EpVma1+RfI/ViuM5pKQlLJ6iBD7FZJP9Og6ug/W0pwIcCmsdqRNXcXRQ8B1U8Yf0NN4uaBMcinfpHhhWuK68MCsJRyjCCPiva4V/fdHp4K2KS6pHFwDZFCtpBRFMpTuLtCd5RNhB1OR1fEavwTxQCwU3aKa9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=bnS+h/EV; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1726489376; bh=XhhH5JTAOwmpDbnqPFnomF2y96t11dWpqCZt2RjGRaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnS+h/EVDMCY4SceoEKBElQ2pd5WEklfXLLUkZtvXtsfLrsCJpLll3VbRw3nr+yTC
	 4rNRfBOS7XD1stL8B10bk4iGnWp89p0WYmAetEFZyEtlIOXp/PXUgloYhlky7A7bTD
	 I7xXMfwFIS60xoN6Hz0fx1HCSujwM6R+VQkIPXhwmiltJJeB4V4prmvMdBqPDwcpGu
	 VemSFlDVH2XRp2lAEbfYyl+lZBGUDzVpz2SZVZpIybuaNkDcDkX38w0QRspqqAEV8Y
	 f5t9GXZAMmk47QoiRllWvKKFtHlpvWOHxYr5J8+LHiTR5ZHF7A3dWtlMUEObKQhWHH
	 LLuwCeQEf0hJw==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 24B6A1230C2;
	Mon, 16 Sep 2024 14:22:56 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v1 1/7] samples/landlock: Fix port parsing in sandboxer
Date: Mon, 16 Sep 2024 14:22:24 +0200
Message-Id: <20240916122230.114800-2-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240916122230.114800-1-matthieu@buffet.re>
References: <20240916122230.114800-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike LL_FS_RO and LL_FS_RW, LL_TCP_* are currently optional: either
don't specify them and these access rights won't be in handled_accesses,
or specify them and only the values passed are allowed.

If you want to specify that no port can be bind()ed, you would think
(looking at the code quickly) that setting LL_TCP_BIND="" would do it.
Due to a quirk in the parsing logic and the use of atoi() returning 0 with
no error checking for empty strings, you end up allowing bind(0) (which
means bind to any ephemeral port) without realising it. The same occurred
when leaving a trailing/leading colon (e.g. "80:").

To reproduce:
export LL_FS_RO="/" LL_FS_RW="" LL_TCP_BIND=""

---8<----- Before this patch:
./sandboxer strace -e bind nc -n -vvv -l -p 0
Executing the sandboxed command...
bind(3, {sa_family=AF_INET, sin_port=htons(0),
     sin_addr=inet_addr("0.0.0.0")}, 16) = 0
Listening on 0.0.0.0 37629

---8<----- Expected:
./sandboxer strace -e bind nc -n -vvv -l -p 0
Executing the sandboxed command...
bind(3, {sa_family=AF_INET, sin_port=htons(0),
     sin_addr=inet_addr("0.0.0.0")}, 16) = -1 EACCES (Permission denied)
nc: Permission denied

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e8223c3e781a..a84ae3a15482 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -168,7 +168,18 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 	env_port_name_next = env_port_name;
 	while ((strport = strsep(&env_port_name_next, ENV_DELIMITER))) {
-		net_port.port = atoi(strport);
+		char *strport_num_end = NULL;
+
+		if (strcmp(strport, "") == 0)
+			continue;
+
+		errno = 0;
+		net_port.port = strtol(strport, &strport_num_end, 0);
+		if (errno != 0 || strport_num_end == strport) {
+			fprintf(stderr,
+				"Failed to parse port at \"%s\"\n", strport);
+			goto out_free_name;
+		}
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				      &net_port, 0)) {
 			fprintf(stderr,
-- 
2.39.5


