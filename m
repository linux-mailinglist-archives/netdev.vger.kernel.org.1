Return-Path: <netdev+bounces-183831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB46A922C3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E019E62C7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6A254AED;
	Thu, 17 Apr 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="L2BHWXuB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4142DFA36
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907600; cv=none; b=teM10uD5EVbLStgh3JKJyfPsSP7rGB9lnSPpikheC1WrVj0HuM/CTGnZ1xcODqnIR4/eaa1Z2b4NoSlwVmZJfH2uPjFN7hr0VoIn/7OvR+dwbJaGnaQsGr1U6t/YLZfT3hwUuZn1pfyxzl6DXl1IeDzz4AvTEJc4u/QDcOYOU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907600; c=relaxed/simple;
	bh=MorJ0Vcovdi4XLQZKAYt8UWHrt+gqIuT1WCj8KBdkGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOme4Rs0h9CPOlLLHoR2m6ygea2IWJDKqj/3/jOQ9h8U75HXlQxNJMgurkTdRI9Te+6z85YC1dDfw/x2/Sl3nQAu/T7ELzjTSB27x90OZ5Be+w4dJ8+Kpoeu72U1wSlKNZgvEw602VZb7nI6rnAr08Cd+IM+t6+rIs9J2hecTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=L2BHWXuB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2241053582dso15591185ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744907598; x=1745512398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mprfwwo0Da4LxnvcuRCJo8vR8B5fCLfrLhkCs2VqZg0=;
        b=L2BHWXuBfQDvEXIUJ2E9Y9ISzkb04o6NxilKIALyLn2k/F1a/k/Jhtew0qp5NcaQR+
         yBdIBb8V6lIarsQgoYIsyEUKb3xUnfQacsT219Ndp3wvcv099AiTTvzUUq2YQmyiX/y8
         QyAwIvSBEgeqtE6O7ZOsAZUTJUcM29nhF2obE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744907598; x=1745512398;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mprfwwo0Da4LxnvcuRCJo8vR8B5fCLfrLhkCs2VqZg0=;
        b=uckJwnVoBxIeQ1JDQmQ0RP9wgcYBWk6mFVoj3FBULaHw2dO5BjzNnTn+2POMW/Ljqr
         bUGHzP1M5ESf172gKz6FQoSZt4ydjTJuxc5FTHkj46B5InFZ1NQ+xyANaSbRNYo0r9NG
         D/UdewbcTehvASir+fbcOFLoefdmMqDXxYYRbWPSlOkaDoORRWVWUCn6Wmy5eHC7PkgA
         E6n27S2pM0dv1xOXK8BleMAl6hHyL42bN8KkHJrE5Tn1J/FTeF8YU1Qan/6w6ylHFP1k
         Ct5a9FltKOumOJoOKhVHuKDFF2Rkd7nUsbFPNL55A7M3hP6zS2OM3Go7e65vDqJRbXyJ
         knzA==
X-Gm-Message-State: AOJu0Yz5lt4XwhwOx6oPxGoHFVZn+Rz6vEsBBuB1GKWHbIqgkWLaXeO4
	D4/J4rkxVSiwAqZsTC8CQfmFy+VbuGvvWZ54MixaitGnnr2d2bPCpwpGjJ4W1U8=
X-Gm-Gg: ASbGncvBCgSnXw4gVtKVPsTmWS+Ek4oVr3H/c6aN13od4dzStZyQyVcXi1Q6ebkDKzc
	xr9H4tEnMJbfTHhhKwuItOA+p7FclU7BDeampb/e6OcAlENQ2+JRYEBahwQEg5i/CKP3CRpW3Es
	AOtRbK72J7tr/2l76RWOIroiJ7PFXDml9HLzYJkAtnEI1N6BZdruVq3kVOeO9VtRd1y1OYnJ5e7
	VGJX/+1XxY6gU9RoC/4338vCjFPgIUoHHsjK+d5UgQsAjK3GqMjBhySe5YgcfrH76p0HUHRud9c
	PPlRzYV3VE1Qnu4YZhSsX+/IGCHuEMrHtbYynd3sUbrvqt//4Jq8UAhJRl1BiAzruSSWDSp4njT
	20ORrbYxlMfAC
X-Google-Smtp-Source: AGHT+IGJpmGDv/RmZoBpASwHCPsKTxrbaXtrzgvFEb/fiM5N6VFMbYf2bDKD9j/RfqFYVUJiTtyDyA==
X-Received: by 2002:a17:902:ce91:b0:224:1ce1:a3f4 with SMTP id d9443c01a7336-22c358c543amr88775005ad.1.1744907597917;
        Thu, 17 Apr 2025 09:33:17 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdae5dsm2114315ad.35.2025.04.17.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:33:17 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:33:14 -0700
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is
 non-zero
Message-ID: <aAEtSppgCFNd8vr4@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250417013301.39228-1-jdamato@fastly.com>
 <20250417013301.39228-5-jdamato@fastly.com>
 <b1fa9607-f9bd-4feb-a22f-55453a9403e9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1fa9607-f9bd-4feb-a22f-55453a9403e9@redhat.com>

On Thu, Apr 17, 2025 at 09:26:22AM +0200, Paolo Abeni wrote:
> On 4/17/25 3:32 AM, Joe Damato wrote:
> > diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
> > new file mode 100755
> > index 000000000000..aee6f90be49b
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/napi_id.py
> > @@ -0,0 +1,24 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +from lib.py import ksft_run, ksft_exit
> > +from lib.py import ksft_eq, NetDrvEpEnv
> > +from lib.py import bkg, cmd, rand_port, NetNSEnter
> > +
> > +def test_napi_id(cfg) -> None:
> > +    port = rand_port()
> > +    listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']} {port}'
> 
> Not really a full review, but this is apparently causing self-tests
> failures:
> 
> # selftests: drivers/net: napi_id.py
> #   File
> "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./napi_id.py",
> line 10
> #     listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']}
> {port}'
> #                                                                   ^
> # SyntaxError: f-string: unmatched '['
> not ok 1 selftests: drivers/net: napi_id.py # exit=1
> 
> the second "'" char is closing the python format string, truncating the
> cfg.addr_v['4'] expression.
> 
> Please run the self test locally before the next submission, thanks!

I did run it locally, many times, and it works for me:

$ sudo ./tools/testing/selftests/drivers/net/napi_id.py
TAP version 13
1..1
ok 1 napi_id.test_napi_id
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Maybe this has something to do with the Python version on my system
vs yours/the test host?

I am using Python 3.13.1 from Ubuntu 24.04.

Please let me know what Python version you are using so I can try to
reproduce this locally ?

