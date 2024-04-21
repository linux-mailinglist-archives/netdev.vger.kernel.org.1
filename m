Return-Path: <netdev+bounces-89850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291838ABE69
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 04:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD7E2813C5
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 02:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE63E4414;
	Sun, 21 Apr 2024 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ9xVpvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861D1843
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713666500; cv=none; b=cqsWracRSsoNbcUHfoOiu3YBXVeULHPqL/GNYOfPx8c4HFnNpisopX8de0Z/XAB5kYoPGg9iD2OLdCDUTbReO/XwgrMhag456ky2qCk+x/wmTcjDkfIM6Ztg/OqbqUJ3VA9wHQ9QR28IBpzJtAcVrQCQySlLAlTmq3AAkkOtDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713666500; c=relaxed/simple;
	bh=YfwUz66wLrXJwsqOmnc7aDVn2c4IlpPgnRLzR8zFgO0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=twN2/uST9o2lSR/57lBiAyJtTSbJUVD7+FvCZCtAkmKwkj5jvh9RbmpXfea8EK0CSPXzVnC2dAq15I4SZH0hOXnmittGHCwAm0XTIVD16/leBfGdGBF8Y08qL0gk7ZBh0i1trhDZtJTuvCJIMZ1yulUEjoLEtA3/D+GsreUF9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ9xVpvq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ab48c11534so383552a91.2
        for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 19:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713666498; x=1714271298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrkcjfHq5FDArvRDFJWkdgX6F7QuVxKXtA5oim+lSH0=;
        b=mJ9xVpvqPlWAmwTUrAzFtSrwKFME1vzmj4gexT4s7mq68j29K5YlI5ev0fiIyF54/o
         MsU1qtCRjRMwOYQdNQLhPMkWlbYef6d6T4KbY/jyV6BN2mNPmhVJHIpJK4rne8lcM96O
         lueQ2OXkB6gV3O0Tuu2JzXVHFP66ZmaohE/D3P5JOWWPx43Vxkj2IVrcVAil6d21ADNR
         invCVjvORhqt/enmWYjiX9sEIX9mvLeO5EtgdhVw7A1YiI+x628YTCBafvoxsYEJq36R
         0stPmTEA53YvAlnEwLOdMcHL4jx9tBUF+sZF6mJk+8LVIdRwp1BzqDVIz0gK/jKZ9uXF
         lHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713666498; x=1714271298;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rrkcjfHq5FDArvRDFJWkdgX6F7QuVxKXtA5oim+lSH0=;
        b=R1XXByGuK+zt2NycBJexhsN2UycFtIoBGFMfPyFGi4NHK316GUMAKwXam69POZyg91
         XBjNzK+R91j8ZwmMMCpxv44/XKN/yZya0S6zvWSD2mjTHJK2Ez/Td+ciAAPMbg91r1mN
         QFHBXgJ9FYrWKVHMbos3egCN3iUNh+fVqOSsaeg9ErUgsKuuu3ntsBGb+iImdQRnRcvV
         x+t5FL/OcCaPEi7aTFgRN1GBPeEzstOPtCHOeSjVzDfOI0u2tti/Vs0C+7vPStxn9cwy
         NnePxhKKurD6nNrbJKLVM39TwZR/D0/qcE9PjS7TnWmCbVXctj2eiT/UYFzCryGl8KPp
         qSmw==
X-Forwarded-Encrypted: i=1; AJvYcCWrmknMytZ9P2LTBC+lWpwKVlIDkiEN2ksc6hAp4hvEHLZy0+t4OPHkrRS1NqTO7GbIRsfuDG41qsNkXk0YiN78EbNbOeVx
X-Gm-Message-State: AOJu0YymmeSMF+AatLIARtrZ5j2pUekpgWk3qIbpD2DvrGdfJIsuDpW6
	nUnuGYv3zg42geQNZw8t78AnGA0LQ/PcuITOIWp3Xdv6XbWyBjfm
X-Google-Smtp-Source: AGHT+IFyYunDm2iwKpvsvTgBmlu1e36eJZ79yuaoykfYPhP9M2sh+qQZBy6hwbHWha2gNJNMLcvM2A==
X-Received: by 2002:a17:903:1106:b0:1e0:99b2:8a91 with SMTP id n6-20020a170903110600b001e099b28a91mr7213328plh.4.1713666498570;
        Sat, 20 Apr 2024 19:28:18 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001e3e0aa9776sm5628755plh.27.2024.04.20.19.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 19:28:18 -0700 (PDT)
Date: Sun, 21 Apr 2024 11:28:15 +0900 (JST)
Message-Id: <20240421.112815.1606766607054243425.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/5] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <6c6af0a9-4113-4408-8a3c-dd95a5410d07@lunn.ch>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
	<20240415104352.4685-2-fujita.tomonori@gmail.com>
	<6c6af0a9-4113-4408-8a3c-dd95a5410d07@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 15 Apr 2024 16:24:37 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +#include "tn40.h"
>> +
>> +static int bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
> The name space prefix generally has something to do with the driver
> name. What does bdx have to do with Tehuti Network TN40xx?

Not sure. Tehuti TN30xx driver also uses bdx_ prefix. I'll use tn40_
prefix in v2.

