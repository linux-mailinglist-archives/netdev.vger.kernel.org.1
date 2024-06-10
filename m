Return-Path: <netdev+bounces-102158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86137901ADF
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782F51C20F26
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 06:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6710A22;
	Mon, 10 Jun 2024 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm1oqjIy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1681C683
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999840; cv=none; b=Vk4bMM6SbBS+INgaJUg+SHlM6wVNv/oncnkO8KG4rB8SHDeJ9epNzceT87oE8o1VJ51esnnFjO5ZJjsSjL9E8KB50SGxAtEj5NaL08SvERRF7nUP4SH+7mb2vs1xXEMqMQ2XYizERrg68B0NCNYU1ms6EImbQSG+5fDwsV/gBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999840; c=relaxed/simple;
	bh=rO8kFfUAwiVUX4C+K6sVsgoV5K2IctRLh1L/eTWYhlo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fqX7vIedsVrIRvcSxG8cjxBPg6Mdgds3wYPEePgojhpjDcYDZ6McOIFBBSW4oVhlBqOygGh+wjB5KF6TGaVhshzNEGlTBWid+FLx+iZG9hgXoxsMCCO/spk9tsWXU9qumfAv1FGnX+zjf3xVsgoNiWsTAG/0tl+5yr9GG0oT4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm1oqjIy; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c2c78f40acso121195a91.2
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717999838; x=1718604638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiPQhbQPOW6Uhn+cGOIeuZphxt1wkYSjJ9AkYrVE56Y=;
        b=Vm1oqjIyr61bVDs3/Mcv+5zpyi2KjoVjEEAudhNetbspa3nxagxRoHDuGnQYI18nRr
         X3PMI83efnm8HEczUqkqixgIWu/KuWkz/wHGZ2dH3ch+vLtbJwvUYhgq/YB3QkrYsckB
         N0pT49n9ihpnQDz+j6gHlJadjXFmOilyc/yVlgCoN92803UbvczwVka+0lqLlT8ISkxA
         0c3/dF6uIHFDoMGqkr8RScdSIrZ6UWz58tQAkUsmhbDOYM9f2X8Qxlto1TNI2XrKzFKb
         rmICo77K5B8bDO8KgGiEroNP6I2UmEkFbw0Yo6Ny4F71iL7Tn8JiDJHq+XnVxPi7ipxh
         blbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717999838; x=1718604638;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DiPQhbQPOW6Uhn+cGOIeuZphxt1wkYSjJ9AkYrVE56Y=;
        b=tq6hESRg/D6Gflbyz3oPO5I6iSc4OLQPohPAcajDJVPNN6+ee/qgOrnc8IvoaQ0tGk
         8kZGrbOVacMOGZW5pXCULJU+RiEVKs69A8xcC8UuJP6TbdcNkvFZbbWsiTWu8cGEfXPM
         sJIJOHxgErLlF5klf54GJOQlUN5BNzKJBS0bM5ZE4qobibXwP117U/UA8yJPp0+taBpD
         PW2aCOdwdnHPHezKIrDtFLxqYFH+Y7k8GY237oXq1eOMHa9Z9qHu6ys5b56p9rVpwOJm
         PU8zimIFigXxNyXvXQQQoPf3GgCy9Am3qt9svreUU6uCpFug27jLkyGIAQuuwd87qqrH
         C4lA==
X-Forwarded-Encrypted: i=1; AJvYcCWWGemHUILBO5KknAgwBFgb0KNPjRykkUE8BX5HN091GYUdVg/XCTApODC8xjhOjnKflp3N2fS6ZfuG7DU3KDfu4aKq+AzK
X-Gm-Message-State: AOJu0YxfpQ+g4C3cJsC8POpLWtSilc5P46p4wUSpRJSKw3/ppHJnvHml
	cEce5DNBDtCQ++iJq4BhvsUwsnIqtCnOj2TcwTfIfLzvRKlsNNYX
X-Google-Smtp-Source: AGHT+IHA3vGSyKj0kr4ZhuxWOHTAiFtG1j3W4W2UpxDGiZxE0/oI00dkHXdzxqNqG46Ug52ONZ/5jg==
X-Received: by 2002:a17:902:ce8c:b0:1f6:daa5:95c with SMTP id d9443c01a7336-1f6daa51000mr81483705ad.6.1717999837763;
        Sun, 09 Jun 2024 23:10:37 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f03b7079sm36970315ad.143.2024.06.09.23.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 23:10:37 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:10:23 +0900 (JST)
Message-Id: <20240610.151023.1062977558544031951.fujita.tomonori@gmail.com>
To: linux@armlinux.org.uk
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 6/6] net: tn40xx: add phylink support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZmWFNATfPWEPSLyf@shell.armlinux.org.uk>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
	<20240605232608.65471-7-fujita.tomonori@gmail.com>
	<ZmWFNATfPWEPSLyf@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Sun, 9 Jun 2024 11:34:28 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

>> +int tn40_phy_register(struct tn40_priv *priv)
>> +{
>> +	struct phylink_config *config;
>> +	struct phy_device *phydev;
>> +	struct phylink *phylink;
>> +
>> +	phydev = phy_find_first(priv->mdio);
>> +	if (!phydev) {
>> +		dev_err(&priv->pdev->dev, "PHY isn't found\n");
>> +		return -1;
> 
> And my email client, setup with rules to catch common programming
> mistakes, highlights the above line. I have no idea why people do
> this... why people think "lets return -1 on error". It seems to be
> a very common pattern... but it's utterly wrong. -1 is -EPERM, aka
> "Operation not permitted". This is not what you mean here. Please
> return a more suitable negative errno symbol... and please refrain
> from using "return -1" in kernel code.

Indeed, my bad. How about -ENODEV? Or -ENOXIO?


> (The only case where "return -1" may be permissible is where the
> value doesn't get propagated outside of the compilation unit, but
> even there, there is the possibility that later changes may end
> up propagating it outside... personally, I would like to see
> "return -1" totally banned from the kernel.)

Understood. This driver should only use "return -1" here.

