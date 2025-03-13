Return-Path: <netdev+bounces-174773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5876A6048A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331203BB73F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698371F866A;
	Thu, 13 Mar 2025 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBYJJp8C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4811F790F;
	Thu, 13 Mar 2025 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905610; cv=none; b=lec+axKACEiFJL0xbR6as9Z4qdaScitiQsGlC0KvyVyrqJPinGZFoDGNdESHIQpmMv3Ykn41NA2x+ftZDFD7bAn6E//jyXYmkhPxpo0RXVi08WmxrUm3IloRgVUL9Q8vHtQmGJW2EZtEnzH3EPmrHwN1pr07pcpW1kY3PSIiTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905610; c=relaxed/simple;
	bh=bS4CPM4fAMakSodjoDheMW0OvhLE7InEn2vXq7j2aQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqQHg3qXhclec9IofIyQJjeMIAyHwNOXP2r0LshCY2KpvmFTRld4zZT+lB9nyvxwunh5wc1assNubZVHfO0TI7Cfs82pZ5cPrWYm8jwr+ZTieJbQcvVy84s8NsAz6zs9IvvzpkSTOYgxSfTQ+92L1IXC522kOX1G0xy4qfV964M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBYJJp8C; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c554d7dc2aso227631285a.3;
        Thu, 13 Mar 2025 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741905607; x=1742510407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MrpFY5DFdMA1Rw40JG71PEizmZhwbVE0ADaSH1zQRU=;
        b=XBYJJp8CVmaonQZAl6f9CxUnQWi2DTUvNXTiXfMf483jRkxUuTyHEiJEDmmZ6jdOuU
         vvcOmaXuPGjCtw6B9Zbb8JGcwyENsmbOX/34xc6GHHSfcIAyS6e7PHH4D2BqNyy1CTue
         O8XVl0fvYrRltvZDnkjZ8maDkNjB5b3lMfwCz1Yn/Y5XOAwosAuyvz7oOrgCJb435l6e
         5xboCG4ME+7zEzgHwj0wPkY+0OIBs5njw0j0bLEkgFCvhPqaqsatyENtdMR534qDZEct
         UufbFJ+cXKJOSCkcmL7gPog/pFuoXjTduKNt5ImMM/onjAL2LeKszHdiw5OchZ51Dcsx
         Qnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741905607; x=1742510407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MrpFY5DFdMA1Rw40JG71PEizmZhwbVE0ADaSH1zQRU=;
        b=Aq8YTehjWEXZ8b7FzFgJfIVPzea1zgpJB0lqIH4w8XxpH313vvYuFyDGAxkh5Iclhv
         WKcbnK9xW39kZLIJkZcXQCCBl9IVPSlQk0g7frYEXp8JvCHY9I3fsz2HY630PL6fSz0s
         VcUQC2/tV2yEnI9y7k2oMkEUHDeQmcdyZHgnohR30NQTc/BKewV6eGGsyfDkGfqKaYdb
         4dA3jFm7DxXGC2G9YyAT+qsFFv+p1sYNauAGd+PkOrmCbmOxcqG7G+HxWRnWUJQqxVo/
         f0T+quAud/CvY8DnuspmsJAjNu5S9MR9zDre9aU14NF9kxJ5g7k69hgJ5wUpDzzTx3Yo
         lxZg==
X-Forwarded-Encrypted: i=1; AJvYcCVmJGcIm1zLy8C3T55an6as1AQYYcSqea917wsnx0K0i4GBO5C02nWpC6cKAGQvHMHbbRShRDWQ@vger.kernel.org, AJvYcCX8QVyjihjwkqye+O8GpbLgLvzJommOUzOomUenICLWHyaJGzwZTNvCGiYx6XdqsYyyOIpwox7nj4Ch@vger.kernel.org, AJvYcCXaGl9qB9LqYMBaI+lhQgMyIZjG4mTgQb2ITXwXBKadkbWOXlkpITDaTPxUqINoApbEsm+1dIyLGf8yxjjK@vger.kernel.org
X-Gm-Message-State: AOJu0YyaLVBJu8K9mOBCgzu/lxANSu5FebY4Sw5geEex+LRhqve5TX6I
	/lFF8Uz38VnM+SoC+AQt5fI2qEac/AeSu6zGRhf9N5ujf4JLWcng
X-Gm-Gg: ASbGncuNqhTWxCtS7fsROtAsPVZdBRIfJLjOJzBQeb7rAfao8N9ZpsOYfZsSdDMgz+X
	I7GArzHWJakelaZeqHvYwyNgybaSm5qsH7jXPnJDGvb+Q9kSswgoB2i3Cw1qf//R8sDgSkatiQY
	zSpQ1/o4V6HG2R9vpyqN9IeJbSmfKEwrJnym0ttrhn6MxkGRvuva+X9m6Ae77a0Bx9gOxoTMZqM
	M4I4c/Ob/yUPzAnuBsarJ+zD/TacSJoGGLQ5jZZb5QT+6nskn5WD2F45azfCmro3c0yhuVPbm8o
	+pS26DSElvJCgjNYFfbZ
X-Google-Smtp-Source: AGHT+IFRhA2NQTGrZIFmt7j5wHuvu1fLNd//sE55p9iAYnjLfff55St6JmFducqntDUIBkITMbvCLw==
X-Received: by 2002:a05:620a:2727:b0:7c5:4de8:bf65 with SMTP id af79cd13be357-7c57c8f8fadmr13878585a.36.1741905607080;
        Thu, 13 Mar 2025 15:40:07 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d6fb8fsm154595985a.72.2025.03.13.15.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 15:40:06 -0700 (PDT)
Date: Fri, 14 Mar 2025 06:39:56 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 2/2] clk: sophgo: Add clock controller support for
 SG2044 SoC
Message-ID: <3pgh622n6mnh63ih2olzmmcmqgxewpaumrqh6eeq3w6uobuiwy@cm7jxdkmle5u>
References: <20250226232320.93791-1-inochiama@gmail.com>
 <20250226232320.93791-3-inochiama@gmail.com>
 <aab786e8c168a6cb22886e28c5805e7d.sboyd@kernel.org>
 <ih7hu6nyn3n4bntwljzo4suby5klxxj4vs76e57qmw65vujctw@khgo3qbgllio>
 <be795c50ef61765784426b4b0fafd17b.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be795c50ef61765784426b4b0fafd17b.sboyd@kernel.org>

On Thu, Mar 13, 2025 at 12:38:33PM -0700, Stephen Boyd wrote:
> Quoting Inochi Amaoto (2025-03-11 18:01:54)
> > On Tue, Mar 11, 2025 at 12:23:35PM -0700, Stephen Boyd wrote:
> > > Quoting Inochi Amaoto (2025-02-26 15:23:19)
> > > > diff --git a/drivers/clk/sophgo/clk-sg2044.c b/drivers/clk/sophgo/clk-sg2044.c
> > > > new file mode 100644
> > > > index 000000000000..b4c15746de77
> > > > --- /dev/null
> > > > @@ -0,0 +1,2271 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Sophgo SG2042 clock controller Driver
> [...]
> > > > +};
> > > > +
> > > > +static struct sg2044_clk_common *sg2044_gate_commons[] = {
> > > 
> > > Can these arrays be const?
> > > 
> > 
> > It can not be, we need a non const clk_hw to register. It is 
> > defined in this structure. Although these array can be set as
> > "struct sg2044_clk_common * const", but I think this is kind
> > of meaningless.
> 
> Can't the array of pointers can be const so that it lives in RO memory?

Yeah, it can. I forgot this can also be set as RO. It is OK for me
to fix that.

Regards,
Inochi

