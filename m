Return-Path: <netdev+bounces-244389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02433CB6107
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F39E3002FF6
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9E7313294;
	Thu, 11 Dec 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lmNrEIJ8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9FcAjhQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bdfkve6X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kY0s42jd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763E31352F
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765460489; cv=none; b=LmLTRsFJdn8FCtHajQs6SWimKbCNlu+cngMzVvrWp+J6be/GToiETExION6VMcUjIO9aGQaaeIKXCXiiTrUzrqEybdvP5QeOXR96FGI2PpDKXcUUMxTlvDGpLhK6U4bgMMxLywJ0utRex9Nb2fAYW6Bo3LjqKwOrWQsDk3lX/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765460489; c=relaxed/simple;
	bh=Aq7qOBQsvXPIbayG3KmN4gvu0Fr0SFkFCVc++g1MaOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPYWW6eir/q9QkhfmUnvjUtTFRFvKKkM2sK5n3BPFbR0geIYEWKKvIT3puX9V/5WcH8Fcso2wdIHpx8pitcy4KHNDARHRWRHNm4+2fi5hAgkHJDeZ23dQAssN39oBn4juch8NIfNOmRHmaIfcWyVRDOB6VczeODKxSqsVjA2/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lmNrEIJ8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9FcAjhQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bdfkve6X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kY0s42jd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82F0C3371B;
	Thu, 11 Dec 2025 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765460484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xp7w8crEseicsrhIetaRkGThZ+qNBm0DCQ3C6uLfXI=;
	b=lmNrEIJ87yQZ1dS+Rtc4cbsdX0C//FKzvZVPQRz8kCGAgDHGBkyanRh3kQyXincRyTpxFt
	MJ1IsbQ5HpQCQWWbc+AZJjos/AZWjqXTsJ0NFHd52g8w3RYedXm56CbM7NjYyVkK6foCJZ
	rSMMq82K9adRmX6MxXZqjDVo9hNORZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765460484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xp7w8crEseicsrhIetaRkGThZ+qNBm0DCQ3C6uLfXI=;
	b=s9FcAjhQ1sAEongctiq7T8gDVdzCj//OqK8z1vOlxRmkc9SXUF5uoYC5JDFrU56yqZL1h7
	19cvEjomo5NSPyDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765460483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xp7w8crEseicsrhIetaRkGThZ+qNBm0DCQ3C6uLfXI=;
	b=bdfkve6XNjrMimbcNB6z8t/BeQv6Z1ciBlNGHEXp6csuJjAWMNwwkhutioUD9psV+5ZXwM
	iPJtitCaZeUmhYWB0abt+6Y0AiomDCtuPD2mJ/+gF6BNNl9Ki4AhPpYmXxl67JZjYnKjlG
	6WZLcUkmIvIHiVXhv8qyWEhTFhfgE5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765460483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xp7w8crEseicsrhIetaRkGThZ+qNBm0DCQ3C6uLfXI=;
	b=kY0s42jdxwkxOpG7uWsnV+EUeZGKO7nsv0mtp3IQsTKs/o+HvsizoiU+vB7kdqZXwlkEsu
	MllSU32RiLhe21Bg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 515F320088; Thu, 11 Dec 2025 14:41:23 +0100 (CET)
Date: Thu, 11 Dec 2025 14:41:23 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: Carolina Jubran <cjubran@nvidia.com>, 
	"John W . Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org, Yael Chemla <ychemla@nvidia.com>
Subject: Re: [PATCH ethtool 1/2] update UAPI header copies
Message-ID: <nco5hrivs7jdsaseejjkgsvjt2y25loew556gxcykdft56uuof@qdlhhch7hwgi>
References: <20251204075930.979564-1-cjubran@nvidia.com>
 <20251204075930.979564-2-cjubran@nvidia.com>
 <aTrGEQIX6b40assX@test-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTrGEQIX6b40assX@test-OptiPlex-Tower-Plus-7010>
X-Spam-Flag: NO
X-Spam-Score: -3.77
X-Spam-Level: 
X-Spamd-Result: default: False [-3.77 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.17)[-0.853];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lion.mk-sys.cz:helo,nvidia.com:email]

On Thu, Dec 11, 2025 at 06:54:33PM GMT, Hariprasad Kelam wrote:
> On 2025-12-04 at 13:29:29, Carolina Jubran (cjubran@nvidia.com) wrote:
> > From: Yael Chemla <ychemla@nvidia.com>
> > 
> > Update to kernel commit 491c5dc98b84.
> > 
> > Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> > Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> > ---
> >  uapi/linux/ethtool.h                   |  6 ++++
> >  uapi/linux/ethtool_netlink_generated.h | 47 ++++++++++++++++++++++++++
> >  uapi/linux/if_ether.h                  |  2 ++
> >  uapi/linux/if_link.h                   |  3 ++
> >  uapi/linux/stddef.h                    |  1 -
> >  5 files changed, 58 insertions(+), 1 deletion(-)
> >
> 
> 	looks like there are no changes in "stddef.h", but its part of
> 	this patch.

It's whitespace only, AFAICS (one empty line removed).

Michal

