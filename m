Return-Path: <netdev+bounces-78785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0E1876754
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39349282630
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDD1DDF1;
	Fri,  8 Mar 2024 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JETg015u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B561EA6E
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911618; cv=none; b=pUKxUrdYcay2hqgP726u3/P7/dIZmIHOwI2JVj27BoQufmIE9b3xnHoZpIyKKeVHxe1pT05kIKBoBGesca/OgiwyHyYFIzT3CJo+DPMuWjIlR0QQ4SmXjwgF26K81H8R579huujW5BKAIW6Nr2l1kLeIGJvWesb9vRTVNpJzBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911618; c=relaxed/simple;
	bh=EAWCa63lvLJl3ru3N9C8g0cEfDMe2KnuXS684woYg5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0a3vwJU179Own2fg5Qfuy/zREfQ7up9B0nP8Mu5R5ukfM/9St02hLD/8nq3pIkrhiuVDsDOa9TNDNs8zHVtJrH3qGk7S7hy8YWrbGKuEfnUKwZx8A3SstCozciI5B47IVjKgzYY5HBsxLzbjWVNuJ5puYOclmodyzzgcRbYVnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JETg015u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEC5C43390;
	Fri,  8 Mar 2024 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709911618;
	bh=EAWCa63lvLJl3ru3N9C8g0cEfDMe2KnuXS684woYg5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JETg015ul+qtedyvnmf7ixhbqcsa06VpvrNchY6pmqjkzgMd68kJ7eeuN6CGzFCq4
	 jqKgUW4KiL0y9xKgcv964FEIcbKE25dyp2RXwfOynwcjGlpVquApfsOiZ+OyBDvKyB
	 tD6TZohuCriMsfWyB44U5FYGFQziuiwpaUdcule6joTsJBi0J9kK6ARpjqXsn2Jyr1
	 4OkTX8TpeWh25x06R+IVi0+cd+FQjKPaZ+KBpsTe1+BwvvrS5PsFP77oKJTOT7AxB3
	 vvx74v+0dQ5/r68WZZJATnmdWKOc5dO9FzV+9CHHFIneieDyP9PXyex6xsD/W0JLi6
	 pF+IdTD/biZWQ==
Message-ID: <106b95fc-139e-45dd-87ba-f8e536b37ff3@kernel.org>
Date: Fri, 8 Mar 2024 08:26:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] ipv6: make inet6_fill_ifaddr() lockless
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20240306155144.870421-1-edumazet@google.com>
 <20240306155144.870421-2-edumazet@google.com>
 <f4bcf5fd-b1b0-47a8-9eb3-5aae2c5171b7@kernel.org>
 <CANn89iJDfhJRPta063ujaASOvgvZ_imeBytm0OWsJ_7oKC4txg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iJDfhJRPta063ujaASOvgvZ_imeBytm0OWsJ_7oKC4txg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/24 11:24 PM, Eric Dumazet wrote:
> I did a full audit and I think I did not miss any READ_ONCE()/WRITE_ONCE()
> 
> Of course, this is extra precaution anyway, the race has no impact
> other than KCSAN and/or would require a dumb compiler in the first
> place.

Then I guess I do not need to waste my time on a detailed review:

Acked-by: David Ahern <dsahern@kernel.org>

> 
> If I had to explain this in the changelog, I guess I would not do all
> these changes, this would be too time consuming.

The request was something simple as the following in the changelog:

"New objects not in any list or table do not need the annotations, nor
do updates done while holding a lock."

Reminder for current reviewer and in the future of the intent behind the
change.

