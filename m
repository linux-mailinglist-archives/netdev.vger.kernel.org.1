Return-Path: <netdev+bounces-270157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FdGwIpUIvmn7FgMAu9opvQ
	(envelope-from <netdev+bounces-270157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:55:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C232E2FDB
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1591D30338AB
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED412DF13B;
	Sat, 21 Mar 2026 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0H1LCoE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD092DC32E;
	Sat, 21 Mar 2026 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774061715; cv=none; b=MNFy2n8dtqbnTZ+PCIv480YSfi0Lyzl1K9F+Gdq1NW6ztsSK1x0c1h0LnnVITAQ7VWjLyWSYo+fHH+/iLJn/Jh0ob5ayNGYeq57VS6xBq/HfCTmHYNwUM5/qLMvpYoUc0TEtSgZpYPsqneNBeY8SWuHC4FQU9qfHI3Gi0erSIMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774061715; c=relaxed/simple;
	bh=aGaGL+OTIB7kMniwi9yQlVf3Ybhwd6MfnVLz/caloq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGQueymW446VJOv4+dmDtSK4JDHvJ4z9X7c7T8d09fjq0YQ0+oFF5DArfJvyz9qxKPkzsvipltoOug//fee1HCZyAjyzijFBEvN48dE3xX7PxcnS9ZWsc6zo9vjatueKa6V9/m0Hp0/Z545KsYjrBqLe7x7PD7wSVmFt5vYuJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0H1LCoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E719C4CEF7;
	Sat, 21 Mar 2026 02:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774061714;
	bh=aGaGL+OTIB7kMniwi9yQlVf3Ybhwd6MfnVLz/caloq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F0H1LCoEjUfpOtqZBZ3EOvz7l7VbRgjusajuaK9h+IJQiiuMjutMOSxy3XyKTzzIi
	 NVxNtsh8PKuHYE6UXi5e57qKnlo0vRXev/9XRqFiyzN78A9uiYFBucwUAgh7I2GWiQ
	 JkX9eaVM/yXA2IqrC/DWDDiV/ImH9Zh+33huv9ZhfBMfncmwibXuGQ1QKs5XgImCtn
	 EDoT+P5F8o6cvCj1agc1D38yvSzpXdaHoVsqyFqt2mCA0OSaNhYPwvg+k81fZ3FyLO
	 rykD5G1RogJ3SsZdoA5hk/5ySNBkR5RQAuym/+y8FIA+S2OwQ//aNbfTU891yP7Dh/
	 Q43b9K57csg4w==
Date: Fri, 20 Mar 2026 19:55:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <Thomas.Lendacky@amd.com>,
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v2 net] amd-xgbe: synchronize KR training with device
 operations
Message-ID: <20260320195513.41396b3d@kernel.org>
In-Reply-To: <20260318091608.1266381-1-Raju.Rangoju@amd.com>
References: <20260318091608.1266381-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270157-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13C232E2FDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 14:46:08 +0530 Raju Rangoju wrote:
> During 10GBASE-KR link training, the PHY state machine can be corrupted
> if device stop or rate change operations are initiated while training is
> in progress. This manifests as:
> 
>   - Link stability issues after interface down/up cycles
>   - PHY state machine lockups requiring a full driver reset
>   - Intermittent link failures on Inphi re-driver configurations

Please take a look at this AI review, the locking race looks legit:

https://sashiko.dev/#/message/20260318091608.1266381-1-Raju.Rangoju%40amd.com
-- 
pw-bot: cr

