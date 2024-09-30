Return-Path: <netdev+bounces-130627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2809B98AF18
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9907282312
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336061A2C3D;
	Mon, 30 Sep 2024 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYxrWxAI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A71A2C2D
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731738; cv=none; b=uXZMZ9VsbcewqKtkijHqSVTErQM5dxXkhGx5HXISnxXePWhVZDZ0T13NvP/O9lHnUlSmTAJWSK7UCFBy8weWcL9aVTJI/HI7x8ikQF9r1Q7QkGnX4skcUUbYg612L0fOjO+6lBZhCPNxqrj5Q/ACysUmJtLKcsLDW9+ZkrV8qXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731738; c=relaxed/simple;
	bh=+b+b6Tn3OXmS53HCvCZBXW/2EogOIfYrO87RHsFR1PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kHTH2nTknc4rkEXhxUrhj3CjFbwZVGH2ZKpdyf0q/VsMzyddROjpmgIqXWQk8aD0ZfaFideDH+CnnVwiIBMkv9jwhwqI5I5HxdAC+vRjIJxa/TjgXEhtQZDu81T+GYe+dn2egCWYq/rPwqs0Y5L3TPBOD6CUwfjhD5JYcCYSKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYxrWxAI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727731735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EdCk7+j89xI+EsUIjwYJo9MUWrLNgZqOLVqTSfJDRYk=;
	b=SYxrWxAId9ypvVFKbL1Psq3dgssCvfg54i67jNB0L7Ccd3AvoDze1A6r2+KtUJQdsJ0DNA
	k/yobqohwaoKv7UJ2YTh2mGzS7JJ/pxtGAxMSaRMw0gg3E1TI0BXRFAM2CfZHOcprcTt/I
	K1AT9AF9pdf8+xYVccqlCShxCNVLb78=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440---jF32aTOkuf6Xim-f669Q-1; Mon, 30 Sep 2024 17:28:54 -0400
X-MC-Unique: --jF32aTOkuf6Xim-f669Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-718d6ad6105so6875336b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727731733; x=1728336533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdCk7+j89xI+EsUIjwYJo9MUWrLNgZqOLVqTSfJDRYk=;
        b=jsEjKLo3VdnRPZYqGCQLslbnesfImE4r7LmdnhxFr+isvP72Gw8t0vMUL5eQJDkbWL
         BZIbn1rSsQ3v2jc0QhDlHt5J6V423G5DMUrUmL3e5tydAxTfrlWdFJQci16kwwjlkGKX
         BmltxsRMDsz/BOU9im3XTCplgJbta++xrzUEjJbnx/y/HlHSqnbhmF7SJY2Jplj++K8M
         hbkamr8lOi6mijCPkbzx7gjY2jWGcgeWA5JfeUBKhnkbfTZGrejPoSMi4SO5FyuW4Jos
         X4VKsReBD5AXYW+PT8iHtWnQ+HX82Z666oqXzyod1mgWRGDeph6nTibgPaktdQ1kDASi
         s8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWpgsdY8NckBcPGDdGF1XlLUOVGRS53bhCXQnOhbmCMHW36G+3Fp0drz3+6ByzqEq2pR3qMv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XD0o2W2K05c9vZjgB44vapdfSJD6Bbii70EwiBMtXFbOrt1D
	RC0IY9S/1LFGq0WalI3XQbJRsjlDyjKDi1yB/MEjsasa5tlqbHUZvusMpFJqFC9KRbHrKyJFh3k
	b6gU2YYfQV6TxucDGmx/vBAG+/ZF3a7ZVOJReHor37Xw+KlN0pSO/BwxRZJ54yg==
X-Received: by 2002:a05:6a21:1743:b0:1cf:6d6d:2e05 with SMTP id adf61e73a8af0-1d4fa6bb354mr21063800637.30.1727731732827;
        Mon, 30 Sep 2024 14:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8/U8urs1ZyXluufNS0Hap8/qkPT67talEPfm75uE6j9PZ2UYWxKTr1EHp3kzvId+HupepVg==
X-Received: by 2002:a05:6a21:1743:b0:1cf:6d6d:2e05 with SMTP id adf61e73a8af0-1d4fa6bb354mr21063771637.30.1727731732438;
        Mon, 30 Sep 2024 14:28:52 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26517631sm6708282b3a.111.2024.09.30.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:28:52 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 30 Sep 2024 16:28:38 -0500
Subject: [PATCH RFT] of: property: fw_devlink: Add support for the
 "phy-handle" binding
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-phy-handle-fw-devlink-v1-1-4ea46acfcc12@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAUY+2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNL3YKMSl2gREpOqm5auW5KallOZl62bhJQyszIyMjAIDFVCai3oCg
 1LbMCbG60UpBbiFJsbS0AZxa7oGwAAAA=
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 Serge Semin <fancer.lancer@gmail.com>, devicetree@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1

Add support for parsing the phy-handle binding so that fw_devlink can
enforce the dependency. This prevents MACs (that use this binding to
claim they're using the corresponding phy) from probing prior to the
phy, unless the phy is a child of the MAC (which results in a
dependency cycle) or similar.

For some motivation, imagine a device topology like so:

    &ethernet0 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy0>;

            mdio {
                    compatible = "snps,dwmac-mdio";
                    sgmii_phy0: phy@8 {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0x8>;
                            device_type = "ethernet-phy";
                    };

                    sgmii_phy1: phy@a {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0xa>;
                            device_type = "ethernet-phy";
                    };
            };
    };

    &ethernet1 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy1>;
    };

Here ethernet1 depends on sgmii_phy1 to function properly. In the below
link an issue is reported where ethernet1 is probed and used prior to
sgmii_phy1, resulting in a failure to get things working for ethernet1.
With this change in place ethernet1 doesn't probe until sgmii_phy1 is
ready, resulting in ethernet1 functioning properly.

ethernet0 consumes sgmii_phy0, but this dependency isn't enforced
via the device_links backing fw_devlink since ethernet0 is the parent of
sgmii_phy0. Here's a log showing that in action:

    [    7.000432] qcom-ethqos 23040000.ethernet: Fixed dependency cycle(s) with /soc@0/ethernet@23040000/mdio/phy@8

With this change in place ethernet1's dependency is properly described,
and it doesn't probe prior to sgmii_phy1 being available.

Link: https://lore.kernel.org/netdev/7723d4l2kqgrez3yfauvp2ueu6awbizkrq4otqpsqpytzp45q2@rju2nxmqu4ew/
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
I've marked this as an RFT because when looking through old mailing
list discusssions and kernel tech talks on this subject, I was unable
to really understand why in the past phy-handle had been left out. There
were some loose references to circular dependencies (which seem more or
less handled by fw_devlink to me), and the fact that a lot of behavior
happens in ndo_open() (but I couldn't quite grok the concern there).

I'd appreciate more testing by others and some feedback from those who
know this a bit better to indicate whether fw_devlink is ready to handle
this or not.

At least in my narrow point of view, it's working well for me.

Thanks,
Andrew
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 11b922fde7af..4a2fca75e1c6 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1220,6 +1220,7 @@ DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
 DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
 DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
+DEFINE_SIMPLE_PROP(phy_handle, "phy-handle", NULL)
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
 DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
 DEFINE_SIMPLE_PROP(pinctrl1, "pinctrl-1", NULL)
@@ -1366,6 +1367,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_extcon, },
 	{ .parse_prop = parse_nvmem_cells, },
 	{ .parse_prop = parse_phys, },
+	{ .parse_prop = parse_phy_handle, },
 	{ .parse_prop = parse_wakeup_parent, },
 	{ .parse_prop = parse_pinctrl0, },
 	{ .parse_prop = parse_pinctrl1, },

---
base-commit: cea5425829f77e476b03702426f6b3701299b925
change-id: 20240829-phy-handle-fw-devlink-b829622200ae

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


