Return-Path: <netdev+bounces-286404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMB6J0P8AGrCPQEAu9opvQ
	(envelope-from <netdev+bounces-286404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 23:44:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 451955068C6
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 23:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A1163008E0F
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E108346E51;
	Sun, 10 May 2026 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T99d+wMJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22232345729
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778449470; cv=pass; b=ppSDdVTfal7sy7sB3SkEia01REnb5mQtghRZN35VRvuFK+xrc5jAh+I4u1nmirVXaJm6XmNCnenxshR+E4SlaDrraNrHIey9R+kOHMdk73bsbzMn8QOMzmgFYpco4stgw5beiJiQdzJbpJF9XJheE8EmLDZDDT7ScvQCwioa5Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778449470; c=relaxed/simple;
	bh=xW31+nqQNjVeVWyZc/zldQQ2zcGUZPyx024EVW7iH8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHxoDIHfDQGeDFgjMTpF5qYibePaLeNMWZ1go6Www6oZSohliQZ+DWBL9M0ALssYko54HlQhkodAhMRXz9I05364nnUAZMeiJtf9ahpZWduXrOmfopCbnvklwtGua10K/Gqn7pguDQQhzd+1o8b6mVzdugDXUK3M++zgsceUoO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T99d+wMJ; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so41737726d6.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 14:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778449468; cv=none;
        d=google.com; s=arc-20240605;
        b=GjAeza3Hej1+A460qhLsLW6c9TDIi9Xhtmb328WgjLb+yeSHBu1pppylMnHQ3SsLDr
         TlvKJWlBN9YjcpUotSRYW/GP/PzWU9s/HBZ/Afjh/sbuHorpzz6eeOPVOl36bS0PVh9c
         xos1AN6gfZpCem7qb5zcPMGua5xmdvNQOW5NGpUkuBHac8Q4VVR7zA7x/BKJZ9D8ZMf4
         j15pKn/k3xvofRC93eGkg5eZZzLz8nVvqF/OmIIU2R2bz61EcxXQKb5qZs64bglAxNbj
         qGMQ/ws9TI2EA4CPtTcGwb1OucMkECju6p2Xi2+P82w/XtIPmdN68uyQ0WAVBR2kn25V
         iSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xW31+nqQNjVeVWyZc/zldQQ2zcGUZPyx024EVW7iH8A=;
        fh=BqBYlaLM66VdNKTTNOVrbj6NORvlzJFJPxAM4eS5tfE=;
        b=Oaul4BEZvVb7kAwLuluWuGXI4XZvkCulFH0M6VGckg/gb2iM9ZbwPOriuQks3Ti1oB
         UJAZ57N2CCiK4bKm+PXtO9WH7G5yjBVtToEH/GhvO5BT41M5/XbaW206aGXmvVneWlwy
         1Bl2HRWkxvrzcw1geC1ZsIPLzZeiNZwH/Yh9AwZ0Ok5SMUpE2gsJFgri++whmOtlUIin
         /WEHWB+3j3SwJpU0FKctM/hcbKnjMRYJt/lbCg8xIh9HhgHApeeOMz5/COa1ZlfzZQOD
         VOsB2yNbDSlDsnC/Y6X4z7cfJGb7dOd6mKivhaAxgIj2ruGK5OmisrFpBy7/6rwVc5UD
         uKoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778449468; x=1779054268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW31+nqQNjVeVWyZc/zldQQ2zcGUZPyx024EVW7iH8A=;
        b=T99d+wMJSxS74zvnF4m+vigdUZngLJNu2eaxpIhOOKt52ds59yjDtmJbVF80fGiZ9D
         97nJffgksimP9EoV/wBcocfhMgDMTStmDFYXYgTdlM7Bk1cTpcrEsSfzcOx99cUURcBG
         vQbec96CqVj4jhhhpzfMQ2wq1FQjfW/Phim/19guxaeIJuvLNlTG5DpQltTSoa1opwU7
         jWuTPTMTWFJtit+TldPgt/3lMFpVqs4oJ+3BRzFmGTyRDK9Se5fqBYdeH4umFGGhCQFh
         eZ1T3ZT9E2HQUi0l3Q36p3PZTwnc+eV8M/sBwwO9Xo9GPSy/R3hxdZtGU+O+ZJrVmVUe
         cA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778449468; x=1779054268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xW31+nqQNjVeVWyZc/zldQQ2zcGUZPyx024EVW7iH8A=;
        b=T0ZrCoejoAt2X7pjjvRjAwz5In7VNgTfSG1Nn/Uz+C/NdxJW8BE7gZsPNLVJBljyb6
         6NuKU4uZRg+ol36NPUfqTKDGhJKsbgVSJtERhgIrATNa0PJi+Zw2XklmAIqDhGMzSOfA
         HUeTGO+xxLRHA/0S9R2oZNSmmlyYOVH3fT02Zv1nXncpf182s0HTnz1/qUIeeGiJCtSz
         cCSBy+iw/3nKeVaOHuKEGey8RefMIfLdGeh/ODVThmStxKz3sZrKJam8A1Em8h4bUI2W
         aMG0iI8jjtlat+quWoAfU7BIgTPOnNHFWxVh0Apm/pAz60xdERW31WfwasCTkC4FSiYd
         NJ/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/juE5nKMG+nK02dWtO3Boj6Cy7mf8dyeDAvOJKBAZ+kUGTZDuEyDj2oMjSYWVQpndZGorQK7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyftGk6Il1lOsFBdjXT7LzvwWnGktDFb9J2FlBtFjPH4PAeyWnH
	i73mplqjw3LpBqlepHGbFXUIaAPAN6cJehPN5ZrA3iAvSxWXp69VEM922xm+pK4xp9tCfst2vpW
	B/SuaPJNZVLkYfU1wTqMxNwveT7IufHk=
X-Gm-Gg: Acq92OHcAes7V3P9lzKeU8/lpimLHSsPLAtjQL2oFtomp4US8GMz9DYmnST0LxHEh++
	8Q2l2ixgNWsI59r0K1fCUzQ9LdoosUxf8rjEe2u+vP3QvAI9nNXghDeiLsMlsbLZhkMpkCoFVnV
	pESyylPV30azeyCluIVgKHmqviIA/7nQxGowOlnPfLLvyF2Gw/lRaFDLg/3GCb3YeywtbRC9Ie5
	50e3lVQEttKgQHqCL4iBaR8jSorizswRyW7PVzxqbqbS8UevWE2L/sE3HEcKPSkvSurn4neUKyU
	+PscMAJINJmqrr1/0/mym3ZuE4arkujKDn6VC3P/Ruo3EPC2OOKBOUh3QdCJ7kthvc1ZbPyzMEa
	wChM=
X-Received: by 2002:a05:6214:29eb:b0:8c4:3588:ae19 with SMTP id
 6a1803df08f44-8c43588afe1mr37113616d6.48.1778449467747; Sun, 10 May 2026
 14:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org>
 <20260509230519.57607-2-enelsonmoore@gmail.com> <alpine.DEB.2.21.2605100246020.46195@angie.orcam.me.uk>
 <20260510085841.243bdd7e@kernel.org>
In-Reply-To: <20260510085841.243bdd7e@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 10 May 2026 14:44:16 -0700
X-Gm-Features: AVHnY4JwVc6R13gZlxOdgoJKapdsnRzw6jvNst6XxwMU71g4MGnJESH5UPnAgOA
Message-ID: <CADkSEUj3qUFDG-Hc3_RNZjm6=h8wJF63OOcHWsZGumG18VdLkA@mail.gmail.com>
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 451955068C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286404-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 8:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Sorry, must have missed it or forgotten.
> Could you point me to the report of these driver being used?

Here:
https://lore.kernel.org/all/alpine.DEB.2.21.2604240004280.28583@angie.orcam=
.me.uk/

