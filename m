Return-Path: <netdev+bounces-288786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 77WsKd5ECmprygQAu9opvQ
	(envelope-from <netdev+bounces-288786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:44:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3BA564344
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44CE330067A8
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86F330B28;
	Sun, 17 May 2026 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="mZqUhPq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9F302753
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779057882; cv=none; b=YrrSbbCSlj3YON/96kmmuFHYMqv+Nqq7TOwRs1Ns/V3H0KOmvTgvz96f68QvVc0Q30T24Z/69fE1M9YrbpKUchBRAqWFQk7xP13yxyp5uCKwxgA73Yd1IFULK2R4b4FS+pUYQ9vF4AEXSm2ai4IjI+m026DS44UIShJYv0duHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779057882; c=relaxed/simple;
	bh=02wpFiJeH5kYYp1HHxt4KWdt6ETCTBYwpOzaF81A0dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYGU8oH/SFIcWhd6G2J0f+mDBRY5rwQVxiBGSplJryA+vdTzzvdBjqVajZoHfrBpkRL1vF2B7Rj4ZYxaJHSJTLgAVPwIz9Pfy+TMxzrDUa22I6NzyMOVvhT4IJ59u3TzTXpR5R4chlDKg+6fGvQfQ9dwfhVIX8JpVu/+Lh9ymZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=mZqUhPq4; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso1290970eec.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779057880; x=1779662680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1ayTVD/Q0qC/3pKC3zpho9UU3KuxGY9jFZpz9NhE6s=;
        b=mZqUhPq4pCfwO0SanWsbepaNOm5r1hMImeVvoj7igIUVOf6G3cFmHFe52QeDWatZ6c
         0kzd74C5BYtk6gxkn/LDn8fhP39h3+TnZ/tvRXJ0/2Q4now/5ZewBYFKSrrue/nzS7/5
         B0QQHPlWx6CPZqVwyCFlV68nm0Wh3QZXcvYpCwa+bpJRFuu1box9OQZdUXj6mEhee9Dm
         72b/NgqSDbmxGLDxWvkQ/xKalzfmq17b7cvnCq6xMiPsYwK6jewWDm7nHCgn1MwVzITv
         QsbrAw3fGX5wzV8slHQyjtBWO1cqOJWLaaHtFHm1BYPn4KzCqRm0n2v+TF493zEsNaRt
         fPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779057880; x=1779662680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1ayTVD/Q0qC/3pKC3zpho9UU3KuxGY9jFZpz9NhE6s=;
        b=bLrvNbNlmjZH4+8fEujFAYy6W5jp7txNffm5Dl3BW01LFOGcTedjsPeH1Y9ItLQWQK
         HiCH+b9/r+/fMmhPO1ELyuQ5QmGCFn3DVAiAeULkyi/I1X3L1hS+05Cqwn/2NknDE1OU
         A1J5YZROw8wxaswzz2ED4Rj6vGDPnAYc3By+kcGc9tXQ4Qs0J22/wyuSBj5q3ud2fP3v
         +TH+bmtRVdS3afACGwxYgtKHJtzgnhbIdknSRfmYU2Bn+HOp34pvJLleS7pE+8KF2k+6
         deuRHCZ+wea3yPfS7CO7knmaF3R7Mp0RG6g6B4UpMs3U5LMID5LxbXXbKGkEnXN6OWYb
         0gOA==
X-Gm-Message-State: AOJu0YwDHx8bTyrZZ203Ug5dcUqlc7/7GWcG94X7C6SiXyFaQQbLZpGC
	ZMtROKAomVzZikgSqAHvKvgx1SznbmWpklJdAMas4MBHGZar6mEI9siVfkT41fFwsmuiUI871R5
	we+WNNWk=
X-Gm-Gg: Acq92OED5gLdMd6nO4gk5f4qyViIvIyOrwRHAlKrMRc09Oru7oRgSPTMyqL8djdRHma
	xFQUXC7yGiXlrbSRX97YQbZnwQwNdLvSZ+ebecm492pbi+iu4TnrK5Fe8B08hA2k6Y3dihpwyXc
	S2g8WkDqnTWY6BKasWCoGphN6IoahisWhKQwdEiOf+vz4zhFLdXMoVWrJgAcYswKsGcGgP4rmKR
	zB8fgjF8oxQOTL9MVALbP7uWvsl9HcgxvfsD1LB3ka04owtSt2Dny9+h7T/bfOL7FzRPFhsNWsz
	WEAg/m2c3QuMbEKsq0I+tXW7x0pYtvwdlk8+T0+RKbfXyq7B2v7+d1Lu0DGoBqnwczbfqHU3Gh9
	e2YL1nhIIguvq4/no217nAPRc+d+2ViTNCIm7OwmzTypIN+M8NTaf+ZhRrofYrl2ZZX2O0A9yh1
	YXLNVYC2VdLxh7BJMAiWrQ9hDLnOof1N24
X-Received: by 2002:a05:7300:cb15:b0:2da:44ac:6d17 with SMTP id 5a478bee46e88-30398655327mr6426971eec.17.1779057880321;
        Sun, 17 May 2026 15:44:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc9d4sm12280249eec.23.2026.05.17.15.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 15:44:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Christian Iacobellis <Ciacobellis@agea.com.ar>
Subject: [PATCH iproute2-next] routel: handle errors from ip command
Date: Sun, 17 May 2026 15:44:37 -0700
Message-ID: <20260517224437.164919-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF3BA564344
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288786-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,subprocess.run:url]
X-Rspamd-Action: no action

When ip exits non-zero, routel crashed with a JSONDecodeError traceback
on top of ip's own diagnostic. Use subprocess.run with check=True,
propagate ip's exit status, handle a missing ip binary, and wrap the
JSON parse so malformed output gives a clean message.

While here, send diagnostics to stderr and drop the assert-as-control-
flow (stripped under python -O).

Fixes: 6d676ad93408 ("ip: rewrite routel in python")
Reported-by: Christian Iacobellis <Ciacobellis@agea.com.ar>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/routel | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/ip/routel b/ip/routel
index 09a90126..51b02d21 100755
--- a/ip/routel
+++ b/ip/routel
@@ -13,7 +13,8 @@ import subprocess
 
 def usage():
     '''Print usage and exit'''
-    print("Usage: {} [tablenr [raw ip args...]]".format(sys.argv[0]))
+    print("Usage: {} [tablenr [raw ip args...]]".format(sys.argv[0]),
+          file=sys.stderr)
     sys.exit(64)
 
 
@@ -23,7 +24,7 @@ def main():
     try:
         opts, args = getopt.getopt(sys.argv[1:], "h46f:", ["help", "family="])
     except getopt.GetoptError as err:
-        print(err)
+        print(err, file=sys.stderr)
         usage()
 
     for opt, arg in opts:
@@ -36,14 +37,29 @@ def main():
         elif opt in ["-f", "--family"]:
             family = arg
         else:
-            assert False, "unhandled option"
+            raise RuntimeError("unhandled option " + opt)
 
     if not args:
         args = ['0']
 
     cmd = ['ip', '-f', family, '-j', 'route', 'list', 'table'] + args
-    process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
-    tbl = json.load(process.stdout)
+    try:
+        result = subprocess.run(cmd, stdout=subprocess.PIPE, check=True)
+    except FileNotFoundError:
+        print("{}: ip: command not found".format(sys.argv[0]),
+              file=sys.stderr)
+        sys.exit(1)
+    except subprocess.CalledProcessError as err:
+        # ip has already written its own diagnostic to stderr
+        sys.exit(err.returncode)
+
+    try:
+        tbl = json.loads(result.stdout)
+    except json.JSONDecodeError as err:
+        print("{}: cannot parse ip output: {}".format(sys.argv[0], err),
+              file=sys.stderr)
+        sys.exit(1)
+
     if family == 'inet':
         fmt = '{:15} {:15} {:15} {:8} {:8}{:<16} {}'
     else:
@@ -54,7 +70,7 @@ def main():
     print(fmt.format(*map(lambda x: x.capitalize(), keys)))
 
     for record in tbl:
-        fields = [record[k] if k in record else '' for k in keys]
+        fields = [record.get(k, '') for k in keys]
         print(fmt.format(*fields))
 
 
-- 
2.53.0


