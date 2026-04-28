Return-Path: <netdev+bounces-281629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCNVJ6xD8GmDQwEAu9opvQ
	(envelope-from <netdev+bounces-281629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:20:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 401EC47D84F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D29A30087C0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D4274670;
	Tue, 28 Apr 2026 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWdGmtb1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2781419A4
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353642; cv=none; b=LE0EoIDLAL3JBTnX1I8JAg60B5lSaP1dPBzNCdCOcWi/fNpa2SfMiaFvLpT05PC540HzyoThYynwSYQewkTu1ECc9614ccxdDNmDnTj8GNNhEndKynSFsdXPfyzBcIwW22F3xfaTkfsAq4jytPlRYrH6pHeJWp0J25Gum3eCNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353642; c=relaxed/simple;
	bh=diLJgi8run2/wJsp0OAzZ5RK9Xc5Th3Fv8M6vhyCDcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ap7ScYddi65661Tf35LHrTyaqJhqrti1gIBOWnGnvcbDONBLenoYCsswEZVPmbtesAywwCtBZoxnQA3lc/x6i/uGZhJZqA+DJ/PKuBa60cY3xD+ZlMXeRjD648ThPp5gzbnUPPItUvTgfe09ihrnopc0CWWbQ3/UP3a61/6/cnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWdGmtb1; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12c19d23b19so14285711c88.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777353636; x=1777958436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PKBzrou/LVFD4QeWnSpA8ddbWuSRTyEsVeaGpL3Dyo=;
        b=HWdGmtb19fVMCodxvHwZghmR82ky+hezkv9EzjLzoCut7Q1StaYN9FfivoVTQQRHwp
         7ntheFeCQ4NiRr63TaXLdtituYFgOyRiAsYMzikMxWMTMrqOLthaR2W3/pFJjvQ55MBJ
         BmFy1LDdVLr99w5C2/Xc6IRfzAlEVVaXIBGm0WMkzO+qDOAp+9oQc/Yi6uLpf7VrjOQB
         v22PDrDYlpLjw1oHRu/0B93saQuKg8iVNDhPQjaD/eJg/BBFytEst3MInny/ntBpVGXS
         cOhZZk1BiuAlgKJNJ2o8uGQIBxRL+dt+CMj6rZQ/0GN9Hvhes5vV9iUViCEGlqxz9YWT
         AAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777353636; x=1777958436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PKBzrou/LVFD4QeWnSpA8ddbWuSRTyEsVeaGpL3Dyo=;
        b=ZnvTBTNH8e+H1/kN5L/NZFpEXD+PK8QhrYCbJCBtfrum9/KcO6h0P8TZjwpV22X2HP
         r4e3CpiD3i+z+X3/uaw+pjRjVLiQ6D4PJA0UEJwajzJ7l96iRrjsSnrhnzhMOwkU9qF4
         FPlNPQgxcAPBs7AS1HDjKwQnC9ga5E82V8i71LNcMWX5Ace4eXXvjkXA61661otgzpd9
         W62b+PbkeoJuDnWIEabqgrV0+vi3Mvtj9LkYibCEJghET5KaOFEBuTRqJWlRPAROkK3F
         V5Prh3G6eVks5ni6ArcRoE0/ruwYqT+TyJOVNaSsEfEJ9uKly8jnFO5YtgXbZJNs65X3
         NViQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JzytCvUzi1aFirtBctVrM2l7OWYU6HjapuHfggesRbIsiayipyMk3KAFkmdCwP5Lg1GAzciQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWAjNsYBUCX1Xmu7Sq7bqkaEBxfOC0rXRj1syGTT3VLiqkBwN
	3uEyAWj10Qx+vzXPunCP6KHHd+H4ld/nsAEYBUYe4sjRwt1ZTg6tz7ud9nvQ5EEG
X-Gm-Gg: AeBDiest+pDXz6YhO45WPXNFhukaX72b/elMF1U2qPvrCqerRHFO+YSdKtj0+oFTXHL
	iYBSbtGuxSSITxZIOl0Ih9MfU32t6pVjzUWjajazG+GpRDOllrgixBuELnPxgBjKDg1SrltfpdZ
	B40npMxBWsFOA1mj0XAOLB4JOrtLq9o0GqLzAnTisrd4rTFWbHPlq2w4HFYz6otmhJx24cTbqK9
	+37zkInvTHOL6a3MUf3s4KGSzh34YbJShVy0Y1uROH0CQ8W6dz+xjJGtoHwwQ8Jfzi+gGD+IJAe
	8d5kG94FYaUDapUPtsytO6fPSRHI37n7XvmNns1ihWIyVPAHmzl1pj9BbVs6OWumfKKhgz0ZHMT
	qxcIWtALXeD3Q6/oYmHQ+k4C4sOLVj8hy18pH3krJ+zwgdYtqWgf56RcaTVMtmKyaubZS0/NLlC
	r8hoxyir0/UvJXfKEHaFdA0QK3qVPLSo4FdObC1PZHp2iuQl2aXz6Hp8XselV3210dCy240PBnV
	gERAic/paGxKw8jAI1MQhP++RjSjemb7F74/u4Xak6Ly/X2+VjJYhgz1rkCaBZXjGlz3TppLEE8
	s8YYtCJYx7H3KhgCwDib8Iz0zj19
X-Received: by 2002:a05:7022:3885:b0:129:fe5:117e with SMTP id a92af1059eb24-12ddd9b3cd2mr697882c88.26.1777353634205;
        Mon, 27 Apr 2026 22:20:34 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd933044sm1355064c88.5.2026.04.27.22.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 22:20:33 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: macro@orcam.me.uk
Cc: andrew@lunn.ch,
	enelsonmoore@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] docs: 3c509: remove note about card detection failing with overclock
Date: Mon, 27 Apr 2026 22:20:03 -0700
Message-ID: <20260428052003.66510-2-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <alpine.DEB.2.21.2601260039220.40317@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2601260039220.40317@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 401EC47D84F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281629-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi, Maciej,

Sorry for the extreme delay in responding - I somehow missed this message.

On 26 Jan 2026 Maciej W. Rozycki wrote:
> -- so it's not about using a time-based vs some other kind of delay.  The
> comment to be removed was only added along with the whole document on the
> 3c509 driver with Linux 2.5.13, much later (2002 vs 1998), and therefore
> still stands.

I traced back the usage of udelay in this driver and found that id_read_eeprom
did in fact use a busy waiting loop before kernel 2.0.14:

https://github.com/schwabe/davej-history/commit/8cf64f0c94dcbf029dc3b12cb8e2afba590f8f72#diff-9acb56ec07fd10ccce51b1dc719976d60ee5a947dec31174e2a96f871fde72f9L331

This is probably what the comment was referring to, and therefore it is in fact
incorrect. The documentation appears to have been imported from the Scyld
out-of-tree driver (the basis of the mainline driver), which still mentioned the
issue in 2003:
https://web.archive.org/web/20030605134029/http://www.scyld.com/network/3c509.html

I was not able to find a copy of an old Scyld driver easily to see if it was
affected by the issue.

Hope that clarifies the situation.

Ethan

