Return-Path: <netdev+bounces-255475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NgKIZY9fmk6WgIAu9opvQ
	(envelope-from <netdev+bounces-255475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:36:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB3EC34D3
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFA1301D33E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFDB346782;
	Sat, 31 Jan 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiGuyhhd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DD356A12
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880972; cv=none; b=V0+z1+LpVo8KUPOOOtrj3k2UCt7zmggm6wPCsn3OtqZYb0OTIjFDH6q+abyGfxgYG2rAg3igqbJ/uCWJXKOwaM/P/9oUf7FHmoxwZLwStqcft2lJL6gIga95BuQqxl/A35YX02SLPiwyjU0+e7pOENfBJNOpFvHANza6bmZ1R+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880972; c=relaxed/simple;
	bh=/lr53/Br3InP7cp45n+9JHtA2MA4e9wqXARcsYlHWL0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AjaaoMFBJQCFXd8m2cdPaScoekNtSc1TRZkBEKIKyys/tjXDtmXXLXDf42mknLI9aEN1whLXFHkuPyfXspnrk3tKfw5dlLL2FRBQH9g3J3j1itUUKkhrXTuEForN1kD/xpxb7SqmdGM/fOz/wURjdvDvmJo/wamDDO8kmDTZOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiGuyhhd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so2583309f8f.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769880970; x=1770485770; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L88/pL/uB5v1vUw77PnySMROsG8lJfhLEJQu1aDyv5M=;
        b=UiGuyhhdoRhv+vKmX2M09WkTpBdhE63OsKOyvZAzmJPAidlDxEUEuOddEEpzdnzKN9
         UHaD9YwH0MqN0Hik6vCBdbLR9zhBYV02CZMs2HhoO58jw63z6K0rlSXJOEhqKh/gRljL
         h9OklDFYpGTq6Hi5MoMnv/Bo2JG7TUcyGXPNpxQjTvFaCnk14qaJHLaTql2ISK1NStxX
         D9KmcOi5P5zXpuxT56vY/ggi5wetuQzH8ypUzDUZ8/yzrmdWVRr7wks1RKHOhxYFXRs4
         XDFMwV9odgN+xf0Of6/dOQhGxqF+R8PIPSTi5UVaQ4wfOGvpyionDny7PJha+PgzODMD
         wM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769880970; x=1770485770;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L88/pL/uB5v1vUw77PnySMROsG8lJfhLEJQu1aDyv5M=;
        b=tymko9jiP9PUIie3IX+o9SGuiefTXWOuCZVEcF5Gzpt9LKvoZ/8+dH3tUgs7bA2e1u
         rlb66LLnenm9t4py9aS4blpdLmt1CUR/YhErJPJWCvHjbqkfTV94D/L8Jj9SWwytzdr7
         sHMNwzRc/ITsXxTsSHCpRj4VsAodHYsfPHAY93YUxg5gILmmBS9EFGVvpnMtxnMsKWTv
         mSO+GbLfAvDTmka47wcKBrj67NQrb/CQD8JglsXJ3bIwHahiQDNtQFfeWIKMH910xitO
         ns7w/P+N+jzn0YzVvBe7dFE0GbWMovX5SEvfEHCSY0tYOp9QdMUf/8EW8u67VehYeJ2r
         GqDA==
X-Gm-Message-State: AOJu0Yx2KTM3J0nmR1cB3h8O+1inwxlSK+juN5QzQuNpeJ52az52AgJR
	nuwL495Z1OnCNKf2hA8xLW2oTvs0v+ETUX8MP6TC/zcOASXRZhsK5sNy
X-Gm-Gg: AZuq6aLwQH0JFfYkpoqqw5cbRRvSgdx7HghmlXWroo894hxchN5+oAR1BdTvz0zftQL
	6ArlhNx48lqKkzoU18X6RHCqlpW6x7Ezh75ODSEWs4E+wqrKLe7Q7csFfmmUKf2Ht+4EPZzDQ2Z
	qiUNvzSREBQB2i+RjX2DEAZ22Hc+7rriVJEIs/jeOKE8A7WxAwTvoHmEBbVGqPcrOV0VGWa65xy
	k0vFKA3vKRI4pZyAh5NnVaTn5BnW8j4ddo8QN03NVruMwLIHWiONgvjNsIWIxlftDa7yKNUx1bT
	TSi34k85nKzGJgvK4pAPwg1ZMAH4Y5SfceC8t09s/gR2aG0XojGCRkvLmyD73Xq7cIab06QIUm6
	equskhwsHFcRgsrRPmXjNFFEzLa3D4fwhWqd0TOeYEExBwXx53leXWaZg6gYGczEc9YS25kD55L
	RzTo8nLLkwk40SZRuTim0PWTaJopvCXXQm4qiZ2+wkvS7rY2l38GEhzbfoB3qdH43HR+0cr8Lls
	bW8PLmKpsZPWDux3piuc29dhGoqfLHB3woTu0j/kkWgfJVl
X-Received: by 2002:a05:6000:240f:b0:435:bd00:3978 with SMTP id ffacd0b85a97d-435f3aba249mr9419172f8f.60.1769880969460;
        Sat, 31 Jan 2026 09:36:09 -0800 (PST)
Received: from ?IPV6:2003:ea:8f06:cc00:41be:d7:a063:4025? (p200300ea8f06cc0041be00d7a0634025.dip0.t-ipconnect.de. [2003:ea:8f06:cc00:41be:d7:a063:4025])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4824sm32362631f8f.1.2026.01.31.09.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 09:36:09 -0800 (PST)
Message-ID: <d9543e7d-23e1-4dba-a6b3-35dcd6a35dec@gmail.com>
Date: Sat, 31 Jan 2026 18:36:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/3] net: phy: remove modalias-based MDIO device bus
 matching
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255475-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,armlinux.org.uk,redhat.com,google.com,kernel.org,davemloft.net,analog.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDB3EC34D3
X-Rspamd-Action: no action

modalias-based MDIO device bus matching has only one user (dsa-loop),
where we can replace modalias-based matching with a simple custom
match function. This, and first patch of the series, lay the foundation
for removing modalias-based matching.

Heiner Kallweit (3):
  net: ethernet: adi: make name member of struct adin1110_cfg a pointer
  net: dsa: loop: remove MDIO device modalias
  net: phy: remove modalias-based mdio bus matching

 drivers/net/dsa/dsa_loop.c          |  8 +++++++-
 drivers/net/ethernet/adi/adin1110.c |  2 +-
 drivers/net/phy/mdio_device.c       | 13 -------------
 include/linux/mdio.h                |  1 -
 include/linux/mod_devicetable.h     |  1 -
 5 files changed, 8 insertions(+), 17 deletions(-)

-- 
2.52.0


