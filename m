Return-Path: <netdev+bounces-272343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP+INnH1xWkjEwUAu9opvQ
	(envelope-from <netdev+bounces-272343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:11:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03833EB0E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03BA9302A695
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B0356A37;
	Fri, 27 Mar 2026 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7umSLLH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F243559F8
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580767; cv=none; b=kJABcGnIjaX2FWSlDuKUXcTClEbvEXul4HJzXtYDehE2blhQCB9pIL0gCukxs0C3lL5PtDWGDDcaxGFey5SmWFmEUbuiKdkIUWI6dvFaiHKCCqaHcdm3fiEht6+pXOzQ75wnTsyJfUC3yrBhSRnHXkbo+e9Ff8XQq7gSZtcjiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580767; c=relaxed/simple;
	bh=GSPHdHyg+uH9B41/pLMTI1+glPJGMLW1zAyv4w3Z/U0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/niNWYGJK3MhFc0MYDRKIVT6fH88rnjr/5YQver8PVpaFcWJelg/8BhD6P9fYsw7zra2qcB/3VccnraTPTDpfPKc2+YLKP2/sc3d/DHkQS7D2aPORObJeOxkJwfOh1LoCxwnPcsRFJVBMpq7dC8xN5iOOiLEq4bDXvGL6M4DDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7umSLLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8165C116C6;
	Fri, 27 Mar 2026 03:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774580767;
	bh=GSPHdHyg+uH9B41/pLMTI1+glPJGMLW1zAyv4w3Z/U0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i7umSLLH7F7pSYDbl4NzXHQ0/+ryzvhUGshvZhEfrM99aWA9u3sA9d4wdqIVFSM7n
	 1r0versrA4SxwpmwSIvQu6GFPgRSW1s3qR1Yja//u/HolhHcA114r9vbzeL0agNdYC
	 1M/qlqZln64ybSpKJCPEGJcV+TkhOX3PalmnFChaGm32cff6v96BtAi8rnld987iHt
	 9K172xEzUVi6FrdqckncHtXDfDb4vh5M6/3fGpnoXLVo+z+Ct3WwYKbls4BSYZjpoR
	 1v0Lp77mlev+cA7uCm9RomtNklZrjNhwh2a7MbBSEtQGTYZtJ4bv1oMmy9unj44mjN
	 UVLdXPrCKJD9Q==
Date: Thu, 26 Mar 2026 20:06:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Grab flow_offload_mutex running
 airoha_register_gdm_devices()
Message-ID: <20260326200605.39222917@kernel.org>
In-Reply-To: <20260324-airoha-regiser-race-fix-v1-1-6014df55886b@kernel.org>
References: <20260324-airoha-regiser-race-fix-v1-1-6014df55886b@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272343-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C03833EB0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 17:54:45 +0100 Lorenzo Bianconi wrote:
> Netfilter flowtable can theoretically try offload flower rules as soon
> as a net-device is registered while not all the other ones are
> registered/initialized, triggering a possible NULL pointer dereferencing
> of qdma pointer in airoha_ppe_set_cpu_port routine. In order to avoid any
> possible race, grab the flow_offload_mutex running
> airoha_register_gdm_devices().

Sashiko says this causes a lock ordering issue:
https://sashiko.dev/#/patchset/20260324-airoha-regiser-race-fix-v1-1-6014df55886b@kernel.org

