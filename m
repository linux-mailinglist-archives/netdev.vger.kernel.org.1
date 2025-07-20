Return-Path: <netdev+bounces-208436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2BCB0B699
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2830E1899EFF
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA1E1F4C89;
	Sun, 20 Jul 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="yGruCdA8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8B46BF
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753024423; cv=none; b=XRDzbRVB24j3q8xya5c6EpNS4t7Fv2kAcxJ+BwxJ4gNxqz3eTEV8NXdwTNsBZSC9l5vNpI/y4Q2x1hDUpgpdIv64ePsLbrLR2DtLbE20mVG6bLoZhAfaON5i7pRhh0jhLVTfw8Q1UWxftU1u7STgdcaYyKS+Byx24yox4jL7pl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753024423; c=relaxed/simple;
	bh=aMtJyEIFFGzL4MAPlGkZ5oUtdO3IENMmrQbzBq4fF+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiY5GCKQ9+aLaew7DJ1l57LbMKuLjVebXND+hg9yZ1etuj7cp19kuz89dxBFEfYXU4ixqj8jZMTButQ/83Xpg/IJHnIoB0HZIwyzLTXxOEgJoVq6Oq459/ju7nRrpAfYWxEMWU0dAmG3QWeYzsa7qCsXqlEIEyhEZwp/nzCkgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=yGruCdA8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso34915181cf.1
        for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753024421; x=1753629221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDGXi4HitoCbZcpkF9ye2ML/fqtZE3jv8sVD7QpI3H0=;
        b=yGruCdA8l91ffliTwzLB04Xu6bLxdpgNR+u+VVceRKx49ALOPTQ3DxQoyNsAZvf+qY
         nvGvg/GGypAFta0kOjyM04PCDRgFNboU11zWTrVvJ/qUWhZmHVcd7i5atdjZeoYx1nt7
         A+kuspAf0UIrsVdJHEFI27eNswaoDYSl+awa+b0KKbf6ND3ar7SjhJeAkWu8IZJcxab7
         cItzNdW7VzK3qF1kN3NqrBSXsn2eyhp5hGL0bJhc+QT+k2PN3L9dKT33BGTqdOCVhnaT
         BH5V9I2ZlyPU4HMQsjN5Q/iiBosgAA2a8I5qdNp0Ufx/ulrW5Nw9C6jyLGGtiEqOqi2v
         MDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753024421; x=1753629221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDGXi4HitoCbZcpkF9ye2ML/fqtZE3jv8sVD7QpI3H0=;
        b=HjorCXtjz6isDQaAhpemZn8B53Uu/M7qwAJuxLO/301kXEAi2JQUvLjIMK2+ITgp6T
         8o/QGbhEA/I71nMnWcxtHx6P90ao5Sx9Ss/XV+/+B5VfbV5w4RmGLm0jt1jrN//vtuFZ
         zp9mSh6zkKnQMS5lKMYqFUFRw63cSKpY1IW1FWFMOXScBUTQvLbgM/u9e5JfutlosICv
         pbhlqizazWZyIWOOBELJt3PdApwlcRH537e6q0jdl1iVHIL54Ml9+YdVKV1rkqCoG+eC
         0Y21eZu4ZfUf6dxgHDrvJKg7+1M2RxtFSNlhNhthQL6W/31pJ4UkSzyTysXK8ygtu4Ct
         VOgA==
X-Gm-Message-State: AOJu0YwrB1fkLf+P458hMb/Vym+yAu1bgdIJv0toZ211NdpTzvr3pDg9
	jbScP9YFg6BLNkCm/HOoUFbMxozmiqbFlpFaIWA9FtlJnp8/gRU3LsyM5ukt56mHEJz3BFRYeK+
	cw0+6
X-Gm-Gg: ASbGncupZUpGmL7Z8dCH+zxKKODyBIHi64fcwC4cwOX1WZe7qWwz6ULYSasxD8x7UYO
	EhmtaaeDkemPTBV73iScBUjSCOpwa+Mlo2ugbX9YBWToUQ1zlvxB8MXOrP4jEiAHsEGlOSKrOU5
	RtCP6upVzWv6L/FBGE0y+OGbiHGXVPnafxMGqcFrsN0O7zo85425OnpgjnHwbP+kVHChRmqdNFM
	18CrIKTPw3LYzo9keQEv4m68+mISXJGCrlZfqt1OsY3bp14/VlnS84YMYg51KvOPIPanpE18pu/
	zZKPOL+slUoSxQHMx/0q8D7yPApQfd1kAW8BVCrUtjdAW25zz+kLXRoD+K+CtMvKnEtwM017ZQe
	rRgrvsUtb4WexzLCzH6WnxPfL+8jlcvevg6ChnFpXL4NtYuQ6+izcx2fW0yDAAHGvXyCeVoddw5
	Y=
X-Google-Smtp-Source: AGHT+IGRHLQdMlvMoiFTC2ZIW0B7xCK7zAUjRw/+En1lJkW3qYLJZRev1yOjXMqQm7dS2Zv8hyVF/Q==
X-Received: by 2002:a05:622a:a14:b0:4a9:7366:40dd with SMTP id d75a77b69052e-4aba263f133mr245986661cf.19.1753024420803;
        Sun, 20 Jul 2025 08:13:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb499fea2sm30922311cf.22.2025.07.20.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 08:13:40 -0700 (PDT)
Date: Sun, 20 Jul 2025 08:13:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] ip: ipmaddr.c: Fix possible integer
 underflow in read_igmp()
Message-ID: <20250720081338.7c20d793@hermes.local>
In-Reply-To: <20250719155705.44929-1-ant.v.moryakov@gmail.com>
References: <20250719155705.44929-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 18:57:05 +0300
Anton Moryakov <ant.v.moryakov@gmail.com> wrote:

> Static analyzer pointed out a potential error:
> 
> 	Possible integer underflow: left operand is tainted. An integer underflow 
> 	may occur due to arithmetic operation (unsigned subtraction) between variable 
> 	'len' and value '1', when 'len' is tainted { [0, 18446744073709551615] }
> 
> The fix adds a check for 'len == 0' before accessing the last character of
> the name, and skips the current line in such cases to avoid the underflow.
> 
> Reported-by: SVACE static analyzer
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  ip/ipmaddr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
> index 2418b303..2feb916a 100644
> --- a/ip/ipmaddr.c
> +++ b/ip/ipmaddr.c
> @@ -150,6 +150,8 @@ static void read_igmp(struct ma_info **result_p)
>  
>  			sscanf(buf, "%d%s", &m.index, m.name);
>  			len = strlen(m.name);
> +			if(len == 0)
> +				continue;

Need to follow kernel coding style, need space here.
	if (len == 0)
not
	if(len == 0)

