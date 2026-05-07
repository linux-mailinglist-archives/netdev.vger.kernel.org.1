Return-Path: <netdev+bounces-285394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMSFMESx/GnlSgAAu9opvQ
	(envelope-from <netdev+bounces-285394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:35:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 678704EB268
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C452030087CD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A93EFD2E;
	Thu,  7 May 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZCfRbnZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0771D5ADE
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168130; cv=none; b=ecJHUocw3kigFPUECXkkcyNf6dHaS2bAfm3TfJEdZAUQ1uY7h5Ply6zZC+xcj8LsUupX/K8WASnDNE6YDC8qh8vmMiwYVrfHlxMVc2AuROZtaDeA92ukDk0E439MY2s5OYEmQZhMHp7YF4ROApu5O4+lt0+KeawUKjDbbqTjFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168130; c=relaxed/simple;
	bh=Pf3cEONmceo9EAPIZp1eVwPY624ZEYL8N3t3BTs37aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv86mS0rrZf5up5Mp+Gh0RPGTuJIYfUvlLQywzfsZ6DyBBWvWsJuU51VkSS2K8HiJk95K66sd8zsD/ZgLj5LmaMHjQhFXiQgF+05QZT9p3sYGDlRK6nUR4S+gFQtMPL06Bp/2Rkw9QIX7Tbdj5+UXU4eWG5C7GDogw/J48DtekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZCfRbnZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acae26e564so9496156d6.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778168128; x=1778772928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCGA1ZpwQj/GZHpiJE1rMqROq1Bndf3dTrA4o7QgiSI=;
        b=hZCfRbnZTzbhkugEH7npCsS/Lu+0i3JSfjt0JsvrTyzeerLxNgbGdII/E0BX54Yio8
         06btZy4oBfGKAaATqwUraSilSXkwd2YjGNhGbHdgjrEo1O9pRFeObzG7BdSJc9gLDym+
         Y/9rt5f1F8Viu1jXL7qkdAtDV7SF0rNgV3gyUfMcFXdzlupGLuf+SeX8sQcAAy+I8b7W
         xPKun1c72J/mf+ZPXjXCTH1qCGxGPlm0f7zxDyBo1mwD94kykg4P4PsSbgT4U8hfYraX
         Eb5k6uwhAPq4bL0/cU8SZkkoKxCOTT5V/BhhcULwLncEQ+mUPG3W0fn1jRY6/edHbziS
         bjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168128; x=1778772928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCGA1ZpwQj/GZHpiJE1rMqROq1Bndf3dTrA4o7QgiSI=;
        b=V+LCn34Ot7I+jyDF0xA0T+6K5d+Tivm79AIxf7Y8zMnaXrO367uFNFatL5bQh+sNnX
         doFNovNDGxAI0eMCACtpe0HkKD5iyI62Bnk+dJZoXIgjyVK6TnCVC8xZEMe0v5yymvTi
         ldNEAWAurzI+GAdw0JOV/e85rHfCIg8tTaChcQhVa/0zXVbogHaYFxalQ6/WqRUCPoIW
         DMnkseO0siWZsQq6Xq1m50DM3KpBel/hmYTORApJBifaUH+LBG3vwYgbaCLHNqa30eU4
         929Ux8bliILlrAKobdhuLtuYr/LK+mafALgp1p5Z3eSr1fDqzVjzHeIrOxjwrYcEKCe7
         1Vgw==
X-Forwarded-Encrypted: i=1; AFNElJ/03J9UwF3ityDbJowN8MIMpvDcX76EpRw1/J7IUbl9BRtQ9Zhy7RsBCgP8qiTKMme1LvpNx0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIaBaDRUMrqQ7hezDpUSNfbLq/YeT+JQoVh53c/oFqA6umLCg
	XvFivxsA88dX5x8I8lMuVrwoCD26pqI7T71ZsR152fhRbZ4M2Yx27oEZ
X-Gm-Gg: AeBDies3UcyYGVVD0IqFodjgP/FdYlcnTbfQFqCLyPg/n2VdhWBovWETZcFqbTVec19
	per/G0LpvvHcgvDloNy5Mt/RtExDmeB531GhErO988wiP50pZ6KmObW6LKEkHkthSpA44Thl30A
	9ExMfxv3mlJQGpt23k22Vlk/u7h+AkBaKZ56WWjMxmVCrnP7YXwAx4PLGomCmNrcZ8DEQToT+0y
	zHp6Z54l2W4gxSd3Yx4H5Z1fUY84IGgKFj8cQAm539dCi8XBDjq79LC/tl2BdnG72iuC8Hwa+sP
	Xm3X6cRJbgT/G+r/sP0IQtdklV68AKzHBr2ok+90qo2Po3szwBocxDAmorKHaN+JYMZoFFmUOM4
	jJNDSDq9hoYQNsQAjaEyuTrBV6y5Z6pOkFKmOUR2KBaPu30wtB68VT7NSx5SOKxPa0wuLoAdwYC
	eXY51wKE5DgDjbw4xSM6pco/9LsVsL4iuA8ELavwQVGO3sLiXFYKI3yqwGG7xJSiielw==
X-Received: by 2002:a05:6214:5901:b0:8ae:680c:81cf with SMTP id 6a1803df08f44-8bc43620490mr133080686d6.21.1778168128237;
        Thu, 07 May 2026 08:35:28 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8092sm228462556d6.34.2026.05.07.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:35:27 -0700 (PDT)
Date: Thu, 7 May 2026 08:35:21 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net v2] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <afyxOaFhFzEKDK//@devvm29614.prn0.facebook.com>
References: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
 <6cec0c03-5bdc-4131-9899-bc5c77fba198@redhat.com>
 <20260507072453.5eec7051@kernel.org>
 <20260507072954.263ae8dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507072954.263ae8dd@kernel.org>
X-Rspamd-Queue-Id: 678704EB268
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285394-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 07:29:54AM -0700, Jakub Kicinski wrote:
> On Thu, 7 May 2026 07:24:53 -0700 Jakub Kicinski wrote:
> > On Thu, 7 May 2026 12:34:24 +0200 Paolo Abeni wrote:
> > > > Clearing fbd->netdev to NULL avoids UAF in init_failure_mode where
> > > > callers guard by checking !fbd->netdev, such as fbnic_mdio_read_pmd().
> > > > These callers remain active even after a failed probe, so fdb->netdev
> > > > still needs to be cleared.
> > > > 
> > > > Fixes: d0fe7104c795 ("fbnic: Replace use of internal PCS w/ Designware XPCS")
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>    
> > > 
> > > Note that sashiko-gemini spotted a pre-existing issue:
> > > 
> > > https://sashiko.dev/#/patchset/20260504-fbnic-pcs-fix-v2-1-de45192821d9%40meta.com
> > > 
> > > does not block this patch but could deserve a follow-up.  
> > 
> > fbd is a devlink priv, not netdev priv, touching it after free_netdev()
> > is perfectly fine. I wish Gemini tried a *little* harder instead of
> > guessing :| Sorry for not commenting earlier.
> 
> Ugh, not enough coffee. It's complaining about MDIO reads, I think
> that's valid.

It is, but I think the race pre-exists.

static int
fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
[...]
	if (fbd->netdev) {
		fbn = netdev_priv(fbd->netdev);
		if (fbn->aui < FBNIC_AUI_UNKNOWN)
			aui = fbn->aui;
	}


Definitely possible that ->netdev gets freed concurrently with
fbd->netdev evaluating to true... but fbnic_netdev_free() faces the same
race.

I'm open to fixing this all at once, if preferred. Probably need to look
at some of the other fbnic_net ptr guards too.

Best,
Bobby

