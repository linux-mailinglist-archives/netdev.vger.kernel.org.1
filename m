Return-Path: <netdev+bounces-73837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C14185EC0C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FB6285C88
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6013EA8E;
	Wed, 21 Feb 2024 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulWEd/cL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E23CF68
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555998; cv=none; b=k7d+jEUZ6B+pkufaBuD4IQph+Cz7PxRWf8rPaedZSGCpVfPoFII2gfd8th0KouomG01PNaTBPt4Od43nebt3POVULRJRCykZScfngbVQWMwc5IaNr+Rf+TSiyZPUSRaTqmrRr0P8q6CVDx0tJo60wKwHHq06/13puaLhXT+tGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555998; c=relaxed/simple;
	bh=20rhpMF3UB9vbcYjfzF6lQkH66Sj20R/cjxZjp5w5U0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2J+OK5YpKk0EWCgOm83s29SABRYjkx1I7T8Ikl6eWOXCPzeEwGk6SfyjUpVilrteALB/sloMgTw2VtXSWPiTeQE2EcYUsoPrSh43abOqymuat28qhhQUxKQN+Hc1mVaix0hwqppOVI2lwuYf+aQWR4mf1tsQ4npmU983CfVue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulWEd/cL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF4FC433F1;
	Wed, 21 Feb 2024 22:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708555997;
	bh=20rhpMF3UB9vbcYjfzF6lQkH66Sj20R/cjxZjp5w5U0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ulWEd/cL6OBYxznI2DoRu0AZxUvKerm3xDG0mt14lMoZ+savQnHU2/sxeUhRbg4lA
	 ZDw9TmXXxN9kh7S84+4Lo/KYVhy3x5XRWahhBm2ycE2XM2TkBAORUCnyOBqhoqH6zW
	 mFSawpT3nJyBzD2Lzd0pnLlLRbImo/dKy/tz6JHHDoynvUyMLLlmL8pGjISb7DBHeC
	 8xYX3fJtFAku9cbKaHBWF9bj0+IhJ19M+NTLRSz4SbQ6flgTyDKB80kC1ykG5FIObK
	 TI9Iz7BdR3Nx5DHXKfjmJkiibepJR4abOckkpEETS/6RuiOb+oe5UwA9T/sLcgLlei
	 9p7UgCHe/CStA==
Date: Wed, 21 Feb 2024 14:53:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH net-next 0/5][pull request] i40e: Simplify VSI and VEB
 handling
Message-ID: <20240221145316.716e361a@kernel.org>
In-Reply-To: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
References: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 13:42:37 -0800 Tony Nguyen wrote:
> The series simplifies handling of VSIs and VEBs by introducing for-each
> iterating macros, 'find' helper functions. Also removes the VEB
> recursion because the VEBs cannot have sub-VEBs according datasheet and
> fixes the support for floating VEBs.
> 
> The series content:
> Patch 1 - Uses existing helper function for find FDIR VSI instead of loop
> Patch 2 - Adds and uses macros to iterate VSI and VEB arrays
> Patch 3 - Adds 2 helper functions to find VSIs and VEBs by their SEID
> Patch 4 - Fixes broken support for floating VEBs
> Patch 5 - Removes VEB recursion and simplifies VEB handling

FTR looks like DaveM already pulled this.

