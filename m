Return-Path: <netdev+bounces-142059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830F9BD3BB
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAB41F219E0
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322831E3DD0;
	Tue,  5 Nov 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FmQI/1O5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A83BBC9
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828981; cv=none; b=eTepIf6W+p86mLUPS/ZxFGbBC5KNKk1dvKSddW7Yli5kXDy/78gZWeyhtSturxPgPATAokE3lztx6YV1IHcL8GbyRciVJJRRvRsCKWmedmntuIc7J1m30kHg0U0XZpkfCfyyBpzOl2BY7lcmAPCP5gv6/Sbu1tfNpdYn4+1lQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828981; c=relaxed/simple;
	bh=RRF5U8tAQnSK3UKLGuHHOJq0T4dm9N/cgBey4h+O7mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5mlrQTQtRNUGNI+Xkr86C7SBgZQcMkFPVRG5G0//8cQmH2uGTrFZb91BUS1r4aDbUWcL+6lVtGgHK4MAWd7E0PmDadzx8noatOWjQJx/r01sGNBEc9UUuPhdTsNwFvUXbqMdwnOJqi2pgfzpjYX103PHCea62diNOMF4pJLX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FmQI/1O5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72041ff06a0so5006773b3a.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730828978; x=1731433778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMzKbSIpX3mvzvQR0Yzs9HjJk/ktoL8ua8KQe/q9MvA=;
        b=FmQI/1O5llhDEGHSnDtYN6Ya8Dow3iWUMSRi3CHezNdWQc2v/GUboPH6kSvVxZrQvQ
         WnzNStttDljTp50Rh43GUp8BzEXTfu9ndcMFmPRNXFyDo/mMZmAG58YrenCOZBZX1zOe
         tYQXGQzZRpAfviiPcbjzOfnu733jf5pyhC5hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828978; x=1731433778;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMzKbSIpX3mvzvQR0Yzs9HjJk/ktoL8ua8KQe/q9MvA=;
        b=BG6He2GyQkMl17YGoad/n59Erkr48vNEwBrGZ2X+JhZoXT4RTL8WyuQVTkn9Ol00qT
         dlHhSubzds76BBK5XnoeQQJU1OqOzVbwqfQLHgSBvvpNewgSCJryPyiEFkpgHrOBpYC1
         BvwfcJzAtjwD7t4Rex9cYj5S86UN6HnwML92sth2kG/SxTCIE3p+rGw7Drfpr+uMytni
         fAIdHPX35nV32twNH6HoyREyyoppTOsbDUhr2TA1n8yZoAH1RsTc4d8t3vf5XAvZxdn5
         tSpFoUFgThxjHbiL9PRmqONRSZQMgwgVEJ9aaQSggOW9xW3e3PtkBr35sLhyUvvWlqk8
         KQ/Q==
X-Gm-Message-State: AOJu0YwiTowUFESm/qsc7vLQLSp5ZTOW8CjZLgg0FEb3sgGmPqEw50so
	ajH9STqV2AnDmBwii9+q/JW76e9pNY3hR2/UdlIcUHAwrHGkgZZfZqGjAUrUgfY=
X-Google-Smtp-Source: AGHT+IH72LWlvV5YwzbNJmSCHjy69fJ5cjez1djOBKUFklx1Q86a4TexGBSJjtXaFbhOQqz1l5GjHw==
X-Received: by 2002:a05:6a00:1490:b0:71d:eb7d:20ed with SMTP id d2e1a72fcca58-720c98adb50mr25107200b3a.12.1730828977870;
        Tue, 05 Nov 2024 09:49:37 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b892bsm10241582b3a.13.2024.11.05.09.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:49:37 -0800 (PST)
Date: Tue, 5 Nov 2024 09:49:33 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v6 6/7] selftests: net: Add busy_poll_test
Message-ID: <ZyparShLqRVi69ed@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	corbet@lwn.net, hdanton@sina.com, bagasdotme@gmail.com,
	pabeni@redhat.com, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20241104215542.215919-1-jdamato@fastly.com>
 <20241104215542.215919-7-jdamato@fastly.com>
 <ZymV_dgbVKW49595@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZymV_dgbVKW49595@mini-arch>

On Mon, Nov 04, 2024 at 07:50:21PM -0800, Stanislav Fomichev wrote:
> On 11/04, Joe Damato wrote:
> > Add an epoll busy poll test using netdevsim.
> > 
> > This test is comprised of:
> >   - busy_poller (via busy_poller.c)
> >   - busy_poll_test.sh which loads netdevsim, sets up network namespaces,
> >     and runs busy_poller to receive data and socat to send data.
> > 
> > The selftest tests two different scenarios:
> >   - busy poll (the pre-existing version in the kernel)
> >   - busy poll with suspend enabled (what this series adds)
> > 
> > The data transmit is a 1MiB temporary file generated from /dev/urandom
> > and the test is considered passing if the md5sum of the input file to
> > socat matches the md5sum of the output file from busy_poller.
> > 
> > netdevsim was chosen instead of veth due to netdevsim's support for
> > netdev-genl.
> > 
> > For now, this test uses the functionality that netdevsim provides. In the
> > future, perhaps netdevsim can be extended to emulate device IRQs to more
> > thoroughly test all pre-existing kernel options (like defer_hard_irqs)
> > and suspend.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---

[...]

> > +
> > +static void run_poller(void)
> > +{
> > +	struct epoll_event events[cfg_max_events];
> > +	struct epoll_params epoll_params = {0};
> > +	struct sockaddr_in server_addr;
> > +	int i, epfd, nfds;
> > +	ssize_t readlen;
> > +	int outfile_fd;
> > +	char buf[1024];
> > +	int sockfd;
> > +	int conn;
> > +	int val;
> 
> [..]
> 
> > +	outfile_fd = open(cfg_outfile, O_WRONLY | O_CREAT, 0644);
> > +	if (outfile_fd == -1)
> > +		error(1, errno, "unable to open outfile: %s", cfg_outfile);
> 
> Any reason you're not printing to stdout? And then redirect it to a file
> in the shell script if needed. Lets you save some code on open/close
> and flag parsing :-p But I guess can keep it since you already have it
> all working.

No reason in particular; I thought about this while writing it, but
ended up adding it as a flag in case others come along to extend
this test in some capacity.

> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks for the ack!

