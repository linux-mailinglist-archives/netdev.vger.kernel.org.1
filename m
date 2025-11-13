Return-Path: <netdev+bounces-238450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F754C59094
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4A04A255E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEEE342CA9;
	Thu, 13 Nov 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q9YecWOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816334DCFE
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052058; cv=none; b=JegU6yIK1TvJRXwpYq/yVHDeMBBtz53Nktpq9okTCJfxtFFPCN83Cip7Ut7TtGaDklFJ6BsThSyhMtoEbebErcdLF1muXUAi+vUz7/CwFXUY0adCaQ9p+hYL8r63T1Um/cpaRel9QHe3F2MSNbDGznQW1N0GlX7xQytRpX+N5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052058; c=relaxed/simple;
	bh=SJFNmWGRGU5X8ZL5+tzvpmc+XBALzGWNyHojV5X8J84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka07lHyXFxgQa8g/6N4+3Aol538MTFbiIK2UHEmAOMNg3j1wGL5WxmzgUJAgaYanb5sgB/M5EUrO7PI4J5CC4pfhMLSdMcKvJ5wtEc42sL+g1ECWnmT03KvJRaPwnyFjSrjXzv7yig8ITgXlQb6wcR6Z6Hy/F3z+2cp8BioBBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Q9YecWOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0105FC4CEF7;
	Thu, 13 Nov 2025 16:40:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q9YecWOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763052055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAmwmmD2qgGVSU1t/O9oUv/kmIKskSiE9vvPsc0RXD0=;
	b=Q9YecWOFbDkpU66syfyHWR9T5iEQ6HXO8lmoEXJAWqHmfBxjfAY32yecWDr/xilrYMgwdQ
	0fef5kQuzFbUNaWeWQKfgCggDpTCMHEyLVCVtLUdQjpgtulcWbzpSQI6KG5dKRVOWju9jR
	Fa7ugIJm9xW58rfYCqkfxZp1/ZU62P4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4d6947d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Nov 2025 16:40:54 +0000 (UTC)
Date: Thu, 13 Nov 2025 17:40:51 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Marek Mietus <mmietus97@yahoo.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, kuba@kernel.org
Subject: Re: [PATCH net-next v4 09/14] net: wireguard: convert send{4,6} to
 use a noref dst when possible
Message-ID: <aRYKE2rKobILiqAG@zx2c4.com>
References: <20251112072720.5076-1-mmietus97@yahoo.com>
 <20251112072720.5076-10-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112072720.5076-10-mmietus97@yahoo.com>

Hi Marek,

On Wed, Nov 12, 2025 at 08:27:15AM +0100, Marek Mietus wrote:
> send{4,6} unnecessarily reference the dst_entry from the
> dst_cache when interacting with the cache.
> 
> Reduce this overhead by avoiding the redundant refcount increments.
> 
> This is only possible in flows where the cache is used. Otherwise, we
> fall-back to a referenced dst.
> 
> These changes are safe as both ipv4 and ip6 support noref xmit under RCU
> which is already the case for the wireguard send{4,6} functions.

Assuming the rest of the patchset is fine, this patch is okay with me,
with one very small nit. The commit subject should be
    wireguard: socket: convert send{4,6} to use a noref dst when possible
instead of "net: wireguard" etc.

Please CC me on future revisions of this if you do a v2, and I'll give
my reviewed-by.

Thanks,
Jason

