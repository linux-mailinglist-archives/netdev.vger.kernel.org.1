Return-Path: <netdev+bounces-70954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A365851353
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 13:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB1D1F242D0
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156D39AE1;
	Mon, 12 Feb 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="XvyyAnaM";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="shfULbcj"
X-Original-To: netdev@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886A39FDB
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740069; cv=none; b=ZEXhKSXjtCjMQc1Ytqdkt67yfaSlbLuLGsV/g6fdK4Ql0lm1MO+MEL3bWFLLd5GwiUKJUIU6/W8QKON0A558Ary9H1XFNaim7M+WtKt8s+4U5uxho8egAjkNaSDJ6PawSRK5sPAL5+2IDpeAy8Td6DHgNF2JmcYzFgLiSSaqh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740069; c=relaxed/simple;
	bh=Pn5zogiyPRiHjXIT/y50rDh7mRTjVLMfDrtm3VkFkpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0BCqhCJxfq9H7aEFGjOjhOzfC2XcpS1dLFRsW9L5Z2lyD2qxqUDYZRdTUehudmRHAca62oFpgvRBxX+jz3SZdqp5LjUK1K+IdDNQYb/8g5tFmP2qrrrQSLjgUyC5W4qRGSnFQLmeMFfpDqMl8DA2pCYj+TlrJ6F4Q1+Kk7NXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=XvyyAnaM; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=shfULbcj; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id E6AF6C01C; Mon, 12 Feb 2024 13:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1707740063; bh=J9uKAK0vRpnU3LG0TXjxtthvlxNYsEtRU9Q3s7bTbsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvyyAnaMHUndfRz1pI+Bi/IiWfQ+zUWHXJKrXDzG+QcU1iO12ZF1Khghu38iz0JOS
	 U7/GCnMo3g5rre89JR7OByJ4Hru+Fgi573evk/1vGRS5AQlAspQlXqC7RIcvOM44OQ
	 R/6GiQy3JLreve6O2Z0UtmIlzHuRsjQWgHmzvUhDknVvkaKFY7xNoXZzvZ5ftcp7Ur
	 jdoeB2EusIDS6uB+bzb3Cqyew9I8Rq6nabXwUieUwmOgfTGE+RGtA8qPiKZlYDceZY
	 sBqrCla4Pstj4nSSK4gH2UhQLq/6/4mFGf59DHVt+jGCcr7UVO0gygLHKM6Yjn+N6K
	 HNgL7ZdAqrpEg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 07381C009;
	Mon, 12 Feb 2024 13:14:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1707740054; bh=J9uKAK0vRpnU3LG0TXjxtthvlxNYsEtRU9Q3s7bTbsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shfULbcjjvJc+CGzQIdeNTsxa7oxRkdaseyz3xhkO62eYAIfrFlf9DLahaMpyEW8L
	 RhYMngabxuVP8bkLcrhQgPDZljuiyzZ874JqdntsjVd+yGzSoK7A2zCT367kWy8FIz
	 f9O9Pm+xN2+eEo6lJgNIYsCAbDqQ35POt1UWLo0IZ17inFPVT5bedo8L5zC7kgOvXk
	 QbJZmbYEtS7qN7GVuBzaE8oLzFJpEfsxMRdNn61rdjimAYueflX9EVNSbnTU67f/oA
	 APM5OD03bYqJ15PWwSenhSvd0myshJBUxm/p9OpsQhMJvIgVaXsUOplZmhp+uSQpf1
	 GSmFCgk2zY2/A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3ceb6d61;
	Mon, 12 Feb 2024 12:14:04 +0000 (UTC)
Date: Mon, 12 Feb 2024 21:13:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] 9p/trans_fd: remove Excess kernel-doc comment
Message-ID: <ZcoLfSBNtfgmeKaI@codewreck.org>
References: <20240212043341.4631-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240212043341.4631-1-rdunlap@infradead.org>

Randy Dunlap wrote on Sun, Feb 11, 2024 at 08:33:41PM -0800:
> Remove the "@req" kernel-doc description since there is not 'req'
> member in the struct p9_conn.
> 
> Fixes one kernel-doc warning:
> trans_fd.c:133: warning: Excess struct member 'req' description in 'p9_conn'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Sorry for the lack of reply, I intended to take the patch when the next
""real"" patch comes in but it doesn't look like we'll get much activity
this cycle so I've just queued it up to -next.

Thanks!

FWIW, I contemplated adding
Fixes: 6d35190f3953 ("9p: Rename req to rreq in trans_fd")
but that's basically been forever so I don't think anyone will care
about backports -- and I'm both surprised and ashamed I didn't see this
W=1 warning earlier, I thought I regularly build with that...

-- 
Dominique

