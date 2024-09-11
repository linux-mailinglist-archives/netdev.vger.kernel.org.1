Return-Path: <netdev+bounces-127445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C84F9756DD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CC31F2260B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316241AC452;
	Wed, 11 Sep 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEFxSSk0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18E1AB6DD;
	Wed, 11 Sep 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068037; cv=none; b=KUJWULohcNEwHpc0shCJ5NJHQmU4Nhj11cSr7tXc+TLBgL5IC1i6bhWiyUA8jn2vKyX57mD/T5i/jIDuVrtJNpMHyqjONkv/5EIM8fcbxxtTHGNfedmWMlksn1T4u0uQRLxWCGs6WAnuZDiaJ9pT84NzbA5Xpmn7lYMP7OiHU24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068037; c=relaxed/simple;
	bh=tZJo0oRkwnQ0wz0RXtGEBBzCddmRFOsdymTjhK+Mz9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgpbGURFQ+arDgmOLPrYVVjyG0LjGWe2gqzO6kvDEpkvNgJZ48j3aKQgWYL6H2YSYDcnc71jpXK2YwCVU5IaO8ODcN9rarp9QKRh61g0kG3z4EDIvW8+jdySdP3NGNNLLzvbTJRl2/ZfiDVsxNFjbO7Xu1M5ir2pW1VX3bGl15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEFxSSk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6564AC4CEC0;
	Wed, 11 Sep 2024 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068036;
	bh=tZJo0oRkwnQ0wz0RXtGEBBzCddmRFOsdymTjhK+Mz9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gEFxSSk0PVcUP+DxRoWXXjYwqOz7wwF+le1NlIE8E8Jn7+Qp/p6w3i8bCMU4BkNX9
	 7eiyBDwZS6iEJOkdDOnWDGAENoAb6MBpLWEH4bPCqIW8o4Yyc9ShgpmUG9K1zoNsxU
	 LWH3JTe7RXbo5z6fZ2oCDZQaelof/auzRaRFr/VbYeW1tRPANFsfy9BH5gNYyJYuDi
	 WffD+c5ZPer52Ax4+MZupm+hx+Yi9RQtFQSextnktFc0w2Ud0IiIV0awrRtSCQiqZy
	 8JdUFzidXvme/UVMWc8ZSXVBsnwBOZSNCMN5g3VeSfH9nr0aMaMCH3RF8sc2H5I+Fv
	 xb9slVlJ4n/ew==
Date: Wed, 11 Sep 2024 08:20:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julien Blais <webmaster@jbsky.fr>
Cc: thomas.petazzoni@bootlin.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mvneta: fix "napi poll" infinite loop
Message-ID: <20240911082035.403f4664@kernel.org>
In-Reply-To: <20240911112846.285033-1-webmaster@jbsky.fr>
References: <20240911112846.285033-1-webmaster@jbsky.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 13:28:46 +0200 Julien Blais wrote:
> This e-mail and any attached files are confidential and may be legally privileged. If you are not the addressee, any disclosure, reproduction, copying, distribution, or other dissemination or use of this communication is strictly prohibited. If you have received this transmission in error please notify the sender immediately and then delete this mail.
> E-mail transmission cannot be guaranteed to be secure or error free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses. The sender therefore does not accept liability for any errors or omissions in the contents of this message which arise as a result of e-mail transmission or changes to transmitted date not specifically approved by the sender.
> If this e-mail or attached files contain information which do not relate to our professional activity we do not accept liability for such information.

In addition to answering Maxime's question / reworking the patch
you'll need to figure out a way to post the code without this
disclaimer.

