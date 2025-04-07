Return-Path: <netdev+bounces-179923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE79FA7EF39
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2928F3B7F3D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA537219A8F;
	Mon,  7 Apr 2025 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McmYrSA4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45091EE032
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056592; cv=none; b=Tx08RajZS6HhBgkbDFWuRfuu56sTFIxJQMW2ZqJjc2kf6JjhhCeXqYRkWOhdSQpy/t/r7aE9gmSKj3xHnVYN5/QpE4NA/gWi7Wu4TrfwBcm98lcHfMUM/BEzEW+4V+2UepCDneDycg+vQNlbS3W5+O0PIWsl60973RG/AmhbNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056592; c=relaxed/simple;
	bh=85wJpawMWy4tIm/mv9uuLFr0gHOVDnxuZz963FpAuDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+o5sW/39MUVoFMfuZTxL6K5ynzrfnj+omIa6uTO15w3xEc8YIa1ejminRvXtJiQ0Esp8uLNJz4pXA2qv2asqIcOSQA/I4JxtpqbnnDTWgwIFGn3ntpp7+m55nojq6MrV3Q7Q3p2IcUWkcUadfgq4Gh8+VgvWUSs7EpFawMv+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McmYrSA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD09C4CEDD;
	Mon,  7 Apr 2025 20:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744056592;
	bh=85wJpawMWy4tIm/mv9uuLFr0gHOVDnxuZz963FpAuDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=McmYrSA4FQmQGXhvO11Ld1h3BaSahV+ilwyn5HbOUT/PkGXGtULdRnFRXu6t2itVY
	 f1MrjBE4bUDdN3UbJ4t7qJjj2Jkw2aPO05bbcu7OGv4yPs8ecUi1dJ31NUj4lG/cLY
	 1Vf8IloCtjks8dS+554MOAZGWmHu7/SIMd6gB3ZdAQ8DOnvqMJVT0EX3vq7xhRVDCK
	 w9TsqlLLnRfK9BbXYxO8Xfo2+byb2QwtnpD/GHwsbzdXrgxbrMuTf6yXcMplexKVMi
	 B0axBZz06+QCYmCgJ1kHm9xhK06atDnUWdVNHbiTKXj1mOmnOiBlApY5r99jq69GyH
	 LqMWkFMKh8d8A==
Date: Mon, 7 Apr 2025 13:09:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [Patch net v2 11/11] selftests/tc-testing: Add a test case for
 FQ_CODEL with ETS parent
Message-ID: <20250407130951.454b2760@kernel.org>
In-Reply-To: <00bd48eb-eb2d-4194-a458-6203aeba6a81@mojatatu.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
	<20250403211636.166257-1-xiyou.wangcong@gmail.com>
	<20250403211636.166257-6-xiyou.wangcong@gmail.com>
	<8bd1d8be-b7ee-4c32-83a9-9560f8985628@mojatatu.com>
	<20250404114123.727bc324@kernel.org>
	<00bd48eb-eb2d-4194-a458-6203aeba6a81@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Apr 2025 16:03:26 -0300 Victor Nogueira wrote:
> > Any ideas what is causing the IFE failure? Looks like it started
> > happening when this series landed in the testing tree but I don't
> > see how it could be related ?  
> 
> Yes, I saw that, but since it succeeded on retry and, as you said,
> it doesn't seem to be related to this series, it looks more like
> those IFE tests are a bit unstable. I talked to Pedro and we are
> taking a look at it.

I dropped this set from the queue temporarily, and the failure
went away (net-next-2025-04-07--18-00). 
Now I'm less inclined to think the IFE failure is not related to 
the series. But since the retry passes I'm not sure if Cong will 
be able to debug this. 

Could someone on Mojatatu side take a closer look please?

