Return-Path: <netdev+bounces-61045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02FF8224C0
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E821F22A8B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A82B156D9;
	Tue,  2 Jan 2024 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2h3jvbD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27E171BA
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EBDC433C7;
	Tue,  2 Jan 2024 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704234742;
	bh=Wjr223nIGu1Tfag5WOYMKODjWLHW6V45AbgJ6ppqzIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2h3jvbDQtwgS2ETLD5YRP2EaPMvgnKB6KOxSJTeP/oYi4JkigjVgPsRd+IkTHFoz
	 ivxfuxL+pmpVWGcyQbF9q6cGmHonaw6nBE0Ebr8hagJKeyLJjgckm74V9Df/CgKX1F
	 A69JITidL0DfvBqwqcQ4lPAbhn6KqIXP8G4HT1Pf+IA0tSG3Vpaj7S1kKGTA3MMDCg
	 dTUfLzm84eiuYce11uSAv5+kiAj2zUL13qXZsvzOr2LibRwrOhJeYLhjEvVFHnz0uz
	 dByNSmPVYTgRSZhU5exSsLRlORRf0bR/InLqWJSqXas4WBxJicm/DJawgE6FYg/eMP
	 RKPdGFM1I6aAg==
Date: Tue, 2 Jan 2024 14:32:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, "Stephen Hemminger" <stephen@networkplumber.org>, Jens
 Axboe <axboe@kernel.dk>, "Daniel Borkmann" <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH net-next 0/4] sockptr: Change sockptr_t to be a struct
Message-ID: <20240102143220.3068951d@kernel.org>
In-Reply-To: <199c9af56a5741feaf4b1768bf7356be@AcuMS.aculab.com>
References: <199c9af56a5741feaf4b1768bf7356be@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Dec 2023 09:46:23 +0000 David Laight wrote:
> The original commit for sockptr_t tried to use the pointer value
> to determine whether a pointer was user or kernel.
> This can't work on some architectures and was buggy on x86.
> So the is_kernel discriminator was added after the union of pointers.
> 
> However this is still open to misuse and accidents.
> Replace the union with a struct and remove the is_kernel member.
> The user and kernel values are now in different places.
> The structure size doesn't change - it was always padded out to 'two pointers'.
> 
> The only functional difference is that NULL pointers are always 'user'.
> So dereferencing will (usually) fault in copy_from_user() rather than
> panic if supplied as a kernel address.
> 
> Simple driver code that uses kernel sockets still works.
> I've not tested bpf - but that should work unless it is breaking
> the rules.

LGTM, but we either need acks from bpf folks or route this via
bpf-next. So please repost and CC bpf@ on the whole series.

