Return-Path: <netdev+bounces-55938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718980CE2B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D562B2814F6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFD648797;
	Mon, 11 Dec 2023 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BZIfsvnB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A697719A9
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702304375; x=1733840375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2HCITNfjFAFypW/yPbQ8j/hSHhdXJP7ePlfj0lsPjBc=;
  b=BZIfsvnBTICPq/kmy4ifyZhSgfPdSXEsR6+NmUpekdsoQ4/oidVk8F8a
   na8wgcxDoaala1Ypqgqdsksz2GM9KzyhAHlL/MFmOMCPFaKsVrNesiuKT
   MMlYs7sG1fF5z2sn7YOJU6Bm2o9yC2lqJJQQPnt0biGCLSoEJ5SE55/xf
   o=;
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="49792805"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:19:33 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id C1DAD6909E;
	Mon, 11 Dec 2023 14:19:31 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:14279]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.170:2525] with esmtp (Farcaster)
 id fedc1b7d-c5e7-4289-869e-602e4e89686d; Mon, 11 Dec 2023 14:19:31 +0000 (UTC)
X-Farcaster-Flow-ID: fedc1b7d-c5e7-4289-869e-602e4e89686d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 14:19:30 +0000
Received: from 88665a182662.ant.amazon.com (10.119.13.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 14:19:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnault@redhat.com>
CC: <dsahern@gmail.com>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<mkubecek@suse.cz>, <netdev@vger.kernel.org>
Subject: [PATCH iproute2-next] ss: Add support for dumping TCP bound-inactive sockets.
Date: Mon, 11 Dec 2023 23:19:17 +0900
Message-ID: <20231211141917.42613-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87947b2975508804d4efc49b9380041288eaa0f6.1702301488.git.gnault@redhat.com>
References: <87947b2975508804d4efc49b9380041288eaa0f6.1702301488.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Guillaume Nault <gnault@redhat.com>
Date: Mon, 11 Dec 2023 14:35:15 +0100
> Make ss aware of the new "bound-inactive" pseudo-state for TCP (see
> Linux commit 91051f003948 ("tcp: Dump bound-only sockets in inet_diag.")).
> These are TCP sockets that have been bound, but are neither listening nor
> connecting.
> 
> With this patch, these sockets can now be dumped with:
> 
>   * the existing -a (--all) option, to dump all sockets, including
>     bound-inactive ones,
> 
>   * the new -B (--bound-inactive) option, to dump them exclusively,
> 
>   * the new "bound-inactive" state, to be used in a STATE-FILTER.
> 
> The SS_NEW_SYN_RECV pseudo-state is added in this patch only for code
> consistency, so that SS_BOUND_INACTIVE gets assigned the right value
> without manual assignment.
> 
> Note that the SS_BOUND_INACTIVE state is a pseudo-state used for queries
> only. The kernel returns them as SS_CLOSE.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  man/man8/ss.8 |  7 +++++++
>  misc/ss.c     | 13 ++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/man/man8/ss.8 b/man/man8/ss.8
> index 073e9f03..4ece41fa 100644
> --- a/man/man8/ss.8
> +++ b/man/man8/ss.8
> @@ -40,6 +40,10 @@ established connections) sockets.
>  .B \-l, \-\-listening
>  Display only listening sockets (these are omitted by default).
>  .TP
> +.B \-B, \-\-bound-inactive
> +Display only TCP bound but inactive (not listening, connecting, etc.) sockets
> +(these are omitted by default).
> +.TP
>  .B \-o, \-\-options
>  Show timer information. For TCP protocol, the output format is:
>  .RS
> @@ -456,6 +460,9 @@ states except for
>  - opposite to
>  .B bucket
>  
> +.B bound-inactive
> +- bound but otherwise inactive sockets (not listening, connecting, etc.)
> +
>  .SH EXPRESSION
>  
>  .B EXPRESSION
> diff --git a/misc/ss.c b/misc/ss.c
> index 16ffb6c8..19adc1b7 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -210,6 +210,8 @@ enum {
>  	SS_LAST_ACK,
>  	SS_LISTEN,
>  	SS_CLOSING,
> +	SS_NEW_SYN_RECV,

I think this is bit confusing as TCP_NEW_SYN_RECV is usually
invisible from user.

TCP_NEW_SYN_RECV was originally split from TCP_SYN_RECV for a
non-{TFO,cross-SYN} request.

So, both get_openreq4() (/proc/net/tcp) and inet_req_diag_fill()
(inet_diag) maps TCP_NEW_SYN_RECV to TCP_SYN_RECV.


> +	SS_BOUND_INACTIVE,

I prefer explicitly assigning a number to SS_BOUND_INACTIVE.


>  	SS_MAX
>  };
>  
> @@ -1382,6 +1384,8 @@ static void sock_state_print(struct sockstat *s)
>  		[SS_LAST_ACK] = "LAST-ACK",
>  		[SS_LISTEN] =	"LISTEN",
>  		[SS_CLOSING] = "CLOSING",
> +		[SS_NEW_SYN_RECV] = "NEW-SYN-RECV",

If we need to define SS_NEW_SYN_RECV, I prefer not setting
it or setting "" or "SYN-RECV".


> +		[SS_BOUND_INACTIVE] = "BOUND-INACTIVE",
>  	};
>  
>  	switch (s->local.family) {
> @@ -5339,6 +5343,7 @@ static void _usage(FILE *dest)
>  "   -r, --resolve       resolve host names\n"
>  "   -a, --all           display all sockets\n"
>  "   -l, --listening     display listening sockets\n"
> +"   -B, --bound-inactive display TCP bound but inactive sockets\n"
>  "   -o, --options       show timer information\n"
>  "   -e, --extended      show detailed socket information\n"
>  "   -m, --memory        show socket memory usage\n"
> @@ -5421,6 +5426,8 @@ static int scan_state(const char *state)
>  		[SS_LAST_ACK] = "last-ack",
>  		[SS_LISTEN] =	"listening",
>  		[SS_CLOSING] = "closing",
> +		[SS_NEW_SYN_RECV] = "new-syn-recv",

Same here.

Thanks!


> +		[SS_BOUND_INACTIVE] = "bound-inactive",
>  	};
>  	int i;
>  
> @@ -5487,6 +5494,7 @@ static const struct option long_opts[] = {
>  	{ "vsock", 0, 0, OPT_VSOCK },
>  	{ "all", 0, 0, 'a' },
>  	{ "listening", 0, 0, 'l' },
> +	{ "bound-inactive", 0, 0, 'B' },
>  	{ "ipv4", 0, 0, '4' },
>  	{ "ipv6", 0, 0, '6' },
>  	{ "packet", 0, 0, '0' },
> @@ -5525,7 +5533,7 @@ int main(int argc, char *argv[])
>  	int state_filter = 0;
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "dhaletuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
> +				 "dhalBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHSO",
>  				 long_opts, NULL)) != EOF) {
>  		switch (ch) {
>  		case 'n':
> @@ -5590,6 +5598,9 @@ int main(int argc, char *argv[])
>  		case 'l':
>  			state_filter = (1 << SS_LISTEN) | (1 << SS_CLOSE);
>  			break;
> +		case 'B':
> +			state_filter = 1 << SS_BOUND_INACTIVE;
> +			break;
>  		case '4':
>  			filter_af_set(&current_filter, AF_INET);
>  			break;
> -- 
> 2.39.2

