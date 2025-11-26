Return-Path: <netdev+bounces-241919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D5DC8A6FA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F228A3A3556
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BDC302CC3;
	Wed, 26 Nov 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dfZgEMnC"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C1A302755
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168387; cv=none; b=qKCLKaMgVeWaogvkffHob+KmVs+5VFNXD7n1MhLrT+qiFcuMKIrCs7ckSASa36JfphbVsIYpQUekf4Z75eosVIXX/NATDwkVOZ0zTg4yGWM3BoMdV2lL40SOT3m8BUjkMMtyVOwsHntpfQ5yan0W9akkT7IEY9EsIwcHW29bghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168387; c=relaxed/simple;
	bh=TbbAB0mQdrDOIGrptPA8oRdX9Ik4DZ5E22D0rMoWtnE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TKx1UBw0gN68TCtPVk+mLHn0TQSo4eWzqMmTZWEVA8LOE5/v2sgtN6Jowhbc+/sz6kBHBnphwqcA7ct10efAYJNepufudWhtLv6IEY9wAHDg6v3FQoC4iaFZJCJimQxt3EhcBLEpzarhgXBztAuMOebqHl28Evlnz1wy6K4qC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dfZgEMnC; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764168383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbbAB0mQdrDOIGrptPA8oRdX9Ik4DZ5E22D0rMoWtnE=;
	b=dfZgEMnCVhB5n8kVv4I57K52vWvVL+EbgdICoRuKiOcDaZBapljjGSoULhIPX8qRx5neLp
	etpJB3sVXeQQ/l7fvwfbybIXx8MzxgaXF3u8WcCKAgQBGrNXsHoqV1sI06Zjl/aOqUVjOl
	obew4cDCgA1ngy04ReeNtNBqjfziS2A=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next] net: ipconfig: Replace strncpy with strscpy_pad
 in ic_proto_name
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251126135042.06c1422b@pumpkin>
Date: Wed, 26 Nov 2025 15:45:50 +0100
Cc: "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7B14C9F-C63B-4278-AA3F-12618681482A@linux.dev>
References: <20251126111358.64846-1-thorsten.blum@linux.dev>
 <20251126135042.06c1422b@pumpkin>
To: david laight <david.laight@runbox.com>
X-Migadu-Flow: FLOW_OUT

On 26. Nov 2025, at 14:50, david laight wrote:
> On Wed, 26 Nov 2025 12:13:58 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
>=20
>> strncpy() is deprecated [1] for NUL-terminated destination buffers =
since
>> it does not guarantee NUL termination. Replace it with strscpy_pad() =
to
>> ensure NUL termination of the destination buffer while retaining the
>> NUL-padding behavior of strncpy().
>>=20
>> Even though the identifier buffer has 252 usable bytes, strncpy()
>> intentionally copied only 251 bytes into the zero-initialized buffer,
>> implicitly relying on the last byte to act as the terminator. =
Switching
>> to strscpy_pad() removes the need for this trick and avoids using =
magic
>> numbers.
>>=20
>> The source string is also NUL-terminated and satisfies the
>> __must_be_cstr() requirement of strscpy_pad().
>>=20
>> Link: =
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-=
nul-terminated-strings [1]
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> [...]
>=20
> Wrong change...
> There is no reason to pad the destination, and the correct alternative

I agree, padding isn't necessary and strscpy() is enough.

> is to bound 'v - client_id' and then use memcpy().
> Then you don't need to modify the input buffer.

Just to confirm - this comment is about the type parsing ('client_id'
before the comma), not about copying the value after the comma, right?

Thanks,
Thorsten


