Return-Path: <netdev+bounces-185332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557EAA99C7C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C2719401FF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641717D2;
	Thu, 24 Apr 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Csvn8Oix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AF383
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453170; cv=none; b=DRrg/MTE8tzqlYpEqmhBZCPmqoVZPZFpgm+PRORR3MWTV52f1eZJZghbUMdYCnKJbc40O33NH1xoOsFTNCAN9k5IoY0xj/geIjSDpDH3JwGgpmjM5xEUbIAPjbiT9+F2CyzDSuyv9AhZ7jQBzFiuhsVpOO4dgrS1x9AEvUWO0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453170; c=relaxed/simple;
	bh=mVT9IY0iZtItMWBqylUMmJqk8EaUvrBNBHLL55g1PgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC/Q7H8koNDCu0rmQpqjg7wj7rsbFYL3poa4NKK7W115fiPAWIQCo79jE5Lg5LxOSUUQEeD2Yw2Yoisferfl1rLDKQ8uX1KqxrMBnMG3u5HaktMqkVIVSQyqCoYsFro/7/nmc4LfIYOqwyWr4jCgwBv1fW7ZaEOSXAyDhl1qGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Csvn8Oix; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22409077c06so6582755ad.1
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 17:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745453168; x=1746057968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A13DmWW4IFyC+2QEpgeShC0monFDWua+5RM+sHVw7DQ=;
        b=Csvn8Oix9SuglDdRamLqqkrPAT+UpkUjKCnbm69tqfbx7QwYZzm9w8ZUH2Wm2lWWrb
         orCaK6Jwi0OIr9NZ/JuPflnM+NsYryiEGrPp8/d3qe801VRlMIZr861Pt3uRsNJBd+RX
         UprO46LrB3CFIrao2EaZrKqJNOSTntikxpZUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745453168; x=1746057968;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A13DmWW4IFyC+2QEpgeShC0monFDWua+5RM+sHVw7DQ=;
        b=g0xR6XqtWb1Ey3xLi3h5Jm2oApisIYWi2mcjiUZV6Y+scO2YXqfFyFBCqMzLQ9bNaT
         uimXf56BLrsYOapMAFarQplwBc7I2MEYkVSbBmR/mv1UyG8MbqvVf31awtcN5bUhRy2S
         o4MOYmmI4bKYNDeHh0qcJ73Jlg2C98D/zoGFGlstcnNyHxIZl9b4mWi5BHGovMnHAa3O
         Ddkvlc80rXs8OgvWwbl8J1Z8MkDl+zFtQpZbuSYlsVkYSRwyMj2GSSNp10uQbm5tSpZE
         YO7F4wYxaiIImzvgWqiwMaCCoEJGLFlvmwhWCcbFUa78+tSSwvcXY8aQ1y3wA5fFcOzV
         ktaA==
X-Gm-Message-State: AOJu0YwhLTemQe5Xh8ypIJequnI7iZEQnQeR7i+xLnIus/jB92HU15K8
	iRV2wPmFPUaA+2cbw1D/WjJa2W2g5333MMyZ9QxXkW8q9JdJABU25+lPDjR2Iug=
X-Gm-Gg: ASbGnctXU91fNGwKxXYk9QJ94wB/TsU4rNDOkmKgsbediPao45Z+U5gHA23Xc9rlz5l
	6eaHywMb490FE0B+7ThxnKQqlwWO3WsUeptr/4OTCp8EQWkROHHcvTvFVYnzPR6C0cfG63TU3So
	DCFBXCNVN5v2Q1+cEf2BhVKrDESEZizTi5G5XfK9mq/PTjiM+3nY6CcEpX+081y3p4MfK7DEy2A
	K2VWqgroDa0+/cjzPEAh5NdZKbt2Up0S12aokXrQQwGgby9EPIWrzTLsKlYPM5EUF7KCfOPiNIZ
	9fuQYBZTrmI8oOWiw0H9ATsCsIspY88nGRHptcTHMSzs8IKPCT00F1N7bplvtqeQKUCqmiUHnSO
	wdxAp6ShKC06M
X-Google-Smtp-Source: AGHT+IFQXaLcPiac68cSLV4WsHdVRb67rogM0b27Rpkqgk1ad4c1qTHP8Vc1O703UVRXxD05dGwmzg==
X-Received: by 2002:a17:903:1a28:b0:224:13a4:d61e with SMTP id d9443c01a7336-22db3dfbcb8mr6113335ad.51.1745453168527;
        Wed, 23 Apr 2025 17:06:08 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a1dsm534375ad.140.2025.04.23.17.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:06:08 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:06:05 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, shaw.leon@gmail.com,
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
Subject: Re: [PATCH net-next v3 3/3] selftests: drv-net: Test that NAPI ID is
 non-zero
Message-ID: <aAmAbcbLMl6IBwpd@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, shaw.leon@gmail.com,
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
References: <20250418013719.12094-1-jdamato@fastly.com>
 <20250418013719.12094-4-jdamato@fastly.com>
 <20250423161612.3dc2923e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423161612.3dc2923e@kernel.org>

On Wed, Apr 23, 2025 at 04:16:12PM -0700, Jakub Kicinski wrote:
> On Fri, 18 Apr 2025 01:37:05 +0000 Joe Damato wrote:
> > +    bin_remote = cfg.remote.deploy(cfg.test_dir / "napi_id_helper")
> > +    listen_cmd = f"{bin_remote} {cfg.addr_v['4']} {port}"
> > +
> > +    with bkg(listen_cmd, ksft_wait=3) as server:
> 
> Sorry, not sure how I misread v2 but you are running the helper locally.
> So you don't have to deploy it to the remote machine :(

OK I can remove that and fix the macro guard for the v4.

> BTW does removing the ksft_wait() from the binary work? Or does it
> cause trouble? Don't think we need to wait for anything in this case.
> With the XSK test we had to wait for the test to do the inspection
> before we unbound. Here once we get the connection we can just exit, no?

I agree that we can just exit, but removing the wait breaks ksft
utils:

# Exception| Traceback (most recent call last):
# Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
# Exception|     case(*args)
# Exception|   File "/home/jdamato/code/net-next/./tools/testing/selftests/drivers/net/napi_id.py", line 13, in test_napi_id
# Exception|     with bkg(listen_cmd, ksft_wait=3) as server:
# Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 130, in __exit__
# Exception|     return self.process(terminate=self.terminate, fail=self.check_fail)
# Exception|            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 78, in process
# Exception|     os.write(self.ksft_term_fd, b"1")
# Exception| BrokenPipeError: [Errno 32] Broken pipe

LMK how you'd like me to proceed ?

I'm thinking:
  - Leave ksft_wait()
  - macro guard
  - don't deploy helper to remote machine

