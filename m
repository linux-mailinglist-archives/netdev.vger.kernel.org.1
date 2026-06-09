Return-Path: <netdev+bounces-297145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1feKKYU7KGpRAgMAu9opvQ
	(envelope-from <netdev+bounces-297145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:12:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32406662313
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:12:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Y57JNkU+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297145-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297145-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0905320FF9A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E648C41D;
	Tue,  9 Jun 2026 15:43:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6F492529
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:43:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019826; cv=pass; b=uhNfjbQoc9T/hWOxcDhBi4upAHoVX6OFN/uRsu5eSWn0n4ifaFsg7faDFTZzMvgcGJJEX4P06OM8XSbSMCI1coZw4MmLTumZxUw0JSSZEB07t5oE7GJIpeb+k3oSPgMLvIYViuMoFEd1/GzJ3qZ2L6qdxcNxxi10gDAJ0/jAELQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019826; c=relaxed/simple;
	bh=SS51fETWJcEF7DuzNCBTp7VvsPQWd7DM7iTU2018+yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScVRDrAXbKS/bcKXhzFAgtIxqeexxHHQauLoIxpxNTxFCjWsfMh0E7FR7ATbjuKHqDbm6rZk1fTkiXRLiQ1pU5ReKjWyQsKUyYlQiI++3492Zo7dSYTqlcAZmtWe1mifcGqmh754UgSHrIOJm6DeaWjyo393TSVQXm2CjJdmmjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y57JNkU+; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176b9c476aso42959891cf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019824; cv=none;
        d=google.com; s=arc-20240605;
        b=VeJsYWxjuJTbeGJ7QOWkbeN0O+bud50omtR9wKAmE+mO5kpMW+h9KMklBHnRPnB6Qr
         ZNqdGqUEar10JYhLh6wHIh/QmOdsgNZ86+Gcewk06rY35CKUTB3xdw8uztkQrbJf5jDe
         PmzfIVA6SAFxfZIh+eU0gu9Mox7RLRzHjEnL281MWd509ON0rTdlGqM86bypQwLjb6d0
         hGG5jYDNz/HD+IuPuev5GGBWL7+1FON2aHw/5xDD9r7wMyssdqySmmW1dHggfadMxfa6
         2jzmw/deDCladw8XphKD/CbOnQF7sEsGALXXruBf1oKh6mJaS+ahiDYYgH5lr1bXsfrO
         YXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SS51fETWJcEF7DuzNCBTp7VvsPQWd7DM7iTU2018+yE=;
        fh=I7Sx/TeeiA1R1YmKRPCVohKnbVmrCpctbanLt2eaTQQ=;
        b=Vu+0XNDq5peACred0zQilUzlsZ0oHO/XBaoxsf+Ts2bbepN+Scduqjwy1ue1Z9cWFd
         08LlN79xovHSUY264/jLrNQczklkNesvZWA6ThJsKQX/7y92Sg273ntsxwgE5qcemGXH
         HHX1nbQKN0eqALHu4E8tGrfnNdipA4SzXDyccCIDKqH7CWzvLHt5Du+9Yb7b6AH+bUgC
         jPEl2G/t3ii4UMGvNLe6AmCpCMV8wjcQjg7PRb0SU8rbTPGLPIgwjGj+yV5bs3eBfJgy
         wx/kg4FkyoexGw1XOQbUIxaN0S+zDPo8Kw2WRJK4y+UgLqujbJCEBFCh7+UOKeQSvooY
         dINg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019824; x=1781624624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS51fETWJcEF7DuzNCBTp7VvsPQWd7DM7iTU2018+yE=;
        b=Y57JNkU+Zi1wdIsSz5nBqsbKvbRUj3kQU46XYgu1/YRPuiaq7EDTsHJwQyurFiAJCb
         ag0WlCwLVmKS5vXwFK7RcZEVJZODSPgeZOmTFWQo/Z2XK6JrCYK4WSmN5F2XrKNUmp1j
         PPC3gPzbtA97j9tzlSYq5jXJRx9aU7PqitCDh8ddIGdafjMr6EbzNmFkoiN5BGegRvOa
         5tPvRoIol+18O9RoDCtUvX3VOyZ03wCeGNcwcZ0YLXVOv6Foi3UzDfbPs3pFwSSVm1et
         Ig/E8zkYe4+6sOZPasZ/fCSjtq/6ps9U4yeqxaZvc+C9L8ErOvqkhQ1Gii4opCsefL+Q
         DboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019824; x=1781624624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SS51fETWJcEF7DuzNCBTp7VvsPQWd7DM7iTU2018+yE=;
        b=dOqicjOgayGdjAr3eoKR+46MUpPRed0WbiY26D4K5QXGkUadFauN4GoA0SLdEAWv21
         7T2h6wodfUn72WWnln3494qjueeJlRihiXtvth7mf0vQ3A+ZqkB0hpmC5nPLivTmaD7i
         dm/EzoWifq+LZNbC34dHf1yQzKw+JM8hVnJZDEY0hOBKoQVwBUBzUkIcqV0ioWpA79q8
         ITrg9qdyO9wzuPYEjRSuqmt8KEcXJMXiOD10bixVYvEuOD+uD3WV+6pPG/suNjThIyNt
         nqaJ19pOlfofE08WR3jdn7OpUrbtp8DtZ3YJaNr5ccOlL6g0zMPVHWfAUujWjw9HzPdg
         ufaw==
X-Forwarded-Encrypted: i=1; AFNElJ/ATdWqe/l89BSgrGl5/BEPoUohHTOxpb0zgZvp3A7cO0ZvDZrjaW8+YmMFX3F+c1xOp8X7IFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2b0Hvi/MW5dyorZt+mt5FXKSYvdJx3jq+cUDgkf4hbu/jPIuc
	PxX2CMkiSQHfoOn23DlLGZRReh25h633eUMa8G7b+vAV7shnkKcAustOQ4zXyDNNdZ0yi51veqT
	MG1pghba6xAW9sikSvsQyf2tynUjkh9FeVDb3OU9q
X-Gm-Gg: Acq92OHuYicm3wjU3qLvNh8/QCJ0Cunu7MeCf5gvcpITUkHI8t78BOzK8pXBr/by1yj
	8fBGewEPxKsU+7XqvNLNVVLP6SWQNtuUR9E1IwCQRXQb7OWmgvY6P7Z1gXDi6UvVnygFeJc7xp/
	e8TLfUOIOG8QYZpciYIikCmMZM95Cyfbyc4j7gWw7j11S4K0grplp3VEo4ckDMVvpe0jYOPD044
	ZnlPlYgqB0u93naTmm+cEUO6SCN5vdMfUi9TqcrBQmRyvz4gjfhStxTyKMzLeqopZedopYXaWrK
	CEWG+9FGQXKD1/B4FIW7tV3dicqz0Esx+jITODheZjkNdGF0LeZS/GZHdhQw+Z3kQuPa4FQChfa
	WHnXkMs/x72y8Yz4E157McIzSCkHLqw==
X-Received: by 2002:a05:622a:2619:b0:517:b68a:8d93 with SMTP id
 d75a77b69052e-517b68a9523mr134503361cf.50.1781019823547; Tue, 09 Jun 2026
 08:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-9-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-9-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:43:32 -0700
X-Gm-Features: AVVi8Cc83JzFPuNDboYlZ_VYilG1Uxn6Dma8J_7BOfHlQOAd0UDkf6xRIVjPWCU
Message-ID: <CANn89iLk0wfujfCXdBuRqGFoexH5iYJ_=w0UJMMpZJ_g7oEUPA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/12] net: ethtool: optionally skip rtnl_lock
 in ethnl_act_module_fw_flash()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297145-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32406662313

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Module firmware flashing reads SFF-8024 identifier bytes via
> .get_module_eeprom_by_page(). Other than that it modifies
> a bit in the netdev->ethtool struct. Both should be ops-locked
> at this point.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

