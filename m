Return-Path: <netdev+bounces-90480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74EE8AE3B8
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471551F24EBD
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD777E58E;
	Tue, 23 Apr 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ihqD9qbI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0187E586
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871276; cv=none; b=iT5B1/M2I1AbfZDspIu8AzuJSe78s24akSfds6Rmbn7LkXMmyI9Nsl6bZXlU0d03x7unnf5GpoCSs/uVqQ9zZCjgXX1i6tCRQg6800zwq+K+UDEsfTDiiMCr07CBW9/Mlb0reQ/w2GIPyV+C4l38zp5FPS2ehN5CqWTlOhDxh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871276; c=relaxed/simple;
	bh=McL494kHylPQpgK5Rw5ewYirZI64scA+ENuhG3CQDmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFMsjHK5W2+8Ztc2uQV8QnE8UhC1LjUK8LaMIgTW0yXSjPEiLwgaI/QeW4atbOC+QF0TM7kDiqfMMf7nJ//Pb/es/IDzfBKx2IpSqUEqJb90xGy0hZxEH5F41kSsccSZFXzwwqE8O+99Lj1UNe3xWvuPa1uI3KIEFjjkx9JHneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ihqD9qbI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso7703860a12.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713871273; x=1714476073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xQMenMSb8l2LXPyBEi3wXYVH63SCYqukshiFhylvZmk=;
        b=ihqD9qbIatpdUh/0foOGY7hiqy8iG1ld0JmC8PR94KHVQx02hzv5gZwVLLv3y4p9h4
         KAlh2wGbcV5U9v3Quwblmtd6KX9gvTgH28NnXcnxPgdbUbZV64LxeGZ7frbcZ5Op7UkV
         0vK+pDui7RAfJF8AP2mWIUmT+ZW3cRDUOmfdPIurf2d81BmNa5zIvGJSDzpjMTE0uJyX
         KsALYJ6pJFkus/O4o5R/sFCgh4+bc4cyt0bSnSjcW5AWh4LEPsgTli95fIRp8K3V5J1V
         Dlm+/DjlZlrPuA6V4OaYnIOMlbUfFrP9NbjU5eLQajmNqiQikxI/Ib/uvMNtpL0IMB0N
         wiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871273; x=1714476073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQMenMSb8l2LXPyBEi3wXYVH63SCYqukshiFhylvZmk=;
        b=MBFN1+vOPAH3muNDKoLnuUxO06e+s2pQcoBRV/QnoKMSh9ucM1/wxsRVOUeo6ruAqe
         TWpNPdxciCGzsaHSmhStA6hAASRh891ermlLT0FvNt8HE8tfPFxfWdxgIp33Kf+2zjmV
         qYEvWeCX0KCh9iUrEvrFgxQkLseCIfyacdwIHfooxmrwUscyoxB4paYCZzgG0TzQ2AU5
         D+jAMwnKGgdYtgeNhIsS7tDtwnolFtqGVSiu0/0WpJr8QcgzRWEkRhnVE6RHpXQThb8A
         0c0lBa+1+O8W1cdpGWN77uK0PA0uxq4oXK1DhYY0CagzaER0lBUC/DsueyEJbNe3ZQSs
         bJoA==
X-Gm-Message-State: AOJu0YwWDx99TIl6fbqmsl8MStUAI4HWS/+K6PGpya1lUfIbasDl3qQ4
	jUAA8pDK1nOubEOvz5INs0TVigPNokkzYo/zyABdu3Ag6E6U6r/ZgSqGDAI/seg=
X-Google-Smtp-Source: AGHT+IHLl0Px4nYo1vdOF1bA0+T6nLq2YDRmJapSrmSqV5inK3bXcounfKFEFFWV8y2QLErPq7rOQg==
X-Received: by 2002:a05:6402:430a:b0:572:f71:8030 with SMTP id m10-20020a056402430a00b005720f718030mr4482592edc.8.1713871273077;
        Tue, 23 Apr 2024 04:21:13 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b005721b7bfea2sm1082789edb.22.2024.04.23.04.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:21:11 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:21:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: lan966x: cleanup
 lan966x_tc_flower_handler_control_usage()
Message-ID: <ZieZpixUPfTxIRs4@nanopsycho>
References: <20240423102720.228728-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423102720.228728-1-ast@fiberby.net>

Tue, Apr 23, 2024 at 12:27:17PM CEST, ast@fiberby.net wrote:
>Define extack locally, to reduce line lengths and future users.
>
>Rename goto, as the error message is specific to the fragment flags.

2 changes, 2 patches?

>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>---
> .../net/ethernet/microchip/lan966x/lan966x_tc_flower.c   | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
>index d696cf9dbd19..8baec0cd8d95 100644
>--- a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
>+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
>@@ -45,6 +45,7 @@ static bool lan966x_tc_is_known_etype(struct vcap_tc_flower_parse_usage *st,
> static int
> lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
> {
>+	struct netlink_ext_ack *extack = st->fco->common.extack;
> 	struct flow_match_control match;
> 	int err = 0;
> 
>@@ -59,7 +60,7 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
> 						    VCAP_KF_L3_FRAGMENT,
> 						    VCAP_BIT_0);
> 		if (err)
>-			goto out;
>+			goto bad_frag_out;
> 	}
> 
> 	if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
>@@ -72,15 +73,15 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
> 						    VCAP_KF_L3_FRAG_OFS_GT0,
> 						    VCAP_BIT_1);
> 		if (err)
>-			goto out;
>+			goto bad_frag_out;
> 	}
> 
> 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
> 
> 	return err;
> 
>-out:
>-	NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ip_frag parse error");
>+bad_frag_out:
>+	NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
> 	return err;
> }
> 
>-- 
>2.43.0
>
>

