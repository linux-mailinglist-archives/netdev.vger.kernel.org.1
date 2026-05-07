Return-Path: <netdev+bounces-285354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKATJOmi/Gn2SAAAu9opvQ
	(envelope-from <netdev+bounces-285354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:34:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F24EA43C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78DE03003BF6
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375313EDAAD;
	Thu,  7 May 2026 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfGuA2iW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CC2C0282;
	Thu,  7 May 2026 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164196; cv=none; b=Xy+/e9cTFlVgy4dO8iTKU8iA61xdYR3v4UhgWUrOusjFA4tvI93o3IQ7O5SJV428i9LwuqqXPC/ZewcSJmU3CJNXVOw+ViT5AMjhkYoLYOqq5e1nti4r9jYeHiNb6DBlUrmOAQgkzwZt+br8q4CipTbLQu51Id6t6rCeXVglquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164196; c=relaxed/simple;
	bh=LB4dE/vBK6x4eXcHtskLCec2C56PHR6Al6HWMU4idtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/nItsyuTIiG8F4flTuOHBrJ/y+BgY3SghGXUeZwo8CRWqf3Qtocs4N8nU5LWuLQGc8rV+5PbhT581W1mRnKm2lsK4zxl55cR81NttLTuNnX6QY/2juz1PjrW1DGF+81nu8MmyKpSc8XMT5fGQpcRnb8HSlA3kRaCJ7SNkL905c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfGuA2iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC19C2BCB8;
	Thu,  7 May 2026 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164195;
	bh=LB4dE/vBK6x4eXcHtskLCec2C56PHR6Al6HWMU4idtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZfGuA2iWhPDRvEfHG2TLSGF1eYmcSxTX58MEl0VbdsEJa9d6iaOa6DD5rOmAlyC2s
	 F2du1+FzOSXb3nS+vHg9KvLY+nRYU5w8iBoT82umCC8Bkd/XalKqoOgrf2aUcKFjcR
	 y6Kpfh1yBAc24hSHp2hGnhN80knZ5HkxyEwGso80loKjxLkzA1bvxVdd9lWD5C57jl
	 rldMsGmdoBl6758roawDD+eDZymzAeOtfUzZWIQucMmeB/39f+vMkTnuNvqAqv0KHW
	 DvJCMlo3HXZ06dRkppKLEGEycH/ctTM19UIdtoAi0+tZa2R30jXr0b8XmXDY5mfkGe
	 fqcZy3kJQnpjA==
Date: Thu, 7 May 2026 07:29:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Alexander Duyck
 <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net v2] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <20260507072954.263ae8dd@kernel.org>
In-Reply-To: <20260507072453.5eec7051@kernel.org>
References: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
	<6cec0c03-5bdc-4131-9899-bc5c77fba198@redhat.com>
	<20260507072453.5eec7051@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 858F24EA43C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,meta.com,lunn.ch,davemloft.net,google.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285354-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email,sashiko.dev:url]
X-Rspamd-Action: no action

On Thu, 7 May 2026 07:24:53 -0700 Jakub Kicinski wrote:
> On Thu, 7 May 2026 12:34:24 +0200 Paolo Abeni wrote:
> > > Clearing fbd->netdev to NULL avoids UAF in init_failure_mode where
> > > callers guard by checking !fbd->netdev, such as fbnic_mdio_read_pmd().
> > > These callers remain active even after a failed probe, so fdb->netdev
> > > still needs to be cleared.
> > > 
> > > Fixes: d0fe7104c795 ("fbnic: Replace use of internal PCS w/ Designware XPCS")
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>    
> > 
> > Note that sashiko-gemini spotted a pre-existing issue:
> > 
> > https://sashiko.dev/#/patchset/20260504-fbnic-pcs-fix-v2-1-de45192821d9%40meta.com
> > 
> > does not block this patch but could deserve a follow-up.  
> 
> fbd is a devlink priv, not netdev priv, touching it after free_netdev()
> is perfectly fine. I wish Gemini tried a *little* harder instead of
> guessing :| Sorry for not commenting earlier.

Ugh, not enough coffee. It's complaining about MDIO reads, I think
that's valid.

