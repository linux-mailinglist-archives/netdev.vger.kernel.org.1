Return-Path: <netdev+bounces-235542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C344C324D2
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F398F3A4DC7
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94504338912;
	Tue,  4 Nov 2025 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bZp0vjf+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E732D7DC0;
	Tue,  4 Nov 2025 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276870; cv=none; b=YDBzHBzTsbFbQIds0WgNV8hn59vjaslNWIOYYlXyaXz4qhI2SIix0A58R2cObztkdifMbvmZpKBby+VAENk7/i8f8dcFZxy5tulC2UAOqjLS3SfCo5BcSK0BoxyboFRFUVxe35M+hYHBp/lq3LHiHzR21TciSHLa7IvHVWXDr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276870; c=relaxed/simple;
	bh=+8zvBh8LshHQVCuidCBDTNgsJOUTcgVdK9arN51f+7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErAhX6fSK/55u7ACm8k74Nl5rMXAZP+WnOWU4VMb27oFlwpMRjpICv9W4206TF3zDchwYeLUh7tAEULDU2Wpw2tmPG36VZ4faXJO33cZ1F9XMTc7WqWBvscC205EBew23C6i6VZGOeMZu7myLkaRSXD2ez0NbdVt5K8e3nwZzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bZp0vjf+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KY3hCDqRp5WKA8hTxQkIYFi4A0Sonxlcdgq2gx69YeU=; b=bZp0vjf+EjCAn4koAHb9xIXFmQ
	WUXsIXFLu67chzuhEI/Nte9o9ujZ0nID/uvhX48pY/z2Xsbyc75cSyVA8+nUEzqi98JfiZ56lgWjl
	/qFCuPU3LV1seQaPiAJj/5/2gQBPjZojurce3ZCwJ13BEZAaVXDIdMSAEdPvEaBBJHLWkVItr0dwK
	4+dKLYLl63W+UGv8VD6AN+xh06CfDuBK72+3x3t1M4ca8OYAVDrZTz+XT3szPNpSbptP8YWG5yBtG
	0SaLVKlmlxs4v97a1iIf5ua38Jsqs3epM8qeuKZANehGFsAJasNh/EJXKJmuZ5sZDGZQUXDd0Ltfg
	9RCUHsgA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41404)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGKi2-000000002Rk-20ST;
	Tue, 04 Nov 2025 17:20:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGKhw-000000004vQ-3yts;
	Tue, 04 Nov 2025 17:20:36 +0000
Date: Tue, 4 Nov 2025 17:20:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
Message-ID: <aQo15IqD4A0S0pfy@shell.armlinux.org.uk>
References: <20251104151647.3125-1-ziyao@disroot.org>
 <20251104151647.3125-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104151647.3125-2-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 04, 2025 at 03:16:45PM +0000, Yao Zi wrote:
> Most glue driver for PCI-based DWMAC controllers utilize similar
> platform suspend/resume routines. Add a generic implementation to reduce
> duplicated code.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

