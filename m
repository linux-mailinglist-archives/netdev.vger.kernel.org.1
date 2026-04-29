Return-Path: <netdev+bounces-282224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPrCIHxx8WmggwEAu9opvQ
	(envelope-from <netdev+bounces-282224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:48:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FAE48E6D1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 012A830125AC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F367302163;
	Wed, 29 Apr 2026 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzjFJO6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8132B989
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430884; cv=none; b=J7qtnXb8VoXo1DySR2SfCNOQorc6fSOweNrRtTd+2iERCrz5FOPBLA1KCfPDMYpYDx4M+v6AEmy37PRZ+3i4z/90iAAesnYSGoLYaoLkvc9i+V7CIVkYzpmokCG1ur3Zcdc4+FBDw2hTfECVzzAi3NIXtSeivXQKVVu1qOkgf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430884; c=relaxed/simple;
	bh=BEwDNV5ZvB7DKXfU9N/dZfDyt9yeEFmp1EfwD6tVK3o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZYZxy9O//ls5WJEbjZZtqOyaXsu4Im4iPiKaSRpWIyoGelBVY/klEU0uTfyWZ55yhpqox30nCbiywle59zvpXYjxKmhExbmnfZacex/fA//hS9ibt99sArtdSKDbQOkkVmoW3VP/PPlMxLFPz4fk3w6ohD1uUXaawBbpsrab5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzjFJO6w; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501d242e3fso11677446d50.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777430882; x=1778035682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha3nsTqMSyARhORrKDt0F4fUNBg/Feqx83yQHXyNT3w=;
        b=JzjFJO6wRDAJdIcX6AFttkzopy1oWOddnV2gNr9zfnvl/uB3MOiU4r/2WuhbEmJRpP
         pD3+uMHFifTv6J/sv1oHeTkDiGDE1JjahiW7d3ZhQk6P9l+HG5zmduuru3iHDpLno4/a
         9StB36guevs2J4TXLYTxeFBFdzKBkmROgO+J+TdxJVt0Nnaa52cQRR41bS0pkvvtCFpy
         Dty8Hg6Ts9jU1vDWWksPQMuaCHSyAREfhKThOi1YCRJhSn+SLpQ0eug44RCJr/TjSajV
         dT6rumyxqCUyHLceGJE2UhJhpBXeP1HJFBxvnI7fDlb2b8gz+szQEuZkqgaGuwsY8AbW
         3k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777430882; x=1778035682;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ha3nsTqMSyARhORrKDt0F4fUNBg/Feqx83yQHXyNT3w=;
        b=r2XrxFCde3deme5eH9OFo8teKc3xvLuI0Hp8M5lU84PfebQN1noRtaNoeDIIFGAZy4
         1Wc0UbfzI+6/igUIEsVp2ek1lWdokalz3+KJr6ZEcxZGEcDuCezZu9W2/KTMSbN79Q3y
         B9/HOUeWEAbi9Nuy8HXJVby/nE6ydfn+2s7yu87KwPdpFjMDFE+shnrhGxaeTm7+1WtR
         IaKk2S3SSFJqmxfHvzN18nPUUMDkHMoIQAI3t22BuIPajoMowozQXF8XO9pBp5k1s2lg
         o3aVrKe3zGWQAaTqMGDvTUiuS7JIg6QHI1QpzQeJZKMA3EpJOOeOj3pHGwDJSMmEjhkr
         JaHw==
X-Gm-Message-State: AOJu0Yy76YJO0vcYaRZ83uDpyhwzIGpDh4B/vOHS0KRPd8VCRMJrgSyB
	0psB4AiSpfEIC1bf4UUB72NIJDfxT73aO3+BaTVNEjLYrbM/HNwnlg8c
X-Gm-Gg: AeBDietUf0C6pWoMXnx/XEUe2BgOjrBk1R4nJF0ZyZzON0aUc1ln1IrUMnWk+LoteM/
	hViH9AsCzbALxEfa/AdAXPLoTYKfC5BNOQ5Jgt4K+qAAI/WZ6xKrGgdHRoKp4aOEZYo1EvVAQRk
	a7Bki9CV28YrIvGe1FhWlOGH8Dblc/XGXLov462ymQLyoANluLOw2XMEysSwA9kD0Gf2Ibfhsrd
	K9JnmLlBxu/rrS0oRt3h/qOq54wnjtGuWGc+UW2FDeAp5FyBFdcSoSrry65Ms5LkuDsE84wg0mK
	/Xf4/nCugUBux+iPDzth4IxmQgefSSMyu1sWUtgt+GANxDL8rRKqfkeIhMC9+05xaPmqsr+VGdI
	ufMnCgR9IB0H08hs2biN/6ZGCYHVVJ4D6k7t5md+DE5CYEa+OYnGTvTbfT/YR4FGxT27dM+sANp
	cD4Yo5+HAxhxF2OtV4Y+1zIxqQB3znMeh3GE+0bn6FIVooryRD/e1Y28HQCDx5rVjSxl01460E+
	p1kNb3KjV5ZJvE=
X-Received: by 2002:a05:690e:2415:b0:651:c321:9d0 with SMTP id 956f58d0204a3-65bfb6c6e90mr1772868d50.32.1777430881960;
        Tue, 28 Apr 2026 19:48:01 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff6c9302sm671297d50.10.2026.04.28.19.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 19:48:01 -0700 (PDT)
Date: Tue, 28 Apr 2026 22:48:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 daniel.zahka@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.ccc060738f16@gmail.com>
In-Reply-To: <20260428205352.1247325-3-kuba@kernel.org>
References: <20260428205352.1247325-1-kuba@kernel.org>
 <20260428205352.1247325-3-kuba@kernel.org>
Subject: Re: [PATCH net-next 2/3] psp: add a comment about a psp_dev add
 netlink notification
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B5FAE48E6D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282224-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Jakub Kicinski wrote:
> In psp_dev_create(), the DEV_ADD_NTF netlink notification is sent
> before the device is published to the netdev via rcu_assign_pointer().
> IIRC this is intentional because a single PSP device is expected
> to be shared with multiple netdevs. So we are trying to default to
> not having the netdev info. We can change it if someone complains
> but for now just add a comment that it's intentional.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

