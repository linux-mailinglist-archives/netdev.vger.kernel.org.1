Return-Path: <netdev+bounces-165764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E21A334E1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DECE16749A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFB413792B;
	Thu, 13 Feb 2025 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX77E3Jw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0C80034;
	Thu, 13 Feb 2025 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411051; cv=none; b=fLiAxOzvBwv7lSEQcCFH282atdMBlXBA84WPcxLziZnQxvmSlF3R/CvoW827gPoMp1cTdVu6Q8GAAUZl/eU9DgZzH0/brnHasJi0+2OkN1LxAp+lUFuIES3z1EuCpBS+tBn9Jj/iLJrwxYkWYT2yHGm8zYT3+I+dEO6724XmF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411051; c=relaxed/simple;
	bh=PiAqO4cwaWZwZ0+zlQA9hwpQDmP/A2e1niC+XO9uyFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jF4P2e0LCKso4awvmzL8ims8HRv0frwkv8ChZYVn5yLI8dXrz8jqE65zayuwodhjNEfL42rsM16lMai33/le9XqlsnjYSWp24PC3rNVa6qbF+59y2IQczudIUuLTRdBC8KrPmsIy+qfxhrHvCE0VGXni3ijZOegCkozrVFBU+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX77E3Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E6AC4CEDF;
	Thu, 13 Feb 2025 01:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411051;
	bh=PiAqO4cwaWZwZ0+zlQA9hwpQDmP/A2e1niC+XO9uyFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GX77E3JwvKVzG+XLJWnRpKZrH4DNFn0bYyqATerqOtikishmxI0sKtjiF/ckX0Yic
	 jNGzru7v5oLp31359mpLNUj6IS4RSYHeUwt2UPNwiHKp4ASWcAcT8oZvSrVpYl/Yzl
	 xxZ+qj+/a8VqvS8b1I2cown790wc+ZL+B5Gga4i+5gFrxYkdb+oum5QCbaLGCQf8Dg
	 HirDHCP1wudLE9AvBhHyQvvj1HaVhfbPn1OXhR/fOLj0j4vZ7sGffH+ckYKz+gWtuQ
	 Y+EOTGZ6AjIZgHpIl4cSptJtbFuqneX96s1DWLZ5X4ZsNsB/KsaHWQ1+D8mk38hk7t
	 x62LRnFpx+g9Q==
Date: Wed, 12 Feb 2025 17:44:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tls: Check return value of get_cipher_desc in
 fill_sg_out
Message-ID: <20250212174410.42d9ceac@kernel.org>
In-Reply-To: <20250212025351.380-1-vulab@iscas.ac.cn>
References: <20250212025351.380-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 10:53:50 +0800 Wentao Liang wrote:
> The function get_cipher_desc() may return NULL if the cipher type is
> invalid or unsupported. In fill_sg_out(), the return value is used
> without any checks, which could lead to a NULL pointer dereference.
> 
> This patch adds a DEBUG_NET_WARN_ON_ONCE check to ensure that
> cipher_desc is valid and offloadable before proceeding. This prevents
> potential crashes and provides a clear warning in debug builds.

Does not make any sense, the state is validated during configuration.
-- 
pw-bot: reject
pv-bot: llm

