Return-Path: <netdev+bounces-290163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOUVE05PDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:18:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FD59D3D4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2F98301258A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B861E5B88;
	Thu, 21 May 2026 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6o1FT1w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9D1FC7C5
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322668; cv=none; b=uUIVLnhZLixO3yh1Oe/lYSx4TRWeZYBE0P2riVS8fz3JBfFTHdlDn9b8OpG9xAAPHbz/KCshwfexZn1rRvNlTWz1dNRw0ZKIQ6H7Yi2rKGbeHs6Aju52iYL02DW3CuBdyslSSR7zV6x3NcccXVzIYRjM40OzWtJgztiCHkbIL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322668; c=relaxed/simple;
	bh=cZmxq7//joj0ix/hQ43wtkPBXlYFpmo/1mfSHjQMgcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChAgnXYd+0clZKs6S1LWtFmigTGJ38U/hWbVPGrNrfw2QbcVzAxpmBpa5vCcPa6vSXtUOhYIFnNRg+/Jg0IQy7IPkP1UK/5JF16qjyj962hTyxflKlI8GBV497hF4tt4x4sWevp2972jkP2UKa1AWpGi1v+uVgx0IZtusyPg0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6o1FT1w; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-132830d8281so3959190c88.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779322665; x=1779927465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9c9xYjPrbAf6EEhEjSEzY/kkB9SIEDEDdWbIXAtZ84=;
        b=J6o1FT1wNe9tfjs5TalpEtjyet+pVOEZGaDlU/+gFnGABqetyiDz3zWxJLoTD1NtUT
         bDIR0Qj518iXAdcA+jvmVmLB76RCpwzUnm244ur1cKcvvK5hpLBD2APJdSvgTRSuGNS9
         tPM30QrYv3BMA+D3iwBan75DVBGDavd6FU4zFEZ0PLnIbksrK/Uo+8Av5aKoo3q7XxHG
         qmHjrgfhXhd+/gn1B+dist4TwCC6UAw3ojMqAlCVF/PLinbz0g7XNgh+E3xD8kmxnFYr
         i3upZ81seP21eeo6q40LQCYhUZTYE+8Isz5sJ1XzG//3FZawkq1fGE4as3PyxniTXlOi
         VuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779322665; x=1779927465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e9c9xYjPrbAf6EEhEjSEzY/kkB9SIEDEDdWbIXAtZ84=;
        b=AVCqZ3apZsoecEAbYRNBrAQgPBt24q8CyLcbp4VSLRNjOYPLRzSJgpPe4h4H4KM7mN
         heTeNg1gwymGmCcxYUTHkIWINH2AhezzDv1Do4sRyBNBB07Vk8M9LBqD7h4OeH6kPyxy
         MSUSG1oHmSw9OFhicMwedU8XAAg8/6O3UnJqvF1nmy+XdKP/kY0XEupnINRT48HoTi3J
         65Au0VH465uEE3pLJU6yh2jC3VWUqHGD6ySM7auSJGgj2YeOM7awydGvQyPIm79ohohZ
         ui8BZcaXEkK01RAB0BOkk3tuqoV4oujkSyoOhgcJhcRh6qs56FYy+ZS+wGiAm1v0WAjY
         gsZg==
X-Gm-Message-State: AOJu0YyhIoVJyo9DmhjLym5P9XRe0+RnmSXIPEwdg+9xsLn8l1Nc1R7h
	aX7QuPEdlaiH0I4IFjIJrxg1EfzOOgFZ/ERYzvJ9EsNDSIxGEVDV0+lbht6rcXlZuWA=
X-Gm-Gg: Acq92OF0dXxHag4F/X+PZ4GNEbqHuIr9VrJBAmvhr7qiXAxoY3zTE37mos9h60rc7G3
	Vhm4O8b14cwHZiM9xbtesyZYYro8YuC5MRf+Z1eW5gaxQgT8EisErGZyQxk0ZoULPmCzc06FaWp
	Iu5U4rT1HWrInRDd+A5cshTC8yiMVkM3gtRsKNoHbzHUexLG7x5pcZ9qniBswpcHDN39DgJnLAW
	Wp/ds5w1PzoLaXKmV9Oev+6ywMK//ws+wLaEOYazygXUbcy5+MG8T8k5FgoxtATfhoazIQTVu2V
	OunGl5pR9ezQCeR2aFTZ6h0DxioASmaiLwomnMOJx3iLbSUDNMeMSJGqm0UDzgPFSgZd+cixwwY
	45f9XOfPXxrhRatB1Dm3w6viOZSY66+iQhisfwKaPSxHGGv55mdO4HOyYERlYBgMX7SUWO9MDRs
	PNOxKp/mSYYNaVCVjPihQKVPBgG5nyz7E3f/zQtNNDzpzJC8hcwIb05UeacOreUpvTboB6Wphja
	5Eyeb+Eq4VJVVn+PTD2i22foxD+XLEH6+zg5m/4y+6H1It+Qvot9b02Vb0HWPONWsbLrJs2xd0H
	pipcCdXI2if27oP6Zg==
X-Received: by 2002:a05:7022:6629:b0:135:6914:87e1 with SMTP id a92af1059eb24-13632a02c3fmr487381c88.6.1779322665379;
        Wed, 20 May 2026 17:17:45 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm28444410c88.1.2026.05.20.17.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:17:45 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH v2 5/7] net: arcnet: expand unnecessary I/O abstraction macros
Date: Wed, 20 May 2026 17:16:17 -0700
Message-ID: <20260521001631.45434-6-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521001631.45434-1-enelsonmoore@gmail.com>
References: <20260521001631.45434-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290163-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E9FD59D3D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that the BUS_ALIGN variable has been removed, the
arcnet_in/out/read/write* macros behave identically to the functions
they wrap. Expand them and remove their definitions to make the code
easier to maintain.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/arcdevice.h    | 18 -------
 drivers/net/arcnet/com20020-pci.c |  6 +--
 drivers/net/arcnet/com20020.c     | 89 +++++++++++++++----------------
 drivers/net/arcnet/com20020.h     |  4 +-
 4 files changed, 49 insertions(+), 68 deletions(-)

diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index c870b8e21d44..a7c217359679 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -372,23 +372,5 @@ static inline void arcnet_set_addr(struct net_device *dev, u8 addr)
 	dev_addr_set(dev, &addr);
 }
 
-/* I/O equivalents */
-
-/* addr and offset allow register like names to define the actual IO address */
-#define arcnet_inb(addr, offset)					\
-	inb((addr) + (offset))
-#define arcnet_outb(value, addr, offset)				\
-	outb(value, (addr) + (offset))
-
-#define arcnet_insb(addr, offset, buffer, count)			\
-	insb((addr) + (offset), buffer, count)
-#define arcnet_outsb(addr, offset, buffer, count)			\
-	outsb((addr) + (offset), buffer, count)
-
-#define arcnet_readb(addr, offset)					\
-	readb((addr) + (offset))
-#define arcnet_writeb(value, addr, offset)				\
-	writeb(value, (addr) + (offset))
-
 #endif				/* __KERNEL__ */
 #endif				/* _LINUX_ARCDEVICE_H */
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index dbadda08dce2..98f68cb13a52 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -195,8 +195,8 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		 * ARCNET controller needs
 		 * this access to detect bustype
 		 */
-		arcnet_outb(0x00, ioaddr, COM20020_REG_W_COMMAND);
-		arcnet_inb(ioaddr, COM20020_REG_R_DIAGSTAT);
+		outb(0x00, ioaddr + COM20020_REG_W_COMMAND);
+		inb(ioaddr + COM20020_REG_R_DIAGSTAT);
 
 		SET_NETDEV_DEV(dev, &pdev->dev);
 		dev->base_addr = ioaddr;
@@ -224,7 +224,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
 		}
 
-		if (arcnet_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
+		if (inb(ioaddr + COM20020_REG_R_STATUS) == 0xFF) {
 			pr_err("IO address %Xh is empty!\n", ioaddr);
 			ret = -EIO;
 			goto err_free_arcdev;
diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index adcf69cb9d50..21f962357b0b 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -65,13 +65,13 @@ static void com20020_copy_from_card(struct net_device *dev, int bufnum,
 	int ioaddr = dev->base_addr, ofs = 512 * bufnum + offset;
 
 	/* set up the address register */
-	arcnet_outb((ofs >> 8) | RDDATAflag | AUTOINCflag,
-		    ioaddr, COM20020_REG_W_ADDR_HI);
-	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
+	outb((ofs >> 8) | RDDATAflag | AUTOINCflag,
+	     ioaddr + COM20020_REG_W_ADDR_HI);
+	outb(ofs & 0xff, ioaddr + COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
 	TIME(dev, "insb", count,
-	     arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	     insb(ioaddr + COM20020_REG_RW_MEMDATA, buf, count));
 }
 
 static void com20020_copy_to_card(struct net_device *dev, int bufnum,
@@ -80,12 +80,12 @@ static void com20020_copy_to_card(struct net_device *dev, int bufnum,
 	int ioaddr = dev->base_addr, ofs = 512 * bufnum + offset;
 
 	/* set up the address register */
-	arcnet_outb((ofs >> 8) | AUTOINCflag, ioaddr, COM20020_REG_W_ADDR_HI);
-	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
+	outb((ofs >> 8) | AUTOINCflag, ioaddr + COM20020_REG_W_ADDR_HI);
+	outb(ofs & 0xff, ioaddr + COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
 	TIME(dev, "outsb", count,
-	     arcnet_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	     outsb(ioaddr + COM20020_REG_RW_MEMDATA, buf, count));
 }
 
 /* Reset the card and check some basic stuff during the detection stage. */
@@ -94,9 +94,9 @@ int com20020_check(struct net_device *dev)
 	int ioaddr = dev->base_addr, status;
 	struct arcnet_local *lp = netdev_priv(dev);
 
-	arcnet_outb(XTOcfg(3) | RESETcfg, ioaddr, COM20020_REG_W_CONFIG);
+	outb(XTOcfg(3) | RESETcfg, ioaddr + COM20020_REG_W_CONFIG);
 	udelay(5);
-	arcnet_outb(XTOcfg(3), ioaddr, COM20020_REG_W_CONFIG);
+	outb(XTOcfg(3), ioaddr + COM20020_REG_W_CONFIG);
 	mdelay(RESETtime);
 
 	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
@@ -107,23 +107,23 @@ int com20020_check(struct net_device *dev)
 	lp->setup = lp->setup | P1MODE;
 
 	com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
-	arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+	outb(lp->setup, ioaddr + COM20020_REG_W_XREG);
 
 	if (lp->clockm != 0) {
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP2);
-		arcnet_outb(lp->setup2, ioaddr, COM20020_REG_W_XREG);
+		outb(lp->setup2, ioaddr + COM20020_REG_W_XREG);
 
 		/* must now write the magic "restart operation" command */
 		mdelay(1);
-		arcnet_outb(STARTIOcmd, ioaddr, COM20020_REG_W_COMMAND);
+		outb(STARTIOcmd, ioaddr + COM20020_REG_W_COMMAND);
 	}
 
 	lp->config = (lp->timeout << 3) | (lp->backplane << 2) | SUB_NODE;
 	/* set node ID to 0x42 (but transmitter is disabled, so it's okay) */
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
-	arcnet_outb(0x42, ioaddr, COM20020_REG_W_XREG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
+	outb(0x42, ioaddr + COM20020_REG_W_XREG);
 
-	status = arcnet_inb(ioaddr, COM20020_REG_R_STATUS);
+	status = inb(ioaddr + COM20020_REG_R_STATUS);
 
 	if ((status & 0x99) != (NORXflag | TXFREEflag | RESETflag)) {
 		arc_printk(D_NORMAL, dev, "status invalid (%Xh).\n", status);
@@ -131,18 +131,17 @@ int com20020_check(struct net_device *dev)
 	}
 	arc_printk(D_INIT_REASONS, dev, "status after reset: %X\n", status);
 
-	arcnet_outb(CFLAGScmd | RESETclear | CONFIGclear,
-		    ioaddr, COM20020_REG_W_COMMAND);
-	status = arcnet_inb(ioaddr, COM20020_REG_R_STATUS);
+	outb(CFLAGScmd | RESETclear | CONFIGclear,
+	     ioaddr + COM20020_REG_W_COMMAND);
+	status = inb(ioaddr + COM20020_REG_R_STATUS);
 	arc_printk(D_INIT_REASONS, dev, "status after reset acknowledged: %X\n",
 		   status);
 
 	/* Read first location of memory */
-	arcnet_outb(0 | RDDATAflag | AUTOINCflag,
-		    ioaddr, COM20020_REG_W_ADDR_HI);
-	arcnet_outb(0, ioaddr, COM20020_REG_W_ADDR_LO);
+	outb(0 | RDDATAflag | AUTOINCflag, ioaddr + COM20020_REG_W_ADDR_HI);
+	outb(0, ioaddr + COM20020_REG_W_ADDR_LO);
 
-	status = arcnet_inb(ioaddr, COM20020_REG_RW_MEMDATA);
+	status = inb(ioaddr + COM20020_REG_RW_MEMDATA);
 	if (status != TESTvalue) {
 		arc_printk(D_NORMAL, dev, "Signature byte not found (%02Xh != D1h).\n",
 			   status);
@@ -159,7 +158,7 @@ static int com20020_set_hwaddr(struct net_device *dev, void *addr)
 
 	dev_addr_set(dev, hwaddr->sa_data);
 	com20020_set_subaddress(lp, ioaddr, SUB_NODE);
-	arcnet_outb(dev->dev_addr[0], ioaddr, COM20020_REG_W_XREG);
+	outb(dev->dev_addr[0], ioaddr + COM20020_REG_W_XREG);
 
 	return 0;
 }
@@ -170,7 +169,7 @@ static int com20020_netdev_open(struct net_device *dev)
 	struct arcnet_local *lp = netdev_priv(dev);
 
 	lp->config |= TXENcfg;
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 
 	return arcnet_open(dev);
 }
@@ -184,7 +183,7 @@ static int com20020_netdev_close(struct net_device *dev)
 
 	/* disable transmitter */
 	lp->config &= ~TXENcfg;
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 	return 0;
 }
 
@@ -220,24 +219,24 @@ int com20020_found(struct net_device *dev, int shared)
 
 	/* FIXME: do this some other way! */
 	if (!dev->dev_addr[0])
-		arcnet_set_addr(dev, arcnet_inb(ioaddr, 8));
+		arcnet_set_addr(dev, inb(ioaddr + 8));
 
 	com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
-	arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+	outb(lp->setup, ioaddr + COM20020_REG_W_XREG);
 
 	if (lp->card_flags & ARC_CAN_10MBIT) {
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP2);
-		arcnet_outb(lp->setup2, ioaddr, COM20020_REG_W_XREG);
+		outb(lp->setup2, ioaddr + COM20020_REG_W_XREG);
 
 		/* must now write the magic "restart operation" command */
 		mdelay(1);
-		arcnet_outb(STARTIOcmd, ioaddr, COM20020_REG_W_COMMAND);
+		outb(STARTIOcmd, ioaddr + COM20020_REG_W_COMMAND);
 	}
 
 	lp->config = (lp->timeout << 3) | (lp->backplane << 2) | SUB_NODE;
 	/* Default 0x38 + register: Node ID */
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
-	arcnet_outb(dev->dev_addr[0], ioaddr, COM20020_REG_W_XREG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
+	outb(dev->dev_addr[0], ioaddr + COM20020_REG_W_XREG);
 
 	/* reserve the irq */
 	if (request_irq(dev->irq, arcnet_interrupt, shared,
@@ -288,26 +287,26 @@ static int com20020_reset(struct net_device *dev, int really_reset)
 	arc_printk(D_DEBUG, dev, "%s: %d: %s: dev: %p, lp: %p, dev->name: %s\n",
 		   __FILE__, __LINE__, __func__, dev, lp, dev->name);
 	arc_printk(D_INIT, dev, "Resetting %s (status=%02Xh)\n",
-		   dev->name, arcnet_inb(ioaddr, COM20020_REG_R_STATUS));
+		   dev->name, inb(ioaddr + COM20020_REG_R_STATUS));
 
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
 	lp->config |= (lp->timeout << 3) | (lp->backplane << 2);
 	/* power-up defaults */
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
 
 	if (really_reset) {
 		/* reset the card */
-		arcnet_outb(lp->config | RESETcfg, ioaddr, COM20020_REG_W_CONFIG);
+		outb(lp->config | RESETcfg, ioaddr + COM20020_REG_W_CONFIG);
 		udelay(5);
-		arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+		outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 		mdelay(RESETtime * 2);
 				/* COM20020 seems to be slower sometimes */
 	}
 	/* clear flags & end reset */
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
-	arcnet_outb(CFLAGScmd | RESETclear | CONFIGclear,
-		    ioaddr, COM20020_REG_W_COMMAND);
+	outb(CFLAGScmd | RESETclear | CONFIGclear,
+	     ioaddr + COM20020_REG_W_COMMAND);
 
 	/* verify that the ARCnet signature byte is present */
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
@@ -321,7 +320,7 @@ static int com20020_reset(struct net_device *dev, int really_reset)
 		return 1;
 	}
 	/* enable extended (512-byte) packets */
-	arcnet_outb(CONFIGcmd | EXTconf, ioaddr, COM20020_REG_W_COMMAND);
+	outb(CONFIGcmd | EXTconf, ioaddr + COM20020_REG_W_COMMAND);
 
 	arc_printk(D_DEBUG, dev, "%s: %d: %s\n", __FILE__, __LINE__, __func__);
 
@@ -334,22 +333,22 @@ static void com20020_setmask(struct net_device *dev, int mask)
 	u_int ioaddr = dev->base_addr;
 
 	arc_printk(D_DURING, dev, "Setting mask to %x at %x\n", mask, ioaddr);
-	arcnet_outb(mask, ioaddr, COM20020_REG_W_INTMASK);
+	outb(mask, ioaddr + COM20020_REG_W_INTMASK);
 }
 
 static void com20020_command(struct net_device *dev, int cmd)
 {
 	u_int ioaddr = dev->base_addr;
 
-	arcnet_outb(cmd, ioaddr, COM20020_REG_W_COMMAND);
+	outb(cmd, ioaddr + COM20020_REG_W_COMMAND);
 }
 
 static int com20020_status(struct net_device *dev)
 {
 	u_int ioaddr = dev->base_addr;
 
-	return arcnet_inb(ioaddr, COM20020_REG_R_STATUS) +
-		(arcnet_inb(ioaddr, COM20020_REG_R_DIAGSTAT) << 8);
+	return inb(ioaddr + COM20020_REG_R_STATUS) +
+		(inb(ioaddr + COM20020_REG_R_DIAGSTAT) << 8);
 }
 
 static void com20020_close(struct net_device *dev)
@@ -359,7 +358,7 @@ static void com20020_close(struct net_device *dev)
 
 	/* disable transmitter */
 	lp->config &= ~TXENcfg;
-	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+	outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 }
 
 /* ARCnet does not support multicast, only unicast and broadcast */
@@ -374,14 +373,14 @@ static void com20020_set_rx_mode(struct net_device *dev)
 			arc_printk(D_NORMAL, dev, "Setting promiscuous flag...\n");
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
 		lp->setup |= PROMISCset;
-		arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+		outb(lp->setup, ioaddr + COM20020_REG_W_XREG);
 	} else {
 		/* Disable promiscuous mode, use normal mode */
 		if ((lp->setup & PROMISCset))
 			arc_printk(D_NORMAL, dev, "Resetting promiscuous flag...\n");
 		com20020_set_subaddress(lp, ioaddr, SUB_SETUP1);
 		lp->setup &= ~PROMISCset;
-		arcnet_outb(lp->setup, ioaddr, COM20020_REG_W_XREG);
+		outb(lp->setup, ioaddr + COM20020_REG_W_XREG);
 	}
 }
 
diff --git a/drivers/net/arcnet/com20020.h b/drivers/net/arcnet/com20020.h
index 0bcc5d0a6903..e7aac0e81a13 100644
--- a/drivers/net/arcnet/com20020.h
+++ b/drivers/net/arcnet/com20020.h
@@ -123,9 +123,9 @@ static inline void com20020_set_subaddress(struct arcnet_local *lp,
 {
 	if (val < 4) {
 		lp->config = (lp->config & ~0x03) | val;
-		arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
+		outb(lp->config, ioaddr + COM20020_REG_W_CONFIG);
 	} else {
-		arcnet_outb(val, ioaddr, COM20020_REG_W_SUBADR);
+		outb(val, ioaddr + COM20020_REG_W_SUBADR);
 	}
 }
 
-- 
2.43.0


