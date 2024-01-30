Return-Path: <netdev+bounces-67102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1968420FE
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43341C21393
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE9960B8D;
	Tue, 30 Jan 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blVGrEj7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A160869
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609921; cv=none; b=rWUv5PvA69hnWX3znb+mhbn8PBSFVsGZrVYrXifHe9qyATbQ/t4YNoBrGCdryM8zsvz65wZ5o+zp8C6GSVHrYXaqkZPwh+quXxSr6MvORRTR5ZhiuF3cl1WEDTnGRDPMA+GhHjfQvOAXjojZwAhUbiEyCqUdTeyDc0nVQN4HfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609921; c=relaxed/simple;
	bh=4TP+2pDSW/hwqAmEi97tuFXblX4QTnYCuHydZUDiKyI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZBbigRUT4R91DVcndVHSrIfoaA9dwGmi+C+xMXM5335/oELLSq7yke1F9kI7fFAONidlXROp13OaNmVSDUq0HMV1gb5UGBpJmtalggyNALyFJUCwe8xairF9fIK3ua9J4CZNrm1Zg+zdtDkKLn7hnFTohtAwW6alpodhOywytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blVGrEj7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706609918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4TP+2pDSW/hwqAmEi97tuFXblX4QTnYCuHydZUDiKyI=;
	b=blVGrEj7JQ8e+7LLwd5VRrw2nimCeYzht4VAYVJyH6cCuG9O8Sr7mLIYlhMueu942sgHEM
	hjAHDRL6+6+iCvUfDSfTSIARERfAJmLCbHsxL3Y2sykD03AXg2a7YldL2Ic0IEofZQALTf
	CA/B2yTY+UR14zyGTextIs0x5Mm+QS8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-YI3ellidM1y4jvROr0hWgA-1; Tue, 30 Jan 2024 05:18:36 -0500
X-MC-Unique: YI3ellidM1y4jvROr0hWgA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33930673253so258837f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 02:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706609915; x=1707214715;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TP+2pDSW/hwqAmEi97tuFXblX4QTnYCuHydZUDiKyI=;
        b=sD01rgDNj9IbvFqHn4xPpb5/YsUXQECRl2MnoP1CrD2bHAPABMd2h7+U7bp11Kb3Y7
         qObDab/Op+5A/IR4ka6BMRmMdGxzRrtpcOJ0ibxJAugROQfCzfm+yRIjRbTTOcFq/2eH
         Zn9VFnWwceExqBLgX2zE0iuswsjsxb1/FIzmsF2Qf8HBdBi6aQN07d5RJ5UImav8ylrn
         BgL4vZIYAmIe1qEw+EKYR7DcECFWb90TeAHetgY4vdOA+1uuijqjLoTHGmzze26Ger9W
         gPowI0AxHC6s75BMR0uKkIpQvMHdtIHgLzDUQOqcTJgXSqbFOCM4tgx/w33hOJkxp3Lt
         TvNw==
X-Gm-Message-State: AOJu0YzB+ubwpbp5Ss/7T1fwgl7OSBCklM8Cg+34QoYb+Eq7I5k7uiL/
	LTzTcvuI9oD0+lTN36KlBma4bTpxHXFEBnjlJC2dQVcYdU1LGpyBs6nubstkFgJP/8Vd2x8/as/
	dwe9xUr87asQivCIMYFB3QzRiwufsqTlr60c6ujIu61lVTthv4LpB0Q==
X-Received: by 2002:adf:c793:0:b0:337:c4c8:92f with SMTP id l19-20020adfc793000000b00337c4c8092fmr6766499wrg.3.1706609915647;
        Tue, 30 Jan 2024 02:18:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+844atY5uHJ3m9UogB9trmk575vzY0CsSl+JmNif5x7p/efSdhW/kDww3eCWU1/h+yIWJmg==
X-Received: by 2002:adf:c793:0:b0:337:c4c8:92f with SMTP id l19-20020adfc793000000b00337c4c8092fmr6766487wrg.3.1706609915265;
        Tue, 30 Jan 2024 02:18:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-203.dyn.eolo.it. [146.241.232.203])
        by smtp.gmail.com with ESMTPSA id x11-20020adfec0b000000b0033afc875fd5sm919133wrn.49.2024.01.30.02.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:18:34 -0800 (PST)
Message-ID: <8f53e63311f6e6c353768bf86775402735dc9b5a.camel@redhat.com>
Subject: Re: [net-next v6 2/4] net: wwan: t7xx: Add sysfs attribute for
 device state machine
From: Paolo Abeni <pabeni@redhat.com>
To: Jinjian Song <songjinjian@hotmail.com>, netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com, 
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com, 
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org, 
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.com, 
 vsankar@lenovo.com, danielwinkler@google.com, nmarupaka@google.com, 
 joey.zhao@fibocom.com, liuqf@fibocom.com, felix.yan@fibocom.com, Jinjian
 Song <jinjian.song@fibocom.com>
Date: Tue, 30 Jan 2024 11:18:33 +0100
In-Reply-To: <MEYP282MB2697447F0AFBA93A9033DE23BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20240124170010.19445-1-songjinjian@hotmail.com>
	 <MEYP282MB2697447F0AFBA93A9033DE23BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 01:00 +0800, Jinjian Song wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
>=20
> Add support for userspace to get/set the device mode,
> e.g., reset/ready/fastboot mode.
>=20
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

It would be nice to add a reference to the fastboot documentation and a
more functional description of what can be achieved using this new
interface.=20

Thanks!

Paolo


