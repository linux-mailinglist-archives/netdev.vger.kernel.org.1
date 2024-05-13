Return-Path: <netdev+bounces-95831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D768C39BD
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6AB280FD0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 01:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA4A92E;
	Mon, 13 May 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crRcEY96"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE115A923
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715562163; cv=none; b=ORHo3ieo5H1MOk9O0cDP/mkRD15Rh6b+7tCu9CUKgH+mJ/Adn7C0XmqHdFx9x7nBtlbgPo+ctx7m3Mf7Fd7aKNqMzskAFUL8KB6jCfUbBqnuRQ6lA8mzup9NP3qWXq9E8BS3BXthxjOKUx+F8TaS4o8kcrVCWJD7OEbFm0vqEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715562163; c=relaxed/simple;
	bh=m9d/0JZ9holQQwUZtlmkc6t63qvmCYckQFML4gOaclM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P9CNP/Ouwj8qPJkHsKyP6QqRr4N18H0DaTd5X/jx/b7FtIgGT9UMK6EkxZBWqeRSb9Wljim/OCDuiOOPwhHnQfgKrlAkh3aSCUjJq98wUF7qLyXf8oBqKofPUQNd/ZPY3+1IcAucAyqi9EfrROiEvBDoWo7ULkYtqrwRb3bkXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crRcEY96; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792b94301eeso359551785a.3
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715562161; x=1716166961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxl/rjAM4RBmQmdFQ0b3uOPqptfw9RCy7CU9eKyOP2I=;
        b=crRcEY96gVjYSYuYk0J/9ZEAUOtuEjsKeLuGUGmtJ1A1otln/j8Eno8ncE9XvS83ST
         iTvVEwAaxCsQmFZs9f5Qf8bdBZoYUAGq9Z8ctaLyabo6/vtrl+t5A5kWTCEM/AEhClD5
         G9OeLGPhfzCIpg4SQXX0jHA5oCzOMAvl1Y5/fgTxip+3X0JWcvy45QtwN3DGlIbJ97xI
         Y2FzOoz02DEVuGM/4PmQTMFzRu8TjiAn4ZsItXFo09B1eIfr+l0jJYVIs1hHnJ+oa1MM
         5iq3XydH4X25p6CY2+0uU0slncuO2E9znkzaYXhos6Xru4aCH5qRGlDOMXs0CD0lpBNx
         vl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715562161; x=1716166961;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lxl/rjAM4RBmQmdFQ0b3uOPqptfw9RCy7CU9eKyOP2I=;
        b=lU76aH1LmBdU9Pwy75NS7tsLTjpioRrsLWhng7zMlGZybdEAAKDnVXxWOO7j8Tx4Hj
         5YCQGmd4dgAPg8EC/z9jPqesk+0kJvg6E9drmaODGsZWFPAQdBS3b/DUByh/Jf5wC5Qp
         5hTh1L9vI6w6PraskAUrpF3ciV3NFUViQXLePlnGnMYGEnUBGw3dLfIrjrcT4/h7oC5N
         y34lpbqT8ZpQ9SHgdtoMoIveRSACvzjta4qOLkMu9g+xniesh/tm5sMbwIeI90k47IH1
         MFt65Sah0986MBSi9YyeJb9CqZCa+0T2SajEjzxBseeiSZzvoffgo1nG5DfGalUyDh5X
         u7zA==
X-Forwarded-Encrypted: i=1; AJvYcCU9ksONMVm30+j8UUOc1SsZjeGRMuby8tTZHyox9dbcbQLKtOSbMYGEWMpa1raBe+k5DoAnc/tCEVxtOeOXV5eD6VlE49ep
X-Gm-Message-State: AOJu0Yyq1uADW25E9FsFbLvCVZE1DVQaMu97WMYsBkQIVET8vuQznFfc
	f0rm79me18cdnckqkf4KvscH+6L3oKJ0/d4hjqzPPPPc5I/CMIZk
X-Google-Smtp-Source: AGHT+IGjk5DEYc777NROMywOVOpfvhcNNaw4djEtXbQJ7wXLOrdfyrGUSQVRuNP7wkXg2Li4u9aQUQ==
X-Received: by 2002:a05:620a:204c:b0:792:9248:c2e9 with SMTP id af79cd13be357-792c75f4506mr902259585a.48.1715562160571;
        Sun, 12 May 2024 18:02:40 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc5a7sm407332485a.84.2024.05.12.18.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 18:02:40 -0700 (PDT)
Date: Sun, 12 May 2024 21:02:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <664166b015bdb_1d6c6729419@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240510155900.1825946-4-zijianzhang@bytedance.com>
References: <20240510155900.1825946-1-zijianzhang@bytedance.com>
 <20240510155900.1825946-4-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v3 3/3] selftests: add MSG_ZEROCOPY msg_control
 notification test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> We update selftests/net/msg_zerocopy.c to accommodate the new mechanism.
> 
> Test result from selftests/net/msg_zerocopy.c,
> cfg_notification_limit = 1, in this case MSG_ZEROCOPY approximately
> aligns with the semantics of MSG_ZEROCOPY_UARG. In this case, the new
> flag has around 13% cpu savings in TCP and 18% cpu savings in UDP.
> +---------------------+---------+---------+---------+---------+
> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> +---------------------+---------+---------+---------+---------+
> | ZCopy (MB)          | 5147    | 4885    | 7489    | 7854    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy (MB)      | 5859    | 5505    | 9053    | 9236    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy / ZCopy   | 113.83% | 112.69% | 120.88% | 117.59% |
> +---------------------+---------+---------+---------+---------+
> 
> cfg_notification_limit = 32, it means less poll + recvmsg overhead,
> the new mechanism performs 8% better in TCP. For UDP, no obvious
> performance gain is observed and sometimes may lead to degradation.
> Thus, if users don't need to retrieve the notification ASAP in UDP,
> the original mechanism is preferred.
> +---------------------+---------+---------+---------+---------+
> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> +---------------------+---------+---------+---------+---------+
> | ZCopy (MB)          | 6272    | 6138    | 12138   | 10055   |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy (MB)      | 6774    | 6620    | 11504   | 10355   |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy / ZCopy   | 108.00% | 107.85% | 94.78%  | 102.98% |
> +---------------------+---------+---------+---------+---------+
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  tools/testing/selftests/net/msg_zerocopy.c  | 103 ++++++++++++++++++--
>  tools/testing/selftests/net/msg_zerocopy.sh |   1 +
>  2 files changed, 97 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
> index ba6c257f689c..48750a7a162c 100644
> --- a/tools/testing/selftests/net/msg_zerocopy.c
> +++ b/tools/testing/selftests/net/msg_zerocopy.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /* Evaluate MSG_ZEROCOPY
>   *
>   * Send traffic between two processes over one of the supported
> @@ -66,6 +67,10 @@
>  #define SO_ZEROCOPY	60
>  #endif
>  
> +#ifndef SCM_ZC_NOTIFICATION
> +#define SCM_ZC_NOTIFICATION	78
> +#endif
> +
>  #ifndef SO_EE_CODE_ZEROCOPY_COPIED
>  #define SO_EE_CODE_ZEROCOPY_COPIED	1
>  #endif
> @@ -74,6 +79,13 @@
>  #define MSG_ZEROCOPY	0x4000000
>  #endif
>  
> +#define ZC_MSGERR_NOTIFICATION 1
> +#define ZC_MSGCTL_NOTIFICATION 2

Please define an enum

And consider less truncated, more descriptive, names. E.g.,

   MSG_ZEROCOPY_NOTIFY_ERRQUEUE
   MSG_ZEROCOPY_NOTIFY_SENDMSG

> +
> +#define SOCK_ZC_INFO_NUM 8
> +
> +#define INVALID_ZEROCOPY_VAL 2
> +
>  static int  cfg_cork;
>  static bool cfg_cork_mixed;
>  static int  cfg_cpu		= -1;		/* default: pin to last cpu */
> @@ -86,13 +98,16 @@ static int  cfg_runtime_ms	= 4200;
>  static int  cfg_verbose;
>  static int  cfg_waittime_ms	= 500;
>  static int  cfg_notification_limit = 32;
> -static bool cfg_zerocopy;
> +static int  cfg_zerocopy;           /* Either 1 or 2, mode for SO_ZEROCOPY */
>  
>  static socklen_t cfg_alen;
>  static struct sockaddr_storage cfg_dst_addr;
>  static struct sockaddr_storage cfg_src_addr;
>  
>  static char payload[IP_MAXPACKET];
> +static struct zc_info_elem zc_info[SOCK_ZC_INFO_NUM];
> +static char zc_ckbuf[CMSG_SPACE(sizeof(void *))];
> +static struct zc_info_elem *zc_info_ptr = zc_info;
>  static long packets, bytes, completions, expected_completions;
>  static int  zerocopied = -1;
>  static uint32_t next_completion;
> @@ -170,6 +185,26 @@ static int do_accept(int fd)
>  	return fd;
>  }
>  
> +static void add_zcopy_info(struct msghdr *msg)
> +{
> +	int i;
> +	struct cmsghdr *cm;
> +
> +	if (!msg->msg_control)
> +		error(1, errno, "NULL user arg");
> +	cm = (void *)msg->msg_control;
> +	/* Although only the address of the array will be written into the
> +	 * zc_ckbuf, we assign cmsg_len to CMSG_LEN(sizeof(zc_info)) to specify
> +	 * the length of the array.
> +	 */
> +	cm->cmsg_len = CMSG_LEN(sizeof(zc_info));
> +	cm->cmsg_level = SOL_SOCKET;
> +	cm->cmsg_type = SCM_ZC_NOTIFICATION;
> +	memcpy(CMSG_DATA(cm), &zc_info_ptr, sizeof(zc_info_ptr));
> +	for (i = 0; i < SOCK_ZC_INFO_NUM; i++)
> +		zc_info[i].zerocopy = INVALID_ZEROCOPY_VAL;
> +}
> +
>  static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
>  {
>  	struct cmsghdr *cm;
> @@ -183,7 +218,7 @@ static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
>  	memcpy(CMSG_DATA(cm), &cookie, sizeof(cookie));
>  }
>  
> -static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
> +static bool do_sendmsg(int fd, struct msghdr *msg, int do_zerocopy, int domain)
>  {
>  	int ret, len, i, flags;
>  	static uint32_t cookie;
> @@ -201,6 +236,15 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>  			msg->msg_controllen = CMSG_SPACE(sizeof(cookie));
>  			msg->msg_control = (struct cmsghdr *)ckbuf;
>  			add_zcopy_cookie(msg, ++cookie);
> +		} else if (do_zerocopy == ZC_MSGCTL_NOTIFICATION) {
> +			memset(&msg->msg_control, 0, sizeof(msg->msg_control));
> +			/* Although only the address of the array will be written into the
> +			 * zc_ckbuf, msg_controllen must be larger or equal than any cmsg_len
> +			 * in it. Otherwise, we will get -EINVAL.
> +			 */
> +			msg->msg_controllen = CMSG_SPACE(sizeof(zc_info));
> +			msg->msg_control = (struct cmsghdr *)zc_ckbuf;
> +			add_zcopy_info(msg);
>  		}
>  	}
>  
> @@ -219,7 +263,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>  		if (do_zerocopy && ret)
>  			expected_completions++;
>  	}
> -	if (do_zerocopy && domain == PF_RDS) {
> +	if (msg->msg_control) {
>  		msg->msg_control = NULL;
>  		msg->msg_controllen = 0;
>  	}
> @@ -393,6 +437,42 @@ static bool do_recvmsg_completion(int fd)
>  	return ret;
>  }
>  
> +static void do_recv_completions2(void)
> +{
> +	int i;
> +	__u32 hi, lo, range;
> +	__u8 zerocopy;
> +
> +	for (i = 0; zc_info[i].zerocopy != INVALID_ZEROCOPY_VAL; i++) {
> +		struct zc_info_elem elem = zc_info[i];
> +
> +		hi = elem.hi;
> +		lo = elem.lo;
> +		zerocopy = elem.zerocopy;
> +		range = hi - lo + 1;
> +
> +		if (cfg_verbose && lo != next_completion)
> +			fprintf(stderr, "gap: %u..%u does not append to %u\n",
> +				lo, hi, next_completion);
> +		next_completion = hi + 1;
> +
> +		if (zerocopied == -1)
> +			zerocopied = zerocopy;
> +		else if (zerocopied != zerocopy) {
> +			fprintf(stderr, "serr: inconsistent\n");
> +			zerocopied = zerocopy;
> +		}
> +
> +		completions += range;
> +
> +		if (cfg_verbose >= 2)
> +			fprintf(stderr, "completed: %u (h=%u l=%u)\n",
> +				range, hi, lo);
> +	}
> +
> +	sendmsg_counter -= i;
> +}
> +
>  static bool do_recv_completion(int fd, int domain)
>  {
>  	struct sock_extended_err *serr;
> @@ -554,11 +634,15 @@ static void do_tx(int domain, int type, int protocol)
>  		else
>  			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
>  
> -		if (cfg_zerocopy && sendmsg_counter >= cfg_notification_limit)
> +		if (cfg_zerocopy == ZC_MSGERR_NOTIFICATION &&
> +			sendmsg_counter >= cfg_notification_limit)
>  			do_recv_completions(fd, domain);
>  
> +		if (cfg_zerocopy == ZC_MSGCTL_NOTIFICATION)
> +			do_recv_completions2();
> +
>  		while (!do_poll(fd, POLLOUT)) {
> -			if (cfg_zerocopy)
> +			if (cfg_zerocopy == ZC_MSGERR_NOTIFICATION)
>  				do_recv_completions(fd, domain);
>  		}
>  
> @@ -716,7 +800,7 @@ static void parse_opts(int argc, char **argv)
>  
>  	cfg_payload_len = max_payload_len;
>  
> -	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
> +	while ((c = getopt(argc, argv, "46c:C:D:i:l:mnp:rs:S:t:vz")) != -1) {
>  		switch (c) {
>  		case '4':
>  			if (cfg_family != PF_UNSPEC)
> @@ -750,6 +834,9 @@ static void parse_opts(int argc, char **argv)
>  		case 'm':
>  			cfg_cork_mixed = true;
>  			break;
> +		case 'n':
> +			cfg_zerocopy = ZC_MSGCTL_NOTIFICATION;
> +			break;
>  		case 'p':
>  			cfg_port = strtoul(optarg, NULL, 0);
>  			break;
> @@ -769,7 +856,7 @@ static void parse_opts(int argc, char **argv)
>  			cfg_verbose++;
>  			break;
>  		case 'z':
> -			cfg_zerocopy = true;
> +			cfg_zerocopy = ZC_MSGERR_NOTIFICATION;
>  			break;
>  		}
>  	}
> @@ -780,6 +867,8 @@ static void parse_opts(int argc, char **argv)
>  			error(1, 0, "-D <server addr> required for PF_RDS\n");
>  		if (!cfg_rx && !saddr)
>  			error(1, 0, "-S <client addr> required for PF_RDS\n");
> +		if (cfg_zerocopy == ZC_MSGCTL_NOTIFICATION)
> +			error(1, 0, "PF_RDS does not support ZC_MSGCTL_NOTIFICATION");
>  	}
>  	setup_sockaddr(cfg_family, daddr, &cfg_dst_addr);
>  	setup_sockaddr(cfg_family, saddr, &cfg_src_addr);
> diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
> index 89c22f5320e0..022a6936d86f 100755
> --- a/tools/testing/selftests/net/msg_zerocopy.sh
> +++ b/tools/testing/selftests/net/msg_zerocopy.sh
> @@ -118,4 +118,5 @@ do_test() {
>  
>  do_test "${EXTRA_ARGS}"
>  do_test "-z ${EXTRA_ARGS}"
> +do_test "-n ${EXTRA_ARGS}"
>  echo ok
> -- 
> 2.20.1
> 



