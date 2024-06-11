Return-Path: <netdev+bounces-102490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBCA903407
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEC4287342
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6C172780;
	Tue, 11 Jun 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XahVT1YG"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585F172764
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091666; cv=none; b=qEKKQxyfcdWWmFAcwmPk9idL9L1HyvBsuKEuA+aVwfUyS8vnKkbajFbVVbeoMJmDB0G/Fa7eGOEnxps/ckrZdpIlpcnpwRDTtN0gsiTlnrFCNAsCs1CK02yRCV8HzUUjlKwVkYRVpBiu960aL1xhZPO7R9lB8TXlhLbK8t1KYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091666; c=relaxed/simple;
	bh=aASoKcq8sN2w4fFATmZxqgQFRXtjqjGMRnTkFWfJhvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zupt63wqBZhiYFQKb0pO7JX6n7v5mVyqRoX4n8tUHKSaa5KHHAGVg9XlpV6LNHn9T3piSgSQFg/I/M0VSTp7WS3uAWTtrAKb9gkIsh5+DP75ouNSZTm/VM/rKugZu6UDNqPmNW5bpwK81p3Z7ilkDKjsXBHuvmrqiexUHW1WIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XahVT1YG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA0A620014;
	Tue, 11 Jun 2024 07:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718091655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5owhW0aHxqtWSeBDnEPBf5XAJzmMgnDRGVbxbD2efk=;
	b=XahVT1YGIW8Xos7jF9WPfgrfyyu963Ak4SqkoT20MmsSeup/NaY9GA3iHJ1rOyqyfgHtfN
	WABwCpInGx0rT5PCVMivFKHun34ywFc0LULVswhe/bsLBcr5hzDto7MIHuyuHq9gY5HVGE
	PM1o0t0yAGwdvvJ6nZ1gM6ats0oaFSp9AAMKRv1obr+fJJf3jF+I6AYUWh/Ur9WEso7eH0
	/ChDShDg0MRM5TgEq0nqs4fhykllf0a+uFz0V5NlPYECbyZ061xtc+Hwy0zokR6bIdHcJF
	H01SguCr9944nNHj5VwgA44KBs2I4tAMCHawYME/Fe9a29Mv01PbUfEGVDjoiQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net-next 3/5] net: stmmac: dwmac-rzn1: provide select_pcs()
 implementation
Date: Tue, 11 Jun 2024 09:41:37 +0200
Message-ID: <13858564.5d5uVuNtuT@fw-rgant>
In-Reply-To: <E1sGgCS-00Facz-4s@rmk-PC.armlinux.org.uk>
References:
 <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
 <E1sGgCS-00Facz-4s@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

On lundi 10 juin 2024 16:40:44 UTC+2 Russell King (Oracle) wrote:
> Provide a .select_pcs() implementation which returns the phylink PCS
> that was created in the .pcs_init() method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Tested-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




