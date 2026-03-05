Return-Path: <netdev+bounces-264436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOHdEvaYqWm7AgEAu9opvQ
	(envelope-from <netdev+bounces-264436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:53:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F1B213E63
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E0AC3054133
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4857E3A9605;
	Thu,  5 Mar 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="P39tM6Gw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323E3A7F52
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721676; cv=none; b=gCXh7CHzapbd/gUjtd3Gq9qIDgEk1G7ajAN0KC02xLRRB9vqkIhQRkJSKMgT5XletLQZ28LHB9E6BfuQTFuXyKKoHBpBRwFmftqX+4x+sXqFfmTpAgcFOUHoPjplfn3J1AQUe4TcNheDBktwhUKOt9trpiprUA7rppPgQZCgUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721676; c=relaxed/simple;
	bh=jJpxs4uW9tmn1sVa7vXlYtBN8USiETjByVpeTdSNuoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCItqlK1bV8daNrueH/BTC99tUF7nfM0IPRlwdFZCjUVKVJ5eYhBwr4M6gbGaDLGN3QbrLe8RlH6BJYTRA2K8H3j1sq4NZw8NK/1q23Vc1N5AB88R7PMqWBQ2RTuVHfadHc7OXxSpA4pMtUY9q0AV0ePv0i+JIQwwsgNuIC0kSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=P39tM6Gw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82746ed8cb1so4551813b3a.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 06:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772721673; x=1773326473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8KIfrmAXO/kTH2qN+MDY/bFTmG66xWFxB/HbEpX9xQ=;
        b=P39tM6GwriTWovmysC5Im56EAgopeF0wz6ZtvA02M7C+G7svNUR+jJC2E8AUXIz8iJ
         uG1WXZ7g4zeHuTAzPk5mPjlMap5TAzXlwFdMT4YxdValwKap0mg4BqD2/P/CHqzepwji
         fPIuaR9FW5PIDo6ggAXVim8yEtDvAyqGhaXSZbWWU6ejqdsnw87PusiCMS0lHv3yu+G0
         UeePquYj0z9bjtNhuRojIBQZPxbZGGC6beiGUmdkC55Y5qiTL+j0gw33RAxoy/QBi6S/
         BdIknXkDXsZbbjJ0EXsmrpPOsZ6TpYS87+6+tiI0sLtf04yumwVXl7Zca+fhu1yoNVLQ
         EYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721673; x=1773326473;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8KIfrmAXO/kTH2qN+MDY/bFTmG66xWFxB/HbEpX9xQ=;
        b=j5L3Hwf0TjAsCa1xs6JwiGKMjn1B0rve4d9Rv6zeDr6OsoEr38koXbahaav6OuH+JP
         sPS4CT7Aq7S4y+RnAh1KI7gSRVfFxWPUQ9znZMLRI26SNZxcr6jnTT0RAYh6zDGmmx6V
         o1gX470Uj265zszIaB3u9pEEBSzqjOCiU0e/7myiIIDWvH4eJQ3FTEn+DpdCixMvhs3K
         06Ulig+AA0KeTYi39KjRO9bxnyHE554uHmGcnZwNm4vFlmipgLy4eyqcKdtxbWvNfBUy
         sgcD5/0JoauT6Rrx2jb8JFA3jhemLo/zRjxBd15Px7QsIL2ri0sgLMQCLwVSh9upts5/
         JvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5O3HRWe7+WSvYNM5CNhDkwSjx4fTOVCFqRH/H+8CppoFnwr7L6dvEte3YRxbY1oLDk3NovUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6ZVuy4LTIYH+efpFX0cAi5g/DCYv8CBQceprCf4QHcdBZrnl
	29sYu/i1zExaRk4kmEZLVLW9dR1uq7MDakn1hSLXnYFqkurSU82Pgp9UDJQtSX6TuQo=
X-Gm-Gg: ATEYQzyroh0+lh5l3bYDelgtGfezOnb8E1KuhVjnz2fTbs9bVgi9/oGF/pkzjSWvcss
	2WZu9OFudBb2OZNtVrBTCB/lbKxUy/Gz82QfFOT5QbE/bJ3GRxPW86Axrvb6kVMPbRySLgP7/UD
	5Nt6p8iA8CCFxwco1LVxDve3JbWM3TX/PYKuzlv2uHzVaRkt1o/A25QbtEPMh2E+GqZJVt9yMCS
	L48QQl5cwJaYwQFOupD0ts+6r/aoi4xt9Uuw3gUdyyRh2JcuuntfPnzJQSmR0iiPcm7Acn+WI4r
	oWkyJaD72g0i8wM76NAnAdC2mBT/YRZIgLmldZj6VGmhRUzWk5lB24Ovuu6Qx/v+Dp4xzKGWpNm
	uyycNOTjfd3IzFxYhXDHfN3kDwMGL+5GtqxpNHLqIU82UcLoCfNiF+ee8TJeDJA6efJ3sTYjQ/D
	teisWa
X-Received: by 2002:a05:6a00:114e:b0:823:c59:9cb0 with SMTP id d2e1a72fcca58-82972b6fed7mr4994038b3a.1.1772721673040;
        Thu, 05 Mar 2026 06:41:13 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8299a6938a7sm37440b3a.7.2026.03.05.06.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:41:12 -0800 (PST)
Date: Thu, 5 Mar 2026 06:41:11 -0800
From: Joe Damato <joe@dama.to>
To: maximilianpezzullo@gmail.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] igc: fix typos in comments
Message-ID: <aamWB4kGq8hRLjdN@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, maximilianpezzullo@gmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-0-b6a9f1d336ff@gmail.com>
 <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-2-b6a9f1d336ff@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-2-b6a9f1d336ff@gmail.com>
X-Rspamd-Queue-Id: B0F1B213E63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264436-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[dama.to];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,dama.to:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 08:21:20AM +0100, Maximilian Pezzullo via B4 Relay wrote:
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> Fix spelling errors in code comments:
>  - igc_diag.c: 'autonegotioation' -> 'autonegotiation'
>  - igc_main.c: 'revisons' -> 'revisions' (two occurrences)
> 
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

