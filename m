Return-Path: <netdev+bounces-70944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16F385127D
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC09928133A
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C343984D;
	Mon, 12 Feb 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x/2Iecq+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D039AC3
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738112; cv=none; b=beGPZJBGQYOzyTmqah8kd0X7tq1zV+P+qG0xY8Qi3rPpJMEPxcVFiPgEXZMd/NYK0cxq+Hp93hTpd1KBTz35af2q/tWkxTW5mxxTqIaaB83kQhy172AzsOTATyq5gcO6Q3yAffVqPZIx2ya5VV7sWcYxYroa16taFsjxqnJ9urE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738112; c=relaxed/simple;
	bh=fqqXziK3WSOeqF8bk7q/fQGNVpiibYdRlMNvSUtrSDg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aYI9cYWHM/Mq6JZeI76h5z6arxPq6b0eqkdhyY4JbulXaipKrNvZz0Z7ypJiaH0UiL37LVY2S5rtvWnlhEupjPyv98ppBSzRv2ZpEvH75xV/W/+teDysyl6cbODz+UyhzE8GOQBHIXH1Gs4Gp6khinpBCXA5BCdqfPBd0BmWzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x/2Iecq+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HAqawrE2DI6Oa9vI6fzwf1aNFvItRA+u/00fLFXfAcQ=; b=x/2Iecq+3/KqPbYSuyvfK5ukiB
	HTENG7FqXnCMGZcD6opRLCU1Z8sAAqlTvaqQ4JOQEFnonR6POYW3ke+hjI6l87KHTqnJHic7/kQSc
	NMVdUZHWrhcQq4gr4J3tC8pskTfsOzWEeL6azbuLPOq76XLb2DSDi2Tt1OwyDAXA0SAnOJMGHQRR2
	96O+OGdsGR8Tr+rhLCilGX+Ilc9M29mmBIuGCJ1+hswE6umlhVHX0KX9MVzeFXMS+NcVMa56xOzOU
	cwnLT+aWHyrQJnqYuVteWcPf88iywB8cES79JiAKJq8lpnE4UJbmw0dhG36FV7hhtOHcR32xv7Q6q
	Ic3bnToA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38492)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rZUgu-0008Hg-0j;
	Mon, 12 Feb 2024 11:41:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rZUgr-0001oT-JQ; Mon, 12 Feb 2024 11:41:37 +0000
Date: Mon, 12 Feb 2024 11:41:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>
Subject: PSV: rmk not reviewing at the moment
Message-ID: <ZcoD8WHMsJhIUDoY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

All,

I'm recovering from flu (likely picked up in Cambridge last week at
the Arm Ltd Linux developers summit) so not currently able to do much.
What I'm able to do varies day to day.

Please do not assume that if I haven't responded to a patch this week
(or last week) that implies I'm happy with it - since Monday 5th, I
probably haven't even read it and this is likely to continue to be the
case for this week.

Russell.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

