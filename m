Return-Path: <netdev+bounces-161565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B9A22610
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 23:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24590188441C
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1C1DED6A;
	Wed, 29 Jan 2025 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PyCd9i8m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFD1B6525;
	Wed, 29 Jan 2025 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738188341; cv=none; b=ewmgu5Aghc89+dXCkn8oTCDJWr/xahc9hQEDKvarDft/EXgGN3/u+XsFOlnSzmUaco1COs5zr+gmFHerjw/UGzAUhp1MOXB81m+XOB8AQz+Zqt8vYca2POhip2rI1g3rIKo0+naa5am3qNYRSunPgFlk+/OkPstUCC0SzwTXCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738188341; c=relaxed/simple;
	bh=2a4GRt6Go+4TX9FwDppABTKiPlF0ZmQVfucxGJl+7co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZm2irjtMLidBLXTfNCrZ6aEHC93VCCdhiMvpGH3bm5oy6Olp2i6Zm1T5h/sPJP0GwZYD9SXTcSwTTiSNFlgjRWCMx+BoL2ZHNQFL8YxurfgAZ2N06aoCvcNi9ynSlAFf2QVZkcv3vwkwShnawL5xi4ArF08J1zMUUYZUm6DrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PyCd9i8m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3cTuFRrZm1pONHhQlaYL6yJbgsP9jphixV+YSaoVfdA=; b=PyCd9i8mAI6ir0xeGAE3ZtTXF6
	cd6tdHhpJklJy4E2SEqLPJLoovt9cbZ+SIqDeZbgjV/7DrUE3NikSnnOBoBsAGSlIDprlzpQvMtZY
	J/LNEYGlYJ9dHmkQrhvTujFhIE3gawSh6PuqQ1fcDsJqQrENQPPCQbfwxhx34iFrzGLzGdaa5zfiG
	tekeIIbTLqgpp7UyxyTVaPA63xZEzcDapbgR2ISNFkkzVot8XTTEvO6kQQR6yrcqiLBDpRda0a3vW
	8d2FDuMR4DiMQaBVIRSMBcQmFykABGROwcwmHmpMeAtFutRBmGls9EGbdhclfwp7YFHaKvI6MkPtg
	zHEtYSrg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51474)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tdGBX-0002Ho-39;
	Wed, 29 Jan 2025 22:05:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tdGBU-00041k-0p;
	Wed, 29 Jan 2025 22:05:20 +0000
Date: Wed, 29 Jan 2025 22:05:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, andrew@lunn.ch, hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
References: <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HYAL5MAMprQXQslD"
Content-Disposition: inline
In-Reply-To: <20250129211226.cfrhv4nn3jomooxc@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>


--HYAL5MAMprQXQslD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(To Tristram as well - I've added a workaround for your company mail
sewers that don't accept bounces from emails that have left your
organisation - in other words, once they have left your companies
mail servers, you have no idea whether they reached their final
recipient. You only get to know if your email servers can't send it
to the very _next_ email server.)

On Wed, Jan 29, 2025 at 11:12:26PM +0200, Vladimir Oltean wrote:
> On Wed, Jan 29, 2025 at 12:31:09AM +0000, Tristram.Ha@microchip.com wrote:
> > The default value of DW_VR_MII_AN_CTRL is DW_VR_MII_PCS_MODE_C37_SGMII
> > (0x04).  When a SGMII SFP is used the SGMII port works without any
> > programming.  So for example network communication can be done in U-Boot
> > through the SGMII port.  When a 1000BaseX SFP is used that register needs
> > to be programmed (DW_VR_MII_SGMII_LINK_STS |
> > DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII | DW_VR_MII_PCS_MODE_C37_1000BASEX)
> > (0x18) for it to work.
> 
> Can it be that DW_VR_MII_PCS_MODE_C37_1000BASEX is the important setting
> when writing 0x18, and the rest is just irrelevant and bogus? If not,
> could you please explain what is the role of DW_VR_MII_SGMII_LINK_STS |
> DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII for 1000Base-X? The XPCS data book
> does not suggest they would be considered for 1000Base-X operation. Are
> you suggesting for KSZ9477 that is different? If so, please back that
> statement up.

Agreed. I know that the KSZ9477 information says differently, but if
the implementation is the Synopsys DesignWare XPCS, then surely the
register details in Synopsys' documentation should apply... so I'm
also interested to know why KSZ9477 seems to deviate from Synopsys'
implementation on this need.

I've been wondering whether setting DW_VR_MII_SGMII_LINK_STS and
DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII in 1000base-X mode is something
that should be done anyway, but from what Vladimir is saying, there's
nothing in Synopsys' documentation that supports it.

The next question would be whether it's something that we _could_
always do - if it has no effect for anyone else, then removing a
conditional simplifies the code.

> > (DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII has to be used together with
> > DW_VR_MII_TX_CONFIG_MASK to mean 0x08.  Likewise for
> > DW_VR_MII_PCS_MODE_C37_SGMII and DW_VR_MII_PCS_MODE_MASK to mean 0x04.
> > It is a little difficult to just use those names to indicate the actual
> > value.)
> > 
> > DW_VR_MII_DIG_CTRL1 is never touched.  DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW
> > does not exist in KSZ9477 implementation.  As setting that bit does not
> > have any effect I did not do anything about it.
> 
> Never touched by whom? xpcs_config_aneg_c37_sgmii() surely tries to
> touch it... Don't you think that the absence of this bit from the
> KSZ9477 implementation might have something to do with KSZ9477's unique
> need to force the link speed when in in-band mode?

I think Tristram is talking about xpcs_config_aneg_c37_1000basex()
here, not SGMII.

Tristram, as a general note: there is a reason I utterly hate the term
"SGMII" - and the above illustrates exactly why. There is Cisco SGMII
(the modified 1000base-X protocol for use with PHYs.) Then there is the
"other" SGMII that manufacturers like to band about because they want
to describe their "Serial Gigabit Media Independent Interface" and they
use it to describe an interface that supports both 1000base-X and Cisco
SGMII.

This overloading of "SGMII" leads to nothing but confusion - please be
specific about whether you are talking about 1000base-X or Cisco SGMII,
and please please please avoid using "SGMII".

However, in the kernel code, we use "SGMII" exclusively to mean Cisco
SGMII.


> > It does have the intended effect of separating SGMII and 1000BaseX modes
> > in later versions.  And DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL is used along
> > with it.  They are mutually exclusive.  For SGMII SFP
> > DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW is set; for 1000BaseX SFP
> > DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL is set.
> 
> It's difficult for me to understand what you are trying to communicate here.

I think it makes sense - MAC_AUTO_SW is meaningless in 1000base-X mode
because the speed is fixed at 1G, whereas in Cisco SGMII MAC mode this
bit allows the PCS to change its speed setting according to the AN
result.

> > KSZ9477 errata module 7 indicates the MII_ADVERTISE register needs to be
> > set 0x01A0.  This is done with phylink_mii_c22_pcs_encode_advertisement()
> > but only for 1000BaseX mode.  I probably need to add that code in SGMII
> > configuration.

Hang on one moment... I think we're going off to another problem.

For 1000base-X, we do use phylink_mii_c22_pcs_encode_advertisement()
which will generate the advertisement word for 1000base-X.

For Cisco SGMII, it will generate the tx_config word for a MAC-side
setup (which is basically the fixed 0x4001 value.) From what I read
in KSZ9477, this value would be unsuitable for a case where the
following register values are:

	DW_VR_MII_PCS_MODE_C37_SGMII set
	DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII set
	DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL clear

meaning that we're generating a SGMII PHY-side word indicating the
parameters to be used from the registers rather than hardware signals.

> > The default value of this register is 0x20.  This update
> > depends on SFP.  So far I did not find a SGMII SFP that requires this
> > setting.  This issue is more like the hardware did not set the default
> > value properly.  As I said, the SGMII port works with SGMII SFP after
> > power up without programming anything.
> > 
> > I am always confused by the master/slave - phy/mac nature of the SFP.
> > The hardware designers seem to think the SGMII module is acting as a
> > master then the slave is on the other side, like physically outside the
> > chip.  I generally think of the slave is inside the SFP, as every board
> > is programmed that way.

I think you're getting confused by microchip terminology.

Cisco SGMII is an asymmetric protocol. Cisco invented it as a way of:
1. supporting 10M and 100M speeds over a single data pair in each
   direction.
2. sending the parameters of that link from the PHY to the MAC/PCS over
   that single data pair.

They took the IEEE 1000base-X specification as a basis (which is
symmetric negotiation via a 16-bit word).

The Cisco SGMII configuration word from the PHY to the PCS/MAC
contains:

	bit 15 - link status
	bit 14 - (reserved for AN acknowledge as per 1000base-X)
	bit 13 - reserved (zero)
	bit 12 - duplex mode
	bit 11, 10 - speed
	bits 9..1 - reserved (zero)
	bit 0 - set to 1

This is "PHY" mode, or in Microchip parlence "master" mode - because
the PHY is dictating what the other end should be doing.

When the PCS/MAC receives this, the PCS/MAC is expected to respond
with a configuration word containing:

	bit 15 - zero
	bit 14 - set to 1 (indicating acknowledge)
	bit 13..1 - zero
	bit 0 - set to 1

This is MAC mode, or in Microchip parlence "slave" mode - because the
MAC is being told what it should do.

So, for a Cisco SGMII link with a SFP module which has a PHY embedded
inside, you definitely want to be using MAC mode, because the PHY on
the SFP module will be dictating the speed and duplex to the components
outside of the SFP - in other words the PCS and MAC.

> > For SFPs with label 10/100/1000Base-T
> > they start in SGMII mode.  For SFPs with just 1000Base-T they start in
> > 1000BaseX mode and needs 0x18 value to work.  In Linux the PHY inside the
> > SFP can switch back to SGMII mode and so the SGMII setting is used
> > because the EEPROM says SGMII mode is supported.

Ummm.... not quite. The SFP module EEPROM actually says absolutely
nothing about whether 1000base-X or Cisco SGMII should be used
with a module. The Linux SFP code (which I wrote, so I've torn my hair
out over this issue) does a best guess based on what it finds - but
ultimately, what it comes down to is... if we find a PHY that we can
access, it is a gigabit PHY, and we have a driver for it, then we
(re)program the PHY to use Cisco SGMII.

If we don't find a PHY, and it doesn't look like it's a copper module,
then we use 1000base-X (because SFPs were originally for fibre.)

We do have quirks to cope with weirdness, particularly with GPON
modules.

> > There are some SFPs
> > that will use only 1000BaseX mode.  I wonder why the SFP manufacturers do
> > that.  It seems the PHY access is also not reliable as some registers
> > always have 0xff value in lower part of the 16-bit value.  That may be
> > the reason that there is a special Marvell PHY id just for Finisar.

I don't have any modules that have a Finisar PHY rather than a Marvell
PHY. I wonder if the problem is that the Finisar module doesn't like
multi-byte I2C accesses to the PHY.

Another thing - make sure that the I2C bus to the SFP cage is running
at 100kHz, not 400kHz.

For Vladimir: I've added four hacky patches that build on top of the
large RFC series I sent earlier which add probably saner configuration
for the SGMII code, hopefully making it more understandable in light
of Wangxun's TXGBE using PHY mode there (they were adamant that their
hardware requires it.) These do not address Tristram's issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--HYAL5MAMprQXQslD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-xpcs-rearrange-register-definitions.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next 1/4] net: xpcs: rearrange register definitions

Place register number definitions along side their field definitions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.h | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 39d3f517b557..929fa238445e 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -55,23 +55,11 @@
 /* Clause 37 Defines */
 /* VR MII MMD registers offsets */
 #define DW_VR_MII_DIG_CTRL1		0x8000
-#define DW_VR_MII_AN_CTRL		0x8001
-#define DW_VR_MII_AN_INTR_STS		0x8002
-/* EEE Mode Control Register */
-#define DW_VR_MII_EEE_MCTRL0		0x8006
-#define DW_VR_MII_EEE_MCTRL1		0x800b
-#define DW_VR_MII_DIG_CTRL2		0x80e1
-
-/* VR_MII_DIG_CTRL1 */
 #define DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW		BIT(9)
 #define DW_VR_MII_DIG_CTRL1_2G5_EN		BIT(2)
 #define DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL	BIT(0)
 
-/* VR_MII_DIG_CTRL2 */
-#define DW_VR_MII_DIG_CTRL2_TX_POL_INV		BIT(4)
-#define DW_VR_MII_DIG_CTRL2_RX_POL_INV		BIT(0)
-
-/* VR_MII_AN_CTRL */
+#define DW_VR_MII_AN_CTRL		0x8001
 #define DW_VR_MII_AN_CTRL_8BIT			BIT(8)
 #define DW_VR_MII_TX_CONFIG_MASK		BIT(3)
 #define DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII	0x1
@@ -81,7 +69,7 @@
 #define DW_VR_MII_PCS_MODE_C37_SGMII		0x2
 #define DW_VR_MII_AN_INTR_EN			BIT(0)
 
-/* VR_MII_AN_INTR_STS */
+#define DW_VR_MII_AN_INTR_STS		0x8002
 #define DW_VR_MII_AN_STS_C37_ANCMPLT_INTR	BIT(0)
 #define DW_VR_MII_AN_STS_C37_ANSGM_FD		BIT(1)
 #define DW_VR_MII_AN_STS_C37_ANSGM_SP		GENMASK(3, 2)
@@ -90,19 +78,22 @@
 #define DW_VR_MII_C37_ANSGM_SP_1000		0x2
 #define DW_VR_MII_C37_ANSGM_SP_LNKSTS		BIT(4)
 
-/* VR MII EEE Control 0 defines */
+#define DW_VR_MII_EEE_MCTRL0		0x8006
 #define DW_VR_MII_EEE_LTX_EN			BIT(0)  /* LPI Tx Enable */
 #define DW_VR_MII_EEE_LRX_EN			BIT(1)  /* LPI Rx Enable */
 #define DW_VR_MII_EEE_TX_QUIET_EN		BIT(2)  /* Tx Quiet Enable */
 #define DW_VR_MII_EEE_RX_QUIET_EN		BIT(3)  /* Rx Quiet Enable */
 #define DW_VR_MII_EEE_TX_EN_CTRL		BIT(4)  /* Tx Control Enable */
 #define DW_VR_MII_EEE_RX_EN_CTRL		BIT(7)  /* Rx Control Enable */
-
 #define DW_VR_MII_EEE_MULT_FACT_100NS		GENMASK(11, 8)
 
-/* VR MII EEE Control 1 defines */
+#define DW_VR_MII_EEE_MCTRL1		0x800b
 #define DW_VR_MII_EEE_TRN_LPI		BIT(0)	/* Transparent Mode Enable */
 
+#define DW_VR_MII_DIG_CTRL2		0x80e1
+#define DW_VR_MII_DIG_CTRL2_TX_POL_INV		BIT(4)
+#define DW_VR_MII_DIG_CTRL2_RX_POL_INV		BIT(0)
+
 #define DW_XPCS_INFO_DECLARE(_name, _pcs, _pma)				\
 	static const struct dw_xpcs_info _name = { .pcs = _pcs, .pma = _pma }
 
-- 
2.30.2


--HYAL5MAMprQXQslD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-net-xpcs-add-support-for-configuring-width-of-10-100.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next 3/4] net: xpcs: add support for configuring width of
 10/100M MII connection

When in SGMII mode, the hardware can be configured to use either 4-bit
or 8-bit MII connection. Currently, we don't change this bit for most
implementations with the exception of TXGBE requiring 8-bit. Move this
decision to the creation code and act on it when configuring SGMII.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 20 +++++++++++++++-----
 drivers/net/pcs/pcs-xpcs.h |  8 ++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 477a3a20f860..75ed8d535de2 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -665,10 +665,18 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	val = FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
 			 DW_VR_MII_PCS_MODE_C37_SGMII);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		/* Width of the MII MAC/XPCS interface in 100M and 10M modes */
-		mask |= DW_VR_MII_AN_CTRL_8BIT;
+	switch (xpcs->sgmii_10_100_8bit) {
+	case DW_XPCS_SGMII_10_100_8BIT:
 		val |= DW_VR_MII_AN_CTRL_8BIT;
+		fallthrough;
+	case DW_XPCS_SGMII_10_100_4BIT:
+		mask |= DW_VR_MII_AN_CTRL_8BIT;
+		fallthrough;
+	case DW_XPCS_SGMII_10_100_UNSET:
+		break;
+	}
+
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		/* Hardware requires it to be PHY side SGMII */
 		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
 	} else {
@@ -1489,10 +1497,12 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 
 	xpcs_get_interfaces(xpcs, xpcs->pcs.supported_interfaces);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		xpcs->pcs.poll = false;
-	else
+		xpcs->sgmii_10_100_8bit = DW_XPCS_SGMII_10_100_8BIT;
+	} else {
 		xpcs->need_reset = true;
+	}
 
 	return xpcs;
 
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 929fa238445e..268a9be21c77 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -105,6 +105,12 @@ enum dw_xpcs_clock {
 	DW_XPCS_NUM_CLKS,
 };
 
+enum dw_xpcs_sgmii_10_100 {
+	DW_XPCS_SGMII_10_100_UNSET,
+	DW_XPCS_SGMII_10_100_4BIT,
+	DW_XPCS_SGMII_10_100_8BIT
+};
+
 struct dw_xpcs {
 	struct dw_xpcs_info info;
 	const struct dw_xpcs_desc *desc;
@@ -113,6 +119,8 @@ struct dw_xpcs {
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
 	bool need_reset;
+	/* Width of the MII MAC/XPCS interface in 100M and 10M modes */
+	enum dw_xpcs_sgmii_10_100 sgmii_10_100_8bit;
 	u8 eee_mult_fact;
 };
 
-- 
2.30.2


--HYAL5MAMprQXQslD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-net-xpcs-document-SGMII-settings.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next 2/4] net: xpcs: document SGMII settings

Document some of the SGMII register settings.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index ee0c1a27f06c..477a3a20f860 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -666,6 +666,7 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 			 DW_VR_MII_PCS_MODE_C37_SGMII);
 
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
+		/* Width of the MII MAC/XPCS interface in 100M and 10M modes */
 		mask |= DW_VR_MII_AN_CTRL_8BIT;
 		val |= DW_VR_MII_AN_CTRL_8BIT;
 		/* Hardware requires it to be PHY side SGMII */
@@ -683,9 +684,18 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	val = 0;
 	mask = DW_VR_MII_DIG_CTRL1_2G5_EN | DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
+	/* MAC_AUTO_SW only applies for MAC-side SGMII. */
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
+	/* PHY_MODE_CTRL only applies for PHY-side SGMII. When PHY_MODE_CTRL
+	 * is set, the SGMII tx_config register bits 15 (link), 12 (duplex)
+	 * and 11:10 (speed) sent is derived from hardware inputs to the XPCS.
+	 * When clear, bit 15 comes from DW_VR_MII_AN_CTRL bit 4, bit 12 from
+	 * MII_ADVERTISE bit 5, and bits 11:10 from MII_BMCR speed bits. In
+	 * the latter case, some implementation documentatoin states that
+	 * MII_ADVERTISE must be written last.
+	 */
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		mask |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
 		val |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
-- 
2.30.2


--HYAL5MAMprQXQslD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0004-net-xpcs-add-SGMII-mode-setting.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next 4/4] net: xpcs: add SGMII mode setting

Add SGMII mode setting which configures whether XPCS immitates the MAC
end of the link or the PHY end, and in the latter case, where the data
for generating the link's configuration word comes from.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 37 +++++++++++++++++++------------------
 drivers/net/pcs/pcs-xpcs.h | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 75ed8d535de2..14493cb61c85 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -676,11 +676,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 		break;
 	}
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		/* Hardware requires it to be PHY side SGMII */
-		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
-	} else {
+	switch (xpcs->sgmii_mode) {
+	case DW_XPCS_SGMII_MODE_MAC:
 		tx_conf = DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII;
+		break;
+	case DW_XPCS_SGMII_MODE_PHY_HW:
+	case DW_XPCS_SGMII_MODE_PHY_REG:
+		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
+		break;
 	}
 
 	val |= FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK, tx_conf);
@@ -692,21 +695,18 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	val = 0;
 	mask = DW_VR_MII_DIG_CTRL1_2G5_EN | DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
-	/* MAC_AUTO_SW only applies for MAC-side SGMII. */
-	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
-		val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
-
-	/* PHY_MODE_CTRL only applies for PHY-side SGMII. When PHY_MODE_CTRL
-	 * is set, the SGMII tx_config register bits 15 (link), 12 (duplex)
-	 * and 11:10 (speed) sent is derived from hardware inputs to the XPCS.
-	 * When clear, bit 15 comes from DW_VR_MII_AN_CTRL bit 4, bit 12 from
-	 * MII_ADVERTISE bit 5, and bits 11:10 from MII_BMCR speed bits. In
-	 * the latter case, some implementation documentatoin states that
-	 * MII_ADVERTISE must be written last.
-	 */
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		mask |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
+	switch (xpcs->sgmii_mode) {
+	case DW_XPCS_SGMII_MODE_MAC:
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+			val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
+		break;
+
+	case DW_XPCS_SGMII_MODE_PHY_HW:
 		val |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
+		fallthrough;
+	case DW_XPCS_SGMII_MODE_PHY_REG:
+		mask |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
+		break;
 	}
 
 	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, mask, val);
@@ -1500,6 +1500,7 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		xpcs->pcs.poll = false;
 		xpcs->sgmii_10_100_8bit = DW_XPCS_SGMII_10_100_8BIT;
+		xpcs->sgmii_mode = DW_XPCS_SGMII_MODE_PHY_HW;
 	} else {
 		xpcs->need_reset = true;
 	}
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 268a9be21c77..f1ba6d6a9ced 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -111,6 +111,25 @@ enum dw_xpcs_sgmii_10_100 {
 	DW_XPCS_SGMII_10_100_8BIT
 };
 
+/* The SGMII mode:
+ * DW_XPCS_SGMII_MODE_MAC: the XPCS acts as a MAC, reading and acknowledging
+ * the config word.
+ *
+ * DW_XPCS_SGMII_MODE_PHY_HW: the XPCS acts as a PHY, deriving the tx_config
+ * bits 15 (link), 12 (duplex) and 11:10 (speed) from hardware inputs to the
+ * XPCS.
+ *
+ * DW_XPCS_SGMII_MODE_PHY_REG: the XPCS acts as a PHY, deriving the tx_config
+ * bit 15 comes from DW_VR_MII_AN_CTRL bit 4, bit 12 from  MII_ADVERTISE bit 5,
+ * and bits 11:10 from MII_BMCR speed bits. In the latter case, some
+ * implementation documentatoin states that MII_ADVERTISE must be written last.
+ */
+enum dw_xpcs_sgmii_mode {
+	DW_XPCS_SGMII_MODE_MAC,		/* XPCS is MAC on SGMII */
+	DW_XPCS_SGMII_MODE_PHY_HW,	/* XPCS is PHY, tx_config from hw */
+	DW_XPCS_SGMII_MODE_PHY_REG,	/* XPCS is PHY, tx_config from regs */
+};
+
 struct dw_xpcs {
 	struct dw_xpcs_info info;
 	const struct dw_xpcs_desc *desc;
@@ -121,6 +140,7 @@ struct dw_xpcs {
 	bool need_reset;
 	/* Width of the MII MAC/XPCS interface in 100M and 10M modes */
 	enum dw_xpcs_sgmii_10_100 sgmii_10_100_8bit;
+	enum dw_xpcs_sgmii_mode sgmii_mode;
 	u8 eee_mult_fact;
 };
 
-- 
2.30.2


--HYAL5MAMprQXQslD--

