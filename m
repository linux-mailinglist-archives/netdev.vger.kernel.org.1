Return-Path: <netdev+bounces-207258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F17BB06770
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA45502D77
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68398272E7B;
	Tue, 15 Jul 2025 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pLbFDViD"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CA2749EC;
	Tue, 15 Jul 2025 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609819; cv=none; b=HrmS2ar4KVaxj5/w/JBqwDdagRkm5om7B+kX4R7vP7Oska8ByT17L7DVTX1ZCka2KAiTj/Mgy6WpZcRuMMeEaqnfyzYBfcwWPBQktAAwwDVvLGIjPpdCQ3K5FjUqsd/TLYlRkM/Elv3ldWfzDuZhxteqppiRHZuSeMKguxUjvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609819; c=relaxed/simple;
	bh=hWcwwSCIE1juPICXC7jR+4JoO+FPPx/JLkJnjiyX7Iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mx7VDMgYbVp9AD7MRq1bV9GgcUH38248tz3RAbe0A8mi6uX6O1PQLCy6H5KAU0qXAxPqKlA+WiOz3q+41cPd0QexDsIUa0rEGNmBe98xVxZ6sabUPO0WCxllzw6Fj05n++DMlBP13eoUP1tSHCf8bC0TlFnA9hQgbxYVEPCKpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pLbFDViD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9F8524040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752609816; bh=5kPEQacK23+5d9HZEBwKwlf08U1WgpD16N1/izqmHtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pLbFDViDIrgJL8ZQateU2gyMeDQgIUGqckKBl894fT8zEhfferjsoQNUJfu/F2kmi
	 bHgqmunluMg8/CrAP+1xeAzeyBkwb9k/D8gjRgUcLUtOue7x0CQjovVXSpittsvf8z
	 QHuolRJl87REBezg0rRnN0jj+EqXpjmuFqUtc9a8Js+uKkCDBjoD5CsAi7GwFpawto
	 N97D86OaxcchGHK0hiv4wr35SrKHUfZUNx1UUfyju4YWpNfSs3xE8Z4miAkT0VNoil
	 DaHSRLO19jjiyqSuJMJn7MDoLLiQh2Yx9AB8i0FtGQmhUrD1RtCeNjc96fpMMNIzN4
	 7g8TuYdwWsqRg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9F8524040B;
	Tue, 15 Jul 2025 20:03:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Linux Networking <netdev@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, Haren Myneni
 <haren@linux.ibm.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Donnellan <ajd@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch
 <nathanl@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] ioctl numbers list cleanup for
 papr-physical-attestation.h
In-Reply-To: <20250714015711.14525-1-bagasdotme@gmail.com>
References: <20250714015711.14525-1-bagasdotme@gmail.com>
Date: Tue, 15 Jul 2025 14:03:35 -0600
Message-ID: <878qkpfch4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> This is the cleanup series following up from 03c9d1a5a30d93 ("Documentation:
> Fix description format for powerpc RTAS ioctls"). It is based on docs-next
> tree. The end result should be the same as my previous fixup patch [1].
>
> Enjoy!
>
> Changes since v1 (RESEND) [2]:
>
>   * Add Fixes: and Reviewed-by: trailers (Haren)
>   * Expand tabs for uapi/misc/amd-apml.h to match other entries
>
> Jon: Would you like to apply this series on docs-next or should powerpc
> folks handle it?

I've applied it.  I took out the vast pile of Fixes tags, though; I
don't think all that was justified for these tweaks.

Thanks,

jon

