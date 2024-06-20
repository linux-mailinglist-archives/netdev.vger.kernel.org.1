Return-Path: <netdev+bounces-105252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C591042B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE6F1C20E67
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161981AC770;
	Thu, 20 Jun 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSbry0ec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC641AC229;
	Thu, 20 Jun 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886575; cv=none; b=YQqatdgdw5S+/j5cgKWSyjyUpH3icJpe60a3PGcOnGUgwqQ2fXvGEqfM4BH17BFV+S/AiHc1Qd5bRNhOr8ldHLpPD0yrd3B+2fO89Gy3u1bi9zrD3zTo8/XEbufxr48aMWCxbari3O69qGuuexMpK3wkpaT3AILI7gx2Y3R/JmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886575; c=relaxed/simple;
	bh=ibC0N7fxSpSAAhPJAwhOTFvUbcqn9SqOfy80AyMA53M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPOR2cOaSyhS0LZLrRUPXOls2TW9fAzvuRCYY1Z0CJc9kbuSmsBDzxFojHGqp/zNplSJydhFPb/Ot1RVJ+KtOY+Lv7jwct7KAiIIvF4QCHQuV9ZE21k7OpbKSCxMIItwP+69OOS/jpal5pX+Bl++2jcfF9ZsGDWXmmpcpWqxxVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSbry0ec; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f177b78dcso87593666b.1;
        Thu, 20 Jun 2024 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718886571; x=1719491371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JY+P5MQtBDn+YB4D/IW/nR3xzmRxBb9d5dLTB5FBko=;
        b=DSbry0eceB7XyuyO/cp4FCQOx+bWokdWOUXf1Qu+y37PM1WbW7tpZF5bCcjEjl638H
         ntTOwKIyzden/tr3/r8+ZNM3DLyNcm74b7XjRhNvY4a+VhBetf/RXKxesrfQarEDJi4l
         yqgK2tIQpve9FUcQt7Csrmv3/zvG9xCiG+VmxSY0c+ybRLeCP1HIGoJsgjoVe5De+dVr
         2PrUIhB+VbNJWci8hNuLoH4JCl4QURWhTRJDu9M7jmR7qY3vgj2wsTqvmzA+9ApVKENC
         1L6JQuKikfYP5uyKStwv4oihBPXJho2lzwEDQjZExMXy1IDvcs8VCYfl4WfQEeIz+fad
         +MrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886572; x=1719491372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JY+P5MQtBDn+YB4D/IW/nR3xzmRxBb9d5dLTB5FBko=;
        b=EDGZ8noUMmfsxFSYPFuXBsQEEpOm5AFcmdSCeTuZKL+GlGkEbAsx5cNvzPm+ll0Lcp
         RKsoNmj2Q+0R8F0v6UYWxTBw79rUnSYT8S1h3LtOHqSY215wEXv7MeQTgBRbpREt85iE
         bHm2lYf2wrRj7SvmnjIE8B5NAtXwzPft2evcVD8cZeJf7CESsT71gZ1hL4c2qDEs0aqn
         035Iwrm7s35X3WLH4AEWlzk1z4268z4xWV89nrkWWWFC7IsFzQZ94F+e6nqSX9HXr5Xx
         2iBORAbplMH77hh9pfQRsy1doLxCdU12uim2dRQ5K9HODBLnGqQeBuonOdFAN2IRMvlc
         bJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV03z2u489UEGmBOB8QZH/i8GsOzA5tngaqrZlv2cqMjJioIxxBr+sRu/uLUdZseoZWRm4dvBauUHvxs8NbuRfgPaojxmW3J1kSiiyl
X-Gm-Message-State: AOJu0YwevnGMNT2MpIXtn8uuEOYILDKqxWHrNUFWHQZbNWcMmjmQ7iIg
	Ua67DysAUNALkbgN2xeNQLjO2gpKX/hV5B9GWIG85fWjZOnnp0PA
X-Google-Smtp-Source: AGHT+IEbbn1htXoG3AL6WdhY6qa5YPWuh5xJr6b7zTna2jFp7Md/ENX++Wbq3F/XQFRZB4A99DmQgQ==
X-Received: by 2002:a17:907:cbc4:b0:a6f:ae08:2ce6 with SMTP id a640c23a62f3a-a6fae0830cemr244512766b.68.1718886571472;
        Thu, 20 Jun 2024 05:29:31 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5f8f6eb3sm711995566b.143.2024.06.20.05.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:29:30 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:29:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/12] net: dsa: Define max num of bridges in
 tag8021q implementation
Message-ID: <20240620122928.nbxshrh2jd5wnfis@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-10-paweldembicki@gmail.com>
 <20240619205220.965844-10-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-10-paweldembicki@gmail.com>
 <20240619205220.965844-10-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:15PM +0200, Pawel Dembicki wrote:
> Max number of bridges in tag8021q implementation is strictly limited
> by VBID size: 3 bits. But zero is reserved and only 7 values can be used.
> 
> This patch adds define which describe maximum possible value.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

