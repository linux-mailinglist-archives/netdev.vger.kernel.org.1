Return-Path: <netdev+bounces-239704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93EC6BA0E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6EA94ECAEE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FFB370310;
	Tue, 18 Nov 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2TdvWPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3993702EA;
	Tue, 18 Nov 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497640; cv=none; b=PtOngxeAH+RsbwuiSI+S1p63VusaFF1q+q9PbwqxUK0MYqG7mVus++JeQiPWFMrP2mQQiPt5VEF1ckUkgXdzeDhp+WTKjIJzZPqDbFGxxMHcXiMXnxajYMp+pINwuJGuewqcA2JqOzy6CajTWiTek8h+py8yGXPr00CzG54SZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497640; c=relaxed/simple;
	bh=diKlHOpjb5XVjO5TKNlve8x2PkW4wFI7hs+EFCpTFUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ypi4r0d0w8zT/RK3tyIFoOFpraTkvVKoGHRVGLdC2C4bM7xp1VCcWKuIs9U3/wDxHKSebwEmQGZDlZvls6BxDgxYPoEKDi8nxas7lIbB7KweI2cgMKs0T/oTwZ/1RLfsEE8PunCFk15+1KPkDDlL9JMWd9Qi69trBw4XrkuCDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2TdvWPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3722C116D0;
	Tue, 18 Nov 2025 20:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763497640;
	bh=diKlHOpjb5XVjO5TKNlve8x2PkW4wFI7hs+EFCpTFUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2TdvWPL720koNYa00tZ4YyznHYvwz905UCU6J5/xcLIFBnBIfqTnh6C0qwDmnMLk
	 UtpyORm6LfEzXmCi+hB5xU+oX/KRLZ4r3tcjX8Wd3kmylAz7oJsg5USlGXDgvDFRAX
	 znSKQPQFK0WgrTWsk85pPQzdbUB6wxrGz4F91QSK6B2jkcCpOmA0rFXQ0urdnEEhjt
	 f1kp9HECMl3o+TPZCA2N/O8RJsIMRk1mV78nhwWMFJF1ogVl72BZKomwGqKWTflI7g
	 VO9EqJ0em4A+J93CWwrqY2Sbor5x+dfnPEvMwBJV62/5jV/sjOk74eErU3ZVw7Cs4s
	 0ex2ZV4bhnbaw==
Date: Tue, 18 Nov 2025 12:27:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20251118122717.16b723fd@kernel.org>
In-Reply-To: <bf9c2ceb-f80f-4fea-999d-4f46b2369721@embeddedor.com>
References: <aPdx4iPK4-KIhjFq@kspp>
	<20251023172518.3f370477@kernel.org>
	<949f472c-baca-4c2f-af23-7ba76fff1ddc@embeddedor.com>
	<20251024162354.0a94e4b1@kernel.org>
	<bf9c2ceb-f80f-4fea-999d-4f46b2369721@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 13:36:41 +0900 Gustavo A. R. Silva wrote:
> Not sure what you mean by "nasty" and "no clear benefit", but here is an
> alternative. See it as RFC:

Meaning of the words per dictionary definition.

> https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=testing/wfamnae-next20251117&id=e0547082214e61b1db0f5068da0daa3d11f992a5
> 
> [PATCH RFC][next] ipv4/inet_sock.h: Avoid thousands of -Wflex-array-member-not-at-end warnings
> 
> Use DEFINE_RAW_FLEX() to avoid thousands of -Wflex-array-member-not-at-end
> warnings.
> 
> Remove fixed-size array char data[40]; from struct ip_options_data, so
> that flexible-array member struct ip_options_rcu::opt.__data[] ends last
> in this (and other) structure(s).
> 
> Compensate for this by using the DEFINE_RAW_FLEX() helper to declare each
> on-stack struct instance that contains struct ip_options_data as a member.

This is much better, thanks!

