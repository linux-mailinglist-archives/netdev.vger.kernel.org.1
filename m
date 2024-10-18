Return-Path: <netdev+bounces-136949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDA39A3B7F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68111F25362
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C0A201028;
	Fri, 18 Oct 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1doT+5U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA373168C3F;
	Fri, 18 Oct 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247321; cv=none; b=SYu2s3hcCv9gfuVAVdZ5P7K6JumQSLR3kTEfWnqUJ3Btu0PxeYmu48CPD3MfDfz1ZTK3JtkQI+L5dTrfPG24s4RtW8Yy4SHSsPw5NvkG4a22bTYSNqDNDshFQ9f63gCG07i/XJSL4UufdMjVmKjT/j4tTmdwnjELBWRc9Wu1W6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247321; c=relaxed/simple;
	bh=Z//4XAt7q1H0ZWQcJjtmB5QjSUwihOoJ3FkRPhrQY6s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=rTjpxinuUqCoMUMRwgWfJRJWPlGa98RbaMBDgn9XhoaXo50wubMq5i0kuTBukec4sZ/1SeOGkBMHs8WsVymsKRxQzqr4VAJDjPvtevqTeiHzXMhM6sSiUrACbdughbe1KsM32Cv+Z8mQa/PdWCT4neMHGapyKBm6iI2MY+ODUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1doT+5U; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99cc265e0aso257708966b.3;
        Fri, 18 Oct 2024 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729247318; x=1729852118; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z//4XAt7q1H0ZWQcJjtmB5QjSUwihOoJ3FkRPhrQY6s=;
        b=R1doT+5U8UE7V7w7wOtpMn+O/o0FuiN1P8TEwUwbQpvvYh4Ykp2kbFUPuaEHuOoxq8
         uAjJhGhPjCDhniJsUP8xLEzSiDt0iGK3vjctL60/0k4fQf+/znfR946EFtxHrYOTJHTW
         eOz3klEN80u44HyR8DpdwsgA/pp6AZNZjXJ9bz7zmSaZvLGCsgV18Cv5Z4BepVgZn/aD
         yXtjmKUJbn5yrw3Zs4dJjbdM872hqPAJtW/RzTBfAusDWcY44hokfOnyp7vLEI3bp5md
         hXyN2cXkqqPlB6BQ3tjD6Ildx+gqLHCcJC5OYTP3HvBwV6wQZC6yNALUjRdjQjzbe8UR
         lw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247318; x=1729852118;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z//4XAt7q1H0ZWQcJjtmB5QjSUwihOoJ3FkRPhrQY6s=;
        b=fG9YBdXUxL/7HJFzWhCgnMWz0UwKCO9nUgjIUE08jx6+lFwDTWId2N+urL1ugZTEtG
         m41LC/+oJqa1Cjqoqlk0Q83T9OXDOgb5tvHvOE35Uk2TP8Xq+JFkwTD54F/EKSs1oGuH
         0Ua53MLvG9IqwSUsohtBdlGpO4m3oZL8MEQyUmMwz1JtoaEiGPzu0p0s+2LXJamMNye8
         3Uh7b9QmIHL0WaQKMSn/lPyWmM3GHL0+XBmaQmJ2PWSSWrPmsF+wwvOJtH4LQOQ0stdv
         OiknvYlMDxuf7By0c2AEQ7Xw8e6HyM6cxqekZMABsnG7Sn2cn6MR8trofSK2NfXpimuv
         mAGA==
X-Forwarded-Encrypted: i=1; AJvYcCV5E3pbkU9xcky+zG07Rm8Yh647/5WH+Lw92eDxL6PWSx0b7GdAp/y6ABCa/2k+mUwA38p2Y5WV@vger.kernel.org, AJvYcCW9XJcz/E9sUWwxpIJ8ma2eNyovakENWFGOBHwQgrMl1gdqmNkaraAlr2Rrh3JR8XHq1+o/VIiPuc5XSAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKN6W9Pa2IvwILN9azT4233jiXqzrulVWP5vAYNs1SViaDK0RP
	wBtk7ytkAycHLK1z8W7sqSylndqJZtpOS9XB6lD1nS5OLkJseJDNLVgVhi70
X-Google-Smtp-Source: AGHT+IEGHXDaWFCqJpMXxqWoBf53I6+A/P88xNhVNgQxXBBGrRr8j5Qum3/gpsjswJIJLdgFOe9YJg==
X-Received: by 2002:a17:907:7da5:b0:a99:4aa7:4d6f with SMTP id a640c23a62f3a-a9a6995d6f8mr185730566b.12.1729247317954;
        Fri, 18 Oct 2024 03:28:37 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8040:ab28:8276:f527])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c28347sm75217766b.203.2024.10.18.03.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:28:37 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: michael.chan@broadcom.com,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  pavan.chebbi@broadcom.com,
  mchan@broadcom.com,  jdmason@kudzu.us,  horms@kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  mcarlson@broadcom.com,  benli@broadcom.com,  sbaddipa@broadcom.com,
  linas@austin.ibm.com,  Ramkrishna.Vepa@neterion.com,
  raghavendra.koushik@neterion.com,  wenxiong@us.ibm.com,  jeff@garzik.org,
  vasundhara-v.volam@broadcom.com
Subject: Re: [PATCH] eth: Fix typo 'accelaration'. 'exprienced' and
 'rewritting'
In-Reply-To: <90D42CB167CA0842+20241018021910.31359-1-wangyuli@uniontech.com>
	(wangyuli@uniontech.com's message of "Fri, 18 Oct 2024 10:19:10
	+0800")
Date: Fri, 18 Oct 2024 11:09:32 +0100
Message-ID: <m2o73hbu3n.fsf@gmail.com>
References: <90D42CB167CA0842+20241018021910.31359-1-wangyuli@uniontech.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

WangYuli <wangyuli@uniontech.com> writes:

> There are some spelling mistakes of 'accelaration', 'exprienced' and
> 'rewritting' in comments which should be 'acceleration', 'experienced'
> and 'rewriting'.
>
> Suggested-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/all/20241017162846.GA51712@kernel.org/
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

