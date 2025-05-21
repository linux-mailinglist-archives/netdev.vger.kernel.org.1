Return-Path: <netdev+bounces-192133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA33ABE9BC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71322168884
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D6315855C;
	Wed, 21 May 2025 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbDQvkCz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9112563
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793875; cv=none; b=P0p5S0PoFBQLI/f8ko4lNZPO3lRGCjwvjqC+iILLnQEqACBF+E8al8Doauv2CRAOUXfvkDo3ZYjerccHAwz/fvjuspEH1eblFY6+5jrejw5ON7TLmFJbxhuRvNtX2MdaIO5cfh8P/KGfWv/Js1wpTo/nFnsl+IorARedRn+YTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793875; c=relaxed/simple;
	bh=kYzxROcOBWbQGw21AvIeumYT/gGIziEG5zPtZMd6FXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bF65qLra0FERGszzCCo+Yreuoua4TN+saY3YB2FyVaURFRu6rItGLG1hx/V8cdrF8Bea4z0fWoWaeeNxh0Xy1tK+vLcPuf4zJYwUmGXUoGWUf7VRZKKqcQzwsqTixPBHwip+PIf18PXmCFkcSXp5C+swMCwHRcE90lyO8kNqAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbDQvkCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C81C4CEE9;
	Wed, 21 May 2025 02:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747793874;
	bh=kYzxROcOBWbQGw21AvIeumYT/gGIziEG5zPtZMd6FXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QbDQvkCzXMt2DUrbojBmyT0my7N1NqxHfS1hrr/Kn969t6cxtHfUux8gYv9jHt0CC
	 k6aUhDO0TstKAyflxz1QWrJ00oxP79q3uG16eXvUgMf4UNM6zdsAcksYtrnHfZrWr2
	 6nqiqCUlUVoIIEM2FhQWMGJEll4BKETH0oAIN73VEEB4r03rSwfOrFXmF9+uUja9ce
	 qNQtbLyY4hT6q9mpLIKbwepEMF13TSaYggSr6lubHbfzgSyX61lbHb+bDkELxS3e3y
	 1fRjg46LMsJIH4xsIfoqW4l0UZaTPYT74UXZ6vg8VUxC0TTxcNvJIJ47veqvrQJIVc
	 yU/u1ywysJQvw==
Date: Tue, 20 May 2025 19:17:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS
 contexts on queue reset
Message-ID: <20250520191753.4e66bb08@kernel.org>
In-Reply-To: <CACKFLimbOCecjpL2oOvj99SN8Ahct84r2grLkPG1491eTRMoxg@mail.gmail.com>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
	<20250519204130.3097027-4-michael.chan@broadcom.com>
	<20250520182838.3f083f34@kernel.org>
	<CACKFLikOwZmaucM4y2jMgKZ-s0vRyHBde+wuQRt33ScvfohyDA@mail.gmail.com>
	<20250520185144.25f5cb47@kernel.org>
	<CACKFLimbOCecjpL2oOvj99SN8Ahct84r2grLkPG1491eTRMoxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 19:10:37 -0700 Michael Chan wrote:
> > Shutting down traffic to ZC queues is one thing, but now you
> > seem to be walking all RSS contexts and shutting them all down.
> > The whole point of the queue API is to avoid shutting down
> > the entire device.  
> 
> The existing code has been setting the MRU to 0 for the default RSS
> context's VNIC. 

:/ I must have misunderstood. I wouldn't have merged this if I knew.
You can't be shutting down system queues because some application
decided to bind a ZC queue.

> They found that this sequence was reliable.

"reliable" is a bit of a big word that some people would reserve
for code which is production tested or at the very least very
heavily validated.

