Return-Path: <netdev+bounces-115320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A2E945D3A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04174B20DA3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B91E2109;
	Fri,  2 Aug 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ED3xD3WQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B61BE87A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597982; cv=none; b=QXjPJxnhpXTKZ+7Y8UcEslLFqAZsq4WUPrURAwIt9GgoMt86dSuP4HVHNwSg13OQ3ieEHPqsEuxaN72UXYZAbub7DIbYL82eWZexz9u1nboN7lHFyq7ifDXrvRbt4Gba86f5j+av++dJt+1jBVr2ehtqabM3e0ulh+hoM9aZ/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597982; c=relaxed/simple;
	bh=r5bPLq7YVTWAbAepM2udvHq7wAklkSEMSNjaiuDyQdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuS1fEPAFZf5D5OxBmjlIij+Gi4pf0naGbLMK3O0M87Vvv0LNtTocJS4h2GJIfkcKex8Y/FtdEjRb16noEEiLrbdnT5wSP79cc8hJJjm3lmETV6Xs0rmscW7j38/muhFvZerFgyWd4iaPpo+bgBaW3AEQ+FaGsvkXCul5jJkWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ED3xD3WQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so5557533a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722597979; x=1723202779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9m07A/HbWuQ7grysUQ4vixCSF4Dg/OIQ2NT9plhBuz0=;
        b=ED3xD3WQAUxatwK2JjAsEUuEaG8/PO8mJP2KNbTSFIM0KlhfMfRNxzcaUMJ1YCi0zE
         w4Hf/IqCyz/8PHeuIUTpk6UUNxCrqZQtj2MOCy4M3DScKgHmMfbMMNtnFUaxRxfM+k5e
         /a502LKjBeU8DbgH2hS5x0YO4n4+37rPC7BTiWS9xuP3SP5dNlfVeyXraHwJ1HizBpqc
         1NXzlvt51CNiTqCWOXvWRKeCJ3E1QwWdPtSMnp/Y/uZ6oZYb8o5YYcAayLnaEEg4+ArB
         8pa6mxkK7jvh6tr+ehR2J/aOagLOIJbNv2YMS4LTR8fZ7mwBS/Fxw9nvHR3vShtxA5y6
         0RDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597979; x=1723202779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9m07A/HbWuQ7grysUQ4vixCSF4Dg/OIQ2NT9plhBuz0=;
        b=aziV49q/V/QacS8HLhSKUsjQOijREh88s4RjFG91SZociks5r3jw26EUTImw0zqjEc
         Z0i919i79FPvOrIO7gkcOB1wxCxr3q5h6jyu7cfona1V0IT0rQR1Qw72WehQ2O0L6wrL
         gDAPJIJw67hjqv7wAnDTiu48KORpuB6KMd5O9eRdftCB9O2Ps9JS3P4ht+PSziiROms8
         +2oO4Q0LCdG64wYE1diK473RsMCS8f4XmsDC8hoRO3Brep8T6XHYeuDefQUyNC+PmsRC
         ViFMQnEmTXULbpInZNXHVjm9sdarf4NGRph/Bif95GAg2qwWemrVgEl5hO/x5LlTVQLa
         0gZQ==
X-Gm-Message-State: AOJu0Yy/9py/zpu3zOSkQdBfqGeOIcuIQL3shVhmkE0P+nSPBURiEfSY
	dXaDaHSu35c77PnTReMDbb6FhpB9UQYOGn/AS4OvVypdCrqR2N6RcOxn8OyVIAM=
X-Google-Smtp-Source: AGHT+IHc5rf0PMCHNXBF8/xiStf5aXoc7w3pseeGg2dtemLLlmV21RfY1JaOgP7oBgI7yOmhri2itA==
X-Received: by 2002:a17:907:d8a:b0:a77:c051:36a9 with SMTP id a640c23a62f3a-a7dc5fb4baamr283353666b.9.1722597979275;
        Fri, 02 Aug 2024 04:26:19 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c0e0sm89242166b.67.2024.08.02.04.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:26:18 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:26:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <ZqzCWQwACMQ3RQaw@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>

Tue, Jul 30, 2024 at 10:39:45PM CEST, pabeni@redhat.com wrote:

[...]

>+const struct nla_policy net_shaper_ns_info_nl_policy[NET_SHAPER_A_WEIGHT + 1] = {
>+	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
>+	[NET_SHAPER_A_METRIC] = NLA_POLICY_MAX(NLA_U32, 1),
>+	[NET_SHAPER_A_BW_MIN] = { .type = NLA_UINT, },
>+	[NET_SHAPER_A_BW_MAX] = { .type = NLA_UINT, },
>+	[NET_SHAPER_A_BURST] = { .type = NLA_UINT, },
>+	[NET_SHAPER_A_PRIORITY] = { .type = NLA_U32, },
>+	[NET_SHAPER_A_WEIGHT] = { .type = NLA_U32, },
>+};
>+
>+const struct nla_policy net_shaper_ns_output_info_nl_policy[NET_SHAPER_A_PARENT + 1] = {
>+	[NET_SHAPER_A_PARENT] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
>+	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
>+	[NET_SHAPER_A_METRIC] = NLA_POLICY_MAX(NLA_U32, 1),
>+	[NET_SHAPER_A_BW_MIN] = { .type = NLA_UINT, },
>+	[NET_SHAPER_A_BW_MAX] = { .type = NLA_UINT, },
>+	[NET_SHAPER_A_BURST] = { .type = NLA_UINT, },
>+	[NET_SHAPER_A_PRIORITY] = { .type = NLA_U32, },
>+	[NET_SHAPER_A_WEIGHT] = { .type = NLA_U32, },

Since this is the same set as above only extended by parent, wouldn't it
be better to nest it and have it only once?

[...]

