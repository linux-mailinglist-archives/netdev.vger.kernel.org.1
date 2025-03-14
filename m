Return-Path: <netdev+bounces-174841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A01A60F24
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097D617DF05
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56801F1312;
	Fri, 14 Mar 2025 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CEQmxLyc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EE1DC9B3
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948714; cv=none; b=ZHvPcsE77eu5CK27M6Rr47sgq8pLgpRrU6C2xyBZgWCxPJfLzxLZNOkbtxl5fjHyiV1teNBTjvYo4OgUXsENua5VTb6PuqX2xdIBSwuzG+GOyJbjwV+7uT58JhLMcdlctpgrQkhXs+QE8wdkXeXGmnoJfN93qWoTK0IH6dEelNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948714; c=relaxed/simple;
	bh=k/sk7VJfX+xc/DR6Xfyqsjt/6QLxyzLhgdh8tAXS6UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsSQnKdLWv2OXY9gYkk+YmHcxBYpHFjqSWJMrVK5TEcqFMZdQyEp5aP611alyv8KyZjflmhibLbsj1lx/xvjeklbi2Xy2DdbC2pTruYmpayTK26hI7mFOfLp6oxIDcYUh+oyEn4x1EKiNuEqLcS7AKtM/O4k1w+7D35ZKMV6aPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=CEQmxLyc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso3504479a12.3
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741948711; x=1742553511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQa/B6nt3kgsdbkom5ifeTDrO/y61K0MNXroRuAN/O0=;
        b=CEQmxLycabiOTYUqRiH2rKdGns/zC67XXrVSCZfGJWJ3rjYnN3HOs7HIpk2pJ2Pydv
         YnBGT/9rPTgqfirDw5FXFjGG4STanvDOxwVdtiMZmlaT/u0wb9o+RBWwnU79kxEa9fuK
         Isww0ZjtyBs8K4VX0tVYOoZg1NSyGZTcs8zG2y8DU/Nvn52AmXTFap4yZcX/zzo1/vgV
         zD5We6oyyzxUttSFIH6bAhd/C7w7lxOAnvtlKa6Sd+sqoA6crDVxNskUb6taqMbJ4cZz
         cvvXwLthnbhrraoYUZQSE3RqrmhWUreXpNEp9c85GYMC3JUuIqB4JZNeosdtT1nD3+dl
         qZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948711; x=1742553511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQa/B6nt3kgsdbkom5ifeTDrO/y61K0MNXroRuAN/O0=;
        b=h7zf3+upK5ZVAKkuS/a/BlYowu8hm87Hnbhg2faI0E2pEd5qqdGwEEaDDq9/MSqf3G
         0Ptk5IaSd+vjTjgk5R2AmDU7Ubc4JayNuS16PN72L8QHla0bE2ZdSwgXmQgxJ/FHU5tQ
         8ZW5N2pKwFlBwvL7MLsFz569K6KaK3eq6YvvRd2HGlGyi3jsg1wOSIhMakQ1MIhb67T9
         TxDGsdDtFTcMP8zn+ceFDtpDMHonI8UdUQRgv+6/kGOxYEYyMg4P7vYihmTNINrUaYqt
         xbPEpYZtPxscewmXxdUNusCQ1IjwKICzJ2IhZ2IchFbxRh/f0ol/5M3ZmbcyNFjHeaw9
         WnWQ==
X-Gm-Message-State: AOJu0Yz9rIWf2TJZ1Kjo80o65draIXSgq0CvRgNLxcqRft3XmyeYh3RZ
	KCkGcGkSrNW5w3Sy4zdzwvLlYwVIj80JtjlcobNK9sMLPGmTeS9QgVZkvR1l+Oo/CmPyEadXsu3
	uQlML3g==
X-Gm-Gg: ASbGncu+xejYMs7fwUnT8mapXpP0P0PjIU+E8Mr7OmOy28Kf1OnWqWcqtows1S2Lvn7
	MH3LQ+vrsodqC4DvGWLeYsXjK+ImyRUfs6yhlEzfiDMWkB6hLTstFwyByGmbkeYP8UDtdBr60k/
	qF0PLd3hoWi+xL83N9SvvNZPJa54FkxsJey//tFrA2hEVlbkz820gcbLvoD9misUeMRPzpGhGIR
	enzGzUCFh9EEMKnskwkHZWuvUgXgd+fU/zXR0m2OYNd2g9XBKFe+gnVtw1L1thNuAGykV9RwMS9
	x7gSi+ieBs+hOWExkY9eFK8OJ1LiuY1mz6hYPn+L5rfgNbgxpXXiCChP
X-Google-Smtp-Source: AGHT+IFU1yLu9tpv1nnF+kpniJQogZiPcfQZOJlEwm6IcPq3xU0Mz61gTDHjYh2+NgVH8czlWjjktQ==
X-Received: by 2002:a05:6402:26d1:b0:5de:dfd0:9d20 with SMTP id 4fb4d7f45d1cf-5e8a0c1450fmr1961696a12.24.1741948710739;
        Fri, 14 Mar 2025 03:38:30 -0700 (PDT)
Received: from [10.20.7.108] ([195.29.209.20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968ce3sm1818193a12.21.2025.03.14.03.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:38:30 -0700 (PDT)
Message-ID: <22026405-bccc-4b65-a5e1-f565b1257fa9@blackwall.org>
Date: Fri, 14 Mar 2025 12:38:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: update bridge entry
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, idosch@idosch.org, pabeni@redhat.com, kuba@kernel.org,
 bridge@lists.linux.dev, davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>
References: <20250314100631.40999-1-razor@blackwall.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250314100631.40999-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+CC Roopa (sorry, my bad)

On 3/14/25 12:06 PM, Nikolay Aleksandrov wrote:
> Roopa has decided to withdraw as a bridge maintainer and Ido has agreed to
> step up and co-maintain the bridge with me. He has been very helpful in
> bridge patch reviews and has contributed a lot to the bridge over the
> years. Add an entry for Roopa to CREDITS and also add bridge's headers
> to its MAINTAINERS entry.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 

