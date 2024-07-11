Return-Path: <netdev+bounces-110938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2E92F063
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B896628382A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249E16E894;
	Thu, 11 Jul 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="loHycgZj"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE616B38D
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730074; cv=none; b=NlTqFZJYq8aJlIVO8/L4PQC8yeZsvi0z0v8RGw/ATFcunXZ65UXEBw7YTyREeeFRbo92we3Z1u25i+ODTJPAAvFndZfkB7H3Lrj7cz407N2gaZ9yJFNR6KxfHz6zQS/QtEWNbAwT0wuoYMud/cWybts2l+drlm6ubgTuR8MQB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730074; c=relaxed/simple;
	bh=a4EWMLxLYU7dgopG4xNfVc7BeMmhgH7egitiGwSDCbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCu1+P0DmaELCErxyhSlcdXqZ2AQ3XO+7L5vxcWr+F7pSUgnMXLEQHIYhQbb1wg89kFYcYqBSoOa5h6zKoDYH1HjNUSz01bH9L/FxRw2KSLoRSYQpHjpdFPILIt1KeFdBbqVxwI+AyIIK73tSF3bn6FOEEL3fJ+0Bom3+KXJv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=loHycgZj; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sS0Um-00ADG3-R2; Thu, 11 Jul 2024 22:34:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=OTKv62FwC3C1sZ9zlpBXXUgzF/vKZCRAIfql+rOy4bE=; b=loHycgZjIoV2mv69bmpKCE1QaN
	D7YizgcQMowu096XZqiKbgFMHMksP67wzCUDbYRYH4Iesbh++iMkYV5mZJa13bMMqvzgQfxCWCLFM
	bhCM4YrVwDDI59zq6wVVNDwLlo4P3zR3pY1bRiGzeNVM/azsW2rOxjfesrH+kHD7Dg2/xODkSoO0k
	aeywDW+cE62aN0An6z9eh9UhB4zieuccBo4zOpWx336mBUhuQ0wG3KsYed6CpquNg51yasadDb4H2
	gjshhaI4T8EIngk6NUxPuItE5VNdH4M6jnO2G7gH1mSfX4hWheaElqZ3O/HeydKxuUvaFCPIGCVLD
	fxIuoTrw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sS0Ul-0004vw-O3; Thu, 11 Jul 2024 22:34:27 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sS0Uk-002Cgw-4c; Thu, 11 Jul 2024 22:34:26 +0200
Message-ID: <b902cd1c-cd13-4bc2-b892-8f1174fdeed0@rbox.co>
Date: Thu, 11 Jul 2024 22:34:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 3/4] selftest/bpf: Parametrize AF_UNIX redir
 functions to accept send() flags
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-4-mhal@rbox.co> <87v81enawc.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87v81enawc.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/24 11:59, Jakub Sitnicki wrote:
> I've got some cosmetic suggestions.
> 
> Instead of having two helper variants - with and without send_flags - we
> could stick to just one and always pass send_flags. For readability I'd
> use a constant for "no flags".
> 
> This way we keep the path open to convert
> unix_inet_skb_redir_to_connected() to to a loop over a parameter
> combination matrix, instead of open-coding multiple calls to
> unix_inet_redir_to_connected() for each argument combination.

All right, I think I was aiming for a (short term) churn reduction.

> It seems doing it the current way, it is way too easy to miss
> typos. Pretty sure we have another typo at [1], looks like should be
> s/SOCK_DGRAM/SOCK_STREAM/.
> 
> [1]
> https://elixir.bootlin.com/linux/v6.10-rc7/source/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c#L1863

Yeah, looks like. I'll add a fix to this series.

> See below for what I have in mind.

Thanks, got it.

