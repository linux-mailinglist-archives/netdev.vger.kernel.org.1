Return-Path: <netdev+bounces-52578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91A7FF3F9
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EC028176A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2D524A9;
	Thu, 30 Nov 2023 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQQI74sy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F7B10C2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701359513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R9sH/nsXBm58uJZS6MMM9fWob8FhigNQ0Gt0J9YIG4w=;
	b=JQQI74syvb/dy6MrKK9YKM0sx7VWlVsN/NIrYuGNEeukcrDtPqSvcHomgJ7t2EeUi2mo8e
	gLrYCHpEN4wcIzJmY4l3SLsS/bLK5VX7vG5bxS2rLv9K/f7D7saGBvReBpn90XO7oODEE/
	FO+vFolCVlD3p0MzomnMJXt9prom980=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-A5ff_npWOWuGXLBsxip0LQ-1; Thu, 30 Nov 2023 10:51:52 -0500
X-MC-Unique: A5ff_npWOWuGXLBsxip0LQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50aa9997747so1455226e87.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701359510; x=1701964310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9sH/nsXBm58uJZS6MMM9fWob8FhigNQ0Gt0J9YIG4w=;
        b=W3lQtbpTBT9718QpW1URU52U4sKlgi2nk/Vaa0KbHdC8zQx2ZxA2op+wo1w5JOA47D
         booEbL6j62zx3fuD6Ezx4mJy3Odyqg6bbQC6mQQo4LOc4pRrtnz+CgKP/ipMTt5a8dT/
         zNEVzxAEkgYa0dKGcOrs/MHvn0S8aqq8XqSL9qcPULrUqfm+Ps5uBvV7RcRyhKGLy7bo
         XQj99fONYomqHyuEOnBo1ASgNYkTQpgt9YPAmLgDJQvmmW8kLPuz2GeCAwpYRMOPitU1
         /OkxxERixNJbmZfsW7Zhcjk1HhcFTR6riSbQRhxYSmojvd29eNyat0eukbaOy4y4mTbU
         HATA==
X-Gm-Message-State: AOJu0Yxe8Zy4UcCgmw+vB+Es6UmpEPVwe4VQTZbhce8MLt+Iwbfi7XU9
	QyHDk9lrwuRdE4i0DtCs0cDYwZyWcuK5LcYzxMNlLUUHVj0Dsdqa4LfNBWLC8JBpmvFVrXhBShU
	v2zxdzf5eisz/wz/6
X-Received: by 2002:a05:6512:3e0a:b0:503:36cb:5436 with SMTP id i10-20020a0565123e0a00b0050336cb5436mr14134486lfv.9.1701359510517;
        Thu, 30 Nov 2023 07:51:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxK+o76JjlzjGo4sCr3Sdp4eHXm0tn7JN0/Jt0LixY17vWdyrIK6Iu8rubG0+Tpb3vMIYqkw==
X-Received: by 2002:a05:6512:3e0a:b0:503:36cb:5436 with SMTP id i10-20020a0565123e0a00b0050336cb5436mr14134472lfv.9.1701359510167;
        Thu, 30 Nov 2023 07:51:50 -0800 (PST)
Received: from debian (2a01cb058918ce00f1553101655f9ec6.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:f155:3101:655f:9ec6])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040b4fca8620sm6138574wmo.37.2023.11.30.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:51:49 -0800 (PST)
Date: Thu, 30 Nov 2023 16:51:47 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net-next v3] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <ZWivkx3frDwoCX0k@debian>
References: <49a05d612fc8968b17780ed82ecb1b96dcf78e5a.1701358163.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a05d612fc8968b17780ed82ecb1b96dcf78e5a.1701358163.git.gnault@redhat.com>

On Thu, Nov 30, 2023 at 04:40:51PM +0100, Guillaume Nault wrote:
> Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
> that are bound but haven't yet called connect() or listen().
> 
> The code is inspired by the ->lhash2 loop. However there's no manual
> test of the source port, since this kind of filtering is already
> handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
> at a time, to avoid running with bh disabled for too long.
> 
> There's no TCP state for bound but otherwise inactive sockets. Such
> sockets normally map to TCP_CLOSE. However, "ss -l", which is supposed
> to only dump listening sockets, actually requests the kernel to dump
> sockets in either the TCP_LISTEN or TCP_CLOSE states. To avoid dumping
> bound-only sockets with "ss -l", we therefore need to define a new
> pseudo-state (TCP_BOUND_INACTIVE) that user space will be able to set
> explicitly.
> 
> With an IPv4, an IPv6 and an IPv6-only socket, bound respectively to
> 40000, 64000, 60000, an updated version of iproute2 could work as
> follow:
> 
>   $ ss -t state bound-inactive
>   Recv-Q   Send-Q     Local Address:Port       Peer Address:Port   Process
>   0        0                0.0.0.0:40000           0.0.0.0:*
>   0        0                   [::]:60000              [::]:*
>   0        0                      *:64000                 *:*

Here's a patch for iproute2-next for easy testing.
I'll submit it formally once the kernel side will be in place.

-------- >8 --------

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
index 9438382b..45f01286 100644
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
 
@@ -1381,6 +1383,8 @@ static void sock_state_print(struct sockstat *s)
 		[SS_LAST_ACK] = "LAST-ACK",
 		[SS_LISTEN] =	"LISTEN",
 		[SS_CLOSING] = "CLOSING",
+		[SS_NEW_SYN_RECV] = "NEW-SYN-RECV",
+		[SS_BOUND_INACTIVE] = "BOUND-INACTIVE",
 	};
 
 	switch (s->local.family) {
@@ -5333,6 +5337,7 @@ static void _usage(FILE *dest)
 "   -r, --resolve       resolve host names\n"
 "   -a, --all           display all sockets\n"
 "   -l, --listening     display listening sockets\n"
+"   -B, --bound-inactive display TCP bound but inactive sockets\n"
 "   -o, --options       show timer information\n"
 "   -e, --extended      show detailed socket information\n"
 "   -m, --memory        show socket memory usage\n"
@@ -5415,6 +5420,8 @@ static int scan_state(const char *state)
 		[SS_LAST_ACK] = "last-ack",
 		[SS_LISTEN] =	"listening",
 		[SS_CLOSING] = "closing",
+		[SS_NEW_SYN_RECV] = "new-syn-recv",
+		[SS_BOUND_INACTIVE] = "bound-inactive",
 	};
 	int i;
 
@@ -5481,6 +5488,7 @@ static const struct option long_opts[] = {
 	{ "vsock", 0, 0, OPT_VSOCK },
 	{ "all", 0, 0, 'a' },
 	{ "listening", 0, 0, 'l' },
+	{ "bound-inactive", 0, 0, 'B' },
 	{ "ipv4", 0, 0, '4' },
 	{ "ipv6", 0, 0, '6' },
 	{ "packet", 0, 0, '0' },
@@ -5519,7 +5527,7 @@ int main(int argc, char *argv[])
 	int state_filter = 0;
 
 	while ((ch = getopt_long(argc, argv,
-				 "dhaletuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
+				 "dhalBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
 				 long_opts, NULL)) != EOF) {
 		switch (ch) {
 		case 'n':
@@ -5584,6 +5592,9 @@ int main(int argc, char *argv[])
 		case 'l':
 			state_filter = (1 << SS_LISTEN) | (1 << SS_CLOSE);
 			break;
+		case 'B':
+			state_filter = 1 << SS_BOUND_INACTIVE;
+			break;
 		case '4':
 			filter_af_set(&current_filter, AF_INET);
 			break;


