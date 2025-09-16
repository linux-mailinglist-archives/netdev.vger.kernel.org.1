Return-Path: <netdev+bounces-223730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135AB5A40D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F734864B9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE72836A6;
	Tue, 16 Sep 2025 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0cs+9xG/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D031BCAE
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058543; cv=none; b=apHUdIG1+lJLxS4WL/fsDRPnmv8N7h58kglR+1MFSxhfKvE8/2CRmOUMSUqmEmDugn2qpjCxI/g+faudJPApJ2yzBLsR6nWHQhl3MdEt75E5Z5oO6KryIfdZatdAEvSTs9JjpV7uAJuWNgP5KGDCe717JVAGlYZQ7N9pkOm/pSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058543; c=relaxed/simple;
	bh=GzXsPGxgSPtnUzOnC0pzPzXBCKex8zRkL3uu5xax5oA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uM+GLkm4CsTsJizKZ0aEISdpy7avWuI+A6UW4K0EA+NpMfT+s2KqnKoNllX+gaq2Yfw7p4cXZEv+5FaJY/QRk4ZBcSacMRdmHnADfE6UASTgUsSV6nloxfUohrhMEiBFloiZiGYVNM9SqiYgLGfQue2qiBYVEx8DKC7BcbsTX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0cs+9xG/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oEaBh55+azWDXu/wNCOa8loY8KkzsLqXMQnJI7BUjns=; b=0cs+9xG/YQE9aeC+yUC2wWtxfX
	iW6btycrN1RQ+TfDEsaeJBJGEQektJXx+cZGXpqVZlWsJM0wZY86prtgEtgyVzLytRnv8IV5n5Nea
	UyfYtEqC5sISmwJxJM7G7swdNEyHivWNquWTKTiMBLHP1GBfdNGFGdMbm2ShCp/MfN+rRbbsIbb4z
	m9ZTnK4RSuEnAA7tdRggdW3FO6hpfHaij9DtvClVxhOnF2TXFHMbbqqohzx+rpY6lkym5vwduKN0G
	jYhU4pUjgBURDOqoxaIgfWnkJmolkzPwxaOT5jKLys05YM1VafJGqAzv0Gcw7IBBD5ItYNMbUjrWO
	piQqO0rA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46122)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uydKn-000000006L6-3O3E;
	Tue, 16 Sep 2025 22:35:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uydKk-000000007zr-34yR;
	Tue, 16 Sep 2025 22:35:30 +0100
Date: Tue, 16 Sep 2025 22:35:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
	Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH net-next v2 0/2] ptp: safely cleanup when unregistering a PTP
 clock
Message-ID: <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

(I'm assuming drivers/ptp/ patches go via net-next as there is no
git tree against the "PTP HARDWARE CLOCK SUPPORT" maintainers entry.)

The standard rule in the kernel for unregistering user visible devices
is to unpublish the userspace API before doing any shutdown of the
resources necessary for the operation of the device.

PTP has several issues in this area:

1. ptp_clock_unregister() cancells and destroys work while the PTP
   chardev is still published, which gives the opportunity for a
   precisely timed user API call to cause a driver to attempt to
   queue the aux work.

2. PTP pins are not cleaned up - if userspace has enabled PTP pins,
   e.g. for extts, drivers are forced to do cleanup before calling
   ptp_clock_unregister() to stop events being forwarded into the
   PTP layer. E.g mv88e6xxx cancells its internal tai_event_work
   to avoid calling into the PTP clock code with a stale ptp_clock
   pointer, but a badly timed userspace EXTTS enable will re-schedule
   the tai_event_work.

Simplify the process by ensuring that:

1. we take a referene on the PTP struct device to stop the
   ptp_clock structure going away underneath us when we call
   posix_clock_unregister().

2. call posix_clock_unregister() to remove the /dev/ptp* device.

3. add additional functionality to disable any PTP EXTTS pins and
   PPS event generation that have been configured on this device.
   This should shutdown all events coming from PTP clock drivers.

4. cancel the delayed aux_work and destroy the kthread.

5. remove the PPS source.

6. drop the reference on the PTP struct device to allow the
   ptp_clock structure to be released.

This is difficult for me to test beyond build testing - on the
Clearfog platform with Marvell PHY PTP, the ethernet PHY is the
primary connectivity, so removing the PHY driver for an in-use
network interface isn't possible.

On the ZII rev B platform, where the DSA switches have the TAI
hardware and where root NFS is used, removal of the DSA switch
module somehow forces the FEC interface _not_ connected to the DSA
switch to lose link, causing the machine to become unresponsive
as its root filesystem vanishes.

---
v2:
- add r-b's to patch 1
- only disable EXTTS pins
- disable PPS event generation

 drivers/ptp/ptp_chardev.c | 28 +++++++++++++++++++++++++++-
 drivers/ptp/ptp_clock.c   | 15 ++++++++++++++-
 drivers/ptp/ptp_private.h |  2 ++
 3 files changed, 43 insertions(+), 2 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

