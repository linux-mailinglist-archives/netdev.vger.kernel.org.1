Return-Path: <netdev+bounces-251491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBEBDiWib2l7DgAAu9opvQ
	(envelope-from <netdev+bounces-251491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:41:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9658446669
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C0648C6DB4
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5973B42EEDD;
	Tue, 20 Jan 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="acaqB8Dd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA842E009;
	Tue, 20 Jan 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916595; cv=none; b=du1rfSrzeK2Yyfnlb1o1v3myR68sFS7MKxprgWq3EeeRjzVQiu6VpYccCmrHfOygfQXo8paHlmfh99KBdGu0jL5QjoJd4y++eSzjSJrrPeBtlorPbCQTABBrBfiR9nj12287RQwNmUFyw4BVh1V5sXu0DUB6Nl1azF4/ZpunQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916595; c=relaxed/simple;
	bh=ma+rzHGsDCExYYGMmhhmllzYCP5f5IspIHOtaqUld24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5KvqZ7HnLVkrz1Y5cxSW0duR+gCetdvaTPRke0OptMCklZ2+VelylauSKukvls1KCqlDfZDpE/IZR3PUe8Y2laORym4DqI0lIimrxzZJLXeDY4QTj+LpCQra4K2hEvpUCJ4sVZ+Mok+l8/85S/DuC6N366LiO3D0UzGFQ4gRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=acaqB8Dd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=heuQ1Tbmi8A/rtNvMDuDrfbmSG1bgNIXq1tHuJAGZt4=; b=acaqB8Dd7K4ewFfzDhla1CfkRN
	+Tlp+Dk9kYrkVLnFW3d8MQ/kAdrwUbXdGbwASsXTOZbC/21HoFvQp2m+OzZfAs8UAxXEjsO1Wv5gO
	9Rhjt+Z5Vo1blGocTs4EbYM4u3vKPpQ/73CFA/Qyxhx84NSYFFqCqueF54o7Ytx0LT0I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viC0K-003gOw-Qu; Tue, 20 Jan 2026 14:42:44 +0100
Date: Tue, 20 Jan 2026 14:42:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: spacemit: Clarify stat timeout comments
 and messages
Message-ID: <0f74cccd-4198-4a8a-92bb-4d4e6ae63e8d@lunn.ch>
References: <20260120-k1-ethernet-clarify-stat-timeout-v1-1-108cf928d1b3@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-k1-ethernet-clarify-stat-timeout-v1-1-108cf928d1b3@iscas.ac.cn>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251491-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 9658446669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:19:23PM +0800, Vivian Wang wrote:
> Someone did run into this timeout in the wild [1], and it turns out to
> be related to the PHY reference clock stopping.
> 
> Improve the comments and error message prints around this to reflect the
> better understanding of how this could happen. This patch doesn't fix
> the problem, but should direct anyone running into it in the future to
> know it is probably a PHY problem, and have a better idea what to do.
> 
> Link: https://lore.kernel.org/r/20260119141620.1318102-1-amadeus@jmu.edu.cn/ # [1]
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

It is not clear cut, but i think this could be useful in stable. It is
not actually fixing a problem which bothers people, which is the
criteria for stable, but it is pointing people towards the solution to
a problem which will bother people. And since it is mostly comments,
it is safe.

Please add a Fixes tag for when the driver was added, and base it on
net.

    Andrew

---
pw-bot: cr

