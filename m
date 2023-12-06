Return-Path: <netdev+bounces-54247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CD08065C7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CFA1C210B0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41389D2FA;
	Wed,  6 Dec 2023 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ3N2opx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24806D2F0
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36809C433C7;
	Wed,  6 Dec 2023 03:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701834051;
	bh=FBt1ijYUbhiyz3fIsr/MI4Jbrx7bhqPm7FXx1/PgtrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oQ3N2opxHiOiJT0bs8bAqxt9mQNIF6tOpDVgvU3PXVzIUzjsw53xB9l63Ru+q3zks
	 /PhlNUWL7WgjoddEONyZOScLATQwfhxHfjvL+Cm27ap9xLZAluh7qIXPflZkpDpzv0
	 NdI5JVUTo9aYt2CiCbeh9d/W8BWBv5nntG0O6w4/JThd+Qk6byKsnpLYrNCMDMngVF
	 1xYUxnfytS/hADG4LtR77eMJnuKIsazR4Gt2gzPyKyZsT9nzz07siSeespLt2xC2XN
	 yyugIcKwweowPFUip9aflKbDCOQfMAV9IxSOPGoCMh1HfjnUFoWcduZBJLDSAaNBGp
	 xh4W0gnaE4Gkw==
Date: Tue, 5 Dec 2023 19:40:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu
 <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v13 01/13] rtase: Add pci table supported in
 this module
Message-ID: <20231205194050.7033cc2b@kernel.org>
In-Reply-To: <ae4807e31b53452ebf176098d95cf1fb@realtek.com>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
	<20231130114327.1530225-2-justinlai0215@realtek.com>
	<20231201203602.7e380716@kernel.org>
	<ae4807e31b53452ebf176098d95cf1fb@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 03:28:32 +0000 Justin Lai wrote:
> > > +static void rtase_remove_one(struct pci_dev *pdev) {
> > > +     struct net_device *dev = pci_get_drvdata(pdev);
> > > +     struct rtase_private *tp = netdev_priv(dev);
> > > +     struct rtase_int_vector *ivec;
> > > +     u32 i;
> > > +
> > > +     for (i = 0; i < tp->int_nums; i++) {
> > > +             ivec = &tp->int_vector[i];
> > > +             netif_napi_del(&ivec->napi);  
> > 
> > NAPI instances should be added on ndo_open()  
> 
> Do you want me to call netif_napi_add() in the .ndo_open function,
> and netif_napi_del() in the .ndo_stop function? However, I saw that
> many drivers do it in probe and remove. What is the purpose of doing
> this in .ndo_open and .ndo_stop?

They will sit in a fixed-size hash table used for NAPI lookup in the
core. Not a big deal, but not the best way either.

I think the main thing that prompted me to ask was that I couldn't find
napi_disable() in the first few patches. You should probably call it on
close, otherwise making sure NAPI is not running when you start freeing
rings is hard. synchronize_irq() will not help you at all if you're
using NAPI.

