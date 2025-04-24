Return-Path: <netdev+bounces-185657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829CDA9B3FE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EB59280A7
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F922820AF;
	Thu, 24 Apr 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4qjxZvR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB72820AA;
	Thu, 24 Apr 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511889; cv=none; b=UrJ4sN8LvMisjULZ10x1QmNOOKQuuyGkQyJpVKsfwK0DCP56iVYjYLd1Ykx9ca/XhN9cuw3plSHzWv60R2Ydb+5MpQfn0GKLNTEEL+4zTxT6o3/xT+CMcW6PA69H2c2iaTWwpumV7CrmDxkrpr36RsZloVKbopfYdJ80QckmH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511889; c=relaxed/simple;
	bh=ehthhJRsT67ePCHd7tekdu+92oqaTFfVHKePVSJFtCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EejDKRAzWFYiLznfyj32IXLB6F86Ys/D9T/bg3+WvoP6rfuChCOUbucZOzujSxcuzp4M4JP3WjTF9hS1QVcDKSiPXJxNN2BLE9K8ksDjfM9ltzDs+gnH40xDiaNd0L0yUl206sOj3glnkK0bncp0n1Q1Wibpnrmv/8NUs4OjyqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4qjxZvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B101C4CEE3;
	Thu, 24 Apr 2025 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745511889;
	bh=ehthhJRsT67ePCHd7tekdu+92oqaTFfVHKePVSJFtCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4qjxZvR6FaqZL4R+VVLTh009Rpx+NCL7vIjuEb3ilJm/CfGsr2sP411UqEsJFwZ+
	 Py/Uo/xbi8SxuQ/rkxVjQ+hZulcPX8hjFyqk3YlO6rUw/Spq20yz4sBCYua/PQb02C
	 V3erMw/pp/3x0K9ybnA/g/IvKSuDpnF7u8aqYCVH9L8u0VC6lmPVwf7tpiYgkr/MuA
	 vCO2zwMKfeq7/YhEv0S0edvlZkF7sPV5FbCUicNwsyV8G7c/IcbQI1X9mC4xKBYdT9
	 RXCtJ0PLSX7PhG8oehjhjroD+/n/9RsldsOhLmzEX55LVt8J0BNbTXsV2yhlOcZybG
	 H+PH/FeUioUPQ==
Date: Thu, 24 Apr 2025 17:24:44 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: disregard NVM checksum on tgp when valid
 checksum mask is not set
Message-ID: <20250424162444.GH3042781@horms.kernel.org>
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>

On Tue, Apr 22, 2025 at 09:43:01AM +0200, Jacek Kowalski wrote:
> Some Dell Tiger Lake systems have incorrect NVM checksum. These also
> have a bitmask that indicates correct checksum set to "invalid".
> 
> Because it is impossible to determine whether the NVM write would finish
> correctly or hang (see https://bugzilla.kernel.org/show_bug.cgi?id=213667)
> it makes sense to skip the validation completely under these conditions.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")

I think that while the commit cited above relates to this problem,
this bug actually dates back to the patch I'm citing immediately below.
And I think we should cite that commit here. IOW, I'm suggesting:

Fixes: fb776f5d57ee ("e1000e: Add support for Tiger Lake")

> Cc: stable@vger.kernel.org

That not withstanding, based on the commit message,
and the use of e1000_pch_tgp in another Tiger Lake fix [1],
I think this patch looks good.

Reviewed-by: Simon Horman <horms@kernel.org>

[1] commit ffd24fa2fcc7 ("e1000e: Correct NVM checksum verification flow")


