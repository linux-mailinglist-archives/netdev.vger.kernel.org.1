Return-Path: <netdev+bounces-248876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 539EFD10786
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BAEF30217A1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145B330B53A;
	Mon, 12 Jan 2026 03:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgIQJ1zu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06A23BCEE
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188261; cv=none; b=n0VFW5qBv68n7YRn4ZIRUNsQBvqN5teIgmsjPaiARvIcbwdSdyAaFC8ioaMEbIvflVP7H8uNy5X/QR4nISz5uLh4HhnpN3Es0/TWdaL4ZgsTtWV/XrreNLcRuSHQDysTSO/ZvIgHJeLg0ChRizOeQuOq/S2QOfCmyU/oM2RoijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188261; c=relaxed/simple;
	bh=W8RnrYRpKBJ/XZpXKVKcNYYQwguTszgGpBaLkNIGfn8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ag/3w/7ndnT59I0jJrbNnp9VuKVi2YpcM6TrRqapGA+Nczgev2Cgpq7mr4WmWBCZ+PWihdVczkvC2VRP7GoEFdATV+7ITAFGHu4uLCMXbf6Kknam/SmYKI7SFZGtp+MuW5Y/Ib9f1NsFnOZyB40xRZxKCz9uWGFItxSi2i3lWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgIQJ1zu; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79273a294edso12550247b3.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 19:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768188258; x=1768793058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RKfNyLmlFc4XSShScbUS2enlCtrapVWe1EjsygcBUY=;
        b=ZgIQJ1zu0pSkcAIsl3smUVlWSAMh75k0JXiWcAHjFVDvfGEaeTK5IHv10996e5gUjL
         EKSQGgGsdTgnWPqSjYEb4HxmrVClxTiYKVzoDEzf4AwW2uGsGaT/n2rpahZI2iJI4Kn5
         t17Zgkz3uRVigTk3SV/Mb48kWsJbvM2PUFEdGDh9wWPrEHS9ctF4lNYRfAOg3vNIpXxW
         qK+TqHb3VKK1U5yZUZzWLXBsmoOgdyNJZWzW6DthvDL4iwgDHy1A5/upM6IVz4FhXd8z
         tU6QYA0iph7+ECmcGnE9p+OUcpFIc3vO3MKAQ8/LtldIvkFAGD9Yu7ZfPut/KEIu2xIu
         myTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768188258; x=1768793058;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RKfNyLmlFc4XSShScbUS2enlCtrapVWe1EjsygcBUY=;
        b=a9A12Y8rwIWavXBNQHl6IQXWf4N3hZWZBH+DHiT1bZeABFjxCshMOAo/M8FehtBh7p
         KFp2Pq5JO/t23qiusNsOMcjKMiP2N74titD6/y4HcwLv9d+TXWuJ14yOBOFdq/IWyuPg
         rPMNgHSVhFsG9g4/mg8oxuzhhrfJXwpHomPlNONZTrTeaaze9vroJQ13seDBX20GPIn0
         b9A1F8tABvnzMnlg9rh8WsOaT//isCbHow5TekDqNlQn/3Z7bVmIaiJ6ws0a6pbgLVGK
         Ik6NTzSt1YaE7Q9a/x8+S3YC63w/Qt0bBU76eRRNJ1FqXU1j5pFX5k12h0rXAJ6uj7Va
         0o+A==
X-Forwarded-Encrypted: i=1; AJvYcCXiF6eZof2wHDS3MV+HL1SZPwxfD4CcHuM+Q6hC6ywBBxCjPZMx9b4p7I5KMRBKLsrXC7bZ5Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkaowTZ/QVxiIT+UygcRh/Xnvbfn9Ict+3kmiCNhl4d5j3lzd
	+TKZb+VyLz7D0+QEMiuRSuUIS38PebrdN98M27Ua8V4Ni4cQBIrAgKto
X-Gm-Gg: AY/fxX4KKwV1JwOp2NhCvsBoKvZnhlWlu2ameh2ptJLKkFkKJsuXU04wTiXRrkIbjls
	ATVx5aYl6VxaJqmE+rLZFug87aJ5bVEm0JBRxeFoHt1eJ+KWREYA46hsrFP9DklzXAVGxSuIVQy
	Y9a2j/K7L0XvG1OiiCvxsen4G+9zFCjVaHB+C6rgsvl+5rEG6+xCD4lrWK/oDVCCZISYFtm4wHb
	ZlFWx636PfhZOSXSVjdw2aTYewZq9IIewWZHE1R64fmijIeKMecDBLB4G1n4WXBqrdw3CEASQ4w
	VhPJJsWDh0SlF04FvwltaGk4oJQsiHziEBDBFCR1voRtHMYuWBOrBnf8E7Ry2e9TugeK+SehR1D
	jrKl1nlk8ubD4LAjWZhq3cwlj68YzstFpvyycLnJd+yvYkgSqVxZIamn/GDUQ09Bd3FvIZN3Xf7
	FPKmhxVBHFn4faj/sTySZtZx8cUCh2cQI/emuonYgCGZDmOe6aEDVgyJzEwLY=
X-Google-Smtp-Source: AGHT+IE303BEuJhWJx9U8oU8f+hk/nXxfxEdxSeEWUjcApV0XwoScqYejHNh4E27dOftSVA56q6agA==
X-Received: by 2002:a05:690e:58a:b0:63f:9448:e81 with SMTP id 956f58d0204a3-64716baea7fmr10831503d50.39.1768188258417;
        Sun, 11 Jan 2026 19:24:18 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d89d4besm7589329d50.13.2026.01.11.19.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 19:24:17 -0800 (PST)
Date: Sun, 11 Jan 2026 22:24:17 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.555dd45f2e96@gmail.com>
In-Reply-To: <willemdebruijn.kernel.13946c10e0d90@gmail.com>
References: <20260107110521.1aab55e9@kernel.org>
 <willemdebruijn.kernel.276cd2b2b0063@gmail.com>
 <20260107192511.23d8e404@kernel.org>
 <20260108080646.14fb7d95@kernel.org>
 <willemdebruijn.kernel.58a32e438c@gmail.com>
 <20260108123845.7868cec4@kernel.org>
 <willemdebruijn.kernel.13946c10e0d90@gmail.com>
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
> Jakub Kicinski wrote:
> > On Thu, 08 Jan 2026 14:02:15 -0500 Willem de Bruijn wrote:
> > > Increasing tolerance should work.
> > > 
> > > The current values are pragmatic choices to be so low as to minimize
> > > total test runtime, but high enough to avoid flakes. Well..
> > > 
> > > If increasing tolerance, we also need to increase the time the test
> > > waits for all notifications to arrive, cfg_sleep_usec.
> > 
> > To be clear the theory is that we got scheduled out between taking the
> > USR timestamp and sending the packet. But once the packet is in the
> > kernel it seems to flow, so AFAIU cfg_sleep_usec can remain untouched.
> > 
> > Thinking about it more - maybe what blocks us is the print? Maybe under
> > vng there's a non-trivial chance that a print to stderr ends up
> > blocking on serial and schedules us out? I mean maybe we should:
> > 
> > diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> > index abcec47ec2e6..e2273fdff495 100644
> > --- a/tools/testing/selftests/net/txtimestamp.c
> > +++ b/tools/testing/selftests/net/txtimestamp.c
> > @@ -207,12 +207,10 @@ static void __print_timestamp(const char *name, struct timespec *cur,
> >         fprintf(stderr, "\n");
> >  }
> >  
> > -static void print_timestamp_usr(void)
> > +static void record_timestamp_usr(void)
> >  {
> >         if (clock_gettime(CLOCK_REALTIME, &ts_usr))
> >                 error(1, errno, "clock_gettime");
> > -
> > -       __print_timestamp("  USR", &ts_usr, 0, 0);
> >  }
> >  
> >  static void check_timestamp_usr(void)
> > @@ -636,8 +634,6 @@ static void do_test(int family, unsigned int report_opt)
> >                         fill_header_udp(buf + off, family == PF_INET);
> >                 }
> >  
> > -               print_timestamp_usr();
> > -
> >                 iov.iov_base = buf;
> >                 iov.iov_len = total_len;
> >  
> > @@ -692,10 +688,14 @@ static void do_test(int family, unsigned int report_opt)
> >  
> >                 }
> >  
> > +               record_timestamp_usr();
> >                 val = sendmsg(fd, &msg, 0);
> >                 if (val != total_len)
> >                         error(1, errno, "send");
> >  
> > +               /* Avoid I/O between taking ts_usr and sendmsg() */
> > +               __print_timestamp("  USR", &ts_usr, 0, 0);
> > +
> >                 check_timestamp_usr();
> >  
> >                 /* wait for all errors to be queued, else ACKs arrive OOO */
> 
> Definitely worth including.
> 
> Could it be helpful to schedule at RR or FIFO prio. Depends on the
> reason for descheduling. And it only affects priority within the VM.
> 
> I'm having trouble reproducing it in vng both locally and on 
> netdev-virt.
> 
> At this point, an initial obviously correct patch and observe how
> much that mitigates the issue is likely the fastest way forward.

Instead of increasing tolerance, how about optionally allowing one
moderate timing error:

@@ -166,8 +167,15 @@ static void validate_timestamp(struct timespec *cur, int min_delay)
        if (cur64 < start64 + min_delay || cur64 > start64 + max_delay) {
                fprintf(stderr, "ERROR: %" PRId64 " us expected between %d and %d\n",
                                cur64 - start64, min_delay, max_delay);
-               if (!getenv("KSFT_MACHINE_SLOW"))
-                       test_failed = true;
+               if (!getenv("KSFT_MACHINE_SLOW")) {
+                       if (cfg_num_max_timing_failures &&
+                           (cur64 <= start64 + (max_delay * 2))) {
+                               cfg_num_max_timing_failures--;
+                               fprintf(stderr, "CONTINUE: ignore 1 timing failure\n");
+                       } else {
+                               test_failed = true;
+                       }
+               }
        }
 }

@@ -746,6 +755,10 @@ static void parse_opt(int argc, char **argv)
                case 'E':
                        cfg_use_epoll = true;
                        cfg_epollet = true;
+                       break;
+               case 'f':
+                       cfg_num_max_timing_failures = strtoul(optarg, NULL, 10);
+                       break;

+++ b/tools/testing/selftests/net/txtimestamp.sh
@@ -30,8 +30,8 @@ run_test_v4v6() {
        # wait for ACK to be queued
        local -r args="$@ -v 10000 -V 60000 -t 8000 -S 80000"
 
-       ./txtimestamp ${args} -4 -L 127.0.0.1
-       ./txtimestamp ${args} -6 -L ::1
+       ./txtimestamp ${args} -f 1 -4 -L 127.0.0.1
+       ./txtimestamp ${args} -f 1 -6 -L ::1
 }

and some boilerplate.

Can fold in the record_timestamp_usr() change too.

I can send this, your alternative with Suggested-by, or let me know if
you prefer to send that.

It's tricky to reproduce, but evidently on some platforms this occurs,
so not unreasonable to give some leeway. A single UDP test runs 12
timing validations: 4 packets * {SND, ENQ, END + SND} setups. A single
TCP test runs additional {ACK, SND + ACK, ENQ + SND + ACK} cases. If
we consider 1/12 skips too high, we could increase packet count. 

txtimestamp.sh runs 3 * 7 * 2 test variants. Alternatively we suppress
1 failure here, rather than in the individual tests.

Any of these approaches should significantly reduce the flake rate
reported on netdev.bots.

