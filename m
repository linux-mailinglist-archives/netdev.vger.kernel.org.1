Return-Path: <netdev+bounces-219339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31961B4105D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C659F1899281
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5FB275B12;
	Tue,  2 Sep 2025 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvpSJBrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F3265632
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853505; cv=none; b=DVb13W89kovjz+AdJTPRP0XoNR8FrzPcO8VIAYVI9j6FVQX4ZoCc6zPwuysSAe569aCEGGoSPdblSh2TI1wZ7XIKKtfXe46wU2nGIVjexUz6WK5O+OrwpK2th0y00FlmLrMkUK6h5Yh6JzU+l0osFgpO25yBgKcFAY08R/FOC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853505; c=relaxed/simple;
	bh=bsmZ5PDPKgBAIOJ5HvCwriActAOC6xFxQ5D5Cn4b5ZI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdd85J1Ct58s19yevY2IqyMHqV/pUFZSJqdMieN1zYnFt8C2QYkbn4YeWlJ32mrRyYfYFEtalo3fD1ZJHXJBJbRqEhKfKmxFyx/ZMwNmi86r0p7zfxC2aszplKjwskOpHmZlM+WUDHgDl5xhw7qPG9R77pLYpOsD8NWEabJDUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvpSJBrl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b76a30584so1110745e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853502; x=1757458302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dor+sidR0RjX82QMLQwNVquvBdAo4Ay/OV7OD/TIaNQ=;
        b=AvpSJBrlvKrlTKaxMlP4ULd2tHAgIzHI+8+HnLS/PT3VuLE5DGk2D1Kl9xkgPzj33Q
         VaVnPNg6TObE6QL1meMwYJ3Ed9a2LCAbByK2P6WJ/nuSgxpNgtSfkLBCQsCFl9cxCQGn
         3lW0MQ0O7uFeP9kUxQwVMdSkrMmUFfC7SghGWkLXCw1PJttM4YjZIqScLlfUlrVs5z1V
         qXTzkghcC4Lz3oPdfeSThlpJTW55qF4SPD7n+n5mByonGgeGEM3hMJTfJD130uydAwOw
         aAjSD7okxrkyTh8ImZ5uNTjLwSnAWc2ONftz/VakdEYHip9cP2QvOgFaowFWTC37B9/N
         TJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853502; x=1757458302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dor+sidR0RjX82QMLQwNVquvBdAo4Ay/OV7OD/TIaNQ=;
        b=lV/okjorXAQdYe/gssbXkTDJkMNm+oPS5XsufpKmiTWr8DG2MYQvHbYvzbD1XQ5/wu
         ocnZhG306n37lg9rDXCNkgqI3x0Bf96b2dFgmrwNZESoKtu2zQtmkSvKWloiRui1+1HC
         TBWLh4Pt38kxTvO8Cnf36uKDGUBGoXSFc44McI3BwjwWDfiA+r8mqaLImbcKovzmirt+
         Vdla4MWSLYZ5Hq2MD3h3PNNpc42yGgfeqqujtWnP7QVNIJykqxyENsB1jrDuOs4wf+p5
         kUMHpf9qwA3ardsgxR4w2nWmC1+jdT8ibT81zmcnmHoDQRtPehktzQ88EugAQ3qha1/H
         xxzw==
X-Forwarded-Encrypted: i=1; AJvYcCUhWoXqt5918bw0j/yQQ+YYjUfXeMSF1T34wCHYeWwUXnyO6fzfneUBabQDEB12dohT3SA97uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGHOK+rPU4CxUkXnPHfsgTTksYA/YCe4Ef3MtgtralwJ7+CTR
	aDK/vyAVce3nlnzQEqbNH+lXt4BgSgHOITv+svTGNKLQ4BtaAQ5VpcXS
X-Gm-Gg: ASbGnctE0bUldZzHw8Kun7upNXO6yzaJ5wIkdb+dOSGkDP5JS59tIhl+dvGMtIltZfe
	VVEan3h4ZaPAQLXTOdsgTRDZNjt47ZEqgxJPDCtFFF/DdFCSMoia+U1zUiQUiKKtPb7hdIBe3kD
	cvYsNPbHt1ihooagBAJ9PBt+C0xCW6ZTtggrUBoaZadnAFC+REONCwG1uCUcBlKveqaJZOAfT3M
	zmNDQGBKZd1DMqu/YjkerIGvwZAxCCzEB8dMiS0JWgCX6LnOj94OEvF4ir7NBeCapt23cDbqyYB
	rQxgq4JF4ZrtNialHTaCHGN6PpVc7fP2adazzX1hdFyEy72YOZREx/F68gz/tf/JxOWDCkKdlrT
	SzfFFoYvmlcVF7xHjJHYC9V0=
X-Google-Smtp-Source: AGHT+IFjP1V+gVIX+eRUe7YF9xD72/E3KPdMwrp5eAxNufIEa3uaF75vzWqWlBb3MGdJ17U4mRpL9w==
X-Received: by 2002:adf:a1c8:0:b0:3d4:eac4:9d8a with SMTP id ffacd0b85a97d-3d4eac49fdamr2843462f8f.11.1756853502084;
        Tue, 02 Sep 2025 15:51:42 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:e6e0:f5a6:e762:89fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d1007c0dc8sm19530121f8f.53.2025.09.02.15.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:51:40 -0700 (PDT)
From: Vladimir Oltean <olteanv@gmail.com>
X-Google-Original-From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 3 Sep 2025 01:51:37 +0300
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathew McBride <matt@traverse.com.au>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 3/3] net: phylink: disable autoneg for interfaces
 that have no inband
Message-ID: <20250902225137.6h2ank6itrgeln6w@skbuf>
References: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
 <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
 <E1uslwx-00000001SPB-2kiM@rmk-PC.armlinux.org.uk>
 <E1uslwx-00000001SPB-2kiM@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uslwx-00000001SPB-2kiM@rmk-PC.armlinux.org.uk>
 <E1uslwx-00000001SPB-2kiM@rmk-PC.armlinux.org.uk>

On Sun, Aug 31, 2025 at 06:34:43PM +0100, Russell King (Oracle) wrote:
> Mathew reports that as a result of commit 6561f0e547be ("net: pcs:
> pcs-lynx: implement pcs_inband_caps() method"), 10G SFP modules no
> longer work with the Lynx PCS.
> 
> This problem is not specific to the Lynx PCS, but is caused by commit
> df874f9e52c3 ("net: phylink: add pcs_inband_caps() method") which added
> validation of the autoneg state to the optical SFP configuration path.
> 
> Fix this by handling interface modes that fundamentally have no
> inband negotiation more correctly - if we only have a single interface
> mode, clear the Autoneg support bit and the advertising mask. If the
> module can operate with several different interface modes, autoneg may
> be supported for other modes, so leave the support mask alone and just
> clear the Autoneg bit in the advertising mask.
> 
> This restores 10G optical module functionality with PCS that supply
> their inband support, and makes ethtool output look sane.
> 
> Reported-by: Mathew McBride <matt@traverse.com.au>
> Closes: https://lore.kernel.org/r/025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com
> Fixes: df874f9e52c3 ("net: phylink: add pcs_inband_caps() method")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

I had missed this discussion and was about to report the same problem as
Mathew again.

