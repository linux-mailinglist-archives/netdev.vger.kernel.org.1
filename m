Return-Path: <netdev+bounces-306984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vGHeHdENVGqqhQMAu9opvQ
	(envelope-from <netdev+bounces-306984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 23:57:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9230F74614C
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 23:57:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=RZHLJiM+;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306984-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306984-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A56933001F82
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9937B407;
	Sun, 12 Jul 2026 21:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6ED37A84C
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 21:57:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893451; cv=none; b=rOxF6UfwQAI6x8nCvtGOXjzey2TrpdLDM3noicy7A6wIlwVk5pu27atapc/SFFTwytkgF4XMIJKg2JEGpgw9/x+/VgYqr/qAA0UBIzRSpgyC5UxpmTZQgijoUEv47DeLpu1nvH86ubbxOZbjIgjHRh/69QfN+xhlHsFwsCQBzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893451; c=relaxed/simple;
	bh=K4mSZwTp/u7hydGX0B9HMeu+jFvEsCWuLWVpwuqs11k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k076i7BloB//P/I0xjjszS5IDZuiPCoDllptTviqbXiztVcSpXGG2xrF3r7q88VxI9lEpLiv1oVW913ZAyB5Z/jkt4ASa+h/ZU/NIu+ijfEpGg49WAyUkB602c7MA9bkfIMsxVVR7FWNdiWSLTxNuMlwR876FbJacKHffG1t00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RZHLJiM+; arc=none smtp.client-ip=209.85.161.98
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-6a1160a2c42so1641816eaf.0
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 14:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893446; x=1784498246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zyr6YBFmBRz4cpGfkF4vKmM2rz6RRnkLotsCwCyQb3w=;
        b=JOedl1ClFrurnCzTZNBak2QItJ4QNJmEI/4jO+dvXfn9aqaTLiPdyL2ImCIY7VL8K0
         Jh6pb1EJtTzLergxMb9ypljY7cuFa9O4UOoiu7GuhxkDdPzDfryF4qHxB65aEhhsamFL
         4Z+Ea+Ctul7SpEIkB+p3IHqeMgWDxfA0vwGkdfSsqgvJpbRdrc2h5ypHOrTbQPoe80ti
         p+aVEiH8oRh/eq5AIZh/o0WcJZSba/NvGgpsRyJyCFPTWC0snAw5woYUEnQHVBIs4IrY
         ipri+vQK0Q9QrBHKVKAwmmGbDSy913nUoHHAV3XfxWdOWOeXJGNb80g0RDppw0Xv/lEi
         mThA==
X-Forwarded-Encrypted: i=1; AFNElJ+I9ygWpWUVpuVs7sjD2XUzMAxmRMsb32y6o0lWeehk6gJHmG6+a+FEJlF+UtPqUZ4ucoyfN2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfQf/cI6hkmj9RuwxkROg5lxLtsLM5gioImZql6lD7iRrGJ/3
	niyTQf0t9oRd8wZe3NYzxP6uquwyw8fhoEwKZdRNYG/931bLEY9apWN5Po/5c0VEjvt1nTlTBxl
	mmHOJTANkil58+kEkdBjuEQX31KDAKf+Rm6W2eGU1/OzoetEfzqQoZeva3mgRZOiOrAdlHlvUYz
	AD+YSrX2chzvNrCAiWNjUqy5gCJ2sMUUt3gLTtPlYcFdiWX5JBjF6GisDuGAZxr23bXT5iARNAX
	cKHtTwRzz0bbJIkyw==
X-Gm-Gg: AfdE7ckJqcEK8CJGj488EwqNqFcArg4vpN04iV2leKjkd21zyVzEkuRUmp/1n0CZljg
	yFQIlIJ2TUdLGTf8zTXcu8O2AgVCG2hayeJL7HqGtUbLexoTbE4gUXGD/Uu1Khfm60BdTTWtQRq
	+lJh8V3LJEGE56SJQmyXs77UryIv0BYwfld+g2n5GmzdQS0fY+EdjQ14YcCG2W2dTZdtK3Fq2Sd
	nVfLTy4n6kTIYxy1kKkZxLzcC9s0WQVO6TEqHy48sa3WNntwbad74NQQ6H0Kbm3OP1QI1KQg22l
	rm4ggfGTM4vj5FiAvroNqAA0krSHv4HrA7p82XyTYd0gFlJEhtz01dgOv/wmbZK89Xs1Cfd5Mis
	KXjUMLFmWSvraSMW6/nq1Ld2wHuDyBVZcudRzaHKztom3cEUQm69TChxOd/U2oODR1WcKVa5s+L
	OoFXW3Q8VyM+qaJM5XBkvAqCi/6bKTrcgj7uUAqvhqPxUwgTDK70ye
X-Received: by 2002:a05:6820:209:b0:6a3:1dc5:3570 with SMTP id 006d021491bc7-6a39a623860mr4243288eaf.31.1783893446375;
        Sun, 12 Jul 2026 14:57:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4519134e08csm1085530fac.6.2026.07.12.14.57.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2026 14:57:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38db4fa2e25so2942131a91.1
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783893444; x=1784498244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zyr6YBFmBRz4cpGfkF4vKmM2rz6RRnkLotsCwCyQb3w=;
        b=RZHLJiM+z1ARcnvgMk2ZB+irb4SSQLgf/7cyDkG+r3gBG4FP3hMgEeFlKvYlrwb4Cr
         zdT1HNVLczw8yg2YU5/rTvpWFxf5P1IPslYZCZpdN2agIjBGh19awqHVI0Y7+kZM8Fg1
         Y83Cqb1X5doxo3kv2JR8r6umCaYIU3mU8FNMY=
X-Forwarded-Encrypted: i=1; AHgh+RpOymfwsIBOzJJZkc0y+oiNr/2DtcnRPNt+nnwVwfR+IJWYftOkGAB/vSe3zV2oj9Aqq4vN/9M=@vger.kernel.org
X-Received: by 2002:a17:90b:58ce:b0:37f:9ce3:ca96 with SMTP id 98e67ed59e1d1-38dc777c50emr6691030a91.31.1783893443854;
        Sun, 12 Jul 2026 14:57:23 -0700 (PDT)
X-Received: by 2002:a17:90b:58ce:b0:37f:9ce3:ca96 with SMTP id 98e67ed59e1d1-38dc777c50emr6691003a91.31.1783893443371;
        Sun, 12 Jul 2026 14:57:23 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm29930583eec.7.2026.07.12.14.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:57:22 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>,
	Arend van Spriel <aspriel@gmail.com>,
	Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	SHA-cyfmac-dev-list@infineon.com,
	Wright Feng <wright.feng@infineon.com>,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
Date: Sun, 12 Jul 2026 23:57:16 +0200
Message-ID: <20260712215716.2170806-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709101635.103005-1-fanwu01@zju.edu.cn>
References: <20260709101635.103005-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306984-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,infineon.com,broadcom.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:davem@davemloft.net,m:aspriel@gmail.com,m:chi-hsien.lin@infineon.com,m:chung-hsien.hsu@infineon.com,m:franky.lin@broadcom.com,m:hante.meuleman@broadcom.com,m:kuba@kernel.org,m:kvalo@kernel.org,m:SHA-cyfmac-dev-list@infineon.com,m:wright.feng@infineon.com,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9230F74614C

On Thu,  9 Jul 2026 10:16:35 +0000, Fan Wu wrote:
> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
> drvr->bus_reset, whose callback recovers drvr through container_of()
> and dereferences it.

[...]

The patch does not apply cleanly on wl-next/main -- a rebase is needed.

I looked more carefully at the cancel_work_sync-under-lock concern that was
raised in the thread. brcmf_core_bus_reset() never acquires bus_reset_lock,
so there is no deadlock. If the work has already started when
brcmf_bus_cancel_reset_work() is called, cancel_work_sync() waits for it to
finish; by then the reset op (brcmf_pcie_reset) has completed its own
teardown and reinitialized the device, so the subsequent remove teardown acts
on a clean device. The design is correct as submitted; only the rebase is
needed.

Regards,
Arend

