Return-Path: <netdev+bounces-138025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFA29AB8F2
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D0A1C23096
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318991CCEED;
	Tue, 22 Oct 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlZ64WGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630381CEAAB
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633363; cv=none; b=YeyyLEJlDPHoTvvz2LzkUIsw/KIW/aoazFDMzE620wS166xIRrENGGAD9YLYduzwa5Rp4vY7HaMt2cF50QJtrxF3QLUu1Wnt86kMAI2VXYlXXr++n+kFkQUny2nbcCf5hbC2HxYUSxtR0BQRb8Y9Bk51onatXI1LliyluN4lVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633363; c=relaxed/simple;
	bh=MT9tpPG2CccRkSzRIUUAWHfkSb0daMkpZu3gRy/28yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IESeB7FQqAZKDARc/mLRQdGvItIhaSCpMlg/7SDhxQe8hQxljJlGeKzxwaQh7Zpt001t+fB5t0mCI/yJpDWGYST7Wx3LvFOKCRBkmqR6nHoOXneKjas2eG+geJrVQoqO8uaST3MqTYExc9BmGz75SedUR71KgMdcwui6AR0hm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlZ64WGH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so6598138e87.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729633360; x=1730238160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhU9Han7paZZ8BGAQedzEn2YTKVTz4ZqVBWQpFZWFRk=;
        b=jlZ64WGH5y6d42OzmmjP851ogYA1ptTBZg6qBPrq280pJfmuKZwvjtMekMgqt5hzs9
         5W36hRt3h4h0XiOKw0gSiwFGzKI2N304umf8SfmP7cb1jh+5J02p5Kp7TpMs1T2DrCRu
         KuVP2xAv1XHLp6P1fESXgvS0k5Qturz9LOmETXZvrFI5+wtnRWEf+LcU6mPo3a/HIYV/
         Qe0N1SxX7fX6qyqMxweN0zZ/jP1iIjEScQBSWoKS0/Ge/p/UBzG5YypnacB9NmRUTGAD
         BToFdh3g+qTRy2KNtg1/dn34ZF/bxd4zGaGRyHT7agBpZlne9IzrrsHMWR+SXZlvMRo/
         IhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729633360; x=1730238160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhU9Han7paZZ8BGAQedzEn2YTKVTz4ZqVBWQpFZWFRk=;
        b=UZAMSfxJvbYuNf/jpvq+5mk+B6um9hHRAJ3sAHwIbYU8eNZX8eFIhFA7kVOylluPKb
         68QF1sgCi8VrVrEigKT5Upx9HTtXo/o2WxxTzV9Ub2ol7VXVHzOAvKq1SFkdHS+feChT
         dqLSQymVovOcxWRzwIZ1YWEEOfReju60af11/J6qCInXUbGYd3juEa41c7+9pfFQhCuC
         UE6YWzXlrIwjORbD7yhm4FAAAvn91tvgrUsBBXRYzaBxKa396IbLtx4tHi/twDo1g7LZ
         pREahW0XPBWVBruPdFxhZZFaXXeROKtVDpdf0cTtd024/IxbcJjQ1UGkrQzuVV5T7ZBB
         mhdw==
X-Forwarded-Encrypted: i=1; AJvYcCXCTcOo8plCrLSS8g26oghTyGMYkszCpCPYgZl8vZLufcIvPxk4IjtA+4jsUWYFfZF4QybzAIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/k/rct4fwzZftpyst76s3iLv2I+oFrmbDOZ45gEsK/F6fao8i
	Ey0Z4YK6ejcAZF7ceX/5KQj33JJgtuaieTSo/yqWnqq+9In3UbfO
X-Google-Smtp-Source: AGHT+IFYSB5qFHqkdFfAXrxKpQ9KmiyGPPhUbtHxFmyqNL3Vl1nEkBASgzGA3VJOgmiehgiQLptHKg==
X-Received: by 2002:a05:6512:1050:b0:539:fb49:c48e with SMTP id 2adb3069b0e04-53b1a30c01amr133233e87.11.1729633359244;
        Tue, 22 Oct 2024 14:42:39 -0700 (PDT)
Received: from mobilestation ([85.249.18.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e561dsm871380e87.22.2024.10.22.14.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:42:38 -0700 (PDT)
Date: Wed, 23 Oct 2024 00:42:34 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
Message-ID: <mixnwzyhuvu7tiablbrmukgtgjuzikldrmdh5rve4vpodpn44q@qqtt5dimcfvr>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
 <tnlp4m7antrcpbscpvdzpntyjudgs5mivw6cqvobyjph37u3la@okz5aoowa6bm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tnlp4m7antrcpbscpvdzpntyjudgs5mivw6cqvobyjph37u3la@okz5aoowa6bm>

On Mon, Oct 21, 2024 at 02:09:02PM GMT, Serge Semin wrote:
> Hi
> 
> On Thu, Oct 17, 2024 at 12:52:17PM GMT, Russell King (Oracle) wrote:
> > Hi,
> > 
> > I've found yet more potential for cleanups in the XPCS driver.
> > 
> > The first patch switches to using generic register definitions.
> > 
> > Next, there's an overly complex bit of code in xpcs_link_up_1000basex()
> > which can be simplified down to a simple if() statement.
> > 
> > Then, rearrange xpcs_link_up_1000basex() to separate out the warnings
> > from the functional bit.
> > 
> > Next, realising that the functional bit is just the helper function we
> > already have and are using in the SGMII version of this function,
> > switch over to that.
> > 
> > We can now see that xpcs_link_up_1000basex() and xpcs_link_up_sgmii()
> > are basically functionally identical except for the warnings, so merge
> > the two functions.
> > 
> > Next, xpcs_config_usxgmii() seems misnamed, so rename it to follow the
> > established pattern.
> > 
> > Lastly, "return foo();" where foo is a void function and the function
> > being returned from is also void is a weird programming pattern.
> > Replace this with something more conventional.
> > 
> > With these changes, we see yet another reduction in the amount of
> > code in this driver.
> 
> If you wish this to be tested before merging in, I'll be able to do
> that tomorrow or on Wednesday. In anyway I'll get back with the
> results after testing the series out.

As I promised, the series has been tested on the hardware with the
next setup:

DW XGMAC <-(XGMII)-> DW XPCS <-(10Gbase-R)-> Marvell 88x2222
<-(10gbase-R)->
SFP+ JT-DAC-SFP-05 SFP+
<-(10gbase-R)->
Marvell 88x2222 <-(10gbase-R)-> DW XPCS <-(XGMII)-> DW XGMAC

No problem has been spotted for both STMMAC and DW XPCS drivers:

Tested-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> -Serge(y)
> 
> > 
> >  drivers/net/pcs/pcs-xpcs.c | 134 ++++++++++++++++++++++-----------------------
> >  drivers/net/pcs/pcs-xpcs.h |  12 ----
> >  2 files changed, 65 insertions(+), 81 deletions(-)
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > 

