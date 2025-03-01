Return-Path: <netdev+bounces-170893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0888A4A738
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 01:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38ECE7A41B8
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 00:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BCFA923;
	Sat,  1 Mar 2025 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFNu1S3E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F998149DFA
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740790033; cv=none; b=amJJtfTBSRS3YEUR/ua5j9LLKfQABbDpbNruViDfnQ6EWV8eJKoKOICgfMNiXMZ/GhVF+Eoi1Hd48slrNYTi1/i5mKHxU7mAhr0GqvNHZflWdGOm/mJKrVtGdGpJ9I8NQyQ21QsguHxZED+3CEH0l2ft45FOWDrWGKpAdnDGePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740790033; c=relaxed/simple;
	bh=PFTRg5n1yzhK3KCfO45YFztDpSFdgdOKKpfJdeiGfXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXGLHb5L3rcxkTI5e02cfVEuznPW83HtykwnSlCBvnneYxl1I5n623brljt1bU24wMNYu72DYvI7D9p4lWljD7q9IdRpxSDAOn5cgmp+jOTt0tWgu+IO1vr+iSDGasYisRviECkbTObO/REm7nFyoTA1TQW/nWEcjBYBsIIN1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFNu1S3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D54C4CED6;
	Sat,  1 Mar 2025 00:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740790032;
	bh=PFTRg5n1yzhK3KCfO45YFztDpSFdgdOKKpfJdeiGfXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GFNu1S3Erpsp/0BCVqm563XgxRPPck0cRCwvPMuI3KIxmp/LDokMe8r0ZwTNwISGP
	 0FvUs8FWrJJHjakkmv0IZD0wWUFZqgzweN/Lkj6nYOoLIwrB4Ndp5whzsfs5/qQ+T7
	 IUEe6gqy/KHCM5cHNBcPHcEI0ApoLI46kqxg3EZapy7Ktd4H4CfTP9bVoUTG+JRs+K
	 06nkH3eKBs6shdvSbq/Pfsvjg7CFC0yjv7INHaFhMz+fXlrd5LZJx3CIJVBcdwJWKm
	 PNGfhYmXLyVt+5QOV3J9gwn2M+ZnbgBwzIvZ/R8AzTmOBe1kbU2jd92+7A5uTEri6w
	 DJmH6gJRKMhcA==
Date: Fri, 28 Feb 2025 16:47:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, <willemb@google.com>, Madhu Chittim
 <madhu.chittim@intel.com>, Simon Horman <horms@kernel.org>, Samuel Salin
 <Samuel.salin@intel.com>
Subject: Re: [PATCH net v2] idpf: synchronize pending IRQs after disable
Message-ID: <20250228164711.52f7a54a@kernel.org>
In-Reply-To: <f186dc24-8cc5-427c-868a-1162e75dd3e8@intel.com>
References: <20250227211610.1154503-1-anthony.l.nguyen@intel.com>
	<20250228144051.4c3064b0@kernel.org>
	<f186dc24-8cc5-427c-868a-1162e75dd3e8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 16:59:47 -0700 Ahmed Zaki wrote:
> Most drivers call synchronize_irq() in the same order as this patch, for ex:
> bnxt_disable_int_sync()
> iavf_irq_disable()
> ice_vsi_dis_irq()
> 
> 
> The order is:
> 1 - disable IRQ registers
> 2 - synchronize_irq()     <-- currently missed in IDPF
> 3 - delete napis
> 4 - free IRQs
> 
> May be "races" is the wrong word, I will try to re-word.

I still have no idea what the problem is.

If you can't explain what the bug is let's just drop this patch :/

