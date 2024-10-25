Return-Path: <netdev+bounces-139252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984FB9B1325
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 01:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6067A28367E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376ED20F3F6;
	Fri, 25 Oct 2024 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaEw19Yy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C451DACBB;
	Fri, 25 Oct 2024 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729898692; cv=none; b=SKCfvKgK7tt8n9syrecmOgyjb237pcbQCO4nXleLEqo8n49DyepnEtz8qyDzYDQMRw9YfCBQ7dlFFeLPoNkWh+SuyusH3Ko8mFNC0doOAbJy0zj5gvhMqmrM1x35tA8p/lU6Y59ZBNNcvn0guzcZp87Acz5pJNHvCzJZbHm+1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729898692; c=relaxed/simple;
	bh=65IMsR5VySxwtLmsMkEkJMmjIPCoMXefrAgbCGTGbsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr8rC5uxyv4lqoCjr9lEjH42pW+9bNnAg/RxDTm9xxWLnaXCxwQSfBo7Gtic5TV8GhBxRx3kTLe3Z5Q0P4pZLZKpPAOXr1MkLskuXvBafVvTFhnToaoAOgsZPunLr/TmNkFzbVjtJR8qrdH2X2RMPnyre5vQ14wwlL8kD9GjgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaEw19Yy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c9978a221so26025285ad.1;
        Fri, 25 Oct 2024 16:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729898690; x=1730503490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUOx9g9Hd29aDPaPnY4OSJGlF1FDFTub05boTsaeB/8=;
        b=DaEw19YyHoLlYNgp23/vfOSXGnXhNY23G17wZCECWECdzLjpmYjj/CdpaOfsCg3jAI
         IUmjm7620C8XCv8jK7+k2gyAWnX/QXR8rm/smwjh4UzJNUVoMlroaDoTpAsShLoTk89v
         XQxOmbbd8PITt68jSXktIi+sb1bkayFptlx8hYf+aTON48RDN8RvZqdOHlN68MrjVNxb
         vBZp85tKzcl0fcRMmZC4DN6cpXUU6vmAa2mbm0CVzA5WV2nCAv2D5AhsmLRfjKNDQgy9
         jbYrGxF2eQgJHOEIJ5jsOYmw6uDmlZvYfJB/d7cLyUlPrfZby/6lcLlM6/UqmNhrlbbZ
         wz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729898690; x=1730503490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUOx9g9Hd29aDPaPnY4OSJGlF1FDFTub05boTsaeB/8=;
        b=Vwqoq7ojZOGeHEWM7+tYM0bwg/Bd+HvBvMkAVqBAjjaikVYpSWHfYE38zgf1Sl6Fv8
         6zSytYdazVdzNVxt36tD4NYACxvmqaTQi8YUfa7+EQDMNvcklwKPs0Yu3GQMAkRcpOoo
         oLFsc1lKfJOC0lV75eMrOarWoK1B6xXIyvB1jVvsYLXb5s2SSLLGqCtgaTcB0/cGqaUA
         lzlRa+KwwbTMGSc+7u5YK2Z9i8KdEBPmAjZT7But2RJpoXtJJB33CcFKJCtEHAAkTHUQ
         fI0Ala/UUFhYANoNvhwb5Yw/p5SaZUQNHIVvCdA5Yv+akpqL8lYYCo2i2GqVGk05WmWz
         Scvg==
X-Forwarded-Encrypted: i=1; AJvYcCUrFQ82xvHMGdCT4af8IWC2Jnwd2XtiXrZLb86BY+kzBaEogA9lbrQRv2wZKSc4qMA34Sf6dSNgPFF3nEPI@vger.kernel.org, AJvYcCWISeTl66hK203qNiZFspWtBsN/YIp30jlhBUzLWAtTOhTzjLmfDvTlqSTa+4M4JsPxxCtLBVOx@vger.kernel.org, AJvYcCXdBrLCFlnxIRsqqLJq1ZTiS7aStKTII+IRuzvF0VbgP2s7ppP6qX3A3PMt4Zrh7bznG2AaWTkLhMlY@vger.kernel.org
X-Gm-Message-State: AOJu0YxAl1h2XvGoegxDqS3yAgX6sRn/8BvJwK7G9vcokPgL0HIS3RgA
	6zSiH/lBL/0Q4atTYIYMtNa3+zAQFq7fb1UKhMS7PiczeVDEa7Dn2ptSBQ==
X-Google-Smtp-Source: AGHT+IFWUkTXqhX/x2uKnWo19NThA/0At3qPgoz/DFagDTJ6IoWaouVLt4TY0P6cRpHC9jOKRPrbGQ==
X-Received: by 2002:a17:902:c94e:b0:20c:af07:a816 with SMTP id d9443c01a7336-210c6c0dcfcmr9231285ad.31.1729898689603;
        Fri, 25 Oct 2024 16:24:49 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d311sm14429325ad.81.2024.10.25.16.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 16:24:49 -0700 (PDT)
Date: Sat, 26 Oct 2024 07:24:27 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Simon Horman <horms@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/4] riscv: sophgo: Add ethernet support for SG2044
Message-ID: <vslmecginak75lrgudcoltoarvi7pcge7qw4rljyo6bctx7flc@xpasjaasdkas>
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025130817.GU1202098@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025130817.GU1202098@kernel.org>

On Fri, Oct 25, 2024 at 02:08:17PM +0100, Simon Horman wrote:
> On Fri, Oct 25, 2024 at 09:09:56AM +0800, Inochi Amaoto wrote:
> > The ethernet controller of SG2044 is Synopsys DesignWare IP with
> > custom clock. Add glue layer for it.
> > 
> > Since v2, these patch depends on that following patch that provides
> > helper function to compute rgmii clock:
> > https://lore.kernel.org/netdev/20241013-upstream_s32cc_gmac-v3-4-d84b5a67b930@oss.nxp.com/
> 
> For future reference: patchsets for Networking, which have
> not-yet-in-tree dependancies should be marked as an RFC.
> Our CI doesn't know how to handle these and we don't have
> a mechanism to re-run it once the dependencies are present:
> the patchset needs to be sent again.
> 
> Also, I'm assuming this patch-set is targeted at net-next.
> If so, that should be included in the subject like this:
> 
>   [PATCH net-next vX] ...
> 
> I would wait for review before posting any updated patchset.
> 
> Thanks!
> 

Thanks for your explanation. I apologize for missing these
rules. I will change it to the right title when sumbiting the
next patch.

Regards,
Inochi

