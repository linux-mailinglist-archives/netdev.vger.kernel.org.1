Return-Path: <netdev+bounces-179324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBBA7BFE1
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECD63BCA58
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30F71F4C88;
	Fri,  4 Apr 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/BBQ8Bo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93961F473A;
	Fri,  4 Apr 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778067; cv=none; b=RV9JuVEZkNH/JmTqe9yvkduHmmmdqHMEEfL6wAA+XGg3B/wY7AZTy9/lPqCGZP00EApF28IEqI+7UfEqhVM7F3FwAh6BLiCLRbvTBAX0KN+8cLTt8JDQTh1kfvktLwxs7ruAGqGkHOPCZ9smXnvC0rlQPfM/eGMRIcKbfE5M8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778067; c=relaxed/simple;
	bh=l4k1iteG8JCPhz04i5zPS9YvtcYiSrcjCLRzfCQcnBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bp9JxK+k2eHT7fIdtdFoFeRHXxi5aFENacRzJCftQhX1KJbssz9RlGKyqr+0JGzZCFqqqOaepIYJvd1od6gJrV6NIvg8KKAPkFivtbRTllbjkEm8tOsqL2Aok5tGzAW1kZmrzSEgMNKxqgOlj2/5RjvSH62LvUmoYDxGN4/WEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/BBQ8Bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCA9C4CEDD;
	Fri,  4 Apr 2025 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743778066;
	bh=l4k1iteG8JCPhz04i5zPS9YvtcYiSrcjCLRzfCQcnBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C/BBQ8BoxTabTFn28TziXfq3ZhXIjsZmQvAgGt8ZN4N6623IPC+gGDBU1AY7Y2WqU
	 AJEf2udN4QsbRy1lz4uWL+0iHcIxXfNOeHnzIVtHhnoOaHYr8vkTp6h8ZsHfymfgIQ
	 W0Ypr23BLKFG3Knj878XKHIvZLxjPwdRIPqATuKbxBs7PyVof7I2NEjL6FxjAw+063
	 zfHdmtA0KpeiodrsoURXigD/GXBDeY6vKFLx9b8eFBdMHVJJyOzlhsec8SKZejNwlR
	 JtjwwhDSZfM4ESjZX60Yc/n7KxeM5Vl5LPQ/uEFkTeVmsOCAa0NNp3RKvsTIWydOzS
	 S6IbWLL8mw0aA==
Date: Fri, 4 Apr 2025 07:47:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>, Michal
 Kubecek <mkubecek@suse.cz>, Florian Fainelli <f.fainelli@gmail.com>, Kory
 Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net] net: ethtool: Don't call .cleanup_data when
 prepare_data fails
Message-ID: <20250404074744.6689fa8b@kernel.org>
In-Reply-To: <20250403132448.405266-1-maxime.chevallier@bootlin.com>
References: <20250403132448.405266-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Apr 2025 15:24:46 +0200 Maxime Chevallier wrote:
> There's a consistent pattern where the .cleanup_data() callback is
> called when .prepare_data() fails, when it should really be called to
> clean after a successfull .prepare_data() as per the documentation.
> 
> Rewrite the error-handling paths to make sure we don't cleanup
> un-prepared data.

Code looks good. I have a question about the oldest instance of 
the problem tho. The callbacks Michal added seem to be "idempotent".
As you say the code doesn't implement the documented model, but
I think until eeprom (?) was added the prepare callbacks could
have only failed on memory allocation, and all the cleanup did
was kfree(). So since kfree(NULL) is fine - nothing would have
crashed..

Could you repost with the Fixes tag and an explanation of where
the first instance of this causing a potential real crash was added?
-- 
pw-bot: cr

