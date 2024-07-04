Return-Path: <netdev+bounces-109296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1E927C50
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3370D1F240D6
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D057344D;
	Thu,  4 Jul 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QilgLYzc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F25481DD;
	Thu,  4 Jul 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114393; cv=none; b=i157TK9rz5PRF28P38JYtlPFYqfKkZ/7FB66dMAolqqqFsg5J5X7t5YKd0tN34fUhaiJtUdEaMrBid8ASDdGyhauTSDsmf8T8zxrwwLfwgJJvTEG3nNyFZOwHAHJdlBm0v2Mr88hW7MOY+yLuR5jfhrho1Womv//dM8ouTbPs1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114393; c=relaxed/simple;
	bh=uOjGimoUuqmHkIRe8mqL1ywdQq3G4j3DbYhME/q+F/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m59zfYKueadKzCnFy47MaLjNTEUwI4GfJ2S6HFADwvLq1lCdp8JRJbNPJuyIt020I1p+6KQ/LtR+wHCbjVqVNuwIdH4rQ1+UbML4rOu7KaZrBN7xEERX5nFwbGfk27zr3EH3M46gDJoe1Qxs1SLyS2PY5n+NkGyxuLvUbxB3P4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QilgLYzc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso8635281fa.2;
        Thu, 04 Jul 2024 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114390; x=1720719190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVYRaNZH3y9ziR5T7ty/SWXI2sYNIiKPBk3pwNTSSn4=;
        b=QilgLYzc/mbfq1FNi9TZqNyzLOMe0rf/iW2xtCejIMofljOWt96G8AMibV3ex42KIH
         5s2N4G+1k7teE8hcyR0t1UtHIoSMMERrddDAXZWcXcvtMnryPEUY3WlHH3oqWOLD/EyZ
         j8sCIM4MPWbMBukmEx4jdtt4dZIvQFbk/uSLioYxOo9csMrdCmeV+cZO8bmpgBf7ogQY
         HJitQ97z3EN1AgH+Bych9Q40ZdBjIMhNV3CElxa2pYxLBoMq7wA0Q7n+XtRIoWR/ch49
         fE1HUyfVdfOjDSaiO5Szx0IrupmNNYW9XhGXB1kGxFLb0HtoyZhS7lXgie4mFWRgnjtP
         bhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114390; x=1720719190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVYRaNZH3y9ziR5T7ty/SWXI2sYNIiKPBk3pwNTSSn4=;
        b=S19KaPvGtnRc4iD9pb41b52oaNl2ieGrqo0tm7a87aV5ORCczzH/lWve1prsVhAnu/
         AfZxJxmAAJvpUNTHiXqJliFu4h36JZEU4Juy00I5X2WTKKO67z9xmpqegFK4FewuI1ti
         09yOEwmafhHGjIto/Pq0d0q3M9A5N47GTppbFO+HthZ29rPeymbRkP/1Fp2RQp2+0SDx
         HvSRIBRHhXWESGnyenYrjkKVHSOFmsT70CWKLez9UR6YOPInbeXdjtgIbbgNUP454NKE
         fI4FWuHL5iF2YfmBLDHAR01VnzNAQSIe65ww3V+QkqWQZLtr6f8GGgTWsEgO5B6WzYmk
         brEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTB1XSIPTyOcghgwn3BxM/RRpglXMIwLCGpphMZGx6zbI8RwDuEblBeqFgwAELeubRveHpBEcaZE/uzUKm0CXVnoeK1rqjy/h2EnnIDL+VB3VwVt7wTcbiuMOwgpZafQIZguPG
X-Gm-Message-State: AOJu0YzSsF3xt9iqpWXmob9r05lodk+VHZbDmZOOK3OYtox3vhPljYh1
	uFQSDfvQUxY2lqSfBOCjKUfLA7nQ+xe8HC2gDRouEaPYKSe8/mJVt7roMg==
X-Google-Smtp-Source: AGHT+IE6j35srePOnKjG8C7MRp1ASp1+rhCl8ONqWVeI3a/7229HAFHKCSb9MIAr+SNjY/DuaZL0IQ==
X-Received: by 2002:a2e:900b:0:b0:2ee:86c1:f743 with SMTP id 38308e7fff4ca-2ee8ed8cd97mr16136701fa.15.1720114390163;
        Thu, 04 Jul 2024 10:33:10 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1668sm31765315e9.1.2024.07.04.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:33:09 -0700 (PDT)
Date: Thu, 4 Jul 2024 20:33:07 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] net: dsa: qca8k: constify struct regmap_config
Message-ID: <20240704173307.wz4wfrfv6rshyqe6@skbuf>
References: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
 <20240703-net-const-regmap-v1-1-ff4aeceda02c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-net-const-regmap-v1-1-ff4aeceda02c@gmail.com>

On Wed, Jul 03, 2024 at 11:46:33PM +0200, Javier Carrasco wrote:
> `qca8k_regmap_config` is not modified and can be declared as const to
> move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

