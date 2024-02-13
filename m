Return-Path: <netdev+bounces-71120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865E852579
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB45E1C2143B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0EE186A;
	Tue, 13 Feb 2024 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIHmZZfm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914FB661
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784639; cv=none; b=FU4z+K+8K8yoeCLzFXNlWvmEn1Wq2+PXHbVNYQSYcsF9hFTkGqbGt1R5hfUa1at3UAJlrnM7OnV+YMuTvtzf/vVOADVM1t4F3OnFnN2Dt18DVIiaW6BH4O/e7Gs3BPA6ueZN+JsouKHbPWJU5KNBJUirgdcglWtXnMrTqIwdAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784639; c=relaxed/simple;
	bh=pilzWz4l5aNY20vvQMytarjNrbfk3Dkm/eXnhujA4xE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O39sI1QuRzAkg7gniBzb8RXm2uYpJOQayHY4nMmeOo4bPu66ijsX9fBauRToTx4Dykiw4I7FHrT2QfeTuBrreLWR7zpPkDF3Xk8FJuaM/YSYsvsXhYondXlXQZRnOcFqB/iW6PnC0P3f44JAYjSh+oruMB7lmILSPC4AvkyIJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIHmZZfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABB3C433C7;
	Tue, 13 Feb 2024 00:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707784638;
	bh=pilzWz4l5aNY20vvQMytarjNrbfk3Dkm/eXnhujA4xE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cIHmZZfm1BwI1ZgjmdMe/UfWKBQ2fhAW76yPwCIF1t/Rdq4Tb0osZ3tPla1804xa6
	 l3k4d/Hw7OOJwKt2ggxOMjjR+14yAgcYMesgjnqCSobX1fm9gSQ2BEVO8idxhCBq6M
	 b/i6fUqrpMYwJIgijXP8Hhkfoeet/oNlfG3tcvSeI/0ZNst5YqWBLy2S3uS9j/rWZz
	 GkgsWM3yPJJrTFFoQ2l+TaoJaqBz+HwRYJ/SkkrdXPwHtnt5vy5dHirIN5maEmJe43
	 10a4plyG3z9o2zi38PXWArWZXM+s+QsFOrjb4HrcSd8RcwlilVqnyo4yNbWToQ/2hJ
	 bJyMycQfpJ3Tw==
Date: Mon, 12 Feb 2024 16:37:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <netdev@vger.kernel.org>, Ivan Vecera <ivecera@redhat.com>, Simon Horman
 <horms@kernel.org>, "Rafal Romanowski" <rafal.romanowski@intel.com>
Subject: Re: [PATCH net] i40e: Do not allow untrusted VF to remove
 administratively set MAC
Message-ID: <20240212163717.14dc15f5@kernel.org>
In-Reply-To: <18049617-7098-fee3-5457-7af2e267b0d0@intel.com>
References: <20240208180335.1844996-1-anthony.l.nguyen@intel.com>
	<18049617-7098-fee3-5457-7af2e267b0d0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 10:11:44 -0800 Tony Nguyen wrote:
> > Currently when PF administratively sets VF's MAC address and the VF
> > is put down (VF tries to delete all MACs) then the MAC is removed
> > from MAC filters and primary VF MAC is zeroed.
> > 
> > Do not allow untrusted VF to remove primary MAC when it was set
> > administratively by PF.  
> 
> This is currently marked as "Not Applicable" [1]. Are there changes to 
> be done or, perhaps, it got mismarked? If the latter, I do have an i40e 
> pull request to send so I could also bundle this with that if it's more 
> convenient.

I'm guessing mismarked.

