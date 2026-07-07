Return-Path: <netdev+bounces-305460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pxavErr+TGrItAEAu9opvQ
	(envelope-from <netdev+bounces-305460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:27:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9490971BE3C
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:27:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oa+RZlOb;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305460-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305460-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435AB30F5B11
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49493FD159;
	Tue,  7 Jul 2026 13:21:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91860414DC1
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:21:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430484; cv=none; b=Cgk8f2SBev/oo2binjCpOPLRHvQhQyyPoLcc/IwcihUpes0jrGvZVZXLglUk0RXs1g1D37RQuwvWV67DQtC+BUPvTCENItPu+s21Odhaexmyqk0d661JPy7vIblcrmkqeHXMvbaElyhEwrRBjeu/lbHyKTAjyeT1O/Ii9L7S8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430484; c=relaxed/simple;
	bh=rtpmQZmUgCNU3EmSWk0EHYX4XFD/SjjAi70EAGlVeoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/ZR1s5GjOzmL6MT2WGBVeaiNWi399M/VanW4ZcB6BU2/stzfKeMJpTnGvefmKuHc25g4/gqAjtA1xX2dXnJsu8iihsEzqjN99h+H7yAtX60N2IjnUr9imaE17+EgM+HKHBS4W4W6/yvnxIzndTSfNPSFAaXQNMCgqA6e61mbZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oa+RZlOb; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381891a9525so3898758a91.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783430483; x=1784035283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5LtSiAl7i9grJO+1JbIxyVycs8BLPMdLEUOPt3G9g8=;
        b=oa+RZlObb37512lSbZSkJzmXkp3qEyaC8buSTR+1WcJPGSPOWFnb1rjN/GgQm17YBO
         E0asQ0B1KwPgMBFopEpMVWHdAjcEDBmPO3eGUhLA1LDfeFLLAWs3+dq1kQ6FkQ61YGyf
         2oRlEwejIJc0HKxkuuXI0p80mK2oHWN8c+b6rkAbgIX1reWKCcJJ1dGxvCwNmbBE5ny4
         CNsGwanXw/Q1m/na4fhjbJRn8BKGaOkyQ20OXE1zFIMMGmrqqj9rS0YDzpAy5dM7VmYU
         gZkedzReWHtoSz4j8ABdiTmi/qyD02/k/GUmoEdbvGuAYRe/UZO/GkS0yD3tC6IgU5g/
         wHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783430483; x=1784035283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5LtSiAl7i9grJO+1JbIxyVycs8BLPMdLEUOPt3G9g8=;
        b=kelWKWfGdIgfyqHlUXdhKg/3lVyGbPMz4qS/j7quFKeqCsZcNilaQVUheBz9PQ1d7n
         Oc9uNoG/jaJlV6Nx/kSXsVRx9OVBXnuwJrNbencAnDCZhVPmvgojXdwj/OYu3e4tScB5
         VRcVxi/uQcgiwtBwRcRUuAvA5Fcrfd0MwBHZvOkyRiNBdaKGNMcqTMC85TIyNp7nyqZp
         wASBLghKxPhzE9Po/UGueGnxVRrr0iwzpWnqxwBAyks1yn1UtOwR5rD5YjoXryoIEdJc
         oibPLSIBPb0FzSLXaT2OHcU8DhweJgzdb4ZY2+cOdaaJTInMk0mRykrymguCPqC908ZF
         pQfw==
X-Gm-Message-State: AOJu0YyKLbzrp1HGHSxWeKsgn5tzqstC79RtcjXaObnZIULpwmPh2kru
	klnJWgiVw5XLi6t+KmSq4hv/mGloNBYsgPasy28FC4YIgrVIDqNrAmWTkGaQp2MVrZ7uRw==
X-Gm-Gg: AfdE7cnfwiA3kcQYKdO0m1hea8s2HTA6QlwuWE33rCp/uXDPja5KLnuEZPsah5mu376
	hoO4h3kAqcV1JMqra9/7FaligCiLwQk0JQgCqB6mqMqU8k83owPGL+MoRW5D2kifnbFJn8MVqcY
	Al6ioXAEJ44a5DHTRiv93hazBv2w1Y/Vn3d5dUwFez2PMia5ZRNVCH9Wqyh7ix9VLMsCDAavvdL
	Hfu91j35CWFdR0OtoNIbZh/VBW5wkhCsgTCd4nx+CkGPW7g7fcv6Ho3UNmQRSZ3HbXXPEEtoWkY
	+bkIsT8C47ckBAeWKXq1pTDKXrPoTP/DZ7LsAeZ7LFI+278neXzl5e8DqGsVBOrPUL6ukBDOr8Z
	pPk9F7NXNzbYnz+vo6FKfwdEKIywUiPGvz5KXwANUTJySpt2XFMTjHjJzJKSKN1v5RXb8hAR9gE
	hvMYxR1ly+tfCZ5H0vGPkjJw==
X-Received: by 2002:a17:90b:2652:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-38755573a58mr5016089a91.7.1783430482655;
        Tue, 07 Jul 2026 06:21:22 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:6cd2:7b5:da34:d79b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm8762351eec.10.2026.07.07.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:21:22 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: netdev@vger.kernel.org,
	lorenzo@kernel.org
Cc: aniket.negi@airoha.com
Subject: Re: [PATCH net v4] net: airoha: fix MIB stats collection to be lossless
Date: Tue,  7 Jul 2026 18:51:05 +0530
Message-ID: <20260707132117.94902-1-aniket.negi03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <akwczc23LOGbKfMl@lore-desk>
References: <akwczc23LOGbKfMl@lore-desk>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:aniket.negi@airoha.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305460-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9490971BE3C

Hi Lorenzo,
Thanks for the review.

> > +	for (i = AIROHA_GDM1_IDX; i <= AIROHA_GDM4_IDX; i++)
> > +		airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(i),
> > +			      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
>
> This configuration is not needed since we reset FE at module load.

Agreed. The SCU FE reset clears MIB counters, so the explicit loop
is redundant. Will drop it in v5.

On Mon, 2 Jul 2026 22:59:32 +0000, Sashiko <sashiko@kernel.org> wrote:
> With this patch the driver no longer has any users of
> REG_FE_GDM_MIB_CLEAR, FE_GDM_MIB_RX_CLEAR_MASK or
> FE_GDM_MIB_TX_CLEAR_MASK; grep in drivers/net/ethernet/airoha/
> matches only the definitions in airoha_regs.h. Should these macros
> be removed in the same patch that eliminates their only caller?

What is your suggestions here, I prefer that definitions should 
be retained in airoha_regs.h as register documentation for future 
reference. Only the loop will be dropped.

> nit: tmp is not so meaningful, maybe better something like data?
> nit: I would prefer "+" instead of "|"
> nit: please drop prev and just do:
>       dev->stats.tx_ok_pkts = max(data, dev->stats.tx_ok_pkts);
> please redo it for all the occurrences.

Understood. Will rename tmp to data, and use '+' instead of '|' in v5.

Thanks,
Aniket

