Return-Path: <netdev+bounces-64086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8FE8310A6
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 01:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C481C2179B
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 00:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821941371;
	Thu, 18 Jan 2024 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY/eDfO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF0A55
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705539127; cv=none; b=jLMnth+4dih5sZBlggHfq3pHhQkS0uU3kJkIajJ9iaIlbz667m2F6yaxojJ5H3+pzbaAXYa01K1NKR1e4oQJQpcc36SUTcofca/RvQeVjIztxPI1U+ZqmqmjtiBCSWArDCSjFfExArpPW25ztz+WmJagNnRZYIP0pMS3JAvmWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705539127; c=relaxed/simple;
	bh=Uhs3ChGhTd1IPwiVdp+Nt+jUGUjZ03jLzU4dczpNvFc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dtSgPqtWJAe7dD/SGZYtMUD8optZmBs2XskTiOE7zC8jiYh5C4s/skzdWJGXsyPDjeNm6zzRzEYAowOd9SP+veIX0dFEybUWYpA9WZtjLz8sy9zQPl8hRlHOtzZlat0jAP5JSMBFO4r+XXCR7AhDeNrM/2DfPT5RRE+Kb+BMWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY/eDfO3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2dda9d67ceso436292766b.3
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 16:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705539124; x=1706143924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mr5k0hMLv2t9QQAvs+E8zZFRhSBKpw1uzL+2+6HyapI=;
        b=kY/eDfO3No12W9czOF1Y/QVphJlHFgaZZACw5U4CQ1rnyi57yBXQrxrYxRl7bpMjAG
         v8mCH8Y0+qr/N8xZLjKJNDzPrGF94FPIt6CC18v/o33Sg4A8pjxvjdSeP5aHimcvVjIR
         tn5BuWEo2HSvYQv4af7kmd/sEddw7ad8yk6zq4crfiYSRtawYkfj9pL3kqB379y0G9EB
         A72QxGOrqqI/eRqStnSUrBi1AWW42nC64ZVIgAgrNC+DYurVsQYiiemBZnynhyTkONOD
         eL8G1fiJvtFtTh8TrZzoQASIr77WkIeHhE6ePnCk9ZNshgllQvQCNSu7pFKCjhdOJasg
         sRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705539124; x=1706143924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mr5k0hMLv2t9QQAvs+E8zZFRhSBKpw1uzL+2+6HyapI=;
        b=SsAu1StDR1NMbWg0e4XdA350/ixP/h0DETzLw0TWHbhQcdwWsm0qaEWa8HgiRpK6Yc
         ywXng/LgsXCGOw2hdURDeVsuDN4v5V3GiToy7wpBhHffN3Ryc3V9cWWPQHCGBl/NAwVF
         5+YLbe2ehRTxSaddecoYmvRwzRbQbYAXogCehIROXtXkhO6qJYaNlCogIcd5hUMSp5jR
         ND6wzPrUBzWysa043b57vQzg/fpr6xlExrf118kUnNNrIidTVjim1bIJ6oNR+BPf1nRx
         h0gof/GOSmhlZV/K4RdXUCShI9kC3Go7qElLrgHtR/PU7/lG15tXDwVJNijsH811BLem
         oL7A==
X-Gm-Message-State: AOJu0Yx9PaAfKtH0Rj7eDHx8Wm9zdulDtuznpRZqrpEmFr3q6U5d0fHc
	FXHZmPjrmnGIh0P/RNWL5rqa4GKcAqi4xZ/JsFIMbn1b9hVoWbZr
X-Google-Smtp-Source: AGHT+IHY5ToaAEX6VVHH/UFxvKYU3iPlO1P0JiFX03XCqkrvG4XnOxaoj7/2lAaEJ8GUHWDhwXLXDQ==
X-Received: by 2002:a17:907:318b:b0:a2c:867c:43e3 with SMTP id xe11-20020a170907318b00b00a2c867c43e3mr17585ejb.86.1705539123746;
        Wed, 17 Jan 2024 16:52:03 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id gw7-20020a170906f14700b00a27741ca951sm8377790ejb.108.2024.01.17.16.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 16:52:03 -0800 (PST)
Date: Thu, 18 Jan 2024 02:52:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Simon Waterer <simon.waterer@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: DSA switch: VLAN tag not added on packets directed to a
 PVID,untagged switchport
Message-ID: <20240118005201.zxpk3r4agkl7y7yi@skbuf>
References: <CABumfLzJmXDN_W-8Z=p9KyKUVi_HhS7o_poBkeKHS2BkAiyYpw@mail.gmail.com>
 <20240115181545.ixme3ao4z4gyn5qq@skbuf>
 <CABumfLwA5xMiag2+2Rjj6r12uqvnsTjrNGfp4HDp+pZ7vw-HLg@mail.gmail.com>
 <20240116131019.wmonfumccn25kig3@skbuf>
 <526bf36a-f0e6-4149-90c9-16f91ff039ce@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526bf36a-f0e6-4149-90c9-16f91ff039ce@gmail.com>

On Tue, Jan 16, 2024 at 10:23:30AM -0800, Florian Fainelli wrote:
> Since the proposed changes were not in an unified diff format, it was not
> clear to me what was being proposed, but what you are suggesting is that the
> following should be applied to b53?
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c
> b/drivers/net/dsa/b53/b53_common.c
> index 0d628b35fd5c..354dcfd23da8 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1556,9 +1556,6 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
>         if (pvid == vlan->vid)
>                 pvid = b53_default_pvid(dev);
> 
> -       if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
> -               vl->untag &= ~(BIT(port));
> -
>         b53_set_vlan_entry(dev, vlan->vid, vl);
>         b53_fast_age_vlan(dev, vlan->vid);
> 
> 
> or did I completely miss what was being changed?
> -- 
> Florian
> 

Yes, I had this patch, notice how the entire 'untagged' variable
disappears too.

From 67ae82a8ba11ebc992ed8450d9ded3f39700b341 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 16 Jan 2024 18:58:40 +0200
Subject: [PATCH] net: dsa: b53: remove use of vlan->flags in port_vlan_del()

The flags are always set to zero by the function callers, i.e.
br_switchdev_port_vlan_del() and dsa_user_vlan_rx_kill_vid().

This makes the vlan->flags handling in driver implementations
practically dead code.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0d628b35fd5c..3b071ef2d836 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1541,7 +1541,6 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 		 const struct switchdev_obj_port_vlan *vlan)
 {
 	struct b53_device *dev = ds->priv;
-	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	struct b53_vlan *vl;
 	u16 pvid;
 
@@ -1556,9 +1555,6 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 	if (pvid == vlan->vid)
 		pvid = b53_default_pvid(dev);
 
-	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
-		vl->untag &= ~(BIT(port));
-
 	b53_set_vlan_entry(dev, vlan->vid, vl);
 	b53_fast_age_vlan(dev, vlan->vid);
 
-- 
2.34.1


