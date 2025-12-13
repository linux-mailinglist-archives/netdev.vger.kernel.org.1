Return-Path: <netdev+bounces-244580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE937CBA34E
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 03:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C324830E8963
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 02:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A06280018;
	Sat, 13 Dec 2025 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmiqz8yK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EF6274FE9
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765592916; cv=none; b=b828AqqLSAxRiVF0pHl4qzHUGxfY/uevTmLU59jsj/SDykzvJ5rjDh/LgqqRkJvENKE+6VEIPMhFOMttZ9DM6cXVBczCKzulmRPA9ArVxCW9WuDNFIzITJrhDWgHYPi9tUnrxFOpZDcOocMO6Y5shTaH3ADQc6KrU07i5CWONuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765592916; c=relaxed/simple;
	bh=0x1vMcMShduTmxRWyvBiBRlMvGc3ZDzpLSl3K9pvsVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBYVjvzi/D1/WScFT2sPsvJIa6QGG0hHQBHSuIRXHdX97Sr3aPkonaJUzCRZB9DUHj/VLxZXuE845K4tEsvDtEHDA9pqtgwzmPdzoaV7fymD8TtZFE6d6NhcQi846W9Jgns8AfeIMdS45sTma2TbxdBb8XhnVrCGL/wbAp56dXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmiqz8yK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78a835353e4so19848287b3.2
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 18:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765592912; x=1766197712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8tj7zFmiGIgl+/XLeshTiYqJVDhHxNQCvlvR2nqqLk=;
        b=fmiqz8yKiqzwLZquhd12/HuAp0bAsycTk1IlQwq43jp1H+NwQRey3u+yUmkcuZ+GpQ
         Xjse24767hWTx2b4gn8vZknuwop1ABNj2Hxxv+gESdZlhSdErhrsZmJAGkUJTwBPMQrU
         Gkyiib+2WqAOMVAQ3Ox6DZcdiw1w+HayrQ8bl2Uw4cXpnt8A3jeq9WD/Afr9zhD938jx
         dgOHo0XM/qL974u73KDD+UZKwdejRXMnCn0IdMEsbS9ZwhpWq/LWUT9vBDG42ReDlwAb
         vPA8YPgH7nBoSXaQescWuyeUbx+CISriWu/bauQ8jjQxySlmmjAyF9+xtR+rcPHMj6zH
         3r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765592912; x=1766197712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8tj7zFmiGIgl+/XLeshTiYqJVDhHxNQCvlvR2nqqLk=;
        b=UrtdeIt7OkasNMd0g6dKiXrmxnM9hedns/aXC5ZBZybTyRFPpqk2dQdsbwwSN++I/9
         h3dOY5oUFOqPKRhXfXsuMR5xXaVnaOiy/d20ow53ewlxDkCAjbllcGFULod7ojzBEB12
         9vzUufmatbRLZFQ+TZ2h7X3aTadL62+XlH99bmjIvkdlFsdVuXr6oQOzLubrYPDJV9mo
         hYU6eFD4eKPgn78XpkMRbtGaX5c+DbLjcCnfF1QYdzbOkGGf/GA0vobGdp20E9G98Kny
         BHElvCtWNx6lUt6UV6zuFNK4zXDoNeZtWCAbaHWRhiZcBvMsGlLzHz243+neTntDiwiC
         ub5w==
X-Forwarded-Encrypted: i=1; AJvYcCUK3Q9v4cFQLeKsFFqlD9HTwP2w6AiFvSESbAfCGAGEZnQlxzDd77nCB30bzgbCBVJhhNMABmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8T6i+DjMaYUL1QKwkpoAIPlPoO+zguje45ubD20VA4QBbFsZ
	aWLTvhqYgKR3yy387Z4NeiX1RH/MI3dSZD2NvzMMoTiLKhpx8kcwPmUw
X-Gm-Gg: AY/fxX6Czt550Fpnj6FqUFWw04wGJOukV6A/72GA6EJ0eU7mth7NrCYok7td9SLvJd/
	cBbUjPuudm15Lq0BFxwLESf9Mw/NYjrjstaxeL6n1/W+mc0Y0rgM63Aum0/o2130zoP+aNhIpIL
	mkdoXavo9g83EYm2hI511BLRBqcHPIv5p4IFQCPm3q1vdDm2HOjaD5yPrRUTBJoXDJZCIh+41Iz
	CFA3W1zaxzcuNso0/ovBYDtW96rVBY+GId1JHFuB79w+HL2C4brLN2qz11olLZdT03s3HbneMg1
	Y4012+mtho+DkjBY7MaNwnrfbAGywZH3FdEjihFdeLu9Do2XBi/JdFa2d+5jUXvIwwelWqv/4GN
	l3/+AFFpuRhbUjDZ+xsfGhmJQgu5NfW4jKs58JmGDMkWsQgXcPHGV5VOZITWzemwz/2nCuEy98H
	/pWHFQ/g==
X-Google-Smtp-Source: AGHT+IGpiya8RbWHXeXIazjjoeNE0QQuWIrlOz/AC0+4esxyba8hfzVjiroZs9tNrTzZxt7cJ04SSA==
X-Received: by 2002:a05:690e:12ce:b0:645:5b0e:c914 with SMTP id 956f58d0204a3-6455b0ecac8mr1974338d50.66.1765592912124;
        Fri, 12 Dec 2025 18:28:32 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:86f:7039:22f0:5fbb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477db607esm3280998d50.18.2025.12.12.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 18:28:31 -0800 (PST)
Date: Fri, 12 Dec 2025 21:28:31 -0500
From: Yury Norov <yury.norov@gmail.com>
To: david.laight.linux@gmail.com
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 02/16] thunderbolt: Don't pass a bitfield to FIELD_GET
Message-ID: <aTzPT2kAt96ypGU-@yury>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
 <20251212193721.740055-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212193721.740055-3-david.laight.linux@gmail.com>

On Fri, Dec 12, 2025 at 07:37:07PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> None of sizeof(), typeof() or __auto_type can be used with bitfields
> which makes it difficult to assign a #define parameter to a local
> without promoting char and short to int.
> 
> Change:
> 	u32 thunderbolt_version:8;
> to the equivalent:
> 	u8 thunderbolt_version;
> (and the other three bytes of 'DWORD 4' to match).
> 
> This is necessary so that FIELD_GET can use sizeof() to verify 'reg'.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> 
> Changes for v2:
> - Change structure definition instead of call to FIELD_GET().
> 
> FIELD_GET currently uses _Generic() which behaves differently for
> gcc and clang (I suspect both are wrong!).
> gcc treats 'u32 foo:8' as 'u8', but will take the 'default' for other
> widths (which will generate an error in FIED_GET().
> clang treats 'u32 foo:n' as 'u32'.

FIELD_GET() works just well with bitfields, and whatever you do breaks
it. I pointed that in v1, but instead of fixing it, you do really well
hiding the problem.

I see no reasons to hack a random victim because of your rework. So
NAK for this. 

In v3, please add an explicit test to make sure that bitfields are not
broken with new implementation.

Thanks,
Yury

