Return-Path: <netdev+bounces-55885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282CF80CB18
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455ED1C2074F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEA23F8CD;
	Mon, 11 Dec 2023 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb3+BDCr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F62C3
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 05:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702301720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=jNziMLx57EjcwsIJrIt7+O6Bdq0QWKhnNrRII4HQrZ8=;
	b=Wb3+BDCrrurjGhdtpncdQIR5eJBJq0WtGNP3IdB5VLjC/oWh2RU+vDQtRw2Lr5NYnJOk3Z
	Qo4x5q6QqwA1YUS6gLosNd/pFnY95MbADLquJD1T/zXGJ7AAGFOEo78p64HIcHtDKZqIym
	4phtmTEzZmlvIEtly5IrU5hfP1qG7v8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-RVpql-30NJqGvjgeGy14HA-1; Mon, 11 Dec 2023 08:35:19 -0500
X-MC-Unique: RVpql-30NJqGvjgeGy14HA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40a4c765d3bso22060485e9.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 05:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702301718; x=1702906518;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNziMLx57EjcwsIJrIt7+O6Bdq0QWKhnNrRII4HQrZ8=;
        b=T96pYOLIYczdhDi4XeGN3fxxSLfFnND2RYe93fnzqWqneGXjt6w2YWiXUKnSo6M/nR
         YeYOvXSyl0OmJBRKU7OPGSy03hAUicScm5ESjMya2IQ0Soo9o2Ov0/+8bLhsKs0s8gQ6
         s7iglBXtsVJWNXQZmhNFYZvk1P/U2mRe8FFyMFdh9p62ZI7precEg2CBZU7477wNCJlq
         Dk2QRz1yVzyUqGaIrzcQLCwOooKrvRwyy5SGcn3LkCB0NVvwDqg199wyTp6B3L9sOSeP
         Unw5yHenPw1iRkkoR7uKX3FHF6IrPTiWcAN8G1g1nn8wcr9Sd7tvvK21dI+iFpdZIl4J
         0DCA==
X-Gm-Message-State: AOJu0Yw3hAg2xj0mrIiMScsF0oWbqiRK65eXiE3/QClk9tFV5vkzd1VK
	5M8AMdQnUtjxuEVFsijBOtcQwkP5y5eQRQSIF+ireYNsLScrfAuC+zwppLikNMbNvfKqX4qNEQa
	bnQiy5codSGEEmHvf
X-Received: by 2002:a05:600c:4f84:b0:40c:2cc3:9a5e with SMTP id n4-20020a05600c4f8400b0040c2cc39a5emr2240947wmq.80.1702301717935;
        Mon, 11 Dec 2023 05:35:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8QqIJmFvIRJUb5/8yGL29uLZMU9Rw7fWWwafr/kpJ0EL+LNiulMY6/7X35hZmclikVEitmQ==
X-Received: by 2002:a05:600c:4f84:b0:40c:2cc3:9a5e with SMTP id n4-20020a05600c4f8400b0040c2cc39a5emr2240941wmq.80.1702301717621;
        Mon, 11 Dec 2023 05:35:17 -0800 (PST)
Received: from debian (2a01cb058d23d600b532f7df3cadcb52.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b532:f7df:3cad:cb52])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b003fee6e170f9sm12818702wmq.45.2023.12.11.05.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:35:17 -0800 (PST)
Date: Mon, 11 Dec 2023 14:35:15 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH iproute2-next] ss: Add support for dumping TCP bound-inactive
 sockets.
Message-ID: <87947b2975508804d4efc49b9380041288eaa0f6.1702301488.git.gnault@redhat.com>
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

The SS_NEW_SYN_RECV pseudo-state is added in this patch only for code
consistency, so that SS_BOUND_INACTIVE gets assigned the right value
without manual assignment.

Note that the SS_BOUND_INACTIVE state is a pseudo-state used for queries
only. The kernel returns them as SS_CLOSE.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 man/man8/ss.8 |  7 +++++++
 misc/ss.c     | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

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
index 16ffb6c8..19adc1b7 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -210,6 +210,8 @@ enum {
 	SS_LAST_ACK,
 	SS_LISTEN,
 	SS_CLOSING,
+	SS_NEW_SYN_RECV,
+	SS_BOUND_INACTIVE,
 	SS_MAX
 };
 
@@ -1382,6 +1384,8 @@ static void sock_state_print(struct sockstat *s)
 		[SS_LAST_ACK] = "LAST-ACK",
 		[SS_LISTEN] =	"LISTEN",
 		[SS_CLOSING] = "CLOSING",
+		[SS_NEW_SYN_RECV] = "NEW-SYN-RECV",
+		[SS_BOUND_INACTIVE] = "BOUND-INACTIVE",
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
@@ -5421,6 +5426,8 @@ static int scan_state(const char *state)
 		[SS_LAST_ACK] = "last-ack",
 		[SS_LISTEN] =	"listening",
 		[SS_CLOSING] = "closing",
+		[SS_NEW_SYN_RECV] = "new-syn-recv",
+		[SS_BOUND_INACTIVE] = "bound-inactive",
 	};
 	int i;
 
@@ -5487,6 +5494,7 @@ static const struct option long_opts[] = {
 	{ "vsock", 0, 0, OPT_VSOCK },
 	{ "all", 0, 0, 'a' },
 	{ "listening", 0, 0, 'l' },
+	{ "bound-inactive", 0, 0, 'B' },
 	{ "ipv4", 0, 0, '4' },
 	{ "ipv6", 0, 0, '6' },
 	{ "packet", 0, 0, '0' },
@@ -5525,7 +5533,7 @@ int main(int argc, char *argv[])
 	int state_filter = 0;
 
 	while ((ch = getopt_long(argc, argv,
-				 "dhaletuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
+				 "dhalBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
 				 long_opts, NULL)) != EOF) {
 		switch (ch) {
 		case 'n':
@@ -5590,6 +5598,9 @@ int main(int argc, char *argv[])
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


