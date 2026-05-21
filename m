Return-Path: <netdev+bounces-290545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O+XA3QvD2r+HQYAu9opvQ
	(envelope-from <netdev+bounces-290545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:14:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C55A9086
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C119E31E3031
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A873546E0;
	Thu, 21 May 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja8dkwva"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757EB13A3F7
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377843; cv=none; b=Ayj/QC/NI+EXIF9h53q9nuG8okqOKL4UhYmhJa8GcS2ffpXNVwdKH2iHugQu+MBXcIBsnK3pt+JSgXm2PtNHZeqYd3mJMV+Wj4biM02Vsm7u1dGhRIlOk7tuyLwfticaAClkWo8Sww9OMXFmzGGqoK3yHiIx2bz8wZzS/pC9Cj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377843; c=relaxed/simple;
	bh=VXOwYWX1xh9f7vfOxrTrZ9VWbfBjIvmBbptxVXN1+gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vtr/dNq1wjDNtehdFyqSC31V2BWLJ1zeg2ydH7kUsUHhnRh3q1UkIu3hIjuugz1zsoSw5BDMClrHPFrn5eE0Nw9TBujPAA2Dq7XlKFvE4qE6Uf0LJdczKjCH2sEA3eA9Fb5alD4D1kuZ5LBzIyA8HTOe4NeiSp6peVbjPpnYAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja8dkwva; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0361F000E9;
	Thu, 21 May 2026 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377842;
	bh=DeqdQCLUsjvjeynVPJcNzG3Q21M+KygIZErHrc8JodQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ja8dkwvaZr24Z4cr/C1nPi4Tog3LkboMBnczTRWyNnNoHqedX+ZXCNGliXIsnUxw6
	 v/kEvcz7WddwLzt5kZVkAGzGRhquxgrNEWfswHW4qLEXlmuyf9ZsgWoQ7ELW2sk/lh
	 mkgBQiIpp9i124Rj14587MdfGcmaypi7gmP18fOhvqlxhh1XX7crx2E3QI6cQ/witV
	 EMKY6Rig1pi9+l1BjbvKK8UmaYdqxsMTMh/3DO1nPUAztKflb2xPUhjMuwtOPbQbUm
	 vwHzx0JXKbA6tMSgNH29VMLNk8E3lDmNaHUUf/kTYT4EXzNFmc6GoH837JzhVlm07l
	 82ll7i8UU/mvg==
Date: Thu, 21 May 2026 08:37:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Kohei Enju <kohei@enjuk.jp>,
 Simon Horman <horms@kernel.org>, Patryk Holda <patryk.holda@intel.com>
Subject: Re: [PATCH net 1/8] ice: fix UAF/NULL deref when VSI rebuild and
 XDP attach race
Message-ID: <20260521083720.67b24a7b@kernel.org>
In-Reply-To: <20260520183501.3360810-2-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
	<20260520183501.3360810-2-anthony.l.nguyen@intel.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D87C55A9086
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 11:34:49 -0700 Tony Nguyen wrote:
> +	if (test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> +		if (prog) {
> +			NL_SET_ERR_MSG_MOD(extack, "VSI rebuild is pending");
> +			return -EAGAIN;
> +		}

I seem to recall complaining about this sort of error handling to you
folks in the past. Chances are user space will just fail seeing this
error, rather than retrying. The correct behavior would be to wait.
Is that not possible?

(I think Sashiko is brewing a lot of comments for this series so it
won't make today's PR either way :()

