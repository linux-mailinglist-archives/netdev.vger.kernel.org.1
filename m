Return-Path: <netdev+bounces-109923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B6D92A486
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76031F216BC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1B13212E;
	Mon,  8 Jul 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I51kNMVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31225745;
	Mon,  8 Jul 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448624; cv=none; b=GYFXZvKe2nepfuddYcIZn1Zbf8d6njA04RJzKEPDrz3qjQzqh98/jdTs1o5C0xWTnE4GNkGT8QhQGXfsLbHcit8c7xM8Su+gdGN9hBsDZep2zK8bh48rqzvccKCucxcwxB3ApADlMUH+t8Xz5rn3xjvzciH4RAFqxEl/X0x1ziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448624; c=relaxed/simple;
	bh=WoimhNi7JKhezsHvSp77u+QORHXJ+pj3D3+mqenfrGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+xyHobz+bunjub9b/r+JzlnQzSrmM5kIiwGqqSqF99PPdTt3X5vtt8KoWsOOktvS4dcFhhn3qFJ5tyYHY7a6p1/pzqc+k6uYMT6W+1eGM/R1XZRrC8HSI5nskBnB9+SKCamxlxOMoBz4mGVDk+/iVmshBuPDMje16pIoCPSdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I51kNMVQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367990aaef3so2820649f8f.0;
        Mon, 08 Jul 2024 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720448621; x=1721053421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvRrlKfFJCB5YjJ5Q7f5Pm6VANP5Cl9Xp3i//ZhVz/E=;
        b=I51kNMVQ0mtEBKuepkDAAqD3Gf+ryR/ohUWWgQK9G9G6QFj/ITmeu6ZIHQmn9uizdv
         8U2+yxjRIJnIStXBKLeaDYzKhFINC5Wlg81A2zO8KT26VdXGYQ7E4xDcA6OE7b8nScAI
         NC5rLP4KWOnP6X5x72whmVDB0QAVcFIl70mUSYcm3Y3VxDDVk7bcWFW6Z3tPNaFyDwMn
         27kGVIl52ccXnB/w+SHT2j7O+Xp8RwRgbC1JiwKBssNzEt7ElNRI8XqkPr8J9FgRjwdR
         iJ3a2JLOZW0d7QxfbM7l7cqYZ3Zu3y7CxMczXJp/VPItDgdSvPGXRYmaZPKF4Lz8nADs
         G6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720448621; x=1721053421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvRrlKfFJCB5YjJ5Q7f5Pm6VANP5Cl9Xp3i//ZhVz/E=;
        b=K8kAQOcYrxyKz9fsT9xU+ZcrWDejHIkpxgPuPA4+hErOk+2WyCbMv6cV/a3WvR1WxB
         rZIjPRlSN2dlkhNKu0T/8GL+tnEeZKJwPZs1AKEc4f+4Yre33w2I0ARWmXfWJ7T8kb4z
         lmH1ht2TwOr65QLVpEyCrvK22kZnAur/CYpjpStIK/bIJQL15+zEPt+upAvpgcl4eZSx
         U47tQLG4KwF4OjsjTaznBuCxwkI/7cJRJMfnC7BfenhfkCqak15OuC2IkbtuEtAmtT0f
         aOB1PqZsXOq1yiYjMsHIgPovqfMVl7sziXgz9wHHYlJZ65mj2JUPJvqupY1aUMhRANci
         MK2A==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8ArUQ5WULm3NPS2OgTcLMGWroEzuR3Y0ndmzzU7LRb1+Rmg+2WETM5tv700Y9Nii/Nadb+c5E0r9rGSGwrj17fBsIJAR6XeBiETnd3zL92flMyzvCEVXUsyPWyIUl1svTCn+
X-Gm-Message-State: AOJu0Yy5xv2g2oEZSaUCkBNifG1L7722s3dm2MP9kpASp/1yDJHk5l7d
	DRwKHGBONOab+XvchY6E6SXGviQ2z8YM1nqaBG1ZTs48YDYHk8o3
X-Google-Smtp-Source: AGHT+IGqQvQa9RT5q/zADnoIwNKrgwZnym96VGcgnheAZp/c2wwKHsNmEbXWMys3McaliSqWTKubCg==
X-Received: by 2002:a05:6000:23c:b0:367:9088:fed4 with SMTP id ffacd0b85a97d-3679dd15bd3mr8338567f8f.6.1720448620714;
        Mon, 08 Jul 2024 07:23:40 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a8d74e0bsm8872491f8f.52.2024.07.08.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:23:40 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:23:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	"ericwouds@gmail.com" <ericwouds@gmail.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"luizluca@gmail.com" <luizluca@gmail.com>,
	"justinstitt@google.com" <justinstitt@google.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: net: dsa: Realtek switch drivers
Message-ID: <20240708142337.y5rwdxijvfnqftnh@skbuf>
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>

On Fri, Jun 14, 2024 at 01:49:35AM +0000, Chris Packham wrote:
> Hi All,
> 
> I'm starting to look at some L2/L3 switches with Realtek silicon. I see 
> in the upstream kernel there are dsa drivers for a couple of simple L2 
> switches. While openwrt has support for a lot of the more advanced 
> silicon. I'm just wondering if there is a particular reason no-one has 
> attempted to upstream support for these switches? If I were to start 
> grabbing drivers from openwrt and trying to get them landed would that 
> be a problem?
> 
> Thanks,
> Chris

What do you mean by the L3 switching functionality, exactly? Offloading
of inter-VLAN routing? Or routing offload in general?

