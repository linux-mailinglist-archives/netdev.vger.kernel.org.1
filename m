Return-Path: <netdev+bounces-80821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256988812F7
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C591F23AF7
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C64207B;
	Wed, 20 Mar 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qM5SVBSo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098B3EA98
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943748; cv=none; b=F8GY/PlZlGTbyVICUtQ+zIB2UfZXc1Pd8ogccc6m8gIUmAHrQ5AwYrygjtGuXDPqoAKZukAW81hmWUlBL54U4OLUiXAxfVs4fpPh1ttlYYBxe37tcFlij+02sBNYXnaG6SfHXrxsVDvJe71VCi1QSgfH9lb2io2Jcvqdzw0m2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943748; c=relaxed/simple;
	bh=H1XOmKD7bRcfqq1UFgWSVIBC/zw9QBBFa1xm/jed5/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcUM5d7giWNG8lFQ7XNP2aorhU2vxhRPjoDpgiTr3f3TzmbtNi+lRdls80ufMEvD7/FRWk3NZD7gSqt62NTaZSjelp2lF2THiukyeHzweyVATXAJJv0a5i/8ioZJjS9Zc4UyZZm7ftmmWdwOyGqqpPePajx6AU/Uzd1uEtjrxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qM5SVBSo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46d0a8399aso166545566b.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710943744; x=1711548544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIdJ3/H6efkxnibONQiSADbnnZKfOXj3hF+4ocmjhSc=;
        b=qM5SVBSoKeNhdvQn/Y5ZfyBfAt7AxFmnl0fF+cYjriNoMYpfaAzVV0O2X5rq9n1C0X
         4L+jkUWg/FgyOKTd7RCSCcCkrQfzfRapLvr1n+lCTvCOeBvjAAPXO083Q55t51m5mFKL
         cEaJUlY7E1ZBp6+2yrBjWSAzGQFj62+5NLR/QbmyFD4M7VzpRyK/rClnQO6TfiAoMzSk
         vDb9XCqcLY5iFC9JfInA9SuOJVhh6eXk+WsbSEQDgGzwjsAgnlxlB0mCT+tBpXlNbZmK
         ndgH2FPWPeCEmmNv1yLybCTtCd79TXNS//bH2xARGTYQCKwjvVmI0Jhw9rCbA6jcyzDe
         vIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710943744; x=1711548544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIdJ3/H6efkxnibONQiSADbnnZKfOXj3hF+4ocmjhSc=;
        b=cNAbyLrOBl4xO59sfNCRZLOK4yzAx39SpXvCU6c7DFMxePbzRZu0aSYQfh4eJUN4Nk
         1BCSKeWVtXbHSNKM9yEZ+GhxZXilLpyDiQDYnVqRWDeQuzh0KN6VmA2vCdwasLe5Wf90
         zs9Cqe2LfO8WiAiKf6+n2JKU23B1lXnW1FZ1tpqiYDR/mF+/bTORv6tKV1jDap4o6G0M
         NTMb8czdYZPqskIzk/ViwnF69WsPaFApvfbcOYSGDC6HjU1jmqQWiDfEAseAwBQNvoDy
         VtwYP0V6ahIPj9G0a1AKPgRRKHguVD1dzqVMqQoTQvh7b9vV5x4LfdZEgvO8unMaGpfK
         KOtg==
X-Forwarded-Encrypted: i=1; AJvYcCXq1kVmRwGhIAWOdbI++pCW/0z6UeBL2ptuiM0ic9tKqDmEk5onQK4BLAbRwmqecTaO7z3vJPsKbBejKYTp+dXDtYDmtJ3f
X-Gm-Message-State: AOJu0YxDYx0rvyHQ207akaOup2gLL6rd2Fl4p0fDJ/1iOg7bqNkLuUdL
	/ndPBKUCwDKqDRw3YkYf/96tcreeX9Y+GxvFEGva0AUVRP4ABPVP/Di5KcJWgw4=
X-Google-Smtp-Source: AGHT+IHKaLgVKjjmaMssGPhGPgENyTmaminl2pI+37dLFhxxBpGvoUD3MhYFhaUXJ1R45Y5fsUtQ3g==
X-Received: by 2002:a17:906:b247:b0:a45:f9c5:3024 with SMTP id ce7-20020a170906b24700b00a45f9c53024mr5416028ejb.11.1710943743915;
        Wed, 20 Mar 2024 07:09:03 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bp14-20020a17090726ce00b00a46bdc6278csm3699309ejc.71.2024.03.20.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:09:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 15:09:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Message-ID: <Zfrt_dlYvBzlxull@nanopsycho>
References: <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>

Wed, Mar 20, 2024 at 02:48:55PM CET, josua@solid-run.com wrote:
>mv88e6xxx supports multiple mdio buses as children, e.g. to model both
>internal and external phys. If the child buses mdio ids are truncated,
>they might collide which each other leading to an obscure error from
>kobject_add.
>
>The maximum length of bus id is currently defined as 61
>(MII_BUS_ID_SIZE). Truncation can occur on platforms with long node
>names and multiple levels before the parent bus on whiich the dsa switch

s/whiich/which/


>sits such as on CN9130 [1].
>
>Test whether the return value of snprintf exceeds the maximum bus id
>length and print a warning.
>
>[1]
>[    8.324631] mv88e6085 f212a200.mdio-mii:04: switch 0x1760 detected: Marvell 88E6176, revision 1
>[    8.389516] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
>[    8.592367] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
>[    8.623593] sysfs: cannot create duplicate filename '/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi'
>[    8.785480] kobject: kobject_add_internal failed for !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi with -EEXIST, don't try to register things with the same name in the same directory.
>[    8.936514] libphy: mii_bus /cp0/config-space@f2000000/mdio@12a200/ethernet-switch@4/mdi failed to register
>[    8.946300] mdio_bus !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi: __mdiobus_register: -22
>[    8.956003] mv88e6085 f212a200.mdio-mii:04: Cannot register MDIO bus (-22)
>[    8.965329] mv88e6085: probe of f212a200.mdio-mii:04 failed with error -22
>
>Signed-off-by: Josua Mayer <josua@solid-run.com>

This is not bug fix, assume you target net-next. Please:
1) Next time, indicate that in the patch subject like this:
   [patch net-next] xxx
2) net-next is currently closed, repost next week.


>---
> drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
>index 614cabb5c1b0..1c40f7631ab1 100644
>--- a/drivers/net/dsa/mv88e6xxx/chip.c
>+++ b/drivers/net/dsa/mv88e6xxx/chip.c
>@@ -3731,10 +3731,12 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
> 
> 	if (np) {
> 		bus->name = np->full_name;
>-		snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np);
>+		if (snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np) >= MII_BUS_ID_SIZE)
>+			dev_warn(chip->dev, "Truncated bus-id may collide.\n");

How about instead of warn&fail fallback to some different name in this
case?


> 	} else {
> 		bus->name = "mv88e6xxx SMI";
>-		snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
>+		if (snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++) >= MII_BUS_ID_SIZE)

How exactly this may happen?



>+			dev_warn(chip->dev, "Truncated bus-id may collide.\n");
> 	}
> 
> 	bus->read = mv88e6xxx_mdio_read;
>
>---
>base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
>change-id: 20240320-mv88e6xxx-truncate-busid-34a1d2769bbf
>
>Sincerely,
>-- 
>Josua Mayer <josua@solid-run.com>
>
>

