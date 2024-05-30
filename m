Return-Path: <netdev+bounces-99483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADAA8D5057
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C17D1F27225
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6033B1A1;
	Thu, 30 May 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCtxDrJo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3544369
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088291; cv=none; b=ZN4LQFced7XNMJDIDwp6PgTrIJ8GlyjtuYTauBH771AYZdHVIwh0EU/eWg7JWdirocjRZIE0VaNBvJBnKOURfV++ejF4gQbcycARYHHAeiKhoKBXj0YYCy3i7CUI7TNVf8cMsP3Z+l2AgMJJ2aVHplZZgENNL4EE+F3qWihwwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088291; c=relaxed/simple;
	bh=G0Z4iodjcdv/WPtOLI7LBrCXOtWr4nRCBP1FC8yTX9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7F6VVNnrVbl+b9sdzuFZS18Azs4VJL5Y0OmCqNrul+auyG0G2rKZ1ruMz7OPrTkaxSeiHySH9nGsX9L5BvQd7ReQ/94pSPEoW8flGWOWg/tfX6ByoQ//gpRIVdoP8gWinBMrdo5fj2SYiXEdRCerdJdkDACEsywER0VtKF0qOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCtxDrJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8647EC2BBFC;
	Thu, 30 May 2024 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717088290;
	bh=G0Z4iodjcdv/WPtOLI7LBrCXOtWr4nRCBP1FC8yTX9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OCtxDrJoseuGUeuX/2nRYGT9DAftf48Fzhgr83/eb275wQ8kXDXdjScNU4n7t9ng4
	 nmvNY9vgtW+Pxd0B4FpljkT9NAjQx1IGID6l/j/dV5uHV8c/guH3DYrYNlaSSFh/m7
	 cpPP5az1TqpQj8ERXZRdKIFLEPI64CuXMR6FIhKdc3b0eOhBhuLCxg1M3T+4nYJh/4
	 kkvuXyuj2UfpNtiQj5fQfxDbOezGBnLTMVT6bBJdokQP8WCoa+I+TT7BHXu7917e4M
	 zI2r8UvOIHYU/xVawnCNquFEJcank4fsLO+8/u//zp5fmYLVqvkjGD1MxOCAO8ng97
	 1jq/jTyXzBO0A==
Date: Thu, 30 May 2024 09:58:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <patchwork-bot+netdevbpf@kernel.org>, <davem@davemloft.net>,
 <netdev@vger.kernel.org>, <hui.wang@canonical.com>,
 <vitaly.lifshits@intel.com>, <naamax.meir@linux.intel.com>,
 <horms@kernel.org>, <pmenzel@molgen.mpg.de>, <anthony.l.nguyen@intel.com>,
 <rui.zhang@intel.com>, <thinhtr@linux.ibm.com>, <rob.thomas@ibm.com>,
 <himasekharx.reddy.pucha@intel.com>, <michal.kubiak@intel.com>,
 <wojciech.drewek@intel.com>, <george.kuruvinakunnel@intel.com>,
 <maciej.fijalkowski@intel.com>, <paul.greenwalt@intel.com>,
 <michal.swiatkowski@linux.intel.com>, <brett.creeley@amd.com>,
 <przemyslaw.kitszel@intel.com>, <david.m.ertman@intel.com>,
 <lukasz.czapnik@intel.com>
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2024-05-28
 (e1000e, i40e, ice)
Message-ID: <20240530095808.7d8c8923@kernel.org>
In-Reply-To: <caedbadd-1840-423c-9417-b9a2c17cf955@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
	<171703443223.3291.12445701745355637351.git-patchwork-notify@kernel.org>
	<caedbadd-1840-423c-9417-b9a2c17cf955@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 09:45:29 -0700 Jacob Keller wrote:
> >   - [net,7/8] ice: fix reads from NVM Shadow RAM on E830 and E825-C devices
> >     (no matching commit)  
> 
> I saw this one didn't get applied either, but don't see any comment on
> the list regarding if you have any objections or questions.

I wasn't 100% sure there's no dependency on 6, better safe than sorry?
:)

