Return-Path: <netdev+bounces-14340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D482A74041A
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 21:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD10A1C20B46
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C74F4C61;
	Tue, 27 Jun 2023 19:49:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5C4A33
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 19:49:00 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A692953;
	Tue, 27 Jun 2023 12:48:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa96fd79feso31141395e9.2;
        Tue, 27 Jun 2023 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687895324; x=1690487324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7pY77BX0Bjm/AG7DKW+7YePblMuDF5/88esr4ObIklU=;
        b=ldzpV7TNtqMRq9y/b72mmwbatQnKd0ZJdsBOP2Ex0kCOpEYiiBIOEvMX5Ro45A2zS3
         HDUeO4NMjVxwbYSM/sKj2DIIFfxGFZBSYA8dlvs1Z5F49RhBIjMo/GfI5Sdb8Ah2iehp
         B4EYj26TKWYeDOmJaTXwcI2aAEYNuXgOO8go53FqhBoipL8+vQsuZwxqUHvq8IBytQA6
         6jG/J/Yal9ojlGirFo61Atum21QrD1NKTHQJKqiKKW53zPwPXR2uIhiPonXXbiyx6rpj
         pscMrDFFBmxc3qJ2mwn5huR9kdigIkrY4/iBU/sjhwjsPYQ36F2C/2OHYH30eBpPVAR2
         0zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895324; x=1690487324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pY77BX0Bjm/AG7DKW+7YePblMuDF5/88esr4ObIklU=;
        b=e8kNP6aW+USX4Y/RHhQTaZgMgsuoEvOvWtG9t+883GWHvu8YH4pUlxPpif5Gux52CV
         ACvpm8x7W4envu4f05Pj6nFko0EF+xqch6FhLmuMl7p+gu3EvD6W8F3u0wFprH860DgY
         YkO55NWJECgG/M8JK6CUzLwg0BVofJVNmXDCobu4l81y67HAaieshCxxXAo0wHRKobri
         vbdRNbVt2H+SV2iM2iuux6jzQGhuiQKJpezqmJ8afoASS/l6FEKVKwrcCIvrjhpTOu05
         djrVlPDY80q5QcKvcYT4BXDukukoiQLCm//GjyTh6tEMiKylj2FB+bHRDUw/CApn9oii
         qykw==
X-Gm-Message-State: AC+VfDze18OTOnPBYBqFF3MphqJquvFd4blbPYUqs/2VaSkP5gHBY1Fk
	q+h3uLYWhFgAdYcCbytq/iE=
X-Google-Smtp-Source: ACHHUZ47C+lWtGTBCwu5KgZvIz28Mq3oGaWnE0/qfgjO5jNdPVrvAxxQeRNXNFDTqrh25iufnRHlFA==
X-Received: by 2002:adf:e711:0:b0:313:efed:9162 with SMTP id c17-20020adfe711000000b00313efed9162mr6149433wrm.59.1687895323905;
        Tue, 27 Jun 2023 12:48:43 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d638c000000b00313f61889e9sm5260340wru.36.2023.06.27.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 12:48:43 -0700 (PDT)
Date: Tue, 27 Jun 2023 21:48:36 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, yusongping@huawei.com,
	artem.kuzin@huawei.com
Subject: Re: [PATCH v11 08/12] landlock: Add network rules and TCP hooks
 support
Message-ID: <20230627.82cde73b1efe@gnoack.org>
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-9-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515161339.631577-9-konstantin.meskhidze@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 12:13:35AM +0800, Konstantin Meskhidze wrote:
> +static int add_rule_net_service(struct landlock_ruleset *ruleset,
> +				const void __user *const rule_attr)
> +{
> +#if IS_ENABLED(CONFIG_INET)
> +	struct landlock_net_service_attr net_service_attr;
> +	int res;
> +	access_mask_t mask;
> +
> +	/* Copies raw user space buffer, only one type for now. */

Nit, which I came across by accident: I believe the remark "only one
type for now" referred to the fact that path_beneath_attr was the only
rule type up until now - but that is not true any more.  Please adapt
the wording also in add_rule_path_beneath, where the same comment
exists.

–Günther

