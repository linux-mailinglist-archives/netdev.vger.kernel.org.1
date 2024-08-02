Return-Path: <netdev+bounces-115432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8629465D4
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D36C283B53
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91286CDBA;
	Fri,  2 Aug 2024 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCXOVu6i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3911ABEB4;
	Fri,  2 Aug 2024 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722636961; cv=none; b=d8OiaN7A8zPOCc+AtKuRUxhTBFmep4Eljpuxajx6mvm4KBWegsyLtS6TXWrTTag9P6HdiZ2UmdVp93xZWULqzfOci+gxHlMg2lU6VdF/6jRHKLiYxF2jAE+6otskCsrwVBg8xLwlF+iVMchOxeXPAwNOQtzQffLgVd+VLjeaDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722636961; c=relaxed/simple;
	bh=oOQkFwrSqifLlaK/Dq7aPflih9oQVQfRRuVbOr9n1t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO7Lyw+WgVX8pgXYoV+DEmAqffT9HXBWHYLi/d78S+g2yctTblf3pfJXPcdIqSM7dC/jGpjXGfKdILMwvatzcPUNSAkBRNHRcoXa37Ug9TJb5Lm/WEKaYtmeGUq5trOHYGPvhi+pdhHgSkPVukLeqjQl5mu3i2DSLJ36FXL/OE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCXOVu6i; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so1248318a12.2;
        Fri, 02 Aug 2024 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722636958; x=1723241758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TL8XYyLfhY1l9YLSgZv5hMsnKvbRhmG/obcWXJUsKNg=;
        b=QCXOVu6idx4rnQhYpkINKx+i6Am9SG9lFETGHAcnMZSRju+oo+8Z+JI6AgYU8RrVBV
         UBswuSVkDaSh4Dlht5ou7grNMHCTLUKuRSKcv3kWCxBgZyo7+hpDy8GtLiTd7xpdz1uE
         0v3yjOpScoquYAavoW1Z/oN0QE6qURZIXq0Ns581fQlKdm/8Zj9Zhi+hUaOz02Y6XTQI
         Ml8QE2/boTG1EQ9Ki6AH7/QdWLcVqtxFda/65yX7JrLJNCe7QSjVg8rCjYJuiRltRFHq
         v1tMMH9kzo7SUFNwOSNBMjsIzODNbjihckZq3hOUJvjfzLJ1tXHgygBlHf3NJN7oSbN5
         fuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722636958; x=1723241758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TL8XYyLfhY1l9YLSgZv5hMsnKvbRhmG/obcWXJUsKNg=;
        b=EvNKYHNMceAXKxWt+gr/79VbHsJ8JS2s9yAXB7BFbmOw0mv1dMF1nNrUuW/UqSs5os
         +w35T9OPdiqH1y/kytIIgXza+3ty270R4T3VM+QHB8BRMS307cgeTotuyLCNx14tnQX3
         FvnLG5mRiF+CqWTKHdw5UGWdo7d9Se0Gv8p5NCmlrI129MjSrCWTFPvvGw7PO2v5vKfo
         S4UP8Ho28lgQ+M6kd2qj3k33vFSNyTk0HwcbhdpWqTO2SAJOITV7s8jxlb5AAcmKZ87R
         hEi7V7rSd9uIsGprdOgEthpVmSpVT5Fj7RYSurz1dRn/X99uK5jVaAy8u36BdTVK2mAS
         RCRA==
X-Forwarded-Encrypted: i=1; AJvYcCUzSVIMD/zn/z9bmm0hXTd/6GB8fAM09bjDg/DSgpnAZ6QzipIc6OSUNNyA8+UID2hvcRMA603UDhTubuh+2iwFHscX4IsQvqYlHpVK
X-Gm-Message-State: AOJu0YxjRO/IawVfWhM/bP09fXCp68JEZijy0DVobjvI7GRtVv2Sa7rX
	8DDrgCyYPmjAxUNubOl2LLqwFEw5Z3P2efmcVf1uIovdvRS63ssj
X-Google-Smtp-Source: AGHT+IFYYcjYsSi6Xttn2fD24qrfKf1gDkVXfRGTX1UGkzvuiJvE9M0hIhVuznyg3Xd3O+dpWrjIig==
X-Received: by 2002:a17:907:d92:b0:a72:6b08:ab27 with SMTP id a640c23a62f3a-a7dc4fe6dbcmr426282466b.36.1722636957953;
        Fri, 02 Aug 2024 15:15:57 -0700 (PDT)
Received: from skbuf ([188.25.135.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e77sm140822366b.169.2024.08.02.15.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 15:15:56 -0700 (PDT)
Date: Sat, 3 Aug 2024 01:15:54 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/6] net: dsa: vsc73xx: use defined values in phy
 operations
Message-ID: <20240802221554.x5z26rj4bkbry6xy@skbuf>
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-4-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802080403.739509-4-paweldembicki@gmail.com>

On Fri, Aug 02, 2024 at 10:04:00AM +0200, Pawel Dembicki wrote:
> This commit changes magic numbers in phy operations.
> Some shifted registers was replaced with bitfield macros.
> 
> No functional changes done.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Your patch helps. It makes it clearer that the hardware could be driven
by the drivers/net/mdio/mdio-mscc-miim.c driver. No?

Otherwise, I wonder if the triage you've done between bug fixes for
'net' and cleanup for 'net-next' is enough.

