Return-Path: <netdev+bounces-122998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68199636A7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EC22862D4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C55CA29;
	Thu, 29 Aug 2024 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmZLwx+P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9879C4;
	Thu, 29 Aug 2024 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890019; cv=none; b=UggxDBgRnjbDxFWqA0lPNu3AFbdAYw+c+i2ODYWZeAb9DMdteckblkynyzyGLDHooOsnNG75+2eTx41OfyCguhnQE/fmgQyygRKp8LuCSXV1PZ90hmA2TSpjJBiBXNUqSWunsigfwdoG2xRHQgk3mdX9F+WRz0b4f1gKoWomAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890019; c=relaxed/simple;
	bh=0KBomtwl5htJf2KliDq8qRkg58AM7cR5JxLbBwVmD/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5HGjBtrFBioSFNWEmCnMqvvhTcoIwXgK4iQ1I65bQZLX2fwVKtjKcRSHpDAHPPSdmz7wvioEEf6EADhW1vXolNFPrb4I+Qwc6mI8KqRtm8sqrY1P5gzDZeE5jgrZFfIWG614PJstrSxAL8ixGik8y7Rjqx1HeQCloSx9JDiQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmZLwx+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9796EC4CEC0;
	Thu, 29 Aug 2024 00:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724890019;
	bh=0KBomtwl5htJf2KliDq8qRkg58AM7cR5JxLbBwVmD/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LmZLwx+POZ+ZZEuXHKVyWVVwSDgrJjSJCUR3aUrxypd4Z4wK+wbPf9EJE/+P7brK+
	 SxbhLDYEJtEpBdkHd8ZwKsdkFWzDjPHxwjPdbkJNS2jfBZv5jzatoqnUiz0zEG28tw
	 hjUYhdxihOCJgq/u8k3cQcEl7ih41Mn0OJWPBDGbgcpU1aJFA1pEtVgtDBWDmAU/l3
	 SHsHnTvjwc7rGXVGqyuHpCidavb1xuTXQKYBS481Y30pxpCGAw1EwM2rQcFNZH6mAD
	 r6TnzILRj+UQJyfdOrc8aBAzwzd0JC9nICmjlULt7mfWsJxiVe4VWmakJOCcMTOr0t
	 Sn0irpBpH5afg==
Date: Wed, 28 Aug 2024 17:06:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, wei.liu@kernel.org, paul@xen.org,
 davem@davemloft.net, edumazet@google.com, madhuparnabhowmik04@gmail.com,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/xen-netback: prevent UAF in xenvif_flush_hash()
Message-ID: <20240828170657.5f493cc6@kernel.org>
In-Reply-To: <CAO9qdTGHJw-SUFH9D16N5wSn4KmaMUcX+GVFuEFu+jqMb3HU1g@mail.gmail.com>
References: <20240822181109.2577354-1-aha310510@gmail.com>
	<fd2a06d5-370f-4e07-af84-cab089b82a4b@redhat.com>
	<CAO9qdTGHJw-SUFH9D16N5wSn4KmaMUcX+GVFuEFu+jqMb3HU1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 21:52:12 +0900 Jeongjun Park wrote:
> > The loop runs with irq disabled, the RCU critical section extends over
> > it, uninterrupted.  
> 
> Basically, list_for_each_entry_rcu is specified to be used under the protection
> of rcu_read_lock(), but this is not the case with xenvif_new_hash(). If it is
> used without the protection of rcu_read_lock(), kfree is called immediately
> after the grace period ends after the call to kfree_rcu() inside
> list_for_each_entry_rcu, so the entry is released, and a UAF occurs when
> fetching with ->next thereafter.

You cut off and didn't answer Paolo's question whether you have a splat
/ saw this actually cause a crash or a KASAN warning.

