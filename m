Return-Path: <netdev+bounces-63731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A366582F148
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 16:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4128B1F246B2
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002DC1BF51;
	Tue, 16 Jan 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gYsUl949"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D081BF4C
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6db05618c1fso7233008b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 07:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705418396; x=1706023196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAR5OCR7VVmVOA9xP+QBk0F9kMMvK4Rl/rRQgYb/Y/g=;
        b=gYsUl949fAZs/FUGcUh4kKBh/f7UCEPznK5R7gsks9CyTgW4cr1ULzbLjed/xYOwPX
         pO+udQknpO5kh0r/FTmNLdqmNh/PVxKZ36gZhn0HHXsY5j6GMsmEhZsXM0rclgDlAFOj
         57+OT/Chl3WF645LdCDCbLJ9qbudDVrjzFqto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418396; x=1706023196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAR5OCR7VVmVOA9xP+QBk0F9kMMvK4Rl/rRQgYb/Y/g=;
        b=AFvOMiKSnJu7mYsvASgaAk7/5wkjBzt0HKrGpYZpaq6mornmk/OdjmRmgMK30gvpDi
         RIN52iMJt/dP9+bgnzKp77y5jz4GSslBkDjT0DcGCZkZIGB9qVzdo/pyW7brMMyEqSjt
         i/y91eMEL5FoEnMc93IZ3mr9LiqNvOiemXSWkaP5eA0cBmQpNyZw/M+8+I0iCbmuvoMO
         CWiXjqZWEanJ8qT2mEI0kOIcWef9Aq0F+46hIkCbABXRXw73RbsPVWAolAyHJmyQjgte
         FPx+ITaPOBWPACWt45TDh2tTf/I4QwowCF7XeViadWPwViEFBBGEEKDx8UA/mFVBWYEB
         lnXg==
X-Gm-Message-State: AOJu0Yy8VquTTRmV1zS3ZD0xa4FzGe5wpVAFIyMlsDqdDXFDVgVXTrrJ
	q7K3vuJRZYR0PCmBOJ1n9QS6sQqSKXbh
X-Google-Smtp-Source: AGHT+IFVX3BC+BDHIH0Vec/KHk8hXT3W2pcVPYxE8901owm0F+Ufil1cSyCMXggp3yKG0jzk3R/FAg==
X-Received: by 2002:a05:6a21:9189:b0:19a:daab:5409 with SMTP id tp9-20020a056a21918900b0019adaab5409mr5231717pzb.29.1705418395820;
        Tue, 16 Jan 2024 07:19:55 -0800 (PST)
Received: from C02YVCJELVCG ([136.54.24.230])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902b59400b001d052d1aaf2sm9376097pls.101.2024.01.16.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:19:55 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Tue, 16 Jan 2024 10:19:47 -0500
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jan 16th
Message-ID: <Zaaek6U6DnVUk5OM@C02YVCJELVCG>
References: <20240115175440.09839b84@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115175440.09839b84@kernel.org>

On Mon, Jan 15, 2024 at 05:54:40PM -0800, Jakub Kicinski wrote:
> Hi,
> 
> The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
> 
> There's a minor CI update. Please suggest other topics.
> 

I would like to discuss a process question for posting a fix to a stable kernel
that isn't needed in the latest upstream as it was fixed another way.

This is related to this thread:

https://lore.kernel.org/linux-patches/ZZQqGtYqN3X9EuWo@C02YVCJELVCG.dhcp.broadcom.net/

Thanks.

