Return-Path: <netdev+bounces-290858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPqLEPBsEGqgXAYAu9opvQ
	(envelope-from <netdev+bounces-290858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:49:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5905B6751
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE6D1311263F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031B84657F5;
	Fri, 22 May 2026 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j94QVq2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593F423156
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459945; cv=none; b=ISnIiA2T+22Bd6PebU+jQQPWoRWThz6fZM4uQxKSsCXqcOM15kbFQECPD0y0Wjsoy4mtrN3N8gBAQVzjoHEgBGOgtmFh75+Nw/xq9POJn19/iI6pnwhFAXxDZzPxLMK0U/Caez+KSVzPovZI8H91MtAn08NQnhiPFqhAsc+unU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459945; c=relaxed/simple;
	bh=2OXLoXiVgy/ua0GDhpA4hbQujGAsgWB97gc3ROPIoug=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Glm5/3UTRNrLE90Ne5jMZeS6N8efBMdYrl1ThSgM4+KnPP1M1cW8xoTIuiNXz8/uNNWzziFk4Qiv6K6BDal0FSA7QP8FFW1WHrvyCqkE8p0UsAGKkGic54GJdhI3HUslG0Nd1aLZKmIf9e8Z+qvtHvIGYsOU/Nug0zUeAzq1ci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j94QVq2o; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so8000785e87.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459943; x=1780064743; darn=vger.kernel.org;
        h=subject:cc:to:from:date:user-agent:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ZEJ3kk2ABpnr52AwVZdvGSyYDVWEUOXVkXHjXX4dg4=;
        b=j94QVq2ocSbPYtjnQUbAkCeNTL7vzdpXoIidRq5XzSKYVhBUVhiK9+229ggDmvaax9
         zzKPIiYSk1VUU/ZZLXIbHp8k8y22zr6kswn5iLWZgOQtGRSP0I+tGalq41mj1kEuNUCE
         13BRONDT8cpOkM/7qoNrz2G5yl6tMG+4gkkO+BoR6PoQVnqQgWVIuqaUknM76/J4JKoT
         fEvUiwH8cQBXKqhsw0f9MXtUjCeKRG18HNtKSnW1IPb7V6mCSYPrBHrpuuDzfKBIVtxH
         H1Iq3WFmcfIseJJR52TBD/b8f6AJ9NMajj945zCutbb62uIsvG8H2v0szA6GSHM0wzFD
         ouoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459943; x=1780064743;
        h=subject:cc:to:from:date:user-agent:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZEJ3kk2ABpnr52AwVZdvGSyYDVWEUOXVkXHjXX4dg4=;
        b=ZgSD6Z4TgvfCoUC5LgeJt537cPf9bSFzQ06StJzjxxeCcIjJXF7ZVbilWedbTNS6iv
         EfwVUD8IPYHtqQZ1J5grnXxTwCl3neirAAAV/EhmTEQdQeKAwcVSVBcFuzeIAU4sZWqt
         h25/KrHJ7ef69y4Avxj7Z2/35lRiYljID1y75EsuJJVc37ndl0SpUkQA1G6S5ZXWjUgr
         mljrSLAwGykZZO4+frQ2tt3Vrwr/wQEEXxkPV0OiD6cz6i1a3FIuGY1EO/hnzGzudbaj
         w8ldtWmUtaQ6gRGKgoinsPEJDX8swT9k2fL+73VrzGNGpWxaquWWdwJ9mkIBo0Ho/cMv
         dOZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9or5sF/P9O7WgEWFJdjvwD9IjwEUAq2gz92he6WDU+e3m2NgLtXLHYzpctYgKSddYRHgQ3MLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ZSILMtLP1ADOn0vCCQQIftm875VrhLX3roqWKSTBjvq9JFnM
	tJQtu70olCHgi/GVceZvHRPl0IwMYK8uYzs+dx1KUhSovmRkadgZ1sAHa20oNw==
X-Gm-Gg: Acq92OFfQeziD1F4kGRxq47o+Sq39jDk+ISVzoc0wNRG6zkR99wdvGw/PfwtiA3X3VU
	cTAp2zLLmIYP+3QJPLkhmcgB/+pc7tpA9oWztJF3dOXq5AmoeQCApd5rIQHq1F1kirUj3J8vCUN
	QN21ej7pzEqOT9KKUoP911oATtfRL7k7IdP6wjs9eReucxg35PlGqJJvFSiHHOJIaD0RJ9upmBC
	YozrGWvoQKjChBL/Toj0c2YZVQ3pNZOQhOOiV4FdXjXr/9c2ScYVQi7Dap/g6MVThDX0qpND0aI
	4AmaS75p9H9/ZXWAkdrXsGWhKN0dunGOdudnMjjZOVSNWrLF9A06XtxlCqGOg5m1yrep8pGk89n
	khe2OLq/L13HXXMOw9cNFM/GZzGkZ5Pl8uc6TbMJB2AjJhUhU+pScg6PL4HpVt1HZJ+Nne+rhl3
	Ro8yFBuoOJmd+V/5wR6mPJjZNRw7pz2cH+X3Hg
X-Received: by 2002:a05:6512:1243:b0:5aa:116c:4127 with SMTP id 2adb3069b0e04-5aa323a9065mr1328700e87.41.1779459942469;
        Fri, 22 May 2026 07:25:42 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cba2eesm446618e87.25.2026.05.22.07.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:25:41 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 2FA295A0202; Fri, 22 May 2026 17:25:17 +0300 (MSK)
Message-ID: <20260522142239.628965142@gmail.com>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 17:22:39 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
 anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Subject: [patch 0/2] ice: Handle nits in physical card removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290858-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F5905B6751
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the series we fix a few nits in code when the card
is physically removed from the slot (thus we're not
supposed to access appropriate pci space).

Prev review is here
https://lore.kernel.org/lkml/agQ_xZUp3Sq905O_@grain/

	Cyrill

