Return-Path: <netdev+bounces-290230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7fnjMCN4Dmrc+wUAu9opvQ
	(envelope-from <netdev+bounces-290230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 05:12:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C08D759E4FC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 05:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9501A3008FDF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D7383329;
	Thu, 21 May 2026 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ59Fycg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF2374731
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333139; cv=none; b=UpSEihdJ66qhuqEwCrbiAr7LBEG/XlyqaNnTO95LyEgKpflfUl5+zVhIXp0E3WRXxEHrNfFR4WkDrrzwF3YtXsPxzCrzQcKYzP7AZlRIDUNXlomXCS3+b/3Tsx25vmO/BTkIYq2Zw6pDgziYwru8o2VAt+u9P+1mOAjjVa15yrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333139; c=relaxed/simple;
	bh=8wKZIV3M9dAvChZqriseN2eTo/lDeIhoPS+0TO8df0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/6aWoovlnb0WISznqfcdU+g1qFRQOVTe1dQAcyFg5NdAvheLW5SwwkRbrRHkivqpuZHaC/BnuYJdBCyh7ylNi9QXQ5i2ujg5b2KpD+ItSAPiBl+Ze+un96PBS92+toJdMigtwZU+HN3GXC/aAVguGgSbTTC1yB6GoVRA5PsmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQ59Fycg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so27193915e9.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779333133; x=1779937933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wKZIV3M9dAvChZqriseN2eTo/lDeIhoPS+0TO8df0s=;
        b=oQ59FycgUCDSIM5GHo6gvcWY8Ycnwm1OERb9qNKyIMpkDHrFTZevqW4cF0zQG3rVCc
         FsTLld0sOYzVv8BHUHaViESnby5mIbq+wEJ10f0ptdRqKN6J5YNAKqEsv1WDx+85yDsX
         ifZ/Z6Wi7AwwSgr1jRE8RoHN0iikE+rX3DRL6/ihlnAK+gfa7/H7OKuvAhBgyywAiF38
         bksyfq8TUHwha9ETBiZr5HYakxhDYBi/Mab5i/QqHLYU6vve6LIbek0OuyLa3/FEvEo9
         wcULHA3PYpCzb92X1pa99fYFFGYlDfF8M0ZceOzpmh6OSM1c6/RRzk8ijOiRNaGQH1sc
         EdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779333133; x=1779937933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8wKZIV3M9dAvChZqriseN2eTo/lDeIhoPS+0TO8df0s=;
        b=Cr0CFQ05y+pavayrE192liG20E+hIs3i/4ImAvl/jhCE5KGhs2nLOGPPGmy/8RD3Qh
         dIv6UGi3g2s1Rga8gHHO01IlS4mG8wCwN7ONACJyxotV3IcpReQiQton7CAePu0Pe9Lj
         FijsoomGLzktoMTygAVJvhucpFpMY67YQNvFGuBEVwtNvmzg2ccyx4t17Q2AG7axA0Ov
         sPAMyMJ/6ngwT3Nm4HnNw+OdQ6yYwyyiH8yPLKpuJi/h29Z7g61+aveYT8VcGxH1Nr8f
         9zUx4P2iSct6ajDKFAMY0eNhGi1SND9tm2Nrin22KunA4gvBuDAaqXf51cKxn229b7nB
         x+bw==
X-Gm-Message-State: AOJu0YyrtvYJMwn78MyePXzQA1zge0bK9Qi95ICtpqnD54Ul28stmlAT
	+UWoXOwTbaQfJtP9kHReyEGp3PRIc0AEZoIIM0NU/pCHwb9l/T2NbJlNGZ1GlxDD
X-Gm-Gg: Acq92OEhhtzyM2f7C/C1TC/eWgdvUMOHsARNQBMbCcFG/o7EBJH7WqS4G8Qz12u4BcY
	mQD5cfGLcIM6dL1x3sD50dHj85JggnH261DjhcQGtdvWCs02flU748SFengV6Aki9dLjL1M6LYG
	PZ206UNc2U3XM4lAOvU8wYMxycmq9P+Pq0pnUQUM0851uCclLsQ7WuGiwcb2UmuuSaraPfKYmGL
	KRfq77c1uATgslYa+wdlpyfQI67ot/M92CTJbv4qGLdKvglJ6ilzO6uJZ9pFsvS/ocY/wLr08ef
	T1RE1FZmNOITn/3Gmj0xN3mQtuwsL0tc8V/AGkbOHuuDs0lK2xsTwGg/YjONB/n4EksjhaJIny2
	iQkbIWsvZ0ArCH+Eet/yaSgV9aKrKg7oDFZhciCkhvD779ZS2nVv+l2liep6330N58vZ1CdZrW/
	uhsXAGTWyPXPKYKb7PfFgfox0zE46goetywggA8g9m1dij+xnc9bNpc/RGDaxtAT033ioqA2Usa
	Fcw0rtiRfeblyoNSoV5+EWL0g9g
X-Received: by 2002:a05:6000:460e:b0:44b:cb31:b767 with SMTP id ffacd0b85a97d-45ea413b90amr1144097f8f.36.1779333132789;
        Wed, 20 May 2026 20:12:12 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm58636100f8f.37.2026.05.20.20.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 20:12:12 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: jan@3e8.eu
Cc: netdev@vger.kernel.org,
	linux-phy@lists.infradead.org,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	andrew@lunn.ch,
	kuba@kernel.org
Subject: Re: [PATCH net-next v5] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Thu, 21 May 2026 05:12:10 +0200
Message-ID: <20260521031210.24834-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260519162007.12345-1-petr.wozniak@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-290230-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C08D759E4FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-20 at 23:19, Jan wrote:
> The patch seems to be malformed. I had to do some manual changes to get
> it applied.

Thanks for testing and for taking the time to apply it manually. v6 has
been sent just now with the formatting fixed.

> Using this patch, the module works right away, without waiting several
> minutes for the PHY probing retry loop to finish.

Great to hear it works on your ATS SFP-10G-T module as well.

> I also have a 2.5G module (XikeStor SKT-2.5G-100M). It supports
> Rollball, but does not respond to commands immediately. With this patch,
> it only works with a small delay in "module_t_wait".

v6 replaces the fixed 70 ms sleep with a 10 x 20 ms polling loop
(200 ms total), matching the tolerance used by the existing
i2c_rollball_mii_poll(). This should give slow RollBall bridges a
better chance to assert CMD_DONE in time.

The XikeStor module is not yet in the quirk table so it won't be
affected by this patch. When support for it is added later, an
appropriate module_t_wait can be set in the quirk entry if needed.

> I am a bit confused by this change. This is the same model name which
> is used by my non-Rollball ATS module when it is linked at 1G on the
> copper side. Are there other modules actually supporting Rollball which
> also use the model name including "-I"?

The "OEM"/"SFP-10G-T-I" quirk uses sfp_fixup_rollball (not
sfp_fixup_rollball_cc), which routes the module through the new probe
path rather than forcing MDIO_I2C_ROLLBALL unconditionally. If the
module has no RollBall bridge -- as is the case for your ATS module --
i2c_mii_probe_rollball() returns -ENODEV and sfp_sm_add_mdio_bus()
transitions mdio_protocol back to MDIO_I2C_NONE, so PHY probing is
skipped entirely. Non-bridge modules are handled correctly regardless
of whether they respond at 1G or 10G.

Thanks again for the detailed feedback.

Petr

