Return-Path: <netdev+bounces-132311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E099131B
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407761F2425C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EF815359A;
	Fri,  4 Oct 2024 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4DXoloG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC514C59A;
	Fri,  4 Oct 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084975; cv=none; b=eIhd1Uetb42so5roxAR8RDIHpidDqW4/raDO2rGdw0jwrZ5VsKHDRLogqg9XFw/rTueymhgBekEGFaRe4bjHb7Ib8eb4kvwnl4QEorBzj1W++hUOdYU2Iapl6fbW2oEdb0pkLdVrnRmp9gZbAObZVivmneoYh1qfFHq+/NVF7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084975; c=relaxed/simple;
	bh=nKGXs7BwgKnuBEhXeAc7JP35n81cOPgB/Ec1rS/DbZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvStZIqRP/iktO3taBdKfqhTYFIDIr63EecGkHxC0L6JjATIl0iXHyApf+KBDI5SZWt7A2GiiepH/EXJWaF5GcRUFAoxy1o2miVQb4BNUXWixDSSbzrjTpL5J6W9b5stoWxAGBmOGHU+d58iS8Vft+0KmR4qXS98cpwazhtC2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4DXoloG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E7DC4CEC6;
	Fri,  4 Oct 2024 23:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084974;
	bh=nKGXs7BwgKnuBEhXeAc7JP35n81cOPgB/Ec1rS/DbZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k4DXoloG0/VvR3xO8T5/KOjdv8s3qrlr5D1q1nRvcHriXyD1wF5Bwg2/Y8vtDOGrj
	 Zf5Ypl57yijSwNJjQ9UrFduLRT/QFsa+KDnA4Ev0EcSnS8G0vBsVzmwCR4c6oNMFXI
	 N1KPlK23aDzZrqLhQQwPtvNrhn2g2dGGeoVAKk6YB5Bx47jrsiKFDcpFeDZc5c/TKd
	 OgL3Jh2Fr7juzxeoIUR04RMxKGI7bcNzHl7uTntZ0mwxwQeMae48QuvgEz/WAygtwq
	 CFpKTQJv7mYiZisnNnKL5RsHF75QmlKNYeZVWuUHqcHriFSuw6IlHqW4mgRON0Lpow
	 6jKugY+75AGow==
Date: Fri, 4 Oct 2024 16:36:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 17/17] net: ibm: emac: mal: move dcr map
 down
Message-ID: <20241004163613.553b8abe@kernel.org>
In-Reply-To: <20241003021135.1952928-18-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
	<20241003021135.1952928-18-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 19:11:35 -0700 Rosen Penev wrote:
> There's actually a bug above where it returns instead of calling goto.
> Instead of calling goto, move dcr_map and friends down as they're used
> right after the spinlock in mal_reset.

Not a fix?

