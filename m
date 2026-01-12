Return-Path: <netdev+bounces-248877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B24D107B9
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A6433005191
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB319306D36;
	Mon, 12 Jan 2026 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjar2TER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87423033C7
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188523; cv=none; b=OAl2UXv+ZKDqm9eXL3pswVfSdDAq9jsNCpnxfLMlpuPhhyc2PQIVl3fsjO7b+lzc/Hk2ty15mvrdTc9IUE8PaeEwMy9T1YToZ2kIyoDUXhe7otB3fzMjgGQotM9Ptid9pDdn/zDsUOfBnuD/S328f9ENYYlj4Wg2sDYpY9dtpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188523; c=relaxed/simple;
	bh=WvvL6tINtDicQHOXnRWZhgmnVSUiY5Ec2ilyls936Xw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h+5TKDkCSSER+6u0q9VWSAWlF3x379GB1vq5m0dKk+LHKtOsqi2g6PoGb7izqL0n072pySHs0JyXJ6YpKW70oAEVf2L+XmbgAo55jIXIjDf/tM55ObckJXmaqd8UjF3Ztfs6SWmHtAYbcyjD9TLkOC5qCSNbOvIJSohXbdLMKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjar2TER; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79276cef7beso9645687b3.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 19:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768188521; x=1768793321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11TLoL5kSXLu46zF46Hsn1hKpZJp5zLQUli5K1TmB9Q=;
        b=gjar2TERgQJjnX8t86BwWMjgUFa1xKkcbsAcuop2x0tU+vJ6k8yFPebR+ws9o3CrXG
         wZXitgc7yIsOPTVoE3DBvpalpmd/Zw2f1ceWo1syZ0hDBvAo3RZGLAPMXBP007Y3ZBjz
         1h7sCw2okikE/UE//bUlmcu+s3arduYgsEmpySCFOEKtVrrLMibHNJch77rk1GYH2oha
         z8iJir9GWOhDD7zBmFDgwqez+sAyDYOiE+ydmPNEa0A+ByV3KCeuBiL3mfMLoKmX0R2P
         wvnYnqVFssB0947msM1Tui5JUBgfnMfQ4sZudRXc/B+aQJlDgvR5XO3815VX5vB15D0w
         rLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768188521; x=1768793321;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11TLoL5kSXLu46zF46Hsn1hKpZJp5zLQUli5K1TmB9Q=;
        b=B9bYOMY+igXPnadgFV79j3vpWcljXWlJhTnAQ5cvBr8QYcoZc+zlIT2xles1PQLo+f
         jJPki3YK3Mx6UojEcPL/edoljMv42wURg2LCh+RGeQwyKb9uLrpRKv2q56EG7i+f7hgK
         q0OuDJjjLc6tVz8gdTJNmOtd52rFLyqrq8nh2FeGtnYzRBYruI7aNz+S0oYe63o7d4lw
         r7SVL+/jHnxVvU7xU53vZY/QJKp1+DQvakh8+SqkhLVHmIBmvUDX7hLk/MivcSE4LJPX
         1aAYapY03s229Hv6NEXXQjFa6lu6GXQI5tCwOKQx3cghg5/lsYqLPA09Dj+7jwPZP3K/
         76Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU54tkud+ymalB05nC+MXLwD99gezW0LiegAN3/JVo0bdsXtNr6XZgM97c4beffy3ybBkg2/ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxlQcVQEX9vHuE+/mZVKU6iMZhxmtB24Oke6GtLx+Ze2RROYc
	BpiyYGMXdAg0UAl5c23i59wasPqfBDXdnVxNZdRBQ5HxRfbfcjvyjbPW
X-Gm-Gg: AY/fxX5TExsuVb5JYqpFjH0MfXSOHPP/zVKIS1oG9gXMQch4HF2WMJvdqIkz84WCdk3
	2qFQ+MdR839zIlfmU8Kn8TnK8cCQ3sqiZh7TwtEGTv7ZWKjYkSaSymDjg/ScmD4r4WAEwcxY80T
	iw1o4WdoOR/bNXaCusbCz7SDDz/Z0h7UnvxqBTbIMLIEc1IeYTm8l9kEjCsWs7etpHDLbREVq27
	OS8z/L+Bkmw+tgZ6d5BqNzEcHb98066eBoS9R1sxiiyyZNKZUVyqONiB6lOHxIKL/TbPDvNo12x
	nEdH77GqxtZ7Ysx7fn/FDO6IOQexADksALGLrei6AghsOkiSDkMUoyI9uhrY105+Y4dMqyfMfAT
	qa696633ESqGdB6K5wssTopMZmF/S3D/DafmTBDErwix5LKCYFnPyqqQYXeqAQ+BWvgHM3WuuMS
	1GseHLX4GOFtCO3YbLm1OYy6kX4Sk0uGSDetpC0ooccMnWd0FrjQfwOTQbqdQ=
X-Google-Smtp-Source: AGHT+IF1kNyko2/aunhzKImSG09eNxw2JlgAGhDHArIZb7G6aSKIolFuJDc9tXU8N7wqRpkgMhtkYA==
X-Received: by 2002:a05:690e:4195:b0:644:45a9:c0d7 with SMTP id 956f58d0204a3-64716bd2f23mr13578847d50.55.1768188520864;
        Sun, 11 Jan 2026 19:28:40 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa6a7abdsm64674707b3.44.2026.01.11.19.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 19:28:40 -0800 (PST)
Date: Sun, 11 Jan 2026 22:28:39 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.311e0b9ad88f0@gmail.com>
In-Reply-To: <willemdebruijn.kernel.555dd45f2e96@gmail.com>
References: <20260107110521.1aab55e9@kernel.org>
 <willemdebruijn.kernel.276cd2b2b0063@gmail.com>
 <20260107192511.23d8e404@kernel.org>
 <20260108080646.14fb7d95@kernel.org>
 <willemdebruijn.kernel.58a32e438c@gmail.com>
 <20260108123845.7868cec4@kernel.org>
 <willemdebruijn.kernel.13946c10e0d90@gmail.com>
 <willemdebruijn.kernel.555dd45f2e96@gmail.com>
Subject: Re: [TEST] txtimestamp.sh pains after netdev foundation migration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > On Thu, 08 Jan 2026 14:02:15 -0500 Willem de Bruijn wrote:
> > > > Increasing tolerance should work.
> > > > 
> > > > The current values are pragmatic choices to be so low as to minimize
> > > > total test runtime, but high enough to avoid flakes. Well..
> > > > 
> > > > If increasing tolerance, we also need to increase the time the test
> > > > waits for all notifications to arrive, cfg_sleep_usec.
> > > 
> > > To be clear the theory is that we got scheduled out between taking the
> > > USR timestamp and sending the packet. But once the packet is in the
> > > kernel it seems to flow, so AFAIU cfg_sleep_usec can remain untouched.
> > > 
> > > Thinking about it more - maybe what blocks us is the print? Maybe under
> > > vng there's a non-trivial chance that a print to stderr ends up
> > > blocking on serial and schedules us out? I mean maybe we should:
> > > 
> > > diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> > > index abcec47ec2e6..e2273fdff495 100644
> > > --- a/tools/testing/selftests/net/txtimestamp.c
> > > +++ b/tools/testing/selftests/net/txtimestamp.c
> > > @@ -207,12 +207,10 @@ static void __print_timestamp(const char *name, struct timespec *cur,
> > >         fprintf(stderr, "\n");
> > >  }
> > >  
> > > -static void print_timestamp_usr(void)
> > > +static void record_timestamp_usr(void)
> > >  {
> > >         if (clock_gettime(CLOCK_REALTIME, &ts_usr))
> > >                 error(1, errno, "clock_gettime");
> > > -
> > > -       __print_timestamp("  USR", &ts_usr, 0, 0);
> > >  }
> > >  
> > >  static void check_timestamp_usr(void)
> > > @@ -636,8 +634,6 @@ static void do_test(int family, unsigned int report_opt)
> > >                         fill_header_udp(buf + off, family == PF_INET);
> > >                 }
> > >  
> > > -               print_timestamp_usr();
> > > -
> > >                 iov.iov_base = buf;
> > >                 iov.iov_len = total_len;
> > >  
> > > @@ -692,10 +688,14 @@ static void do_test(int family, unsigned int report_opt)
> > >  
> > >                 }
> > >  
> > > +               record_timestamp_usr();
> > >                 val = sendmsg(fd, &msg, 0);
> > >                 if (val != total_len)
> > >                         error(1, errno, "send");
> > >  
> > > +               /* Avoid I/O between taking ts_usr and sendmsg() */
> > > +               __print_timestamp("  USR", &ts_usr, 0, 0);
> > > +
> > >                 check_timestamp_usr();
> > >  
> > >                 /* wait for all errors to be queued, else ACKs arrive OOO */
> > 
> > Definitely worth including.
> > 
> > Could it be helpful to schedule at RR or FIFO prio. Depends on the
> > reason for descheduling. And it only affects priority within the VM.
> > 
> > I'm having trouble reproducing it in vng both locally and on 
> > netdev-virt.
> > 
> > At this point, an initial obviously correct patch and observe how
> > much that mitigates the issue is likely the fastest way forward.
> 
> Instead of increasing tolerance, how about optionally allowing one
> moderate timing error:
> 
> @@ -166,8 +167,15 @@ static void validate_timestamp(struct timespec *cur, int min_delay)
>         if (cur64 < start64 + min_delay || cur64 > start64 + max_delay) {
>                 fprintf(stderr, "ERROR: %" PRId64 " us expected between %d and %d\n",
>                                 cur64 - start64, min_delay, max_delay);
> -               if (!getenv("KSFT_MACHINE_SLOW"))
> -                       test_failed = true;
> +               if (!getenv("KSFT_MACHINE_SLOW")) {
> +                       if (cfg_num_max_timing_failures &&
> +                           (cur64 <= start64 + (max_delay * 2))) {
> +                               cfg_num_max_timing_failures--;
> +                               fprintf(stderr, "CONTINUE: ignore 1 timing failure\n");
> +                       } else {
> +                               test_failed = true;
> +                       }
> +               }
>         }
>  }
> 
> @@ -746,6 +755,10 @@ static void parse_opt(int argc, char **argv)
>                 case 'E':
>                         cfg_use_epoll = true;
>                         cfg_epollet = true;
> +                       break;
> +               case 'f':
> +                       cfg_num_max_timing_failures = strtoul(optarg, NULL, 10);
> +                       break;
> 
> +++ b/tools/testing/selftests/net/txtimestamp.sh
> @@ -30,8 +30,8 @@ run_test_v4v6() {
>         # wait for ACK to be queued
>         local -r args="$@ -v 10000 -V 60000 -t 8000 -S 80000"
>  
> -       ./txtimestamp ${args} -4 -L 127.0.0.1
> -       ./txtimestamp ${args} -6 -L ::1
> +       ./txtimestamp ${args} -f 1 -4 -L 127.0.0.1
> +       ./txtimestamp ${args} -f 1 -6 -L ::1
>  }
> 
> and some boilerplate.
> 
> Can fold in the record_timestamp_usr() change too.
> 
> I can send this, your alternative with Suggested-by, or let me know if
> you prefer to send that.
> 
> It's tricky to reproduce, but evidently on some platforms this occurs,
> so not unreasonable to give some leeway. A single UDP test runs 12
> timing validations: 4 packets * {SND, ENQ, END + SND} setups. A single
> TCP test runs additional {ACK, SND + ACK, ENQ + SND + ACK} cases. If
> we consider 1/12 skips too high, we could increase packet count. 

That should say 16 validations: ENQ + SND validates both.
 
> txtimestamp.sh runs 3 * 7 * 2 test variants. Alternatively we suppress
> 1 failure here, rather than in the individual tests.
> 
> Any of these approaches should significantly reduce the flake rate
> reported on netdev.bots.



