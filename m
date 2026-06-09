Return-Path: <netdev+bounces-297151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IIZvId05KGr0AQMAu9opvQ
	(envelope-from <netdev+bounces-297151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:05:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24DA66220E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:05:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Ke6bXSOK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297151-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297151-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 089523183D31
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF957494A09;
	Tue,  9 Jun 2026 15:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3D494A15
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:50:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020222; cv=pass; b=gXhTzM24hXXwRz4bA2usMGZ3+CvUrrCC39mZpqRmYU8VFxsJoNt+RtiiRJX8nfXfO4SlZJdnni3e6FqqZvSWRm8/rVv1Ptfdl1+GqIN2jNO5HM+QA4byYzjqY9kJ4mjd8GfYYNd3FmF+IkLY9h5an3kCqUPlEc2D/T0KyoNBj8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020222; c=relaxed/simple;
	bh=iEqZZpRWV5lyDCLwxmWWrGZpRxM75Xdh+pFCbZqOkvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDwqNDFCdvWiD9UNJCEbQnw7ucfkVDHZW0pt4hgv1NQFm1+aOPsi92e+TDyGKK5bQDLGSuCdrNJWMcti2a/hPcAnfGNuj7/NnSi1t4U//kOc4gJ/SfHHQzVV2Fhntyk4jTIyb6ZYokCmQ1jVk0DXRo+FDFNjUdQxFeo2Sy+4f6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ke6bXSOK; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176096116fso62487261cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781020220; cv=none;
        d=google.com; s=arc-20240605;
        b=P9LmVNqyWVzbsijK66ijj3J1NXcHp+W7P82F2ef8+VnDTaiXXWhEJNjAmPoaGR4a5D
         NwF1K4230I9/cj45rjN+Ar4zvTo4mYZ0yDeF/4dNrCKZjMtDbpiZ2Xt7eSmwc1kDf7o7
         F4MA7xr53XVqVvqQFT4UZ1ZY6cEZtW8SiL/LiIC8idhmYhMS6wpS6ENk7I2khEKLy0YY
         0TF9m4DmipJx9NHeJ7xa4tejtqrqzyJGjRvKkkpSwR9c4xxU7sY6aXBRCQtHS2Nv6OK6
         5c1s5q087mMfPuxIFlFC2UbD8S86vJigthIu6I6JP6iOlrNSC+dngziWjMjLGbhvwryG
         McNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iEqZZpRWV5lyDCLwxmWWrGZpRxM75Xdh+pFCbZqOkvs=;
        fh=3e6nucIi0AzOI7fKhSR3kFPJYwJA8BWdmd471drWGk0=;
        b=T7VlaKP9PK9afZjJf4iVK5zapPJWAxPf8E331IBXyhI96NJ+DP6DcnKly4ImR9hxe7
         TmEmQZX2VBhhkkVowvEQ4A5Sm2AJRIi5xbGIjGY8UOg6/mjmHBvPQLdKNHkAB1h7mEdz
         eMhJeXrKwXtQk1TCXXpcatzZJSbbtTM2Ui4RulDGv8IsQhpY9ihcX+U88/lg/b/JX/Ef
         DYWnWp4gWWeaxS57AhTizdMDMciu9cZtGWtvFOabWRDuciA5heQ8mogPv0pRAsfhcQ4L
         ZnzVfQREMmaBZv2Z4BnHHt+SPDp5wV7WBzag/+4Rwf/QgzSkuFi4i1a+IQomw9qIOBSX
         FRVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781020220; x=1781625020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEqZZpRWV5lyDCLwxmWWrGZpRxM75Xdh+pFCbZqOkvs=;
        b=Ke6bXSOKljKn665Ib170LcCVSaTqyzuga2IylE9wt2eT9FegceVpKWI/B8xbaELnfR
         gonMopZfcvcjdXqzREi/zkxrSgF4oZt0OeYuO39AOzX8bbHPT+26Ojj48m4QWx+dCjGX
         1Z3D02hLQlExlCfgwZ/MMwczYaECAbclUgK2bk8WYdvSgdRM3obzZEJwKCLoWskWkccI
         kyz9RBLZTo9F0K7s6CAlHkx9SuOYU1T7/B/2zF764raxTI7XyZI49OjJGLYKxAiwDmYy
         Hjv9ftKg45yJ2udsjnQfCdNuuZEC19RRVCp2xK1/LtO7LLhYfJZrJqz3unDaT6bP+f2C
         2Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020220; x=1781625020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iEqZZpRWV5lyDCLwxmWWrGZpRxM75Xdh+pFCbZqOkvs=;
        b=maD8zTcDf/ASurZYfR035f00licxn/SwzFyxL88qUaxDI2v5zg6h5UwPHVRv30Rwg1
         SLI7ospIAKjVv5kvClJdDx9WhogDrkMg2j2nWci7nfnTpStue7Va7o92DL2CdUnImWU7
         amUTKfxprSxbQ51VzF7lY5p758ue0rXB0UJIPqHfDxttPaRkTO/iKHxZt6HAVwUpzDRK
         ZgGNabgRKNWYy4uywfp5u/ZwLfIBoj9zkoHWBiLbay290AM2BAy4DMoOAxxzby+wZDt9
         o3gySmkKoGQ3uyZsucxt9UXa2qll577wsiZf8SNlflyhWcYbvh4aSXGPAlKziRmD5BTn
         zgPg==
X-Forwarded-Encrypted: i=1; AFNElJ/siMJszSctyiLOZwboKsYuGXcFWKsUa+2Xhyxi7M7z/IcqitOKTyHlavi9pemqE+NqXU07P3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+M7wemCw+ThALIyXrXLCSjLM1x6REnqkApc1NkyPaW6ttUSej
	Xg67A6dh0+zDIFO73HoxcP6MoJ6nJDJMExZV3ApXSHs3DGkLtJ32X0EvNBCvSSQR81bP/W9z9sS
	905J/zMa5H2R8yJaAK+p9tccirHpSbKkDreR/aNWu
X-Gm-Gg: Acq92OH7n4qFtNEZuVDqYWGTJLohdG2ljoPkupyLBL8kJ8/kV8cbGxzqQSYH5D9rXfG
	CQ3HmmZainOYUpG+OKWok6blAjyI/QI3FwkMuiBReZzcDNt2SOGLFc5382Y8FLQ+mxU+0dIqxk4
	Tjm9SjRSQ76CCGa5fM9wRdvUzDb7fx32e7pgJe2ObieQiRNKE2HdLuOy8FqcEiEWjTl7dzpHoUe
	mMX6nJoPWuOPZMBo0WD0qQgZt3U+97Srgv2bDP5FipV6WAXACbmwWDqxl0tD/5UhXmZpzNoc1Tr
	kzJyWwriC7fO6775ZGhn3mdNkVX4XrP0oVu98adhLzKrYmDQyL2DoVJzX2NT3yEbOZS/dRKzDbn
	L1DCj230lRhLuk6gS3caHYHSFhaAVNw==
X-Received: by 2002:ac8:51da:0:b0:517:9e9b:162d with SMTP id
 d75a77b69052e-517a0f3157bmr198339781cf.32.1781020220031; Tue, 09 Jun 2026
 08:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-13-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-13-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:50:07 -0700
X-Gm-Features: AVVi8Cd9qT4BAnFIqF2c4rC0FSTTui5i5JugfkNTHSCanGrahDCo7pLcb42RlFE
Message-ID: <CANn89iJE2Dmg79WrNw3jY51yHukr4w3Lj4qRGwM-SsODNUA-JQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 12/12] docs: net: ethtool: document ops-locked
 drivers and op_needs_rtnl
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com, 
	tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com, 
	jakub@cloudflare.com, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F24DA66220E

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Catch up various bits of documentation after the locking changes.
>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

