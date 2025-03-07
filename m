Return-Path: <netdev+bounces-172795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF3CA560DA
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 07:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F54176886
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 06:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B551C84A2;
	Fri,  7 Mar 2025 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4vQ7two"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB61A0731;
	Fri,  7 Mar 2025 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741328727; cv=none; b=DWrjMgz0p6E9TqJYJhEicdzm6s6tsHPMToyI+wdGSjjL6znbScacDKaBedKVMPEp56zD5lsIVmTqOpLfT3MKtLvKLG61tezOv7CURhwLUAeay8av6CXfOIVNz+j4JM51CrfXHGosGdJrVKvbaNB/RPWGD1OIx+z6rS4BQKvB/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741328727; c=relaxed/simple;
	bh=IaXFjppS/IoB+IJ+M/BVXjFLMyZOrjULwzmXC5Zs3oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sjqq3W2KNyG+nw/1ok3nIXc08vvqlnA56TlB/fb2Q4v37a4q8Rd1kCMdLPA0WK0q0+JZhu8Y37k4TcjbOZXp7ZSjIpigSl8QeHhnxpiqYsddY/xIR78RglkL2wkSTc4sivVUBMXxMaMGcFb/zNo23Pxtox/4aZ5vJN6fpd+2K7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4vQ7two; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c3d1664ed5so181489585a.2;
        Thu, 06 Mar 2025 22:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741328724; x=1741933524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DE4RgttB+ObeTGoRY2FNPNi0ZuWCnd0LsJTM8WKCSPE=;
        b=P4vQ7twoUHQPmt+m/8VaumAE86PX0xxhzx51Yy3GLM5vqYn1D0mUjNWqiaZZ/sFBXC
         r73r+JInHMoo1MCgSqyhTehGgAgdQagPkeGhJfPeBNn+mklWXLIOgj4Gpigi5bVZgf6S
         W1NJbcxT3WWZ3bSb/+q/bQm0CBmUrbFtQIT6rF4R41/l4a83J1EgCiw3zFdQRYQfxtM2
         gjcgd9vO/KBEkEsRehhyiXgv3pSBdylzFYjYgIOlo3H11gl9krdQV88mUB219G0YwatL
         rNmSQ+c/HYkbnsL7PcG6zQHrvD/MGFIEMkafAkKql9nN6JNVWlGfaUUsTWbYWn6o78gC
         r6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741328724; x=1741933524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DE4RgttB+ObeTGoRY2FNPNi0ZuWCnd0LsJTM8WKCSPE=;
        b=lh+FsdFbGvNU2GGMqEnL2ER4ZEq2aEDbLnQKBobuO8d7MGC8Isf5pJfAcxHZHnKGEQ
         v7L1Xw16LZXKqk4gzBWLlPsHyFyZsbszbRinDC3OhqgZjICspg/mkt+BqN+hxmeNUXoD
         XB3Uj+I93aFSTHI5JKYr7udjsDeDsGVRwSJhl80esugeptuMT8SkgThsQIT9t0ZxH1cs
         YDNbUORV+jmlHEIklKdM3IaG7hs9qVHbV7XTQOUV3ptYTpYnmhmnXLVHdNv34OUmZ9T7
         3L9oJPjU2CQMKYt4MTE8VuNJmcTTSgTzgq1bSZ53iey1uxOHRsTWqjZbw93iQd6DgntP
         73kA==
X-Forwarded-Encrypted: i=1; AJvYcCUnLXNowdW4ulG4TIBS5Y5xqsam+l/2ghqrGy9lVH6BZCwwtPNViEDMTXtEyOthchC0P/q+1ayE@vger.kernel.org, AJvYcCVLU76/PVR+Gl9OouQ4ARF3P4NZjH+7DgtnXXE4hZQJ03Yb0RH4qv4LoNpwRjbmsr7Rzq9lNXM+Y2Q3PMJD@vger.kernel.org, AJvYcCVfgfRMqFuYN/Hs+nxerAjsbYWgj8QsRvq2kk7xjV+dECmvJAh/pPH4joZYGwbbTVNQ0mU5m59bJ8vH@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNydzGMxm7JHhuzjHeUXooysgKS9HVlEU5+4RHlJu+ZelXHpO
	PW6paWcrCRJ0GHG02fDMiPx5QfqVxEdd6ADPBd7/LtkmXo9cGD9t
X-Gm-Gg: ASbGncsPgmqGiQLev/GSzOVaxO3SCCkIaoHv+2hG6TNwQ9Pn2k9FIg9vzHj9ALCTRzq
	DYQnPmI/V279u5kLDzcJnbiroAqTksVAheSsoetPDKrcFSyNrMaIuUw7+GCG4ThlP4NRVeKl1st
	JoDGh/SHsRSLEXFUEAKVUTv7PNs1FZmHuVP0EICHrRcE1qYt145omM5UzQPvRWBLMtCcGvjODZn
	zG6U1xM+HSGEtrL0Abts/e9liG++mux9z0vBJ2/xRMRZaUd9bT3sMexNylCiId3GKq5T/g5+BbC
	+mFRGZuaMsAerCA6BBF7
X-Google-Smtp-Source: AGHT+IEvDoykmlC42OAIJsi/QLfT+x2fU7js07z1lL9fYKp71NWDuSXyrrw0QsqRokKnLcIZ4rtbYA==
X-Received: by 2002:a05:620a:2787:b0:7c3:c199:c3b0 with SMTP id af79cd13be357-7c4e610578fmr376275485a.32.1741328724151;
        Thu, 06 Mar 2025 22:25:24 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e533a0e8sm200339585a.9.2025.03.06.22.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 22:25:23 -0800 (PST)
Date: Fri, 7 Mar 2025 14:25:19 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 0/2] clk: sophgo: add SG2044 clock controller support
Message-ID: <gyww3drj2eez2bl3y5ikxy7mqpqpif7cktd3espqs4ve5srjpk@u6h5nzmtkmrb>
References: <20250226232320.93791-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226232320.93791-1-inochiama@gmail.com>

On Thu, Feb 27, 2025 at 07:23:17AM +0800, Inochi Amaoto wrote:
> The clock controller of SG2044 provides multiple clocks for various
> IPs on the SoC, including PLL, mux, div and gates. As the PLL and
> div have obvious changed and do not fit the framework of SG2042,
> a new implement is provided to handle these.
> 
> Changed from v2:
> 1. Applied Chen Wang' tag
> 2. patch 2: fix author mail infomation
> 
> Changed from v1:
> 1. patch 1: Applied Krzysztof's tag
> 2. patch 2: Fix the build warning from bot.
> 
> Inochi Amaoto (2):
>   dt-bindings: clock: sophgo: add clock controller for SG2044
>   clk: sophgo: Add clock controller support for SG2044 SoC
> 
>  .../bindings/clock/sophgo,sg2044-clk.yaml     |   40 +
>  drivers/clk/sophgo/Kconfig                    |   11 +
>  drivers/clk/sophgo/Makefile                   |    1 +
>  drivers/clk/sophgo/clk-sg2044.c               | 2271 +++++++++++++++++
>  drivers/clk/sophgo/clk-sg2044.h               |   62 +
>  include/dt-bindings/clock/sophgo,sg2044-clk.h |  170 ++
>  6 files changed, 2555 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
>  create mode 100644 drivers/clk/sophgo/clk-sg2044.c
>  create mode 100644 drivers/clk/sophgo/clk-sg2044.h
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h
> 
> --
> 2.48.1
> 

If there is no comments anymore, I will collect these patch and send
a PR to Stephen at rc6 to see whether he will accept it.

Regards,
Inochi

