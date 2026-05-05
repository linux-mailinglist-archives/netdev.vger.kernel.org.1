Return-Path: <netdev+bounces-284230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP4wL3iK+Wnh9gIAu9opvQ
	(envelope-from <netdev+bounces-284230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:13:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9684C71DB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D1A301AD32
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2733C278B;
	Tue,  5 May 2026 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ6RXR75"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671142D73A0
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777961588; cv=none; b=se0wapgyLp4pliqQNvDXk3hi4H11Uzk6FyCY4sCTMNqPU8vfLBK4FqZeBkmY7HinwZK+65ygj0cOefjLYrbo5s7mFa0QbIyXVPqbXvAKxJN5cjSpiDw7BUpv9QCXKoSIhFDtuansaCfxcQuOW5Du9f3srM+s71BMDVprz3/KHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777961588; c=relaxed/simple;
	bh=nFhPLMziV1nj+jGf7ankzrrom1xqgWZNFBcno2gpuA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QasQFO0IQmYmlloCtRZKkchbYeIJtYzWxwQLl3lpMf7chZONiFlkXqR7DHwsgrq5bomjpHRQDFK+Xy+Da9Uh+zvsfVXOn7jdYvlF8ExbPKulKTjaOctmTAXSzgxm0ztrdN2NCM3Y5swbVF7gVCO4twPZXxPjEg9mZ8mJp0kcUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQ6RXR75; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-835386ff122so2062582b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 23:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777961587; x=1778566387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFhPLMziV1nj+jGf7ankzrrom1xqgWZNFBcno2gpuA4=;
        b=dQ6RXR75Stl952u3jkdq4gOhUbBrXOZH2zBteuhnuGD6UIaxq3y5fTPXX6tobLdSO7
         AfvO//QtiQ747UZJPE1YhNG6NgPC6fR6g7twBvpV1ejhGmGUYU45dzI2qWzef5Gibi+N
         UBmLcq9cB4jVf3BEe/NSweLK5CZexNNSTcTcDfIfwCq6ByxSbwGn3fPXYynZ1Ev9HmPR
         jfQTF1qPVEdbq2IBOjZJBfxvIZV7+tBR5QypTD3XwpN755d4VFa+19sP4GIwtq51Lw5t
         Kq+JoymFXviRJrREKwB3mwQEiIFEVZ6bKKlom0jI/ji3rmJWrrfT0rkdOXsYXI3HV6RI
         MSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777961587; x=1778566387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nFhPLMziV1nj+jGf7ankzrrom1xqgWZNFBcno2gpuA4=;
        b=icKKFMSDe5CzGiJ0Y40xXDvQlUf9cu6SiYHuNmL6ycQCHNvai4lphEENkyY6WSXsaj
         zZTgLTBIjkBt8pr/iSTJdzy/4doy1lW+AVgodASobXL/d8TAdUyDhc5Es1mi14WhS0cD
         DIM/oIcCFE7tOwg/jgE7Xg+dScmj7XS5nzconXPDO0BQMoAycPFRYM03EfWU5TEvBKdH
         6Qj03ZAKy6QS8MfhaGrHH6sAPayvfZ149u8F/m/npOOFbcNOGUrUOzklBX3atwSuR0Hm
         zMDaloU/ghOOtrR2h5db3OTOPruNDh3lywRxT57rtTRwanfq2LuJn1OEeKvBhjqNsCu4
         Nx8w==
X-Forwarded-Encrypted: i=1; AFNElJ/gAtXu6MKSEAGR037f18fCvPffbK0cNFbZDcSxulhT+UlYSfVdRsYaIiH0dUdKo1hZLPhIMrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwNG0KfIwZt97fJfmnuq9HeZg7g3E8TxLmhVZwlbUZ9jv9vX6
	TaOQBlzo0dVVzNYrMUuIfUxoW81l0PksDDjbcN3h5XL3zgYMfBB7Wl5o
X-Gm-Gg: AeBDieuQ1OSdTlYYcXF083ztvHRF/ghJLkbh4ztvxHpQuJ9506Ui67FuEvt6uWTCcAr
	FxxMlC0BX5ZAVEb742ChXtekXVun/ligR2oZNDkgaMpKya+RGpYWVGI/vB+gdVNyawgzV1IDWNP
	OQsi8svghDbr1yGMHRXEUO7zq/VW0I5i9JAUVd26h8QgN007qo3Evj1+Keh8QIQKB7yRRWRVJe6
	2sSGkpZ1YhZZGp3b1jdrQW2j7k/VAR+LrNJtSpQEg+kwoO9r8nN+gOJKFE7Hg44KgW+OVa20Tt5
	VHTrrn4Zi2Crj9THjMQ79w0RwZMayuHdOjidriA2DZO00XxbZULFwjA9qVE8lF5R7I9HhVsxmp6
	jKFZGSqtWm6JoEfiQG2SrYvl95jyjFVxE2UU9f1XzgwmYUWDz4tg356GDwkfnkOANEWpsUrKKoW
	ZSCubG6CE6DWS9PzU58P9VSLIjn5ZvOMxpaW839nYgxb07++q08gRg4cv7+nshrX9SnFQ1Syar
X-Received: by 2002:a05:6a00:3e27:b0:82f:8b20:9165 with SMTP id d2e1a72fcca58-839249b0ea9mr1813305b3a.44.1777961586687;
        Mon, 04 May 2026 23:13:06 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf16sm1070558b3a.40.2026.05.04.23.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:13:06 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Parvathi Pudi <parvathi@couthit.com>,
	Roger Quadros <rogerq@kernel.org>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net] i2c: sun6i-p2wi: fix of_node reference leak in probe
Date: Tue,  5 May 2026 11:42:22 +0530
Message-Id: <20260505061222.319845-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260504164750.5eb6c55a@kernel.org>
References: <20260504164750.5eb6c55a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B9684C71DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-284230-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 4 May 2026 16:47:50 -0700 Jakub Kicinski wrote:
> This is obviously not something that should go via the networking tree

Yeah, sorry - mis-routed this. Wrong recipient list on my end,
please ignore. The i2c patch is already on linux-i2c.

Shitalkumar

