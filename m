Return-Path: <netdev+bounces-240859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8943FC7B787
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E943A5644
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE12DA779;
	Fri, 21 Nov 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8IT3Noq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95526F29F
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752673; cv=none; b=tm/Jo/p8Jv5mz9qoTQpXWi6A1ADahjQsBhqVTkkjObAESuOpAOLiZeyrR0eW4O/v+6xOdqX1zwP54A0bht2TRITyS5czeUnNrrlTBEiFE0Ho5cp+ACOf/P0GOuvvCo4fJLhA4mavi4rjtp33lNHnO7Allv5e5cuaANAN96rPncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752673; c=relaxed/simple;
	bh=4sAVwsYY2YHBOEK48pCtdqBPT9jCA7HP8BBEHRinpiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiSpWD0HVX+aPhNQId68Y2IpnXdtBDUmJ6u250ZMcj8eHwMkig3AVPOOM/i8/Y/Sn0EozQN/bmFnMOjz9TmlqV/5F00QlUoc68PnDrsNO3Sq4emOhSMAHPjlKkrcO3LOeunu7BzhSnAZzw55AyBcIBqB6cD3cAFpXstFyeNYuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8IT3Noq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b2cff817aso225441f8f.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763752668; x=1764357468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8iwBwhNwuioSSQWn7LFK7t0rJ8Mh2P5vp1THsx3YdU=;
        b=j8IT3NoqDmMpUSg9gO3je6rP5DNc7uJQhf2dmXcQ04sgq43Z8nCTojxJrGcL+/hlM5
         rabuzh+0wXwEf5Ux/GvhN9eVKROxTeUBf7NrA/dKaiq9PhJCQM/+ge62muDrHXlw4Adf
         7SuPyGQ0YbYh3/TZNixM6jAGN3uJNiTTNgQGZgJ9XvuZSqfcSX6VBKGJXpjTrYlLwZK9
         0sxL20Yqdmepz4szhyKDpp/dGV58+tqVrpQCoq+IjQdpVEueg5dgU65BgSPuhoSYDbsJ
         I/48NXUZc6MqzAIITK+UFKqcUclSP26W7d37/D0yLx5vMrTIPHnAQrF8+iWZQCIulI89
         JrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763752668; x=1764357468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8iwBwhNwuioSSQWn7LFK7t0rJ8Mh2P5vp1THsx3YdU=;
        b=m+YnpmHsuu/4QldOQu939AQTMf+lZRMTLsfxbcgEVPm0/Q0TdYOySTZqnkkrtPvbD+
         +mBHG9+eMpnevTrNyzgV/aPxUHNPs6Z0VdbRLQhZJ/gRe8db/o3IkzbwByILid751QoE
         4rT5a8HIpPO1CjtGG+t7mMsR65YVW0Rb0ZbYBT74GYzJ+ueuv01ceytUgeU53AFHsejb
         VciwqLVJ0zNHWS1HPm5gLy0QnkJc/TaQcc1vzn+NhbJCok1XCL3eBaApGcPq2UJHEGzY
         gikzEDT3EFmkp2aO88o5yy6zAb0vajlKQ+WEARvgKsq+1E6I6H3ic7V5K2MFc0NShZEc
         oBdA==
X-Forwarded-Encrypted: i=1; AJvYcCV2sCxo9fLDQxyxleKfoqdGFc3xoY7HvBxM8cxZ/6CVz0ZVJSrGaG3RT8z57hiDTIbbgygxvxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5zTWLVXvlR7F8mib4DTfC7fnhFA2A3keFNLmNjBfSESuN1i6
	AVNolBeXhE6SwOPrjq8+LkYM8jRxrGqh/YpHviRr2FhwcNOpODlSmDB+
X-Gm-Gg: ASbGncslold4DF/GxusFDPy3fnIMeW4lxZJXLmmSR7XyEP0gjxyry/H0x+XWtStEFvb
	Jjw5Kx8BTqZa7ZC+Mw2wv2Ef5ULy5UIY/yuOee4ztKeelG/Wpmz4G0ZwRTbG2bL5z6f6ULZOWJC
	1JT3aOyAjsV8zSE84oWqmF0vkMPnMuMp1ObyWn1gidw71cLQow+smkfoJEHxgAb1W8NRihgCBxV
	mWIE31Od9R9HzR14aYdDgAKOQclRIkTci6XkrUjKeHmegwzUKj1CC+qKJJwF56wrXZ5PWSQCdfi
	tW8fOLNUDe9pUv3PWchG6kq3knAeodXV6epD6xpKUCwVf+Jri+SOicynDjhT+gFKIVfKdXU5n/r
	n7Pd4PP3+zppmInt5aNNNfXtXbvbthnFp2TsIy90EGZ8gFPkCwtn2aTg40Ysf2NEAPs+14rUHv5
	iYxUw=
X-Google-Smtp-Source: AGHT+IG+KrMg9GArGEp6Q0CjIrd17kh5O9dzvIO8tRrv+f2pfyIXfV6MHR1Wp42qXDKqxshdNqo9Gw==
X-Received: by 2002:a05:600c:4443:b0:45f:2c33:2731 with SMTP id 5b1f17b1804b1-477c0169f1emr21053475e9.2.1763752668337;
        Fri, 21 Nov 2025 11:17:48 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:b19f:2efa:e88a:a382])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477c0d85360sm48129405e9.15.2025.11.21.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:17:46 -0800 (PST)
Date: Fri, 21 Nov 2025 21:17:43 +0200
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
Subject: Re: [PATCH net-next 01/11] net: dsa: tag_rzn1_a5psw: Drop redundant
 ETH_P_DSA_A5PSW definition
Message-ID: <20251121191743.5xyrsey56gr7e5e3@skbuf>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121113553.2955854-2-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 21, 2025 at 11:35:27AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Remove the locally defined ETH_P_DSA_A5PSW protocol value from
> tag_rzn1_a5psw.c. The macro is already provided by <linux/if_ether.h>,
> which is included by this file, making the local definition redundant.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

