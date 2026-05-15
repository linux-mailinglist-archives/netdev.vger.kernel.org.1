Return-Path: <netdev+bounces-288453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAAiJDWJB2ol7gIAu9opvQ
	(envelope-from <netdev+bounces-288453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:59:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19337557973
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B780B300D686
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFB737FF4C;
	Fri, 15 May 2026 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuxcDhRt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93B413D6C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878666; cv=none; b=p1hI3cSJxAmsQYeds4tqO+xN/LG1PUP+Dtgt0SDzKNc8KEVISJkk0kkCm0vMjey0a8ulYAzFzskPvnZi1Hz9mneDKeKaRUw3I+kneqlJOAQZWOKvzTt88r/2vtwh9BzkV9gFoNq7MOSUyBOq6kGraGw1P1yUCzDyY+7H1iZcqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878666; c=relaxed/simple;
	bh=T18phV1uWOaQaUa1vLLX0NYJ2ankHcxd9/kOPhQnwwI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HEwiF+wd/m5mAEK2xXOHf4TooPoU6fkJ7MyBsPRXpC72fHBwsuJ7/VNjfgRgoEn/CQ3E6IW8thgqxboh0b8kBA59asZWm/hjnRCMv2AetuMdkIE2OIrkKZlTKy4VZAcpl10yDZtq6ZBBCLVkK8+IQD/xrupDYf32KQ4CD9gcvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuxcDhRt; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65890a6ca20so633872d50.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778878664; x=1779483464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T18phV1uWOaQaUa1vLLX0NYJ2ankHcxd9/kOPhQnwwI=;
        b=MuxcDhRtP1FFxboIgd4U1yLdLXXQP0mbyZpE9wR9SqKs1DcE97LYS2gVKYz6nFW1+Y
         REeMT3xFWlvqoy+SIuYVZtHsX6q9aelQR8xYHKtjUreXNaxyKlZ8C1D+M8+DRuwiLQhT
         ySkSqb5ETfAQQ1ZKUSjS27XeD29uJDFOsIyXQGcvUWLN/fl8fD+/Czj6fX2y6hLN4wD8
         C23QKEUBRIZCiUgBizEGMZPtVB4LhPNkBRO1861gkcD9VUO5dJrlJGsdb589UTUoORXc
         G0ZmAmWUBYxUr1v32YR994bQaPMvRiaK0oAB/RsNKqT0fCBkRSQrUa/BtkLsIpJ+DCxs
         xjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778878664; x=1779483464;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T18phV1uWOaQaUa1vLLX0NYJ2ankHcxd9/kOPhQnwwI=;
        b=AKos5kyJbO4cBK4VIg56d6ejj/wzLY4WVg79gZvTBjZQlUDAb9hbQSROHsO1S+RKAd
         BwiFQl1uUJx+hXC7dLxmDe5NeR53VMv6e6kRyxNfdQWYdL58ryyDfsIYugQDTUYCyjyX
         16hvSyuJOjjoSeJw+xllKJNmAmIQIL2eF1JlSFq1e9tSRg8HOXC2ktAT78LACe5Re47b
         3IBUYETCJxP0xSTSqYLkIIRrASwijq/JLWp59POpwhxUAdnYw9uNt+B838bPIfUUMtGQ
         VwKVQR2lmo6ghrfx5uXlTWzIAuBpoCVuHwmqIQO2/tsCGZB1H+K4MdpM2mtMWoHCqIoc
         jDeQ==
X-Gm-Message-State: AOJu0YyXEczr7UEqAsOzJ9G5YY+CaxJvOO9C3yH7oijG8dRBFuKS+H4P
	++iAVPWXn0ELnO921Xry/vK0r/GTjO+C/ZYIWRKrbnfIlK5ioOo73PiL
X-Gm-Gg: Acq92OEDp65cHaVqM9ce85uycAFaxuzq1LwHGpxF1Hd2+sX0K0pmc6jAZLQ1ETUH2Sp
	/Rsl/IfCcq1S2djPJyMRp9P1+ujIOPS5/mBBySdt0G6ed0a5ypnP1xdmOoHa0nZDCETVjBkv/oX
	LEvRpyXi1lmaapwy66v/kXiavUH1o7nLXEGzExtvvPzTf6xyf3kqTsdnRhyL0sVg1OeQMcv/Ram
	hY3QqQ8RFEuvF1Yxw+OYBWfoi4KLYNlYtx4DYknZYlB3pmP7+jNJqQHxQryF4HYFDUDHF8FOI5V
	+2aOWf3WYKiKkmtjT7D4gMdrhNHZa0qaIbj+HtLW7crMSkGTBqLpVPA4tGNZZjM7YZedP+rr8PD
	jDKyI//MFXFMcww2auhRzR+do0MT6dehPCBfoDGbYSKn0XNKbhts/OQDFA1jHDt7Zts15rP3N21
	QyI5CGovw7RB2TJlUzbANZDbTBQKpv6qBsFIRq6X69iwL+3d09SClbzQdxSnr4awzf+41ATmR+z
	ka7QGB0H/QBi4Y=
X-Received: by 2002:a05:690c:6987:b0:7b8:9418:7605 with SMTP id 00721157ae682-7c95c201035mr60281887b3.38.1778878664204;
        Fri, 15 May 2026 13:57:44 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f2aabf9csm36060107b3.16.2026.05.15.13.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:57:43 -0700 (PDT)
Date: Fri, 15 May 2026 16:57:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2434107fce59b@gmail.com>
In-Reply-To: <20260515-spi-handle-v1-1-debf8cb467cb@gmail.com>
References: <20260515-spi-handle-v1-1-debf8cb467cb@gmail.com>
Subject: Re: [PATCH] netdevsim: psp: reset spi on key rotation and check for
 exhaustion on alloc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 19337557973
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288453-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

Daniel Zahka wrote:
> The PSP spec states that the lower 31b of the SPI need to be
> non-zero. Though not in the spec, I think it is reasonable to reset
> the lower 31b of the spi space after a key rotation, and to also
> decline to generate session keys when the lower 31b saturate.

This could be stated more clearly in the spec indeed. At a minimum as
a suggestion ("should"). =


It does imply the second: "The SPI field is 31 bits long (since 1 bit
is taken as the master key indicator), so the master keys must be
rotated before the key=E2=80=99s SPI space is exhausted."

> =

> Assisted-by: Claude:claude-opus-4.7
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

[PATCH net-next]

Reviewed-by: Willem de Bruijn <willemb@google.com>

