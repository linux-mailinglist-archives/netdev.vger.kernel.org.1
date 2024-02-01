Return-Path: <netdev+bounces-67889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D53845415
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 10:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24FA28332F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B84D9F4;
	Thu,  1 Feb 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OXGUfRX7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBACF4D9F3
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779913; cv=none; b=t9OeRjlp06Ht68GrcpK7LstKpkrrr6AXB6g27nxgl7Hnbr55ljvNjH5wLJvgQzasJ8Dn1eGi29CjVfnH/mpEJheWeUDaFcRhilhWOdEX7jtak20ov/LOd46Bv7x/rYJ+YZ82Ox/rvDIkt+E1bbaaip5nBZCeKctwuCHqF8IAnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779913; c=relaxed/simple;
	bh=E9niEGVgZhUdPgPTb7GMxl8Ccwm+G7/hGenwW522N9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8INALzj3W4LztXv8zGEiKzaUDng/7sLZ88GcSZ2CTUlRaRh/15kjbNpNyVaX+18TOtdjWSA2yMcflBsheJ3hU/MrsrYpURdR9DrRUEmMJRdCbIiBCCU2lSuuJdNsyQMBgph+gZbGOeXtB1Lt5SkpPKG5XSe7QaGqeaXHkDtqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OXGUfRX7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-510322d5363so1025983e87.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 01:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706779910; x=1707384710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAv92q1PnnVq+dxV1mTCP+RfAFuWPr3Wk7OmWYlbPfI=;
        b=OXGUfRX7pCwMKH+jfB37hKuUOZudWYtrnO1LXGwgQgZvnRT2GF8P8TCXomdL3HkmBC
         A2+jbkQ3GYh3IfDG4BlCSxpnOnN/9feHBaEr7x8C86C0zAaI/75SSXwdIBshYTYymFV8
         mPkP/3CGo87dDonIXe3Xemxfug3Sx2p207KQntaJNhnviE9OOCaecmFegI+ZkUPAU0+N
         PIFe6wmYAvt/VyufrPP/t7KLQyhDqWayO3Pmbr9dnCOkYONLujSOHB65TXdX9g9UHay6
         B/YiyluS3wvQw1WMpgbrBSwR8KFQdGMluGxRcOt0I8KeKIs5dQP6V3pttem+zY5kghRS
         OdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779910; x=1707384710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAv92q1PnnVq+dxV1mTCP+RfAFuWPr3Wk7OmWYlbPfI=;
        b=XtUUcas588uHIYj/AsS3uhVBJQBO2EQD6w6dJd4GCIW/V04buspaG6Y8AdQpxZ7V/S
         9P3p9xHatHUCC9/psbzgmFi5vJyM2c1GifsB3QQ4wIoAaTL92EeSwEC0hMqlbjCPhWvP
         L/zu4FRXunR94OryZQVWzyg2Tg93gcA12K1jsG7skN9OkC1R4Hkw2gSVKIrm4kSoKpeA
         hoxPuCsMs3fNTH01z3ma1J2hVU4wjmH5apZVvxGSM335OIgIpk5T+deIBtKSdd6NOX5l
         K5lI7VmM2Uqkx17XoLfiY26qoQS3Wie6/SBoD1fRJhZoYmnBu9qbERzSJmWPQ19U4B5C
         zi6A==
X-Gm-Message-State: AOJu0YydDyTAo3ApsJBY2p4qgqS9y5HVvxhzVQ9hm/qgjqQdDRoRD/iZ
	LNWAudxnu8COi7yU+PUCvXiy0+gskBV9kan9RZ9aECpIbl3LREBwC98CqSD5S/U=
X-Google-Smtp-Source: AGHT+IEe0Gs4UjFC1yYOp4EHmipjAJpEnViYrLrcMQHXETpNl0XbVpLlMYurAjYB3pY5xuIhL1kP1g==
X-Received: by 2002:a05:6512:748:b0:50e:a219:e05d with SMTP id c8-20020a056512074800b0050ea219e05dmr1541060lfs.12.1706779909758;
        Thu, 01 Feb 2024 01:31:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV2VBfNg+hcJUA9n9GQQU7ItsWT5ZYOsaRaWYvRf5sW2nUHLX8KFNTv3+qwkfKIDLjNwCiNi7DvfPl1u6XhuCTD
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c1d9700b0040e9d507424sm3954296wms.5.2024.02.01.01.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:31:49 -0800 (PST)
Date: Thu, 1 Feb 2024 10:31:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net/sched: netem: get rid of unnecesary version
 message
Message-ID: <ZbtlAi0WU2sZPEHP@nanopsycho>
References: <20240201034653.450138-1-stephen@networkplumber.org>
 <20240201034653.450138-3-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201034653.450138-3-stephen@networkplumber.org>

Thu, Feb 01, 2024 at 04:45:59AM CET, stephen@networkplumber.org wrote:
>The version of netem module is irrelevant and was never useful.
>Remove it.
>
>Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>---
> net/sched/sch_netem.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
>index 7c37a69aba0e..f712d03ad854 100644
>--- a/net/sched/sch_netem.c
>+++ b/net/sched/sch_netem.c
>@@ -26,8 +26,6 @@
> #include <net/pkt_sched.h>
> #include <net/inet_ecn.h>
> 
>-#define VERSION "1.3"
>-
> /*	Network Emulation Queuing algorithm.
> 	====================================
> 
>@@ -1300,13 +1298,14 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
> 
> static int __init netem_module_init(void)
> {
>-	pr_info("netem: version " VERSION "\n");
> 	return register_qdisc(&netem_qdisc_ops);
> }
>+
> static void __exit netem_module_exit(void)
> {
> 	unregister_qdisc(&netem_qdisc_ops);
> }
>+

These whitespace changes look unrelated to the patch. Anyway:

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


> module_init(netem_module_init)
> module_exit(netem_module_exit)
> MODULE_LICENSE("GPL");
>-- 
>2.43.0
>
>

