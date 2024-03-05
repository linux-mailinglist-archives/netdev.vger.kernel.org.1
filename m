Return-Path: <netdev+bounces-77544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C281872272
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8D81F2257C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A33126F14;
	Tue,  5 Mar 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnVeoA5l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60128664C
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651603; cv=none; b=pABxzTNzVV8djKdRQSHulaJckNVGQCoM9I8icnudwtNO9QI38pmjYENkLJinZSZ4KlXX/qnOYDeoWGN83nkx04/rwsJULCeu+Frgz/Yp5VOJZnxOj6DlmlFm6/vMlZES+ZLjzx/609IFn5aB8XBjlR3h78EJOCH/CoISGvpFwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651603; c=relaxed/simple;
	bh=Aqaq9DkI0sA9vn3RaElwpqJ0iWqko0W3IVJIlsmJ8TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnSHS3OE93gG9PjryxhWOnJrQ0HDtynjQLcR72aAk02P65rhCB/m0XHqtMoDfN7Wz+nTtYsV/sbGginEVeELDhZDUdJuSvBI1GleirFaznG0wq03/H+jxxhZ15FTiMMY3YV8Re08R17icfhBvB0pHexOauu65T0JGkLO6DRlcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnVeoA5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA76C433F1;
	Tue,  5 Mar 2024 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651602;
	bh=Aqaq9DkI0sA9vn3RaElwpqJ0iWqko0W3IVJIlsmJ8TQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tnVeoA5l84SfAb6fiqv2iiBi5PQPbntwLAPqWvDXiocc7oo/rf+ZLusGTAih40Cn6
	 VMcZKdL5i6h7Jc5jHTkKIQgAI+fmM8qYhv/AYk2XNL+WYUeoSb6fBDnQcC26OcZc8V
	 3i5RDThWPlo2CyP5gsDeGkzoFkmbmnxd5XXM22yrcyrJAWXIQbnPqvTcijXVedPXL/
	 0dH5ANigVNEymD+46fV6gO3VpCUPtoK/E1LMlTg3Szbkopq5BavFno/EO8LdbmJfkv
	 VqEIOrdaTHWHsMTiNWaB2/QY7RV0P4URep26ba2YZ25bQ3q297xBs1vG2oDfNFaCSQ
	 qF+vnTUQuoFBw==
Date: Tue, 5 Mar 2024 07:13:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Doug Berger <opendmb@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Maarten Vanraes
 <maarten@rmail.be>, netdev@vger.kernel.org, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Phil Elwell
 <phil@raspberrypi.com>
Subject: Re: [PATCH] net: bcmgenet: Reset RBUF on first open
Message-ID: <20240305071321.4f522fe8@kernel.org>
In-Reply-To: <f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
References: <20240224000025.2078580-1-maarten@rmail.be>
	<bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
	<f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 15:13:57 -0800 Doug Berger wrote:
> I agree that the Linux driver expects the GENET core to be in a "quasi 
> power-on-reset state" and it seems likely that in both Maxime's case and 
> the one identified here that is not the case. It would appear that the 
> Raspberry Pi bootloader and/or "firmware" are likely not disabling the 
> GENET receiver after loading the kernel image and before invoking the 
> kernel. They may be disabling the DMA, but that is insufficient since 
> any received data would likely overflow the RBUF leaving it in a "bad" 
> state which this patch apparently improves.
> 
> So it seems likely these issues are caused by improper 
> bootloader/firmware behavior.
> 
> That said, I suppose it would be nice if the driver were more robust. 
> However, we both know how finicky the receive path of the GENET core can 
> be about its initialization. Therefore, I am unwilling to "bless" this 
> change for upstream without more due diligence on our side.

The patch has minor formatting issues (using spaces to indent).
Once you've gain sufficient confidence that it doesn't cause issues -
please mend that and repost.
-- 
pw-bot: cr

