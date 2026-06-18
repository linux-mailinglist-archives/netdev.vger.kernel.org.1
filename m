Return-Path: <netdev+bounces-300408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FWc/AbLSM2pwGwYAu9opvQ
	(envelope-from <netdev+bounces-300408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:12:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C73D69FA7A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:12:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=orc04B5C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300408-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300408-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E4933026CB4
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15A3B2FE9;
	Thu, 18 Jun 2026 11:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9103272E56
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:03:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780611; cv=none; b=IFxPl5rBsOyA+ypanYcRieiGrBeyCnDVc0Xea/5/Jcz4j9oPx26hBP67uIJJOJf3a4X0vvhh0lt6s6Q2WRw9swknkYIWoGXh9JH3S5Y8wJqIDqPOMAJbxAsQA7L0ML3hRK7jbaht2DojdbT8JNugkxKHsrv5OxeYA3VouoUShvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780611; c=relaxed/simple;
	bh=ih1hA9pkwP8L/MCNP4uRdj5lWZxa52mA9WZkZEjpN1I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 In-Reply-To:References; b=JNCOMPPbhBCfF/EwPLJRLEqF4HufxSFqVgtlbXL9hc3veBFY4LOOgswhtwBJeuf8O4hjcrnqATkFX4xcRP5XL7QMR+31yGutOjhLG7zbRmkRMt+pLjnuDAkcSzWz/ph3YgD5wcZ3bt06zSreU3GhVQko/QoZgfA0b3nzxhomYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orc04B5C; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2247e38eso9627655ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781780610; x=1782385410; darn=vger.kernel.org;
        h=references:in-reply-to:mime-version:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ih1hA9pkwP8L/MCNP4uRdj5lWZxa52mA9WZkZEjpN1I=;
        b=orc04B5CsDOnBkE9B757tiunTwtc6FAlJajDjwl1WBbiw/3p3ijVG4fnTPzY4T+vPl
         ImfZ6i5Zv+z+oJ0L3mN0ynm1CRmPlIwfiHuNWHa0lHRTWc/4LXQv+CEXS/fmgjtGhoPA
         Jqb2WS7xWBlATZBVHWHFVSaVeFVSUzaTzIRQWV4LWs0W7qJLQNeNSqWWQhAeA9t051kF
         deBD2Wglapg2iNvw0C50ELbXEALG1PXJnT+34lP6/oZfmWME2dP/FK5jA4jJzMwiqran
         InYt9mPay9ikdC1QjIZ7KcemAtwllMd33oXLWmUf3PdJJPD4+kdmg/rEswm6RW3riWsY
         HANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781780610; x=1782385410;
        h=references:in-reply-to:mime-version:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ih1hA9pkwP8L/MCNP4uRdj5lWZxa52mA9WZkZEjpN1I=;
        b=LkkEjALAu+dOoiw4C+Xvhg/WeYd0WInbwq3fMxrGAYodA13RtuG2oJuxETfjhCeLzu
         Cq6UBv+D9HOUK8Uh2GffNYwSCnsSiW1yuAw8jKRGdOHFfzVMcSWx/TsQSxsD9K/d/oGk
         4ys6MKPjljKc2WCz92YNtau4IkdgHyWh4lUZTln/YYcgfwVbN66fA+U6w7Ykiv8aBKG3
         OMc7/LoNNI67hYirCzghGdx1uUsdOEILKW4TunEiTk/xpmdeDLmWkSkCw8dq9IY51nct
         prSxV2T5Did6cwbfVJxX6p3/GPLz+K+bF5yGLz3MBFufvCFFt40CnTbNLCiQgGwn1Lxt
         m3/w==
X-Forwarded-Encrypted: i=1; AFNElJ9AUve3ONFgqwAiVq1heH9ekjzjnVi6XyM8pkvK+57cCLidp38Uyf5GwA40mxXb3hdo7/1xIwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1jbMmPSuBJrrqBlYAIs65rc9BaKRIHtf8yd+E7v2wtQozfChx
	JBN5umdfH/5vQ7g3nls/uM077dvUeNNyRW9bIc5JhBSoZ3zjK34qPNDU
X-Gm-Gg: AfdE7ck5QOzMs0itD9/2bhm0LBLbIg/4fjBW5WvnpF/jrXMy4L6BrNQWNmn0wSiJxbc
	yH0CsvPcg2SiI6kxKQc1lRNjgm8uf6zDb9Jv6aeeV0xHb8OaLVA97j+sz1NNdEVnGZ2nETaMW9B
	B7ms+H74AfVD92W5gHLJadaSN+UJ9qjiuC1qc0MfXNEKqF42DmaIrIuQT7IzJyn3Z8Ewk/YEeKF
	C8D+d8JIlV1lCGqDcQhxCkDwnH7XG8PDsYNrg77IhNTnx0Dlv5/Bur26hf+J4LYyRNATpN5dfpV
	p9L9lAA1hEJ6KGLpNw95E7KDUnMq7dHGcsL8/M5TbtY34ua3llflSOv+qHjuauKAFHfLB/AlMes
	t/ADtvTLRx4F3HyE604XkMG3kkfZmLXzCtvwtoKuMphPYBVQ1C1h+fIBE6SCPiJ/1hBYlceNrv4
	6Ly1tSLQ==
X-Received: by 2002:a17:903:2a8b:b0:2c0:c940:dc32 with SMTP id d9443c01a7336-2c6bc0cc732mr87305065ad.16.1781780610103;
        Thu, 18 Jun 2026 04:03:30 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8c1f9sm199005805ad.59.2026.06.18.04.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 04:03:29 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v3] net: airoha: Fix skb->priority underflow in airoha_dev_select_queue()
Date: Thu, 18 Jun 2026 22:10:00 +0800
Message-ID: <178178060540.2320032.8413754929321784354@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260617161951.52abe413@kernel.org>
References: <178161373805.2167512.2544164327472822616@gmail.com> <20260617161951.52abe413@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.39 / 15.00];
	DATE_IN_FUTURE(4.00)[2];
	SUSPICIOUS_RECIPS(1.50)[];
	R_BAD_CTE_7BIT(1.05)[unknown,utf8];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300408-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:lorenzo@kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C73D69FA7A

On Wed, Jun 18, 2026 at 08:19:51AM +0200, Jakub Kicinski wrote:
> Hi Lorenzo, is there a reason we're subtracting 1 here in the first
> place? Could be just me, but may be worth adding a comment here.
>
> Please respin with some sort of an explanation..

Hi Jakub,

The (priority - 1) mapping predates my involvement — I only addressed
the underflow bug when skb->priority is 0, where the unsigned
subtraction wraps and routes best-effort packets to the highest-priority
queue.

Lorenzo, could you clarify the intended priority-to-queue mapping so
I can add a proper comment in the respin?

Regards,
Wayen


