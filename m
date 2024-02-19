Return-Path: <netdev+bounces-73021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C885AA11
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DD31F235A1
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8245961;
	Mon, 19 Feb 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="I0jR+cCU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605AD446C4
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363904; cv=none; b=gMbFt3w2QydaAik0xyUIbTl7WbvslJkArPuHLevS5fWXTelPMAGtmJSnQ+D16BXlnB3vfbXWX4XK4ffXAZw/tm9tYRsxZ1oAvVl0sMpfvoHmsuvtghdtuOIoL36+1XqR4Uehsz4s3/yIrKVhu0sGX939KiaZQfGynuGlAvPIx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363904; c=relaxed/simple;
	bh=6xZwkdVE9Gs5wwO6SEmNrW3a6thnWFWbmQAdicf1Kk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZLjHQlwL3wK1lcrSEeSf+jYsTlh3kfJoNOT08rOoYhIdSpvOzIG/wnWiGOjNrnZf3AX8p/PFBvgpNQbo7m6w/PdM/ySwHvRSupEj1jopZGBccl53Ki+bd+j3VNUWnB6Tb9Zi2Sg1Nax5XgwCubaCqnFDAhe5FSaGvDW9ZRN11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=I0jR+cCU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1db5212e2f6so32872125ad.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1708363901; x=1708968701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUkEvIa4c12Idkw7v1U0P5buCnI3fCcq7Cm+xhDYKhw=;
        b=I0jR+cCUDne+p3YZLoHqNJAnhwV4sA9CCZpkYaURRDPn/yqHHkdcDCKJAtAe60/TPz
         XlGHMcE29v3Yi8q7VQoXXzL9BACYVJSdYXN9Lyox1QdUZrDdKpmeYv73RglxJmB2nbCN
         fVIkLQiS34xwHPVLLoVuDcUaTg11yQvUWAt6ZhFaISBP9x0AUfJfVk1Njul0FYVERBQ/
         vfwTO/qxrmMY3sOk6lBQnPf0MO6RnBn9rDxdvmIbLqAPpPKso2cGtJJyeyJdOxF9dpCP
         6iwXe030lYkgJIAQ1dgsv7yF/KChTeASiNg87D0YRkRLl94wxZiBTQ8GLHxOk1yGA7ud
         0Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363901; x=1708968701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUkEvIa4c12Idkw7v1U0P5buCnI3fCcq7Cm+xhDYKhw=;
        b=esNTGryq0nibulHNX/3DAwcZ6/RZSrnp7vSTX2MZekBjk52OC1namFSJHQNW6L87o/
         tr5I0QT1QlaqhZrT/OpHgnHFL5x0xzvFHOxSVO5on3/5ri7GtIw43ylMzYI6mepoZEXI
         R7ifBaXRwwK58ZLHYU4V7lRgouhYvZaAj0L7i24ocSc2M7olVVD4Vw36c8Ejri9HA+Ac
         /5vLYaanbyhWtdhxLnBDZfcjR90J3FKGGbrrfOKVU6TLpKZ1Tu0stQ9/qPngF8CFSFNg
         YeK0w68ZM/qHbKTO5u1B5YactYy/1GSknwfAQi8wH+LARVl5x1S2vSZsaSWmpcLU+wWt
         2yew==
X-Gm-Message-State: AOJu0YzqUeCt3PH3J4yxemfaPFlVmkj1SwblAFwiNTYy+sY7PpRdZ5sb
	bDn7mEVyVo1s+clE1UBoW/bsgoUb24kHiTsvqedbz4HakAYjRwtoB+yRmho2pyVYxpSy8yh+S/T
	t
X-Google-Smtp-Source: AGHT+IEhgsprkih5C//JoTsIIcyTjF/GGyVptFRDvNq+nYPW2opL0B2KjpaScfT+T4WU4b5HMVWqYw==
X-Received: by 2002:a17:903:120d:b0:1d7:836d:7b3f with SMTP id l13-20020a170903120d00b001d7836d7b3fmr16464265plh.9.1708363901590;
        Mon, 19 Feb 2024 09:31:41 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902f1d200b001dbcf96004fsm4028309plc.148.2024.02.19.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:31:41 -0800 (PST)
Date: Mon, 19 Feb 2024 09:31:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ipmaddr: Add check for result of sscanf
Message-ID: <20240219093139.5d86c69c@hermes.local>
In-Reply-To: <20240218204203.7564-1-maks.mishinFZ@gmail.com>
References: <20240218204203.7564-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Feb 2024 23:42:03 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Added comparison of result sscanf with 2 to avoid
> potential troubles with args of sscanf.
> Found by RASU JSC.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  ip/ipmaddr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
> index 2418b303..00e91004 100644
> --- a/ip/ipmaddr.c
> +++ b/ip/ipmaddr.c
> @@ -148,7 +148,9 @@ static void read_igmp(struct ma_info **result_p)
>  		if (buf[0] != '\t') {
>  			size_t len;
>  
> -			sscanf(buf, "%d%s", &m.index, m.name);
> +			if (sscanf(buf, "%d%s", &m.index, m.name) != 2)
> +				return;
> +

You didn't look at surrounding code.
That will leak the file descriptor.
Please review you patches more carefully.

This is reading from kernel /proc/net/igmp. And the ABI for that is
stable so not a serious concern. It would be good if this was available
over better API like netlink, but few users get into the weed of multicast.

