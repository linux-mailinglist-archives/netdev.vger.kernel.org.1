Return-Path: <netdev+bounces-200332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AACAE4947
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210FD3A21AE
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265F427511B;
	Mon, 23 Jun 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlgZeHeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3E1F94A
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693949; cv=none; b=Nv2DjGzg8916ULB1Rtcczat+iFVHKaSETV+5xd1/qQ6LzaXkkLO2/2GvKLSD4aBRWa79AJsQhnSq+H4pRKyD9Hv38MGLf8WgmuVJi8CQBDI3KjbslW80QUbsAHu+JB9fQpTCw7usRXfJJFsbHHb3skMwVfNOMe/7uqb0pY5Vi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693949; c=relaxed/simple;
	bh=swZyKu2+7PHKHRfwkdESPz2DA5ktsMeC1wvUcdYV9iE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QJl5ubddjjQcNwD9A5abQwvjERkllpIWYf7l6TvXhhv3+7xnGiB+pxhef0ZXblFlLzc3TGOL/vLin0gQWvVVairfhCtLZu9iEZn8Hl+v3JwstiF2tlxn4hNgf05H8nnvl8OJanlzC9gC+WoDVzTH7ryST/Q4lcs3x8LzuikLm8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlgZeHeH; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so45894291fa.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750693936; x=1751298736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFal6z5WdoJfwgoFuJLt03DQDW5DDCeNtwgGrqakBwU=;
        b=UlgZeHeHIkuOAOaEVdWdnGX1wdH55jWYILbP2qqJPNDLizckonbt4WBZIbwdCcirqu
         pk8EtxeER/JuXgonoCTZX/EA90U3J6zqU/iuAgBKNPFkFNDrlhcOTOZZ7jFntwHF3qDK
         4ZJnBN8MDOPiEESH5FH5mein0XUQdpVqRBIUP7dq4GqpG6oaqr4gyF9quON8rwK8/R6v
         qo14XXQv2o7pZ19l1o6A4OOYiyO79KYyNA+0zIZU70KMT2NW/UmbDnE/aMm4xVT6IF+2
         9F3idoKc3ixEB0mvfd87c9rsPie1+sgOR9egAHLf0PLJFte5/CIdMSyCXnNEaxfPI+Pu
         aH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750693936; x=1751298736;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFal6z5WdoJfwgoFuJLt03DQDW5DDCeNtwgGrqakBwU=;
        b=FJPxAKus4SPu85hgYDtNom8ghMjGEkNMWdUUFpOu/93rTGuOAGmQ7uFGLU9LtM7wRt
         jto3lRQiPVkny67lBXZeVa0HVI1CYFhCJ6aIuhs25hp+XeiTljjZ5L5JUnYFSk/IWUqD
         +i1ku5bb/+2naQe+6h4xRdrezCDiNgM7npQHIkP13vWkwAdbITnvbTZZpNyX68jLVdwM
         PP9HwWhDrDYBCv+9ajIIZxIkLWd8x2KXlGv8EJ6tb0+dqWag52wX8ayWjlFg7K2QWi/O
         TqtR/5n6NVCzxXYW54Hk14WiUnCdkDTbF/dWRoJ9SGRXA2YUGE6mSfJWmqNS8l8tWWu2
         N82g==
X-Gm-Message-State: AOJu0Yx5qFuMBoMJAKzyckdJhf0BjSSnVD9ekNMcwrfPFb1ipQajqowy
	Tj4YQLU2YQm7vAjOEFY1GIj53vuVvVqqMzSEZwWvs7bkHgeoDgA8npTGYNjxNg==
X-Gm-Gg: ASbGncsyHtoA4n46h5qhcGf+ic6h6aithG0H5IPBTWq5kgy1ct8QQM/bpQcz82Pto9u
	NoINHE/tTarHyFpw6EO+PxWggWQuUjhb5b6Zw3vkvRFYBTuDOCKUz+kvREuA2zpJnnxCs2zKR/N
	QvOfI9HTjMbOJo9Zzr5+CfB5LkVDjOoCg4J34b74LilKpxC+CCpA10mkpZT3KQn7E2bgSPh31Yv
	h14FB+knGI4MSv092HFJBh5fT+rSYUaIg4SqJYNf5ryU4f5SeYIz42nAKGyOc0B7ul0jib/HRLt
	z+Qt3CgLeo1BWcnLGdRhSOBs/KrkSNdbxuL4BK91SMkRpSvZIoyWcMHLeH7tHvnfdTMIQtKEFQ3
	924A/UHHQ5PEsTZ741SIvpg==
X-Google-Smtp-Source: AGHT+IGaNwpEJrZTNxHoZE/oSLL9KF3CSArRfcXIxUGIx0td6xC1EkNPYdREAq1Q6+TI9QmN2o5MwA==
X-Received: by 2002:a05:651c:4004:b0:32a:6eea:5c35 with SMTP id 38308e7fff4ca-32b98e8e669mr21686611fa.15.1750693935636;
        Mon, 23 Jun 2025 08:52:15 -0700 (PDT)
Received: from burken (c213-89-58-143.bredband.tele2.se. [213.89.58.143])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a3652sm13459791fa.64.2025.06.23.08.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:52:14 -0700 (PDT)
Date: Mon, 23 Jun 2025 17:52:13 +0200
From: Jonas Karlsson <jonas.d.karlsson@gmail.com>
To: netdev@vger.kernel.org
Cc: jonas.d.karlsson@gmail.com
Subject: [PATCH net 1/1] net: cadence: macb: only register MDIO bus when an
 MDIO child node exists in DT
Message-ID: <aFl4LSaVfY7sz3Pr@burken>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Prior to this patch, the MDIO peripheral was enabled for every GEM
instance, even if no MDIO child node was defined in the device tree.
In a setup where gem1 shares the MDIO bus with gem0 but has no MDIO
subnode, gem1 would still scan the bus (both Clause 22 and Clause 45),
adding unnecessary delay to the boot sequence.

This patch changes the driver so that each GEM instance only registers
its MDIO bus if it has an explicit MDIO child node in DT, e.g.:

    &gem0 {
        phy-handle = <&ethernet_phy0>;
        mdio: mdio {
            #address-cells = <1>;
            #size-cells    = <0>;

            ethernet_phy0: ethernet-phy@7 {
                #phy-cells  = <1>;
                compatible  = "ethernet-phy-id0022.1640",
                              "ethernet-phy-ieee802.3-c22";
                reg         = <7>;
            };

            ethernet_phy1: ethernet-phy@3 {
                #phy-cells  = <1>;
                compatible  = "ethernet-phy-id0022.1640",
                              "ethernet-phy-ieee802.3-c22";
                reg         = <3>;
            };
        };
    };

    &gem1 {
        phy-handle = <&ethernet_phy1>;
        /* no MDIO subnode here, so MDIO bus won’t be registered */
    };

Signed-off-by: Jonas Karlsson <jonas.d.karlsson@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 68ca6713a09a..e2b1f93f97e1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1024,12 +1024,11 @@ static int macb_mii_init(struct macb *bp)
 	struct device_node *mdio_np, *np = bp->pdev->dev.of_node;
 	int err = -ENXIO;
 
-	/* With fixed-link, we don't need to register the MDIO bus,
-	 * except if we have a child named "mdio" in the device tree.
-	 * In that case, some devices may be attached to the MACB's MDIO bus.
+	/* Only register MDIO bus if there is a child named "mdio" in
+	 * the device tree
 	 */
 	mdio_np = of_get_child_by_name(np, "mdio");
-	if (!mdio_np && of_phy_is_fixed_link(np))
+	if (!mdio_np)
 		return macb_mii_probe(bp->dev);
 
 	/* Enable management port */
-- 
2.43.0


