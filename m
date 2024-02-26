Return-Path: <netdev+bounces-74991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D4867AB8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB67B29501C
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B412BF39;
	Mon, 26 Feb 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AksM7EtY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15A12BF33
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962571; cv=none; b=pRHzNkmubptaiHEoOuqJbNUkszulG6OFQBTcbrMhkwgZ78xWiIz+zwB0jHxyubzRhHEDExUOrXpqGxlPIYKd+E52acziiBgkVMevTXSlcQjNdfGvIrXcY04TEOCLcvIacUXi5eE5ujoggMg5CvafY0n1WSA7T/Qn4ezV4mb2cTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962571; c=relaxed/simple;
	bh=QuQOhoSKYSA6S6ecyRCikKpWB3gG/2419qaq5K6HK+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/zJZNZrY3wdupWEKyyJMeH/cYjdUSuobSdL8c9a81WpghXe5nYbmvVuPyt6F6z+LS9K9J0ruVXJcdc9OKI2v/tMF6n0GxrxI8hlf45bEUXmGRjrhGTMBhkGcnzqFhcRHidkrLgUFicbkW/aPsTAM8uuVlJ5J7TXr8gBph2KhzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AksM7EtY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412a9457b2eso2731655e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708962568; x=1709567368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QuQOhoSKYSA6S6ecyRCikKpWB3gG/2419qaq5K6HK+I=;
        b=AksM7EtYqW1I/QTTUjqQolFd8YqvKSgQ/M2632pmj1+sykdIb77UGUsbqlnISPx0kH
         /861Q/eoWb7WXJz4j9vCMXNAotbtV6ioV4QDSfbh3oszWQFJYfAV2V/N2eMYNWB+L462
         k0vM33V5E7Ip16TXAaHlvWIU22CvmWFTOy46yXoz8SuhXYtrqwA/cUq5OTg91hALA22U
         iahmet3J/LFegebHLjWVtzTtLqW+epX3cS2RptjBUa0o+mQlFB0lprp3zgD4VSE2IZDL
         Rqpl1Y9YMIk0RPy5AumJ39ZWkUxnU6VuWmrg+yIRtC+GB4HaKSBqTsholL6rZhHS9/jF
         Mv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962568; x=1709567368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuQOhoSKYSA6S6ecyRCikKpWB3gG/2419qaq5K6HK+I=;
        b=kvUwbyvWk8Y97RlZZB3iY9klb2dJNPYP8x4uBBNNNi6pf+Tv8DsXVpX7OclezUpj+r
         jQ+ou/PDX97qwzaC4DE0RLFvEXDyag2ct7SjKAWvd9xodltRt5MvdfeMUiFAStibWUDu
         Bi9U6/i7d1QKbDHbXaVUOM9Y6kZwZDRjx7lRNzuyFu1yXUmj1dLoDMUGRRYaggMJi6hV
         x4PcCrJcm0jTIKyN1Ucyw4k6OhM+xsd9bQHHh7eljnFlBfMlWsuBH5e/v0Ae1XgkhUmH
         hzgFKIva6c3SwnXeibUv8UWgUzt6+2MJbgxKXign17a5pwSPIqWJN2AlDPai07rrWv5U
         s1eA==
X-Forwarded-Encrypted: i=1; AJvYcCUzgOPta5osF/HjVARaiO3lE4F3xXUly3vf0SUt/R21F0vY3KBQzoU8EHTkRR/7SaHceyPvcCY+MDu7le55KjXh4YJ8B7Za
X-Gm-Message-State: AOJu0Ywus9kHYgu1HVm0ImDMQNM8IUpAGp4FvcV+2+PkxnDNIaD4C04u
	xPN3Fvgc4vsB5fGZdaT1ytxzAYhXyzjYqnCGywO/TSa7NjmIyYoEm3FlAVVhWbc=
X-Google-Smtp-Source: AGHT+IH62EmCPT2grL133xioxj+/UqxRqyJFrqd2I0knBMx9mTTaBj9K9DXm9vddfUPo+sSSBe5aOQ==
X-Received: by 2002:a05:600c:1987:b0:412:a5cb:5aab with SMTP id t7-20020a05600c198700b00412a5cb5aabmr2356320wmq.16.1708962568302;
        Mon, 26 Feb 2024 07:49:28 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b00412a7d9fb9csm2252060wms.45.2024.02.26.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:49:27 -0800 (PST)
Date: Mon, 26 Feb 2024 16:49:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lukasz Majewski <lukma@denx.de>
Cc: Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Fix typo in the hsr_forward_do() function
 comment
Message-ID: <ZdyzBIzIvqSvnzju@nanopsycho>
References: <20240226150954.3438229-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226150954.3438229-1-lukma@denx.de>

Mon, Feb 26, 2024 at 04:09:54PM CET, lukma@denx.de wrote:
>Correct type in the hsr_forward_do() comment.
>
>Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Next time please indicate the tree you target, by "[PATCH net-next]"
or "[PATCH net]" email subject prefix, so it is clear.

Thanks!

