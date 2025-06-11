Return-Path: <netdev+bounces-196514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3399DAD5177
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CD71885F23
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B263257448;
	Wed, 11 Jun 2025 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbKq8zRt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094812576;
	Wed, 11 Jun 2025 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637097; cv=none; b=nSux07Y4vmh/mFTHWpUmJG5tk6fdFTvzzWobysILUaGGU6RD+PPwfesNp+Ks0EN73ORcXoO58jvKDqhKmokCb8WWZmXZZ6yozpI6uF2UtUwZMgnFMtW3Ohvt0M89Un3Oxbh22hNHLzpX2vPH3+7BbodCVfmo91kYGb5UGT0qxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637097; c=relaxed/simple;
	bh=WGrP9tEvMD3BUrTB/EzMwO5IxuAwWTEiAfzuQXCIZvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyPL2RzlFz6XcRm7aiWMcDkpmWndh0HEjxumzYuCJbGQUm2RdtO/1pFcN+qBhMWXkzxPJ/LpJIxe4P8jRNRlTihvEZ4zxCp45KZCn0QCN6huBYDfH9zy86/sYAgANSAlxGKeX3VJwxscc30AEUsYObppWC8aP7Uo8834qc1G4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbKq8zRt; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fad79433bbso58881906d6.0;
        Wed, 11 Jun 2025 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637095; x=1750241895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0H9DqqVIooICLmp4vYW/Nyz3xv6CeQHhJZyVDnOWFA0=;
        b=lbKq8zRthrug6PnVnp/OEMbiP1UgX3GjORov2AlGmDgf0rY7ZHDTQliNh5YejQk8Ss
         3zGHu3GcZ0Kxsd6+XUqkEESExMt2obBx3Lgo9yAa6QiEQ/+HVhP+Dow14FG7QMG37KKH
         PX5M1jXNPT6yfOxzsvrdszoFXQRS3Xh4mA8ySsJmQaprOwPFRuSqlaeoKhxxoa5xUvA4
         4c5tBzH4GQa5P/7E6dROsgY1pVI/oBM0QOTLSCkjYR706OlzfIVwK6H5s3KnDNE00U84
         2CQ8kPQomcL7M0vvmfspxEQnhXnD8bZrh9OF3TMbiJOpMmuuQcnyyoLUEzTrQKfKIptj
         Xw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637095; x=1750241895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H9DqqVIooICLmp4vYW/Nyz3xv6CeQHhJZyVDnOWFA0=;
        b=V/toUN/yTidLlWpIg5Ksec400+VxRMrwI68Py/r083CF0zw6GthPzbH2t+o3ENNgAJ
         bhgMTnnkxxgPZaK1SYNe9yZYMDB6YoEJ0SRwDkvgSe9wddID1lO92c23H0UfObSYqWDe
         1W38AgX4Y4s7fYr/Zf8cgLrUfDRup9VCQOqg8kcF/07ujzRREi4FN45IqleBeLpuHdJ9
         f1KE2kjAGr0J0j6VjguY72HSnnDhql/eWSKU3yXLJCuto6xEu5PFKJtuAfwlgTWUKs4b
         yK8PzvPl4ssX2jx0hDDSmvpvuhm4vJZskqwc+HVIgQCA14pKmsOsvjS0x1kic19AnNow
         OiVA==
X-Forwarded-Encrypted: i=1; AJvYcCU6KEX146d85nBzPLDv+AtoiFf1rnqkbw6cR3NrLegv07XoJdvX8YTuzXs/zh+3RWMmNKIaztKg@vger.kernel.org, AJvYcCV/PeUFbKWfWiowR8O5uwGzDriOHQXhmfxuGft3xOdrVS33CmSHS3b/outNwHeU3PtxuCHneFaUVLQn@vger.kernel.org, AJvYcCV9RzGorrbGmm7on98L28/A77bfem/PXB38Bm3SLRvq+EMMjrZeYTNX3bG4CbP+vZUFE6pdnddje+Qy1mJZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxft2o+k2GpJqPRt1sLH6a6rCrZfDCBMYCOYtgnNuHfzdip1U/M
	HLb9FkSQKucjMweMyvJ7qECztP+4HKb0576eR2CWZ62Rj6V+TQ0SrUsM
X-Gm-Gg: ASbGncsCEhha3YqHOisWt+f/hO42hcJ8sixqWn43yMz9kbO3JjkhuTR5F9aue2s3MEa
	xOwHVBW9DNOaBF0Mc47VnC1MbDXa5caXdlq1roQUwuwufaoSwj3RSy2M0qxNFnm9EofrXZvgf0r
	t1GyRa4lZlgi6M0SiP/J1YINQxzy3S3AscIyunC01vBU+RIcYiv56P7xU50seRqG5892pUVR5hZ
	qUwKXO9JUKCkqjvd7quB7irtemjHiiHvoizVpqi7j/1h+0gfEuXCAoo3xkt1LfnITmjqFKJtXbN
	WNcG2L27wyvzwQcJFaHS0fcMcoaXNfOghnzYvA==
X-Google-Smtp-Source: AGHT+IFwTEmZcybq7Mt7k025PPfiskyqYi6E6YXzghaXiz9yzSTgjcINKWLcnTMMqF7Kz/++OLzTxQ==
X-Received: by 2002:a05:6214:627:b0:6fa:fe02:8229 with SMTP id 6a1803df08f44-6fb2c38701dmr36593406d6.30.1749637094989;
        Wed, 11 Jun 2025 03:18:14 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09aba071sm80423106d6.24.2025.06.11.03.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:18:14 -0700 (PDT)
Date: Wed, 11 Jun 2025 18:17:06 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Richard Cochran <richardcochran@gmail.com>, Longbin Li <looong.bin@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH 11/11] riscv: dts: sophgo: add pwm controller for SG2044
Message-ID: <evxmh4zqt5muhbyv2bridgyxw57z3ek7sxn2jp3ma2pyfgxuuv@nn6htxhn2p67>
References: <20250608232836.784737-1-inochiama@gmail.com>
 <20250608232836.784737-12-inochiama@gmail.com>
 <PN0P287MB2258F2BB409F70955D6EE248FE75A@PN0P287MB2258.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0P287MB2258F2BB409F70955D6EE248FE75A@PN0P287MB2258.INDP287.PROD.OUTLOOK.COM>

On Wed, Jun 11, 2025 at 05:53:54PM +0800, Chen Wang wrote:
> "sophgo,sg2044-pwm" should have not been in 6.16, submit this after that?
> 

It is merged for 6.17. So I think it is OK to go.

Regard,
Inochi

