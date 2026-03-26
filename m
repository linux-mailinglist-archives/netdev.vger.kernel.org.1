Return-Path: <netdev+bounces-271930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG6lCxXvxGnv5AQAu9opvQ
	(envelope-from <netdev+bounces-271930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:32:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF2B331636
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D60B3020224
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4436D369229;
	Thu, 26 Mar 2026 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/tzRESl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E926330651;
	Thu, 26 Mar 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513853; cv=none; b=JF1dMCk1DOAJeTyinAPI98j2ZVQj6AXapkQdzJMUSprc2+UIJEdO1CkngCHTD91o5mgI7iESqEVuV1HktAIOc1dqB26A72KRlpOf/r9S4NYp4dwGcFWUz6NDP0jEeaKJxJWkNbnjmWqglD11KeBPiczzVS5TYjvNE+wjBw1xgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513853; c=relaxed/simple;
	bh=aXZLmu1r0N3ZiLsyHB3RIQpexKASDNHCMInj5liYXRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrmsDtd96jdkxgZuW5Rx6incevmPfNjcx3uSatQlfKu/x/VjokGmjQR8tBd9kIMuLUBK4vEefLSlNh1s5C6pSSTLXC1iqvTGMuyUQr/joaaJq4n0ud8PZoUZ41XylxqwPYPnTxCc2eHHNUBOQLjN2tKVPd2WC4eazqihbI96DUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/tzRESl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9B2C116C6;
	Thu, 26 Mar 2026 08:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774513852;
	bh=aXZLmu1r0N3ZiLsyHB3RIQpexKASDNHCMInj5liYXRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/tzRESlxqaOoq+s5j7Z/OeSf/tdF8xOuX+QylNrstiKdyzhLj9TzCP9+OeM5W1Sx
	 NmA1TD2D0fQ9xm3Qf47z1ABPjxM41tzwJZnDxF5Mi0lpFOEk6JRabKceQLSt6AnAMt
	 0POmGWJv8b0qIsg23HhzdtrDaDz0DTiTP1HcxzlkRBvPf5An67LeXQynt/5dAWKkZV
	 d10jO3Fn7Wjw27EdxtPqEYq5WjyBLm8FrgAUi22RekkvM4uGHnLOWnFlCvoEodRueh
	 w2XdqM8vGQH5D93u4AUqXcHkgHczWq8vh0nJCq4gyWLGHHXKfFslHcYQgK26Nwnef3
	 kArB3bzF37wpw==
Date: Thu, 26 Mar 2026 09:30:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH V3 3/3] arm64: tegra: Fix Tegra234 MGBE PTP clock
Message-ID: <20260326-fractal-stirring-barnacle-4f3b7b@quoll>
References: <20260325135811.148480-1-jonathanh@nvidia.com>
 <20260325135811.148480-4-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325135811.148480-4-jonathanh@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271930-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: CCF2B331636
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 01:58:11PM +0000, Jon Hunter wrote:
> The Tegra MGBE PTP clock is incorrectly named as 'ptp-ref' and not
> 'ptp_ref' and this causing the initialisation of the PTP clock to fail.
> The device-tree binding doc for the device and the Tegra MGBE driver
> have been updated to use the correct name and so update the device-tree
> for Tegra234 as well.
> 
> Fixes: 610cdf3186bc ("arm64: tegra: Add MGBE nodes on Tegra234")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


