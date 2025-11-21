Return-Path: <netdev+bounces-240880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D107C7BB69
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 22:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3987435D2CE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9B9306B21;
	Fri, 21 Nov 2025 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvus6StE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550642248B9
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763759112; cv=none; b=soiCFChERR+rHCvbiKHTW8cZrrefmql3ueJpz/flCHeUzoNMJ3kNggLntaZoj3rQm/zyqzNfqX1bZQ4gfQPq24p5y5Rvm/92l9d3xok7tZMaBgrFAkWyN316oUj6FmUJK+OUgew24SgdyJ7ml04aAsOmVKZIMJ88wSL7XBXve4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763759112; c=relaxed/simple;
	bh=ikocOw5rSrWvxBWEQdFtppjYN11mom4HHhas6/T9J2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdDtV8arC0sgd4Yddq30dkJIw9aiDWLvLcDzSPiIbwzWC3T5srKZQ9+lnS18iwmIoxaIshXfOAR4LEU4peZ54CetEpbAPfFsaEp84ODlKC5j3d5C6vCMESk34K3Kucnxw0yPZjCilijQ1qm7rYTBM1wOyGh0vU68+kzZJD+76u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvus6StE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b2de74838so206869f8f.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763759108; x=1764363908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JM0Mreiq32b+LPITrWPP1aT6vTsdSPOWG4QtqrPmPSQ=;
        b=Kvus6StEPYOK5Nn9yT9sJpo1VRUIp3KQK79bcMq9Yh55IrwEPQoOoe8iwDeryiWUXl
         Dr29xuT4qBbPvsKO/1v/c2z1nv9UEkmCSS0k0pVNhcxpB2PSzaWQ/D1DdBTD1Bja7hzM
         LZ6O+hfbpOPovUN7n/Btv3wjDQYtEpC2IRDB9+6Kkt9YLOuhJzDNYDMbKmyLEh5RMwWi
         s/6ug5j6nNJTuZxtvLzwCk8hlH5XI5FSLJrVkUau+2WFbOvrNoOnNd4WnrE6LQ6iTJd3
         HbcW2EEKOzFSvYY0wqpu1t1rDqU/h/ZWq7fDTEfC+vUiobsM5396nB9jNehUS7s7ecQt
         hfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763759108; x=1764363908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM0Mreiq32b+LPITrWPP1aT6vTsdSPOWG4QtqrPmPSQ=;
        b=nyUTOhFpqymL/dg1WQHSvvCPjX0RLGiTzedaJ1HQNk+ZW8yuWDk5dWDC0bUD6EMAUj
         vJrP4uKcniiHOiPZZlo/mT2W0prWLb+h5cPH+EEMhpop49K63kpVF6H2Dt1AGuDrhu5L
         hWdVRj514JDiZ7UTs0bqafCLHNublB8maTZuV9CTQrB59OnTvAh7H2IofQf04i7CRUMY
         rQWMI7a4Elf/q3BezHQK+KG49wAh8AZzICpW5JWwPuv8NQEFu0acwo6X+gSgNTgpwCQF
         YNrLpTOg9v9lx6NN1L8JfeKWPlcOq8Ca4nYhchCxYNy44VI9w4t2wxhxmFL4itV55uCt
         +RVw==
X-Forwarded-Encrypted: i=1; AJvYcCXnwTkLF1sLSKvC49MTQnWwj0dM0aeAxArZ0x+NLAygz00j8qXFrw6ZHZqdCyLrpCqrVoW/Kug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj50pebvt10G9csG0NLPT0eeOIx3FzXoZXww/XyRlbwQ0lzn+L
	4mTzOQS15NbvhtOJ9wT7efc6DZUmrlRBd/RFcGqbKpW3VZEkKnaIKUAl
X-Gm-Gg: ASbGncsTYT4x3v6xoyszSCzXXYYEIBpZaatVOjOauDjirsUs4RdEBWpJgx1J5YUubr6
	5eWDlIAzDiOGteDzPP37SaqQpXsHVaqFDn4TSL0j2uOPL37LxKUsSPPaGN6pigJRptX+u8Ky0Aa
	gLLD/26xbOLRxdySGHHE6ebWXjMdXJFBRVh+Xy/xri4FxnkVocIxZANduoW+X4HwCCzzm++LgO/
	zicql+VTLn9F11Lq/JSkJAgSSwM1wKAmXFxmWgfdE/co8EdOcvyMOLSqEwA366rkuw25Pkps32E
	4aMAlHMSdn7ivsYv0cPSMs/L1qJYeEg+hm9PFOn7E5+c/fYYwYj0J25PxrH6qkuB5htm0O6UsZH
	cDEGk7gO93RKMK5KbqP4+l3vrcnK4A7J27tnquFHHIlxhhtG9MD/8gpBAOLJlmdqqFtaDf/t0d9
	9lZlo=
X-Google-Smtp-Source: AGHT+IFS3P2oYUjpO8Y/WJHNkwI++Z16Q0FgFLqrouu1RpHsouIxJV7ZSaPDknXEWFmL4yz0PFSImg==
X-Received: by 2002:a05:6000:4382:b0:429:c711:22b5 with SMTP id ffacd0b85a97d-42cc3eda99cmr1814532f8f.1.1763759108146;
        Fri, 21 Nov 2025 13:05:08 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:b19f:2efa:e88a:a382])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f49a7bsm12836295f8f.19.2025.11.21.13.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 13:05:07 -0800 (PST)
Date: Fri, 21 Nov 2025 23:05:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH net-next 09/11] net: dsa: rzn1-a5psw: Add support for
 management port frame length adjustment
Message-ID: <20251121210504.ljeejnltaawahqtv@skbuf>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121113553.2955854-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-10-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 21, 2025 at 11:35:35AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Extend the RZN1 A5PSW driver to support SoC-specific adjustments to the
> management (CPU) port frame length. Some SoCs, such as the RZ/T2H and
> RZ/N2H, require additional headroom on the management port to account
> for a special management tag added to frames. Without this adjustment,
> frames may be incorrectly detected as oversized and subsequently
> discarded.
> 
> Introduce a new field, `management_port_frame_len_adj`, in
> `struct a5psw_of_data` to represent this adjustment, and apply it in
> `a5psw_port_change_mtu()` when configuring the frame length for the
> CPU port.
> 
> This change prepares the driver for use on RZ/T2H and RZ/N2H SoCs.

In the next change you set this to 40. What's the reason behind such a
high value (need to set the management port A5PSW_FRM_LENGTH value to
1574 bytes to pass L2 payload of 1500 bytes)? It sounds like this needs
to be called out more clearly for what it is - a hardware bug.

