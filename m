Return-Path: <netdev+bounces-100632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFD68FB664
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C701C20A2B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E213C818;
	Tue,  4 Jun 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvAJiDTT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424163BB24
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513192; cv=none; b=B/KiIujIBjyBw/QttRsGBFtQuwT83+u7shxFTTBGzjbYMZ4NJESbkSWXUquGEFhQaUfDXgLAaV0ynZkncYLH0Xq1u/EfxwCLxctzdyCOVdI/5q6x3SZEKx1CXFzG8uTDQa0sykhGZcZQ0OdFYUnFehiiKxc7qljO3tE37qfp5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513192; c=relaxed/simple;
	bh=BMAv/YMqZtKZzCQGK+N97pyWvgDS+gYmBiSlOwVYBD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P24JpjG65ZMegOY36qlqfF18+AJ+6zSugc12OcJ80ftuRryK1IDuLJ2E+XG+VQLIaDVYCtCfUom343FgbbYnw4WG+DrMLiqOP7Iyhd0H/9yzdqnsvIQ7MLqA0y8X1JE94IiecMWSno8yzDfO/+Fiyhtd//GOMrZymwX1OEXoD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvAJiDTT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f61c2c689eso1283245ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717513190; x=1718117990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLMbitsUm4ZH7+T2Ub/EbG4eW8PxZ7iLk7p423BQbxE=;
        b=XvAJiDTTo6jioonBspGdeEHPij1eLkzY8SPa6dQSeNi/DCQB1QMdBv890VQv+ACaHT
         9GtsTleBJRuD1ehCnJQJsZ7uQdBQcUsc0u31u/AXy5c/OfeFH0snv19Qz7L09WUqt8ex
         tGHPP0lAK4BIOIpE6C6DK+Yb58SNNi96VVdWtW7kwAatSTUG+Oqh60Libj2N8Bbo3mC+
         E0YiqhXXkRsiphxkxUBc5TmuDEDTU6Vt9/m7xYKb3PCfRwSvKDkt+tam2Tsz3tYdDsh6
         +US/VhpJhyVVm3NOYN657QEnodE6nUC6P6V0EPXTyeJgnijG2fY0+XzAtY0PvGqbUXjN
         9qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513190; x=1718117990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLMbitsUm4ZH7+T2Ub/EbG4eW8PxZ7iLk7p423BQbxE=;
        b=T/f+IZPHX+I7DiU1z4ijUq4tW0oEYv4twyw1yAng6N0aF4yQbI5xaOii+Dagx7k8dV
         0mEB38/SWgNMC/q2PGZ3CkahhV3/YyHsBW+SmdbYv4b0N4px72XSq9CBFr1n17UmPFsv
         hNpiqNPKTVbphwqnYFTB4tmURZQEvr/uR/dQou5iWCY8LciGcWbmOGAF/Yc42+l3yMFf
         ugczlrOKPHtUGXAkitnOOqzxSc1/gdeCrIxG9feteXxK4jg398wv2BCpuOCQOkqqFr2t
         Qj1LnpeHbWv2u71A1OJAxdWKv+qvJSgpW9WRJSj8cFZzG5w40OU5JKM83kWjUvkVg6Ue
         sPuA==
X-Forwarded-Encrypted: i=1; AJvYcCVY6GmIGxSXmTcyQCZ4yVzuEUNBAzPulVa7g/5+9JzC8/V/G4tBInSwQdyhXsc9nwzyjGVfFGwLQCec//lQkekhsWrI+vla
X-Gm-Message-State: AOJu0YwxIxfC2ZOo1r8UkI7OOARuRGth2YaftzcjH3xjaV0vVzjriQtl
	rifVd9fES95rI+FWBESL+s9y87VnWt8FVFfr9CeBWgdB8Opz9jUc16q4xw==
X-Google-Smtp-Source: AGHT+IHUsHxoL+mxlTewp8bfVSOkLyooO40fgK9tkAqRn2hrn9r1tN7nulo/l2ROYrNPbuMZEhUBhA==
X-Received: by 2002:a17:902:e811:b0:1f4:b02d:bb61 with SMTP id d9443c01a7336-1f694042c83mr28225525ad.3.1717513190406;
        Tue, 04 Jun 2024 07:59:50 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241f76fsm84554905ad.307.2024.06.04.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:59:49 -0700 (PDT)
Date: Tue, 4 Jun 2024 07:59:47 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] ptp: Fix error message on failed pin verification
Message-ID: <Zl8r49_F_Ux-TFYQ@hoboy.vegasvil.org>
References: <20240604120555.16643-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604120555.16643-1-karol.kolacinski@intel.com>

On Tue, Jun 04, 2024 at 02:05:27PM +0200, Karol Kolacinski wrote:
> On failed verification of PTP clock pin, error message prints channel
> number instead of pin index after "pin", which is incorrect.
> 
> Fix error message by adding channel number to the message and printing
> pin number instead of channel number.
> 
> Fixes: 6092315dfdec ("ptp: introduce programmable pins.")
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Nice find!

Acked-by: Richard Cochran <richardcochran@gmail.com>

