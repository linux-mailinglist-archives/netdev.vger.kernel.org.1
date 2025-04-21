Return-Path: <netdev+bounces-184339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CCDA94C6A
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 08:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709547A539E
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC5257455;
	Mon, 21 Apr 2025 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy/aYSCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41610A3E;
	Mon, 21 Apr 2025 06:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745215890; cv=none; b=fi6RMe03UHC6h1LRysfsFuwtw1VVVuXbE9W6CUKFr6AJVXGx//2Ry3jo2gd8+H1cs2IfMz16joDGNAKOkf15iWl0ki1AfED1c9bDBXZq+CoNQxkoFTnPL+LyrFfwHDRiYg9JHlTqt6I9cEw3id/MlaLSjS8fkvkA8M8jm5A9PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745215890; c=relaxed/simple;
	bh=pfOBB66y5AUpbTiLaPwZa6ouIiwqIwDoq3RVh1UM0bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5vBst6wuN5AQY9yihqS8Uw53fhrViEuumBJVtekUSNY67KAQGSPLBPa7WxNw6Ms1AIjY10AuC+3tLg4JyyD++w40Dit8+xwa4GsHigkj2rktFG66Zg+q/uxxL54alYaCW81gfNvIXfdOIwO8MomiMnuAFFS8yl3fLGHeRgUvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy/aYSCj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301e05b90caso3593357a91.2;
        Sun, 20 Apr 2025 23:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745215888; x=1745820688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C69EyoD7e1EUPJxpKdh2LcmIsHKCmPyscuaz31gErLo=;
        b=Zy/aYSCj1dG0xsoHyWAsOVIo5WaXuWguK++UtlxY9yvBLDZrzlyQ+NmQBXtULmJ7BX
         ++03r2nhLjRhNoVtXdfkqrdZ2BULl+Gn0xit9MeH1pvREbtat+UGsPhlZoaG/1JVp3Jm
         0qkkndYeBEvnXDZu+Qf/KN1TrmyUFErFz8I7x8PJ/mZancvNdM8w08yo78GfC6a2XxRo
         btovysr4xNRJYqIVwXdin0ck15jdouJY5f4OBMBl5yJMLuaL/Y6f2pZI6f8l8ILsx0EH
         TG1ZA71H6n/Xk5zziiPxwp+Xo8C1o/b0+bhO41UnyFR3LDPlyuTf5nZniAdWOZOY2uZv
         Tvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745215888; x=1745820688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C69EyoD7e1EUPJxpKdh2LcmIsHKCmPyscuaz31gErLo=;
        b=TlXZW5FSDCwUBPQHUvXcL/pZbE9/oCk1LfzLJKbahknpiS9/iXKVKvRRBfK8VfGpHZ
         wqTA1lYWIZ4FW4SB/PFKdCHhbT6+HAqKTuYhTiPrFlYtRh4loeJPh2nxemzlMUOeE48F
         MUNR/ojUmb4G6rag3QxOrbMnoQvhCUE/y08rLkgCqmmEmIIhgPWxMK0EoPh5DBGRyj2S
         re4l8plxNQPv/WnfRT2HmsfwNDwWRxMmMQDCunvo3hzUeKqUAwvF/2U1zK5KzmBpFSwz
         +tRmKk0zYiU4hWXOwvNdzMhl+VtEudXRht01mLRNFAFjGw3pwxpBWvOQvHIhek9SaJZg
         PGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCXxbHHM3W9mkpXjvL6A0e7eM1vBU9B8/ZeuBuQ9RIO/+60Qbzz0f5HizMC6bHiTTZC4KaHYo1pjn+WcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWFF6qHrmnFogtGLtH4vhD7KDcapkF//2MbfC7JudNREmFke6
	iUXneIQfpz33l+3HLFVG08ECJvOiEVXhDcWs+fQEyK9kh2fGFxax
X-Gm-Gg: ASbGncs4mxjJ0KGvSg+4Wm4IPRW9CzakDA98ZXQh4bx33fY08jCnSLItfIKq8mOTa89
	FfNaVIGR9Aipduz2u7sRNrWrvIiKbkgWWcF/Z82trw/DdRBPVqe2Bq3Sd7sQcgaBStX6Jm/S013
	ZgH4cg0pl7cXK1uwEsG66Zpfw9w8+asvfHw8nMIoNGprOV6EqBHExMBbDWFY27iCSy5wlMxsVv0
	sWTTgZGy1Uj4a3DYup6ZR+XS1TBOBuYFfWucpZ8oe+AQSwazxpHA25RXWDco3n632D62+48jty8
	bwy2xmn8Jx7PKaS8B53IWdtppyviA7dc1hzKcIR7iQ7ULA==
X-Google-Smtp-Source: AGHT+IHm7qZcL8Gz7jo51scn41XPIDA07FMq8yyqyXub0ub+fXVBqDVmLhp+aPfsqSY2wk2c0xwsEA==
X-Received: by 2002:a17:90b:4b89:b0:2ff:6f88:b04a with SMTP id 98e67ed59e1d1-3087bb6922emr14213640a91.15.1745215888492;
        Sun, 20 Apr 2025 23:11:28 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4b80sm57762225ad.144.2025.04.20.23.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 23:11:27 -0700 (PDT)
Date: Mon, 21 Apr 2025 06:11:21 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <aAXhiW6n-ftxAr9M@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine>
 <Z_OcP36h_XOhAfjv@fedora>
 <Z_yl7tQne6YTcU6S@fedora>
 <4177946.1744766112@famine>
 <Z_8bfpQb_3fqYEcn@fedora>
 <155385.1744949793@famine>
 <aAXIZAkg4W71HQ6c@fedora>
 <360700.1745212224@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360700.1745212224@famine>

On Sun, Apr 20, 2025 at 10:10:24PM -0700, Jay Vosburgh wrote:
> >I'm not familiar with infiniband devices. Can we use eth_random_addr()
> >to set random addr for infiniband devices? And what about other device
> >type? Just return error directly?
> 
> 	Infiniband devices have fixed MAC addresses that cannot be
> changed.  Bonding permits IB devices only in active-backup mode, and
> will set fail_over_mac to active (fail_over_mac=follow is not permitted
> for IB).
> 
> 	I don't understand your questions about other device types or
> errors, could you elaborate?
> 

I mean what if other device type enslaves, other than ethernet or infiniband.
I'm not sure if we can set random mac address for these devices. Should we
ignore all none ethernet device or devices that don't support
ndo_set_mac_address?

Thanks
Hangbin

