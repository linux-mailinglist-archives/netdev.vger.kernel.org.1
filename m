Return-Path: <netdev+bounces-109295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3C3927C4B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21881C232C9
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998A23308A;
	Thu,  4 Jul 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBaWPe5q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BCD39FC1;
	Thu,  4 Jul 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114265; cv=none; b=WHwOtB5qFb/sx86fJXIzNOkUb8uYhJHOe74gRjLTIaAQQrkzqw5MFz1Ol7CNw1zwUsRNa0hhz0Bn6ZQhuGg//EKqOMjjZGhUo+2qw3Tf+ckUQp6OhqUWXBIcAxejvaKl+2aDC3dkXvsiw3J1du6ydchr1azsixpK0kQQhXGcqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114265; c=relaxed/simple;
	bh=5q3oFEDz4T0LTndDItlwbE6guKzk7uRcqqE/O5P9rr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwEio4LNkbsXbId62lYUG+Li40iIMf+Bx7FK1pks3B71UlCfSLmJe56oce8wDQm7hTfq9o77ksfqUdLZ49IKW6/4iYDGLzLTEakShCLHuQulkne2ntUFOKKwlCwpFAJ3YrBW37ZfPrgT5KKvqvQmeyFN8Pcl8AMkrc/VEyFYoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBaWPe5q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424ad289912so5765225e9.2;
        Thu, 04 Jul 2024 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114262; x=1720719062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYKKIXRdbbmGJon/YAloljtCFlU8QSWfBTdly5sHuPA=;
        b=iBaWPe5qu8BMbtvpRcDgAXOPEd5S0ah0B5HELVdk6cJnHXoQr4VtpWWoJsuew166Ck
         W9DpRqzYezpKAvf3rIUSSWDu4aGH6S/xBwHacDw5BmaR6Lg+lpcQQipUqfS8y9Kj7veb
         PukbpSgkmsMFTIL2WCu5nO9ctr+0YrHZOICUfprugoXZnXrcm6U7H72TJkwYS1/HXzr9
         TFfFO/bfX1W3UVSJKcrIf2BmUTrs+gFPTd7uhApUocwOjGWmCnldd7SLOKlq+0lebriy
         ewRnGUAudP5dIICr5XBFQ/e4qK1G3CEdzZRK1L37kbtRbAd4SHpRE7ezIH20p5mm5Oic
         KV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114262; x=1720719062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYKKIXRdbbmGJon/YAloljtCFlU8QSWfBTdly5sHuPA=;
        b=WvUqtlrip6GxHdkk9zBzSc4y0tzJue9yiQKcGN8NUZQ5kpdcXM7DQNCdrdy6ONneDY
         GYkG+LMcB869CO8k11kFK9aFDKBmlJQjR7DZbvw64hiGTScV6gbrLQGozzcO3Lt2MKM0
         HI/SHXIXAu+jj3OEjD+K/ajRdiagToK9aDH2jk1alM3ddkJEEKJagDbsF6rpinnTkUHG
         MpSROSmLx9G7WeYuDSyMVeA1AQZGuydZSY5mZpYRjoOqbXnPCZrWfvbg/51NFFxcdq1d
         y1g1bdEx8OUU3fgkWTaKHgoya1aZ23ARgPGJfX57NCOlFyh9IvYMziVXoky16gFMBvek
         +xlw==
X-Forwarded-Encrypted: i=1; AJvYcCUaZiDg+Ba7AMC3jYuF8Be5ZdTQOwwPruNDdOlu1HAtZzXSp6uG43ez4D5rsrzChC76G54CxPR7K6IUk5xemNOyV2JcfD5hLeCCOfgeGJOTyCWjzgI8RGNlwznF1XC19DjKh+Pu
X-Gm-Message-State: AOJu0YxFhtiiS1XAHqHMAOVRpZIvYxsvlSj+xJ51OFpvtqqmL1GS282A
	VzkJF5Y/Ylwql0ZNNA2D97P61FM/9BL4hRUZwzhA0tMSqOzDsCcH
X-Google-Smtp-Source: AGHT+IGJDIkmpY8dH1pd2tFP+ZFn3wej+makztEsnHkuSWP1GTxm/rD14/P/wb5nx6ry5UBNExoPmw==
X-Received: by 2002:a05:600c:6d8c:b0:424:acd2:40af with SMTP id 5b1f17b1804b1-4264a3e9bcdmr18068135e9.24.1720114262243;
        Thu, 04 Jul 2024 10:31:02 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d0bd6sm32143175e9.8.2024.07.04.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:31:01 -0700 (PDT)
Date: Thu, 4 Jul 2024 20:30:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] net: dsa: ar9331: constify struct regmap_bus
Message-ID: <20240704173059.u6yk6iujbbxsxmiy@skbuf>
References: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
 <20240703-net-const-regmap-v1-4-ff4aeceda02c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-net-const-regmap-v1-4-ff4aeceda02c@gmail.com>

On Wed, Jul 03, 2024 at 11:46:36PM +0200, Javier Carrasco wrote:
> `ar9331_sw_bus` is not modified and can be declared as const to
> move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

