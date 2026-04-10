Return-Path: <netdev+bounces-277200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPC3Bo5X2GnacAgAu9opvQ
	(envelope-from <netdev+bounces-277200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:51:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED43D1397
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E72813009176
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4DB29DB86;
	Fri, 10 Apr 2026 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEdLuTgO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE861A682B;
	Fri, 10 Apr 2026 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785867; cv=none; b=EAUBmLbfZFaIVZFRu+O6pLICSs+XoDeoYzfXiqU5qFnw25dCxctuGpokmysovUukmZSUF4KU64OkN3stq6XJvMWTEVCa+IcWyEdJHOW4Qy5wZiVYHJjpK8pn0g5zEqNB7kpATi08f2lPGgCQ/aZpW5qFs6Z83UMia8HygiGDkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785867; c=relaxed/simple;
	bh=4kdbX8C7vVDG5MUQ0azlR7qfOWKDTh9ORukaO367o34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJO9NDjM2a2Pu0O9HHFntJAqivGqmxCHA8LCOL7FRWGP0j1irupJq370l8G98FTefGZuRGrKhCdIpfs38BxalW8QpRWarV5O/4Gb9YrZVxIkqYGdaOSdwf/fgWjmKyOplN2JDKlcxGqqeWusp5QJBRqhwf3hxYvMFub23X/5iHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEdLuTgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA06C4CEF7;
	Fri, 10 Apr 2026 01:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775785866;
	bh=4kdbX8C7vVDG5MUQ0azlR7qfOWKDTh9ORukaO367o34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oEdLuTgO5GL/HHnic4/aiHDpF783SZFwt7JB2zZbdjjtPqA76vwL/aHQMgf2Rmzb1
	 2xk7EeWIK/OlDLPUwO10uO5VSsMLrJyOFF/w6RIpnpgIZrub9Nh1GrLGCiczWyZ9TX
	 YAyDlXsshQ+nLL/JQ4DmZXuXj6hIWROFVGbI20Icxs+CxLi1nGcjZ6yX5FfgjxUEY7
	 E/lYrkiXyiJE/R8NmVdWnSYoWNORbSmxoMo9ERbd1/L1kNcuLsTiT7Ia8vD2kQW61A
	 8ZSalhdkFZGwb/hG+ODwZEcHYkRbSmD5yWS7u8AOW+vl7v5hBYTxVmQmg/sdlplkgt
	 /Grsf7uO/BwXQ==
Date: Thu, 9 Apr 2026 18:51:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v11 03/14] net: Add lease info to queue-get
 response
Message-ID: <20260409185105.721a6465@kernel.org>
In-Reply-To: <aa222301-e716-41cf-ab10-5365c0e15b6a@iogearbox.net>
References: <20260402231031.447597-1-daniel@iogearbox.net>
	<20260402231031.447597-4-daniel@iogearbox.net>
	<20260407204017.3fc79d1b@kernel.org>
	<b9a046f8-cb02-4d54-9a7e-e8213339d720@iogearbox.net>
	<20260408151251.72bd2482@kernel.org>
	<731d2749-abf6-403c-a1f4-ffe9c8d1e8ad@iogearbox.net>
	<5a5feea9-7675-4ccf-aa8e-3a2e476ce8f5@iogearbox.net>
	<20260409074651.2e58b3dd@kernel.org>
	<aa222301-e716-41cf-ab10-5365c0e15b6a@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277200-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 70ED43D1397
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 17:32:31 +0200 Daniel Borkmann wrote:
> > I think the test has to be reworked but of the available options seems
> > like merging it as is and following up quickly is the best. I've only
> > set up the container testing in our CI yesterday anyway so there may
> > be more things that need changing in the test as we gain experience :S  
> 
> No objections obviously if you want to land as-is with your refactor on
> top.

Done, please double check my work, there were some conflicts with net.

