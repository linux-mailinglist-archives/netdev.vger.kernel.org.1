Return-Path: <netdev+bounces-300893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xw3oDJInOGrBYwcAu9opvQ
	(envelope-from <netdev+bounces-300893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 20:04:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699D76AB667
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 20:04:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eJlJYdUu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300893-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300893-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0732300A8F1
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373FF1F151C;
	Sun, 21 Jun 2026 18:03:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002C42050
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 18:03:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065039; cv=none; b=XrXWQK6CVLi5n26qX5ln9EE5MeM/IwaggfDqirPPzKXlSSKGe74AGSWNheDaxiYymwaiPUF72ohB/F7iY6vxcw6UWvUD/qyC1jn3R9i76qwZa3KBQZLS6fyH8PKmVDN03MvSflCStzgZt0wh0aRyIXuszrHEOlgyXXb6Y8UISYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065039; c=relaxed/simple;
	bh=nqTXG96TwicbWT2+ycxrvD2KdRK4W6MkNw8m3usCob4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdlsqN9LtuKArX4s/7VR5M7HESJObOr+WpElNFSFqjVXo64q0aajjbC4XprVfOZPo1ENrB1zU9J7U4B+so5VWcw6d3GLryp1u5prXBMcDMvsoM4vsTuyY3R8Bqf+CTYO0uD1HsR9+ae4cNM/eH3B/vIuPlc/SbvuuHs2LnxMIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJlJYdUu; arc=none smtp.client-ip=209.85.161.47
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69e1f777bcaso3238280eaf.1
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 11:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782065037; x=1782669837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+BhuQIQObpKBP/rKiRmJIu1e7WC00kVjrFFSWiSEAvs=;
        b=eJlJYdUuIKJX0SRR4QVZDkkDvKDTb0HR/3LRqdJq9dWlz4HzyMqj6ambg/sO9lVYSZ
         whGAT2lrtzJEFSRtpGVk/dWysG9WKGuVTLT2ThEulHUZpZPL0GE978MnXTWeZBqFjNZn
         5eA7rx0YodtnH4bEawz62JFVSpCx0E29+X+mdfNhAGYkx6dCnHtYSVyK1jHXszTD8mzV
         xK7WPI3k6eaZoRajGomE+ski2+BoRruiMw1vh263o7SRCC8MEzrfyWlCNfGSki6Finav
         uaJmY4qWOwhVi9tiQcn4F2+LPBFBx2oQLjGqdvmaWVEP7VhlbAtR4dPqPZgmK92vbmmX
         xuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782065037; x=1782669837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BhuQIQObpKBP/rKiRmJIu1e7WC00kVjrFFSWiSEAvs=;
        b=DY4RJ+g9JjguLF3I3URAI96ZX8njMdhI61lCf6mADnxQC+Q3JjYHCJ5DZ2yNwCGi7O
         xtOheWK7uQBkTFiwFU+3PX/Go93BSslTeNzX0F8I3KS03zsSsNQM4mQqjt9AsHgdeTjt
         9ZXdvMXFyWFjo6aq78FXaPKrEJS6dxypyhSJdtyO6Zz+qB7d053i8VyrTR0AiwM4agHK
         pvTDTr/L7ndQKUL2VVTCN5Jeu20ijGhsapS0UInXZIonmP2hpQL2ln9pEmrk+elwUh/+
         hAOx6qSoc878lUTwTtdj141FoFd8lRJUgvKsnDLojAmF9/hcwHQ7pprq0tQnQ4irY9wz
         J8rw==
X-Gm-Message-State: AOJu0Yx33PiYDhE5EsvWQy/VpHV+B3pDP6BU2kEHEyBQohsXsKaSo7OR
	D+CSu8tl2bzV9ekbDk57+TgCpYWxHzJBdrPIQ2N3MPL5YDL1NPXPU8O/3Lo1YALk
X-Gm-Gg: AfdE7cnkv8wsIPHJSkSXMLUsA5u9QJKuUW3tSglwK09aPe1D28Nm8vBr9IIP2K4/0qz
	Uv3tj9HwTTIM6xa+8aAJqwFO+vgsKtOba8h92t5KuxHemEWdrbfwW5MLN6lMcEr9jTWgdrBlAUA
	f6yFm1sL0I+WW7Ctfpt/CkN09Gz8tz9ToNeULjgO7oFHXLsR0S+wPxV0JKx0USp8+kQ+xJBJ+Y7
	ew0VlAEHvIsjNpkdoQ3SMbAm1DHtYA37TpIXCpXBEmfrikZrXGq8D/QRYCSOHAqSC9p1WBxWB5d
	+DgF2OLSYzMFGwh4VxsNUOs54KPr8ZVWKUl/xXSE26kkxcKC0Vpy6sgdfojTdMBFTjtXgSrP+wY
	AN2KfdwlbOQ9fFKThw+n9T3hZQJ5se2KBUhBrEQaWjbwIGgkvjnDXDvjaqCZGXU+94Cj8dI4X9j
	R2838DfHkVx97u2ob9fBYD0RFYbELgc/bQLA0x
X-Received: by 2002:a05:6820:81c3:b0:694:85da:3f92 with SMTP id 006d021491bc7-6a0da01ef3emr7382482eaf.17.1782065036942;
        Sun, 21 Jun 2026 11:03:56 -0700 (PDT)
Received: from 94d39335bfd1 ([147.126.81.13])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0475e3sm4338150fac.16.2026.06.21.11.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 11:03:56 -0700 (PDT)
From: Rose Wright <rosesophiewright@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	Rose Wright <rosesophiewright@gmail.com>
Subject: [PATCH iproute2] ip: return correct status from help command
Date: Sun, 21 Jun 2026 18:03:11 +0000
Message-ID: <20260621180311.8374-1-rosesophiewright@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[networkplumber.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300893-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosesophiewright@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:rosesophiewright@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosesophiewright@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 699D76AB667

Currently, "ip help" or "ip -help" always returns an error code because usage() is used as a fall through on "ip" and defaults to stderr with -1.

This is a minor bug that breaks "ip help | grep" and other scripts that rely on standard exit codes. The fix is to pass the status code as a parameter into usage() and change stderr to stdout when needed.

Signed-off-by: Rose Wright <rosesophiewright@gmail.com>
---
 ip/ip.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/ip/ip.c b/ip/ip.c
index e4b71bde..ee4595e8 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -52,11 +52,12 @@ const char *get_ip_lib_dir(void)
 	return lib_dir;
 }
 
-static void usage(void) __attribute__((noreturn));
+static void usage(int status) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(int status)
 {
-	fprintf(stderr,
+	FILE *out = status == 0 ? stdout : stderr;
+	fprintf(out,
 		"Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }\n"
 		"       ip [ -force ] -batch filename\n"
 		"where  OBJECT := { address | addrlabel | fou | help | ila | ioam | l2tp | link |\n"
@@ -72,12 +73,12 @@ static void usage(void)
 		"                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |\n"
 		"                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] | -a[ll] |\n"
 		"                    -c[olor]}\n");
-	exit(-1);
+	exit(status);
 }
 
 static int do_help(int argc, char **argv)
 {
-	usage();
+	usage(0);
 	return 0;
 }
 
@@ -279,7 +280,7 @@ int main(int argc, char **argv)
 			rcvbuf = size;
 		} else if (matches_color(opt, &color)) {
 		} else if (matches(opt, "-help") == 0) {
-			usage();
+			usage(0);
 		} else if (matches(opt, "-netns") == 0) {
 			NEXT_ARG();
 			if (netns_switch(argv[1]))
@@ -321,5 +322,5 @@ int main(int argc, char **argv)
 		return do_cmd(argv[1], argc-1, argv+1, true);
 
 	rtnl_close(&rth);
-	usage();
+	usage(-1);
 }
-- 
2.54.0


