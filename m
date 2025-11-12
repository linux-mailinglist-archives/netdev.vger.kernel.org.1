Return-Path: <netdev+bounces-237816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0C9C5082D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09DCB34BAFC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 04:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383662DEA7A;
	Wed, 12 Nov 2025 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnioBE+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2B2D73A8
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 04:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921708; cv=none; b=VB6ExkgZvkqyCMjjSaicgP4+Av2ctNky6+QhcFfenV6NBh7Hb6wUSpJxv1CuxjRet60enjhUZ45PS1Cv/40y7ojhyq3wRyY6NRiV2iKgW+AC1HraX+xIy0VpHDcVS3F0FIB0GBkqO/oL1a48gBn5fjLHpMLhHIEhXeolJyUkzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921708; c=relaxed/simple;
	bh=zP/NG7w1+KArs879n8cQJzWDunWwyIPS5O4paM2aWv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4QnuYgD8IT53R0b5YGlLqZuZAetTS3iNQ73YIkkjedmAnhpT4fljCjUZnIqbA5Pn58ny2enU980xn/+bHoojPZizlhQHQyy40pggKuOhGSiFua4/g1q0fUnfCH07SisCyrrTAmU4gcUY4Kwpx68NjpoxpPDhmH33r2ihkT0hyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnioBE+9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340e525487eso276509a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 20:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921704; x=1763526504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkGiIciWDidvQkbZlkaOibwVplEAw58SDT70kiDe31U=;
        b=MnioBE+9RluMS451pD6BCq/wgG9AjNRfLpn3OOC6f+TMcIvVk0/QKxcdwKXZ5j7RKz
         IXGk9ZbS6MQqb9+Q81yvkIDMcbyhlvmJ02GAISA3RgQEnsK2hwieOmHZ7PrHm69r2btP
         yXEfqYVr75TfX3tmLmgKCecYybtptcijEuAJSv6IqQht7VDsqfO3cRwzoepmlQOLABf+
         +ZhOBP9Vh5VakngdMhP1UU/Cl7dkDRWmY30DOJNsNoaUSBYebRGgVB7iLLQL+hvtsYW0
         sf+PRnXJpRZ5XKtr1Vcdchvbs4fQVAzOBCj13NbgEzR9m3buyp6iuyW2IJqEA2t/2e9Z
         Y5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921704; x=1763526504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkGiIciWDidvQkbZlkaOibwVplEAw58SDT70kiDe31U=;
        b=mXWOqmbYOnGJKA//0Pyl2ObRtwuwhosl3alU30aQfQG0hoArz5PQ4rs8igcro8td6s
         zgw+LBGowqEFUUbtheg4rjFhgIlAuB2O/oVY2ZP3YTcTE7oB3y0RbZBgUXqN/sTTL6v+
         TvlKMoCrhFhpO0klmXJxHoeOS3ETrOT0TV3qKDtI4+AZPnqTW4/RAiF4h4D4WVSNgXxv
         epy0kV1M/+rBGeIF/31h9fz+kr+xLlDapeGiLy/Rki0r2m0yiNmDy0jotsx7v8NnsP9K
         GLy5bip2KSSGAXW74Cg2N1YS4vqiDaRxdST0QWhURg3t3RFanZ+V4yx1bkhVYDd8REDK
         kcKA==
X-Forwarded-Encrypted: i=1; AJvYcCUPUhVOmDxRJRiKY3vhKFBLh0F0pp/5seTzz4rbKMSwc9bhS+UCVmU2hJve/BJYiX8AWaJTNmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpkHAnENhvH8fTEig46Ci2A3sIgQL3A4Nd+uaAuKYNmitXUkl
	cXADdGP3Oq4VQNVwV5JwU3SU8YmLdxPcPDpl1l8IuWs4xdce1s/36OPF
X-Gm-Gg: ASbGncuIGvXlBlAqGyaTo29CdCHBElhfvbHhuIjX67kJNvy69fM8TpuwHuZ2y4MjccV
	tMGiURn9XeOCCrMLBJtl+/voCDleMntFttcm8IsP1WU58cCmdjYSmMpXwoiNfTlNDyibaeQykcd
	9MaR0m99nh49Ku+UFG7O8X0EiZpKp1hvk5da2qzCNEIfTZVt+2ODcJNjBSLtH47xCrv30+EHskZ
	saHE5vzf90qvgIGgjr4lh2XZS8s3119DL0Cwyu4Yq0b/mkNA4Sab7TUNlquOnE+IHlLDCY9CdZ2
	+gIKkUpm0da50YhowtgUeC8HgbQ4QzJjOFsAk1ufYnFkkW+DrJ94yFlECF4wDzwpXvQfG2WtLeg
	ep/TYkUvWnHdUzazKbVSQwCtsOCPSSZtRPxHCTh8I2PoFqk6qd75NQ4hPmDWBGe8jfDC9sOy1vq
	oQXgLH31pYZTJlFpziHcIS1DmYupIP+UUqXvHyPdGkpSQP1hVH5ujurc4QKagmVg/HD+eHXvROu
	BD+LnkNnw==
X-Google-Smtp-Source: AGHT+IFz599JMY+HbLZlN+Y4HCQji4lI/mnZmgyLfcZAZDfwLpsK/Yd65k0yw0c8AJv/WsCEFQFd3Q==
X-Received: by 2002:a17:90b:4b89:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-343dde81845mr1915818a91.18.1762921704526;
        Tue, 11 Nov 2025 20:28:24 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:24 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 3/6] net/handshake: Ensure the request is destructed on completion
Date: Wed, 12 Nov 2025 14:27:17 +1000
Message-ID: <20251112042720.3695972-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v5:
 - No change
v4:
 - Improve description in commit message
v3:
 - New patch

 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 0d1c91c80478..194725a8aaca 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
 		/* Handshake request is no longer pending */
 		sock_put(sk);
 	}
+
+	handshake_sk_destruct_req(sk);
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
 
-- 
2.51.1


