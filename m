Return-Path: <netdev+bounces-90982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC478B0D41
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE69E28B893
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E115F40B;
	Wed, 24 Apr 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WW821IC6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977615EFC8
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970356; cv=none; b=IWdSeDZWv6i/j3/jlT8nmvgXHajlCcF9Py1cRUPllmfSXvYjZySwO7m8AaujDstlHw/94HUpohhHfcS458GJvM2+5N7xZkZgiv2MWFUdTkD+uHcLDlirBhUqHmPwhsHwPgHlWDJg2YiPMhPqpavqjP1qFDDF97CTohwH9qPZUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970356; c=relaxed/simple;
	bh=uwMlOajpsTG7Nvu/GdqkCHHfqk+DgHsocAsnwQtfytk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdxSHag4ZLXtT3AqWINZuvmVyyioBolmSQLZBSzJirDkD6r5Vn4K6njVLoOIxrgLfTriqLbSuI1SQWKnP4ERfPXakK+y5setzODZItN+XQAw3TDhTG088/ylD6IqmnkODHzn1lmviDaGvUO/0apzgNLMPXz9pAfXzeTqd3N/7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WW821IC6; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516ef30b16eso8565546e87.3
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713970353; x=1714575153; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U7XnI+BXV8UmW2sRzD+hzCEM7gwy7DDAc2EqtkuzGdE=;
        b=WW821IC638aKkEVNJ1SI4qdJdp32abv2tsasowSJrxJXD/WZMGypwjC9OGZz0QxQAP
         L4q+PRmYCbm6dzrAs02icdNaPVO0edEkI1r+BLz6xc1Ubjxrv51bOvepNZlOXAGbMHgy
         RIUHnT1gRbmyhe2y+op6emBQDoP8FDCL2vuL/7xStCb2rS3k4BFXQpYWg3DYnX28dT1v
         2rfMj/sEcpuTjjSo9cD2xiQyBH+t+cdEfkQPDyR0GCcxGUQgn4kFp0pbjasdSy4uZMdN
         Q24y2yHrr1DM4BNU9lpfKoz8tXS9CWKRU5OKnbymqIld5KxIwHFOphIpqpbYpdfX1q5S
         Kc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970353; x=1714575153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7XnI+BXV8UmW2sRzD+hzCEM7gwy7DDAc2EqtkuzGdE=;
        b=OVko41T02W5BZvxhRjABYr4v67RLZhzEvg/HlLtRmqSUXgXEtvzeNfBgcg04hnrKhU
         PcxED21RIs0GAESejOGXfb1jULJCfNNY0Gh7FChHKrJeBvtooO6nvJG9KSRwQOGHoJ3e
         pWV8CdsNj5/5SYC6Ixe3G0r725TEeIu9N429OnkLZhmE1coeOC3A9lFys1YhM0Do37ne
         Q96efXROg1jjzPsc9hveWrhLbsSRIWDDnwv3Jy91H9kfr2oGmLhRKbo1ODTBmYat0FGK
         GtZgbyMhXEjHB+6WNTy/b1gRgoYeUIZKfCbslzG5e/1nVxQS3FC+XX9AyrY7uFujeFBk
         SH1A==
X-Gm-Message-State: AOJu0YwJvy5BVnQOUo+29uIlbrmrququ3o66rAwl1KlF0a9RR6ZZ4cPB
	vZuZU37J7ZagyMYmp5ZrWFwMH3uTu/4AmOdtoTKzUrjT64tyKqpENraKPWKnyEM=
X-Google-Smtp-Source: AGHT+IH9F9eP/2XPHDQWflN29dAuAUFe6jszWIggRCsEU6DATfYGnMJ4GGP77Hb98kuV+APO2prnzQ==
X-Received: by 2002:a05:6512:3d2a:b0:518:8d15:8810 with SMTP id d42-20020a0565123d2a00b005188d158810mr2738510lfv.14.1713970352642;
        Wed, 24 Apr 2024 07:52:32 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k15-20020a170906128f00b00a473a1fe089sm8442813ejb.1.2024.04.24.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:52:31 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:52:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Subject: Re: [PATCH net-next] net: qede: flower: validate control flags
Message-ID: <Zikcq2S90S97h7Z0@nanopsycho>
References: <20240424134250.465904-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424134250.465904-1-ast@fiberby.net>

Wed, Apr 24, 2024 at 03:42:48PM CEST, ast@fiberby.net wrote:
>This driver currently doesn't support any flower control flags.
>
>Implement check for control flags, such as can be set through
>`tc flower ... ip_flags frag`.
>
>Since qede_parse_flow_attr() are called by both qede_add_tc_flower_fltr()
>and qede_flow_spec_to_rule(), as the latter doesn't having access to
>extack, then flow_rule_*_control_flags() can't be used in this driver.

Why? You can pass null.

>
>This patch therefore re-implements flow_rule_match_has_control_flags(),
>but with error messaging via DP_NOTICE, instead of NL_SET_ERR_MSG_FMT_MOD.
>
>So in case any control flags are masked, we call DP_NOTICE() and
>return -EOPNOTSUPP.
>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>---
>
>This is AFAICT the last driver which didn't validate these flags.
>
>$ git grep FLOW_DISSECTOR_KEY_CONTROL drivers/
>$ git grep 'flow_rule_.*_control_flags' drivers/
>
> drivers/net/ethernet/qlogic/qede/qede_filter.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
>index a5ac21a0ee33..40f72e700d8e 100644
>--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
>+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
>@@ -1843,6 +1843,19 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
> 		return -EPROTONOSUPPORT;
> 	}
> 
>+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
>+		struct flow_match_control match;
>+
>+		flow_rule_match_control(rule, &match);
>+
>+		if (match.mask->flags) {
>+			DP_NOTICE(edev,
>+				  "Unsupported match on control.flags %#x",
>+				  match.mask->flags);
>+			return -EOPNOTSUPP;
>+		}
>+	}
>+
> 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
> 		struct flow_match_basic match;
> 
>-- 
>2.43.0
>
>

