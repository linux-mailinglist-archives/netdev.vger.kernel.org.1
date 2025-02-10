Return-Path: <netdev+bounces-164716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2FCA2ECCA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C54F3A4A9A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5FA22259A;
	Mon, 10 Feb 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="a8lXB5Ij"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4CF1E1C22
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191449; cv=none; b=t+GxmlgnzYLiIuMvcai5dfQC4VDAh8lTps2B9kzex/dN5+bHvwuvL4UUbV3GQTHMkFxkKUdZk6lsL51QA+TISs2B+OXEx3AjMLPMvpq63qk7BHNXlknVYW+69DyhB5q2C5XFaz4F/ucHQE4T/lrkFhk28SL7m8fLxb4VEiZTkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191449; c=relaxed/simple;
	bh=GLZwLaofuai1+ZKxckCk1D+VBkztYywkGUQdVMLjs7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tm5OePQXT1qcAY3qT8xYGcRUzmtBkCiFGylBjwMccJ7tWc5BGkdqMlhNYMAcR3qG9uFLVhHvniq7OjGgOW8qSdirWE2g38xh0Q3OgNEMJ/brqn9H5dNUxcs8qcdIbXgsJ/BhxT2mIVrrgWVZyaDBeMdw27q884lTPosJN1J5bVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=a8lXB5Ij; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1thT8t-00BRMy-2A; Mon, 10 Feb 2025 13:44:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=wO85ERmJMlSw/Yf7vbMFqN4QVwV47Z00fmhOJhTEfak=; b=a8lXB5IjOm171G9+KuipIHEGuv
	3S3WKntDXPjmJRnO7IZxCSHYkOkVlz3p4GgKjapAKC+vyJ7Qd6bcFeAYPeYeCaD7Ql0dZa06pnwvy
	XEPrOKb18D2oLIsAZt5dDxvUTkcT3v49dk00sZtXjpD0Ttiq976ScxwDSe0IjMIH9x0m0/hZMOexr
	MIZe0u+NfWuOePRYH1PtW1WIHDoxU1p8WKlAKkWlxyxOgsGRdX+phUYhx02w3OQP7UcAPgH094SUj
	pPr1dUDpGoXNBmLGA7aPnu2QT/F+bWlhtjuxL4qlsmtQ8Fc8yqqykA9gP4HT7KOAp2b4UyMjfi/61
	lEcp7kyQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1thT8s-0000gY-ES; Mon, 10 Feb 2025 13:44:02 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1thT8k-006GmA-As; Mon, 10 Feb 2025 13:43:54 +0100
Message-ID: <2f253267-2277-4a96-b732-ebbed46e023a@rbox.co>
Date: Mon, 10 Feb 2025 13:43:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] vsock: Orphan socket after transport release
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com,
 Luigi Leonardi <leonardi@redhat.com>
References: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
 <20250206-vsock-linger-nullderef-v2-1-f8a1f19146f8@rbox.co>
 <zboo362son7nvmvoigmcj2v23gdcdpb364sxqzo5xndxuqqnmy@27cgbg6bxte2>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <zboo362son7nvmvoigmcj2v23gdcdpb364sxqzo5xndxuqqnmy@27cgbg6bxte2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/10/25 11:15, Stefano Garzarella wrote:
> On Thu, Feb 06, 2025 at 12:06:47AM +0100, Michal Luczaj wrote:
>> ...
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 075695173648d3a4ecbd04e908130efdbb393b41..85d20891b771a25b8172a163983054a2557f98c1 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -817,20 +817,25 @@ static void __vsock_release(struct sock *sk, int level)
>> 	vsk = vsock_sk(sk);
>> 	pending = NULL;	/* Compiler warning. */
>>
>> -	/* When "level" is SINGLE_DEPTH_NESTING, use the nested
>> -	 * version to avoid the warning "possible recursive locking
>> -	 * detected". When "level" is 0, lock_sock_nested(sk, level)
>> -	 * is the same as lock_sock(sk).
>> +	/* When "level" is SINGLE_DEPTH_NESTING, use the nested version to avoid
>> +	 * the warning "possible recursive locking detected". When "level" is 0,
>> +	 * lock_sock_nested(sk, level) is the same as lock_sock(sk).
> 
> This comment is formatted “weird” because recently in commit
> 135ffc7becc8 ("bpf, vsock: Invoke proto::close on close()") we reduced
> the indentation without touching the comment.
> 
> Since this is a fix we may have to backport into stable branches without
> that commit, I would avoid touching it to avoid unnecessary conflicts.
> ...

I've checked that 135ffc7becc8 was already backported (6.1, 6.6, 6.12) and
thought it's safe to do, but I understand your concern, so sending v3
without touching the other comment.

Thanks,
Michal


