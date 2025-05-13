Return-Path: <netdev+bounces-190024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA5CAB5027
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9181416A40D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39138239E6A;
	Tue, 13 May 2025 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlHFwGDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED8225A5B;
	Tue, 13 May 2025 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129507; cv=none; b=F7VqA1LLiIhDcrFZLc6v3JHohocIunjetg+7LwJjbq80tZhlb6BX4IeC7W/0OYK9lg1eoCfiAC2ZAxSyVDBZhm6FBKFawB8TLw0HAnq6d3rihQvPZS6cfDJ7BbeLtRw/GMLybUyWYSoz/a7iCeBq6KaN2+Dy9G47q0XQcZmYJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129507; c=relaxed/simple;
	bh=4cA/c2SgQaSutqHVEWpXBGOkHrfbUUtsB5JUpYIhYgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8+xbyLs0L0vkrdHjG/IsWIOLrnWuKJ0/kIOLFCmGJ31U25xvgzwXHbeGWIBgtzPKnOYzxpzQgzruRtJ+qFBBMkq/uBn85R8wfaPcZL04YlaZ643AOESbvX/3I9fUkM/1hQ72JUYEh4dJDG3Et3VTwzCaO/rvLELpdz8gYc/AUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlHFwGDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BB7C4CEE4;
	Tue, 13 May 2025 09:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747129506;
	bh=4cA/c2SgQaSutqHVEWpXBGOkHrfbUUtsB5JUpYIhYgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlHFwGDWcQ/IbTTatd7as9XRkk5sgfpCUVmNCSPZiOp2ThCJNSUit/nUzokrMWIx6
	 4ocQcKK2VO5EZRJfCv8WlsI+7akoebkAubdPaQ+GGgRuUaF27Kiviay2eVkrgI92Cp
	 h07bSB6/bDwIJh33hr8xPEVL3QYXqcRQ7lbyV0fOfAo2roa9xsvwj7AyjrnF72l1Le
	 vBfpWsXnBLHo2DfNYAKAMPmgSiogb3r2FmngoTXrZoxpwzVZxCPUg+gnMox6CuD32J
	 SR1kial5gwYCuJ8s5NsW3vX9Ms/wrW/p9Xv1+gWLi2P430CvfdEMUi21QUigNlRya/
	 XwJh6mKD5XN+g==
Date: Tue, 13 May 2025 10:45:01 +0100
From: Simon Horman <horms@kernel.org>
To: Zak Kemble <zakkemble@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: bcmgenet: tidy up stats, expose more stats in
 ethtool
Message-ID: <20250513094501.GX3339421@horms.kernel.org>
References: <20250512101521.1350-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512101521.1350-1-zakkemble@gmail.com>

On Mon, May 12, 2025 at 11:15:20AM +0100, Zak Kemble wrote:
> This patch exposes more statistics counters in ethtool and tidies up the
> counters so that they are all per-queue. The netdev counters are now only
> updated synchronously in bcmgenet_get_stats instead of a mix of sync/async
> throughout the driver. Hardware discarded packets are now counted in their
> own missed stat instead of being lumped in with general errors.
> 
> Changes in v2:
> - Remove unused variable
> - Link to v1: https://lore.kernel.org/all/20250511214037.2805-1-zakkemble%40gmail.com

Hi Zak,

nit: These days it is preferred to put Changes information, such as the
     above, below the scissors ("---"). That way it is available to
     reviewers (thanks!) and will appear in mailing list archives and so
     on. But is omitted in git history as the commit message is
     truncated at the scissors.

> 
> Signed-off-by: Zak Kemble <zakkemble@gmail.com>

This does not appear to address the review of Andrew and Florian of v1.
I think the way forwards is to engage with them on the preferred way
forwards. Or somehow note that you have done so.

-- 
pw-bot: changes-requested

