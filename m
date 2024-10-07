Return-Path: <netdev+bounces-132742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12279992F37
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AEB2859DE
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877CD1DA104;
	Mon,  7 Oct 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anMUKl9h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637771DA0ED
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311185; cv=none; b=FgXA3F80uE+hazyhEd0jun2CryUUds8RAQhfLKX3UpG9OmK5mtY1Pja+RL4mulzAKQJS5wE44Sreu0d+aH39PpyfgSYpcMOs+pRrTex1c0cSqZOn5SMkDwMiwRTR4mmMalWmfpte8IzP3xBreyiEo8tUpOUXEuyRGchvfctWXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311185; c=relaxed/simple;
	bh=jvoU1QQFcMTFEc/iOZh6D9bAnex/M1RpVDJjLb8SGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVJEM2oTc2jh9AolQTl4smUUX+GAPkrU7y9djZokxjVXYBsPtiW2XP6WpeTJr+GrTCuA3icnh9XveN6VlEc5mNobqQ9Jhmi3TwIgfb+m1NWzTGINUYurDIDFrfUKeQEx5qATaU7FZDmPNvxTKVXZno5XJe/hSFEStfthaz8Etfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anMUKl9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98520C4CED0;
	Mon,  7 Oct 2024 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311185;
	bh=jvoU1QQFcMTFEc/iOZh6D9bAnex/M1RpVDJjLb8SGo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=anMUKl9hsS1OpOrpWsEsYvjNC2P2/DxMJcNKHndPAR3Sbg+84rPFI2vI6e30T8ykV
	 RnVJbnSyLoGFpi+YkPvt/Y9j8Xg9roW41FIKOxtbgDNn9DP/diO02NRcDzuvvqHjz7
	 n8v1Os4h5qkTJRXEncs4iCSOAvM+PW53l9ugKCntO9NU01lTzh/tu3yC4lT/4CgpeG
	 peh50AzhiCXkX0AKmwg71hI1+d1MGWnVMDjbq1YzLMjGAeHfjlFURVlq1S4BtTtf+H
	 XaVMb6+uXggE34r4k3E4NR+Sl6uT2kexjcm+SM7kYT4Q+FilWt6Z4jLN/6ompwAk7l
	 OTJ4+aeNFUiFw==
Date: Mon, 7 Oct 2024 07:26:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Tobias Brunner <tobias@strongswan.org>, Antony Antony
 <antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
 <paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
 <sd@queasysnail.net>, <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH 2/4] xfrm: Cache used outbound xfrm states at the
 policy.
Message-ID: <20241007072623.1b7b24f9@kernel.org>
In-Reply-To: <20241007064453.2171933-3-steffen.klassert@secunet.com>
References: <20241007064453.2171933-1-steffen.klassert@secunet.com>
	<20241007064453.2171933-3-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 08:44:51 +0200 Steffen Klassert wrote:
> Now that we can have percpu xfrm states, the number of active
> states might increase. To get a better lookup performance,
> we cache the used xfrm states at the policy for outbound
> IPsec traffic.

missing kdoc here, FWIW:

include/net/xfrm.h:595: warning: Function parameter or struct member 'state_cache_list' not described in 'xfrm_policy'

