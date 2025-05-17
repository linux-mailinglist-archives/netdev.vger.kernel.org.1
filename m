Return-Path: <netdev+bounces-191228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC36ABA6F4
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298944C1820
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ECA1876;
	Sat, 17 May 2025 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ghcw6vOl"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012419BBA;
	Sat, 17 May 2025 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440553; cv=none; b=u56cxYKKlFFgtLmwKwQEUuciG4pcPfXMxgscww8WOZ0I/TJfpJ6UhKxLhjjopIibyBirtvq+mUXGqdKPEfcoTb1TzQ1OPafbE6NE/mGk8CRxeHRRnvhiNuWETeRnguNHXZhNQRXWaBe2vtXdcUXXm9kkZOJrbcS7xMIfyC5szOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440553; c=relaxed/simple;
	bh=al5kiGvjKhkzIde6hJPHiGk8cI2gkxhgeE18KHgqX+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p02JYfv9FomN4lQPA0hYcC81NYOmiDwG4C6QnTYKm8g+PZH/y4ozL/xZ0GKTP9QAnRHfXwbD0eXlPhFEt+sC45xPmk3l2kCSR+POy8gcnpM+zEIBA2D5anm5tPKXo4dG147fKt1kOt21deOFuNdyZhvYDq8UU0CZ5nwavLxmzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ghcw6vOl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ogaHJ+ryqmx1qUDpq4/M6JZujlzudYoVKKEgGRINpbE=; b=Ghcw6vOl8KGp3wgQ3pl+8w4ekQ
	K6jJn//Heov3vpbtZj0k8rdTHxAnqHi0Th9x/pp8e99LeR4V+BdCT7fT0Me1kDmoalbPd1LGtjtvG
	1qqj4rRkHstF+Y37J1EXhiqwvij8pbOJeu5bsi1GAWklN+I2vvPuBk7FuqFZUnQ/3YrFNjFd2OeVq
	CxJu7/tyeTi8DwiLzpO7sSUkgRTHHN83MxYyzTnwruxAM7has+Ugn4o6HmT+uGjGRVSN7/NW6PlFe
	2o9qp6cYjWhHSN4wjMP/+lLX0HmgV9F4Q16X7M08gRcXAm4h0iWQyo7/Vo/efBuJbzJAbWyeY9+CE
	GvLe89EQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG56x-000000040Ua-1JZ2;
	Sat, 17 May 2025 00:09:07 +0000
Date: Sat, 17 May 2025 01:09:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, sagi@grimberg.me, asml.silence@gmail.com,
	almasrymina@google.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in
 sendmsg
Message-ID: <20250517000907.GW2023217@ZenIV>
References: <20250517000431.558180-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517000431.558180-1-stfomichev@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 16, 2025 at 05:04:31PM -0700, Stanislav Fomichev wrote:
> iter_iov_len looks broken for UBUF. When iov_iter_advance is called
> for UBUF, it increments iov_offset and also decrements the count.
> This makes the iterator only go over half of the range (unless I'm
> missing something).

What do you mean by "broken"?  iov_iter_len(from) == "how much data is
left in that iterator".  That goes for all flavours, UBUF included...

Confused...

