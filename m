Return-Path: <netdev+bounces-144610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372989C7EDF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF665B24A37
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB5F18E021;
	Wed, 13 Nov 2024 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhmKYvUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65D18DF72;
	Wed, 13 Nov 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541203; cv=none; b=os2qSXZELvRgc3FtFtFqKU2i6aTXIriWFbwnCS6TODwr4iApQWX45XZmXQrwV27cDfomCnDZExE57mcwijNUjVE/ZnEve8u6Z1IQWNITDjjuZFVixSpbDi9uGZITbaOtfT31vwGGjIM5hXpQp6jsmwUUi05xmTIB6pGv3hrqHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541203; c=relaxed/simple;
	bh=FFJTfE5V4bx71ebziI2pbysq0/XCtc6MklWCpANK65o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqPG9P1ETiEysDNEf+KqiBb6LlVbH3Mr0i8zaDbZmq+48exHfCYuf0FBOtviklMXG+6GPD7D9z0RNMWzUc8FHB40mTgpLQzqhcg54YCRgFG85jNxRehKLFcj/Og4uBPRfxrBrol9IxdfJjbun+mciF5aL/FcgisAgMlaHU3iZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhmKYvUC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720be27db27so73772b3a.2;
        Wed, 13 Nov 2024 15:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731541201; x=1732146001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HI0xxj+KXLswVa6N/SGGXWKpC/g/BZ3ToSfiUhSnzZ4=;
        b=DhmKYvUCkxPCi1aTxf/m7IPER4sEFREaNL/jciiSXHHnaac4WNghLrPQ0JUHMKMdtP
         qLWYj/a3hlA9GQhQ51lUQhWjr1fnhbAos3svim7j9j9P8b1E1UppISmm+JYAu8OT3yU/
         qq0q/4qV9IxWEsdyhjwICUwXQosDHys3d/9xkaNVMG8Cz9usLb5s4gSxPBbo4LQpeisX
         qVTunG5p9BSUyTQfU/zqrKUO/FtJJbf4vQOlA4pLJEDrhz4/wRetBw8VqdMFzXFHQi/5
         AO889eOcbPPDJVREHrxWuVsZYYIWdrHcxVJ6ACTkVyG0HX3Jd+vlMxmF9epDIfwnJOAb
         TxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731541201; x=1732146001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI0xxj+KXLswVa6N/SGGXWKpC/g/BZ3ToSfiUhSnzZ4=;
        b=MO8qAyXBocmM1/eFDIuPfE+C1aVXmbRbPxIqh26xwGmXeQAQE42Wj3N8DYOTAusE8b
         x6JKBVwY9lSAsh6ISStR9wiRmP0JvYuSy8ZM9sVuRUmG4Dd4hqj9ERIWfHxGYWQL9lPN
         liVcimJhJlIMk+CI9lj2DpWSa8kkyuF1eTw5yZwX7p3hE9yQbsZeibVBXIQwTOlLYmPW
         ZQnQrjzteB0GKrzTty85DkfA8HzFt5JiPByyqG9BQoeu+GWHCTl428Ysr27ppkTsZr9+
         xnXo+c0c+Tv8QnQcW9U/OFwoKERz+I2GmVnXy2jlM0PPF50NisuFS/zt5qwH0wUkvFJT
         dbtA==
X-Forwarded-Encrypted: i=1; AJvYcCVSZ/AFa1qduHBOTY8E3HKM+yTMItQirZWu6I+4dOVPpwAGDqSmCODX7+cB7J1Z3dk5J4ygQqJReW/+MvI=@vger.kernel.org, AJvYcCVe9jy74I1Efeq8STJWlfpxvsfHxavXdPOVBih9Uw+tuadlSW9+4sfL0gFDzw5mhicQICKbsbq4@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNAZO1iq+oDcNJmij4u8ZAWH6U9/cuB2pNNfoA9ZQTQKaR9gd
	sTt905SIgMv1BwCSQ5v5SAs6uaKlzwqC9EaL7dtlglBq1xcgfBo=
X-Google-Smtp-Source: AGHT+IE4UgAQEfqRwoJOKPcXTNZvtPXsUgC6Gg5kFMdPr4gitS6EuLyb1P3zvUb2hKwNIBTjuRI+VA==
X-Received: by 2002:a05:6a00:22c7:b0:71e:7674:4cf6 with SMTP id d2e1a72fcca58-7244a516159mr12028632b3a.8.1731541201225;
        Wed, 13 Nov 2024 15:40:01 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f643cddsm11090829a12.54.2024.11.13.15.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:40:00 -0800 (PST)
Date: Wed, 13 Nov 2024 15:40:00 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 2/7] ynl: support render attribute in legacy
 definitions
Message-ID: <ZzU40AtcsZzj7YuG@mini-arch>
References: <20241113181023.2030098-1-sdf@fomichev.me>
 <20241113181023.2030098-3-sdf@fomichev.me>
 <20241113121114.66dbb867@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113121114.66dbb867@kernel.org>

On 11/13, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 10:10:18 -0800 Stanislav Fomichev wrote:
> > To allow omitting some of the attributes in the final generated file.
> > Some of the definitions that seemingly belong to the spec
> > are defined in the ethtool.h. To minimize the amount of churn,
> > skip rendering a similar (and conflicting) definition from the spec.
> 
> Hm, is this mostly for enums and definitions? We have header: for this.
> "header" should tell the codegen that the define is "foreign" and
> should be skipped in uAPI, and in -user codegen we need an include.
> 
> Coincidentally
> 
> make -C tools/net/ynl/ -j
> 
> In file included from ethtool-user.c:9:
> ethtool-user.h:13:10: fatal error: linux/ethetool_netlink_generated.h: No such file or directory
>    13 | #include <linux/ethetool_netlink_generated.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I don't see any existing usage (or maybe I'm looking at the wrong
place), but will spend some time reading the c-gen part. Worst case I
might refresh this thread with more questions.

