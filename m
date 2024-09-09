Return-Path: <netdev+bounces-126620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD5972152
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77F21F249D1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06AD17C9AF;
	Mon,  9 Sep 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eno0I+z/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD74524C4
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904207; cv=none; b=qaPaKLR5SZQmGDz5+FIW2cX2H8jybkcZ468pypI+fy9hDpZQoOtyPkrqWqb8QkC6nwKEoVtA3n2hdk3m1ZuVbkMng5YoBaAJo15HhkOgAWCpkQAtBl1sfW/53QE1e3CAMV1iWyMMYek4FvlKIgVfLWGmNaBgOGBaehZBONg01aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904207; c=relaxed/simple;
	bh=tCDv/sye2k9l6Ne0X+DG/eQBkEXbVkL4kotpxazCiTs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dWflG0OjFcveQC7BLoIEi73qV3qHTzi1LT61stNyuG1JhEc/OucWM9co/bKercKOgthqeRpYdIfiIXFoREgpt0VbXiI7mseuz/vRI5nedvo1bGTGijphJMYr1DxgGqPg8q8ERAy3/IO/x7zTJeMrnoXzyAAVLX0nv26cWzjS568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eno0I+z/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-502adfff646so969652e0c.2
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725904205; x=1726509005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pqrYQwbVsEibKwsCXJcjRXI9oSYTeaAexUuHyZemQ4=;
        b=eno0I+z/PHGTq1PIC3Hh4lRqGNcCUFiAL8uYWuGM1nJs7gKiQtoFxFzbFS6CDajA5H
         zSdkJZYzCjmGT7kVyMS/7SRHvsv37N5e9sioXkLFYUnk7nUxQpbbh7fC7ey9c998J3iW
         gIzfDtQgZ3fCc658YlbV3obJcXpZDvqx0Il0oL45mLNiq4CTPW663NFdxnJ5L5zs83Va
         +RrJUByBhJzeo/x7OShRFNbX6QLu9MO0WDw3mxAMVaesLT288HAKUag5KRToBeSHNZjv
         0MRgmYxd/PT9NG5/hkpAyVGdLiEBDMLzMnv/GD3IjkznAWrzb8o67yEuE3LFfH4WNZtI
         MvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904205; x=1726509005;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9pqrYQwbVsEibKwsCXJcjRXI9oSYTeaAexUuHyZemQ4=;
        b=jkCtkCl3Cjepye6D6wLrUSuS5wmGayG5Hpfi+Hau/MV1W7d0IBfLzC8JAofQqx+xT2
         TnqL4LILRkn8BlfHOgwJXeDUTwGyCNhDCPSDacSCU6L9vcGBp4lY7pSgDqfxuOvpmRgj
         ZRJ8tObUCpkVjcCDZK1bdEAiytg4AvIqdevGN25UgTmk6otgPIPAH853th5Wbw/WKdI+
         j2O09g4s3sjNPNZ+fjn9sojHv+fQ945rVHU4n5z8/KyvHSF6cOKgnK/q6FsSEa2SsZyE
         g5ajiwhFI/2937fHKMgrZyIlHHo223APMCtPiZK0rAAuFetz+n/dM9ByIxGfzE1or1DX
         ypQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9eZx8zGojf2eluB3e+AO//swRRou+PUmQqLW0I1au53T1io2XJbhtXEsOvGTfJ7nS5s1yGv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcFsB+t3nEL27pL4DX1eVUij9fx8W4RFrjdvZELLwsHX0p3yx
	vg7r27u42RwIZJle60dvYm2CN3qW7AthTgFODYVVphfLOK0odWIf
X-Google-Smtp-Source: AGHT+IGpFnWyOZ3afAIrvFlvTx4u7VbUuSTcYj0tCKylVK00QZFLDagZCqW91S0o55WKElUVPxkOrQ==
X-Received: by 2002:a05:6122:1682:b0:4f5:22cc:71b9 with SMTP id 71dfb90a1353d-50207c5eb94mr14409892e0c.5.1725904204717;
        Mon, 09 Sep 2024 10:50:04 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7967615sm237659585a.33.2024.09.09.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 10:50:04 -0700 (PDT)
Date: Mon, 09 Sep 2024 13:50:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 netdev@vger.kernel.org
Message-ID: <66df354bbd9e9_3d0302945@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240909165046.644417-4-vadfed@meta.com>
References: <20240909165046.644417-1-vadfed@meta.com>
 <20240909165046.644417-4-vadfed@meta.com>
Subject: Re: [PATCH net-next v4 3/3] selftests: txtimestamp: add SCM_TS_OPT_ID
 test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> Extend txtimestamp test to run with fixed tskey using
> SCM_TS_OPT_ID control message for all types of sockets.
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  tools/include/uapi/asm-generic/socket.h    |  2 +
>  tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
>  tools/testing/selftests/net/txtimestamp.sh | 12 +++---
>  3 files changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
> index 54d9c8bf7c55..281df9139d2b 100644
> --- a/tools/include/uapi/asm-generic/socket.h
> +++ b/tools/include/uapi/asm-generic/socket.h
> @@ -124,6 +124,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SCM_TS_OPT_ID		78
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index ec60a16c9307..bdd0eb74326c 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -54,6 +54,10 @@
>  #define USEC_PER_SEC	1000000L
>  #define NSEC_PER_SEC	1000000000LL
>  
> +#ifndef SCM_TS_OPT_ID
> +# define SCM_TS_OPT_ID 78
> +#endif

This should not be needed. And along with the uapi change above means
the test will be broken on other platforms.

(SO|SCM)_TXTIME ostensibly has the same issue and does not do this.


