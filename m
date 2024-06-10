Return-Path: <netdev+bounces-102175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BAB901BF4
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861571F226DC
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE422081;
	Mon, 10 Jun 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvZff8ZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63263C7
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004956; cv=none; b=NbaQjHDGlr6oGYIxsWiDm/kTYj6I1YD6+j1oejUnE36DXANzcut5IZD/22hTaznwwnjOVaeqizhSzyPWyL2i63nFy/ED+FqjIFCpjWlFvqKG3ueUl+7h12UVItfCKNlNWYpBn9d4d/3Wxc6w1K1Gq16V/BP8JcufNT6vuUMCYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004956; c=relaxed/simple;
	bh=XvfJqZfNIctRMChEYlm8ZYdt86KVux+8kx82raLdYy8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kPhYfpX+QB5V0uqLekEzlNhG4XzJ9143EQrDt8IM082iCTp57goBZUBkvXMR9xzJ8SFN8ED5lTiB+fm5QM+LrHGgGoGiBgKjj82jlCdsCXoVW48GuotWoXcN16X3x3xPRYBuUpbY3a2npQCSS0tUgJOCLY/9f5bH57aMFbWMr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvZff8ZX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6e4f97c1eso2089325ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 00:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718004955; x=1718609755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwM2E+ZsYy1fjDn6giXELZADaq1T6Vs2975HqbylIHI=;
        b=LvZff8ZXzAUYAafBap4htX1IpxHYwoC8MxPNyL27FaMduDaNBxPqZmko3UTXjyRpTx
         D+fdscNaf6tUKHdYWyj6MY6qlWt2EqtmFma5JyJp9fMuwNq3UWYvJtFTKv1WBP4jrJ3G
         +IXkZJGsAjN/bxmevTtxELuIXybuTh5xcVfwl95a0PEDCY6W9o59naeVvcd/uHDLE08c
         GxL7dWp4LBqSe5+pNVUMt+scfKs5QpNMfpcoNBOY7ExSnTG4/aBjznLbekwb1OrtuxRA
         lctFgzrRsvUN5dYF8cniMKrpHAvoESolPwELfsCvtb8LSGqv1OH8sfNPfu801Qy3oQPF
         C0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718004955; x=1718609755;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DwM2E+ZsYy1fjDn6giXELZADaq1T6Vs2975HqbylIHI=;
        b=odlta+YV/oBDqmG4iG4aAdMMf1eXfrJN7IEu365+Ng/fiv9m42sxkvh6H2rOFMDpK8
         nCM3PNNLLuAlXxDADpHyN6g/a3Bka2PGr2DfmtsxMD4j46nKhqPoxvNDKMA0LmKhhl9J
         2QbfxphmfoPYxckUd6k3GFs3Uw5s30W8OAdHw7nR3i/alBSpmplNOrIYEJ66/moZ89sJ
         TpHkxVzta7UjodhUuO7rG+CXNNtv87xqLQAMe/ajuzY3/iOO9rUabU2KEWI9q2gvS3gA
         P2Z15ZaLgZ4E1+Cu3WVhPnkAO2quKTayasYi/pOLrdDbfcoBdgEMjbrWHDueFFAxGFkS
         LboQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiaNVTx1Dl4tCjW1JuW5cT+CH7nwUcIuZlVmAfgWZQwERjSarB/cYRUEfYW18pe6asvHyPuSpXitb6zzmVqUa0/OkGFwa0
X-Gm-Message-State: AOJu0YyZXjI4PFNKCRitVHZ6GDEQcyCX90S4hcgdO197RGpeReLbWuI0
	wbSo+vfLGQR1zcH8DSDtj5+t0sv2XCL5pnBC3Ak0x2sURtBhmGCe
X-Google-Smtp-Source: AGHT+IHL/wFyBMVVYR/07lzxhojgmC46OLIPffCcc21uq+QqaO8W6hRlD2YoEKAOxcjdsHez9Khueg==
X-Received: by 2002:a17:903:2349:b0:1f7:1303:f7ae with SMTP id d9443c01a7336-1f71303fcd4mr24856185ad.3.1718004954749;
        Mon, 10 Jun 2024 00:35:54 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f7111c4ac2sm16608365ad.161.2024.06.10.00.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 00:35:54 -0700 (PDT)
Date: Mon, 10 Jun 2024 16:35:40 +0900 (JST)
Message-Id: <20240610.163540.1951943035923637886.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 5/6] net: tn40xx: add mdio bus support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <de03d402-306c-419d-a441-2fa3c3b63a89@gmx.net>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
	<20240605232608.65471-6-fujita.tomonori@gmail.com>
	<de03d402-306c-419d-a441-2fa3c3b63a89@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 9 Jun 2024 13:22:56 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

> On 06.06.2024 01.26, FUJITA Tomonori wrote:
>> +
>> +static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
>> +{
>> +	void __iomem *regs = priv->regs;
>> +	int mdio_cfg;
>> +
>> +	mdio_cfg = readl(regs + TN40_REG_MDIO_CMD_STAT);
> the result of the readl is nowhere used. And as far as I have seen it
> is
> not needed to trigger anything. Therefore I suggest you delete this
> read
> operation.

I thought that reading the register has some effect but seems the
hardware works without the above line. I'll drop it in v10.


>> +	if (speed == 1)
> why not use the defined value TN40_MDIO_SPEED_1MHZ here? It would make
> the logic of the function even clearer.

Yeah. I left the original code alone. I'll fix in v10.

Thanks!

