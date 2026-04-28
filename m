Return-Path: <netdev+bounces-282142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFkMO+NB8WlsfQEAu9opvQ
	(envelope-from <netdev+bounces-282142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BB948CFB8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A91B3032597
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D645389DE0;
	Tue, 28 Apr 2026 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxGuT5jo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03933ADAE;
	Tue, 28 Apr 2026 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418680; cv=none; b=eCXw5R5GdR2MdYXU5b/LZOlLO3ykfn0RUiZrDXvh+TV/GCa4XlMtJV43FOQIGClIri64JrMiYsOUmMoxJBZcNQU++CnvOAlUdRPRhyJXdYPVkAZv49O6xPruzyvyKB9mBnNKMd3AyhsD8t2Dpnpvt16kuZ8e6ylZpb3NhWeaN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418680; c=relaxed/simple;
	bh=5Xrt7KILIwa+UGYbws9Qz6dlqQ+86xVFwddyb05WyLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTxbP+suiLiD3E05qsOvIdPjN83sPAGDvTkEwqA22hlhMhTZZdFzEG09dfFWB9zg3y/BdYMpdlE3wzzm9CvyvkaUA5fgHTNpYV04r094aDqaWNuI3jKD7s87pFlz0WHUFeXjJZMzglRMoJfTmY7rdxp7ZMmsSgh0x25BLIZL9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxGuT5jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B95C2BCAF;
	Tue, 28 Apr 2026 23:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777418680;
	bh=5Xrt7KILIwa+UGYbws9Qz6dlqQ+86xVFwddyb05WyLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxGuT5joBp58dAE0+NjIz/E2039dgeZPzrItrEhy8MGPTucajnEWEAPxlYvDwiolB
	 PPfYWaYW8xzD22Nbq/1xELZRbayheCI6lYh0XwLUFv3GpHTqm50K0acr73FhJr9xZU
	 rMRJzV6eY0RcRsy72x025FVgphcrN4eD4y+h4Thzw6JZbyoKi4B8PffAfD8VotqiQb
	 hKNF3ejqYhqm/kIRlgRrxddbBx14dfj9fg2sRknspMM6wgWgCbjZkSJedx6fJ5QVc2
	 mjd6WexSZ2KTZ7zJA0A3hNViMBJx4Duv0vNUYmFBAtZIje7Sc+saOeMrKBrL9eC12t
	 GeAEt2gbozpyA==
Date: Tue, 28 Apr 2026 16:24:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Morduan Zang <zhangdandan@uniontech.com>, Petko Manolov
 <petkan@nucleusys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v2] net: usb: rtl8150: free skb on usb_submit_urb()
 failure in xmit
Message-ID: <20260428162438.07633ec9@kernel.org>
In-Reply-To: <f52c81bd-aae3-4d23-ae55-a0b3dd075f4d@redhat.com>
References: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
	<E7D3E1C013C5A859+20260424015517.9574-1-zhangdandan@uniontech.com>
	<f52c81bd-aae3-4d23-ae55-a0b3dd075f4d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A2BB948CFB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282142-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,uniontech.com:email]

On Tue, 28 Apr 2026 13:32:13 +0200 Paolo Abeni wrote:
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>  
> 
> Applied (by Jakub, AFAICS the bot did not send out the notification for
> some reason), thanks!

my bad, yes, the patch was conflicting with another one, I had to tweak.
Morduan, please use patch series if you need to submit patches which
overlap in context.

