Return-Path: <netdev+bounces-180657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EB9A820B6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70BE8A018E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B072147F1;
	Wed,  9 Apr 2025 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIIkxP8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AE1DED5C;
	Wed,  9 Apr 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189737; cv=none; b=gIkfh7AkZvJCA+RgXdQKK93Un4tbNyMioPt8nUSpegT72AgOceICEg0OOzm/wbaCewv5jyfIvOfuofnXI+yuJpMdBEVRytLjVrmCxozWMbN50Lc5nIeAX85J6RFv5ygPMX2GYeowGJ9NAIuEQHhiJj/USMhBqVboc5ExjtNliMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189737; c=relaxed/simple;
	bh=Kb/JY4qhpCv665w9G9vLxVho1H4WG4sMNhnQ9Vsg2fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehhHxswmxAcgQjLVO+h+9aIFoBN9ea5JLnsN7S55arDLng9SYTwkgAGbXgMiz2owOQZ6ceDedKysZRR8u+uaIAe2DVDKW2OisGjmcawyF0+Z03YDfm7bPgToJTiZEyRjAX3+Tly4j3aR8iMGuGpwCfYrdQtxQBf6kkTPSCuATE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIIkxP8k; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-549b159c84cso4583710e87.3;
        Wed, 09 Apr 2025 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744189734; x=1744794534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PH0fOBIhSyqFlzxadIjEET6L9k55RRbC7X+MjH8Idj0=;
        b=XIIkxP8k2StAqVK11WYDFSxXjUiCFrZ+GYaGTq5A6V+Lnt4UQqaDpcp5jBy7YiGfm4
         3W9ky9/x1SyuzD6WEdmwA6XT3lcM/Mt6MBc1n21eb4Y/LWQlPMmcNzV7NF1OuhTD7Jnu
         x+ZJUf3Q7fDhzVYCxFxdBZz8HimWsAGYOU971rXwFxxk5IVPpOvQv/E2cWn+vDJpcE/Q
         18Oy36D+I4QyXFJnzMk3bTTMG2o/irSBU7IG0TqHPGsZdNtQU27bHbBBq9sK030WLyoG
         VtOLeHaKDIJDtAqid6MmOp56infN88L0nq/VIJ9ubZ2+y/adtUTsDOhUTyj6CllTFcMb
         cv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744189734; x=1744794534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH0fOBIhSyqFlzxadIjEET6L9k55RRbC7X+MjH8Idj0=;
        b=kV8J3DI4nH5mg+ORwZBt9mtxmwXcTNRYWIn9bO48bYxWvMqsYFUkoItoy0BrZAxTcj
         WX4TZbV6QPfOet4zmWJtc2UcVI8Hg878e/gXllUqh8QqF+S5SOJB4NvHdiiUHwax7dnY
         2aq9Ueg2w8GwlYRc0iqFZZkoPBS12X0edcYmmPWYdxcBo///BLnOvuHDDKYHV3s4J7Uq
         5/shjkMy+6Tgj9tjHKTV4rk17MdhE2bAxcBtNAdvqAZLrKeMNR1fqoJ2OnoDDd5z37LJ
         v2tuQYmU2cYI5YFSmcK3vGbD7bqve7XEDvVz525c6MSrKC5GtHYocXY2q7kSdYRIHW0T
         OR1w==
X-Forwarded-Encrypted: i=1; AJvYcCUB/vpRSCA9WOo5dQSyhJgHVF0mZJqPz02BwfjFwlZ13rHtwwPQpTzK+4QQkZvh8LK8gezG7W6S/4j1rXc=@vger.kernel.org, AJvYcCUpCwfb1wzhxiXZnx5PhUZtxHFOZvqQ2H73542pOBW+LCP+FyrMPnyidwSC3UyQ/3yAbf27juZw@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsjMfc4xe2u5qyM6T9NlGtRMV99IWjjW7M2fF2ChwkxeG5ytx
	qWtH36L5wELM46zzMPebhVJfX6U4Pq2qbms4zPJod6wK9hTSOhiQ
X-Gm-Gg: ASbGncsjCNvgD3yTjrwXARxBlDs1BMgkpUI5ttQTIFea0NQ1nMAUxFtJDL1ZXgu6pBw
	dqcmKb8AUPVg6GS1j4XhudmVRVHrWy+ZBrZC6fbKYqq5WZKrLBbx8QjS0rOKooOz5DtBYMwJXfW
	1EypeAZwKbjUOsQQl9eAfnkmst3mDgcwRW6YqyPtmOvgwDJWN4Fe6lHeoF0Nrxl5la03DqMIzbv
	LocUe8hYlOj0a6B24eh0zfLp/LmwvquiX9LB7Nuwp4wH/SESBO0bX8ERlhjmOARBwcm4x8aZ3xV
	uG2FAFMQecYCqm77U73V03VNwfpa4Flnh8rvyrz6NauLaL5Py7/MgYI=
X-Google-Smtp-Source: AGHT+IHGw2aTTap+T9CAlwkD0MyXWE65mmw5jUheOCdePumyfAqqxxXqqQnQ0rLLTKRcswO0jG8IUA==
X-Received: by 2002:a05:6512:32cb:b0:54a:cc75:3d81 with SMTP id 2adb3069b0e04-54c444b3571mr587091e87.4.1744189733354;
        Wed, 09 Apr 2025 02:08:53 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c4565ee3asm82678e87.126.2025.04.09.02.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:08:53 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 53998nTC028385;
	Wed, 9 Apr 2025 12:08:50 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 53998mj3028382;
	Wed, 9 Apr 2025 12:08:48 +0300
Date: Wed, 9 Apr 2025 12:08:47 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Cc: Sam Mendoza-Jonas <sam@mendozajonas.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, akozlov@meta.com
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
Message-ID: <Z/Y5HxdJfZss/GiF@home.paul.comp>
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
 <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>
 <Z/VqQVGI6oP5oEzB@home.paul.comp>
 <1d570fb8-1da0-4aa6-99f5-052adf559091@gmail.com>
 <Z/V2pCKe8N6Uxa0O@home.paul.comp>
 <b1d373d7-77e5-4341-a685-07a617935db5@gmail.com>
 <Z/WkmPcCJ0e2go97@home.paul.comp>
 <93ac7481-43c0-4207-8965-2d793c90263c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ac7481-43c0-4207-8965-2d793c90263c@gmail.com>

On Tue, Apr 08, 2025 at 04:23:43PM -0700, Hari Kalavakunta wrote:
> On 4/8/2025 3:35 PM, Paul Fertser wrote:
> > Thank you for doing the right thing! Looking forward to your updated
> > patch (please do not forget to consider __be64 for the fields).
> 
> I had not previously considered using __be64 for the struct
> ncsi_rsp_gcps_pkt, as it is an interface structure. I would like to seek
> your input on whether it is a good idea to use __be64 for interface
> messages. In my experience, I haven't come across implementations that
> utilize __be64. I am unsure about the portability of this approach,
> particularly with regards to the Management Controller (MC).

I do not see why not[0][1]. What makes MC special, do you imply it
doesn't have be64_to_cpu() (be64_to_cpup() for unaligned data) or
what? If the values you get from hardware are indeed 64-bit BE clearly
open-coding conversions from them is suboptimal.

[0] https://elixir.bootlin.com/linux/v6.13.7/A/ident/__be64
[1] https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h#L155

