Return-Path: <netdev+bounces-96748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C18C7914
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 17:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78001F228B2
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76814D2A8;
	Thu, 16 May 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="A6fUyDEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23CA14B973
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872396; cv=none; b=bw0nktH9XHDGyzglH56a+RTmnv5/lvCtLumLXmnJdlZAJbGJXmHP7ny83MzKam7RYMz8oMFFBIMUaen2dmtjhM5cIrNKiN3qqWHRcclal1Hxj0FqzMDZBGhr8LOCLfAm0Q3abnUJMmuzcxT0CNJfMmG/N6DWtPXEaQrbvcgtiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872396; c=relaxed/simple;
	bh=apMWFyWzDxCIes+oxvQb5FaNJe2ZBqfCD2Bawd4Apms=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ftICmDdDj4iD6aua93/A0fhcnUdyH8MPwg8nLymjwz8gf2ocUgDbVnA7Ud9YVFPqluiO1vWw3a8SQteqD0xdYw9Pk+1fgvLGrzM6C9Y83Z7+OokGwxBTh69qSawSctH1hLXtj8wDfDrxg9NCTWiE88ZDo1IypL9d36Hfxq5aKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=A6fUyDEb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42016c8db2aso32121935e9.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715872393; x=1716477193; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe5Vtdlgyg4X8O20OCekmLHTuiLDo63Hjvcy1VkxkQ8=;
        b=A6fUyDEbjhEZs3gCXlWi2xz9WP7b5MEsckD44elyFrg3mYo9Z9h2e0hVvP0mYPg388
         Qx4d0evESs193xMZgOUROa6xvrGgx4acoiQy8itMuNWgGvHh+y8JszA7rAlvmczH8eHP
         Tyk5VYVO3MuR2aCyPAo/wv+8Oscl0ZruSKMtatAZDa5PBN6Cz31a2tBu/rHQUvzJd0ao
         rrtzmsQLt6aeINbJYa0JU6Mju9dn1MY9E8Js+x43iV+W4OlLpzo+asjK9NvFooKkJRvF
         xO6M7WC6yry3r1OPVBBvNrYLXY17pcax1sGN/QCQOZxEYCokGrASBNc7g8FQpJFN1sdT
         gl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872393; x=1716477193;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pe5Vtdlgyg4X8O20OCekmLHTuiLDo63Hjvcy1VkxkQ8=;
        b=vkSiXct/byA6Buow7hSh8c2yeoyoVPxErjPxg7XbupTlnao1Rpc0aARo6OGB9tNzYY
         hJFF8JUQD0zKASJf1cdnZIMi8lOq4btAlla64sutWS+GCGRvz7JRNSHkWFDxxUhY+S95
         hekAYPd3KFhGPGBTulFZD0tRUxl25ud221D3qYXcBJqVCazLncgV/lCb5qkE8ukUD5Nj
         LqrzjEyGJnrX3je6+POPw2PXKocAMaj2kWsokGv6iW26OpGiPjrxJfimvjn6pV7Ws2bf
         qxT4sfyafu0wFxzuv+NBQKbjoPxJZmettJMg9OSNOwCcRP4Pt9RN3HBcwn2EP36mGkFm
         Svpg==
X-Forwarded-Encrypted: i=1; AJvYcCWVeyuJMKIBgo9kBZA/uQ8ECnoUEtVi9I+adeCbYpBLjDhLjzfr+W05CYgX2ZEQjhhGhGy9fki8I8fXzhEva5mX6of3HA3c
X-Gm-Message-State: AOJu0Yzqone8oeJpP6HkV/5D77X849CizN5EuGIMXI7yF4o5GhIjrKqG
	VeUYgjN1wH3VIKmn3MUjXXFm5pfCkm2QRUS+wICgubjOItLnUNdSWgvoHOCE0Ww=
X-Google-Smtp-Source: AGHT+IFxzcSeFBgqI1jSuNq7sJ8N7L4zmdV8rX1GnpfWMzRCEzXPF9y1c4mAXMbQPylM+6aicZ4Apg==
X-Received: by 2002:a05:600c:45d2:b0:41f:eba9:ced4 with SMTP id 5b1f17b1804b1-41feba9d048mr143258545e9.16.1715872392657;
        Thu, 16 May 2024 08:13:12 -0700 (PDT)
Received: from smtpclient.apple (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce2580sm270540805e9.18.2024.05.16.08.13.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2024 08:13:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] net: smc91x: Fix pointer types
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <b15d7689-0385-4d9c-b5e0-afc525ac9578@lunn.ch>
Date: Thu, 16 May 2024 17:13:00 +0200
Cc: Nicolas Pitre <nico@fluxnic.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <AEF82223-BB2B-4AF0-9732-0F2F605AAEC2@toblux.com>
References: <20240516121142.181934-3-thorsten.blum@toblux.com>
 <b15d7689-0385-4d9c-b5e0-afc525ac9578@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 16. May 2024, at 16:13, Andrew Lunn <andrew@lunn.ch> wrote:
> -#define SMC_PUSH_DATA(lp, p, l) \
>> +#define SMC_PUSH_DATA(lp, p, l) \
>> do { \
>> - if (SMC_32BIT(lp)) { \
>> + void __iomem *__ioaddr = ioaddr; \
> 
> ioaddr is not a parameter passed to this macro.

Yes, most (all?) macros in this file rely on ioaddr being implicitly
defined in the surrounding scope.

> + if (SMC_32BIT(lp)) { \
>> void *__ptr = (p); \
>> int __len = (l); \
>> - void __iomem *__ioaddr = ioaddr; \
>> if (__len >= 2 && (unsigned long)__ptr & 2) { \
>> __len -= 2; \
>> - SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
>> + SMC_outsw(__ioaddr, DATA_REG(lp), __ptr, 1); \
> 
> You probably should use lp->base here, which is passed into this
> macro, and should have the correct type.

ioaddr is lp->base:

	void __iomem *ioaddr = lp->base;

but the type information for ioaddr gets lost across multiple macro
boundaries which is why either __ioaddr or lp->base must be used when
calling the SMC_* macros. Both __ioaddr and lp->base work, but I guess
you prefer lp->base? I'm fine with both.

> @@ -1072,7 +1072,7 @@ static const char * chip_ids[ 16 ] =  {
>> */ \
>> __ptr -= 2; \
>> __len += 2; \
>> - SMC_SET_PTR(lp, \
>> + SMC_SET_PTR(lp, \
>> 2|PTR_READ|PTR_RCV|PTR_AUTOINC); \
>> } \
>> if (SMC_CAN_USE_DATACS && lp->datacs) \
> 
> This is just a whitespace change. Please put that into a different
> patch.

Ok, I'll change this in v2.

Thanks,
Thorsten

