Return-Path: <netdev+bounces-211959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 345FFB1CB69
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 19:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23B916E6A1
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E0E29ACE5;
	Wed,  6 Aug 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7Te2kga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51901F4CBC
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502468; cv=none; b=XCeC1j1A+3YplPjaUoDuBG38qxyeICfsPqf5NgDcJf4zBiy3Nxvo53hlMUFzl2aCLuVEmTnBLQkwBzCrZJvRVgUU2c8gRfV2hX1zGkCgCNVFnbbqUgff3+OtqJYhksSmWHSOABzPMAIJCT69pfVKRrVs1Bw7ciG41qL1RUwiExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502468; c=relaxed/simple;
	bh=ANrk/XEhU8er5UdvcSNKvG86rbEmEmIvPke0/pMR2GI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFZ31ERu/xx1vt77Yqy9SFhbyffVU6SbGrY6lGQHyIBYSAiE0Y/R/9MawWbLrpn0COzl7DqlvCllH7SVNrLHFYuN/DsR7EiD8wBaqiJV1lAqVftIPeXMwmsyrAAQf9nnK83c5+7Ws1YyELye2HawQEHCgHdmkncaxj6GPYMje9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7Te2kga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21969C4CEE7;
	Wed,  6 Aug 2025 17:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754502467;
	bh=ANrk/XEhU8er5UdvcSNKvG86rbEmEmIvPke0/pMR2GI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X7Te2kgaLBaFrXMN8W4iPDYaZU/hvVRgYY3ANddPmSsVQwCM0lVw55pDg2JnBKv8u
	 7+BuC4B8+CgIRo1lUtOlbRu32JeKDR/Tq2wgMzYydn2986KxOqdGoNAVcl4NZWeY1+
	 G6Va9M/GOkfksZ71p8NGVKUm0bMImT76h4ooY9Aks6Pv3u7c3/+ms2e2zD4NOyj07l
	 qDxjyG265QcvDmAL17JF5fcnMPeklwDeI+V+eMvV2UXl+boTCPWXm/o4O1p6t9Lec6
	 pznyAhngvkCIKF1BH39cxn4jHxzvisnuFTZD37vzSjE/NcWxB/n2rx76jyIFO1tT47
	 vOwIJjFZiZY6w==
Date: Wed, 6 Aug 2025 10:47:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Savy <savy@syst3mfailure.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "will@willsroot.io"
 <will@willsroot.io>, "borisp@nvidia.com" <borisp@nvidia.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>
Subject: Re: [BUG] net/tls: UAF and BUG_ON via
 tcp_recvmsg/tcp_zerocopy_receive
Message-ID: <20250806104746.0937caae@kernel.org>
In-Reply-To: <tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJXfIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=@syst3mfailure.io>
References: <tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJXfIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=@syst3mfailure.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Aug 2025 16:30:37 +0000 Savy wrote:
> This UAF read can probably be transformed into a privilege escalation, 
> as the UAF read can be turned into a UAF write if the anchor undergoes the clone path.
> However, the conditions for that is pretty restrictive, 
> and may require features such as TLS hardware offload for us to hit such paths.
> 
> For the getsockopt(TCP_ZEROCOPY_RECEIVE) version of the bug, 
> we suggest the following check to fix the issue, as the SOCK_SUPPORT_ZC bit 
> is already cleared in __tcp_set_ulp() [2]:
> 
> static int tcp_zerocopy_receive(struct sock *sk,
>                 struct tcp_zerocopy_receive *zc,
>                 struct scm_timestamping_internal *tss)
> {
>     // [...]
> 
> +    /* ZC support has been cleared by ULP */
> +    if (!test_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags))
> +        return -EOPNOTSUPP;
> 
>     // [...]
> }
> 
> For the tcp_recvmsg() version, we could check if there are any processes
> waiting for data on the socket before installing the ULP.

Thanks for the high quality bug report! I think that we're better off
checking if the copied_seq moved since we looked at the queue.
It should cover all cases at once. I'll share the proposed fix soon.

