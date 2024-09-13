Return-Path: <netdev+bounces-128040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72789977995
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84408B252D1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE0187334;
	Fri, 13 Sep 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqDlCX20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D6F1B9B3E
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212306; cv=none; b=lWYZbIxFO3JYh0YAmELFm0LH5oxZLG8755ZJEKcGvfRD+jTzjmA2rFujs0sxt+VeXiDXcJSm8fGnbRWVP8iuuGMyNWPwYmNLNkfMxuP9v+XhB3Y7niwV/5JmNuFZXtr07kLTkXo9illPTmKxSMGT3cAUEz6jtExaIm0mWQ+fvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212306; c=relaxed/simple;
	bh=Dr+NTsOdckpyJ9QjYWFcjtmzaimU0NLvQrY+704mVYk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oEQ+WXL7j5+aUruEW0JZ0duCWGYcmYCKw1X3FCcuzFWG8IOYi8oFXIU38Iegx/9IXV9cMLUAPsRE8A6GPaUkCDgKMNXuZ8M1945LLx9w9RrUNeobmdiDk4hhIn/3AodkKFCb5luVvvtRjB350fVnitqIpxK9iWplQcpDOghq7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqDlCX20; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053a0bd0a6so18829395ad.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726212304; x=1726817104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+E/Cj2sUSKsqIWoS2514usEvp5ibNeqiHKZA9hwExs=;
        b=dqDlCX208G05r/UIOmtnniQOD+kjkqGEL7LJ7C25cI3v//wkcsbUWF2921ejpcpw7r
         GsxCOIMbtG0gaBWJaraH7PzPUiqDuZ8DKRXDRjybQ3Z4IKKtCjdoClXcDOM3Y4CWzjBv
         o/4J4Y0iPpS7Z0BdWSKP3102CGTRR0a1iSfYdLIzyz1d4+DFMhB9gO/C6K6pJImKNScm
         BYIyOPnjDOLrDk1YeiN5EoPiSD54/3LKyxJnmBTisx1pawHvf9013RFX4jEQATm6HRtq
         pQNETDXJUSwxV/seaaz7rbL5PsuY1cosbIunt2MKwZKj/MddcDwnzE2vlwRbtE7r8o4T
         bc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726212304; x=1726817104;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+E/Cj2sUSKsqIWoS2514usEvp5ibNeqiHKZA9hwExs=;
        b=hmdjBefEqfux+4HuVus7hF/tjoAfeFcU4lBffTjsJ1kFURhXxg0Ddo8d5M9vqff9dl
         YAq+UsuW6ub4cRFg41RPpkNgEdDbt2iOFVE+Y/rY5Nhl9qggnmyi+k/kJNk1o1ltocYi
         RZlxefEcMXpMme/e86fglfp3FVOlVMfdHCCH6napvipDLb92dM3csbfbADoR/W7CPRee
         FBMjysErY6hyceoYsiSUHpcih99ovQXCeQ+p3IZ5jUUHgiUg0DyoTQv2jE5cmQb6ijeN
         lWtUwE6O87/mWhHjhjmyrwkQ/MjnqrOw1MB8YHPS3q536kmh/1LDMUtPmu0UMMKQN3b6
         0cpg==
X-Gm-Message-State: AOJu0Yw4FwaJciXMXesPsxHj/cg/iFCvMAfFzCNZ4SmyZKyFTPGX4pQz
	7kpX8jZLDp1j/6vRNmAx42Ef44nd6ySaTz5PQgmxACKI+ITL+0BD
X-Google-Smtp-Source: AGHT+IE8L7BL09jVlWM0YxLnJ/Xc9ekC+By4RePzMEeHJkyUOIoj3JXWX/PoJP/5urWJ61v4UKCgnQ==
X-Received: by 2002:a05:6a21:6711:b0:1cc:da34:585e with SMTP id adf61e73a8af0-1cf764c40d2mr7726514637.46.1726212304316;
        Fri, 13 Sep 2024 00:25:04 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba4866sm2833426a12.3.2024.09.13.00.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 00:25:03 -0700 (PDT)
Date: Fri, 13 Sep 2024 07:24:49 +0000 (UTC)
Message-Id: <20240913.072449.1448639398786513810.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, fujita.tomonori@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 4/5] net: tn40xx: enable driver to support
 TN4010 cards with AQR105 PHY
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <trinity-0e61ef5a-b461-485b-a7ea-787ffe9b1689-1726083054223@3c-app-gmx-bs04>
References: <trinity-0e61ef5a-b461-485b-a7ea-787ffe9b1689-1726083054223@3c-app-gmx-bs04>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 21:30:54 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

> Prepare the tn40xx driver to load for Tehuti TN9510 cards
> and set bit 3 in the TN40_REG_MDIO_CMD_STAT register, because otherwise the
> AQR105 PHY will not be found. The function of bit 3 is unclear, but may have
> something to do with the length of the preamble in MDIO communication.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  drivers/net/ethernet/tehuti/tn40.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
> index 259bdac24cf2..4e6f2f781ffc 100644
> --- a/drivers/net/ethernet/tehuti/tn40.c
> +++ b/drivers/net/ethernet/tehuti/tn40.c
> @@ -1760,6 +1760,9 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err_unset_drvdata;
>  	}
> 
> +	/* essential for identification of some PHYs is bit 3 set */
> +	ret = tn40_read_reg(priv, TN40_REG_MDIO_CMD_STAT);
> +	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, ret | 0x8);
>  	ret = tn40_mdiobus_init(priv);

How about setting the speed of mdio 1MHZ by calling
tn40_mdio_set_speed() like the vendor driver?

The following works for my TN9510 card.

diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
index bbd95fabbea0..e8b8dea250f2 100644
--- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -183,6 +183,7 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 			ret);
 	}
 
+	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_1MHZ);
 	ret = devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",

