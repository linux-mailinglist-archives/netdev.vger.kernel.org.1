Return-Path: <netdev+bounces-114776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84B9440A1
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4FC1F21B19
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5114AD32;
	Thu,  1 Aug 2024 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWBADccg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DF14A624
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475438; cv=none; b=aRay2M2jzFRzn0kLcTvwya+tbIWWkcplJHocpy8/wcnGW44vXxJBPTWuz2+tkTn1shQZFaV9Kyv5dAEgbrDAQ1EmBWUCUAZOw1FD0oU3jXGD1nqd7fWbooE4otqT3+GnvRl7xKWy9pVJ9SSSNRFAjpH29AWxMfPuCvammZn7hsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475438; c=relaxed/simple;
	bh=h9jrO6Vy6p24ESKMgr35/NorH8sY/HdciGL6m7r5n8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o481XE0Hd7gAXKl2Vj2CtRLZkytabUBir34mbmfVCXbJt2cThDqGvVadG+15AY3B79EJajEy6Jjl7NsbxLnPoSK6vr0NI0Sv+qjqGQzX5hAAvrnNY/vThDxKNGmbxnZ6AoqMg4Y1nCtUIg6gRD5uS4qIbSGv0dK6VutC+Swv7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWBADccg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C439C32786;
	Thu,  1 Aug 2024 01:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722475437;
	bh=h9jrO6Vy6p24ESKMgr35/NorH8sY/HdciGL6m7r5n8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EWBADccgX/ZbTzpcJ/r4i5NLRMpLFPvY9a36YdTyttjl7jzkK4ezKvB1OwtJgiWSx
	 1bmGBCeb8z0FkruWUNLh+BtFqgsbOY3aB2BYvhKWWcfVA4az3iVIEacXZ2CL0ztmZQ
	 NVoRkE0Z9HRY7tuIERVxT0L7JxnzXhzwFjWKvxo1jDD0VGv24oy8yYYYy9IRXCuK9e
	 sjqAaLGjwkY2rflmG5UQHgBSm2/T6pO+tKds3hjd/j4+4P+CRAG0Ul0rx5Z+eRj9db
	 UnAQIxx4t3s/EAXf+U4w9X/tDvwlbCkoztgaPyK4yfho53gGnqzqCmDVJHdOJ6assX
	 xa0A3ywAhjShQ==
Date: Wed, 31 Jul 2024 18:23:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jon Maloy
 <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Per Liden
 <per.liden@nospam.ericsson.com>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next] tipic: guard against buffer overrun in
 bearer_name_validate()
Message-ID: <20240731182356.01a4c2b8@kernel.org>
In-Reply-To: <20240731-tipic-overrun-v1-1-32ce5098c3e9@kernel.org>
References: <20240731-tipic-overrun-v1-1-32ce5098c3e9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 09:11:50 +0100 Simon Horman wrote:
> Subject: [PATCH net-next] tipic: guard against buffer overrun in  bearer_name_validate()

double space and one too many 'i's in the subject

Code looks right:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
-- 
pw-bot: cr

