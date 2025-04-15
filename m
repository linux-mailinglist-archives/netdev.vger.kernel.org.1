Return-Path: <netdev+bounces-182548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B67A890DD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44247A5494
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80F1798F;
	Tue, 15 Apr 2025 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY8KblaX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693548F58
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744678037; cv=none; b=eDhjjHc/58Por+kGASLVzBLxi7qDiu4T2dWb8QvD1sQJQuF9ePxsfJgTZ9kvMK0v2i7JCXk1DisaxT32lSHm0FToJHu1wZwKukK6mOOojQ7KC3mmAyFBjGBaar9B/vkLtNcFmZjGgdHKSoKa53c+EuVLMrrwxRK5F7UQjV/KlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744678037; c=relaxed/simple;
	bh=nLIohd4iWQvveJpFMtx5ynlgIcKYJBmBSraYQGu9T5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqjB9p8RB7KF9acs4lJPAtbLLhLnn6MPI2U2mKGtO0Ekf29dUj6UtP66JKoZk7cO5ttpVw79j6+3eYMUpLc1KjrmWV4ZnkdTUbQqHxuwA8U+hBc/wdPyiH2ysOgLNyQzFFzn4XFBnjakIOkko49PDfgNyLXwPtlXPl/XnN4ywRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY8KblaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DE6C4CEE2;
	Tue, 15 Apr 2025 00:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744678035;
	bh=nLIohd4iWQvveJpFMtx5ynlgIcKYJBmBSraYQGu9T5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VY8KblaXmJC9sJa5E7uabaTUBnSffSZ82AurAFF+D9gPNGjiXiyhk54D0Y7+Gah9A
	 zErPXNsDVDV34ogel9L1qXfastWiIsdlX6hawFPK0HXnd7VDg7fDYMB4SoKuTvwQ3L
	 UsNodqVvCBeF9fXZ6GGy+eupdj24+j8ItLLo65vwmeqTRxpNoyON64wVDajSyQG7ub
	 JksY0aQzK/XfwfrdsBSKBmQHuux1Sa/gaXanZXocQITNGB0V/v178DoR8C/WIHLsyc
	 +lsGFNkGEsqDxhVZaSofWT/7fG8oT11pP6X6YCbqldekY0zsE25J5/gBmI94YstM17
	 7NxZEiN239Qcg==
Date: Mon, 14 Apr 2025 17:47:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 4/8] net/rds: No shortcut out of RDS_CONN_ERROR
Message-ID: <20250414174715.26b048cf@kernel.org>
In-Reply-To: <20250411180207.450312-5-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
	<20250411180207.450312-5-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 11:02:03 -0700 allison.henderson@oracle.com wrote:
> Fixes:  ("RDS: TCP: fix race windows in send-path quiescence by rds_tcp_accept_one()")
> 

missing hash and unnecessary empty line

> Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>

