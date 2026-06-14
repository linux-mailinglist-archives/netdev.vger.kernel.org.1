Return-Path: <netdev+bounces-299179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i/zgEtJkLmoBvQQAu9opvQ
	(envelope-from <netdev+bounces-299179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D9680A3F
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:22:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CnzdlwBn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299179-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299179-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 315263003EEB
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C6F27A10F;
	Sun, 14 Jun 2026 08:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98E2F3C0E
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 08:22:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781425359; cv=none; b=kq4PZVcy+zFMI/an8gczD+Aqb/vEluyJF+m3DiYjmR/PYCSsyXEFZ4Vu+k/60Sk1RPd050i1aWBA8bF9/Tcanskx6KFT0+YjCwr/9+qQfdnFfT1gh37GAFrnqaUydcZ0v3JEEPFTmFZ2C2rtyy2Cr53mbcixjo6BgNjh45KmMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781425359; c=relaxed/simple;
	bh=qb21hqb1S7YZ5BeL08StiBkLAbTGYCv15aAj6D/zaWI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References; b=Tv2OydxzRu2r/y0b6HNHwoNR2e7xkAz5vZL+x/zR6t2r13G5Fqubl0C06SOCKLI9CkZKUKdrFxKyMfNWwVSTOkAdbu0Unw1g2+3qN2+fh9ySAVT33jmqnRSiIHaQYnczKKmu4Tys59mTh2MgF+sun0wOoOS7d53GNKtbTf9bmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnzdlwBn; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c3315c5dso25243215ad.3
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781425356; x=1782030156; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb21hqb1S7YZ5BeL08StiBkLAbTGYCv15aAj6D/zaWI=;
        b=CnzdlwBnp8QscPBXMTa9wQYuWIn8m4BeoEzE7nt8UDMisra/xQXDkW69hOHPggX6u9
         Z9MRwBb6VMhG+H9aJOc/KtVBJ4W6k3mtgNsRutWaGOFUPdypdx9il6TJNvqBaNorT5NV
         7DdT7XuOreua7B6IuOkQ09lADlqS3v8f/gc79IDpjnJMElHQLcYWIoa98imHR4TbONO+
         G29IzdgBA9HHtkLxFOvOUqnQKlsVFVpNREVHWHkyeOv5vIvnd5E/UI4x0DBIBa7+OazJ
         s6+wE6EsT2hrX1wlJeU9ch9llpNFZwSF0ksUIUQNF/YF9YXpdBDlpwXAtRtBJtM+360f
         L/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781425356; x=1782030156;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qb21hqb1S7YZ5BeL08StiBkLAbTGYCv15aAj6D/zaWI=;
        b=YpouxBScZzPqb/zOz9DE8If0WnE7+17WpB90vdrcwawHXTH0dbvLKhIALi/eZUSIGJ
         uIMtNH7EzxgZwJSuRhnlBIlyzYhDmKXqBerAgLjmHYCe8sRMjAaSIQ4znX481mcxMb3w
         lXyDCftRcSOXK5zKTRYDDTUmSmsDOZZiSWRSVptEqoKuQxcqvAfKHjwFGN5hA7MXYeGS
         dbvz627J5PcfIJHvQU54XifMPdJgyOGefc6LEiOJeHG9W1aWScYEBDF5R87Eyi/sy1mJ
         VxQfMKCdoNtU7MyEh7R01Loat4zrEJv5N26C8fssIx7gLhG/2viFxEbUadL1YPvX8BBa
         xoiQ==
X-Gm-Message-State: AOJu0Yz2mQvAy0WhJtC0kKlur4Ph756uYvfTLbetSChmMR75kImBQBg5
	iZW1lHvH0h2Q8LLD83zv6wkcgu4UyAJxjJamRQFkf5VtYx7swGY57mIh9GSywNsuCUI=
X-Gm-Gg: Acq92OGKIu+9sjHAm5N8jdPgeizx23O54xJI10IccouwFo05vcwCNEC29LgurqiJYeW
	Pvbsu6JbfywaMi9eAQPd6imPjY5MOtSR3RBDQgNKkyDs9d4JmOqj085lEUp+W3yP3Q5kSZVj0di
	VZ24tftf6w46WJLXRCEP9wg3h+ZyaREu4EyMnrpsZukiJhQqY+AyvBvjp0ej5jOCdMfQOAa99f+
	axnefnBtZUbzxngwixL0LaUbioGL8vwgKEWXcRPX+HF/W274mbaTB1A4Mzd/SOwdGFXqFm+iFok
	wljT22BqwCKCB57FnRXap+n3wGeaRgO2Opyx7hxgh8tu8uvhSEO5SONufGhb5b3gjuY3nbQfHTE
	pBcxxX54qww+aWZn/S+6gfjGufWyBtvXB1x2x2aJFyEsAQyaiKgplaHskMH44Km/JoqwcbLjSdR
	0cnXkNGhMx1PXUWqhU
X-Received: by 2002:a17:902:f78a:b0:2c0:ab82:6ba7 with SMTP id d9443c01a7336-2c412840b4cmr130549805ad.33.1781425356220;
        Sun, 14 Jun 2026 01:22:36 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327aca9dsm67318685ad.50.2026.06.14.01.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:22:35 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: net: airoha: Remove dead MT7996 NPU firmware declarations
From: win847@gmail.com
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org
Date: Sun, 14 Jun 2026 16:22:32 +0800
Message-ID: <178142535221.1923709.6145590590751458758@gmail.com>
In-Reply-To: <6a2dea77.01c4f138.336eeb.a256@mx.google.com>
References: <6a2dea77.01c4f138.336eeb.a256@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D2D9680A3F

Thank you for the clarification, Lorenzo.

You're right - I missed the DTS-based firmware loading mechanism
introduced in commit 3847173525e30. The MODULE_FIRMWARE() macros
are indeed used to notify userspace for firmware loading, and the
firmware names are defined via DTS for different board configurations.

I'll drop this patch.

Regards,
Wayen

