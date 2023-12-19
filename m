Return-Path: <netdev+bounces-58896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D264818877
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07521F23CAB
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0794918E1D;
	Tue, 19 Dec 2023 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDzT3YuH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281318E18
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702991899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8gCg7F2LD8ybUPGUCi7YjR3rBSf86+Mz8l1OEgEMuIY=;
	b=fDzT3YuHgZka8QNJpn9UG1wCv4r2CWW85+crQ1h+qdWkEBIeDJRBMelTqVkunF+uvhHb5E
	2XfAUM5v+YjjCpGQgssnTmJw3wrtglgml+rL6vheHhXW1mA8SUFvx0GtdnsbY1Zun0KcvE
	Pah3g7tKH19+Gm9T3CgZ6KBYO0GiFWE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-yrVAfHalNQS9rWMmGCJneQ-1; Tue, 19 Dec 2023 08:18:18 -0500
X-MC-Unique: yrVAfHalNQS9rWMmGCJneQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c62d9bd43so20007835e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 05:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702991896; x=1703596696;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gCg7F2LD8ybUPGUCi7YjR3rBSf86+Mz8l1OEgEMuIY=;
        b=dEw3DomuGYTgoitgkEOoTRDoxMXsGH8wpk00kHSbUqLnVmf7L3xdBoxyinYIgVGvCh
         EF9mZiQpjNmjqztO+jQJPMfrBa9myImnWTYnl+rktOTQMailAy94Bxb7590WvsF1Hs31
         SUWQzpbyDaZS3VH9U58vJmaWodRRhqFnrxJEjDl17AuXTIKD6uSZe12p0mFpK7BA3uQe
         L6zZyqyoeVBAWnVDxBORTMTcHfymDWmgEe1NNeJXVrikzThRYiHr70z2aLOJmEeOnlfE
         18mRk/awH4Yl8mNbueAqNdSlc2faQxARX1KCynCqvEbljiUX15s6OYa6eUi0oDZSWeOA
         dvpA==
X-Gm-Message-State: AOJu0YwXSGSmOnLkOgTzaPmg9YWIOswrc+HsZRkRtVmb0FeY9/x/9/y5
	nTV3/o92XJLfF7xuLOIjts90ILLLNn2TsMsE64lOTFgysWdUi87/Tnl7jjVYG2QQtxuR4dnbJfq
	O/ZQyCX9iE6wkp85oBKNC7PU+
X-Received: by 2002:a1c:6a02:0:b0:40c:619e:d117 with SMTP id f2-20020a1c6a02000000b0040c619ed117mr516104wmc.177.1702991896241;
        Tue, 19 Dec 2023 05:18:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPIuKtGBDlfRg/fdZjff/J3MI9cxEfDlIkXkOAXRmDa3dWozQdFrBGWUGTw20xVSzWKqOr3w==
X-Received: by 2002:a1c:6a02:0:b0:40c:619e:d117 with SMTP id f2-20020a1c6a02000000b0040c619ed117mr516092wmc.177.1702991895858;
        Tue, 19 Dec 2023 05:18:15 -0800 (PST)
Received: from debian (2a01cb058d23d600034751d9eeb3e349.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:347:51d9:eeb3:e349])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c359400b0040c440f9393sm2807931wmq.42.2023.12.19.05.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:18:14 -0800 (PST)
Date: Tue, 19 Dec 2023 14:18:13 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH iproute2-next v2] ss: Add support for dumping TCP
 bound-inactive sockets.
Message-ID: <ef4e0489be45f59ad05f05f5cae0b070255a65ef.1702991661.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Make ss aware of the new "bound-inactive" pseudo-state for TCP (see
Linux commit 91051f003948 ("tcp: Dump bound-only sockets in inet_diag.")).
These are TCP sockets that have been bound, but are neither listening nor
connecting.

With this patch, these sockets can now be dumped with:

  * the existing -a (--all) option, to dump all sockets, including
    bound-inactive ones,

  * the new -B (--bound-inactive) option, to dump them exclusively,

  * the new "bound-inactive" state, to be used in a STATE-FILTER.

Note that the SS_BOUND_INACTIVE state is a pseudo-state used for queries
only. The kernel returns them as SS_CLOSE.

The SS_NEW_SYN_RECV pseudo-state is added in this patch only because we
have to set its entry in the sstate_namel array (in scan_state()). Care
is taken not to make it visible by users.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2: Reject the "new-syn-recv" pseudo-state in scan_state() and add
    comments to make it clear that NEW_SYN_RECV is kernel-only and
    and shouldn't be exposed to users (Kuniyuki Iwashima).

 man/man8/ss.8 |  7 +++++++
 misc/ss.c     | 20 +++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 073e9f03..4ece41fa 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -40,6 +40,10 @@ established connections) sockets.
 .B \-l, \-\-listening
 Display only listening sockets (these are omitted by default).
 .TP
+.B \-B, \-\-bound-inactive
+Display only TCP bound but inactive (not listening, connecting, etc.) sockets
+(these are omitted by default).
+.TP
 .B \-o, \-\-options
 Show timer information. For TCP protocol, the output format is:
 .RS
@@ -456,6 +460,9 @@ states except for
 - opposite to
 .B bucket
 
+.B bound-inactive
+- bound but otherwise inactive sockets (not listening, connecting, etc.)
+
 .SH EXPRESSION
 
 .B EXPRESSION
diff --git a/misc/ss.c b/misc/ss.c
index 16ffb6c8..c220a075 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -210,6 +210,8 @@ enum {
 	SS_LAST_ACK,
 	SS_LISTEN,
 	SS_CLOSING,
+	SS_NEW_SYN_RECV, /* Kernel only value, not for use in user space */
+	SS_BOUND_INACTIVE,
 	SS_MAX
 };
 
@@ -1382,6 +1384,8 @@ static void sock_state_print(struct sockstat *s)
 		[SS_LAST_ACK] = "LAST-ACK",
 		[SS_LISTEN] =	"LISTEN",
 		[SS_CLOSING] = "CLOSING",
+		[SS_NEW_SYN_RECV] = "UNDEF", /* Never returned by kernel */
+		[SS_BOUND_INACTIVE] = "UNDEF", /* Never returned by kernel */
 	};
 
 	switch (s->local.family) {
@@ -5339,6 +5343,7 @@ static void _usage(FILE *dest)
 "   -r, --resolve       resolve host names\n"
 "   -a, --all           display all sockets\n"
 "   -l, --listening     display listening sockets\n"
+"   -B, --bound-inactive display TCP bound but inactive sockets\n"
 "   -o, --options       show timer information\n"
 "   -e, --extended      show detailed socket information\n"
 "   -m, --memory        show socket memory usage\n"
@@ -5421,9 +5426,17 @@ static int scan_state(const char *state)
 		[SS_LAST_ACK] = "last-ack",
 		[SS_LISTEN] =	"listening",
 		[SS_CLOSING] = "closing",
+		[SS_NEW_SYN_RECV] = "new-syn-recv",
+		[SS_BOUND_INACTIVE] = "bound-inactive",
 	};
 	int i;
 
+	/* NEW_SYN_RECV is a kernel implementation detail. It shouldn't be used
+	 * or even be visible by users.
+	 */
+	if (strcasecmp(state, "new-syn-recv") == 0)
+		goto wrong_state;
+
 	if (strcasecmp(state, "close") == 0 ||
 	    strcasecmp(state, "closed") == 0)
 		return (1<<SS_CLOSE);
@@ -5446,6 +5459,7 @@ static int scan_state(const char *state)
 			return (1<<i);
 	}
 
+wrong_state:
 	fprintf(stderr, "ss: wrong state name: %s\n", state);
 	exit(-1);
 }
@@ -5487,6 +5501,7 @@ static const struct option long_opts[] = {
 	{ "vsock", 0, 0, OPT_VSOCK },
 	{ "all", 0, 0, 'a' },
 	{ "listening", 0, 0, 'l' },
+	{ "bound-inactive", 0, 0, 'B' },
 	{ "ipv4", 0, 0, '4' },
 	{ "ipv6", 0, 0, '6' },
 	{ "packet", 0, 0, '0' },
@@ -5525,7 +5540,7 @@ int main(int argc, char *argv[])
 	int state_filter = 0;
 
 	while ((ch = getopt_long(argc, argv,
-				 "dhaletuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
+				 "dhalBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
 				 long_opts, NULL)) != EOF) {
 		switch (ch) {
 		case 'n':
@@ -5590,6 +5605,9 @@ int main(int argc, char *argv[])
 		case 'l':
 			state_filter = (1 << SS_LISTEN) | (1 << SS_CLOSE);
 			break;
+		case 'B':
+			state_filter = 1 << SS_BOUND_INACTIVE;
+			break;
 		case '4':
 			filter_af_set(&current_filter, AF_INET);
 			break;
-- 
2.39.2


