Return-Path: <netdev+bounces-303272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id efP3BEDdQ2p6kgoAu9opvQ
	(envelope-from <netdev+bounces-303272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:14:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6319B6E5CDE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:14:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="K/hOiKDf";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303272-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303272-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 743AB3007896
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35F72F5A12;
	Tue, 30 Jun 2026 15:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77932319852
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:09:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832184; cv=none; b=F/UYHNSF4rWh4EoS4BkGQhVMNOuuL7WPCLWanrOSYKu+otcZp3r2GkmPQyhbQFkKO8IgfIhSaBgeBOvfr4gfjNAXvOQXfV3P0jcijGFhrDeGs984AW2n9383/u2dPyi5+6k1YUGaWsfuL+4pVPCgR5XINs7He2scVuShBBYmdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832184; c=relaxed/simple;
	bh=4SB7xtE7LLNsmMby+vVxbe3lzN/XHMxMCDPsRtqIgyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=netaieAkqzyZcpcVHo25VnuTYPvPBQzCnGkt1dXV0+45H8MyiZXEAQ1kFQnAUOJtXWepUseqw2yCSzd1izTDqs+8shFt7uU2a29mkKrtepPZg0VP01Ng/1qnM5jgY2J1b1MZ3ZHSkECAM9s1ak8V1eVsvRRo37gZNhhoJv6mlPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/hOiKDf; arc=none smtp.client-ip=74.125.82.45
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-139b5e604b9so5349682c88.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782832182; x=1783436982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iy90YGAiyQKrVGwXUqBi9GraSvwkuFALJaJT7TVoK6Y=;
        b=K/hOiKDf9W3nlTQWw50wIgXstxnlMNVo8vVo/ZVPKOMVAwO0/xktJKCoPn79OTTEt+
         FmTPm3iHHr1RNHWJLBArYhgyuRYXAS5E3vDHYshO0BcfVxlYUQ0A8YylXhvKMbqBp7Sc
         eHHRMM1OVhTaVOVQNcru/4/iEFop+PsnEl2LOfL4QuTqS+YgyEyahaIAJjesfYO/juN/
         FYsPipEY62knYh3iGmDVHBMzhKNSJXPHPNmgIjlTvxZgErzhdOtpieMKHs5a1mEBwHWy
         GLp8iSrbV6/Dbxx28dQXrpoKfL3u3HhJMyCwCz7dgX+VfiP+3sBDNWuP8t6qLfTuL8DI
         /nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832182; x=1783436982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy90YGAiyQKrVGwXUqBi9GraSvwkuFALJaJT7TVoK6Y=;
        b=cr1PGlw+Upu8l4O5uyhdQajOMzewZ6dgqT1lePYDVNlog5y/kPOs6v/s5oPNqL9qDY
         TYaMxv1o1g3GXlecfP3fvWdtr8FTI4c28CRcN5pf2bIV41AkGcjV/exgPD9uDezfzMNy
         xpOrAIM7rzX3hWhqv2GlSgqKYNM5RyUteI2BmbF6jgJh8vAtn6KAxvva9DsE9bO6AEcK
         Glm53I63nLjj+6wiQNjuqULT8BEjaESrynl3NmM+zMZ+qTnfI7Ro+z2IyU7F/PEx2TdK
         TFnzPyeQhCUiHF3T6FO3ukqkOmjsd8bORU67aiSokKzdfjAkEbSKmNmf+9hJAsOz1l9k
         XJOg==
X-Gm-Message-State: AOJu0YwJOxZ9jqOrIPEYLlMsr5Kee4rhifB2Oh0kBUznH2rowyYbij34
	gG2o5YW4SJMiutxNMV0RY5O4zZBANnPLFtldALlg9+Od3JwVXPgpP8HhKkk9yyOY
X-Gm-Gg: AfdE7cm1p8TZQTjPrihQpTuOwDHTA6LQuwpQia3CED5BiUr9tkQ8cr58rM1jj5VlpyU
	B1j4HSG/D6U1xVl9hhG4QiX9ycTao/pTze43NVDUTzI4yEmijVI9KR5wHsv20bW/lLrOH/2TsbN
	b+wdOIbZM265Eaq2gB79eTZwkAiR54CCqvrIEqbAMQa6UDwQgr5Xf/SKcd3KXqe+fIhNnmgt2SD
	XMfPkhcI+bFXPUksGzC/3osoiInJkIio4bply8rK10YofpKKijPuIg5HK9ImmHhVwCfQFDN8n6o
	NIVwJU8ptDJFHwy+nBX/4bBgDRtKC8wUCp+VhUtWHFEtElrEqqVIVq/8VcdVTYkcZPJlGDjngYN
	0R7dP33uGn+JLEflXxfEDiHUJZE/+z5ZpYCieiV64xtpBya74nArqV7rAakwHiTHz2u/nuuE1jg
	UQZe0cosdKPafIn9us
X-Received: by 2002:a05:7022:1e11:b0:136:c565:e847 with SMTP id a92af1059eb24-13b2a1c05f7mr2517782c88.32.1782832182454;
        Tue, 30 Jun 2026 08:09:42 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2a9b425asm11369849c88.0.2026.06.30.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:09:41 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paritosh.potukuchi@amd.com
Subject: [RFC net-next] bonding: Retry updating slave MAC after a failure
Date: Tue, 30 Jun 2026 15:09:37 +0000
Message-ID: <20260630150937.3508222-1-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303272-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6319B6E5CDE


Hi all,

I came across this TODO in bond_set_mac_address() :

        /* TODO: consider downing the slave
         * and retry ?
         * User should expect communications
         * breakage anyway until ARP finish
         * updating, so...
         */

Currently, if the dev_set_mac_address() fails on a slave, we go
ahead and unwind the bond and its slaves.

As the TODO suggests, one possible solution is to try setting
the MAC again, after putting down the interface. This is because some 
drivers may reject changing the MAC when the device is UP.

The solution I am proposing is as follows:

dev_set_mac_address on the slave
        - If this fails, temporarily stop the slave - ndo_stop
                - If stop fails, unwind
        - call dev_set_mac_address() on the slave
                - If this fails, unwind
        - Bring up the slave by calling ndo_open
                - If this fails, unwind
If dev_set_mac_address on slave passes, we go to the next slave


Before working on a patch, I wanted to get feedback on whether
this interpretation of the TODO makes sense and whether there
are concerns with temporarily stopping and restarting a slave
during bond_set_mac_address().

Thanks,
Paritosh

