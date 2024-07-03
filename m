Return-Path: <netdev+bounces-108938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB56E926452
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41F328B3F2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B943B17C21F;
	Wed,  3 Jul 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaLXY7RY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131017BB1F
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019281; cv=none; b=VfHubD44KyD2ebPbYYbqfmaO5KpX1VKADxA6YdQ3lzrZb4TiiiQfYiSZN6sejthjBYdhPYL4qeb3Vx9BoU2/+ihe2vJbD2PNnxeBBN3d6kBeor9D78Iq5KJWKiZBfrRBNMseB1EgQDlPMfXN8FRky5+7N6kOFG6Ql5jcq+z5xF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019281; c=relaxed/simple;
	bh=RMvuRB+N9+svjb/UAUxuXV81wHqlOOfmcILOij1TESw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrak6O/DnKym9+ZG1sh19RNLvmF47RxfNg0EWaktjei7UWr6VLPJwczyg9/hb3YSOUYzZ19wItUj9jwSSMZ2oTdbuU7+Rv+xAS8a8Hj98Hq27aSEQzvS2bUwiat/aKniC/zdLFBjraPF9GnxehEfxz7x/becHuNNDJv0UoJ1HHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaLXY7RY; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cf4ca8904so9016896e87.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720019278; x=1720624078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o77kjbwlD9Z3c6BS+RuGYrL8FzGeJxJRgdv2p8GCZbk=;
        b=eaLXY7RYFUtYqC7MBhqlZ4eVH0T3I3Q77g4kXVheeBidoDx6VjVdUou0FbvmbqV3nk
         /NGItrhImzdquGTl0V/57JserQE5wk4TNVlxX/mFKh3/s71orZ0nMIseuNNJjCE6Yw08
         0/9EgV3HhkBAOQwXe7Yyw2tWAO49PHuH6I1F6+aXtDHzywga9s5O/JX9bRG23Lr57twp
         tQePnRcSlqMs2hXhzpkJMmOlIwrrD8X7+xM+XCunQxOEAFYiKRlTNwuk+uzpGt953q+8
         fS6+vx+YBNcZ1L/9KLHehrUxSpG+qEMnYhtrJo9H6bBDcUDNG53N2I1raRtiuehfsOGD
         Cq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019278; x=1720624078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o77kjbwlD9Z3c6BS+RuGYrL8FzGeJxJRgdv2p8GCZbk=;
        b=XoSY/TTiM4R+ukW0gO3oE9kWWosixbLYVM1aFrgUR4rZrVREoqXVW9GxeSQYhE1vQo
         27TJyKbPp7bXe2z9rRs9YGrYuMgIjVnZVwxDWA5hVot+rW7vXd1vZ6NRtVzl10e6HONC
         f32CyE6C9qc3l83L51pyNU9O5hgoK7b6hkthYCTIdIbonf0qamKj+tPfem/EghwTI0cd
         P2yuABNFAJSeHhf+EMQqtMJMXUe/d3BQEvJwDSTvfQvd7IADlKFhbxq20cP8iNnNnRv5
         /FU9+WzkLU7kYGyr20jYfQImnw8xWjskyZqDaixD/jMgOT6s9X5RtJ8iBthcjQiPDXCV
         1X9A==
X-Forwarded-Encrypted: i=1; AJvYcCXLzcM5pHFhvNsR0baXfKhwBbraf97MU2KWEv5iQBfgrl0sMM55WViX2toMFc7uIVX8U9C8/mv+Dd7Q1LB6HWicmtPn79m6
X-Gm-Message-State: AOJu0YxmFlJL1AI5FsVhw61+HJpn18gQ6ixBSwFIb+O/g21mRK5WX/BF
	jeWeoNrfNEykVKIvA7a8V9RjM22q58YoWfLhkyiXDa9Dnj89D4Yb
X-Google-Smtp-Source: AGHT+IHdcMZi2lT1OmnivTCIy0RDYNDcq2ZLvwE9OMuR0+m5xHJb9jnuS0hZjfFM/bb+bVXr5gZvCQ==
X-Received: by 2002:a05:6512:224b:b0:52c:9725:b32b with SMTP id 2adb3069b0e04-52e8266df2dmr7006603e87.17.1720019277758;
        Wed, 03 Jul 2024 08:07:57 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1030bsm2188120e87.99.2024.07.03.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:07:57 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:07:54 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Halaney <ahalaney@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac4: fix PCS duplex mode decode
Message-ID: <xgqybykasoilqq2dufnffnlrqhph2w2tb7f3s4lnmh3urbx4jd@2e7nl2qkxtrb>
References: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>
 <c26867af-6f8c-412a-bdd4-5ac9cc6a721c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26867af-6f8c-412a-bdd4-5ac9cc6a721c@lunn.ch>

On Wed, Jul 03, 2024 at 04:06:54PM +0200, Andrew Lunn wrote:
> On Wed, Jul 03, 2024 at 01:24:40PM +0100, Russell King (Oracle) wrote:
> > dwmac4 was decoding the duplex mode from the GMAC_PHYIF_CONTROL_STATUS
> > register incorrectly, using GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1)
> > rather than GMAC_PHYIF_CTRLSTATUS_LNKMOD (bit 16). Fix this.
> 
> This appears to be the only use of
> GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK. Maybe it should be removed after
> this change?

There is a PCS-refactoring work initiated by Russell, which besides of
other things may eventually imply dropping this macro:
https://lore.kernel.org/netdev/20240624132802.14238-6-fancer.lancer@gmail.com/
So unless it is strongly required I guess there is no much need in
respinning this patch or implementing additional one for now.

-Serge(y)

> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew

