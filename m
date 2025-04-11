Return-Path: <netdev+bounces-181758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0860CA865D7
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A53E1BA56BF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288861F03EF;
	Fri, 11 Apr 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvaccVrK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3057191F79;
	Fri, 11 Apr 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398030; cv=none; b=MCDzvKOOYXDf99DiJ6Z4+NjMrNO4Ud0KGKiF4qD/d0akAnGuES42cF0I+bEczOzBwkM/RSWSZQIMgy2+JfFrZaJs7bT8JKpvqdcw9htFVCVlQivSHZWXMS4cwy0RRmoJHPqYS26RkvFEpqc/mJc093AUPlCVhG2iZXgmdCG80Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398030; c=relaxed/simple;
	bh=LvxuDvYHHp3PaOGm7Xh4UckcuXqEIo9CXx4W9sDTTtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se0PMD5hK4/cX5qY0N76Fi0mG3AIH9dL+rCoqvO9o2XSYRmyaqzI7oauM3QpXAvoS1tiENl753qNGodLPVqONboNxX541Qa2lxGXE9CWB3+5UEBVCraYkqv3DGOb4NVYkWpfCPMqSDiM3TpNgkiwqlA8AgZWQPjlLljSqsZuaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvaccVrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D75DC4CEE8;
	Fri, 11 Apr 2025 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744398029;
	bh=LvxuDvYHHp3PaOGm7Xh4UckcuXqEIo9CXx4W9sDTTtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvaccVrKESEpqvY29TNPTNV6Ri+rlNJG+h2Pl7G4s12e5YfxNjH1MT1OZsBZlaGtO
	 qww/jLO9L3kiTDfO5zsAvuBd6HoBqpcovhp6LaMl1+DR8cPDlJRYBX7ufaQ7/xvuyK
	 KPYleAXE32l6JEKcN9x1bujAumMawBMPE5OWv2uxbxMGhV8FnNYx8Hb2SgwuBlvrtM
	 /v8v4KK+WjYSDu/v+yyrvIqOnjg+vLInwQOEfvpjfMYCYaAkwzBPwAAc5w4+TKmHhG
	 ElAwhZvJT65fHcCvgPD/lvXwniSKVVsIQKj84IN/NaneJc79i5dmrT649CRX55FvQl
	 8Cm5erpV9rLZQ==
Date: Fri, 11 Apr 2025 20:00:25 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 3/5] pds_core: handle unsupported
 PDS_CORE_CMD_FW_CONTROL result
Message-ID: <20250411190025.GQ395307@horms.kernel.org>
References: <20250411003209.44053-1-shannon.nelson@amd.com>
 <20250411003209.44053-4-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411003209.44053-4-shannon.nelson@amd.com>

On Thu, Apr 10, 2025 at 05:32:07PM -0700, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> If the FW doesn't support the PDS_CORE_CMD_FW_CONTROL command
> the driver might at the least print garbage and at the worst
> crash when the user runs the "devlink dev info" devlink command.
> 
> This happens because the stack variable fw_list is not 0
> initialized which results in fw_list.num_fw_slots being a
> garbage value from the stack.  Then the driver tries to access
> fw_list.fw_names[i] with i >= ARRAY_SIZE and runs off the end
> of the array.
> 
> Fix this by initializing the fw_list and by not failing
> completely if the devcmd fails because other useful information
> is printed via devlink dev info even if the devcmd fails.
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


