Return-Path: <netdev+bounces-200051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D9AE2ED5
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 10:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92290188A9E6
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0319C55E;
	Sun, 22 Jun 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+qe/QKN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A478C13D;
	Sun, 22 Jun 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750579935; cv=none; b=b6sY17tPOeKlyUp6iefU7Pe9atA8SXalYLdFcwExmcifGqDbzWM5GJv7Ld74CxoC5xPQdCo9isgU3QRQMRZtmqHGsHhSmjXYybzO+Hm5Af7ms9am7vzLuEQoZk5wE8oggdmAsC8rkYJo4nSSJcmTJgRaM6zJqCWzQPTeh9d8fvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750579935; c=relaxed/simple;
	bh=1Nyqsom7BzEZrrFbK6mIV6zQVoAU3LFbyT+w96GCjpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM8pd4GBSUQfMzBPyT2XDcXOCy9CScoZ1GnLGlxxUMXfjv3JrZeTYvlRGKY9BeuYrVtnQLHLagmWc3o32t3vXN3d+zcU5QPR+r2BYvLvPIWNlDtdEE3+rQZ2KyX9HCzYp8Gxv5S2eYOmx6TczNMQfUx0FOqBmxfPJF4bWeQrraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+qe/QKN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3641924b3a.2;
        Sun, 22 Jun 2025 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750579933; x=1751184733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBR+XoEZ32orRCDnBc/jEQaZSm0kBODP8RwLrnmBm0s=;
        b=b+qe/QKNouzJRZ1cT0fi3CxQkPR51qKfrEDJeTfg/qpxEciOjS+oK9pdSp3sJ/zt4n
         KAO4X1bquxt0xFQ5GNbH82dwmXkjz2OrMq+XB1oT3WrlQ9zyosDfdkDu++ChiLj+BukA
         PCmPcV/e940zA7fw64afWfv9K2dMMFTbdZViliAgIMiLhCdMK/CE0748KlSMN+mYpUht
         IKuXhLBJ/nGBf1tzLQ6Sqn2RluRT+yd7Lm7Vz2fU9i2G/vQbPqQHxURLBaiLtKtLYRC1
         9iv2S3zjzzqvMBaWZnN1NvPEnVtYLpFSGQsXlHocYfY0+KeWLdcTRP9MlPL0EthYHlzJ
         krpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750579933; x=1751184733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBR+XoEZ32orRCDnBc/jEQaZSm0kBODP8RwLrnmBm0s=;
        b=S1kofbz+ESKN0NaK7LWsM2brY8pSmnOygdjAUYlHPryfzYcV+PskuQ/0/CEyJ7tJua
         Rrse5TUFA4ZzksiC0HmYd8oJK8FCJtJ1PDR01HhPMBsEPO16jn9WllADpmiesiZUQc+O
         l1jC6scEWahNdRVMCiSe8d3J/ndo8OcvVae6Yp23cPqlmFpCIu3d0XMt8weG22AmmhOJ
         NnZNY6whL0azKGMipIVeftw7mY/cZyXq5+mYLsSEosTg4hi1YbdO4eZWCp36mrYcaQFX
         Kv5D5CZmxlnPmDVMTnln6ca9WauZl6v7fGQhtQTYOozmG4iBeqs+QLdSHXqHQ3BHLdoA
         vR1g==
X-Forwarded-Encrypted: i=1; AJvYcCUOW9sa0B8ufHQWo9+STNRMxpsQS1sBEktyFa/I0hmX7jSHagcoL2QFqyyHMcHIEx7QRP9agNDJskwhKQE=@vger.kernel.org, AJvYcCVxD/l+szIEqqKURq1WvP3ufSk7gazG6mMpqaZo7RiwI9Nmu92nbjRZ+jv0WfYvqtfgKEuY+HY2@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3rkCdA+eofclAyqPVD666MdLiEw0bDoCCIIp/ndSsYSNS15n
	vEx8GLjdP1fCKYc5o+RydqfOTZxlS3+ehFsu7uXTm3cS2gTghAGEcUaj
X-Gm-Gg: ASbGncuZNFZYsOs/NxEucv7USufTs1bEg6Ms9bv5Aw+pY+x2aNjgYJtvwuyoKDPlFCA
	qztY8PC+yrQb8dui4V2H0xAeS05/bs5hXuACpOgePya1ib5dpDMlMjkawr+p/HQDFcrE3zVZMzb
	22dqG1P5sTIr7dYbVX5G/eK7ocUGV+9AQQLO6S1l+jcICxyZvkAeEx+Rc0KkkJMcSUmYY59mYpl
	1dAFzM8Ri91McC5pe7qG3kA/n/MgkCsTzGJQOD4ReIp9vqdOOY3bs56CFNv++zeyUQC/CRMr0cf
	TecMqyPMXzvwaALqyEbjcNQ6DdJr0IIW2Y2yO9DLkf8KXpP0TYfsN1zXZtjc1Q==
X-Google-Smtp-Source: AGHT+IGPw6YyGIuDPSt2iRzF0W7Kh+gQvIPV8hducKJ1Zi5ziOV8ujfgRDVNiq/Vn+KNi9yCX27yVA==
X-Received: by 2002:a05:6a00:14c3:b0:742:da7c:3f30 with SMTP id d2e1a72fcca58-7490d6793f7mr12661656b3a.19.1750579933256;
        Sun, 22 Jun 2025 01:12:13 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a48a1b6sm5871067b3a.50.2025.06.22.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:12:12 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8B4D84208F51; Sun, 22 Jun 2025 15:12:09 +0700 (WIB)
Date: Sun, 22 Jun 2025 15:12:09 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, pabeni@redhat.com
Cc: linux-doc@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	skhan@linuxfoundation.com, jacob.e.keller@intel.com,
	alok.a.tiwari@oracle.com
Subject: Re: [PATCH net-next v4] docs: net: sysctl documentation cleanup
Message-ID: <aFe62dzYPLktxZrH@archie.me>
References: <20250622062724.180130-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250622062724.180130-1-abdelrahmanfekry375@gmail.com>

On Sun, Jun 22, 2025 at 09:27:24AM +0300, Abdelrahman Fekry wrote:
> @@ -1028,13 +1134,15 @@ tcp_shrink_window - BOOLEAN
>  	window can be offered, and that TCP implementations MUST ensure
>  	that they handle a shrinking window, as specified in RFC 1122.
>  
> -	- 0 - Disabled.	The window is never shrunk.
> -	- 1 - Enabled.	The window is shrunk when necessary to remain within
> +	Possible values:
> +
> +	- 0 (disabled)	The window is never shrunk.
> +	- 1 (enabled)	The window is shrunk when necessary to remain within
>  			the memory limit set by autotuning (sk_rcvbuf).
>  			This only occurs if a non-zero receive window
>  			scaling factor is also in effect.

The indentation for enabled option outputted like a definition list,
so I fix it up:

---- >8 ----
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 682428b8f20507..e20cef49adf75c 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1136,11 +1136,10 @@ tcp_shrink_window - BOOLEAN

 	Possible values:

-	- 0 (disabled)	The window is never shrunk.
-	- 1 (enabled)	The window is shrunk when necessary to remain within
-			the memory limit set by autotuning (sk_rcvbuf).
-			This only occurs if a non-zero receive window
-			scaling factor is also in effect.
+	- 0 (disabled) - The window is never shrunk.
+	- 1 (enabled) - The window is shrunk when necessary to remain within
+	  the memory limit set by autotuning (sk_rcvbuf). This only occurs if
+	  a non-zero receive window scaling factor is also in effect.

 	Default: 0 (disabled)

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

