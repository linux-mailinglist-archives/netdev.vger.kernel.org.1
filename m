Return-Path: <netdev+bounces-181753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F4A865C5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9252B1BA18C3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B8269894;
	Fri, 11 Apr 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/18xSVc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B81F8BD6
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397348; cv=none; b=Bjm6wB1SfzYs+W+dsct3Mm1HKamc/A4uB0UO2RHzeDXaLQ+KX9xFT+OrCOiz8fdwRlCjJhVRkiH2/CJItoU7pWn8ys/F4pH3MwhI0kHs0hyrvNuhqAG9unUqo0vh3G9V6OURmhkqrHKEc3B5KFw5+Z3pNqaTlvlUswiGpQcFEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397348; c=relaxed/simple;
	bh=NfQ7udwo6RjripPP2cHolZz7alvS/XkqtPRRl3Mo7i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8e2ozvhphwEwvDJj3T6AK44xDTSr93DcBA+VpDy1jKa8wMIw7WoDjSc8oUX2Kq5N08dzurH2BSeRbBALJrnrmd4KznGdpw+qQzZbP7INaomX7IuUEodkN6VIQ3Wk16z+fKwMu+PU3xMx4qWmOkqCxKoeoP8IVjTsx1FdK2ZjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/18xSVc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d64e6c83eso2916575e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744397345; x=1745002145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJDF4+dOw2KNAQE83quVhIfgCCxP21E5HmkpgNBx4Ng=;
        b=P/18xSVcidr3wx1cE3NOwTvdlxhsq6R+Ft/yzQRu8nKgjOj5xuwl0U6gx0MY4pGkIR
         AAEf3qZmtt1VowalvBXYZD/jY3cvGyurB/IKoFb7RxWaKY9pr943FZk9L7xC+OiEUITD
         ZJXkUlH6yGXP8WjbHgeqPp6W0Uq96j3YPqDIWFahA/muL2a2iZ/+13NOSBlkmELcw2NQ
         G+k/rOy9NcgA6LqD7zsBNM//XQk18J0kptb/nZuknoSYMlyj9/RWnLZ8qyEtR68+pXLV
         MCvoUN9LDcls9+eHh+R9y1nVnHdpGWEMKh0RolGWy/tRDCMjNpmQiUlQKjKuXUj4Zzrv
         3trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744397345; x=1745002145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJDF4+dOw2KNAQE83quVhIfgCCxP21E5HmkpgNBx4Ng=;
        b=INj3/MQGnvlxwl58ta/0xiN4T2fe37qJZW8UIS147ubdb7lVvZxC1AR7YqIyOS+2G5
         ihiW12Chh9MK8R8DRMJA6Q4pdDabhdzNNm/w7NPTAvQtumcPb3kaE+W2lX4YWV7UfVWD
         3MqWsjsu5wJg2ZQZ5crzs4MoDFDKPM3q0vWijWz7SXo/nbv1IQr7Wb/GxqkzgRbYg4es
         /4/cnEdX8ASUkD4aVytef11jd9Xm9EXBeMS+hUssGdwDcdI/btdTmn5YHoOCJm47VLiK
         60PT0QkYTBNQKzoKa8Ajxfx5ewxg+IrJzeluNWw31lvj7oQjJX/DfbgM0utPVTZT+5Iy
         IvKg==
X-Gm-Message-State: AOJu0Yzxs4P6UAhiKDuIZXlvl1hQezvcA4Cx05fUrl4t+29vy3cFc4+7
	zOtQ/bk7W1/+0DGPOrJK/tCPeMCeZKc3EBDuzFQjOHM/oF0kPoX+62XXuEvL
X-Gm-Gg: ASbGnctxHUjvqFhMGphya0E2/Ok96L9sSLksNVl4dwAuYdDEQOLI/oSSZIUN0ijBlJm
	tSxfUL1S9+EvPuRrarLV8rLXXYSA900NUuDSIXLCdn6za5i2NbwpR4379+20OvPFCSlsZu9AJh+
	xYMTRa9HcZm2ZF3GARDAkDC4RxFZH64yAouNBQB/suYHt77bLgwEK7xzP4B2gYpbhyUCst1wz1l
	+KxbnfALGy3nmo5pxc5piCBDmBLTOrtxXX8FQsr3+3tJLBOtJad6yDXBrTtX3AOuLL4env7G1Ir
	xDdN+RfDUuWw7u0U0fF6e6O7lfvr9cd0DxOS8SA=
X-Google-Smtp-Source: AGHT+IHmNL3hw+Z1MhxTjvXmDGoglEu+SPRhXg+hD7kPUcLehqgCgO7tiTsFPcQwiarfUGWyRMfhIw==
X-Received: by 2002:a5d:6d8f:0:b0:39b:f12c:3862 with SMTP id ffacd0b85a97d-39ea51ed97bmr1056313f8f.2.1744397345189;
        Fri, 11 Apr 2025 11:49:05 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44572csm2943137f8f.90.2025.04.11.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:49:04 -0700 (PDT)
Date: Fri, 11 Apr 2025 21:49:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Subject: Re: [BUG] 6.14: WARNING: CPU: 0 PID: 478 at net/bridge/br_vlan.c:433
 nbp_vlan_flush+0xc0/0xc4
Message-ID: <20250411184902.ajifatz3dmx6cqar@skbuf>
References: <Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kxt463rxpj2cfx7o"
Content-Disposition: inline
In-Reply-To: <Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk>


--kxt463rxpj2cfx7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2025 at 06:24:44PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> When executing:
> 
> # ifdown br0
> 
> on the ZII dev rev B platform with br0 being a bridge between mv88e6xxx
> DSA ports, the following was spewed:
> 
> [  628.418720] br0: port 9(optical2) failed to delete vlan 1: -ENOENT

(trimming the rest, which is just the bridge complaining that &vg->vlan_list
is not empty, but __vlan_del() aborted the VLAN deletion due to
br_switchdev_port_vlan_del() returning an error, and left the VLAN in
the VLAN group's list. So that part is expected and is just a symptom,
we should focus on why DSA returns -ENOENT when requesting to delete
VLAN 1 from the CPU port).

Please test the attached patch. This is more speculative, but I've run
all the options in my mind and this is the only thing that makes sense.

--kxt463rxpj2cfx7o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-mv88e6xxx-fix-ENOENT-while-deleting-user-por.patch"

From 508d912b5f6b56c3f588b1bf28d3caed9e30db1b Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 11 Apr 2025 21:38:52 +0300
Subject: [PATCH] net: dsa: mv88e6xxx: fix -ENOENT while deleting user port
 VLANs

Russell King reports that on the ZII dev rev B, deleting a bridge VLAN
from a user port fails with -ENOENT:
https://lore.kernel.org/netdev/Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk/

This comes from mv88e6xxx_port_vlan_leave() -> mv88e6xxx_mst_put(),
which tries to find an MST entry in &chip->msts associated with the SID,
but fails and returns -ENOENT as such.

But we know that this chip does not support MST at all, so that is not
surprising. The question is why does the guard in mv88e6xxx_mst_put()
not exit early:

	if (!sid)
		return 0;

And the answer seems to be simple: the sid comes from vlan.sid which
supposedly was previously populated by mv88e6xxx_vtu_loadpurge().
But some chip->info->ops->vtu_loadpurge() implementations do not look at
vlan.sid at all, for example see mv88e6185_g1_vtu_loadpurge().

It was probably intended for the on-stack struct mv88e6xxx_vtu_entry
vlan entry to be zero-initialized, because currently it looks like we're
looking at a garbage sid which is just residual stack memory. So
zero-initialize this to avoid MST operations on switches which don't
support MST.

Fixes: acaf4d2e36b3 ("net: dsa: mv88e6xxx: MST Offloading")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 29a89ab4b789..c94c228434fc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2706,7 +2706,7 @@ static int mv88e6xxx_port_vlan_add(struct dsa_switch *ds, int port,
 static int mv88e6xxx_port_vlan_leave(struct mv88e6xxx_chip *chip,
 				     int port, u16 vid)
 {
-	struct mv88e6xxx_vtu_entry vlan;
+	struct mv88e6xxx_vtu_entry vlan = {};
 	int i, err;
 
 	if (!vid)
-- 
2.34.1


--kxt463rxpj2cfx7o--

