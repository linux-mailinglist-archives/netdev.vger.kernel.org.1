Return-Path: <netdev+bounces-89349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D408AA1A9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799B21C2099F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5AA175552;
	Thu, 18 Apr 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvTyL/5k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297FD174EC5
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462990; cv=none; b=Sq0XAdgs9HX03Ufiw6RS4SWfMKO09uDFtDAeSxKumiAhoLDriOI5j1i79yTR72OPUfX7d5q5KeU5bq+8e6wwhm9Vjnlqw8WsnSXZelR/uD2RslTNvyhJeltD0hvDSC0Lcg6dr3iRvvT2tXPvF9x2h85PVqKHdBGsEMe/dix8YWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462990; c=relaxed/simple;
	bh=8uA9L+P47F3AEU8Bvxxkz5cIclqUFLl0LsIHt3KmG0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kACLSd2AYcvxBo5wSIsQDH0/0+qYF8ifsK+Jd+RoubDvmEKF16h6ZcEEZs2hV/LxeIl4vPPnTxdst5UOYv7t3TG1YaxjaUossJXF10+zN2edk6iRhtTMFLmBngTEsnCOzIXBA9U5HXGf1ju4UvnLBFUxnbdq3T3VTB0tLhNn+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvTyL/5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E95C116B1;
	Thu, 18 Apr 2024 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713462989;
	bh=8uA9L+P47F3AEU8Bvxxkz5cIclqUFLl0LsIHt3KmG0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OvTyL/5kwHpe99Ga4iItD2EjN8bBmCOtWyQa9YUCzqx8IPog34eXdmFL5b9Ihh0O0
	 T+1VRzA1Dp2V3Xl/FjY81vhB2k3PKQNwkNO+EudkB61yYNfC182DLrd8ZWDhjjjPqt
	 HcBL0OUnK9pDYP8KNFLTdmWq5fQlP7eBS5nmndaBOLKb6DmNdvBfMtkszGXI39+plr
	 paLGtzCWnqtLSUfVpaIRdVdo9Fc45oMl5XvKJVwqXE5PlKko+6beV0sJlsBijR8R9T
	 lF7Y9T3V2srA1hPZp+iAAVYQZIv2ghNFFQh4IIIwwz4HvV5P5wknCGYj9UussfHuwk
	 okjgkUNx7E+7w==
Message-ID: <4561e150-7601-408f-9775-fe1718c2fa56@kernel.org>
Date: Thu, 18 Apr 2024 10:56:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from
 tcp_v4_err()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org,
 Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 eric.dumazet@gmail.com, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Willem de Bruijn <willemb@google.com>,
 Shachar Kagan <skagan@nvidia.com>
References: <20240417165756.2531620-1-edumazet@google.com>
 <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 3:26 AM, Eric Dumazet wrote:
> For the second one, I am not familiar enough with this very slow test
> suite (all these "sleep 1" ... oh well)
> 
> I guess "failing tests" depended on TCP connect() to immediately abort
> on one ICMP message,
> depending on old kernel behavior.
> 
> I do not know how to launch a subset of the tests, and trace these.
> 
> "./fcnal-test.sh -t ipv4_tcp" alone takes more than 9 minutes [1] in a
> VM running a non debug kernel :/
> 
> David, do you have an idea how to proceed ?
> 
> Thanks.
> 
> [1]
> Tests passed: 134
> Tests failed:   0
> 
> real 9m33.085s
> user 0m40.159s
> sys 0m30.098s

The test suite was started in 2013 and has evolved to cover the many
permutations of APIs -- setsockopts, cmsg, VRF, routing, ip rules,
netfilter, etc. There are a lot of combinations. They verify not just
control path or socket bind succeeds, but data path works as expected
which means do a connect and packet transfer.

Some years back nettest gained support to change namespaces and run both
client and server in a single instance. I started converting the tests
to use that capability and remove the sleeps, but it did not speed up
the tests in any significant way.

The tests are in blocks and the blocks can be split out to separate
scripts or kept in one to retain the common setup code and launched in
parallel. Splitting out to any lower level does not make sense.

If someone wants to pick up the task of splitting the tests or running
them in parallel, please do. I have zero time right now.  That the suite
detects changes in kernel behavior shows it is doing what it is designed
to do and proves its value.


