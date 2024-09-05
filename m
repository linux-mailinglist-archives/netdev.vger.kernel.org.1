Return-Path: <netdev+bounces-125343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA996CC6B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B0C1F25335
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A74E8BFF;
	Thu,  5 Sep 2024 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFvMl4kd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686211185
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501368; cv=none; b=fHr8lgciIeZxPERZkHr0y35VdpDIAnU6NL5i6KW8I8eSzObWmHleOgnCMFkJYD0U8F67OSRm/axjcx99v4bRJOM6BW6phCMon0yTXhIGLxVWnC1EEx6KQ/u/YISUv07t3n/KqdvPgTu/f4EXoJ90+51gXpCzy9jucKfdofc+y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501368; c=relaxed/simple;
	bh=ER/YQRenfgFAaIh9sSTZF2sy46HPM/+nUbIjFGXd7kA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IT2sm3sau+sOKKwkOOMvyvgti4ws/SmYKP++03H5u0X0LrQyC/RRyFFFDQw8j1TzpEjZVUMXkHf10MKIBzVTg5EiivLn9OMTnHjzY13L1xGCrtz183FFO/mHvWv9VThkc5N8nCmMEYOnRjp8JmIAyVuQdLCpg83cor6Ii7xlGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFvMl4kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA3FC4CEC2;
	Thu,  5 Sep 2024 01:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725501367;
	bh=ER/YQRenfgFAaIh9sSTZF2sy46HPM/+nUbIjFGXd7kA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qFvMl4kd53tHu5iZPHxZB9LAADztpL/NyZPPpRKE2EDAJ6kE/i1TNhAbHoYeSYCvQ
	 uF0a28+LEgRTOH4LRE2ke3yBcYL00dvHbamZ3i9N788K1onKMP9cwPRizDWPhM1mVn
	 hykWggKdjg9lGDCziSyLAG/MHckczx81rah8d2l9lzEJg19JSXMtF9rLhFB7QLqGYJ
	 poMk99Njyi2pYvAGWmZQP5biW8sm/V2XmjKX7Cnn1mP8aL5x1ttOvA4XMu7AX65CNo
	 xTg6vMV5OhdURkHq7YSswja6ZlZIpgj1VREf9o3LXxwwVQ6fnizXrqWBkAxFpDdu5R
	 93Ew5fUtCPwrg==
Date: Wed, 4 Sep 2024 18:56:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 10/15] net-shapers: implement cap validation
 in the core
Message-ID: <20240904185606.366ef437@kernel.org>
In-Reply-To: <70576ddc8b7323192c452ee1c66e7a228f7d8b68.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<70576ddc8b7323192c452ee1c66e7a228f7d8b68.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 15:53:42 +0200 Paolo Abeni wrote:
> Use the device capabilities to reject invalid attribute values before
> pushing them to the H/W.
> 
> Note that validating the metric explicitly avoids NL_SET_BAD_ATTR()
> usage, to provide unambiguous error messages to the user.
> 
> Validating the nesting requires the knowledge of the new parent for
> the given shaper; as such is a chicken-egg problem: to validate the
> leaf nesting we need to know the node scope, to validate the node
> nesting we need to know the leafs parent scope.
> 
> To break the circular dependency, place the leafs nesting validation
> after the parsing.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

