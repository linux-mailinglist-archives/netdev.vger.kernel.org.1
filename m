Return-Path: <netdev+bounces-70324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0313084E5A4
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364001C22555
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468568002D;
	Thu,  8 Feb 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KWNV227n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739280058
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411404; cv=none; b=mB6MGzSNuCb7ufbRFkRzrej6AzIpFIwNJMicvz0UldreY40+5o/sc7UuI77Hf4msTwhv+BIQWRYBnDgxwh3ZS1AUm35v2mL+h5C71FJmC+jg2Vw8Sv6v3e7ZAfxV5TbTW5o3PrsZK0GoQEeRHQR0ErurYXj7qcg8sZSmMaliDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411404; c=relaxed/simple;
	bh=MUsb0hIoMKDc6CxuL7oi7WrQxEaYEI3jhjbJuHIH4gU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddWl9Ad53vJhXHdysPOc3t/jSCVDQgO8MiEyU3Tf2OL9PgL/41mksUWHtfOsScGvYpHLueyOx4GsL7RmGtu4c8IO8mOm0JO6Cyo6F/MWZmZOaHi7uNY0AimjUE6CZiDYgE22gBqFbdOmkqaIrpnQQwXw27Uxmx7TzAUSh3p8/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=KWNV227n; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1757719a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 08:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707411401; x=1708016201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8t0FBFklbSa0WOTXDvtT6VC4NjI42Dj2ELNDWg0GmQ=;
        b=KWNV227n0BM3VtiQFulcF36/S6KcRJ1H2yCzWxRqZIThduwoAsZn1yXlKrtle4T6Z5
         yrJmJgMnOBFw8LLuISXZ+OoADScevOWL/TEB2/ofdF2qmhurmxIBZWbBpycXGpN1dCMb
         UNz8hN2OkU9gkQsAtBVjtFdT6/Y3UpOomRR1tpYU47OGKu8pOxNrlY4vOuoQBBJ7wrhi
         t+AbD9GAZIpsKTn0CzQmEpqV3W/OXQqH1dicSO4lRkfdBgGcSaY+UINDEK/7IUE2CAvY
         UBfWMbAZGAIe9iVQfqTwXe/zOdm2HiMfxVECv0sS5OnrFq6GCrywWDbvEfgxQnwFY0JW
         bYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411401; x=1708016201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8t0FBFklbSa0WOTXDvtT6VC4NjI42Dj2ELNDWg0GmQ=;
        b=n1/r6vPqp2HNEgCx9HI/1ycakJobu0MAaSVlMYChfVhLf/2YMhkmTHYuLg95/3J3Qi
         LX498IxbhMeai6HLR9421Ofc/2LT0BB3Y9uOUEK87ejAWo6ZM056lLgxmTHiVgcvl20X
         lcMsMakkKP+NgyR6zpR0AcMiAw8NcQI7Ea90bbx0NKML+gJ6vr0q2k3kcAFP1Oqq7IB5
         QxJ1QYMb+V9ab9sA/HjrIaJ57e2+98ui6vQ8YqbQsdybicrSBz0L1QMOYTCYyI/yj7lI
         O8TP7kvVJR0wVCkjA870x4IoStsJgb09eZK7lD/D3XZXiNhZYKa/+v/0ZMAn3SK/EwAk
         Apww==
X-Gm-Message-State: AOJu0YxLe+WLYD2/pXTpm6q/75DXf+gh9TqHRSfN4MWx9CtpI5p7ZmH5
	fHCXBXKhbUX0IAqUXVAZ9cB8eQWBnZxFNXfi9C5FyH+u0rd6o+dDdPwpB+DxDmaVLH5oJw0K7nH
	dVrQ=
X-Google-Smtp-Source: AGHT+IFXf+i4Z+dBTWvotzry4jtwSZ0Wjht4/QovhF5fPD3MVwZDN4yawxdZtf4gtCI4UR4N9Tqu0g==
X-Received: by 2002:a05:6a21:164a:b0:19e:a270:e766 with SMTP id no10-20020a056a21164a00b0019ea270e766mr188091pzb.5.1707411401614;
        Thu, 08 Feb 2024 08:56:41 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id j2-20020a056a00130200b006dd6bb57a2asm3972854pfu.114.2024.02.08.08.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:56:41 -0800 (PST)
Date: Thu, 8 Feb 2024 08:56:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ll_map: Fix descriptor leak in ll_link_get()
Message-ID: <20240208085639.65d037ee@hermes.local>
In-Reply-To: <20240207203239.10851-1-maks.mishinFZ@gmail.com>
References: <20240207203239.10851-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 23:32:39 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Found by RASU JSC
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  lib/ll_map.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/ll_map.c b/lib/ll_map.c
> index 8970c20f..711708a5 100644
> --- a/lib/ll_map.c
> +++ b/lib/ll_map.c
> @@ -278,8 +278,10 @@ static int ll_link_get(const char *name, int index)
>  	struct nlmsghdr *answer;
>  	int rc = 0;
>  
> -	if (rtnl_open(&rth, 0) < 0)
> +	if (rtnl_open(&rth, 0) < 0) {
> +		rtnl_close(&rth);
>  		return 0;
> +	}
>  
>  	addattr32(&req.n, sizeof(req), IFLA_EXT_MASK, filt_mask);
>  	if (name)


Same as previous patch.

This doesn't make sense, the error path in rtnl_open cleans up
itself. Do you have a reproducer or is this just some static analyzer?

