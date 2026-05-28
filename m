Return-Path: <netdev+bounces-292740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDPOC4ZdGGrVjQgAu9opvQ
	(envelope-from <netdev+bounces-292740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:21:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFC5F4505
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 681443145A50
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695523F7885;
	Thu, 28 May 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv1q8UQc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B33F2109
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980871; cv=none; b=cIsnL2e0b1qonWDDMXpzNwgQK59zMI5bzE5RRMQDy2ERSaG49RIvrNSpaQogSwWekIKoSd11gbiM5xufwSGW62SY9AkzVpI+lvSbUUBMH0Lhlk1DyzrezxavP65Y5Agk0ihIoN9q3l+PiYLVOljTaOd4ygI1r0mzYoj3RvQuGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980871; c=relaxed/simple;
	bh=c6/yQ+aiHcaLwmQo6qcNVLwhfEPpXvDNZdnx8OO+R+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6YHzbNB4frDPx8HXulu1Hqn5rNb78Yk5tHELLpb6hYCTKDZ/z7AUAyfpCPlpt7V+EGovLw5FK/1PrgcSkQB4BJYcoFTXpFfopzDll8LcMeigalAYEg4np2/PlR618zkf8WvE32R4uY3BJoV6TugIyfLO/ZD/5GozoeFQnpx/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv1q8UQc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E931F000E9;
	Thu, 28 May 2026 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779980869;
	bh=7/okIY2wgxnQyhKEZlgiZ4ASlffEMjPQtXrxLlJX61I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hv1q8UQcbuIHv5njwl50dOq05VFFkS5+7efY/D939gwmKQ8Pclfc56I3w9pyyJCNz
	 1YMiNNQ7re1R5KTqDX68POIR83ME3AdP2cChSwBMVn+V5JFs2RHPSvevX83gYhqwn5
	 8uprQT3l4x3s9f65KzZn8WFa3feP8eCsCt9eQGU7/Jy+wevUt/D0KtZmZRvmtXyCDj
	 1KP4fvYKQQjSHvZsi7L2Qacln7sl0JWjr0p94P+/PEg1mz0OETopAzRtSUJu71/aCT
	 4CBeUtvFDwVDRjL1a7Adazwb3Uktb5/R+UoyagXL11qauT7U2FK4tkluW/eZ2OMRkD
	 ZhuIiyqwdg5Og==
Date: Thu, 28 May 2026 08:07:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <20260528080748.3e74355f@kernel.org>
In-Reply-To: <20260528142851-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
	<20260525125437.4061-3-oscmaes92@gmail.com>
	<20260525084528.547fe263@kernel.org>
	<20260528142851-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DEAFC5F4505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 16:28:51 +0200 Oscar Maes wrote:
> On Mon, May 25, 2026 at 08:45:28AM -0700, Jakub Kicinski wrote:
> > On Mon, 25 May 2026 14:54:37 +0200 Oscar Maes wrote:  
> > > In my testing this resulted in up to a 25% RX throughput increase in iperf3
> > > tests in both directions.  
> > 
> > On which platform?  
> 
> Intel x86

LOL. Please. Which _hardware_ platform.
Or to ask more directly - is it QEMU.

