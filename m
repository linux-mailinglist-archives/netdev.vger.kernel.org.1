Return-Path: <netdev+bounces-234474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D95C2116B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3C4F34F5BD
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C91363B9B;
	Thu, 30 Oct 2025 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="eXcuw+V5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177941DB15F
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840396; cv=none; b=Z/JYSHUTnSkTtTF3NJh/+O3plnfcSlbNYQt0Nd3LMBS8PN2BtYNcNmQbZldK0k0ZcvPM6XeIwtmLgP3DjFKLGo8ghQZmDrsUZ/WkVXv1a80IIofwN2pH/p/bawTzEGci218kOGI45sJrt68nziv+ZNeZ2qfUTTDnoBoZn9TyOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840396; c=relaxed/simple;
	bh=FjvqJbJhtyjNg1e2n6d9+KOjBsxEJInjB8d45TyP9Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOeXcFwZs1u1OONQYh6IOj0KglMcAtLt0rFeNasWhBXcrwKnnnUOyNrlEwfvSGW3dCNxxkdGUiwY4QI6XM4BsJVSmsJmc7zassq5F8ZIPJRHlHRgNlz9+qwSCt6RNYU6/1cgGoLZT/bk/T/nGojq4opFl33nfbq35C+1Ey/xp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=eXcuw+V5; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c681a8aecdso783450a34.1
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761840394; x=1762445194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54DWiUnRf/+lC5UPWAwFch1X40meKelVC4u/Q9+8ubw=;
        b=eXcuw+V5p7gXAG219RrF8Ok1n74lw3KH4BS17MvltvXSrBI9ChOjZ/HhJx6BC3GnRx
         pMJ+kXErq4DC3TCGd6gJQ5cZxUp2Ihli75clu89KcHr3rBgqJClEiSg+LqSOtWd8oQWB
         WbesU7sbWzH/E4TFI8igmognXL6dz8EG2zmtpE7IB4hqP0x20DmMQRNO9RzGce6h6TGC
         ojhM6kXFvs3N+XLkGW1Wz1fDS/wboTt+DbeDH7iJ206PeaGtrBYUhR0STEB1tTrzLgbS
         eZww+nz8tRnXmPTGfFaiQbWVuuXsJmuglDgmhqWr4+pWF8qxx+MmlHzF00sgjlaoPoOa
         RoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840394; x=1762445194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54DWiUnRf/+lC5UPWAwFch1X40meKelVC4u/Q9+8ubw=;
        b=foIHQyPg8xkKphanQpuDu7wI5Zv8rmKKWKU+QxmxxKNZUB4AorDNkQs54JBD5xJq8j
         LhgSat5bPjMBXP2B0yQgz3wdnfthIzhe/qSF/L1q11VPucMgdf/j4QyN+CscoRJWhrGt
         lI+R9aRj5ZvYAq4vEHhkAOdTv1POsChiPUP46mdjns2TYUp582aX28fhFyICaC5dW9cY
         6eqC4rTmfJ1lAdgJbcNOc5lCx14yfxehQeTtlV1/NEoj29XMU1Q0bcJghGKf43V4urSm
         Zi0mZQTiZ/Ofz1w1Vl7WFHKOLk1eIzn2/tw5G3cbtq07NQ/GEWDD5HgiN3Zy79fro4su
         cxOQ==
X-Gm-Message-State: AOJu0Yw6Eq8YXx2JT8AJAFwjoGkasiistrNWcI92b3i2rrG5VKY2s8Fz
	Ax1n1brPfU7Wi57poxPjmh5P9oHtN1vZNverFfk+DNdnz8C+k38WLxUNcKOlkfgJsW1+RdSuozD
	gQs0N
X-Gm-Gg: ASbGncuDD1zYfDCGefOc1OKwIh1xwAPPcaIB4GOn+UDDW0oEU6qoAxzWTgxMaygx5j+
	z+GKPvrkUOSIg6g2jLb72v5aWXoxJ71QeXXB86yG9+pYMk9TRHsjhIw3HhY62gyGek2Nkl+C2aF
	pD26ITYFZ6upb4yN3Jilb5m5i36tqCJ0D9OQoMjT8k/2qxzvhsg+/4+Kw0YxQ1RJ3XqDEZopxZy
	MS5LRrrvtlAexUuE+IqjbzSQYczyeApatGSxv41Sd05pkRgrtozW75um0gJsoY4vf6DecjjhRy8
	M6S5XbUd45L7IEKz3UAILHQRwTs7n4jlppVBdVSF/fgsECNv6gpNpZMy3XBOMhgRmerNjmFLYEe
	YOJMb/dtlaJJR5DC6hJwbvaIqyujzbFPoUCm2nDjUSVx148YQeGIUfheUrrUji8t4fhOSiJzOX7
	OPFDT9xyqHES58efXtqfBL/I+KrPze+0y+SQ==
X-Google-Smtp-Source: AGHT+IG9MHSBT0YskIpUZYnO8XixxYyVcWx3Tq48GMijP7Cgoj7iCRuqyUmZHSkJo46tkcBICkxEAw==
X-Received: by 2002:a05:6808:1882:b0:44f:8bff:4365 with SMTP id 5614622812f47-44f95ebefb1mr64414b6e.11.1761840394111;
        Thu, 30 Oct 2025 09:06:34 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44da3e59a15sm4291723b6e.8.2025.10.30.09.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:06:33 -0700 (PDT)
Date: Thu, 30 Oct 2025 09:06:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next] ip-xfrm: add pcpu-num support
Message-ID: <20251030090615.28552eeb@phoenix>
In-Reply-To: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
References: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 12:06:16 +0100
Sabrina Dubroca <sd@queasysnail.net> wrote:

> diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
> index b15cc0002e5b..586d24fb8594 100644
> --- a/ip/ipxfrm.c
> +++ b/ip/ipxfrm.c
> @@ -919,6 +919,12 @@ void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
>  			fprintf(fp, "other (%d)", dir);
>  		fprintf(fp, "%s", _SL_);
>  	}
> +	if (tb[XFRMA_SA_PCPU]) {
> +		__u32 pcpu_num = rta_getattr_u32(tb[XFRMA_SA_PCPU]);
> +
> +		fprintf(fp, "\tpcpu-num %u", pcpu_num);
> +		fprintf(fp, "%s", _SL_);
> +	}
>  }
>  
Reminds me that xfrm is overdue for conversion to JSON output.


