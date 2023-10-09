Return-Path: <netdev+bounces-39065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E27BDA2C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3429D1C20831
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091C168BC;
	Mon,  9 Oct 2023 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBAvQfbX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1E11738;
	Mon,  9 Oct 2023 11:41:07 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592994;
	Mon,  9 Oct 2023 04:41:06 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57c0775d4fcso546415eaf.0;
        Mon, 09 Oct 2023 04:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696851665; x=1697456465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3UMoGQQEfDpfmWMr3jSmUBbiLLCy8BHLNGDda2pd2Y=;
        b=PBAvQfbXz0HcgJkTM4cX3NvywouWCWTGs1xMLxJjSA12dueZIAiaaYgVre9eR1RxjK
         tfLNtX5zURtBHj5BVGRG44C4uOO5fQLCyQr/SIUasHoiA7DhBGkNnkaU+q5SExkO+0Xq
         RNGFBNzclcBFacdj8bwMXd/4Y/G2hthsDVrHT1jvn96voaruKX9F54UvqscugM/UVp/n
         ZYnA0uy8/W8ZOZGYUIZGB7QfyD/4Lsm105N1OTrs97kmvKmM051deUroNhautvNJokQr
         1k2J6mrC0uao8qOnmBrgiQXze6TklYW2G9Ra+jSfrzL24KO9tTxFwNsMEb3FylXCqPNj
         niEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696851665; x=1697456465;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3UMoGQQEfDpfmWMr3jSmUBbiLLCy8BHLNGDda2pd2Y=;
        b=fbkCb288Pv4uIe9ZBDEDvy3SqHSLgmTI9UVNEuExmGhuJDzSjuZZMBed6QSecnjVeS
         3cNS4nyoLdGakkwKJUBxHPXtsy+Tjyfmi+vpZydJSbyI4Jv60MlNntfis4P2jfTwr19Y
         +dcoSR6Mwhm7aOtVEboHkSm9EQyvGzg7VeR/jdAc8i3t9mSYEt2UmKs4+POBITyow+1P
         SoI7uVdGb3vqjocT1DxcKpykUtephHjRK7B0f2Ihy5DUSFkY2aRLyuzcpA/tewaJvgKO
         tUgWlbfvYx5tQGBKch5k+bLsxGeDuqJHcEHXYV+AONBIifxD95pPJF/ROTSqfjtkSwVd
         8/zQ==
X-Gm-Message-State: AOJu0YxD5wgcPnscxiJaMrV0lSV7iiY1ZoZHcysBZaHiwNuudWK9/BDl
	vakESqV9TmX+4ujIaJE2BM7h2uiKbH9x1wxb
X-Google-Smtp-Source: AGHT+IFv25pJjbrFHs4iK+A4CgwscwJEMcqZJIUocS9cMXo8Lpt7uybhzzOKC07g4VJdaF81AKFX6Q==
X-Received: by 2002:a05:6359:219:b0:14a:cca4:5601 with SMTP id ej25-20020a056359021900b0014acca45601mr10453087rwb.3.1696851665437;
        Mon, 09 Oct 2023 04:41:05 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id bb16-20020a17090b009000b00274bbfc34c8sm10168730pjb.16.2023.10.09.04.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:41:05 -0700 (PDT)
Date: Mon, 09 Oct 2023 20:41:04 +0900 (JST)
Message-Id: <20231009.204104.218796704097737110.fujita.tomonori@gmail.com>
To: jiri@resnulli.us
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZSOqWMqm/JQOieAd@nanopsycho>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
	<20231009013912.4048593-4-fujita.tomonori@gmail.com>
	<ZSOqWMqm/JQOieAd@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023 09:23:04 +0200
Jiri Pirko <jiri@resnulli.us> wrote:

>>diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
>>index 301f5207f023..08f5e9334c9e 100644
>>--- a/rust/uapi/uapi_helper.h
>>+++ b/rust/uapi/uapi_helper.h
>>@@ -7,3 +7,5 @@
>>  */
>> 
>> #include <uapi/asm-generic/ioctl.h>
>>+#include <uapi/linux/mii.h>
>>+#include <uapi/linux/ethtool.h>
> 
> What is exactly the reason to change anything in uapi for phy driver?
> Should be just kernel api implementation, no?

It doesn't change anything. Like the C PHY drivers do, Rust PHY
drivers use the defined values in header files in uapi like MII_*,
BMCR_*, etc.

