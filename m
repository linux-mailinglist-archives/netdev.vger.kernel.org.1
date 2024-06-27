Return-Path: <netdev+bounces-107493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76BE91B2F2
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EAE1F22483
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF67413C660;
	Thu, 27 Jun 2024 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIFV4qYb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795C47F6F
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532218; cv=none; b=EL0lh7chM/PN7HB14fY0HwoRWZbSvlS4EL8n7/sa0i9NEEjgx+M45n/z54oI4KyrMNytydbbJYr5E2Y3jWLtzyzRloefxh7VA9o0k+fB2MTc3viICypP1hWhmLlPlGE/x1ODgJKfl0NyjVJbKZlbFe9jS2Rpz2UpbHzmsv576QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532218; c=relaxed/simple;
	bh=x/JXkj5CbMutlo29hjVqQZKBsJhrYV7/W40c7JLhzEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvbmhaDop+OXIjUgZvY0fdQTzusk15Oh7Jt395e4L0QCA4i41xW6DBizbMAKEcS3wbltT1aFhFKDpGiHNLwPJnlygzk4eLphZIvjfQobFRh8O2EACrnru6mX3x+kZepNxQM90j/y43MYeDRx1FsGziVq7mNRN75cpOaVhpEZghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIFV4qYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F9C2BBFC;
	Thu, 27 Jun 2024 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719532218;
	bh=x/JXkj5CbMutlo29hjVqQZKBsJhrYV7/W40c7JLhzEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gIFV4qYbh67zDLsSp+o7aeYAdoE1tFNm06R4JqgNmicVOe2mf89VxmwSO8hr1fliR
	 rcC3N91RNAyNrHfW9qtqe05BjpOo/vriERHyfplVJ51EWNrN0QI7wDmAe7JCMi4oBi
	 bIYWn6XPGdWMl7Ltl/t4WJQiF+t7CihVlw86+yoIR18BBUjCRr5kv1vVrcMaCkr3pM
	 uqDbmUUpeeU2Raa753FmhPH/e8jTc9vs7JPgl/8xVEVPiLYxA4CznRBrCvlAAW5tKz
	 OvG+Gptd8nfkdu/LrjggY5mA/y6hKVe2jCiIqkDgmOvK7C/vujifprG9BWJyu4k1xB
	 bL7Y1xwYU/0Yw==
Date: Thu, 27 Jun 2024 16:50:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Michael Chan <michael.chan@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 0/2] page_pool: bnxt_en: unlink old page
 pool in queue api using helper
Message-ID: <20240627165016.2b00dbf0@kernel.org>
In-Reply-To: <20240627030200.3647145-1-dw@davidwei.uk>
References: <20240627030200.3647145-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 20:01:58 -0700 David Wei wrote:
> In my initial patches I unlinked a page pool from a NAPI instance
> directly. Instead, export page_pool_disable_direct_recycling() and call
> that instead to avoid having a driver touch a core struct.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

