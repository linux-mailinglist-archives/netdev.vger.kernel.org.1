Return-Path: <netdev+bounces-180387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A814DA812CC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6234E217C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21C22FF40;
	Tue,  8 Apr 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqhxmG0H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EBD22FAD4
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130941; cv=none; b=W67WK2sDddGDrCu24Ot1APQYdEguLARGAQIMaf/0F41sG1tfy28XwOBD5BTsxSg20tOyv1vrAn2Hi4EFiYILDxU4oJonJ1BluKkCvDxcC0OLkvAtJJ3bXZ+1IJ4ZIfr7ZZYaM+5JqFvPfaJzqc9+e57BPSJxA8IkQZf9v+S0kYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130941; c=relaxed/simple;
	bh=X7N2hbIsyPBF+25/X/M47qsPBaj+pnUoqE0FzGYRtjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJLulGVwVA2yt5mhi5rFbWLlOqcC6Hc28rEuN/4EM7dI3bYkeG1PNFffF0HsaLVyEA/2Lmf61mWcdwI/77tRhGf0c+c4YkM2oA90y+24uxs1No+7iH+pnTldxTwx/lw8gcCjKd00LQFgfd2rtSjKub6UZ6xVH1ftFIMicxPqE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqhxmG0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1900EC4CEE5;
	Tue,  8 Apr 2025 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130941;
	bh=X7N2hbIsyPBF+25/X/M47qsPBaj+pnUoqE0FzGYRtjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KqhxmG0HkFgh3TyEBq/XmGM980vKRJhxKEqjZ6WupSwIGo76sOTfthVPwu/X/5NL9
	 Yqr3SDkOLFLg5erd0MKNI31LXJ67zqMgjU8b9WY5LJ9JBh7H1zaMFNhPVdZJr5MK0/
	 7iNhsz6wphZjcbxHC4CaD5rhxVXDOnBkIuEGVHK9ddXT+jPtpeQYfIOWXB76JbQL6V
	 spM3LjmQT7CsiJvZRPHxifyC7GxOaVPZcJjg/VFjA+omwpQG4X7g0iLD2PJx9gTsKb
	 wy7RoEUTVsXHQVD18FkraAINMhaC6duy9vabhzddpO/BV4263D1q6pt7xd/xV2uBVH
	 +3WUFnyYwxE4Q==
Message-ID: <e8acfa25-0cc4-4976-97e5-1639dc049c59@kernel.org>
Date: Tue, 8 Apr 2025 10:49:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VRF Routing Rule Matching Issue: oif Rules Not Working After
 Commit 40867d74c374
Content-Language: en-US
To: hanhuihui <hanhuihui5@huawei.com>, idosch@idosch.org
Cc: kuba@kernel.org, netdev@vger.kernel.org
References: <Z_OMzrUFJawqfYe5@shredder>
 <20250408161756.422830-1-hanhuihui5@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250408161756.422830-1-hanhuihui5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 10:17 AM, hanhuihui wrote:
> Before the patch is installed, oif/iif rules can be configured for traffic from the VRF and traffic can be forwarded normally. 
> However, in this patch, traffic from the VRF resets fl->flowi_oif in l3mdev_update_flow. As a result, the 'rule->oifindex != fl->flowi_oif' 
> condition in fib_rule_match cannot be met, the oif rule cannot be matched. The patch also mentions "oif set to L3mdev directs lookup to its table; 
> reset to avoid oif match in fib_lookup" in the modification, which seems to be intentional. I'm rather confused about this. Does the modification 
> ignore the scenario where the oif/iif rule is configured on the VRF, or is the usage of the oif/iif rule no longer supported by the community after 
> the patch is installed, or is the usage of the oif/iif rule incorrectly used?
> Any reply would be greatly appreciated.
> 

oif/iif rules per VRF does not scale; the l3mdev rule was added to
address that problem.


