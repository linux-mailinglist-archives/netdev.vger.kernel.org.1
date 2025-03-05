Return-Path: <netdev+bounces-171913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A61A4F4E6
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F313416EBE5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B615199F;
	Wed,  5 Mar 2025 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1Qi2vWO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919445C18;
	Wed,  5 Mar 2025 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143105; cv=none; b=gxp4DGrOc2E6bCTEQJwihggVd9fh0LqM1L5Qiw8DecISDUE67YLimFyclwiuvjamvkT3D8XF+O1oD2mlYj9eCfqkPPF2kT7hbWUVatPEG1eAq10BjWqozfS7Qal533NLGI5/hAundftnCHs4mSV6LjIHxDZIVjx18UftPTPrxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143105; c=relaxed/simple;
	bh=g2WThUhsO91dz/mGuI8D2NX0Nz21o4kxNDUGWqjAteQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vi5mnypKOXSb53xBRX945mQh7h9s0ITcPJzB/AvgUb2Rlb21LaggDsonFIeHWoJRqT1fQcrePiUIJvWzqyhoGxI6S/ShMwyj+jsT5hH5NE9lxxi0by4+uJw2d9z1Vi7kdpDTP7AA4+nSXYh107FwuLbRGnrqOi2XX685wLhqdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1Qi2vWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6454AC4CEE5;
	Wed,  5 Mar 2025 02:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741143105;
	bh=g2WThUhsO91dz/mGuI8D2NX0Nz21o4kxNDUGWqjAteQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t1Qi2vWOzXCQp52HSv+6eZdbSAEM2/Z5bQD/4eXpWnE9U2Tg0lweDrQz22PsiNNlq
	 p0V+gYdFIcqkFTZJl0pqvO60WCxvEom78r/xCujHHyy5WpDqS7KxTxMhe5McwlVKM2
	 HHQ0EgygMJPT43zlm+cFPcwoAYxAYmZBaYJdgVvuKU0axjse+BTbvy1U7ksaiy3KAR
	 fGe64vVrwKQWG8AwHSLeSSDpq7gEpuVZoiyMUe/GcANhWQ0nqkRcPiLlTygZCWrfLI
	 sjHHELtQzOsLA2XTCKA+9ApcyZoOz8P/t6trdb0uJiGf4r8NjDCM4PdMYyX+KhMIaE
	 ILU/EBawYntQw==
Date: Tue, 4 Mar 2025 18:51:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, viro@zeniv.linux.org.uk,
 jiri@resnulli.us, linux-kernel@vger.kernel.org, security@kernel.org,
 stable@kernel.org, idosch@idosch.org,
 syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] vlan: enforce underlying device type
Message-ID: <20250304185143.3b1eb5a8@kernel.org>
In-Reply-To: <20250303155619.8918-1-oscmaes92@gmail.com>
References: <20250303155619.8918-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 16:56:19 +0100 Oscar Maes wrote:
> Currently, VLAN devices can be created on top of non-ethernet devices.
> 
> Besides the fact that it doesn't make much sense, this also causes a
> bug which leaks the address of a kernel function to usermode.

Applied, with the line wrapped at 80 col, thanks!

