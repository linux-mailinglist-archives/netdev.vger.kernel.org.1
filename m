Return-Path: <netdev+bounces-263799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO8kEL4hqGlQoQAAu9opvQ
	(envelope-from <netdev+bounces-263799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:12:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A73461FF89A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A55D1301CFD9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD23A6EEF;
	Wed,  4 Mar 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGK7ttSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF0439EF04
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626347; cv=none; b=L5stOK+gP0InYtco3o7RemF1CcODfoR+QFEzawIGENG1a35/NzhHUCHfJRH/ahiLhW2Hd3wV35wBQJ29famVBHir0RrhITtun0W3RBO35ELQgyltQBpejqETwfGowdh4F1fbbRG2ZVDLfiKwWVcEhwuStD6+rCai7BZ2mpVkhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626347; c=relaxed/simple;
	bh=rSYha14kAP1w1wpHdg+iX8xV7RlSbT/YKdzsmMvI558=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=VOuRzGidki11g+etYVXEyMKg16a5ZTvtuELO5tM2Vryu9i2QpKDFL3uiHIPfI7LPdapVbNOLrVyR2lwhcWof4VwunmbWb80oLTLGYPTvTkhB7+Yxm1R4EUPPhi36xy6RvPvO90dAQ+TGVm6htYGFZDWn7hyj4UKE6sD/62Otcks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGK7ttSx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439c5b40f60so783433f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 04:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772626344; x=1773231144; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxY3blhRYQ7Z0a4lZe+t9JzHnzGMK1TD/KOeXPkJpVY=;
        b=RGK7ttSxFMdTEzlQ5t6rsNwH2jDIjl02qWk0q0qR/BkGhvGG0ngAGZBD5/5KVP3oXr
         oy9027y9L0pvkYT5wI4eFFiERyZYCqCsORQ9ipE2vJd0UcijNmNQ6IzgYTmT2WaCBIXN
         bfP+TbAiKlGHRPe5MRERDRXdKZwVg5hhbtibuIGR4/3bZ8+pMZ5d+6mQnZSpQ0x9KEJU
         86iUSqL1EH+kECBefFdNZRJs1OLMCNJmMNs4wVybf/oQqXdDkfOWDY6Ty1yH1/61EXFb
         SRJDs6VMP2HPvnvdXbmCv1Cuco4sm742mUy7/nH4t/p2IWKD8+jIOsxb+okGV3vurDq5
         kb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772626344; x=1773231144;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fxY3blhRYQ7Z0a4lZe+t9JzHnzGMK1TD/KOeXPkJpVY=;
        b=QX6unnuntdNrQOU+vG/r6KNSvF17txwne0xAzT4H/xIvkdEwQswuJSBErYYsTw3fhD
         /aYVLJb3gNNZUYGkgiWueJK0WlyHhVo2GJYm4egGuHFmZRa98uTF+3Br2QYTsm1dtWCV
         T823aWu0BjrunFmuiwKPrWRIKJYEfcrULESp5bYqA06SSkOtxAqxKan5fjg17M+P7UiY
         PTApNdBSevsh1ynNTr+0+c5P7zubxgHW7IfbzE4YL2GeTBhMBnfEpzdCUbrmG2ilIdxX
         EW3/pNC14boQ8jtCB9nj3mtxk5U4FU9oa/prKxzqdfvfwVErLCfXROHLulpgS07hIxvw
         eCeg==
X-Forwarded-Encrypted: i=1; AJvYcCXlyBkJEwdNnjsSCyTj6crdE5CJx8AxjtZC9p8+lZEnagMiAtBa5hqmqbJMuZ5TjKiqbrjDA4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tvRKx+X7forR02kCCTUswnTCX71Lc18eLzEfI7SMDXVsufva
	OWVzxjXmK0Ww8MbFjZw3dXQhgd7dYxkVIhbx/dJaTyjz4JuZczn7lP53
X-Gm-Gg: ATEYQzxk3cdzhxLDFHBMwTCleGtoCkUVGOdHyuWQj4U4c5S90FHtld5Fi4XI2eCOi/9
	QYFmexnOaHNtNKT91a9NfgjPpY2vmt2ZoNBDNTtc8T4EFqY3FKKgEeeCz9stvBj1HmbEWbWYo/F
	YGrOccMtKqwdHFkfVoJdNFJ7gH7zMYn0yMuJGvSLozkGspEwLC9hg4Xkh796JkBF2HvxamBrx5k
	FAhYv/r5URnw5bORcUWleBrXh1TXvqO7UYyOJs1N2Mp2A/5vVry7Ce8qjKxQ3I/seMjlWUFoORJ
	JfSPDBNLu1tvUtaE3mIsTTY8nTKluLsC1Bwtj0FF1glu/NL91RoiIhyC7dkdQQJok8PMGUmx6IW
	C2z3nakFx60vjT/F5ja74NbbYK9GEdQLcpu3uM5HfIfAvMF1NHnYwUNOI69BPEmUc8LpOKbSEHl
	V/ituc5kz6H1E3BxqMwblsEk1ObA==
X-Received: by 2002:a05:6000:2382:b0:439:b811:11de with SMTP id ffacd0b85a97d-439c7f91d3bmr3486353f8f.7.1772626344294;
        Wed, 04 Mar 2026 04:12:24 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ae0e7abasm29291430f8f.23.2026.03.04.04.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:12:23 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  liuhangbin@gmail.com,  matttbe@kernel.org
Subject: Re: [PATCH net-next 0/4] tools: ynl: tests: adjust Makefile to
 mimic ksft
In-Reply-To: <20260303163504.2084981-1-kuba@kernel.org>
Date: Wed, 04 Mar 2026 10:36:59 +0000
Message-ID: <m2pl5jyj78.fsf@gmail.com>
References: <20260303163504.2084981-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A73461FF89A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263799-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> writes:

> Make a few minor adjustments to tools/net/ynl/tests/Makefile
> to align its behavior more with how real kselftests behave.
> This series allows running the YNL tests in NIPA with little
> extra integration effort.
>
> If anyone already integrated these tests into their CI minor
> adjustments to the integration may be needed (due to patch 2).
>
> Jakub Kicinski (4):
>   tools: ynl: rename TESTS variable to TEST_PROGS
>   tools: ynl: don't install tests in /usr/bin/
>   tools: ynl: support INSTALL_PATH in the tests Makefile
>   tools: ynl: produce kselftest-list.txt from tests
>
>  tools/net/ynl/tests/Makefile | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

