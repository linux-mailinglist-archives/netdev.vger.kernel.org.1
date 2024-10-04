Return-Path: <netdev+bounces-131919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF59D98FF0F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B03282EE7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D121494DC;
	Fri,  4 Oct 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnAdldZo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6533146D7E;
	Fri,  4 Oct 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031648; cv=none; b=YNzsVcNZhCOOCDsxZIbSCio2ugYMCZOP/4YZ0jeqa1gHRAOd+pt0FoyyaOKVMoGT3Sl2wlF4VQdO1BdGveg7HJ5huYWqtB0YZAwD0eKrVjrqokperAugaXdlHiFfUMgnKsOdxF9OtdwjPK7Y3MCiMvRiP2cAC86IpvTXQBaJ5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031648; c=relaxed/simple;
	bh=WrttW4soaNRNeFDh1G7yiAsAT1m0YpQGlJh37KDgp9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BexI051ZDe3MfW/hzNK/4JtQJPXaVUlb4+ohxMc1TJd0xF0dsAuKOSpjNtd8fptOhxA0ONBdRctLWc8OHCw9mIg9UUkkTmHWwRgqT31DU5lfuQeJzu5yVUY9NV3GMmz5itJ69bIqfKa1AIl+VbrXgirR7d7Mt1H5Lrq3w+1/Kc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnAdldZo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so554659266b.1;
        Fri, 04 Oct 2024 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728031645; x=1728636445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmV9RYJBwVbGt572Wu2QKdQNVKD66Br50FGjDXtR6Z4=;
        b=GnAdldZodCn/BF2Xn6h8MJdbMZC9UA7fNTyOYQetDCQJ0OYoKTkaRIO4qWqqObsbCv
         /vElG3VaxOKqv4Qb7RuxYmvZhXaFjgrd/DyqkAjfYTdH/eNVgL8wlCjDlbsj2Xcnj54F
         RoqrvjLSo2AlX5NVMHZ3Jyw2cMx5hvxttfhwh+X6P/psYEqh+EAncyC+2j+G3IPboLIL
         oRFqF/+d0ypDmd2Vz3CuWOy4oFY4ENUzCeUljp7mQzh/IUGx36XCtLqRP15iLwIgyUEv
         OHmZYO3UZz9MV+ChWHBJZDjGok9haYiPRcgJ3F1NQaMVj1KqdCC2mo9cCI9asKSc8fff
         cIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728031645; x=1728636445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmV9RYJBwVbGt572Wu2QKdQNVKD66Br50FGjDXtR6Z4=;
        b=twT7BGxXVLUmBlVD1TAYgh78F1+3CvjuS/rh1pUSEY6l2VesI8eiZp6QYYcpPvYYYr
         Ln3rXxTLsHpj4wJ3hNuZBZHzdVAyPtvu2H91KuzkdzHZTgGfHFjtcqTXuRUnVzhN+H4Z
         4IwEzMm7/4Z5Avmp4RhB7BrKVJtwuaVSu35zLDGRHeDJWGRHzjIELTcqZVfPjYZN1JHt
         JjnOvngmK/fVHzYW14PA8tUyDDomd1A1luFwkblw5M1XmLgKNCNG9NR1KEH4dqN16/XH
         Zm9l5t/DKXXhLM2FFo2f6yNcxfvD8fT2ASwouUZQrcqZRlOX24avlIGGWjJ8oFEDirI9
         9/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK6geMJnxk5dBB2IzlJN1ichPlQXmJirGvWtnLvDc5fu2fuoJnj1d7fvYCzgFGQeAcVrL/EsrH@vger.kernel.org, AJvYcCXTQoSS9B/fDDxenOV9O8fFK+2tHVaricb1QgG5+c+PZmGcYtYxdYDE0MzxgYS2vb7VdhF+KDtnAumQWZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXxRWeSR2j0Z93Yxymv8rNUPOS4nwtWReo+sdRz+zelQTbA+3K
	ah6tgA/58b5XSy272QWiCHb1vzzQTi+a2ZXJG+sRnITS/+g6adnE
X-Google-Smtp-Source: AGHT+IEdiuCNJY+e+Qi4o2XoAyut/1S9hpI/xHgeuu7ykahW5fp61ZS61OqxId16MWjakDnvbXt/cw==
X-Received: by 2002:a17:907:1c05:b0:a98:c4b7:7971 with SMTP id a640c23a62f3a-a990a23d7famr608823266b.32.1728031644866;
        Fri, 04 Oct 2024 01:47:24 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a991027ffe9sm193521366b.51.2024.10.04.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:47:24 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 04 Oct 2024 10:47:21 +0200
Subject: [PATCH 5/5] net: dsa: b53: fix jumbo frames on 10/100 ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-b53_jumbo_fixes-v1-5-ce1e54aa7b3c@gmail.com>
References: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
In-Reply-To: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Murali Krishna Policharla <murali.policharla@broadcom.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

All modern chips support and need the 10_100 bit set for supporting jumbo
frames on 10/100 ports, so instead of enabling it only for 583XX enable
it for everything except bcm63xx, where the bit is writeable, but does
nothing.

Tested on BCM53115, where jumbo frames were dropped at 10/100 speeds
without the bit set.

Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 5b83f9b6cdac3de6c5e6e2164c78146d694674cd..c39cb119e760db5fcbfaaf44abe033f6977e7005 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2264,7 +2264,7 @@ static int b53_change_mtu(struct dsa_switch *ds, int port, int mtu)
 		return 0;
 
 	enable_jumbo = (mtu > ETH_DATA_LEN);
-	allow_10_100 = (dev->chip_id == BCM583XX_DEVICE_ID);
+	allow_10_100 = !is63xx(dev);
 
 	return b53_set_jumbo(dev, enable_jumbo, allow_10_100);
 }

-- 
2.43.0


