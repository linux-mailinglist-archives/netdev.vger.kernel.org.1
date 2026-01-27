Return-Path: <netdev+bounces-253824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kERtDpaheGljrgEAu9opvQ
	(envelope-from <netdev+bounces-253824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:29:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2693971
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C68302E90D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3320346FAA;
	Tue, 27 Jan 2026 11:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB20346AD8;
	Tue, 27 Jan 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513350; cv=none; b=PS525ddybHaLtCYOhJgLQKWZMLxqEoVmwqAmgKiakpoyYoU0/j7ZAydggQY1UQ0o45vMOxBjXekJNSl/RQn/F4i/omDVs+3/Y78H1+G8wQUS6fGdkiwS/wqYB/SwrZjkkjSsFyBQqN3isqVCyoLO1rlAZbU4GDBKCkaZZWnwZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513350; c=relaxed/simple;
	bh=J8onob1rjyOl4EooAMxh9Iy1UHZaEDzeMxJAqh5Lic8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTcxFbgNUmCr1E+isNbmoSjqqrgNdRq+mdyAf1yE1Y01DbSLKNvRIdcZL5JGQIwwf1rv+CCaWsccGABcIEOi9ITBW+hfH+v3QRTF8z6+gdvJxbT8NNyW5AgP5SGhggSpRr9OBdHQr0X357Kt61CO2VA7MCUCLUjCCepZEEjf74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 82E446033F; Tue, 27 Jan 2026 12:29:06 +0100 (CET)
Date: Tue, 27 Jan 2026 12:29:06 +0100
From: Florian Westphal <fw@strlen.de>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: fix static key check
Message-ID: <aXihgjj_H9Gk2X0H@strlen.de>
References: <20260127101925.1754425-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127101925.1754425-1-martin@kaiser.cx>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253824-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3A2693971
X-Rspamd-Action: no action

Martin Kaiser <martin@kaiser.cx> wrote:
> Fix the check if netfilter's static keys are available. netfilter defines
> and exports static keys if CONFIG_JUMP_LABEL is enabled. (HAVE_JUMP_LABEL
> is never defined.)
> 
> Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in bridge input path")

Reviewed-by: Florian Westphal <fw@strlen.de>

@net maintainers: feel free to take this directly.

