Return-Path: <netdev+bounces-252928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFYlBUDFc2kpygAAu9opvQ
	(envelope-from <netdev+bounces-252928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:00:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D279EAE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A99233002B51
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0E429D277;
	Fri, 23 Jan 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8S7pVi/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002B280A58
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194811; cv=none; b=ZzPYgybDQBAKDp0s4CXUsBcWaLwHYnCuzmrj6eYlYyjOaYp8ifLvYvyyN3k1DgSBd4SnU0HfQ5vgPcvSwH36YrU3/PKXcHAD1yXfl/Ci6oxY4ef7Ij04hzaq+J5jR5wX6i8aPP92uJcCiiL7HfEgmwyepEWii3L48+SzhdV7KIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194811; c=relaxed/simple;
	bh=6ZlSmw3+0Gi+KfWcFbEdYCu/eLYX0UoNj3aYLLzXFBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IyYktACr0jSv24AgorqpmeKYJAzRv1PTW0/0mEa/1gqC4MTldgTPpVZ4b84TyyweOPyBFkGnVe1D7aJ1GrLdryOwqYjpOpgAx0WRIAHmc02M38ESg+hW/MZ2a/F+Z2v9j5J8a507KtmKYSidBsW933CjUVS6Ff2/0kYkGBi38d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8S7pVi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8096CC4CEF1;
	Fri, 23 Jan 2026 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194810;
	bh=6ZlSmw3+0Gi+KfWcFbEdYCu/eLYX0UoNj3aYLLzXFBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q8S7pVi/JvTtYSUX5NzOe2a0OAhby/30eDGtsPKnizGZebWH19umxh+2BahCG7Ev/
	 hMHzc19BDC0d6hGdZyCVUr38wsjduDV24RihqjquJJRZYcrS6qtnx7qV0VQ1+82vm4
	 4UP1EiUcek7TN+1ysGeZ3hGCQIsuhddRhWmol3JZhPcGZKOgOCmC+6d4GL57UM7HWF
	 O1yLZtYMJu6d5LMdzPY/QMRIG7x455h/z1mZeiSJnfo35pxNOVVAuNn6dEFyxjh7tA
	 L3kUWYpMV3LIjpTUUsDyxGkzwDT9lOEPri3OOh6SIQuA5yj4k04bHfbj+xZ/xtkOkX
	 IgarlmB9OaVow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BD203808200;
	Fri, 23 Jan 2026 19:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bcmasp: fix early exit leak with fixed phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919480636.2680587.7223132808988495649.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 19:00:06 +0000
References: <20260122194001.1098859-1-justin.chen@broadcom.com>
In-Reply-To: <20260122194001.1098859-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252928-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 2A3D279EAE
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 11:40:01 -0800 you wrote:
> We are not deregistering the fixed phy link when hitting the early
> exit condition. Add the correct early exit sequence.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - net: bcmasp: fix early exit leak with fixed phy
    https://git.kernel.org/netdev/net/c/6de4436bf369

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



