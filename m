Return-Path: <netdev+bounces-90549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43D8AE73F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D578B24956
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E301332B0;
	Tue, 23 Apr 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0n0mWsT3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5F12E1EF
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877242; cv=none; b=NrdZ0Z6/Jf2tarIXFdurpGABJsoxfEovRyoznVF9EHQDHmrZN+AMO5y2aws3wi0QWT8q61Qb4KR3RqnpZRNGNgPKoB/Aek6wjkJvvHpzMr1hXSAAw0Ef+2vrla3bCSops3Ut5+vIRJlKjphg+7GbD1AedTrv03exMQWvUK578HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877242; c=relaxed/simple;
	bh=4e7Ivdpi73R3Asy+T6McJ5iLTyYu7ntCldm1visSE8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzuOMjg+3J1YCU70PSfrmHs5EphI6gfM1wEYQT1YIZWtfZIs7pif9XPpM1yj0YoTKrFh5x6xFfq8ayW3vr3yU22PZPem554I12XJ/0RwUKbAF2cWs1yAhhh3CRCaCyhMUWF89D8WUsX5SF+wmwsuNW42gs4WE6f9SvZ8E4yx+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0n0mWsT3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5224dfa9adso958226566b.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877238; x=1714482038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1oFlPWufm1X1dwJhs2vlGqs0Y4h+ING71TAYMDei7Y=;
        b=0n0mWsT34qHuFrfLn97QHtS99MuGeYCiS3cGryFN4IcnIWKbNpWtcRfMJDMy11Tref
         p12sWclr74HIBlbZXMZDiOBuqsBNSSV/PAogmUsJvADuTr99fe7WpJh8FV0iiJ0ADb9G
         2fG3RzvNaSdqpdA1KlSmIP62CSShHgbrQmVkPoFTEFtLkwFMUFHXXdT3+SkzM7iZ7XW9
         HB0jMfC0Tb5yx25BdRnroFifFZZ5sxJAF1WUU1T7ZxarMmi4tMF/gtlNSacA/T7ukTxH
         UMQujYY+JuiFyP0G2Dy/Zo+IvWZT1cyBD051dg6+d7x9n6MJnNfpDiqmhHw0u0k3PcfF
         GhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877238; x=1714482038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1oFlPWufm1X1dwJhs2vlGqs0Y4h+ING71TAYMDei7Y=;
        b=YPAMwEkULFYyLe5Ehs7/9uvH5+80OlIMRF7HmPmx9ZTg5Rds1+UXtW3PLMb97zQOav
         pNX5M6UviPKKEyMHt8Qu8DQU2oEWeYLSrD8MfxhKRfjLzhYIQGSVmpVbAkOXrBo275CS
         bzbPkvXRTqJKMI4U5n4CUTle/FGWWkVyY/t7klVfsD2OiwmtUUumLE/VImM8mhRwQXPv
         h7Eba6lejPFNup0sEn6xvyUJqYYgWtGNJ+jdzuXRvYnpstlMtMhStDL+xoP5UGH9lLKX
         rM7E2zyhewVK9GadvcTbZGcCu2Fp7M4hOtaXEc1BQ3bv7s+xjVyXAlAN5F5n3848Q7MV
         KO+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQhZxTYVM7IF6RXbrSszNegKJl1p9qTVHvXRsKdn93vzboaM5Hb9KxDRhP7cHzxFJDYyG4tpK3CUM7aarU9LgJEPe3yaxM
X-Gm-Message-State: AOJu0Yw5Wo95KV6ShOcV0DxXQFaH2CHuALf6YNwcr2yZo66/v/I1G6Yw
	oFxKQYmEqQNxJOt/ECg75cxYOSO8UL5Fjooj83uP8jcGYX28NV20QAPgq1tULUI=
X-Google-Smtp-Source: AGHT+IFGfrgbOkBF5CWSNErHIsEj4PSOJnsTMrDwXT/jVh4LIfzm4gFC1LPhNya0L7f3WIr/ItidXQ==
X-Received: by 2002:a17:906:eb4f:b0:a55:8631:b673 with SMTP id mc15-20020a170906eb4f00b00a558631b673mr2908473ejb.8.1713877237574;
        Tue, 23 Apr 2024 06:00:37 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id gr13-20020a170906e2cd00b00a4e696e613esm1843076ejb.153.2024.04.23.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:00:37 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:00:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 7/7] net: hns3: fix kernel crash when devlink reload
 during vf initialization
Message-ID: <Ziew8wLJ180m9PR6@nanopsycho>
References: <20240422134327.3160587-1-shaojijie@huawei.com>
 <20240422134327.3160587-8-shaojijie@huawei.com>
 <ZiZx0E5NlSL7nuLE@nanopsycho>
 <2ada3cd6-ed7d-432f-8aa4-cbeafa820590@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ada3cd6-ed7d-432f-8aa4-cbeafa820590@huawei.com>

Tue, Apr 23, 2024 at 01:51:21PM CEST, shaojijie@huawei.com wrote:
>
>on 2024/4/22 22:18, Jiri Pirko wrote:
>> Mon, Apr 22, 2024 at 03:43:27PM CEST,shaojijie@huawei.com  wrote:
>> > From: Yonglong Liu<liuyonglong@huawei.com>
>> > 
>> > The devlink reload process will access the hardware resources,
>> > but the register operation is done before the hardware is initialized.
>> > So, processing the devlink reload during initialization may lead to kernel
>> > crash. This patch fixes this by taking devl_lock during initialization.
>> > 
>> > Fixes: cd6242991d2e ("net: hns3: add support for registering devlink for VF")
>> > Signed-off-by: Yonglong Liu<liuyonglong@huawei.com>
>> > Signed-off-by: Jijie Shao<shaojijie@huawei.com>
>> > ---
>> > drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++++
>> > 1 file changed, 4 insertions(+)
>> > 
>> > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>> > index 08db8e84be4e..3ee41943d15f 100644
>> > --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>> > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>> > @@ -2849,6 +2849,8 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
>> > 	if (ret)
>> > 		goto err_devlink_init;
>> > 
>> Hmm, what if reload happens here? I think that you don't fix the issue,
>> rather just narrowing the race window.
>
>Yes the issue still occurs.
>
>> Why don't you rather calle devlink_register at the end of this function?
>
>We intended to fix this issue with minimal changes.

I'm not suggesting anything that would mean the opposite.


>But now it seems that we can only call devlink_register at the end of this function

I don't follow. Is that a question? That is what I suggested.


>
>> Also, parallel to this patch, why don't you register devlink port of
>> flavour "virtual" for this VF?
>
>I'm sorry, I'm not sure what "flavour "virtual"" means?

git grep DEVLINK_PORT_FLAVOUR_VIRTUAL


>And How can we use it? If it is useful, I can send another patch to optimize the code.

Please do.


>
>Tnanks,
>Jijie Shao

