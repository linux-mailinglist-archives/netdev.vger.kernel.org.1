Return-Path: <netdev+bounces-184364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BD0A95019
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 13:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50A83A7329
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0126159E;
	Mon, 21 Apr 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtIRpNgN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E11E51E3;
	Mon, 21 Apr 2025 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234455; cv=none; b=YzX42pFfF6lqxqlzGsjeyJKJVVzJEHeHsetY6tOsGrGKP4olpsr3b8f78fWYzb5lWuJu+2fizeEs1TvYdc//zHywfW1oPJdGjJJFJ6YHmp+p9e23QpMwSnsCqJKqGYput7etyz5raFrgX2W+N2ywBMlfAlCNJkyOtn8QMgvUJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234455; c=relaxed/simple;
	bh=hdFkc5aw4MjLw2JIT+KUBIv7V/54VZs+5iIEIh3SJCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRFcjl6eGCQsz4g/sBx84Q352LcgAkbMgB7iaC8BGPZihsdxhYP+K2YhtVq4dXVqbPE73g+0U7UzWXJ3GrnpUgWMYaxT+X/GBZGFaf3sisf7e+Pzx+t6wv25VRCInjNS5WZDcQSeMS/K7YYbo0GZxuJOfaJ82FLnjhWrzIsmIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtIRpNgN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22622ddcc35so56944705ad.2;
        Mon, 21 Apr 2025 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745234453; x=1745839253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sGxrIsfttRS2s8260/XWCpTi1j2sM8XQx5x9IuQNs8g=;
        b=FtIRpNgN7frLmcIvlYPB0vc+8Kv0kTMOGT7DxGI4ha5aO1UTR9YRvrUQWgDBOQao+K
         6WjQ1k+KEI2NJOP4AkB9OHQs06UrGtuAywwtav3PBcGLuvLPFYtZ8eLKZlyZUgmAQ1UX
         sN4k33bA5FN641TY5tPiH1B+yf/ePTG35o5uFzajgIh5x9ymSeHleNL5OsG9RON25lsR
         SWFlVmUNMaut/tJNj9osrEYKAHwDU/EPu7Y/w26IebIJFjbK1ssE0KJsd7DuePvFPDK2
         0su7nN/CNWxLJJwLQSlhvkikZ93WtLv6712uTNuKL1108jfA83bY4b2txvAYFoFymKfW
         viyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745234453; x=1745839253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGxrIsfttRS2s8260/XWCpTi1j2sM8XQx5x9IuQNs8g=;
        b=tliJ76ux171rAS90+lBzb++qyjhRLOLrAD0lDkrf8IKrbQBEba7+eKbk8Lh8ujKqm5
         Jga9VklH8Cxkw8MPoxw4Xgh4f5aPS9nwo0br/cNNTfI5K1RhIzjIz6Icg/bzKtmaFbhU
         4hCOpv5xTusMrGBAIWFYxkAn8u9DnP1eZwKSCyTqag2VCwCqPu3heOrF8SM27/crO0vl
         W5xyjPqKO+H8ZN+1kAaKo/61w1a28wgPbtD+Jy/YsPcVUHCmD/aPxg94PSDSNGWTuxl0
         VOZDDDgBJKO78+qqLOQGZQFGXxkwAMk+gNSohrtusNlU6Pt/CXSYCEa7pI/mv/zxNWV3
         CMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjHLC7xsiqrB74+gdY2PViTJyEikSqxMbeE72XcGWN17HKMluuoPY4EpNwpYRaTZPyogQtPnbWhA2fWnQ=@vger.kernel.org, AJvYcCXi/mz0rc6Xjb+r3SSfc9Hy+0bcs2Qo5IrZDsbkcGQNM8kz3WI0R92c4CcVOhiNE2aOWjl9menc@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZMlPYWo3EIsXQE8fe+jUAvGvl/my6rE1W/GuzBdpq3kte5vT
	TwDasVuISe4+l5YICB4oci/MJD39yJWIfFmyqIBx9KV3sash7JKU5AoCXQ==
X-Gm-Gg: ASbGncvvclw4VJn0nkNdHCMx6+t0Z03Qq/WyDES/jFp95MQNJlV7z4piTLVUEqD55GS
	1UQLKeLZAYZwdx3XpZqzdbfn78Fj7CgySqAuKqvpKsd91x6WVd4F4zPIIEMOm2quGT5UO+VJA+M
	c4yYkreTqTWY0EzcjraeceiNfvHFg0iVEFCpaUUdhvBPPATdmkDtTGLFCHlNiC/WF8wSsD9pcAr
	hQ+yStxIMOqYcXvsmkJnnaqCQaUptKBe9prnahTbg4sO9ZLMgn79JyDwMLmLg5ghHL58H3n9qY/
	+FcpKK3tr0DJI4ABsBj46/O7H8eQZfSaRWs6/pRCTh7fftksASP9xsWP7RzT
X-Google-Smtp-Source: AGHT+IH0bHBGNQwbcDhrSj/hVB8zKY6lA8BeCc+OkGmX99YEIabvhymOzF0+/yS2fvNNoz/rQ/6sZQ==
X-Received: by 2002:a17:902:d4cd:b0:21f:35fd:1b6c with SMTP id d9443c01a7336-22c5364235fmr147132115ad.45.1745234453313;
        Mon, 21 Apr 2025 04:20:53 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdbad2sm63166355ad.226.2025.04.21.04.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 04:20:52 -0700 (PDT)
Date: Mon, 21 Apr 2025 04:20:50 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <aAYqEgZJP5gd8pPV@hoboy.vegasvil.org>
References: <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
 <20250409104858.2758e68e@kmaincent-XPS-13-7390>
 <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
 <20250409143820.51078d31@kmaincent-XPS-13-7390>
 <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
 <20250409180414.19e535e5@kmaincent-XPS-13-7390>
 <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
 <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
 <Z_dGE4ZwjTgLMTju@hoboy.vegasvil.org>
 <Z_d2xntJMPQYGQ6T@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_d2xntJMPQYGQ6T@shell.armlinux.org.uk>

On Thu, Apr 10, 2025 at 08:44:06AM +0100, Russell King (Oracle) wrote:
> What else is there to test PTP support that is better?

There is nothing else, as far as I know.  So I guess you are stuck
with ptp4l.

Sorry,
Richard

