Return-Path: <netdev+bounces-88390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC118A6F8C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0052814B9
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9967130A7F;
	Tue, 16 Apr 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWHE2LeK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3F1304A9
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280723; cv=none; b=fmeQAnnKsXisA9pcYextsZy0ivBgq/viTyQYa9jiwuZd8RrHYLYtbjegNus5GlFsOSBvI5Vu1lm+X1S0q8BP0VBbvhfMdU9G2QEh9oFYyQ2AWrJfCZZicULvZaLHT3Rh4Ig/3DbOcXrMkUToa+pEfoErVCwWLbPa2UFKmQgb7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280723; c=relaxed/simple;
	bh=OsA1Hb/7K7k+WfIl3baRz1mBWdPPkAUxFw6x9VhAQBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJ1pkLi7X+j9xd5UWQVRAs9I/1KCe7sN/yw/9sZliJF5MhggOVIsMQa6TLu1nVsL1KKnkkuEvP6bryobUHv6nKSJF5TwY4kB/fKUriFh+VdO5kTe2pf6pz/zuLkz8aHA3An3bovn2Ikk1LghInoD4klWZ2s8WjpuAzMp3nFnUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWHE2LeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CD5C113CE;
	Tue, 16 Apr 2024 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713280723;
	bh=OsA1Hb/7K7k+WfIl3baRz1mBWdPPkAUxFw6x9VhAQBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jWHE2LeK6aaZlop2BB7LTRYtfpDOWAfkDkU0zBFYE+045BdnWaOCEa9J89t1beWv4
	 iOO2LLxYkSKFC5TR4wo/TepDtvTksuyqwxDMLQQP+a/UYZ06FrXip2WvAbi9KWjpbx
	 NBqHdFRsEgN+kx5GR6F/ysUyhmW3Y3263e+v9gNp2CBjFXe+jqu6mplp/2C9/NNe7F
	 T/P45AF7Zgd+cOjm+Gl83pGLVLwADuJWWUYTHOi3id84aD6DUJBAm7e3RAHT5wkGvF
	 FQfs95v6SB6TZJGPkhgKHkT+/84rrEGBdjd6MmywkW/AK5lCtTGTxn++ZOuNtJUj7Y
	 MZ7KaNZrBe6RA==
Date: Tue, 16 Apr 2024 08:18:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Hui Wang <hui.wang@canonical.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>,
 <anthony.l.nguyen@intel.com>, <dima.ruinskiy@intel.com>
Subject: Re: [PATCH] e1000e: move force SMBUS near the end of enable_ulp
 function
Message-ID: <20240416081842.35995b10@kernel.org>
In-Reply-To: <f4bd1573-400b-4b45-940a-e1dc5e19df45@intel.com>
References: <20240413092743.1548310-1-hui.wang@canonical.com>
	<f4bd1573-400b-4b45-940a-e1dc5e19df45@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 13:15:41 +0300 Lifshits, Vitaly wrote:
> Thank you for this patch and this observation.
> I think that you found a real misbehaviour in the original patch.
> However, I still think that forcing SMBUS functionality shouldn't be 
> part of the ULP enabling flow, since they are two independent 
> configurations.
> 
> I will soon submit a patch where I wrap forcing SMBUS in e1000_shutdown 
> with an if that checks if the FWSM_FW_VALID bit it set.

Why are you submitting a patch instead of asking the author to change
theirs? This is not how code reviews work.

