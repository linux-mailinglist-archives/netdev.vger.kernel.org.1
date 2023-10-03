Return-Path: <netdev+bounces-37692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3C7B6A93
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3EF6D28164D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09C52770E;
	Tue,  3 Oct 2023 13:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A524218
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:33:35 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E0DA6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6BuH5GFh8Mg6RyT9Uc7R1PLxrAD/ymg98bloCbXBrPc=; b=IJCjMzdwq0cIGGMqC+IE6LKqVh
	Ivvbgl6jOdmyPGBu0IVmLbshtW6iJkIi7+xwKh0EC0e4rcmAeL9frC4Qcmdje34/mB8d7Y5QIxUnK
	q0cY/oklhf7EhNkOYsDdWnpEV7wR9GLWgaGJfUBEazDw2gNfoXnUJSQRE7WgygVIHmpZegcPJf9Zl
	0o1cDaQhpEpPw20rP5tpctQ+NZEe9yTr/+t+mdMorK6iYflpmvRxfmx/IhVDYtD0sbZtIRuefAKbu
	F4Xx0MtaH9FIJ2kWtm82nL5LWpe6x2CZR3Oa0wrDlifLhkXeV5oCJq6HV7SISzeCb0MaLCQpnGky0
	1UKGEc+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58146)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qnfWf-0001my-2P;
	Tue, 03 Oct 2023 14:33:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qnfWf-0007vc-Su; Tue, 03 Oct 2023 14:33:25 +0100
Date: Tue, 3 Oct 2023 14:33:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] Rework tx fault fixups
Message-ID: <ZRwYJXRizvkhm83M@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This series reworks the tx-fault fixup and then improves the Nokia GPON
workaround to also ignore the RX LOS signal as well. We do this by
introducing a mask of hardware pin states that should be ignored,
converting the tx-fault fixup to use that, and then augmenting it for
RX LOS.

 drivers/net/phy/sfp.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

