Return-Path: <netdev+bounces-194509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5D3AC9BA6
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 18:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824D0188DDF1
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAEE155A59;
	Sat, 31 May 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiyWIAlI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABE249E5
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748707917; cv=none; b=QjVLPgmwvUUeMK/wuX5S/aRDRcxzm2VtGmNOCzsj+CeUMphPeQhEjqB9F1cQBqSWKk/5AOP2QtZXRHq1O0zpEWRUS8LMG2RBH3IQQebyRIrBgXkeOdYZW1hr1pEtiBmZ7ojK1BY4+PpCOzSWd6zmmvnYeTpeJ5Kes3jMeYnvFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748707917; c=relaxed/simple;
	bh=i4OOg4gp0pIcy6rYlYnXdVPKXSPRMF0gNQxLPqproWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YN3QwSmCQV70+xvgCvZma7jbxRgRpREOcpUFCJJ066ZBczVYKjdXLIbNwOvEOFpMLxY0rnhEfmjyVIlb4zpGfqFmHc7GV/bv1yg+Co4X5BMBWWK9U+ejI81+LPBuznortaHsPGnoTk/C2QN2BOCv7fDw4pgajhgoAO4MNcAJayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiyWIAlI; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85d9a87660fso289391139f.1
        for <netdev@vger.kernel.org>; Sat, 31 May 2025 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748707914; x=1749312714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dzk+aPb+F+GJhIsvj5QNvIAydu2JqhCFhdsZDhBunAs=;
        b=DiyWIAlIWKcn16WoqCisOSBaJGRWrCISvt6ztxBPlug04XMp8CMYujkiGP2zkgqE6V
         Aailprlvss1X5urQ7+z7F+Bgk9omZIC0ZTLdBZrbBStUhdBpDkbYUomj0B1sVpwdnVtP
         FUiudMxzh8BHCkeOgHKk409QNg4WdEYySNxGvL8GzY2MVf0ZknjOqQqPNDv/YKOdU+CL
         Cw1Gj8dAEGEiiJIWAn1WzBuIe4dlNVITXOv3W0Lt6WAJTWUZxKh+fEs/i2iawMyWCTR3
         XPLjz36j6VtnJ7vlWtwoHctKc8eIkj1Z8WFS7Km3IrqLeFedjBaeYL5P4NWF0If95tb4
         MvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748707914; x=1749312714;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzk+aPb+F+GJhIsvj5QNvIAydu2JqhCFhdsZDhBunAs=;
        b=tLhezphqjSbNGZl8dO7Nka4C0VUZIoKg2MeI9zyCMLm7FuS4xMBdR6B6RXZ8wN8JH7
         FxaaqLlJ7EOU+b/fIpZH7bwiKLBEZPp9XJp8uVtGK11lW7qa188aXZrWyv13osPNfmyI
         ZpSfxxCPUzKJ+ftMsewIeV+xf9cn9mkJ9dT1Rc1CivNZo9aIpaomaNnOaEAVBb2ZkqwR
         2J6c74aHDMY7svcxQ29T6AsGpRu2hDYmYaILaUlOQbMQ7SZuL9PRSZz4NR707zLyWi/8
         U0srz4rXNR9qljyB1KwMuh0HYiO8zQQ3VqOxQEBT3M4ITYz4Gi9KdOswijD9QqKhONJL
         UhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe7h+RtrHUQZfpF74jffpfurd03IlcoRT96ICKRx3LoQRlq8ZnaclhqY2+6xNgAqjM8sT5Kok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/4I6o0+djsIPHYzOhnNOKCnOp8LR0y/gfdTHpSL1ZUmA0lXk
	9XSEc2SlSJ2dFlSTHtdUyjF4pnpmlb1dVBbhn18ACZxT8eaDRUSWFgcj3XXcxw==
X-Gm-Gg: ASbGncspmqsnm4RWPfDpyfkiWvMqvPGf+rRJLrf0j933LaPezzp0NoZ38s/5SB9e2VV
	ady8votggI+VXpq2mKUMrlo5l7ngJu59XVlBO8rnRveFalbwfaHP2FoaIS+PIR1RpNrz2Y74kzc
	oRGe4ZJy8Jo1RQPtq3tuoA6Uz3Ms+TaS27tscS/K9r9W3WtlwENVJrZTesFiXaZ+MkDZgCVJOCx
	O8Y4BPL+eq+KHm1+jOiHo8+KFLUkHfXtzuiLVVcqMWmiPEaR/6Gn42pHXE3rvdEP4+EL/RBCCyK
	BF2TOYTdvGV8oboq4rdGYG/QgiHChY7wj+QmgAJaToIGcsu08iklbDqIQBhXbxGFCXVmpFTTscB
	nzC5PVDA5/hl6eDDJt9qmRcTfbYkQ54o3MBG/Kw==
X-Google-Smtp-Source: AGHT+IFf1FG8OV+/wbVClDNXOibrUXMsTrMMAvVSdDnza1czOy+Om3drVAIHirVzJo1VRqkR2Izmtg==
X-Received: by 2002:a05:6e02:1487:b0:3dc:8b2c:4bc7 with SMTP id e9e14a558f8ab-3dd9c989d54mr57107855ab.1.1748707904084;
        Sat, 31 May 2025 09:11:44 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:8877:7794:991a:57e2? ([2601:282:1e02:1040:8877:7794:991a:57e2])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4fdd7f29e19sm920934173.145.2025.05.31.09.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 May 2025 09:11:43 -0700 (PDT)
Message-ID: <61d68d2b-5792-49bc-ad78-bf48de576e25@gmail.com>
Date: Sat, 31 May 2025 10:11:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip: filter by group before printing
Content-Language: en-US
To: jean.thomas@wifirst.fr, netdev@vger.kernel.org
References: <20250520140248.685712-1-jean.thomas@wifirst.fr>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250520140248.685712-1-jean.thomas@wifirst.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/25 8:02 AM, jean.thomas@wifirst.fr wrote:
> From: Jean Thomas <jean.thomas@wifirst.fr>
> 
> Filter the output using the requested group, if necessary.
> 
> This avoids to print an empty JSON object for each existing item
> not matching the group filter when the --json option is used.
> 
> Before:
> $ ip --json address list group test
> [{},{},{},{},{},{},{},{},{},{},{},{}]
> 
> After:
> $ ip --json address list group test
> []
> 
> Signed-off-by: Jean Thomas <jean.thomas@wifirst.fr>
> ---
>  ip/ipaddress.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
> 

applied to iproute2-next. Thanks



