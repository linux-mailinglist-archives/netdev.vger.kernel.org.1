Return-Path: <netdev+bounces-167994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD67A3D1B5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC446160878
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B21E47A8;
	Thu, 20 Feb 2025 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iQ1FTqfM"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CED1E0B8A;
	Thu, 20 Feb 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035085; cv=none; b=Jlu5KR79ao9+v6wJUxZBCqFrBEVR8CElcIFLF/W8grfILcoO3FjYjsnCHfRhVYWifGtcB5g65fTG/TNLdMRzYDFZTdoSLrvl8ntmjzqEbqLPlt808ztPp+5FeS8h7/TDwCl8iyydwvkDCj+meIdHUISFAwIaQW7qfm3/NBtCTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035085; c=relaxed/simple;
	bh=lJIoqdUy4V0zIzen2mVuEfwtyWVyy02G6Fbphz11x3g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f728kKfCdYXpvBf5fcHfVnR+gUMyu8jwyuWWqt1VYeBTi3/OUIXBOPpKh1HNswE1RgIgB7N+JobkqM7nyUglo9bDnpxUFwYqDHLebM3qgPQP0FbsjfXvyah8+TigDfzb8eDXqKi9rzPC06Ia0tQ5ErT12C6S8OQ4adD6ePvSHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iQ1FTqfM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740035071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcOrIhUgSKoUIoZfwA21I+o8wG81FXhX6ssan37TXl0=;
	b=iQ1FTqfMeQMLUvl3u3ZXWWI+ZrbjDcedqusjY44u3pVLlITtEl4DM2/S4kIJgPh7ykNfL7
	0K613d7SITLI64xmLceP97Y1p/xJwtyY6QGrAjNmjaoFsKoaHc91ewg/80qJBbyoNFcqcj
	NiN/1Yi005+d3fw0vze8Vo20o6Q0TNI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] net/rds: Replace deprecated strncpy() with
 strscpy_pad()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202502191855.C9B9A7AA@keescook>
Date: Thu, 20 Feb 2025 08:04:18 +0100
Cc: Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <08A0C3AE-A255-467F-A007-5584E8E44517@linux.dev>
References: <20250219224730.73093-2-thorsten.blum@linux.dev>
 <202502191855.C9B9A7AA@keescook>
To: Kees Cook <kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 20. Feb 2025, at 03:57, Kees Cook wrote:
> On Wed, Feb 19, 2025 at 11:47:31PM +0100, Thorsten Blum wrote:
>> strncpy() is deprecated for NUL-terminated destination buffers. Use
>> strscpy_pad() instead and remove the manual NUL-termination.
> 
> When doing these conversions, please describe two aspects of
> conversions:
> 
> - Why is it safe to be NUL terminated
> - Why is it safe to be/not-be NUL-padded
> 
> In this case, the latter needs examination. Looking at how ctr is used,
> it is memcpy()ed later, which means this string MUST be NUL padded or it
> will leak stack memory contents.
> 
> So, please use strscpy_pad() here. :)

I am using strscpy_pad() here already because of the NUL-padding.

Did you just miss that?

Thanks,
Thorsten

