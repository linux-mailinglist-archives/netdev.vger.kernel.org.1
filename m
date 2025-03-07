Return-Path: <netdev+bounces-172721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D5A55CDC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924A9188CDAF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464919259A;
	Fri,  7 Mar 2025 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB9xEDfL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A381714B4;
	Fri,  7 Mar 2025 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309959; cv=none; b=LhrxdztrcDj6YnFZNTnK0yQL7D4LHP4RdgzIR7np72WgARhnGPvwAAAv/ZBHK3ZUHz1I6fY0ea/B41a93Nuk5fEr+w2Dl+wP3ooPDJOTYN8if/O7Cj3a4cJKOoCuFFW3PWUmwY6sQCl3SCpcDvEw4kHK71SAPelOvo0LI/xNqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309959; c=relaxed/simple;
	bh=BrW1aIZtHKo41y17LJzfr4co8/xIvNXDluaIYdF+m9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUMrCkYes6Gn0qMbiy9UuI91/E745aKD96YDTtA8r5CLfX29rm9KkhZuvYGZKwMH/VvZsAecbGsG67rssT0A1EIaLJyPqb4jQ+x4BPtmz1rziTZnvkpGFVx/RbarDad0bEqPzNM/Xl6Rb1fcXtOHTpYRpaYBI5iOb3vm1Zc14EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BB9xEDfL; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0a159ded2so146387085a.0;
        Thu, 06 Mar 2025 17:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741309957; x=1741914757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoTiwV/penO5v76PscVulf4a30dmwygkJIwyLi0333I=;
        b=BB9xEDfLsz7IBfByN0/wI2YW/AxqXMQVZ2rSfeM1OHFLtkzChyrRv7KD0TKPpan9Xl
         IArsxfHIux4EuzWNYRtYEng+hibttlykhKHZlmEotF1k3imGpi3BmvUVD5KVP820YylS
         ey7JouVWaop1mfr4DAeJ7TGZ25/9ne2rjwhwRobF3fn0T6mvH4PzXD2RkORF+wpJOo3Z
         0Ni5jKTcEOn4DPRda0AHshYgGGwx851INLYSf4DZ1DvV2vVdV1AmAAH9YDY+2w+qETt3
         nyCNrVnezCBHDBaMqsz6jt92E6aMI1XXTRVWX9hiCkqjeOoLhWoUQjeTMDoz3hZ0NjJD
         DHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309957; x=1741914757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoTiwV/penO5v76PscVulf4a30dmwygkJIwyLi0333I=;
        b=eXUgIwGXh9yIZ7JhqvcOz//T7qgZf/I0FeaYKKqpNepv2NcoRxDJIrG4k8Hbkw1XZZ
         FtCAaje55hA9WrzghYtxSDhkWPIp+wQ5Ho9UG8A4pElUcyA9aVfO23LivX3hrEzbNmv1
         g5m3s/5ui/lH/i05p9W6dReYZOr7FZnmKFcN87VBLvJ5Rey/L9J2gncReepotUyKvI5M
         Yr1pbKsBI4Mw46h0//tv7HeXsi1hD8E3/L0KvUtN5jYZUkz0QarsPa3ztf+AV1l6Bu3F
         0/FkWxm01sTZLksV6EYzFX5JbOdnhdP0WKLZWoh7aZA8v25N+5RmydnAKk3s4COl/q5w
         gkYA==
X-Forwarded-Encrypted: i=1; AJvYcCUGeu5uBNrX6P0IuaH3/ehcoNViAnxJvNYKJs0vXozsazJ7T84OB3zx5HyzrdIOILp226MO4RRzI8G12Elk@vger.kernel.org, AJvYcCWyHwDS1UqiVtjKETTHGUUDsh8/TC7C4TJOh2JgLuRwrIWhqhiseNQFqIMepLUSRctclyd59TrcS7ij@vger.kernel.org, AJvYcCXAmZG0oPY6mzQdNxr4stbCfTQSxYbqhsOa+3hEKfehZNq//xKkyWB6IO4KBAeQiHOwJPWjDa1S@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+dLIKBfQxAfN609DbkNL7P2ZAUsmvXBxhoSBx18q47dFCfFf
	0/ud7iX3UbsBDJre7qk08UAvzQgy6diZf8j0bdJAz2+4lxlbFYXr
X-Gm-Gg: ASbGncvF/Qifn3DUdapD7vrcub1gaw+rZhAE0ZSwqtGi2mLhnQsF0/zMJBp6PMc2JZS
	QH+RLwq6jISYdTOMkqiaEVev5CKwvWFxST4MOgPVdeobZoanb/JJbPTYHWl2dPuFjg6JmTToJ43
	1eUfJ0Nrb5N+Y4nTPGE2WwIxfQolV8MKuafC98q7hrw/fiaOKglNJ4iXkD5MJJBCJFEHNTWtbtj
	Yf6Jn7USwvkJHv+zE8/zS1BJO82+YXP9KYwSrbsJfsRT6oCrbjfwr/go8e5OeA8rwhD7n+8UfgG
	Vqo3pfzViF63tftRyYc+
X-Google-Smtp-Source: AGHT+IFUBVq3F43PYm5XLqPTMM7AQh1lBI2X72APqLeXMYlSNYjEqY6EGkejol6T0++oyIAOjKb56g==
X-Received: by 2002:a05:620a:6607:b0:7c0:ae2e:630d with SMTP id af79cd13be357-7c4e168299dmr213772785a.16.1741309957325;
        Thu, 06 Mar 2025 17:12:37 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e54ffa6bsm163770985a.80.2025.03.06.17.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:35 -0800 (PST)
Date: Fri, 7 Mar 2025 09:12:33 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Romain Gantois <romain.gantois@bootlin.com>, 
	Hariprasad Kelam <hkelam@marvell.com>, Jisheng Zhang <jszhang@kernel.org>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
	Simon Horman <horms@kernel.org>, Furong Xu <0x1207@gmail.com>, 
	Lothar Rubusch <l.rubusch@gmail.com>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v6 0/4] riscv: sophgo: Add ethernet support for
 SG2044
Message-ID: <ptq4ujomkffgpizhikejfjjbjcg44vyzw4pwbs7kureqqndy6e@alxgdc3qkm7q>
References: <20250305063920.803601-1-inochiama@gmail.com>
 <20250306165931.7ffefe3a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306165931.7ffefe3a@kernel.org>

On Thu, Mar 06, 2025 at 04:59:31PM -0800, Jakub Kicinski wrote:
> On Wed,  5 Mar 2025 14:39:12 +0800 Inochi Amaoto wrote:
> > The ethernet controller of SG2044 is Synopsys DesignWare IP with
> > custom clock. Add glue layer for it.
> 
> Looks like we have a conflict on the binding, could you rebase
> against latest net-next/main and repost?
> -- 
> pw-bot: cr

Yeah, I see a auto merge when cherry-pick here. I will send a
new version for it.

Regards,
Inochi

