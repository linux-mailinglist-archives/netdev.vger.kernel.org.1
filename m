Return-Path: <netdev+bounces-129259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE5497E869
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C465B207BF
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF51946A4;
	Mon, 23 Sep 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LkUkPBKJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96A50271
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083127; cv=none; b=j84jrsmBqEK0qvIMBQeZvKS/xME65AhnBW9c2uVo6m3nd/IQxO28eSHjiGeaWu0UWl8M76gGSFIY+uF/epAOvRfDBUi+7XdlnRtp6pnpaWqJKczvskTEkLu/hgY5iSvs6CyuVUK552lG3SWrWapRvc1EUESLH9/3CR9jIVJX6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083127; c=relaxed/simple;
	bh=ZBMjAUrVmUz4k0uWFuuTUxfNF2FkuZ922UrTseo5G0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RYBSrKvfcca7j4JCqoIYjXR7yEraabOSpOnWijVDyjhERaXWx9Z0Y8cxsTQQNInFJZjHdrNYYOK566T32hyTG2UERiePp6wIUGLZla4Bl2JTKBDiecpV3tUkgBJkCl3HIOSvs8kvCx3jPjE6YygFhhomdhvHVD5cHcS2ItUrl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LkUkPBKJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4AjFsHjV87EgGlQb4MGpKgCFjon/l3tzLRlflfUOgEs=; b=LkUkPBKJkVZrgfGKzJGCJrhH07
	MB2kORPfKdtT8xnDgDlo3vNG5qtQvRkjDToXWaWnasoQA0CJikMRcoKeeeWfYPJNjsxhdK5efeifp
	TwMU6SVCPPS7bsjrJWUY6xRVk9IiyIFs+JOSxctuF0bbYZHxWPjIsXPnWoR1Krze3WL7ahczi18rg
	XHH7o8pA1EVEFD6UoD8fQ3Q83WteavJMx8xtoQVntEM/TGuFiqZo8px1WU8wpk112Vf8Wj6hHHsmX
	FLR8gghILTmU5NTPsyvNsp7zhUci/MJWYOhXg3VrLcO9dyVuYQ9olQtMrTQuWwW0jTyredT9CmzNN
	0UCUCtdg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35914)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ssfDE-00042Q-1i;
	Mon, 23 Sep 2024 10:18:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ssfDB-0005I5-0E;
	Mon, 23 Sep 2024 10:18:29 +0100
Date: Mon, 23 Sep 2024 10:18:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org
Subject: Bug? xpcs-wx: read-modify-write to different registers?
Message-ID: <ZvEyZGKt5elazWfj@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

While making some cleanups to the XPCS driver, I spotted the following
in pcs-xpcs-wx.c:

        val = txgbe_read_pma(xpcs, TXGBE_RX_GEN_CTL3);
        val = u16_replace_bits(val, 0x4, TXGBE_RX_GEN_CTL3_LOS_TRSHLD0);
        txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);

This reads from the TXGBE_RX_GEN_CTL3 register, changes a value in a
field, and then writes it back to a different register,
TXGBE_RX_EQ_ATTN_CTL. This doesn't look correct.

Please check whether this code is correct, if not please submit a fix.

Thanks.

Russell.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

