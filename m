Return-Path: <netdev+bounces-105357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCF910A19
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF541C22150
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCF1B1406;
	Thu, 20 Jun 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpSVrxW7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A791B0125;
	Thu, 20 Jun 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897950; cv=none; b=P/8ZltntZkj204oBk4nTkmQZWmv7LBcU4jCgXPPgODm8PM3VLhp3Pb/FGt3vXLytNOZsvN6MZ5yOuSyHL/sqcZxUw9TvhsxIFOyjT+KMpZW2V/iL8QkYOBq88uCXUMQvsxVDVosfHBsMP5CIzB8U7910V2zkSkCAfon9SG/0JuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897950; c=relaxed/simple;
	bh=YMJ5rg+LstDIy8JSldCpspn3ZdW7vTZ+L5dwUQKY7Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmgD/HJRNF7A/F0oUrvqY3N6Rrl9+/0Ng/DmgQTe3w/uaueywSFtRucjWfHO+dR3r5mn9YR3YqktVvNlWKg9mnoB5B1hI9MGGtUVvBupnRWlqfk56c4+4UPFKuYVnj5le4g4ltXSLLIltFraqReOx0+z6CFHBzOfCdrlAsDv6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpSVrxW7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso1183271a12.2;
        Thu, 20 Jun 2024 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718897947; x=1719502747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEZnmjNFKC4uie8fSpDDUfBNfzyWC2aExQeYe8P7A8c=;
        b=kpSVrxW7y50q1lS+MbT39loX/IPgeBDmhWtJwsv5gnLeK8Mhy8Qb5q/dXgB0ygnT+Q
         WZ+eCx8yF0wAGNdiehw57UDF3lX9jsYnG9et0ECIPrQr81woE+bJ04jzgaQqC14VqYGB
         KHWgRueYGkWYcIhe5UkDD7V4u5BeflHd8E+9+thGAKrglNxudkDsoAYfWfyIcVdt+AV+
         5nOI2Oobv4NmKy/pdG0ZKVW4zP/TJCuxYzTMBJ4OOUlvT93HxUGeWiT8gD5Slm/u5GmW
         m4Q04LMe3ATyYoAyNGF4kgxwifcFi1STaky2wCbp5QJLbWYCCcX2Q4UOhHc5YH46mTIS
         09Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897947; x=1719502747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEZnmjNFKC4uie8fSpDDUfBNfzyWC2aExQeYe8P7A8c=;
        b=crjLaKjkxL1df6F/QehfzAd9bWBF14mS9tCRIqjTl/Pt7eUkLkICfwGg/Rz7fm1ttw
         scsz5oVJAKUpnu5mMdjSOapXzAbA/i3Un9Esboi/ttVdaiAzhrIBtHgHgv3+1ZTPvKG4
         ge8Cg/oynTvMC6btolh3GLWDdW9hfFcscF5MsDRnyUV8V0ibm5H/Jvig3564bN7xSBQa
         j9pqjsIYbxSmJkTj2GsOSydMP0EkHE6xKdim+jNyXjdwbyqfmc++Z1I83wxvWsSfESxs
         LxBdaiM9xZQ3YQxTrg8eHQPctCRtBARJttc5lDhpMfPBSZ/WDj7VhSEhXbDmOC+/RWEc
         1YGg==
X-Forwarded-Encrypted: i=1; AJvYcCWsh5RnMje9j5YoqGWR13OBECLFjS22pppEFe2nMZdDrHGYeYhO/N7bSsH1U6MzVejmDQ0VcLe2FjytV5AX3gLQvmSnb08/Yln+GgES
X-Gm-Message-State: AOJu0Yz88XlvAdrCe30icGmi2IYFhOAKlrNimETSkUSqT0JKWKh3NUh8
	27zxt1XFkUsEcpN3+KZkRvSqqdt/CyHm66dRae9SM2S0/7Xz5gmS
X-Google-Smtp-Source: AGHT+IFA98MSuyfBmi+dvaSL2Ri0kd08hpOT64n1FXIbWWmXEsW0KBOi+ncjA8nQvB7i6TvKKoYv4w==
X-Received: by 2002:a17:907:c086:b0:a6f:b687:1ee3 with SMTP id a640c23a62f3a-a6fb687211dmr333086266b.1.1718897946474;
        Thu, 20 Jun 2024 08:39:06 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5731cf4csm772363866b.188.2024.06.20.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:39:05 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:39:03 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/12] net: dsa: tag_sja1105: absorb logic
 for not overwriting precise info into dsa_8021q_rcv()
Message-ID: <20240620153903.pxagjityrvff7e7x@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-4-paweldembicki@gmail.com>
 <20240619205220.965844-4-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-4-paweldembicki@gmail.com>
 <20240619205220.965844-4-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:09PM +0200, Pawel Dembicki wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> In both sja1105_rcv() and sja1110_rcv(), we may have precise source port
> information coming from parallel hardware mechanisms, in addition to the
> tag_8021q header.
> 
> Only sja1105_rcv() has extra logic to not overwrite that precise info
> with what's present in the VLAN tag. This is because sja1110_rcv() gets
> by, by having a reversed set of checks when assigning skb->dev. When the
> source port is imprecise (vbid >=1), source_port and switch_id will be
> set to zeroes by dsa_8021q_rcv(), which might be problematic. But by
> checking for vbid >= 1 first, sja1110_rcv() fends that off.
> 
> We would like to make more code common between sja1105_rcv() and
> sja1110_rcv(), and for that, we need to make sure that sja1110_rcv()
> also goes through the precise source port preservation logic.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

