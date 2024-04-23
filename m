Return-Path: <netdev+bounces-90504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C318AE4EE
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84671F215FF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C91474B3;
	Tue, 23 Apr 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YKUl9VbY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A6146599
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872498; cv=none; b=FQJpy0bX6gU9NZNsYeZU4hkwoYTzfcyEkGroVsDYWt4ne5GZdflelTj5YW6i464KjBnnenIbV+jF057PO8DSKmMTvzEfqLnmYoRcYwlHfPxAvEZiNlAQLzSwsa3IRv47m8nNQRewTtb3zST9gTHuqitqmiWsRmdq6ZeCYvrMuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872498; c=relaxed/simple;
	bh=o7jtnaaZQb1r/f6RAGBo+8pRcnyHU296cWvDakaC4ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Se1azYOUxEgAHEVix2H3BGkLkwEOv3gpWdoIkuM1oUvI9yM1xwQRITcRA99UW822rmeDK3mhyzNG33GyrvfOEbN31r3T0fUSDfB+Llx1+Zv/8VNfT7tgkCsn8SRU/dUwdcQEEEd41HjXRXMjh9OVFD5zTecSN0K+ZyuRTDX5jTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YKUl9VbY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so6472481a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713872495; x=1714477295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mXLYXrUpAjVedUSLmTaTBWxXa3hHZnFa+cugnGh7NJk=;
        b=YKUl9VbYL9bRR8u3GTHsQbk+eUwl0rF4CylVN0lTo6W0/PbmLVWZGcf1UDMQeOJUXk
         fvHQR5ld6OFf2kJnB9cQDl8tu20B3Eo/pzGWBZw4lClNxJKYXFbz+KAsIM3YhwY8Qr10
         v6ocn+EQKBt+NNRxVieur2H5OGUOQA98Nn68Dr1kjW/FtrdONxLjAy6KmVTIfm85aF5T
         MYcjf+qlPnJjP/D5QbzpFbIxuOnJpQcaabGeArdNNYQj8mvr80+uuHQosdrSoxSv4Ypv
         FPKzGw6qnGwmGHtbIoIOzCdXakailLPq9oisr/AWpJ9GjVBe4swShnXDhVzCKo8mfPU6
         x/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872495; x=1714477295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXLYXrUpAjVedUSLmTaTBWxXa3hHZnFa+cugnGh7NJk=;
        b=CD0NpwyLaCBTrA72NorddHcJVPikeIO3ZT9XG1KN+6Qa/4LrCBmtXm7bszuCGJkb2I
         fVEsnOGJVstAOOk7bjmdbaaRAZzTnTn/rtesJ+3DblOJPM1HXzguPFkrHIWGX2lcNTmH
         AVWohXu2bBr28HN/4yK+U6rx+9/oam3ZP+FHjZphjyS9NOWFT9yfva8ATCZsQjtwrVDS
         H5NQOY9pFiTp8iF+VYlG88YkCKLgI21/IXIx1eJvJ5wbqvyfLbaRJi29h6BrVC7uqDH8
         1eUz67vVqEJQpLYJQpM+KoPfB6qtMApYfg/QHLekAINmGkRmH+A7iRSMpU0hFscmVtio
         Le6w==
X-Gm-Message-State: AOJu0YzLRoWBBf9gPwvteGhTzaSW943J5F7euVkVQCJh10MCbMxthIOY
	9K8bkJSYJVZIIm9xyj0jwLtnNfrVCWTwHfjVGFvdicUVkqy9DELExTz74/CsgYI=
X-Google-Smtp-Source: AGHT+IFhaA1kmARPJxTeRlstkK1nqRs/gRPgZWIEaW1ixRV0N7idvFvHrLG6ZvtgY2x9kn8Dc4PBcQ==
X-Received: by 2002:a50:d4d9:0:b0:56e:2452:f864 with SMTP id e25-20020a50d4d9000000b0056e2452f864mr9252273edj.35.1713872494688;
        Tue, 23 Apr 2024 04:41:34 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id c7-20020a0564021f8700b0057000ecadb0sm6605526edc.8.2024.04.23.04.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:41:33 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:41:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: sfp: enhance quirk for Fibrestore
 2.5G copper SFP module
Message-ID: <ZieebbTQ0FP0yiXx@nanopsycho>
References: <20240423085039.26957-1-kabel@kernel.org>
 <20240423085039.26957-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423085039.26957-2-kabel@kernel.org>

Tue, Apr 23, 2024 at 10:50:39AM CEST, kabel@kernel.org wrote:
>Enhance the quirk for Fibrestore 2.5G copper SFP module. The original
>commit e27aca3760c0 ("net: sfp: add quirk for FS's 2.5G copper SFP")
>introducing the quirk says that the PHY is inaccessible, but that is
>not true.
>
>The module uses Rollball protocol to talk to the PHY, and needs a 4
>second wait before probing it, same as FS 10G module.
>
>The PHY inside the module is Realtek RTL8221B-VB-CG PHY. The realtek
>driver recently gained support to set it up via clause 45 accesses.
>
>Signed-off-by: Marek Behún <kabel@kernel.org>
>---
>This patch depends on realtek driver changes merged in
>  c31bd5b6ff6f ("Merge branch 'rtl8226b-serdes-switching'")
>which are currently only in net-next.

I don't follow. You are targetting net-next (by patch subject), what's
the point of this comment?

Otherwise looks ok to me.
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

