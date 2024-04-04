Return-Path: <netdev+bounces-84664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA318897D20
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8E51C21392
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 00:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67A23CE;
	Thu,  4 Apr 2024 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uOFbL0W4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD61FBEA
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190932; cv=none; b=PizfQcGCkPXXEP9zpWYDySWNZHjqVSUvAEAaP1RkTBsjYs5BNQykza0r+r1+d6JGFh6i2ZDa/RAKtlt0V4vgYFdoG7M40dVxeFdqOpBIyKP/zUky5cCWNwwmqdN4KzHQFLDf96eGnqVhgbIrXMjC2f2aBaE1DBXH4Y5YnWtI1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190932; c=relaxed/simple;
	bh=nKiw/CPKx6o2LR0UgYwRxqjETPGFb8noasaCcBoDM1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgrwH/d9glejAht9bRXpq6xBRTUS7JJm8nbovBn+Kh7Zyl2VBqmEluc4NOlU0Rw0kSPStmNDmHVQHycRQmsGYCyLr0NLF3YYRI4hD3fAMXzxg3IJ6sBvPu3OAjP7lmuqeFZomgHtucZQi2OjKk/CVL0XVOdoJ7Xno4NCZOmkya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uOFbL0W4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e24c889618so3617975ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 17:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1712190929; x=1712795729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5BYJ2ihbbGfecL0vwFwsaHjkVpBpqKPro8LqUxZeFM=;
        b=uOFbL0W4fFj4FQbOFwby8DR5rFXIN1Wmwrxiik//71jdoRPg3/3iaBlxMArO/uXFm1
         uOYqrnbZvR6zlJQlG6fMvOAL0wF7FmuWsra94s6eA/+otU8djQ9UUcxnRD6BZkDaKNJp
         6UkQd1wntQ5SdTYmER1w79+1tsTVj4g73nFUqPelUpmrKEbJ7kyNvwFXs6+a6xSOiHtk
         y0NxPby+3SMBdGRd3bWwkZiXk91ZPYbvMUQSX21/ZqQD26L9Q3K7U8q0S+TnhnhdkKrD
         +ZSkjRxKSPhchKIUP859V0aneddIlPAZdIxNvrg8UD2rZJc6cyNY0RUhq3C0Qlpa1BDj
         5Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712190929; x=1712795729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5BYJ2ihbbGfecL0vwFwsaHjkVpBpqKPro8LqUxZeFM=;
        b=cGXX5EeBcOqlnUUnsguCIQo8Le3taUT6U1enOrxNStCV8nXUAr2AwBl+TxCDNcfGfk
         aFIJYmxyNfqCEdcM+07GzLR4hVdD6uE6ua82VHbxckle+do8R/8UuVqs2F057jfhSrHi
         DQh3Qr79dWo6TWQsW+lmAd/8GwVAibCWk4uTis9KaBna/wLiVVUthZSphQIROk5ZbsEu
         2rbr3rpv1bUtcsgmd32lAxEFeI4bW28LHLirWiduOEaslCRcM0xV39HnDIbWvPbbireb
         OKCdbfnhxD9xcYJI6BoBH8uwv3xr/XCULZeg+9TztyWBrDNzT4uP4snPk9boqM9ZMGfE
         Wy7A==
X-Gm-Message-State: AOJu0YzYuPnHV34TiNOXtFDTiyWWPumEOo1bQW3WjV+l0OwIFoJ+c3HB
	Tr3OfhjWZ9rLhz/4nIoc3amn7o668kGQJlPXekaypv8icw6MCTegiuV1xbiIQQU=
X-Google-Smtp-Source: AGHT+IHBgSB9ENdgsybRIu9fjyoRWsWpqEt9jrdhRHv6GRCRfGEeqoE3tO2Ivj4WAoRR/QE1CBQwkg==
X-Received: by 2002:a17:902:be05:b0:1e2:688e:5972 with SMTP id r5-20020a170902be0500b001e2688e5972mr673410pls.44.1712190929368;
        Wed, 03 Apr 2024 17:35:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709029a0b00b001e2a4004c37sm684394plp.119.2024.04.03.17.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 17:35:29 -0700 (PDT)
Date: Wed, 3 Apr 2024 17:35:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: renmingshuai <renmingshuai@huawei.com>
Cc: <netdev@vger.kernel.org>, <dsahern@gmail.com>, <yanan@huawei.com>,
 <liaichun@huawei.com>
Subject: Re: [PATCH] iplink: add an option to set IFLA_EXT_MASK attribute
Message-ID: <20240403173527.63266cc5@hermes.local>
In-Reply-To: <20240403032021.29899-1-renmingshuai@huawei.com>
References: <20240403032021.29899-1-renmingshuai@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 11:20:21 +0800
renmingshuai <renmingshuai@huawei.com> wrote:

> Kernel has add IFLA_EXT_MASK attribute for indicating that certain
> extended ifinfo values are requested by the user application. The ip
> link show cmd always request VFs extended ifinfo.
> 
> RTM_GETLINK for greater than about 220 VFs truncates IFLA_VFINFO_LIST
> due to the maximum reach of nlattr's nla_len being exceeded.
> As a result, ip link show command only show the truncated VFs info sucn as:
> 
>     #ip link show dev eth0
>     1: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 ...
>         link/ether ...
>         vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff ...
>     Truncated VF list: eth0
> 
> Add an option to set IFLA_EXT_MASK attribute and users can choose to
> show the extended ifinfo or not.
> 
> Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>

Adding a new option with on/off seems like more than is necessary.
If we need an option it should just be one word. Any new filter should
have same conventions as existing filters.  Maybe 'novf'

And it looks like not sending IFLA_EXT_MASK will break the changes
made for the link filter already done for VF's.


