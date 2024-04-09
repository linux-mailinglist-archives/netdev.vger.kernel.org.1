Return-Path: <netdev+bounces-86283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60C589E4EA
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA954B218C1
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F1158A37;
	Tue,  9 Apr 2024 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbyhalhs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87F156F4F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697960; cv=none; b=ISY4NsmPThbW65XQrQjc09QiJ36HMk87EHB0c3rDV0E92c8kkjugmfTNDQ7Pkw/sXOwtyOiyoUfN+cyT6ku8ls9l94JesptRa6oiAE8N+2nGaepdk+YymUfn+4RlEYF9N3E0Wlh0OfHfxTLtNdy+IIThqynqzaCAkUjSrcxRqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697960; c=relaxed/simple;
	bh=PcvgK6gO1wRAsulMtfTbJZrDhVIDh79rYzTnXDliWVE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TuEWWSA1iWKxnGz0sitgr9DVnLooYRZT5r79eHRLhgteEAzs2IajHba+gtVejg7cGtxoYTrseiUgGPKfDahg+Yi/ltIrrFTukNFSOoYNY/MIAL2HugYGmD2ni/yIPCIS7p2fI2T4ZouI/qOFjf3npIlvYtpsEQKD9294KPwRoPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbyhalhs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d6bc947aeso100992385a.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712697957; x=1713302757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEfS1unLNrVfbsJxr4T7YVHYwCts8cLRQLdkg5+Cr2M=;
        b=NbyhalhsO9IKQD3P+WE649r9Pmd5OpCTFiqMunZ8ew7neLgMZfAB+NJ3hQUNfJdlMJ
         iFd0R3if6Lp2+lp/odgpAElVY+M+NSV6nIVO35I//lYhIOIMWg9T5gvt3EHqgHMO4w/6
         RYn4h4Aswg4jAHhlTFLP1EHnpHZSVsKYNwXLw0ZKb77VBFfpMd79bw2cbKmOomeaxL92
         0lf/iYJ1LVEifawSWM8WeKqfEPJNTuROV7QTNzzw6ab3wW+xAByNMbmRINDjSQepUGXB
         sNRHUKNWZXTaGu/HN7Jk3dFYsWLyuThmTeh+Hh7eiQnnciir8g0uAMiYCP3MYBU+KJTZ
         vthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712697957; x=1713302757;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PEfS1unLNrVfbsJxr4T7YVHYwCts8cLRQLdkg5+Cr2M=;
        b=beQToGhAybhRx7jQ2OgCs91BWlDCp6oi429lbnMybwdCEhLXdsBfyKpIVEs7vVry58
         EP/H0k4jAV6wi9m+gAqWx/jXsBgdrwTH2CFPe8sKYobPJd3BLVXix4qguosJfVswcddx
         P62ImT5J3tJVeIOsQJOv+PC5/0FhSaaDq0lP79kz8xoRhfL06tUXkFNmMdQRtDyuBuEi
         oimhYJKWFDzERw0CsMk8nxlrTBQK9OsNa1xPzEAzhueGiEBSinjx0Gc0MZoHqAnSzt/r
         De9XlgC8048YGlTzX2/AfW3q+sMg+s3ojY7jKwPE0fgUTMvPbqXb9fw5xepmrUW4Ti4l
         jJsw==
X-Forwarded-Encrypted: i=1; AJvYcCWr1o6gXKWxO2thJQXjxc9bWl6YKnM5mnb4b/RCz2VkmhH6f6WbU5J9fGUqt1SQodIPMUfwU/kNK2KOKwIJFgvDvhVDM3ow
X-Gm-Message-State: AOJu0YxqxX8FcmyeUmNGAVDdNo6KnN4VZifrYUrFgC0AERJh30nDF9Qt
	RTrkucUMUn1WM5h2Y+OnY2XwAmQOH1pUlErgtvOIjNmY7uZBSBz7
X-Google-Smtp-Source: AGHT+IGVVoCCd+mhCJbO8w9iB1c34ydz8mk9h5/h+dhHyc9kZaWzTsRUC56JAD82GTpQXz4FXWwspg==
X-Received: by 2002:a05:6214:2aa3:b0:69b:370b:b1db with SMTP id js3-20020a0562142aa300b0069b370bb1dbmr661662qvb.51.1712697957219;
        Tue, 09 Apr 2024 14:25:57 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 7-20020a0562140d0700b006993cbb1ab4sm407943qvh.117.2024.04.09.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:25:56 -0700 (PDT)
Date: Tue, 09 Apr 2024 17:25:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <6615b264894a0_24a51429432@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240409205300.1346681-3-zijianzhang@bytedance.com>
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <20240409205300.1346681-3-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next 2/3] selftests: fix OOM problem in msg_zerocopy
 selftest
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
> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
> on a socket, and it will recv the completion notifications when the socket
> is not writable. Typically, it will start the receiving process after
> around 30+ sendmsgs.
> 
> However, because of the commit dfa2f0483360
> ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is always writable
> and does not get any chance to run recv notifications. The selftest always
> exits with OUT_OF_MEMORY because the memory used by opt_skb exceeds
> the core.sysctl_optmem_max. We introduce "cfg_notification_limit" to
> force sender to receive notifications after some number of sendmsgs.

No need for a new option. Existing test automation will not enable
that.

I have not observed this behavior in tests (so I wonder what is
different about the setups). But it is fine to unconditionally force
a call to do_recv_completions every few sends.

> Plus,
> in the selftest, we need to update skb_orphan_frags_rx to be the same as
> skb_orphan_frags.

To be able to test over loopback, I suppose?

> In this case, for some reason, notifications do not
> come in order now. We introduce "cfg_notification_order_check" to
> possibly ignore the checking for order.

Were you testing UDP?

I don't think this is needed. I wonder what you were doing to see
enough of these events to want to suppress the log output.
 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  tools/testing/selftests/net/msg_zerocopy.c | 24 ++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
> index bdc03a2097e8..8e595216a0af 100644
> --- a/tools/testing/selftests/net/msg_zerocopy.c
> +++ b/tools/testing/selftests/net/msg_zerocopy.c
> @@ -85,6 +85,8 @@ static bool cfg_rx;
>  static int  cfg_runtime_ms	= 4200;
>  static int  cfg_verbose;
>  static int  cfg_waittime_ms	= 500;
> +static bool cfg_notification_order_check;
> +static int  cfg_notification_limit = 32;
>  static bool cfg_zerocopy;
>  
>  static socklen_t cfg_alen;
> @@ -435,7 +437,7 @@ static bool do_recv_completion(int fd, int domain)
>  	/* Detect notification gaps. These should not happen often, if at all.
>  	 * Gaps can occur due to drops, reordering and retransmissions.
>  	 */
> -	if (lo != next_completion)
> +	if (cfg_notification_order_check && lo != next_completion)
>  		fprintf(stderr, "gap: %u..%u does not append to %u\n",
>  			lo, hi, next_completion);
>  	next_completion = hi + 1;
> @@ -489,7 +491,7 @@ static void do_tx(int domain, int type, int protocol)
>  		struct iphdr iph;
>  	} nh;
>  	uint64_t tstop;
> -	int fd;
> +	int fd, sendmsg_counter = 0;
>  
>  	fd = do_setup_tx(domain, type, protocol);
>  
> @@ -548,10 +550,18 @@ static void do_tx(int domain, int type, int protocol)
>  			do_sendmsg_corked(fd, &msg);
>  		else
>  			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
> +		sendmsg_counter++;
> +
> +		if (sendmsg_counter == cfg_notification_limit && cfg_zerocopy) {
> +			do_recv_completions(fd, domain);
> +			sendmsg_counter = 0;
> +		}
>  
>  		while (!do_poll(fd, POLLOUT)) {
> -			if (cfg_zerocopy)
> +			if (cfg_zerocopy) {
>  				do_recv_completions(fd, domain);
> +				sendmsg_counter = 0;
> +			}
>  		}
>  
>  	} while (gettimeofday_ms() < tstop);
> @@ -708,7 +718,7 @@ static void parse_opts(int argc, char **argv)
>  
>  	cfg_payload_len = max_payload_len;
>  
> -	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
> +	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vzol:")) != -1) {
>  		switch (c) {
>  		case '4':
>  			if (cfg_family != PF_UNSPEC)
> @@ -760,6 +770,12 @@ static void parse_opts(int argc, char **argv)
>  		case 'z':
>  			cfg_zerocopy = true;
>  			break;
> +		case 'o':
> +			cfg_notification_order_check = true;
> +			break;
> +		case 'l':
> +			cfg_notification_limit = strtoul(optarg, NULL, 0);
> +			break;
>  		}
>  	}
>  
> -- 
> 2.20.1
> 



