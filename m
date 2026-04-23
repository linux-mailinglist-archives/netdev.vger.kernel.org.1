Return-Path: <netdev+bounces-280812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JzhD1xQ6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:01:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E854553DE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78F76300DD7C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684B37D137;
	Thu, 23 Apr 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOZ4Z8IQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7952D2488
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963544; cv=none; b=bRIlk6Pwy3n4bd4VhP8sDrZabqzrWnwotRvo+QlznqoOmvW0hdWAW4fWLPJTuJFRy1GqhzNMk5Fip59nAPv71KZECh1drRZqCV3f8ImVDkQU50fDCCraCcDjO64B3C2FsKSIK5fD9xVMJbQBd3yXkvVJHgyL9bsz8GP0m3d+xFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963544; c=relaxed/simple;
	bh=HWF3fynQuO3pQwWRnZ31DO+K+HHAJDpLv0yXmAxCd9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABGyPaj9H5r+ccHNQiUpkCuswZEsi22KKvX4r8gmOY3QWSYboRgFw6aWcL5PmUgNubHSdyqbgGR0IHkBkqGoFq+ZZEEqIfOloeQkm33dpB/EgaRk20gv81izhTbjCqmB9wD6S1HFb700yUgeXe8hfC/wenqNTb7huNWpDmy2bKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOZ4Z8IQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D16C2BCAF;
	Thu, 23 Apr 2026 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776963544;
	bh=HWF3fynQuO3pQwWRnZ31DO+K+HHAJDpLv0yXmAxCd9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOZ4Z8IQ6NqKs4G2m5bqTZDFzIX3P56QkXyJVv9e74wCnhd3n+dYPKjak4raCrWJp
	 ji9PwAfwf/GwZBLV7Nngb+AQJqpRJFZPFRVQwom0eulEiSvddyKJfPvZZ17lR21+DL
	 +uIx3hGlUP2WbCpfWdsiWSj75MFRWcDIlivQR+SIrW18Iqm+Bm7/qcPHQYgGc3O/4m
	 RgoIyO9B2dAY7BHP82u+LwlZDufnGTxKmuhB2nqlYVhtjj6/Cx7Y7cD0hbQDS0u3iT
	 4MHvGUQnpTRR2OyHuX1ragrLrvusuRwveJVVcmn8dvag8o6vP6mbFEoQ3kxW6W2pkL
	 B4Zqz/gMdvhwg==
Date: Thu, 23 Apr 2026 17:58:59 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andreas.a.roeseler@gmail.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	caoruide123@gmail.com
Subject: Re: [PATCH net 1/1] ipv4: icmp: validate reply type before using
 icmp_pointers
Message-ID: <20260423165859.GE900403@horms.kernel.org>
References: <cover.1776563662.git.caoruide123@gmail.com>
 <efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280812-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[lzu.edu.cn:query timed out];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 68E854553DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 06:19:18PM +0800, Ren Wei wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> Extended echo replies use ICMP_EXT_ECHOREPLY as the outbound reply type.
> That value is outside the range covered by icmp_pointers[], which only
> describes the traditional ICMP types up to NR_ICMP_TYPES.
> 
> Avoid consulting icmp_pointers[] for reply types outside that range and
> keep the existing behavior for normal ICMP replies unchanged.
> 
> Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has generated a review of this patch.  I do not believe the
problems flagged there need to be addressed as the array indexes used in
those cases have are always valid.  However, I would appreciate it if you
could look over this.


