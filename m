Return-Path: <netdev+bounces-289284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLDOLPoCDGrETgUAu9opvQ
	(envelope-from <netdev+bounces-289284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:28:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 330D1578165
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D99AA311502B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C563876C3;
	Tue, 19 May 2026 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="FgYoqae9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BD37CD42
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171567; cv=none; b=gLefgt6N9WSTEcJm99SSVlLVPcDFdObNW6t1HUkzXDBtc4cvEICBkdOylak7fBg48xbrQKDjkWELP2W+JKxX9xFTG6T0RSmGNA49NcKuvx6jPqQmT96MUlnJaI23mtj/K0qbmCnaZvw4r8g7MwR2HkACmDE3YJw/mTDLM8kBWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171567; c=relaxed/simple;
	bh=vqb0FpFo19y3A274d+b4C+8E/9a+TiVcC5zMvUUwpfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHtptDokZVf0bdxWDerX5LSMhOA9wBFPVVejozsqsoYh2+VyvNo+ORENwnuVT/4687ydr3b81S/kvLUoPS2JwbS1xDIeITBAbP6FY+BjASTR/N7l9pX2KIOL78Fco7VCDluKIWbYm0G5dMZXC/UbPLz4XzY7qsf3CPyVM4R2FnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=FgYoqae9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36974217d4eso1767647a91.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779171565; x=1779776365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLDd1nTNoi/a2u/UDZO1p6PnaILOwf1IfErETTfppzs=;
        b=FgYoqae9d0kYsxVeyeJCXvnRYKuz0CZrVeopGOLX/U0TWihRCBaMQ7DI+RGAAcfxZA
         XdqWioCnLk0xvdCW+u3NNXaqDye1d5MTCGPaCQSujOPnjSa3u3QUSd9j9T5WECkjdDIW
         //Fo6RVlOLJOiOZ5jAWJ9v0uq3vHwbDqqY+lXHrwbqdQuz23j3I3pCFrqo+mOdv/Ip1O
         1ZyUPDu0TJIIMOn8YbTHo0gC17m7ZF6nnA/Z1ehxIhEKuHKHwiKV6A1KQI2IbNSy85zR
         E9i16nAbOcUxUj1J8LyJa8gjOd1xlznbHinSl19DATSH8sjEKMNi9a5NxNkCW6palTbj
         wQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171565; x=1779776365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLDd1nTNoi/a2u/UDZO1p6PnaILOwf1IfErETTfppzs=;
        b=BpwBFAbWfvV/B32J86tcDJEP6x4I19wKW3tLzmAy4Qm6ndNS4/IGifSBzk7seNG0Ui
         mGKtpZFkbpxbjBAtbIVFsoGVKyLIHFOZjSrd4jWzHbeOOd15Ph+06nxL4Drmwcp2zccm
         jmqptlhfIkOPzGaYmJ6QpvNCR8F2HaJJWLdriXpWyaxBDv4XWErGJbE0COz88bt0h1Za
         t5+pYOyM9Js4gC3mH6QVcw7FJUpqSsR50ADRDinnUKmHA267h5wj2KXTyh9oOz7g6SCR
         hPaM946355f5oCZzjXSD6a9qC8bIljBPMddI7wssBeIHVSvSx7omWQHqj/kCY7H/4pok
         e38Q==
X-Forwarded-Encrypted: i=1; AFNElJ+rV0LPVxpE8qsZOLJfxG+P8SDgjVlE0NFGDQaXiCSUG9T22g6uUnJiKzmjwWzCiG6hxQioYs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLQX48l9dl/uV8tv8QZDC1mVNvaKkU0N2N960SBJfLT9+LVvW
	z/KYGCnem85DdYOhXWe7C4cve2opC6MaoaUtSU5lLX2TKpnSfp5kT3hLgUylsmma0So=
X-Gm-Gg: Acq92OHnoFhkAaMoWMA9TI8iJSF4EjZIuu8G/EAr+xaMB5I6p9oIX4hPGZTO58iG2QM
	hbqFhmU8q+iyD30Unq4Qw9I0H1VjBbb1pRZEYQe2eLUjOR+sCqTpsLdStBPav4Aaf2ya37mMd6K
	q1Hx0DRJLR9p//zYTgGhYVgd1ZZ2ED9X+sjy3bYjMh/D1ORGAz25/LLsQxa0DddRoqPbx5CeQkX
	CnTtRvTfL8qOFfaI/UqKUDeeCG0wXNuMpPXtCX420oqIztYgKmf9J6Ol56azgyosmTuPAHwTtfw
	g5QB2vdFDgPCY3wegPCeW1viOSMyT6rvNrTHvbOUSReDjT0YpVLbx1qvRFpKlYhf2/WvLd/+Dm8
	cP0Vc54uL6Anu5Vg+miNbpE4llvRwiWiNX/sDrKKsbrELRSyEK/nmK5uHsa7SntsJkc72+sBfl2
	2cWUWwAev0igBUm038F+pf07wa0uyyJYe9VT16b9MAePZSD3Ua40YTBEwjHwHUm82NzUtlhI/Y7
	gPFSBhy0vVf/P9ebJ/D4VkZfcy1L/9QVa4Vj51XFeJbjQ==
X-Received: by 2002:a17:90b:33c4:b0:35d:9c32:6219 with SMTP id 98e67ed59e1d1-369519e8faamr17627377a91.9.1779171565440;
        Mon, 18 May 2026 23:19:25 -0700 (PDT)
Received: from essd ([103.158.43.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a09e95esm5167462a91.9.2026.05.18.23.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:19:25 -0700 (PDT)
Date: Tue, 19 May 2026 11:49:17 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Jakub Kicinski <kuba@kernel.org>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, 
	johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	m.chetan.kumar@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: wwan: iosm: fix potential memory leaks in
 ipc_imem_init()
Message-ID: <r6xteqo3uj3hiujtohra63pdkwx4uqqub4zovkkaywfuburhan@6xqqvahrep5g>
References: <20260508092141.82495-1-nihaal@cse.iitm.ac.in>
 <20260510170451.3886726-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510170451.3886726-1-kuba@kernel.org>
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289284-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 330D1578165
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 10, 2026 at 10:04:51AM -0700, Jakub Kicinski wrote:
> > diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> > index 1b7bc7d63a2e8..f4edb277efd92 100644
> > --- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
> > +++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> > @@ -1422,6 +1422,7 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *pcie, unsigned int device_id,
> >  	hrtimer_cancel(&ipc_imem->fast_update_timer);
> >  	hrtimer_cancel(&ipc_imem->tdupdate_timer);
> >  	hrtimer_cancel(&ipc_imem->startup_timer);
> > +	ipc_protocol_deinit(ipc_imem->ipc_protocol);
> >  protocol_init_fail:
> >  	cancel_work_sync(&ipc_imem->run_state_worker);
> >  	ipc_task_deinit(ipc_imem->ipc_task);

> Calling ipc_protocol_deinit() here frees the ipc_protocol structure.
> Since ipc_task_deinit() has not yet been called to flush the queue and
> kill the tasklet, any pending tasklet may still execute.
> 
> Would it be safer to place the ipc_protocol_deinit() call after the
> tasklet and worker are fully destroyed?

Thanks for reviewing the patch. I agree that this change may introduce a
use after free since we are freeing the ipc_protocol while tasklets and
workers are running concurrently. I'll fix it and send a v2 patch.

The same UAF bug seems to exist in the ipc_imem_cleanup() function.
Will send a patch for that as well.

Regards,
Nihaal

