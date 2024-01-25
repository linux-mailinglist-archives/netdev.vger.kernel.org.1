Return-Path: <netdev+bounces-65713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A376183B6F2
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69DD1C22763
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846E81388;
	Thu, 25 Jan 2024 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pEZKN1VE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B304111AB
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147709; cv=none; b=VHVWDaEOlm8p+PJce8lXoKbfEL01CPDhFH0pXuU0DJGczIAHetTuKbOEuYRO+insRc87of5vB2Vlqom7YxYgPcLDCTwucO97Q22/vi+YpCtUGLC11LxHKHSGbvMbxTCrn9m53i8h2Bhmf6R1/s/R0iqsHW3By6E+dVqK+2Vjj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147709; c=relaxed/simple;
	bh=P6y3WUFu5mu+MV7z+QtF+/xIEpUMdKJuTjd4yfH8Ct0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nb5c5eDrbUL9YKo5O7zWvu7AuHVYIBSHsmNjC39wSoATgIT85x6bbmiHWqSNvQyLekkN61u5zo7VrSWDLENq2hTKjTVNYBsvwpHdhhNYRGN4SfqofA5ii6Mwa8YcEicuGqlCvHnL0MWMw0rfQOwnH4VjWoWFnCf8gGN3yzZDFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=pEZKN1VE; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e0a64d9449so4036567a34.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706147706; x=1706752506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqclb7cXoE33qdN4THlUcPh8FPVHS/F9BjTx9CfMxbo=;
        b=pEZKN1VEwErjegEfuRqjfkBD+Md8/0X44sOlwKBw3rmSX2HBxq1oiexUkkCOvQNhqX
         /JQPmi0nAB0eHwM4bUvJYRC38u+RXW4ttqr6eH03BKzLpw2sFDtCgIUsjpzBtpQdoo1l
         3WWF6g1/ZaQsJo8pd/CcbsN60Y90s5T5QvHAQeQl94XZEXtOGZCOgVh6vZnoTd0axK6m
         jBpIbd50vuvZrpzjbasNjhgSKIawE5CuRSZEukBRIIDJPUIbFVNwYnees2vedrG0RcPI
         zWJGZYcsFycM1ekV5IWbbQSm28/VsAjAtTj3mP3lucnIvpu8K4xecSlKmDQH3Y57rSrw
         +gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706147706; x=1706752506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqclb7cXoE33qdN4THlUcPh8FPVHS/F9BjTx9CfMxbo=;
        b=Xn7ucYTUBhc2jvml7eJpf406ZcTf5IGYiZoajwLsLKp6KqP3dU1AuBopAQJ5UWGnHu
         VOCd/CMcQMGsXEkVl14hNn3XifEJrOJPF4GBGfnB609B8Vh4KQn2PsaLNbZ8voKOOajq
         j/meSG59m3GIncQ+mCLzM/xCLZsqnNHOk2IH50ClhP5IMXFU7nI1IDc+FQtYFBCF3Ydk
         wjhsJSNHTtqclgCLVwr7ICJSzcpBAusEmMFGJG0PysLAt6n4Oetae5YvV0PVJtbAx6ZJ
         PDNRw9o2Y5/rz71MOb2DucfErQMakvbyczl6PVSTQyfloyrrgaiGqVGaQFuStiG3aL1X
         U2nA==
X-Gm-Message-State: AOJu0YyAlTD3GEPpPm2t74lNgVBZ9zqTubuN4X597n3BxcsGhsB/Ht4Y
	EE+EO1Hg9f/eIyKiRsQHDVUiCgIAej5uEeaaduWVWfcXcUYNZGAj+0+u2DDxVjI=
X-Google-Smtp-Source: AGHT+IHYI1fTjpvcLQZSaWeEeJNxv1y/7RqqeOc9dJCAS/hjEoxVy3ViOPVSp+aoWbdI/g9BcBDRhA==
X-Received: by 2002:a05:6808:148a:b0:3bd:c698:eefd with SMTP id e10-20020a056808148a00b003bdc698eefdmr182202oiw.24.1706147706259;
        Wed, 24 Jan 2024 17:55:06 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o8-20020a056a00214800b006d9a38fe569sm14384515pfk.89.2024.01.24.17.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:55:06 -0800 (PST)
Date: Wed, 24 Jan 2024 17:55:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Aahil Awatramani <aahila@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>, David Dillow <dillow@google.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, David Ahern <dsahern@gmail.com>,
 Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] ip/bond: add coupled_control support
Message-ID: <20240124175504.088cc8b1@hermes.local>
In-Reply-To: <20240125003816.1403636-1-aahila@google.com>
References: <20240125003816.1403636-1-aahila@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 00:38:16 +0000
Aahil Awatramani <aahila@google.com> wrote:

> coupled_control specifies whether the LACP state machine's MUX in the
> 802.3ad mode should have separate Collecting and Distributing states per
> IEEE 802.1AX-2008 5.4.15 for coupled and independent control state.
> 
> By default this setting is on and does not separate the Collecting and
> Distributing states, maintaining the bond in coupled control. If set off,
> will toggle independent control state machine which will seperate
> Collecting and Distributing states.
> 
> Signed-off-by: Aahil Awatramani <aahila@google.com>
> ---
>  include/uapi/linux/if_link.h |  1 +
>  ip/iplink_bond.c             | 26 +++++++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index d17271fb..ff4ceeaf 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1503,6 +1503,7 @@ enum {
>  	IFLA_BOND_AD_LACP_ACTIVE,
>  	IFLA_BOND_MISSED_MAX,
>  	IFLA_BOND_NS_IP6_TARGET,
> +	IFLA_BOND_COUPLED_CONTROL,
>  	__IFLA_BOND_MAX,
>  };

This patch needs to be targeted at iproute2-next 
Subject should be:
 [PATCH iproute2-next] ip/bond: add coupled_control_support

David will pick up the uapi header once the kernel part is merged.

Since it is a boolean option there is on need for on/off style here.
Just use presence of flag to indicate on state.

And use print_null() to indicate presence of  flag rather than using print_string.

