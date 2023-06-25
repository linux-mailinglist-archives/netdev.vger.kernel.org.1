Return-Path: <netdev+bounces-13817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D973D14A
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 16:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEE51C20915
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE336134;
	Sun, 25 Jun 2023 14:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE336117
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 14:07:33 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0813810D1;
	Sun, 25 Jun 2023 07:07:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d9124e1baso1340898a12.2;
        Sun, 25 Jun 2023 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687702034; x=1690294034;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuAG9jAdxVasKdX2usI2xLW6Z40/NeC0yYSwBQqZYDc=;
        b=HowsnPGWbWKV8NnSpGwN385ujM0UcLFoA+AF/IgiJeJHXVmqLvEz4tyWpfe34UD0TU
         WskYE082R+k7JWgnV0tJ4VfvCKWQcVwkMPZrQUKwCgUEcRxVJXqEcwv4IFwYRUkTEgNn
         gXL1LPq0oeY9BBOAN8pCPm/XGNXvAvbSrMUADsvHzwD+mVjMe3zhNoGJYMoBzr0A9OXt
         cXIUgLFRH0n1Fh09i6+BtWIgBamHSvw7xxsYWCxCHGUQxm6AgxdOhXqoh/A+OmE2TRav
         CVVTZN+mNAe8rsBGtG/hyFCQ54NPSyJciEnK7r/4Oq5f4wetnXT35YcMMOuxsCyWFmDI
         ClGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687702034; x=1690294034;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuAG9jAdxVasKdX2usI2xLW6Z40/NeC0yYSwBQqZYDc=;
        b=GkoEmzislPgC0Sah3p47MWoQEQi2lHcuAPOzomBufXoBS8z+FDhPf2lfUDAL4NqVON
         fQuvOICMRidpHzUC7mwI0i//L08czJBhgcHvPEV5s/mXI7BPD95yjX7AZYwIGiSa4a0h
         mRAi3RsGJ0+PqObH0ATbZpOh67J5/sV1y+v8vTNUoBBK2JJ4J1P9p2qbva4RFaMG6I1a
         mhd1DyfXVBLdAMWkKBKcJTzAPslOiRIxf4nw+0HF4DLtHz67bwbm2BmFjr5cJliKHn1N
         lVVYUnqo0eweHCdK06WujnafDcYrIHE9UwpwRGIo/86m+cBzgsw8WKgGMosvWxdKS1th
         lv6w==
X-Gm-Message-State: AC+VfDw2nPcSp5Gp1dNzbOWZM7rGunGPe+Kc2CXpqIpIbxMy+RjbK1hj
	pv5ehPq92Dw1luedBXBEg0XnkZbyCA==
X-Google-Smtp-Source: ACHHUZ7DpGTC1ashgSHrCs6UX7S7+s0At33zJANHmWxBXQW/fkthA7fWtDxhuluOY/Ldj5S6PguNeQ==
X-Received: by 2002:aa7:ca4f:0:b0:51d:96de:af6f with SMTP id j15-20020aa7ca4f000000b0051d96deaf6fmr980161edt.0.1687702034115;
        Sun, 25 Jun 2023 07:07:14 -0700 (PDT)
Received: from p183 ([46.53.249.169])
        by smtp.gmail.com with ESMTPSA id x26-20020aa7dada000000b0051be4cb7f54sm1793067eds.84.2023.06.25.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 07:07:13 -0700 (PDT)
Date: Sun, 25 Jun 2023 17:07:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Lin Ma <linma@zju.edu.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, simon.horman@corigine.com
Subject: Re: [PATCH v2] net: xfrm: Fix xfrm_address_filter OOB read
Message-ID: <8a80ec0b-154a-4e6c-8fb8-916f506cd26d@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> + if (filter->splen >= (sizeof(xfrm_address_t) << 3) ||
> + 	filter->dplen >= (sizeof(xfrm_address_t) << 3)) {

Please multiply by 8 if you want to multiply by 8.

Should it be "splen > 8 * sizeof()" ?

