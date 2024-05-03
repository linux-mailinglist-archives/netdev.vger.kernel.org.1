Return-Path: <netdev+bounces-93397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D58BB7F4
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 01:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF99E1C233BD
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A1D83A01;
	Fri,  3 May 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="S6smFOt8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A682D64
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777837; cv=none; b=pZiR+a0K4hwU4qzcbGNgtUlr9JMuv2mXWwDTEwe7zod75moM2myq6tzvurN6PyzqUFlVs02RIc/vfHcFDKUclrfq7Bc/UAEtzIR5RxKFSRRDJd+VPaWQDM2tPsl3VKFxJyIxl35GM/a3m381F4dEW81aN7oBWY/ntkQK6cZNQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777837; c=relaxed/simple;
	bh=8bql15+WJxfp3Z5uXrUiklNLUX4PjAwhtOGWgb3atIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHOJ2qHVPa9yMfMCXE/PsH3XQ/JfXw2Zp6zXVX6pm58+kCSliQMWBej2y6u7kiYxrbdWBQ5Jvxs/8e9Tm4CfzmRRFpXp6n1RIN0lfl7JMY58QSr5zJe+eOtEtuD7tQ8sjsbb0eiSZjXiVcNdWaHOuU3fEkhPORXlB8K0ruZqHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=S6smFOt8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed627829e6so237430b3a.1
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714777835; x=1715382635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pijrexf3avf2m9MLIxwafUqtRHr1mW9+cEjHYs/cYcA=;
        b=S6smFOt8NwK4enGVQZ7Pv3REgUWOEx7hoJxwppWxRiMwYwOLkIU7lu/Wodz5HD7kZl
         0+s1LgFwb4zMT3vhN1Ygp3lggngnR0ZH0j8ysYpiDm2QjztrJVq0u+VK31wOAQlK7EDQ
         PmFY+/WDBRU520g9loBEHrknYmjBTALUlFP3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714777835; x=1715382635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pijrexf3avf2m9MLIxwafUqtRHr1mW9+cEjHYs/cYcA=;
        b=VDzZzktVrhxXMP4D9x+Jy8RS86Ay+zR8YCHbKhMt57+YzeDixbNafgW6L5nnUbEvy6
         vKAoBdTwA3/kJtRZIxREheK2W8y1nx5NMt6bf9GG/a4fZzXCj3u5370uMURmXZ46t5hD
         ApuhlzPgVPdN7wBtHkdFn+3G/rJ4ft9PmuWZWIKHyuYCXBSUa9JlBKDG5V1orWQ1SncM
         3O41+nS23M51vel9UNgPdvAazwezUe2R7BHnh8/Wm1wZnC170255l0Kb9MaL/c1degTC
         ryDP7HaOcPpaqo79qSn82zQwHJ+Fr5ltTI/Fbsd5Uhf3pIsPnoS0X4hVSlB7a9/lEuSW
         MLow==
X-Forwarded-Encrypted: i=1; AJvYcCVUIIQ2UNP5wsouZ04QfQNBsIkLreZKOp+R1ISdUL3W+wfLnPY2z257zeb29EtFQk/ANif6RZgUeRBhoauQrYBtQDGPmzRu
X-Gm-Message-State: AOJu0Ywi95iDH68f885urxax0F5ks2j+wUKjkZYz5FGnrvij7BrO9/Yt
	QHtKlmzgcXgJ9l0xMNTCsytxP6tOK+5GvRYxT8+DoYXdu0PLa0kK/wPymztbQCU=
X-Google-Smtp-Source: AGHT+IGiDKSOUib7i2rMcmQSoz81TAxeZsNV7h+A2FCrlcDJZ6JK7dxbbcseOVX5A3oOQi65/TApkw==
X-Received: by 2002:a05:6a20:dea6:b0:1a7:807:ca2 with SMTP id la38-20020a056a20dea600b001a708070ca2mr4103801pzb.29.1714777835231;
        Fri, 03 May 2024 16:10:35 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a001ace00b006f3eee787d5sm3725613pfv.18.2024.05.03.16.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:10:13 -0700 (PDT)
Date: Fri, 3 May 2024 16:09:45 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next] selftest: epoll_busy_poll: epoll busy poll tests
Message-ID: <ZjVuuVj2qGHrvqtT@LQ3V64L9R2>
References: <20240502212013.274758-1-jdamato@fastly.com>
 <20240503154939.79f7c878@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503154939.79f7c878@kernel.org>

On Fri, May 03, 2024 at 03:49:39PM -0700, Jakub Kicinski wrote:
> On Thu,  2 May 2024 21:20:11 +0000 Joe Damato wrote:
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -84,6 +84,7 @@ TEST_GEN_FILES += sctp_hello
> >  TEST_GEN_FILES += csum
> >  TEST_GEN_FILES += ip_local_port_range
> >  TEST_GEN_FILES += bind_wildcard
> > +TEST_GEN_FILES += epoll_busy_poll
> 
> "GEN" is for files which are built for other tests to use.
> IOW unless there's also a wrapper script under TEST_PROGS
> (or the C code is itself under TEST_PROGS) this test won't
> be executed by most CIs.

Ah, I see. OK.

If I decided to go with the kselftest_harness as mentioned below, I'd need
to include a wrapper script to run the binary with the right cmd line
arg(s) and put that in TEST_PROGS?

> FWIW here's how we run the tests in our CI upstream CI:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

Thanks for the link, I'll give this a close read.

> >  TEST_PROGS += test_vxlan_mdb.sh
> >  TEST_PROGS += test_bridge_neigh_suppress.sh
> >  TEST_PROGS += test_vxlan_nolocalbypass.sh
> 
> > +static void do_simple_test(void)
> > +{
> > +	int fd;
> > +
> > +	fd = epoll_create1(0);
> > +	if (fd == -1)
> > +		error(1, errno, "epoll_create");
> > +
> > +	do_simple_test_invalid_fd();
> > +	do_simple_test_invalid_ioctl(fd);
> > +	do_simple_test_get_params(fd);
> > +	do_simple_test_set_invalid(fd);
> > +	do_simple_test_set_and_get_valid(fd);
> 
> You don't want to use the kselftest_harness for this?
> No strong preference here, but seems like you could
> pop the epoll_create1 into a FIXTURE() and then the
> test cases into TEST_F() and we'd get the KTAP output
> formatting, ability to run the tests selectively etc.
> for free.

I have no preference. I looked at some random .c file test in the directory
and it wasn't using the kselftest_harness stuff so I just went with that.

The advantages of kselftest_harness make sense, so I can give it a rewrite
to use kselftest_harness in v2.

> tools/testing/selftests/net/tap.c is probably a good example 
> to take a look at

Thanks, I'll look at that one. I had previously just kinda scanned
reuseaddr_conflict.c and rxtimestamp.c and some other ones. Seemed like a
bunch were just regular C programs so I went that route, but the advantages
you list make a lot of sense.

