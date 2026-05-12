Return-Path: <netdev+bounces-287230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kILsBbVRA2qR4QEAu9opvQ
	(envelope-from <netdev+bounces-287230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:13:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 649115246F8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACF433001F8F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8731A3C8C49;
	Tue, 12 May 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMinE4vT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643643C819E;
	Tue, 12 May 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601881; cv=none; b=L9ocwoUslg0jjrmnbLc1aXhE3H8rinJhL4G7TAlE5hekB9r0XgjC8RqmdAnok+tL2HrROrubdhmFuaLNb3AzVLJ/iWAiSUaG0+Qb0JualxAYi6xNANovVhB4MmNOYFmsGLgaCTeoD+vJNryziVRzLwITSbg/7dH9xmAih3nzMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601881; c=relaxed/simple;
	bh=+gRijnzxRtu6tbAngyZTD2Te3JxUdAdL4stmmmU2bZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/Bs/T5PBSFOvaCnmkEPoxYLjfKGO3dOJ9IFLO9OJe7nB3ZY5mI/yczL28zFNOenRkqPyaJ5RkvnaepQv9xyN2Gk1huMeNZdMb08UJ2sXg+/zlC5VWbSNBPQA4tBFmhsSIe7YftsxsUZtHCefhWKY/Rf69c554LnGnFycvNe7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMinE4vT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763F5C2BCB0;
	Tue, 12 May 2026 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601881;
	bh=+gRijnzxRtu6tbAngyZTD2Te3JxUdAdL4stmmmU2bZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMinE4vTKT6goPysB8X3k9rnZYFx620q8gp7ZoPlkodpfp7zxJxluoquHOAuMVr80
	 ZNxyHhy/huQ8tQbY/Kkt0GWH9QD16WlyWat3aSNrAkzrmHibWKX57gGVDTtiIHL3Ka
	 DK2yonNZ26bGe3/2AZr+6fK11FI2ewUX6O6Jcx0cfAVw5uxKWXSjGMA2aXNR8/t0J0
	 h5HnGI6G0O2hakWGtD7ESJUnr9w5M36HM+7ZifMjcfxoiuFrWTO8j8kCsDnsCndkF/
	 l3gXT56+NF57fKT3zWGvKYzuRY9qLnfCrD82VkopyQu0mHXfxwhV47JuQJTPGV4/XW
	 09545f1WHGPiA==
Date: Tue, 12 May 2026 09:04:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sd@queasysnail.net, john.fastabend@gmail.com, bpf@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v2 3/4] net: tls: fix use-after-free in
 tls_sw_sendmsg_locked after bpf verdict
Message-ID: <20260512090439.6a91bb92@kernel.org>
In-Reply-To: <e683a7db-b465-4b34-b002-8f22031c77ce@linux.dev>
References: <20260511174920.433155-1-kuba@kernel.org>
	<20260511174920.433155-4-kuba@kernel.org>
	<e683a7db-b465-4b34-b002-8f22031c77ce@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 649115246F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,queasysnail.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287230-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, 12 May 2026 17:47:13 +0800 Jiayuan Chen wrote:
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Fixes: 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")  
> 
> Is the blamed commit correct? I don't think I touched the following code 
> in this commit.

Fair, will update.

