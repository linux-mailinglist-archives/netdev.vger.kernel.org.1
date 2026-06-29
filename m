Return-Path: <netdev+bounces-302809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QRCgF7W/QmrnAQoAu9opvQ
	(envelope-from <netdev+bounces-302809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:55:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 586926DE292
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:55:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bpOQiWoz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302809-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302809-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5276130034BD
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADA6425CC4;
	Mon, 29 Jun 2026 18:55:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDD42885F
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:55:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759342; cv=none; b=LgEhGCWNb09EJMBhrlOd1+RwX0/CWR4cvIR/d7YCKCHZ6hl1B1Nkb90wwH8YtIPjHbGMrT+LZapFH5w24PFU1G23GwL7vaaVn0FxmKDnAIUfMeLDdT75VhZCl2rpXdLty3jZyGn/WU7YBHFAGlOZb05XKHCQAVarysK/BvmRZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759342; c=relaxed/simple;
	bh=EadCIK0hv1ebJMqpfwTHlVp1CFu9ZSZHhVnHkud6iSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwnZeJ7sxbRvicwGk8yy7wXBYM5Rzwij3bXQ4sQakErj0mzE79PSFsDz+YYepD8NTx0h7B6UcKI3zFumhcoMthH1EijLLuM3hw86nX7CIlto6Ckz1/HzWMNA+6T+UwcamHFPfhhRUIQnUrsiEv1cD2mwVFYadP4JoNh64ZO7toI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpOQiWoz; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b27c7451so10479405e9.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782759339; x=1783364139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EadCIK0hv1ebJMqpfwTHlVp1CFu9ZSZHhVnHkud6iSI=;
        b=bpOQiWozr/+wy7zl6taeH1oG5TdV6Z5uq+Qr4C9ObWBbyHFc0+UhXpXuF02T91z4jb
         Xql0RV9W/u6w073y+dVMAlamWgUT1dlI+Us2Lov/V8WYfQ3KTO3/RaTmH2uy6nAMjw5U
         ROTREMZZp+dmoZq852nl3+lH7nclkZB56n6nJYWEqRlu+4gqr5iB2TJ4zJ03OScIQzE8
         Sj9BzPReCeLJ+X/RxvFqRZrz1uRu3Mr9qfsQtq6S4vr8aatufLgGazhGptmdbQSVZvRy
         OMNCKcgpbxtKKonXBpnG3wmgSckXVTWHFVGFJC0wvuTzqTP4rE3jHM5h7WuqyB1JwLgp
         CqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759339; x=1783364139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EadCIK0hv1ebJMqpfwTHlVp1CFu9ZSZHhVnHkud6iSI=;
        b=MYAYvshD/JBjOvAER9yRtCtY5CrPfQ/FptlJ47oCa8wIwvXgI0r6igTLcHz1xI3Ere
         B49fT95gp0uDSGFLGLGqVjPVg7GSuejowH0t2+maF9ygP+gCVNj5YlhkrEZTh8MlHJZm
         Y+YqhG4MHzbo3K+L6RoafEZdtGvDQ+k24OgAMLPIX3gADLf1J+gHwemBEsEDEmKfmQMX
         DcQmREA4V4ghc2v7mV/GCnaS2/cEcloDBeDgdC7wptQjBZ7AJi33Gt/VQf3XLr6PW/io
         stsPsohOvufpS4Kov8fvwq/HRPaIx0XQgsEPe9YGxj+Vua5fbA0Zm3/Xcd46Ja5f7qN2
         2aEw==
X-Forwarded-Encrypted: i=1; AFNElJ+nVA0s+z5IP0pIZHVMd2xTgorKj7sKBjkM/pGNslQ1PVWWmKoye9v8tTchx+pHi8mtT+YnPbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKLYURmbRT0NBUsIDZpFCW2nsAbYEFK8bLYTNLw5u8r14Rg1xH
	93SxqVT4iDV0lGv+lc46/7FeXog+C8+Bya8k1CfM2n/Vr9tBWMI7moNL
X-Gm-Gg: AfdE7cmxtBeTuBUhHMK7RXdoWT8AK4wkL1fTvQ5YbbzJY4zwmegYxATyRHXnAEf4FZG
	FlfrYz1/TC/kA9h2dKqI+LQ1G0CcIQYjLrxTd+e3yPBuoQdia7yZVhQ9bEjUhpwfQLOhck7ZImm
	EIRls/kgOMIo7YrHHMXIGQG34WPmHi2MbYUAUzhabe0uoxHQe2mwDwhAM5rXnBuD5Bh40Sqa+TA
	jMw0aYOIlGCLudnDjpC8TR1di1sKrw2mltKu8chd/W87BjEQ9weX1dZkaA1zm0lr62vZEL8I5Is
	w1kv/KFzf4wlPpuUulkkm/vCT5cTF/b27jYyx31OKd8ejOSKbp4t+xdTzMlJrLwBpvx9Aj3wDFV
	6EmTdazCSAbCGR/lui1Hg1aHQ5dUevpWQ3VO/r1jkR27WtCSD4FMPaiyt9kkYhW7lBc1xpaY/CP
	duRfTEFYPuInlnznTBJWaST13HtYgrOGGdmo2L1xJSyf2Qi1WniYwDxGHgJooGC7lRT2BK2pKXi
	GZW/7Y=
X-Received: by 2002:a05:600c:3485:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-493b8d1bd68mr4749085e9.7.1782759338421;
        Mon, 29 Jun 2026 11:55:38 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8ca8a81sm9144875e9.10.2026.06.29.11.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:55:36 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: maxime.chevallier@bootlin.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	bjorn@mork.no,
	olek2@wp.pl,
	kabel@kernel.org
Subject: Re: [PATCH net v5 2/2] Revert "net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c"
Date: Mon, 29 Jun 2026 20:55:34 +0200
Message-ID: <20260629185534.15571-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <1bdf0dd4-4f34-406e-ae97-f2ec5b540906@bootlin.com>
References: <23e3931915c3ed2a14cec95f1490e43d30b225e8.1782581445.git.petr.wozniak@gmail.com> <1bdf0dd4-4f34-406e-ae97-f2ec5b540906@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302809-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,armlinux.org.uk,lunn.ch,gmail.com];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,mork.no,wp.pl];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 586926DE292

Hi Maxime,

Thanks a lot for testing and reviewing, much appreciated.

No worries about the original probe approach not panning out; restoring the
working RollBall detection is what matters here. If I ever get my hands on
genuine RollBall hardware, I'll revisit the per-module timing idea.

Thanks,
Petr

