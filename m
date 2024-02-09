Return-Path: <netdev+bounces-70408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C784EEDD
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3751C21EA4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 02:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19CC36F;
	Fri,  9 Feb 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2KCUKk9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7591849
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446031; cv=none; b=bTVQoRnoMD0czz+1pP37epukQtQgEX9pLiRqX6uUhz/oLG5bHKYjwFvCu69Mk/NJEGk3t6teKclRsU2QHEL/lbOsHShpYt41KOXxj5K84E8uB6HLppc0brLDdcwDTXaz5edOPgSQU8ZsxEssNM1BB09dvb15OrZyXv37w2Kk46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446031; c=relaxed/simple;
	bh=OfpqjLmYtb5ZXf0E6v5Kd5aQ7CTyhtAON3mR+Mst2+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVsY8iw2Cjp9kA/MzVIodjsg371ltMaIZOOij/DxkvAk3UdwU7V/g6Jx9KZxjR34ZU3EZVpi65EFvlZLW+CQWpMc1DpEZwCyG4/5onUcrpP3Y8B0ZV1YRnzlpK40NfRAv1LmlNfikN17vKIJP++eQ1jnGchzyL1wqeIdgYzJPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2KCUKk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4E0C433F1;
	Fri,  9 Feb 2024 02:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707446030;
	bh=OfpqjLmYtb5ZXf0E6v5Kd5aQ7CTyhtAON3mR+Mst2+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p2KCUKk97KLp8sknCoMSnJG+j0z5BKeOFspBRO2WTr5GVylzuJfvZsJ2g8RBUud4e
	 B8UjlFjX98kqp3nXS20jbf5C5rB81bqttiB9ivdG8eKZFXECtWBrtRuh+1Ln0pj6XA
	 l9aYw+Ssk2btvH3WNzE+OAH4kuaTZuBLNZJHSzqnmgUOuFggT2rwyeikcny7dDM4Nm
	 MUDA+UGGqPq0JlyL3fJ/U6GzZaefLBAvjGUMz2pU2BzKH615gifd4siYvV8dKwllVt
	 3Mk7IUs/Y3cNtaB6fZfT5Jv/EVndO5l+UvPf7TBhUe0FX7KPPqYG8yoYv2cqCw4+CM
	 a5VzEekGjFWoQ==
Date: Thu, 8 Feb 2024 18:33:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Sasha Neftin <sasha.neftin@intel.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 2/2] igc: Remove temporary workaround
Message-ID: <20240208183349.589d610d@kernel.org>
In-Reply-To: <20240206212820.988687-3-anthony.l.nguyen@intel.com>
References: <20240206212820.988687-1-anthony.l.nguyen@intel.com>
	<20240206212820.988687-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 13:28:18 -0800 Tony Nguyen wrote:
> From: Sasha Neftin <sasha.neftin@intel.com>
> 
> PHY_CONTROL register works as defined in the IEEE 802.3 specification
> (IEEE 802.3-2008 22.2.4.1). Tide up the temporary workaround.

Any more info on this one?
What's the user impact?
What changed (e.g. which FW version fixed it)?
-- 
pw-bot: cr

