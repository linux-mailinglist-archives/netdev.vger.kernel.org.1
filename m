Return-Path: <netdev+bounces-39584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DDB7BFFAB
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C429281C14
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A324C6A;
	Tue, 10 Oct 2023 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+Uz0c0i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0E1428E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF52C433C7;
	Tue, 10 Oct 2023 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696949553;
	bh=SC7yJOl9NogjSVaJgP1tZVwr6AZqwZq0588QgBR4Kxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q+Uz0c0ijcyokgwWb6YRXw62dH5kgpM+LVwnDJ3/BpbfKoZGE7SymnD63273yLDS+
	 y8F6LKtiZPSnvTMoBkPO6qgtI9bKQ7OpKTE9KtCKzDO6peOhNiWl+mtAAxqrhHoz33
	 yJextLqBphN22oUQLN8dOFZjo0AP8qRFyfcF6d02okcSgJB4OT7HvXJ3uyMpQunlrU
	 vyrvFYSLQp+1apZvS10GB8Wh00WUOqhDzPhxHPiN56VETCYWDOyK8bv6BorJrf2VhR
	 ErhyDYQ4+ltU3TOCsV040f3Tgom9TBU6XBW5gNWrQaval/zef/HM58stCP+X1nG8DS
	 SEFlsghm/wOoA==
Date: Tue, 10 Oct 2023 07:52:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231010075231.322ced83@kernel.org>
In-Reply-To: <ZST9yFTeeTuYD3RV@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
	<20231005183029.32987349@kernel.org>
	<ZR+1mc/BEDjNQy9A@nanopsycho>
	<20231006074842.4908ead4@kernel.org>
	<ZSA+1qA6gNVOKP67@nanopsycho>
	<20231006151446.491b5965@kernel.org>
	<ZSEwO+1pLuV6F6K/@nanopsycho>
	<20231009081532.07e902d4@kernel.org>
	<ZSQeNxmoual7ewcl@nanopsycho>
	<20231009093129.377167bb@kernel.org>
	<ZST9yFTeeTuYD3RV@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 09:31:20 +0200 Jiri Pirko wrote:
>> In Linux the PF is what controls the SFs, right?
>> Privileges, configuration/admin, resource control.
>> How can the parent disappear and children still exist.  
> 
> It's not like the PF instance disappears, the devlink port related to
> the SF is removed. Whan user does it, driver asks FW to shutdown the SF.
> That invokes FW flow which eventually leads to event delivered back to
> driver that removes the SF instance itself.

You understand what I'm saying tho, right?

If we can depend on the parent not disappearing before the child,
and the hierarchy is a DAG - the locking is much easier, because
parent can lock the child.

If it's only nVidia that put the control in hands of FW we shouldn't
complicate the core for y'all.

