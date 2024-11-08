Return-Path: <netdev+bounces-143402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F749C247D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5DF1F23DDD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED31AA1E2;
	Fri,  8 Nov 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jnRzSjqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653891AA1CF
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088543; cv=none; b=tRG/fxt9Fli7P+DtAnrRDfK1HmXKlQHbqW/XYr99j9hDISazVruuZvINXn7zrUDJ2dP6DoGISdeOsrEpp0ng4cqH+0k43zqWm6ER87O9XCatovcXkxr4E7eQciIGaKz5MlUHldAaW2hzcY2VcgPPtgiSeRbPLVTDgMIRIMlSN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088543; c=relaxed/simple;
	bh=3XEEjpzoyVVjrFa8qZSsaTMnvXE7mOW7qLd0g684tUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxS9XYBQYu0W45s+liS/CHqp4MP2ApBnuJjP52QJlE2Xq4YZflR+Rx9VR5URt/5THmN5OlJA7PV7FPqLTX95mBPkd/FhMtcoI8Ha5QIjYvaNOH54egGt1dGpIDltGQQuJCaACN2RVeGQ7aLWfOVRNKgUGvFIiXGOpFHLuZ6nT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jnRzSjqs; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so2107957b3a.3
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 09:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731088541; x=1731693341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiPDLfL5JTBKeeqjpJ5u/XBxPNvTKsH7Pcb34HC2tGE=;
        b=jnRzSjqsfNVaVUDH5de4Ef18Vt94xLUiXdS/G53lVmdsJS4cWE6uBbVzkeU57hav/N
         z+bKKDi4SIKhuj5geSc9ApUMRjgwGvbuy78q8fFfP2nFDk8LX+zOpddLExhxu+uMVEV6
         1RwNdRfVWrgVhZ7e1VW8EKsVQgqdiwZ1Mk59g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088541; x=1731693341;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiPDLfL5JTBKeeqjpJ5u/XBxPNvTKsH7Pcb34HC2tGE=;
        b=PBRb0HuK8mxyxGZAlEgdycX29BPXM8AGAXkfWpF15M00x5L3GuwZpfpiFVaiIv0io5
         Uy18GafzJu+2NOCjoOwJ+WFPckARnIGEwNLRIXfLHH5rUFsFz6zcsBb2IImHZqd8MC/5
         AfQRQc2sgf8n2rxIjqLM5wKYMYGCjfCIG7KyOtf7v9oNrRfj5MBDIn9HnloK9yOU03at
         Q7yzMf9t6KeRKr+Mod0FEL/6VLGU5+kXULXhd0eG4qVPSt0yrWRLFftkCE/ZrRD4+dI2
         1LWfazf1xddBT3j7ZUBrBD3yDf0VcUN1V39ASrD9kVjxFWPu2mlxC1Hsx3OTRggOeUeS
         vaJQ==
X-Gm-Message-State: AOJu0Ywt31BmjBPGTV9iCOYrZEqwU0n+n9HttvdGhJkeG/01G3JcGEUP
	aJVqGkg42Czz5dy71HXiU9qbukqQ4vC9hwYyKFm2fw0nPFew1zMNbenC2DSzyXyuPQ89VE5LMVZ
	e
X-Google-Smtp-Source: AGHT+IERbFI+o+2LyayD4punr25StjJoWA4Jj2wzw5p0JjcDTHDRzT1/x7uQhWNXVNPsCLPYIGwlKQ==
X-Received: by 2002:a05:6a20:158c:b0:1db:da5e:361f with SMTP id adf61e73a8af0-1dc22a1b4d3mr5454374637.25.1731088540720;
        Fri, 08 Nov 2024 09:55:40 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ef5sm4141017b3a.63.2024.11.08.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:55:40 -0800 (PST)
Date: Fri, 8 Nov 2024 09:55:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v8 5/6] selftests: net: Add busy_poll_test
Message-ID: <Zy5QmNT5XqZUJ3f8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20241108045337.292905-1-jdamato@fastly.com>
 <20241108045337.292905-6-jdamato@fastly.com>
 <672e26ec429be_2a4cd22944c@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672e26ec429be_2a4cd22944c@willemb.c.googlers.com.notmuch>

On Fri, Nov 08, 2024 at 09:57:48AM -0500, Willem de Bruijn wrote:
> Joe Damato wrote:

[...]

> > diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/selftests/net/busy_poller.c
> > new file mode 100644
> > index 000000000000..8d8aa9e5939a
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/busy_poller.c
> > @@ -0,0 +1,328 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <assert.h>
> > +#include <errno.h>
> > +#include <error.h>
> > +#include <fcntl.h>
> > +#include <inttypes.h>
> > +#include <limits.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#include <arpa/inet.h>
> > +#include <netinet/in.h>
> > +
> > +#include <sys/ioctl.h>
> > +#include <sys/epoll.h>
> > +#include <sys/socket.h>
> > +#include <sys/types.h>
> > +
> > +#include <linux/netlink.h>
> > +#include <linux/genetlink.h>
> > +#include "netdev-user.h"
> > +#include <ynl.h>
> > +
> > +/* if the headers haven't been updated, we need to define some things */
> 
> This should not be needed, as headers are taken from $KERNELSRC/usr after
> make headers_install.
> 
> Generally discouraged for tests (else every new feature test for a new
> features is forced to adds such checks).

I get that, but the reason this is required is complex:

- sys/epoll.h defines epoll_data, which is needed by the program to
  access stuff like epoll_event.data.fd and linux/eventpoll.h does
  not. At the same time, older glibcs do not have the ioctl yet
  (I've sent a change to glibc to add it; I don't know which release
  it'll be in or when CI will be updated to a distro with that
  glibc).

- linux/eventpoll.h does not define epoll_event's data field, it's
  simply an opaque "__u64 data", but does include the ioctl
  definitions.

So, it'd seem I'd need parts of both headers... but of course you
can't include both, because they redefine types found in the other.

Maybe there's a solution I'm missing (please let me know), but it
seems that the only workable solution is to include the #ifdef blob
below, but perhaps with a comment explaining the above.

> > +#if !defined(EPOLL_IOC_TYPE)
> > +struct epoll_params {
> > +	uint32_t busy_poll_usecs;
> > +	uint16_t busy_poll_budget;
> > +	uint8_t prefer_busy_poll;
> > +
> > +	/* pad the struct to a multiple of 64bits */
> > +	uint8_t __pad;
> > +};
> > +
> > +#define EPOLL_IOC_TYPE 0x8A
> > +#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
> > +#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
> > +#endif


