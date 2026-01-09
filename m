Return-Path: <netdev+bounces-248330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9BDD0707E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42F55301A73B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A3A228CB0;
	Fri,  9 Jan 2026 03:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kb5gGg5v"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-100.ptr.blmpb.com (sg-1-100.ptr.blmpb.com [118.26.132.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874A17AE11
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767930507; cv=none; b=aTtoP6cQRgKJd7p65pGaU397ER+BEzQeENtQgkgq4LY3NTC2FfxRhY3xg6QS/xKFfcwHiEAOGqVdFpbS8JHjLlDIMQHTDyxPk23bWIfggn86BfKxcI1bmXzM9XIQozesHVijiNCMWdoM7bBtGdQkZcg2WbSa1IFe8zI34zYdkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767930507; c=relaxed/simple;
	bh=Rhb0igZH1rdeWE6EUpFJeBTB84LB5x64KhBddp3LP14=;
	h=From:Mime-Version:In-Reply-To:Message-Id:Cc:Subject:References:
	 Content-Type:Date:To; b=VdfmJHR3Mo+kbUt1rKy0fDlU+3EAzApegLQ9ZN7yFtqF5/6iH6UHJoCUXFlPRHF4yovmSzqWG/9xmHIac7KLiIvJbQjjM4SCQxVc+P4/oXVSVBSAT1M1ntBPEY4cqRo5jgiRggzZ18BvO/gu9AhOI4x9u03z48YLfcSklFZhmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kb5gGg5v; arc=none smtp.client-ip=118.26.132.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767930493; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Rhb0igZH1rdeWE6EUpFJeBTB84LB5x64KhBddp3LP14=;
 b=kb5gGg5vBZ3HcycKS6uFA+79Nh48KyLYLjPufyI05OryBVnlESBFYaqh9jHitO13rxXWBx
 3EmCIy6S5oead51pvk303CnkJnAPTgncB1SXkrNTkGByV3GNxeWJxP6PC7DKNgdXc3Q5et
 7nVMBWyaJs2e8Q/lDI+c/QG58VTi63C35VAzaZMIjizbI4FL9gt22lGw9thR1yY/WUVExg
 zW4XG2tedrOd+TUeioIgk2yFXhLNaYwx7jUd7ZScklZF2lbIJE8yIMNNOSRWyukg90REVB
 LbN1hnFVrBfHWrdobCjOSq12lvfhhKJ1KDXFl9m7nlplYkhyggH342ZQJMYbFw==
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <ea3db627f1d7fb4afb1d7b36253ff369341fbad3.camel@codeconstruct.com.au>
Content-Transfer-Encoding: quoted-printable
Message-Id: <51dd8bf76aa056fbc966e48132cac2607d2326ca.20efc551.304a.4dd9.ad9e.59f1ab3bc329@bytedance.com>
Cc: "Matt Johnston" <matt@codeconstruct.com.au>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mctp-i2c: fix duplicate reception of old data
References: <20260108101829.1140448-1-zhangjian.3032@bytedance.com>
	<ea3db627f1d7fb4afb1d7b36253ff369341fbad3.camel@codeconstruct.com.au>
X-Lms-Return-Path: <lba+169607a7c+675f22+vger.kernel.org+zhangjian.3032@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Jan 2026 11:48:11 +0800
To: "Jeremy Kerr" <jk@codeconstruct.com.au>

Hi Jeremy,
=C2=A0
> > The MCTP I2C slave callback did not handle I2C_SLAVE_READ_REQUESTED
> > events. As a result, i2c read event will trigger repeated reception
> > of old data, reset rx_pos when a read request is received.
>=C2=A0
> Makes sense. You're just invoking any i2c read from the peer controller
> to trigger this, is that right?

Yes, the peer just send a i2c read, like `i2cdetect -r -y 4`.

Jian.

