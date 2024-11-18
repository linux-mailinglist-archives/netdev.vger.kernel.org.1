Return-Path: <netdev+bounces-145982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFC19D1863
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 19:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C69282CD1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81FC1B6CEE;
	Mon, 18 Nov 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/M53LG5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5A18E0E
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955528; cv=none; b=QefEykxGVUQF05N9qgLaCBPRpifjyu/7xwTtqZa1dAcpU3GPgjTcK9Dxo6dpaS1lJY9MeoZgqgus25OvCr1SMEF2k4HXNQWkIFMsfkIPsLNfI64fJ9qUvn8iwGZYuPt4IkYUSYtv/TIvWoPoBA2olS+F8gpfxTUZ/sUEfU1YVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955528; c=relaxed/simple;
	bh=cmqVngCxzb6IocbcM0H+Z3fhTe9lf3PQ2Q4W664eiaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4xdtw+TTnbEk2VvEGncK4Gkj6MHUNwDgremGerTLPz//ImvTvELEPrbMKkW+cq71Hgo+hAjQcJbPZGYWcHwe3SbW/8VxOZRtKtORMdQIiBCJJt5Dk88WNkBzxgov4hvMpCJrhpp6uJwWIH7+9qA92Qh6Q5lVzgL4gl6BgdGh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/M53LG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EAAC4CECC;
	Mon, 18 Nov 2024 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731955528;
	bh=cmqVngCxzb6IocbcM0H+Z3fhTe9lf3PQ2Q4W664eiaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g/M53LG5VjGkVElk3PbRiHb8Q0W8k2PNBCy9AmtWtHA/R3/HQQ7ImI13rlcdsOYIF
	 rAjWhUI+4qkhDddW3tCvsG0wY7wcpEK8vS6oJsOA20AmB5SWyRoLH/yVGND2AQlaQR
	 p5ql+4Qpm9Mropk1AME/UmjRpoOxD3S8IyE0RcYp927xlotsR1RtZRNu9rlX6ZC56j
	 H6+qZETyct/qlnUyVkfkt1HIJlGd0nNsMQYD5Rp+yKte9qN4lUJJL14jiHWc6gJ8qQ
	 gid1R0FOG5JdggzL5zaMEyEgi4+yPAl4D0IKtBlKypI2ekwYI8HzjiuGWCSTRHKBEp
	 toyWh1G1/azew==
Message-ID: <c97dd18b-8f67-4d22-a088-d73268402261@kernel.org>
Date: Mon, 18 Nov 2024 11:45:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iproute2: add 'ip monitor mcaddr' support
Content-Language: en-US
To: Yuyang Huang <yuyanghuang@google.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, nicolas.dichtel@6wind.com,
 andrew@lunn.ch, netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20241117141655.2078777-1-yuyanghuang@google.com>
 <Zzs0xDi-3jdQSuk0@fedora>
 <CADXeF1GqzSWYmSFO3v6x7+KTc=Q+U9hUiTd+x5yvZaViSKSkOQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CADXeF1GqzSWYmSFO3v6x7+KTc=Q+U9hUiTd+x5yvZaViSKSkOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 6:19 AM, Yuyang Huang wrote:
> Thanks for the prompt review feedback.
> 
>> No need changes for headers. Stephen will sync the headers.
> 
> The patch will not compile without the header changes. I guess that
> means I should put the patch on hold until the kernel change is merged
> and the header changes get synced up to iproute2?

headers in 1 patch; remaining change in a second patch. That allows the
set to be usable and then I can drop the uapi patch after a header sync
and only apply the second one.


