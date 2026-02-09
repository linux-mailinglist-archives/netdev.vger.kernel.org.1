Return-Path: <netdev+bounces-257878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCqYH/g5iWnk4gQAu9opvQ
	(envelope-from <netdev+bounces-257878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 02:35:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A4B10AE2B
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 02:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD285300139D
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 01:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1B246BBA;
	Mon,  9 Feb 2026 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnM2bPB6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C382AE77
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770600945; cv=none; b=RI1zfJvH1RxJ2nUVG1POgWPKsp+bDQ5/Dd3PDc9IVX0kDiOT82qTz6QJwOtYOVhLiVS4mtH1bt0e/ArsFyHnnDwVY2R4fPRuPNF3K9vTdwtv8IsexISAi8PPE6Hc53kCN2jxdWWRxsvZKGS253DjFeavPcRH4t3zgYpf6ELmC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770600945; c=relaxed/simple;
	bh=4YbSWlTecWW66n9g7OUno8LlzhDFYBr0aOTF/XVqXcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PV5O5CyvAS6tyVvxUCEk8gRUAu2jyZsXJQ6X3rhnRcf2oQpC21dOuhZiGuc+0KS0idNX2OWQWL7Cuat+X03aMeBMDXQx2zJ37DlAJ+0DIaToeMvvI3kOM3CO3O23kbkfMkuwQuIztBiBITutDIX2ebhugOAuPMdGC3hAMQ4ypok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnM2bPB6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so6187569a12.3
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 17:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770600944; x=1771205744; darn=vger.kernel.org;
        h=content-transfer-encoding:reference:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IzL+CmZy1H8DFp5+kl4EuEy4y0FBgJ5yViUOHf08y/U=;
        b=YnM2bPB6oHrJEBHLkZzxAT5FyO/XAvhcfYH32ua88LBFlAaF4MO0qdeLd1sTqTV+CP
         +iQ83D2OlgTcvbAr/HEg8DU0GkxYqbJc58Gl67CuQgGLc5kWkoKMqDaa0a8DssWbo+yU
         zFdN1/asEfA4BdcLeFxbZXHnseJ2PPXSxT7Gd7BW8FwHGVzUA97M2EYvGgDJcBO3omU8
         irQ1ddz0AS+vbbQLr9cQA7JUb+gpnDUhpRmigsrMxBkDGjWjT0lUskh+YaiWJqL3yCFV
         mbEbu/eS8UH1hqKFgKbc5smcmsVqNqypnUdwge1dPs43umm1pCkk4BNwHLKBeO9zgZ6h
         3jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770600944; x=1771205744;
        h=content-transfer-encoding:reference:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzL+CmZy1H8DFp5+kl4EuEy4y0FBgJ5yViUOHf08y/U=;
        b=ZbjpNV9ft/7gA1PihxjUp7vRy/T3wXhf/3CT0KnN4t9Scr601juwg0Oom/p/FAYhrD
         zkGnbH8e8SLWo8qPT81VHbx0+xdUtZj5B7RMm6HX/hGnQcHKyTZ+GhDTREu72GrMaL2k
         yB4o8pj2o6VI8VWuJx0fUE38Y9HaqswOYaRoU3G5CSfAQeWCWpHNxDqoRZYr91lPk+ut
         sGBNK4OTa87FEeclzZaOJXbSXwqD9RpwMtoKmM4JiV0BEthrFc77ojLXlg2Vkzf//gck
         fvzsu3JG+ZFNOUpvgVgUWjffKL8tu8cytN3QDCE1JRPW/X7eu6Dk4/HX9HoSO6plq1bj
         yhww==
X-Gm-Message-State: AOJu0YwnrEl8oF5ka/3+Ka552m60/EPkcYeaXbSY6Y+QjvBCBUV8mU25
	xqT9D6pWvGH6iCCjtEYm6sKUd5agcdHAUczr1oq+uyGJJ+toEJ727qg5
X-Gm-Gg: AZuq6aKrH0XOnasMI0QST4AhEmmVq1ldetvTzy5TcDTmBnI1mm9Vz4Tcvtwxa9dbehw
	zbQf5hAB53Ex+Jyv2CrJlR4aGUeUTNf8APSx+as903TPtZS25w4gMOHRQO0gLgDRQE0gcNB97Uc
	ScjNnM+qDag6DtJYS5Jdr/0Tv/zWBkxJh0rLVWE4yBoRezR4NONmzMLavQn+hAaRqz8S62J3YLp
	WaQXpX2Wf9o2x0vY4jYQ5RHVX10nAnTZ9HXoYzdtCHT/UskfepTXX8YNtQGeRDaJCuvUkdZlZb6
	kgYDvTMuVMxwpMRm7iOnMmWNwbmNjCsho9AW11WDV+FvSQ9Yhh0DqdiOPGt2YrTr2+xDNhOBxdp
	lG23yIad8kyakJ2/ZvuJKXJEWwLJB3IKSJfssMfZZbCbWlQBNuyzSjOkLA+mFVj9gIdM=
X-Received: by 2002:a17:906:6a1e:b0:b88:31c1:c770 with SMTP id a640c23a62f3a-b8edf174362mr570406066b.5.1770600943516;
        Sun, 08 Feb 2026 17:35:43 -0800 (PST)
Received: from gmail.com ([2a09:bac5:4e21:2705::3e3:36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda74a578sm326313766b.6.2026.02.08.17.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 17:35:42 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thierry Reding <treding@nvidia.com>,
	Paritosh Dixit <paritoshd@nvidia.com>
Subject: Re: RFC: stmmac RSS support
Date: Mon,  9 Feb 2026 09:35:25 +0800
Message-ID: <20260209013537.19052-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aYd4BkAeNW6d0iIC@shell.armlinux.org.uk>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reference: <aYd4BkAeNW6d0iIC@shell.armlinux.org.uk>
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257878-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 43A4B10AE2B
X-Rspamd-Action: no action

On Sat, 7 Feb 2026 17:36:06 +0000, Russell King (Oracle) wrote:
> Hi,
> 
> While looking at the possibilities of minimising the memory that
> struct plat_stmmacenet_data consumes (880 bytes presently on
> aarch64), I came across the RSS feature in stmmac.
> 
> In commit 76067459c686 ("net: stmmac: Implement RSS and enable it in
> XGMAC core"), support was added for RSS to the core stmmac driver for
> the dwxgmac2 core. I can only find socfpga and tegra as the two
> platform glues that use the dwxgmac2 core.
> 
> RSS support is only enabled when both the core supports it, and the
> platform glue sets priv->plat->rss_en.
> 
> However, the stmmac-related results of grepping for this member do not
> show any platform glues which set this flag:
> 
> $ git grep '\<rss_en\>'
> Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst:        int rss_en;
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:      if (!priv->dma_cap.rssen || !priv->plat->rss_en) {
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:      if (priv->dma_cap.rssen && priv->plat->rss_en)
> 
> So, as no one has decided to enable this feature during the intervening
> six years, is there any benefit to having this code in the mainline
> kernel, or should this feature be dropped?
> 
> If a user appears, the code will remain in git history and could be
> restored.
> 
> Thoughts?

As someone who has worked on both DWC GMAC and DWC XGMAC, I think the
whole XGMAC code needs to be uncoupled from the stmmac driver. They're
completely different IP cores.

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

