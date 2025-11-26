Return-Path: <netdev+bounces-241994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277DFC8B795
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA4F3A2662
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26C730C605;
	Wed, 26 Nov 2025 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="kxMmI0Yg"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D942278E53
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182684; cv=none; b=XffNItQhYDwgt1DT33u/sd3x9LiIP/KJ9/SW/0vx9qIzxm/fN2BMohRD0/Ti4VzW1Qi+jP+elN8Epz6sw7vEcoH61Dl/vwx1EBh7aSdE1ALXSXBG5jmnwfBvwnHD1sPWxJKo6aLiYzeIbtjD5PWJvO6umyp4uK9Mx1qQU6aNg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182684; c=relaxed/simple;
	bh=aohXC9EG90drxXkDwxAg88OpJ3K2oR6SDTPHxVxJOsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN71UPXiPYpXfKus8ZPX31NeuZelSMNtO3Q5HroDKNyHiRGl1zer9bLFHbypG4ssxETs95ftVs8+6q2uNQ87c4lNWJ2gbrXfsL/x18k/MhQaPHqNuDjQAIi++qL+NLs5g6TtkFdv345h7ljILACy60HnprL3E18R18bKC4P9zs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=kxMmI0Yg; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOKVI-00AJ0W-Up; Wed, 26 Nov 2025 19:44:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=jISugL4FXWcXTSUyi4aKYZq7sevZjSy4HXep8d5DTJ8=; b=kxMmI0YgN2+PyBaquv+Ukrgl8Z
	Cv8s+PrSi5xIvrH5k19JxarZPJifAMMDX2z5wa8g0ZdkoNg+r3XgbvY8aqheFEnxitwV1zDZ3hak0
	yQ518PI8hnIvjvUFgHybSEH28lSJcwKXbWKL6rSY53PxRhO6y/5vrTXPWPmiV7WjhG+sG2wbZ7c1L
	0GIorhee0Es/w3t4VMEncGtBGPwTDlXuKI8dn4bO9R6nmTYCn6mqd17A9G8IedHKndpnFGb5fvGNH
	8dGCtsCKaE0dm09SFt5YFQspgd5006q8q6f3O1ztT5+pvT2sv+WU8YWIvmXHklwaPXiKFXRX2eYW2
	NZEJHlcg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOKVI-0006dO-0r; Wed, 26 Nov 2025 19:44:36 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOKUz-00ELuo-Du; Wed, 26 Nov 2025 19:44:17 +0100
Date: Wed, 26 Nov 2025 18:44:15 +0000
From: david laight <david.laight@runbox.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipconfig: Replace strncpy with
 strscpy_pad in ic_proto_name
Message-ID: <20251126184415.28f7fdc2@pumpkin>
In-Reply-To: <B7B14C9F-C63B-4278-AA3F-12618681482A@linux.dev>
References: <20251126111358.64846-1-thorsten.blum@linux.dev>
	<20251126135042.06c1422b@pumpkin>
	<B7B14C9F-C63B-4278-AA3F-12618681482A@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 15:45:50 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On 26. Nov 2025, at 14:50, david laight wrote:
> > On Wed, 26 Nov 2025 12:13:58 +0100
> > Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >   
> >> strncpy() is deprecated [1] for NUL-terminated destination buffers since
> >> it does not guarantee NUL termination. Replace it with strscpy_pad() to
> >> ensure NUL termination of the destination buffer while retaining the
> >> NUL-padding behavior of strncpy().
> >> 
> >> Even though the identifier buffer has 252 usable bytes, strncpy()
> >> intentionally copied only 251 bytes into the zero-initialized buffer,
> >> implicitly relying on the last byte to act as the terminator. Switching
> >> to strscpy_pad() removes the need for this trick and avoids using magic
> >> numbers.
> >> 
> >> The source string is also NUL-terminated and satisfies the
> >> __must_be_cstr() requirement of strscpy_pad().
> >> 
> >> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
> >> [...]  
> > 
> > Wrong change...
> > There is no reason to pad the destination, and the correct alternative  
> 
> I agree, padding isn't necessary and strscpy() is enough.
> 
> > is to bound 'v - client_id' and then use memcpy().
> > Then you don't need to modify the input buffer.  
> 
> Just to confirm - this comment is about the type parsing ('client_id'
> before the comma), not about copying the value after the comma, right?

I've misread the code :-(
Probably because it should be:
static struct {
	u8	type;
	char	value[252]
} dhcp_client_identifier;

There are also better conversion routines than kstrtou8().
You really want one that returns the address of the failing character.
Then the parsing would be easier to follow and wouldn't need to write
to the buffer.

	David


> 
> Thanks,
> Thorsten
> 
> 


