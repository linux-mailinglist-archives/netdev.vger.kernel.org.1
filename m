Return-Path: <netdev+bounces-282538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFrGFuuR8mlhsgEAu9opvQ
	(envelope-from <netdev+bounces-282538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2CB49B4EA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7D11300BE39
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0937C39D6D3;
	Wed, 29 Apr 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caWg3WXG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EEB36E48C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504730; cv=none; b=mXqi2oRcjDrCbwfv7o3DqnLs+7Jv490ItHcLl0EjSF7nl3a9bT/ZcdNEzozFctL4Gq1MCDQPE/jTKweGdfH4qtci1CLCOh3X5eIK1j6nv7dD9n5Vmu8xJX3m6uxqUn/xXtR5sLwrmC6kn/9lBGdVZfI2hdgjKmR+DAfwyl6iy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504730; c=relaxed/simple;
	bh=Zj6EyFrG27dVsJjtN+0O1fbv1ApMVh3gWAYYHZskTM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpQjdqhZ7qPrVnbeKvgTKjafSaI0xYXWXgY5Gefftv4JGPSyF/GN40iF0atDoS9DPr6WkmI/n26oQn9oc71AIxYwVKp9bNVkHcew1Owa2RfR1G2QemhhQAI9pNgfw0r4wYu+aKlSHcI/atdGIA+OkI9Mr54o/mCyGkw37h+Wq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caWg3WXG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d43e09de5so145974f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777504727; x=1778109527; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuEsegkyryEZOXO6Gpz2sASCEUkFJVzUSqqEieVk9oU=;
        b=caWg3WXGKp44I12qv99rvWt3QFDrvhK/4kKfOurlP6az3hjb+gCKmYyvkucX5fIQU6
         n1N+lJi0AmbB+CPJqEVm/cgL01toJgNx5Ew9fFroeKy+jrsrbVD5PNPSJUfUbXSKfoBa
         Hq3ZHZ782d7aqnluvlOUZ96GxIQ4uxclYLEc7YxIxESHlctCZNgcavc+ODNCAYzrSOa2
         DD+jntWqvSmymvxTja2zMx38cReuXZoZ0HmmY0KKH03lWi60rNhZ10YC0nV9hAon7wU9
         y8Shzg0113ny1P5hxFAAfNYFUR1zt9Ko38voHpYeW4b1uD7kkKiZFZTFh72vzaOl2qOu
         c4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777504727; x=1778109527;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FuEsegkyryEZOXO6Gpz2sASCEUkFJVzUSqqEieVk9oU=;
        b=iWGF4MtzQatEM3m7b3YPFG/czE1s88oDXfwILYmYmQixP0MOEo3vLIVNQbowabjflq
         X4McOckbz9Jgi8fiWkUynrwG3rAdZzrZtmfmXYq+SfM8SJRl/gIosrCZODy7G/mkcB7V
         PrKppsDUen2t2mS63+9g+rSMwURtDze7+GGuDhY4KOatyiNRVP0WRmuJo2nwUObRfyEt
         czwH7i6jY0eQy+pFxu7/os8CVRYpclItzE0vhaG0QPkJWSdCcUEnvT77DymAeFd/v+eJ
         +3SgIsA8+hnjMvFAXn+4AIyKesqoh5I5oQtBTEPjiQAcWFIjRqswpJx8vyICG6kBFO/s
         +fAA==
X-Forwarded-Encrypted: i=1; AFNElJ97h2FDnsSxFKmLDrpZgTKoPZQPN5IYyRhtvtumOGVyCWvZZary3rPeQUFe3S8vf212jsFX/4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5TiZDzJNRtq47TurytcVPAanFLZtzD3/EBKGEU1BIH8Tfanc
	+FKSL8v964LNCrcv+5mhGfyoGdqUVZtUDAe35WvZ8az8gndwk4Sanqw=
X-Gm-Gg: AeBDiesTGv4BLqlMI5uhtUazbm4zXZBVHQX3zmg6X9PYeOGN8CTY3UvF+jJ+K/leYTl
	jTwm8fV1c67GJGCPZ18AVHIEqdIAgLj3g50USYTq+BzBagsp+cMKli+6r86yYt1dtDzS/dMIj4d
	uHcpB1a9beDTNtta+4WuCQrOL87StGuhCF/ms+VO/F85pfVfHx5urR6NKXL2MA3XM+DQ/2RsO64
	FxE9HB8I4w4/0iZjn6bu6KD4P2PinqEFWDoBV17BdM+8uh7I7tu5JaZMpYC7e+N/wBD5zkrdC8q
	4Pdn+B8aXtKCSKc6u75E1ZdkSWY55MonotT0uJbxV3IJST1EUwo4kewvQCrEEI0eHeeMCT/T/T9
	GgLpMOEX7PwAfKuuWgVflxuU2NRCVi9cC7pnYdw0XYKxt241icFUCN8sMUHVdIewiCOYr+BDSK6
	jDVtLoUuH737V53Q==
X-Received: by 2002:a05:6000:26c2:b0:43d:71f4:7ed4 with SMTP id ffacd0b85a97d-4493d4120c0mr627963f8f.15.1777504726704;
        Wed, 29 Apr 2026 16:18:46 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c00sm8707525f8f.25.2026.04.29.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 16:18:46 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH v2 0/2] netfilter: fix NULL ops dereference in iptable lazy init
Date: Wed, 29 Apr 2026 23:18:45 -0000
Message-ID: <177750472539.3004201.15967003942391945312@talencesecurity.com>
In-Reply-To: <20260429175613.1459342-1-tristmd@gmail.com>
References: <20260429175613.1459342-1-tristmd@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9D2CB49B4EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282538-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


v1 moved the ops allocation before xt_register_table(), but as Phil
Sutter pointed out, new_table->ops is still assigned after the table
becomes visible via list_add() inside xt_register_table(). The race
window was reduced but not eliminated.

v2 takes a different approach: guard the pre_exit path against a NULL
ops pointer. If cleanup_net races against lazy table init and finds the
table before ops has been assigned, it simply skips the
nf_unregister_net_hooks() call. The register path will either complete
normally or fail and clean up via __ipt_unregister_table().

v1: https://lore.kernel.org/netdev/20260429175613.1459342-1-tristmd@gmail.com/

Tristan Madani (2):
  netfilter: ip_tables: guard ipt_unregister_table_pre_exit against NULL ops
  netfilter: ip6_tables: guard ip6t_unregister_table_pre_exit against NULL ops

 net/ipv4/netfilter/ip_tables.c  | 2 +-
 net/ipv6/netfilter/ip6_tables.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

