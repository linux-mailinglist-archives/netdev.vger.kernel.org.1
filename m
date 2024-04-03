Return-Path: <netdev+bounces-84432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D4896EF2
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5197288A41
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8E56B64;
	Wed,  3 Apr 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz8Nyd6L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341850241
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147868; cv=none; b=p3/ie8F7ZAEgVrL1X/Z7zesqycUVRkhnaSzi5seFjwtsYk5jOLT8DeB2ZyblGX2f8BOlr4BIPLWfmPwD04pZalDCC6AKzSMzgu4SDilXLeSGUJq47B9iVnrYQim/Da5a9ANyZ3pNZ0cfm+mhH7OkukLQqxUCmFYiW3BsiNNCluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147868; c=relaxed/simple;
	bh=QCQko2aqMF/VVTxkjqGbTjUXivgcbO6sKLcqITi59GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1b6xcU/SdVWhjuUjaX/9swlV5Lblu0udC+64GkZJn+8kL7xQpyd8b8I+X9NUsgALpUn+7lBDVzS/2d+DiPbOtSM0YwkJzE4Gpzk48pbLVfgg+6amDXCbSZnp7oj++OFl6OT3ptJ47tJBJ+UCT60s0B98eRsWuJwcdLyF8nK11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz8Nyd6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5031C433C7;
	Wed,  3 Apr 2024 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147867;
	bh=QCQko2aqMF/VVTxkjqGbTjUXivgcbO6sKLcqITi59GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jz8Nyd6Lb8/dBu5XOXJOxBh4z+JPGlNdNOlgZm2rO+VB7YjLigxSu5KU577Uzm2vH
	 Ahy6/Lw+6/ZyNPCOuMKj0yKUz3JWAb3R4eaKWGbTHh4jjxlJzpn0r/Vgv2EfcBK6+W
	 pM593xvElz9+CDWJa5zKalKPqRY48oLb2F+BtG4sN0SX/oJ1j1GHWjTqCTmOc+TzwM
	 m04y4Om9Bl4EzpLYmSwSqcbZtJbNSE9yijP0vhT85B+7yoEgWulIsFYt58RzHkF8jX
	 FcyPtbQQQ24dsW3vd18rbwL9yoZjBeL3Lb3fm2b9NnS38XpayU5NQAhSx3Q4wQ/KWQ
	 by4jrwVrc757g==
Date: Wed, 3 Apr 2024 13:37:43 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 04/15] mlxsw: pci: Arm CQ doorbell regardless of
 number of completions
Message-ID: <20240403123743.GZ26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <f8efa481bfe7bebb9f93bb803f44ab7da77f53e6.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8efa481bfe7bebb9f93bb803f44ab7da77f53e6.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:17PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Currently, as part of mlxsw_pci_cq_tasklet(), we check if any item
> was handled, and only in such case we arm doorbell. This is unlikely case,
> as we schedule tasklet only for CQs that we get an event for them, which
> means that they contain completions to handle. Remove this check, which
> is supposed to be true always, and even if it is false, it is not a mistake
> to ring the doorbell. We can warn on such case, but it is not really worth
> to add a check which will be run for each CQ handling when we do not expect
> to reach it and it does not point to logic error that should be handled.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


