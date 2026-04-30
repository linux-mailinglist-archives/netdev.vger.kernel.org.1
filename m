Return-Path: <netdev+bounces-282927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7qq7AiZ682mt4QEAu9opvQ
	(envelope-from <netdev+bounces-282927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:49:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 914CA4A51E1
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A76203008C0A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7CF44CF39;
	Thu, 30 Apr 2026 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YDPegXpS"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0F44CAE2
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564187; cv=none; b=JeCy50nM+0ULg2DZkZS/p+mWZNJSSkehiQiuFnNzScUWzGQXtJYLkuRlqF8uJGp1RZA/jhgEb5cr/syFH0jIYlNQs55qWt2VIhZ9fs/nm4zLS3CAwgXJAhnhS3DnM90R2oAHnmCCyQjzaN8olL9EoSrjZbtSH5UhIomZmGzbP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564187; c=relaxed/simple;
	bh=Pd8sYVFV1kR0uSimC6jrCcGJEkwAziThLBOjGnujbaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=a8xTtbN2uNMHULG8OFSZ7JLY+ltUzQ5Bg0HHuj075nWa9gVvJSvaXMB4uKJjSA40yrFkqnsq2CnJLEfgdX17uCskIs7uw1s8lYWHCnPAyg6OErmod0cm11gW1e7ds4mGgrU+OLo0FuNshRemByUVJ+1Dj/iccDnDVrTZaLZvbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YDPegXpS; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260430154943euoutp01aa4ecc9fcaac5bca7cedc8429f3ee74e~rLTTzpenl2250222502euoutp01T
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:49:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260430154943euoutp01aa4ecc9fcaac5bca7cedc8429f3ee74e~rLTTzpenl2250222502euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777564183;
	bh=iCKWbPC+I/tUrQZJo+RFleYMY1viaZ7b8su8ZQeFbG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YDPegXpShtz3+ydmnC4zWjutNW66ZiSt2HRTHYrXgjRx8ghZ9tTFZzomldrOLO+Kj
	 ydUF+T+w0EUOOBrXecEOjWZKHMm2cN31en3SOjqAfIMKIDLGhEBq8TQn2NKKQjQARy
	 f0Uxp+ilwFYC7W77ZgwLjlm2BKwn7gnQd8gz+vQ8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260430154943eucas1p1bceacf3abe2f9fa802912566f1876217~rLTTrGz3v0489904899eucas1p1s;
	Thu, 30 Apr 2026 15:49:43 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260430154942eusmtip233cda62c92a14610cd4e27508e05f97c~rLTTNpc3N1125511255eusmtip2i;
	Thu, 30 Apr 2026 15:49:42 +0000 (GMT)
Date: Thu, 30 Apr 2026 17:49:39 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH RESEND net-next] net/sun: Fix multiple typos in comments
Message-ID: <afN6CpRoH6g2RdoB@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260430010322.2326574-1-kuba@kernel.org>
X-CMS-MailID: 20260430154943eucas1p1bceacf3abe2f9fa802912566f1876217
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----EbkeEIwBiIKV-5_.nU08j0UNUa-otTO645nIPTj5A2-x7-zv=_3474b_"
X-RootMTR: 20260430010331eucas1p1e5a85246a4a475b4b70b883f4f241c26
X-EPHeader: CA
X-CMS-RootMailID: 20260430010331eucas1p1e5a85246a4a475b4b70b883f4f241c26
References: <20260428101728.3537456-1-j.raczynski@samsung.com>
	<CGME20260430010331eucas1p1e5a85246a4a475b4b70b883f4f241c26@eucas1p1.samsung.com>
	<20260430010322.2326574-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 914CA4A51E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282927-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:dkim,AMDC4622.eu.corp.samsungelectronics.net:mid]

------EbkeEIwBiIKV-5_.nU08j0UNUa-otTO645nIPTj5A2-x7-zv=_3474b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Apr 29, 2026 at 06:03:22PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

I should also implement any basic tools or AI to verify my writing skills.
This patch was basically prepared with help of 'typos' script and yet has
errors.
> The "autonogotiation" to "autonegotiation" change looks correct, but
> the neighbouring "in enabled" in the same sentence appears to be a
> leftover grammar slip (should it read "is enabled"?).  Since this
> sentence is already being touched as part of the typo cleanup, would
> it make sense to fix that at the same time?
Probably, no reason to not do that. Might be good to also change double spaces

> Neither "imperical" nor "emperical" is a correct English word; the
> intended word is "empirical".  Was the replacement here meant to be
> "empirical"?
Writing fail. Funny enough, I had someone read/check this before sending and
it slipped.

Will resend whole patch soon.

Regards
Jakub Raczynski

------EbkeEIwBiIKV-5_.nU08j0UNUa-otTO645nIPTj5A2-x7-zv=_3474b_
Content-Type: text/plain; charset="utf-8"


------EbkeEIwBiIKV-5_.nU08j0UNUa-otTO645nIPTj5A2-x7-zv=_3474b_--

