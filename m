Return-Path: <netdev+bounces-287790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIcON9MzBWonTQIAu9opvQ
	(envelope-from <netdev+bounces-287790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:30:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD2F53D0CE
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BEE1300B10B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB028224AF7;
	Thu, 14 May 2026 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBRRaJeA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46623F410E;
	Thu, 14 May 2026 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725840; cv=none; b=MjhmI32Gt8YuEnDbVp9Xr1eKiumiv2uCbZlOEYta3ME8NBQPtCjwrH0oKI1NffqkNoY0qNeJcf94bnnLZYB0BqeQDVqK89Y1ZMxmW/vbGmONvJ3iZvmDEtZ8LxUlyMQEjxjd64OP+bFab4ccKiHcJhMtZxVGoToDjkJs1Bf5PzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725840; c=relaxed/simple;
	bh=anymWKMJinrIHSnimXr7FGoJQlWff6vTzzrQCu4N+nA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLyNchYXi7a0SYli2qGY8/erYbncl17nat0+DxiscbpBI5x1juqHoPq5QKEPdGgP5h9QwZrg5NDeWAQAr53JVTEsqDYO1u/yEg8WODn3nrSwGc04aS48qxZ84lawKcGZcamA0x3W8gPACUw/hTq47h+p0GVL7OXUr+k6SFqpPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBRRaJeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA958C19425;
	Thu, 14 May 2026 02:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778725840;
	bh=anymWKMJinrIHSnimXr7FGoJQlWff6vTzzrQCu4N+nA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JBRRaJeA8URSNwVV3xOUiqP11p63HixRu8h8+WBou235CWpJFNDTJewpQZz5KcM52
	 SM8QyM1AOENFf8wLyBI1Y6sEJ1iHdi6KbYppFMOPNlJKz/0NpOtZrT2tiIyPQPcYNX
	 C497nLfIAdX8PZ2s9jFIDeX4+sGr1UFHFi+mIgAbtPlv2iCnL0OugoFpm322WK9nyo
	 9XnpOWwW9S/7oFhllZzkFi3WkJCvaslRjNe8XDPPjSo5oeNamMUDxmkPA1rn4DXSXc
	 EwYOCJfZ3wZDbwUJN5q5fjEAsNyqrYPefdFdSpswvE9SaQn1OsERT15vyCS+eDiqS2
	 KkinYQiENEuvA==
Date: Wed, 13 May 2026 19:30:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH 2/3 net-next v4] ipv4: handle devconf post-set actions
 on netlink updates
Message-ID: <20260513193039.7dd435df@kernel.org>
In-Reply-To: <20260510081528.5257-2-fmancera@suse.de>
References: <20260510081528.5257-1-fmancera@suse.de>
	<20260510081528.5257-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AFD2F53D0CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287790-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 10 May 2026 10:15:27 +0200 Fernando Fernandez Mancera wrote:
> -		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
> -			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
> +		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
> +			int old_value = ipv4_devconf_get(in_dev, nla_type(a));
> +			int new_value = nla_get_u32(a);

Hm, what checks if nla_type(a) is in range?

