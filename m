Return-Path: <netdev+bounces-256926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0VJrNFQDhGmHwwMAu9opvQ
	(envelope-from <netdev+bounces-256926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:41:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1534EE06F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F44A3003BFD
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8A2BEC34;
	Thu,  5 Feb 2026 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAY21sPE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903021F5834;
	Thu,  5 Feb 2026 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259278; cv=none; b=NACnkwCZ/U/XXWtJFp6QV3i3nciVYhK5uIXRxM4X6YAE8ADLkZKYePwo3MPwDWfbqfWU5kE9vw1y+2JIpFI9BNWEjE/mUCwSzBa2SocI3dBrPF2C4AfCvj8OFP9xbDpmILFXXDIPsj/F6oUQExsUsgipDX52p69IJXEhihJwjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259278; c=relaxed/simple;
	bh=IfPF/Ecwpu4CLWUVg28CS2dpUkT27gNfMmd+9r9Gr+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7RhtpZ6+wQoBlPn6mMIjkoJaS1CxIpkQ58uxCe93RIpL/8ky13VeX7Pa2oWTeFpk/htos8oogopwnw2ldDt3VhGV6XDot27D4e6qnNfQLgr2DmvvBxuYdJvvj1mK8vv5ZGfJRSyBouVcXmH1eqTaalvEPzMj3LmL3zUhaQs1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAY21sPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E6EC4CEF7;
	Thu,  5 Feb 2026 02:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770259278;
	bh=IfPF/Ecwpu4CLWUVg28CS2dpUkT27gNfMmd+9r9Gr+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAY21sPEwQpyWxNm5022Q4jfRhYPLMKUgov12iqGyQ6v+Wy9DYbIIhZ34VEC2raM6
	 rLaHq1/AY0APjp2DsYEDccdwCz8HwjzEI0ibQ+08dVW4gKkNvUT24i2zgfnVO5teH0
	 nrwXJkhC82je9CzIzZN3h+p+Ax82WM1NlG1oKaBGhzbeqCHqnw4PNu/IKam6kP6lQN
	 m0T/JKQJ0O+cW3Jh9Lhg8MK+u4npAHM1CNBWC9W4AGhEfhWt5so3hy3Hkr44HODoto
	 QtXSRB3XgMklkw9q1E4zvnUorX1Y32rliYp1jgbjc7vEmC8U2HJQTN1TWDjF+fuJHk
	 1LZ5v/b/SjGCQ==
Date: Wed, 4 Feb 2026 18:41:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Simon Horman
 <horms@kernel.org>, HarshaVardhana S A <harshavardhana.sa@broadcom.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with
 gcc-16
Message-ID: <20260204184116.11ec0a8c@kernel.org>
In-Reply-To: <aYMqw2HbtKi50b1e@sgarzare-redhat>
References: <20260203163406.2636463-1-arnd@kernel.org>
	<aYMqw2HbtKi50b1e@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256926-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F1534EE06F
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 12:29:44 +0100 Stefano Garzarella wrote:
> Not sure if it's net or net-next material, maybe net to avoid the 
> warning/error on v6.19 too ?

I think net-next. I assume people who build with werror like pain, 
and we need to be inclusive.

