Return-Path: <netdev+bounces-107072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF5919B10
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 01:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DC41C21371
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BB61940BE;
	Wed, 26 Jun 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BrM6T+Er"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FD19309C;
	Wed, 26 Jun 2024 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443591; cv=none; b=ok8qCaT+nYwag9GALH092s/YpDBMd0Vtt1kTgtFgGg6EN3VUN2otXBmVuvmnFmvUw2btFySgZ9RgfnfG7l0xlkVAcbiqnsPGuPyvkDau6fuuq8nBnETY9NVhmLMIT7H0I77kLydzRgIR8hPkKl3dRu6w1HSV6q96W5Jb+RltP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443591; c=relaxed/simple;
	bh=4MNHDuB27X4XbIAQZjJn55ihsbt8baZdU7aNrx01P88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QacU4POC7jmG305BAVj0BsEc1HartdSWlybp9+XcXdhEiRY7lHLiYrOPmS7wRqM0l7Rc9q7Fwvaet3dSstaZKCX0VTRzE+cFLOJSlJ0pjA69Jit81bLLkNXpqNKqa1DUIqPkUSHiQxzTeUuf0FBsgiyRxUBThHU6xbKZWryMeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BrM6T+Er; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4A0CD45E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719443589; bh=Lf1chSU6XVlbAueGCt5A9XabdPOkNuXkxU1yuwXYxaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BrM6T+Erj9ZDLDHhti8Fyao9nDqSPfxpLFxUDEJxCCZeqVyrg1/KJ4zhPfLpjQHJ/
	 Go3rOocScliB3XeK917BjmVHDmjxwd2No1Aml9QOOLIYg9Hih6HyJkJrr7mTpG2Nyq
	 keJ3G5uXpE+Rm5Dk8Y0wOj9zsQdBKVhQ90MTB+q/LuMhkoOGQl11vZfNwIP52Rp8HD
	 JjO0z2+4PEoFFIrMmNp6b3KaCK9Ydc6ovzqJj7x0ar9Qm24+dTGhJoh0DO72WbIFj/
	 yoED1DGq1zYscfCOMOJe6xIjXwVaPYc7NN6H2NOErQ8NMo0R4ae0zwdpDKQCEtWMla
	 VfAi0CqSps0SQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4A0CD45E2B;
	Wed, 26 Jun 2024 23:13:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
In-Reply-To: <20240621-amorphous-topaz-cormorant-cc2ddb@lemur>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
 <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
 <202406211355.4AF91C2@keescook>
 <20240621-amorphous-topaz-cormorant-cc2ddb@lemur>
Date: Wed, 26 Jun 2024 17:13:08 -0600
Message-ID: <87cyo3fgcb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Fri, Jun 21, 2024 at 02:07:44PM GMT, Kees Cook wrote:
>> On Wed, Jun 19, 2024 at 02:24:07PM -0400, Konstantin Ryabitsev wrote:
>> > +   This URL should be used when referring to relevant mailing list
>> > +   topics, related patch sets, or other notable discussion threads.
>> > +   A convenient way to associate ``Link:`` trailers with the commit
>> > +   message is to use markdown-like bracketed notation, for example::
>> > ...
>> > +     Link: https://lore.kernel.org/some-msgid@here # [1]
>> > +     Link: https://bugzilla.example.org/bug/12345  # [2]
>> 
>> Why are we adding the extra "# " characters? The vast majority of
>> existing Link tags don't do this:
>
> That's just convention. In general, the hash separates the trailer from the
> comment:
>
>     Trailer-name: actual-trailer-body # comment
>

Did we ever come to a conclusion on this?  This one character seems to
be the main source of disagreement in this series, I'm wondering if I
should just apply it and let the painting continue thereafter...?

jon

