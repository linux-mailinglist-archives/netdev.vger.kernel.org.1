Return-Path: <netdev+bounces-284757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGShDvMA+2kbVQMAu9opvQ
	(envelope-from <netdev+bounces-284757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3064D81A7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACCEB3070A28
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A13E558D;
	Wed,  6 May 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUuYoN2x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C767376466
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057182; cv=none; b=uRHuW37DSzc49/ME00171IObe47rEQlGRDoUonZsib4wVKSDX81qebgkxbHlosbtfGP2BhdUT2bpF+aleDJ5e2EY3NJHsjnc18ksDaJTiEEVRJkcO6+awU++7Z6NpGWYo2dlrWmrf1FWayaYwfu5YS2U1ZVkwMLPPvAgs3R0eTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057182; c=relaxed/simple;
	bh=szoDOqUzU2bOU29+oChWEEh+cZc0HHzEKqtTD9+8r2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwYaKcJKQhgeS5XdLQ88ATrxbMjjTd8OjOrvHzXc3i8/hKgzjz0QctPpnCe5nzC0CmRZDDApqW3WFzpJJGLIFqZFtj9kwcLGsOrWj4cH5USBuQdPlLMppVgp85TOYnKuNcmaVKR7fc+mfivvNK9euOr706Ox6ua14pXHtQf7dCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUuYoN2x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad21f437eeso5433235ad.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778057181; x=1778661981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SbqEMIRZJlHc6JKkwETPU4424MlqTlraWGTdcFOX+ew=;
        b=rUuYoN2xTbGY5lRrA7EJ6DoVSOfZgX18GJHUo7OnXaagRUo5PWjM1Hml2sVaE3VyKj
         X2BLcHY9BZQqdXDo7FdIt6sVprg8p6su02Oclhtt7HVlelRrA3z4EWcFWDvXuGAH61a9
         /+HlzRYB9vMzPYOB6KVf+eQeaA0UdvIv0szCHmYLZFi188PSK575Et4j8BFx6FvjW0u4
         MGNMZsm9tZtllVlxtcCTu/SRgeMWHkIntMHvUAa/4ntvybb1P8M84WWfQ6G0Engj9lut
         97gcutzd6lcBVG3Fc9aJIp3mHFcRHtkrniHXYtMRqoVMjUG/ZawN3I0wRYWHA7tiEXRf
         9uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778057181; x=1778661981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbqEMIRZJlHc6JKkwETPU4424MlqTlraWGTdcFOX+ew=;
        b=LU729XvhnHOU/KaPV2u9rE9kMyYVfCP2ugDuvIMQxKl0ZYMk65AoM847xMqpGAdSv6
         /fdDav6tHkwfGf/+z7wX2yvXGbjzzRI3GTfdKBXQJQ+G196dfH6kyNmHdlPKl4TMQIhZ
         dPw7pqTlC/YDGTjP+HfbYytR2O8jOUvYIZ7L3QIUNdynGF/D0K1vUdENYHM0qsaL5USI
         MERpbZldSlGFhu0wjNf/1CztCnX7oTtN/KxNgDfu1kRSYJFen5EPVG2tQ0x1MpHy+l6M
         TaryZuw72CWW48G1Q84+SC0YXsbbuZnI9OoJiMDeecQT73lawgVqqLZi93XVydWOIUej
         DjhA==
X-Forwarded-Encrypted: i=1; AFNElJ9P5zNnhVilcxwsQUr889A2vG4XUPrj7IXlObi5fYyk7q0OWnSQBLSg/3VVwkngr9jVOCHwrAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NY1TRjCDHfkIBf78N6r1Q4OrDD2xrEKbSGk/3Kt3CfZ0o0ov
	mgshXLyWU1Mxc1JywlQOrszuRoug7Esj0oVhSj5LvnyOoAVifjDW+kpG
X-Gm-Gg: AeBDieu6nzP57Es6pFiHDrd44CrdDkbR7WJXhQoXFZ0lTzNHDda0Z2VCTNb5gdLJNBB
	2VKsY9/O7Nyfof73tGQElfXdz3ktfcljjgx8y46UUO6mK0c+4KdJGkqmgkOXTSxTCI7QCdxY6si
	5+thzlyZ7HJBx2mYRhcm2hrffKJU4pBDfETKDGtuKIcyjMXU0jZ+4H6ufqUtSXFb8kJxem56tz6
	Tezy0b+DhYVkls6RYhaJkCoPp5DNi9nqIunUyiAmP5lJqEzx43ltGC9uzXGShDmiqR7b9V7xxwn
	Nsrwszed3pQ5F3XnbkcNQvcQfyzWGJ6GFMOwmwUkVMkuD9+8+fXEmL9qbcPkUAeSIqyszYnK1Zc
	sjpF/UIHv+89Eb/mGCsGPdHM9eGDIP6Mu+eXW1g/Jd2felQx5VFbRM95YDM5ahitbB0kHPyT18n
	7baLMaV+P9jPr+IIkpuBjxKb+NpRvwmbYavvksEGLTDgiJiJ0GafDyBqku/vzqDnBNg/8eV5GLb
	XU+SD4bSfZvX4xsj2PKBPQ=
X-Received: by 2002:a17:902:c949:b0:2ba:1c2b:4d9d with SMTP id d9443c01a7336-2ba7908a658mr19665375ad.17.1778057180790;
        Wed, 06 May 2026 01:46:20 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf2d72dsm18985145ad.25.2026.05.06.01.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:46:20 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH net 0/1] net: stmmac: dwmac-nuvoton: fix NULL pointer dereference in nvt_set_phy_intf_sel()
Date: Wed,  6 May 2026 16:46:12 +0800
Message-ID: <20260506084614.192894-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B3064D81A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-284757-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series fixes a NULL pointer dereference bug introduced in the
initial dwmac-nuvoton glue driver. The struct nvt_priv_data::dev field
was never initialized after devm_kzalloc(), leaving it NULL. When
phylink later calls nvt_set_phy_intf_sel() for interface selection,
the callback dereferences priv->dev via nvt_gmac_get_delay(), triggering
a NULL pointer dereference.

Joey Lu (1):
  net: stmmac: dwmac-nuvoton: fix NULL pointer dereference in
    nvt_set_phy_intf_sel()

 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.43.0


