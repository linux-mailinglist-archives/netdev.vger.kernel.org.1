Return-Path: <netdev+bounces-303578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Z/tOiXuRGq23QoAu9opvQ
	(envelope-from <netdev+bounces-303578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:38:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1006EC3F2
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:38:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=N8Q7ocsO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303578-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303578-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47214302E70E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF05366054;
	Wed,  1 Jul 2026 10:29:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF223C09E9
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:29:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901796; cv=none; b=TAsekR9HC8T7w1wuH7yZ0RnUpTfVH8pp2ZjNIqp2jSGttrFT2jJpezY4b07msUmk2Qz1urfTvvMmIeUOiANBttl/+IGfQ84KNZ+Z3XHFVAkG5cUbusvlUe6Ib1/dgA6TWiQAGD487HB12bXG/jj2M3XtJ60v00OSdqypDTMpPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901796; c=relaxed/simple;
	bh=a4U8rQ9U8yPwro1DPxYVDCbokTGOt/Po5BbZSokWPDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddCnYxx7X1fVXuPyAvUUOSgn3twg2FFlcGLJH/+GC7jV6+/eJuZB2BjMgAav4JmAZpNWKGEXq1IzjO8OQ9pgmQomak+D6kB7UbMB1We+SEkPjyBIQmA46UWcxKFA1pr9oLm4i0L6orPpfXXZqphqIfBSuwiboSVvomCdCxFP4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8Q7ocsO; arc=none smtp.client-ip=74.125.82.179
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so1092246eec.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782901792; x=1783506592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZMCWACMwzKqJvaEkw4AdQSHyt0FLtQuCecBrJDnzH4=;
        b=N8Q7ocsO7YPB/s30r3aaiduEm/lQCavQR0yzBOYgPwcF8qPqb/D5B0FDxQpEFRiiPL
         KAunb0TgCuPRSxC1D4k02yfJfmRvgsk2mCUDdbyJDmBthdgVoH1xbeRtZAmeTD5I5ONG
         3EHMTjjiQe9WYzLZHPpz+FpP5cHY1pIQXdVPCxvrJ+orD0RrhDSyJr0YaAkGO0omh3OC
         mpOpXQ4IR/oozN47aLlsVkoU8DXSicZwcstYhVNsncfICdFmLvlMK+agNLBMcUDswSDT
         wCSt/ni0BxsscUjdtyUZq9Qf5fsxmAEsU6pAGfBr4G8MpviJaQ1FsbwiCpIQwfOIMxsD
         +ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782901792; x=1783506592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZMCWACMwzKqJvaEkw4AdQSHyt0FLtQuCecBrJDnzH4=;
        b=G2Ir0r0hzrX4E7WwYJl++tGw9+oUe2FqNH9u5ydvecK81YbzTxir2pErTCBCZ9k8iC
         wwtnk7MSKifu5unf1DVyQJOMQuND6bohGb7ZY08vLihhYYAaFwd7Ro+NlyZrUgucHwZT
         Tcrr/8ywSjsQU2n5Z7OQ0BGIQpMpO6jAovUZWpO2WaREnPLlOM0X5i16qHOznMxadbpT
         jxo4VCCLw0GfP8Fe7SgDJ+mfdlv7r+F+vb3mcarorVh/uO9KoYRMlc1gDFWFuk9Vysot
         9P+f2mt5czcsk7dkP2zzdXmXCNBVhCFN6u314N+0rCxqltl1KcuEmStTktiJrlp884dU
         fPdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRHTP1Cizb84uNVBxrYO795QSSid51HMA08Zyb0tVuqVcg8hjHIff9pSPOJmMeqlhVLKrQlmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/DwOgRSYwHeAyHl11VDNGyrEOPzaYjoZHSp5fLQmIcl2CWfVv
	18qLbvywhrXdVJRAmMDVOMxZY2Nkx4I0mzQuw6zmsNh7h+qS1ehofCHB
X-Gm-Gg: AfdE7cnZiQUpbOISR6RuS6yR8OnYuPRIQckSzBSuJ2x82a/B3R/xw80oITY5HXjmL20
	IMn60bgBIwOeAX6b/KAUkt/6OMDVZQsJRLLET/cnPTiaor1ranh7LzZsW22i09btpTG9NeTzAvp
	xeWA3DPeFW+IFo7I5PzKqX/k/lqSF/KcAfP7AijJET/hRDXlQxlBaIDXOvBQp2x4yDbtzyIE5lX
	qIQCtPt0FrcOh/aPy1aOSUVpGfMat+R+8+GGRaL5YnaqVsfxidWDamBGNYrxN2EGnG3VHSQtihY
	TJ+J0W21DIQr5+7S0bSkFPwGc52tO3tAqDnegse64eA1z+vCsw1NxuNulhYZhqoT0bEH4ehIV0T
	sUsfvdj+xl/TIKSRykDmlCrOffFpgdFr3ogQM61zRoXw8awYBiYuPAbFp0QFPGDgJy5ofhYT4ae
	Eb6+S7fZTxEIWENVU/2ZP2bjg=
X-Received: by 2002:a05:7300:fb8c:b0:30c:9f31:b604 with SMTP id 5a478bee46e88-30eff294ff9mr1275666eec.25.1782901791971;
        Wed, 01 Jul 2026 03:29:51 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:c5d7:7505:b0e9:be5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm27602019eec.15.2026.07.01.03.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 03:29:51 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aniket.negi@airoha.com
Subject: Re: [PATCH] net: airoha: fix MIB stats collection to be lossless
Date: Wed,  1 Jul 2026 15:59:44 +0530
Message-ID: <20260701102944.246106-1-aniket.negi03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <akS48y8gCJf-EmTP@lore-desk>
References: <akS48y8gCJf-EmTP@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303578-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:aniket.negi@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF1006EC3F2

> Maybe better mib_prev?

Ok sure will update. mib_prev is cleaner and more concise. 
 
> Since now we do not reset the MIB counters in airoha_update_hw_stats(), we can
> get rid of the for loop there and just call airoha_dev_get_hw_stats() with the
> provided dev pointer. Even better, just rename airoha_dev_get_hw_stats() in
> airoha_update_hw_stats() and move the spinlock there. What do you think?

I am aligned with your suggestion, Since after removing MIB reset logic, there isn't need to iterate over all devs on airoha_gdm_port. This will simplify the code significantly.

I'll refactor as follows:

1. Remove the for loop in airoha_update_hw_stats()
2. Rename airoha_dev_get_hw_stats() to airoha_update_hw_stats()
3) move the spinlock into the renamed function.


Best Regards,
Aniket Negi

