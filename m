Return-Path: <netdev+bounces-57575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C34813714
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035DE1C20A6C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D061FD8;
	Thu, 14 Dec 2023 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ez7aJSHp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B0118
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:57:36 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b714a7835cso70624939f.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702573056; x=1703177856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bF6JAIGkdcWEDAxYfIlQw3OSyrt6nxRKSkcWVcaayZU=;
        b=ez7aJSHpNmVv1H/2VNFP+XRnCwtwjnJuPlbf1RujMYUaS5TwF5i+UNRIG0kGeCIrva
         E9BiVSdjOhuv0m0V3fqlTFbkLAjIN7e4RY1MPfeOiNCCmYJsZNs8jQ+4TBeae32aKCZD
         UljhMivp5KgHETOdFfEWvUogrhyAC0vXh/sEkILqKeKalS5IfnE4yVo4ICVAWmn9r4Gq
         lAhIDibydYmaCd1rPHNETO/INYLBbsOUlTGdAqWHuwVX3ADMbqm6s3p+PTTYLRjlhwNs
         6BBlw9bVdDYlgFbADzocb/SBtRkDmUuuEV947Q1DC0O+IQcC68X4GmhGATOCDaE4a6Ga
         ovCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573056; x=1703177856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF6JAIGkdcWEDAxYfIlQw3OSyrt6nxRKSkcWVcaayZU=;
        b=RPnoo5vN4SyhBzWKBk4kJ0eGzDcdLBvEb+zGOGZHtrPRWyVHrOE5Zd+CsV8T3GCgab
         F3qpwb913pgZ42fHo4EEHprDrxoOgtQ5HYC2+FT+BoidQ9kY+8OYyf5VM/55HQeZ/bpp
         dtO1Z/cxeeJa/1AGNlcDDJesGqMrU49heB4JPbN+g+gMsPNnobspvT56fTyDb+W6TDMJ
         VfE+lRLo6rLSkiGD5JBTSilBH1q6h5hSt1d6MLLnPZ42v0yCxQDm4wtQMFa+l0iYzb6L
         c8tv3mbZ97+zZGNKJUo7GnGSbmSZM3+5np08CFz+D78S5oBvQowI01d7yCQB1HVcLq4Y
         HTtg==
X-Gm-Message-State: AOJu0YySPbTUYsWOttR1hSh4ajtqTI2Y1Si89sZWVIzTopkYD4Hsb/W+
	Dt0UgOTOMf06o+nAccogg2bOQg==
X-Google-Smtp-Source: AGHT+IFlw+XRTrT7e71YKSTcDQk//pRdpkg0t26kRH8ZiJIsDpZhk7PFQa8ipkgdwGtQW7W2DeCpYw==
X-Received: by 2002:a05:6e02:1bac:b0:35f:692e:2049 with SMTP id n12-20020a056e021bac00b0035f692e2049mr8161692ili.2.1702573055728;
        Thu, 14 Dec 2023 08:57:35 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bn14-20020a056e02338e00b00357ca1ed25esm1231116ilb.80.2023.12.14.08.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 08:57:35 -0800 (PST)
Message-ID: <3d025aeb-7766-4148-b2fd-01ec3653b4a7@kernel.dk>
Date: Thu, 14 Dec 2023 09:57:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
To: Christian Brauner <brauner@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Tony Lu <tonylu@linux.alibaba.com>,
 Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>,
 Karsten Graul <kgraul@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local> <20231213162854.4acfbd9f@kernel.org>
 <20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/23 3:50 AM, Christian Brauner wrote:
>> Let's figure that out before we get another repost.
> 
> I'm just waiting for Jens to review it as he had comments on this
> before.

Well, I do wish the CC list had been setup a bit more deliberately.
Especially as this is a resend, and I didn't even know about any of this
before Christian pointed me this way the other day.

Checking lore, I can't even see all the patches. So while it may be
annoying, I do think it may be a good idea to resend the series so I can
take a closer look as well. I do think it's interesting and I'd love to
have it work in a non-blocking fashion, both solving the issue of splice
holding the pipe lock while doing IO, and also then being able to
eliminate the pipe_clear_nowait() hack hopefully.

-- 
Jens Axboe


