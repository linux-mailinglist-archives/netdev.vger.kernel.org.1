Return-Path: <netdev+bounces-290685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GTvKt/+D2qCSAYAu9opvQ
	(envelope-from <netdev+bounces-290685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:59:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6E5AFC07
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 782573073772
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575083793CA;
	Fri, 22 May 2026 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz8kMkyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2590360ED6
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432899; cv=none; b=AUGPzJ/riyGzIEOXPYA/gCJWceChGkCQjV437oTwhVrRlVjrYkbcWLkxR/Ir38N2hp+rBzaEh9cgpFxD94q7k/jK7qWPZ2+Yjz6zIylhveq52noBPH19TIHutvqkSlqCFAth6K8+REsebUkQkbjr17VCLomqUE5Xu3oIuKQ6IY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432899; c=relaxed/simple;
	bh=wJ0C563Ghgv+mwad+zKEpzaeJ9PbuKH0EuvqylaFOXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLPdT6u/h+0xdcgI8Ic+3fxL6uG3MMzTlKVTdcX/V3XWCtSPo56T7CbHAAq+Ag9TiEJYpD63Q69NMEHQ6Ks5w9EKBRvUtYHsqFhgnXcWMeA/arT3O6Fzd8wvGqm1Lfmv9YyUvECsiVpOSyar1gXPV4ZV00jsP3ykNzBhMZTFDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz8kMkyZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so79585425e9.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 23:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779432896; x=1780037696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ0C563Ghgv+mwad+zKEpzaeJ9PbuKH0EuvqylaFOXw=;
        b=Nz8kMkyZHwqnpJ4OpruprDlBcHjG+a0EDx9kVnTD1XvAFvTwCb5wyBMYUz1AAdHiCZ
         dHabO+5znMOV414Z0ZRu/7G+B4oBO2Clsp6wSj2SLm8gIT6t+pllVTWBUag2HE/oLZSg
         /7qnBzYh3r+gRPevfWWXXjGZq7M8V3g9NzdDjhf/h0Tun0Km8OYWmlnYNBCHAg5BDoOB
         xlEaJ2yadP93EzOZ/VBqajsXhwajqNBuNQDzI6iqn8b01UJ8gDhrB07sfLYDEk7q12BQ
         IIA4ZJOlifKxsHbY3KMoL6n9BrcwZ2ZpVldrz8+V0voiYVWuOtHHl9Fv/LdMsTkUYHb2
         lE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779432896; x=1780037696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wJ0C563Ghgv+mwad+zKEpzaeJ9PbuKH0EuvqylaFOXw=;
        b=owiuSr9dI0aVPuJnGYur2B39cCi+1OxKVKp+7YRZu4cLHM3qbNH7E1P/e59zXnVCFm
         qurHCcEXVKow4WcAktpvFBsmreuiQfXODPawsMr0HdDUdkQGW/CaLogekZjzANTw4BVG
         gHVNaFgD7rJ7G/cJKe5tpXTM8J3nBKXLlN4jgbLmgLtoRRLZkBMyOD8CfzluIu+NIUPy
         bJzXfBdk/SHM57QOoEEl5nhKrXCNPgGF54bHfThhy4ZT79dM1OVqyFwYs2MRuhPrOyke
         sp2SB34iGeu0VtyB0UxrJ5vpd3nNaw+9NM/aP1TUgd3e1R/wa/BG7H82wF3JR07s8Vn0
         lhog==
X-Forwarded-Encrypted: i=1; AFNElJ+En/JXKazdvV3bPBMlMOH9J8K0WrN1hHZzOWwc2aFOagZ66Z8NnrTQtXx8RSZpPdBoIJAJ3xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QhGbY6Cau0n89Z6oCBHDqzJY6CzRhhTqgHLuGzpH9xwcMHl8
	4Zq9CSMv8xg68xeQPPVHAamg4mmChIMjpjdH/HniUEijnWQ6bSaQxj+U
X-Gm-Gg: Acq92OG3MI7CwNwsdd0+eUa5OuFAAGkVL3/9dPSbz8LjlixOeNke0TvoU/jNQyl4WwN
	6P2CrwpTzV8KcR9NCehD2VymZegxoBGkL8xLdBquvQMwnXIvoItlMdUkCGYlijdteGNpmkWK9L+
	WfkVj5GO4vRkBAbS49vIUcRSqQQ7gtveL6WelozqlvRwoGTVvNjXNVHg84di9zr5M60IzmHaE8f
	0QTSSA8fo4bJyXseQ6KAVvtbMt+QbFEGCcL8ZcUz7Di5GB6ZpAmXqYTncfpbz50/UvABG05f6MP
	7jWs0FL8hDd1gN5mZhQ/7mUVuTlWbA/r9T/5mfbsR3sM/rS+yXNIXjlpWgwOOHYCBo9QfxE5SI/
	+yC0MywXoJJzVbckiV4/jTE4pEFgBNgTDTfWsAw8xjvxQg18Acgw1+w8ulDBUEVCHnrsmoTWDD0
	FebpLpkV+0JyF+6lvwX5CnvTCaJUCyfRXe7us9GZ9zxbWjhGyZ5UlSjSIEQg==
X-Received: by 2002:a05:600c:4ecc:b0:490:3a07:c467 with SMTP id 5b1f17b1804b1-490426cf642mr25318265e9.22.1779432896201;
        Thu, 21 May 2026 23:54:56 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com ([31.215.251.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4cefsm9693025e9.14.2026.05.21.23.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 23:54:54 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
To: andrew@lunn.ch
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dev.taqnialabs@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2] net: stmmac: mmc: Remove duplicate mmc_rx crc
Date: Fri, 22 May 2026 06:54:34 +0000
Message-ID: <20260522065434.6231-1-dev.taqnialabs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2d702678-5b2b-451e-b692-228efcbbefc4@lunn.ch>
References: <2d702678-5b2b-451e-b692-228efcbbefc4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290685-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[devtaqnialabs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 12C6E5AFC07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 20:44:53 +0200, Andrew Lunn wrote:
> Thanks for the updated commit message.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Much appreciated.

Should I send a v3 with the Reviewed-by trailer added ?

- Abid


