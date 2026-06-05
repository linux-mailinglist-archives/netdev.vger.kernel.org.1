Return-Path: <netdev+bounces-295633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5bZ9DdVfImpsVgEAu9opvQ
	(envelope-from <netdev+bounces-295633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:34:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75A6452DE
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mFoJfMV4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295633-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295633-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 465D43033F68
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FA5375F8B;
	Fri,  5 Jun 2026 05:34:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A782BE02C
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 05:34:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780637651; cv=none; b=hCbGj803ONwEeYlhuRqVSEZvn3asXNhpynIA46BzjPcQVpKNfUsjz+hhZwykhu+vyvwAOBNnhUNSIFzWPtlWW+VQ8+TugT3yoVqGz42JuYaP9e7jTeszLROpZ6NfPP03ofT6nZkRyI/6QypggUJuFjDGVT2d/VLE57MrH+RBo+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780637651; c=relaxed/simple;
	bh=sjXzyZnNDhRfEEmts9pWPcuuMg/BpffNpvk3G1fwCko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9zrOE4x4qbnsAAwf4viC68PTiIhxqT99VdduQYQ4TRuLVJkUah2wiRmou2B/XAh/KlqWf5NR+1mCB1y7m78EfDjB7Hn8M2mDl1av0NRH9jFct3coXECI5fp09Eh5VQpJplqvVrtkWvaWhO8Q1NlsiusnKO3T9OIMTLCSVSeh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFoJfMV4; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef29c5561so828236f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 22:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780637648; x=1781242448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjXzyZnNDhRfEEmts9pWPcuuMg/BpffNpvk3G1fwCko=;
        b=mFoJfMV4LKVtSRIKb04mFAtRI23vbjTcDwiarBEoQQyGYUsUADLqZbMiNr9sn5Hy9I
         xTlKANlrBlbqyYYJOCDGt2fujG23kjQWyKxji6WMe1VsDul8rnhCHCbEzOJ28AeVylJG
         bklJY+Ajmo/ZUW0mL+WIyruLrdThWiwmntH/ktshJlLC99XU38c0l7dSzCYwfhUtOPSo
         MJmsilUqG3j7r0WvmI22lCsi508EIvcTnHRZHRpx7J5df3S/Opt9fKWPaXPUvM2mcowh
         NO6IGKDCmH0fpHOuT4HRtreSoiLC348cXZAplSwlJE6g1olUf9jhQg7lZBtNz1q04t82
         GJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780637648; x=1781242448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjXzyZnNDhRfEEmts9pWPcuuMg/BpffNpvk3G1fwCko=;
        b=lcZEEc8zDucvy2xhPNy9Z/2hd2cllmQYNmQ8ojcKZSBnWfHyj3mnjyH6rC+1oaFIj9
         DNSO+1mIyFdDMbS/AdxQN3wy30ENgFbqJqcAj3eyarLkGirl3xTpznZc6II0xZyIc6Aa
         q1Io686WuGpmR58mV2rVdQeMZeeCirmt9SLTUDh42WcclzHXaVpXub6v1xVxqYAeCyHX
         EkUZNJ5zxTbMoDFW41fzdedkwPRpxOxecTHjRzD/ym2sfIxnv55kx3OGotNcsTKXPwLp
         YsTcygg2hUJxL/cftL3D4oi7ZDLteeTllLrjhob8QWS+SWeL6oxGn+kxvcm0g+PUkgxc
         fFbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p89EEP7k91idxsivYwCnHpZ3ac0BnpCqqErsorPrMhfio88qSh3xNRIBR7Fh7/0UTuNUf6gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIskQ3hkl2cHXuYF6QrBk1S39uUs3QUNkxyqyL93OWq+zWeHPC
	Xsv1FYh/O0LHHYfjAKILO5sqsc5BBAtUlAc686sVe4esqGltINtk+Y9H
X-Gm-Gg: Acq92OFBaSbO4wJElS3IrZqb58t7d88dBbE8C1Uv38g2oyCqiSbtRd7eqPqQiY6gCEa
	2nT+KEJ0/bO7MafozyeqLL/5RWhYQj0Vbr5V8O4TYMynSge99i+RceyrNKST1DQ+xvcErb8VzjX
	eEWHSu6ZBPSI0iay24dmZoDAJkQRScVHfGDM4tdhdzuGd0xPOmedvgZrsYyupgPrDZD07k0RTAq
	Hce05l4acWkrFp/W8l5ocmO6tDcR3wR5FWrWlp9reNcRTQHDZ5+m1Bx40tOkrm4B3NFEZZ+hp8A
	EHCZL+1u1rbxleHKqoAWKexRZXVCA4jggs+AgXkduPNsfq0XQPqKr1MwpoVmsZk2EPEMAjE/MYV
	JOx7t1Av/KE39l8kSY8p1HcivA3aHKyQiFBHAt/LnmYeqjQtWEd3GfCL7CfoHu1YPj8MVjT5FoU
	Ua3LT3wpSKKimah4rmLBBDj7vFKKLSGav8ASGfzIRSvxgPqgTxtulqRLXBk1sNr3NXrvg0Wny1T
	I7LobpuN9QEGaR0OtXf/G/v21ON
X-Received: by 2002:a5d:4e09:0:b0:45e:ea68:523e with SMTP id ffacd0b85a97d-460304fe066mr2555737f8f.21.1780637648182;
        Thu, 04 Jun 2026 22:34:08 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm24383821f8f.35.2026.06.04.22.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 22:34:07 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bjorn@mork.no,
	olek2@wp.pl,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: Re: [PATCH net-next] net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery
Date: Fri,  5 Jun 2026 07:34:05 +0200
Message-ID: <20260605053405.2019-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <19e947e08e51987b@gmail.com>
References: <19e947e08e51987b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-phy@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:olek2@wp.pl,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org,mork.no,wp.pl];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB75A6452DE

Hi Maxime,

Thank you for the question — it revealed a gap in the commit message.

The regression turns out to affect both boot-inserted and hotplugged
genuine RollBall modules. Aleksander Bajkowski confirmed that his FLYPRO
SFP-10GT-CS-30M (with Aquantia AQR113C) is broken even when hotplugged —
the PHY is no longer detected after 8fe125892f40.

So the root cause is not boot vs. hotplug specifically: sfp_sm_add_mdio_bus()
in SFP_S_INIT gives the bridge only a 200 ms window, which is insufficient on
hardware where bridge initialization takes longer, regardless of insertion
timing.

Jan Hoffmann also correctly pointed out that the commit message was wrong
about the state: the probe runs in SFP_S_INIT (which follows SFP_S_WAIT),
not "before initialization delays."

v2 with both corrections is at:
https://lore.kernel.org/netdev/20260605053056.1977-1-petr.wozniak@gmail.com/

Thanks,
Petr

