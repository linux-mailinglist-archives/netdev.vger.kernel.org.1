Return-Path: <netdev+bounces-88120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6848A5D3D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 23:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A2FB22A75
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 21:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C098157485;
	Mon, 15 Apr 2024 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Wjy4UwB3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093F157482
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217965; cv=none; b=l+UlQzMDIM0i9BnVj41ANvc2ZGQT4Hb/Hx0oDGhIv/5Lpa3dCGZh3kEcEitY7PscYp+4kUydMrd2wW2BSuEDIPrE1hZ6cznQSTSTanBcIMAn1gUGboV6zjE5bLUxJT7w3BPPB1hZJH/FG3UrkgDjh9whAQXqQ0cd1mggVDdVL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217965; c=relaxed/simple;
	bh=s6S5vArFfLeA1n6AEe08Vc+YXvCyTe3w6saiJgf3DZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V73IXLdCK0Ua4ChSTklRMFsJYy+daFyPeuEhKhr03G4IttY8g6RwlycYCy778SFqaCiyLfI5UwjtR8PoWo6ZLvgKBlGP606YP6iQek7UHwdpA/KmykvVg5J+QomXiOysT3ZxdwRbMEEUTZ7rsfKP3Y/YLncvtJRvsvs5EyMlmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Wjy4UwB3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3ca546d40so26206985ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713217962; x=1713822762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLqM4sU5bpj7q4IRaybWHZrQDnGfSBFI/jBhVVNs2QY=;
        b=Wjy4UwB3yoAZXnbX9umQZkHsTb9vwaoyeTa3zr/pe3JZj/wd77zg32KT2PmeZ9tGGW
         Z/JdeIAXmZimXGOKse1+5k7wadRWVhe0xsFRiytgfIgZGDntWkv3CQojBK+rpUwaQzyS
         ZVM+srL/CFZ7iahczIdlSciPSvy+MZeEpnEHq9QWXiIjkS5b0NPkdkmH1nMfJRVWHCST
         /nPnK9j/78CWJKSM9MXj9czV2oINKdWA7iOkCNeCiQc8vFYTXV4ov9ichqaa+aEjL4UA
         qJU9Oxfo4wcvY0PA1W299S/Jcf/geuyJ1Adst0QFoNMdTid0qhmy27/aVJB6vDjy+GyT
         vxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713217962; x=1713822762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLqM4sU5bpj7q4IRaybWHZrQDnGfSBFI/jBhVVNs2QY=;
        b=U7m0juVVT3WzdZdJczGrFBSO14PD5Q15J5OhLjlgtE84AxttGG1IdIMyb8dtnnTEH+
         GcLRvhRIOgBihvI5bhX0SfdKdsDJ0RTQr9DnDdaeBChyokx7VkPCBP/3lGs7Th38rTC9
         nXmWOVdmPkT5YoKqOh6iia9UghL7tCW11Ov5Xi9rSLM7+nXWza4/MAQRi66Ej3tanIei
         /PI1MiLEXBd51p7WZbtRx7e14U7L4Fi5ey34D5lYQLyrMphh3qgG1+qLCtK6RID0Ior5
         r056ujYjDV+KdnlVvr5CJBHIA4W7NbewMK2hLBuE1q53iCHDtmGKcH2bk/dLBCFfSx3N
         GcQw==
X-Gm-Message-State: AOJu0YyHQ+TfP6vLYoHphBV6caOGBnDdAXy0Uciv8DTrrpZdA/6Y8luu
	C1Flf6BYqZe7Ss5l+PRZfaIeK3Z77lus62iUXcGorQCLj9++X1MrUJyldPg52Mo=
X-Google-Smtp-Source: AGHT+IEP7wv690ahr7S0tQIuoZ0yi7Bi2TZUHydZS1gVbuGe9tCCrfcchoh855wdh3BdNhwB+amKUA==
X-Received: by 2002:a17:903:1cd:b0:1e3:dd66:58e1 with SMTP id e13-20020a17090301cd00b001e3dd6658e1mr14513622plh.44.1713217962279;
        Mon, 15 Apr 2024 14:52:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b001dd69aca213sm8378848plt.270.2024.04.15.14.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:52:42 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:52:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next v2 2/2] f_flower: implement pfcp opts
Message-ID: <20240415145238.0f5286a3@hermes.local>
In-Reply-To: <20240415125000.12846-3-wojciech.drewek@intel.com>
References: <20240415125000.12846-1-wojciech.drewek@intel.com>
	<20240415125000.12846-3-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 14:50:00 +0200
Wojciech Drewek <wojciech.drewek@intel.com> wrote:

> 	} else if (key_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP]) {
> +		flower_print_pfcp_opts("pfcp_opt_key",
> +				key_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP],
> +				key, len);
> +
> +		if (msk_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP])
> +			flower_print_pfcp_opts("pfcp_opt_mask",
> +				msk_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP],
> +				msk, len);
> +
> +		flower_print_enc_parts(name, "  pfcp_opts %s", attr, key,
> +				       msk);
>  	}

I find the output with pfcp_opt_key and pfcp_opt_mask encoded as hex,
awkward when JSON.

The JSON output would be more logical as something like:

	"pfcp" : {
		"mask": {
			"type": 0x0000,
			"seid": 0x1,
		},
		"key": {
			"type": 0x10,
			"seid": 0x11,
		}
	}


