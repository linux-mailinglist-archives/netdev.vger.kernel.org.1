Return-Path: <netdev+bounces-243652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C151CA4BEE
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D10B7306D516
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EAB2DECA5;
	Thu,  4 Dec 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdlcMULK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA12DC781
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868922; cv=none; b=eVmTwAd1yqoKPb2UlwhzdwQgc9CFDrK0gOwG2ITfJY2pho4JXpYcY7Xuk9ETLwjP4eWBXKgxedey0ZPMZ7QIaERdEwOYWEfJvJn7LDpPc5qLromTHeHSPtfTqQmNPpJGKlYrUrx1mUHe3R+848mPKj4icneHQWghG1MukZAH0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868922; c=relaxed/simple;
	bh=D1LJURvCqBD19tHDb/ZAcUeEQGw9iRvK41XJcVnkOf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmfGCEyMEe6JGwJyJYB/cCnjG8DC7y5FacWrXEGO+A9pX5HHNPSneyvZ98+LosV/eIM3VgJv4IoWBZHLy5Qhrk+yJGxQiN0BuCMkVfaVCTt8d3yr6z45Hq3yg1awDnNVIQ+SwEEHsnKjaSVQc/prfiTL9pWzHPsx4PAbTwFc3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdlcMULK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aad4823079so1139217b3a.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 09:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868919; x=1765473719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJXfDszGjsCT48bZrhFtIknmAdGQdI9xd+KhNwA4Sp8=;
        b=IdlcMULKLoa/0qhG1kUDaIn9fc8R4Y9F1qVIKIy76hYA3gNl+1B70CS0Wttq6e+nK5
         iKpRoAL0RnYrJ0TezAmPE7Ar2qA2SQ/coXRLAr1LWGcpL+M82DedqP81LuL/WTz6Zw3j
         o/wleYEChKYWDDlIMYXFHO+LNak3s4fISubo22wDY72CTTBp1f2NOY4Vwgl8ZFsL0T1d
         re9B4p245pwaL2kBd78c5T3rwzvP5KYGHZ3LNL0AUYShqormGAApDLm4Y+ttNQ+8DPQi
         X8ama5stnsD1/NOgUuJNWgMSf7VTqpm16BcqwQMh42OocGNtL/F8DPJN0LtX7vKvC1Qu
         JW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868919; x=1765473719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJXfDszGjsCT48bZrhFtIknmAdGQdI9xd+KhNwA4Sp8=;
        b=HaI3VnsoE4gH1hWkWl2YhONB/tdTlsWiTfuGW/8Whp+J8lEctsAOAHYFZfcorExokQ
         hXelFbUv/O8PwzKq29Uhz0GwQfYabn4sG/yUuUcdjMD0Wkdg+tp9uzuyPNrt1Z7QUSN9
         fO1G9A45aoa7rZo5EwSQrTAO9sksYiqofWCdZNV9mjGDsTWZ+WqzlaWr5q9yNumRUKgQ
         zK796sW7NeiDcCyzHD+LB8hVlOAuHnw10BdcIvg9i3jXdrGcs6OAbw6RbHOxYm+deHU9
         p7zFTZ0ctcqUX/XcDbAkbsx4ExTEfqfKUNxhg2gmQfVv5MrMRLYXyww9MlD5sxDszUh7
         mTSg==
X-Forwarded-Encrypted: i=1; AJvYcCVkjrxncL2cwPUSuBBMG7HNHwxN0kBW/mmXwT7pNRv+VjjvZ6t+JtGMeiQUeAd3iO665oYRIdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2s7E49A1HLD1cMm6lDVk1SJDLQsZU45BUuGw5ooOXP47BHwu
	YNb2ZGM/argxBolEvFrXlD58FzxIuVRKRO9IBq34axwOS4fC54O7Yk6w
X-Gm-Gg: ASbGncu8ZLwP4n4Vi+NIAMI7rcdJigXlCfQj2eCnBavsa3JMHbHyGubU3TG2scFHD5z
	D2baB9c86jH9BGV4ncYvT40lfW4HkVAIIBCRakb6crJ0KqZhh8whgwUCCQj38PicZCnRlEm5vX5
	2V0+pxpy+CO7+44Clm4YWoSXJa9Il8oX3TJ6n1S8ST1nQgQ2J+C/XK2Sxd7P+qSppx/18c6P0JM
	cXaM3N0s3g5h6eAAmvPtzjFTPlUvg31/GtN0c0X/7btaguyroyHk1+0EeWv9c2I4UD+KuCKW5Ey
	e9rZwLnJKZF8mRGFqEWkyjIgWFC1urmIoUvAG7yiFOgbpWGACRNMdRqPle126L3+P6hcNVqGjvZ
	yKnTLXEgp0yU6u4IsMbDST0KNobDAy6ebwczWIkw5Szbwdn5gbC52M1PSyES0sw7nnjZGmCzccU
	aTX0fUFoZrCwnlsiTVM52Y/7E=
X-Google-Smtp-Source: AGHT+IEZEurfwDNB61dWVp10IYOlyd6SF/U/w/lTzFcqv3k5XiH2udV6gEaIKRdEMzDFljcRgNTaNQ==
X-Received: by 2002:a05:6a20:3d08:b0:34f:7454:b98e with SMTP id adf61e73a8af0-363f5cf427bmr8613133637.4.1764868919140;
        Thu, 04 Dec 2025 09:21:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf681738a29sm2388211a12.3.2025.12.04.09.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:21:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:21:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH 10/13] selftests: net: Work around build error seen with
 -Werror
Message-ID: <7df3f306-1bf3-477e-990b-a76e2c2396ed@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204161729.2448052-11-linux@roeck-us.net>
 <20251204083029.188cd7a0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204083029.188cd7a0@kernel.org>

On Thu, Dec 04, 2025 at 08:30:29AM -0800, Jakub Kicinski wrote:
> On Thu,  4 Dec 2025 08:17:24 -0800 Guenter Roeck wrote:
> > -	write(fd, msg, sizeof(msg));
> > +	if (write(fd, msg, sizeof(msg)))
> > +		;
> 
> At least add an perror here ?

Makes sense. I'll do that in all patches unless someone has a better idea.

Thanks,
Guenter

