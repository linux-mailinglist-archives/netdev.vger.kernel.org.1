Return-Path: <netdev+bounces-269204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPIICBMmu2kcfwIAu9opvQ
	(envelope-from <netdev+bounces-269204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:24:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE042C3587
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF28A3062208
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7936AB5F;
	Wed, 18 Mar 2026 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUAwZl2m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3746347BC7;
	Wed, 18 Mar 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872653; cv=none; b=uaNw08v7EW3Ja7y2VoFCgmTyS+85cnBb4y8/ufHwrYe9Xcw+XC5NfJNEt9LL82w0kwwsukzK9TlqHYi87hFCk5/P1zjw9fviJyQOdkScRksNbja2WpIo5oLt4o1tBfkHYfjfZ+FVcGndec5Nki9IulT/DBFmeq10/++lZfJrPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872653; c=relaxed/simple;
	bh=h6ndzAFvIQVHqH354HE+77ZIUYrbNgvOw6/MHKSXkcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHf22UdjuR88XE2Jz/VnnWIlIdFLEyd9pjaxw18mfaj7qBhuSERmDPRRn6LKzNeIJVv6iX/OFzampOHrFlAVYMkNjTX0FsHTMXTdRmTwubsPMBMP19cQgmawrGEXKl0TG+M+cX9aJLdDt3EHcIB3LkQ/58P3pZrl5zRMV80hY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUAwZl2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BC8C19421;
	Wed, 18 Mar 2026 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773872653;
	bh=h6ndzAFvIQVHqH354HE+77ZIUYrbNgvOw6/MHKSXkcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUAwZl2mzfE6ZOYdjgXflyKsVp07YDgb/YHhAMsj6KAffhy3k44djep/2i4RjEsDH
	 DgCO455CMfC5YLsj77FsAcijiCBVU3b59EcTx/x4Kr74UwesFclFSemVn0HmwAWIDg
	 /IzFB520uDimKtkJ0sqtTcXd7xJYan/Ow23b3Yqakompc8vBYgW3JoTimW47hLJR4B
	 +eFGnHcP8jwuKGDnTJyJai0Of7NfJ/0HF0AeJjbjSZKWcdtn2EzLQcGsAWnKZtY5fu
	 WHYwaN4C9dnWdiUHWDmCYIM+8Yfcsv37Qz+K1NxmIvA9Az7Ygs7dPwCnkawFsehwDx
	 9RJQ2HPwFHPXA==
Date: Wed, 18 Mar 2026 15:24:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Simon Horman <horms@kernel.org>, wei.fang@nxp.com,
 netdev@vger.kernel.org, xiaoning.wang@nxp.com, vladimir.oltean@nxp.com,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org, krzk+dt@kernel.org,
 frank.li@nxp.com, claudiu.manoil@nxp.com, chleroy@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 imx@lists.linux.dev, pabeni@redhat.com, f.fainelli@gmail.com,
 linux@armlinux.org.uk, edumazet@google.com, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next,13/14] net: dsa: netc: initialize buffer bool table
 and implement flow-control
Message-ID: <20260318152408.002d1bd6@kernel.org>
In-Reply-To: <3dab3f5b-fb94-4c63-bcfd-aad4268e2ac3@kernel.org>
References: <20260316094152.1558671-14-wei.fang@nxp.com>
	<20260318145452.1898637-2-horms@kernel.org>
	<3dab3f5b-fb94-4c63-bcfd-aad4268e2ac3@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-269204-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,vger.kernel.org,davemloft.net,lists.ozlabs.org,lists.linux.dev,redhat.com,gmail.com,armlinux.org.uk,google.com,lunn.ch,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AE042C3587
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 15:56:39 +0100 Krzysztof Kozlowski wrote:
> On 18/03/2026 15:54, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> 
> Why are you removing the "PATCH" part in the email subject?
> 
> This completely messes up with the filters and causes this email to pop
> up in places it should not.

Sorry about that :/ We pull patch info form patchwork and for some
reason patchwork uses this notation for the "name" of the patch
when showing the list of patches in series info.

I'll hack up the scripts to fetch real thing from lore.

