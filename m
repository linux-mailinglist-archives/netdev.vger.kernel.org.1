Return-Path: <netdev+bounces-242728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80559C9453A
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 18:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BCDA4E068E
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83674CB5B;
	Sat, 29 Nov 2025 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jAHcuCL7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A355B21A
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435852; cv=none; b=WAI8vJphAXIVWB9H+Vg3DmRBDN+O1Tb24FDCG4+D87DBIvxF1JfE2C49OcqqjBN+dRiW1+gWUkqOtPdmqJL8M6Zkq9TnJlOfY3y4u9OxYPxWprxmq0jfQc3aEV3aESimqnpBzPmg3ka2V+zezjFqOdlY7LMMmfvDMQOxMsMksLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435852; c=relaxed/simple;
	bh=1ofg9EbWX3TxmwN9MuMZWoXX9LDX+R4phsPu3w2Jy7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUL79OogwQBBU109Esn7VvZ6VE0SmOwC/jpxt7nD7/5xIYXnjC21+nup5DWI2zAGJdcFGw6MsQDJgSe6Ijbaj32cVoYRj9L4XDoIoTs+BK48gHRJi8Z7c2OH7NM8i6qu/wITWXeW2pHR6g5ueRNkZo3QuY22Tf1EEbgDr8degKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jAHcuCL7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8826b83e405so38564726d6.0
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 09:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764435847; x=1765040647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0JrUY6rvuTDOtsRxKK87/+s+sI+ekupf3sIqBsYK/M=;
        b=jAHcuCL7uwpZnl40rR2bXPZRfEbNhO7WD6ASwTW58LSD05Lhk+gOiwKWSThKUsCpq8
         OOgStgmS42YMV1t6dPSJ5I7khNpvx96odfvOJOOj6Rs9HWlBQtJdh1oM5DvZTwgkNdh/
         6Ags8VhexSN4/tO5OF5RT2Uje8bjdq5HHhXTP7fqr0vWNVkyNFWIKR2/Q8QlsI+IPTqz
         16LXjQOOrrunN1xevzuaPEHJ8a21ubbXh3p3LYCM/svD80s2HlvPg1ucw7or7wElpZAM
         Fpjmd1CA6HhA7WS0X+nEDLgUn9Z2S+msQZgAhkWBvPKaRhb2B3134CotX3x3yI+EPn4X
         Y9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435847; x=1765040647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e0JrUY6rvuTDOtsRxKK87/+s+sI+ekupf3sIqBsYK/M=;
        b=tQF4IPizp7MJ5tavj3f1UBm/35IotMUWdCdxi3MCoLEsB8r619sZ8WOw1OL1zXs/aQ
         osoQm+W7//k0a4fM+xoEIU4Du/ahkAFSUysDhpCDMKEai4Rtvwi/FkHwnfT6XtMID1Gn
         hWinuBRznBfgW3w/P2EzhIg/ezTZC+57l9DNCfq7WgEDFmmy6TqgG1pJOEm6aO1VzZ6g
         vQuxtLJmwpE2Pnx5JEXKKIzMkOaTh6lOsSUwVMDL4wwSQxmE2aDIR8WwHO6RRYOV/eRG
         282NJgLZkEvhtrNk8Avg/kOzD5FH/9D4rshSHDyrI0wNoO/ZvJ1Ku7XFPQndZglveuZB
         3BzA==
X-Gm-Message-State: AOJu0YxtC+9o60lH7jTKmf/OMrWK5I06SfWAS81tB3iddwIPUijkOpEW
	BkidkmOyJN8inhwbK4XE7llc0atZffWeI213JwVpvoyGs6Kgre7CzNukPHc2EznX8s4=
X-Gm-Gg: ASbGnctII+i/g/PrXiRiZh3VRj9r3xgcIXvSX8D42eYPdoML1W8C5X9tsoZUPx98EJ4
	o7vteKPBvMquA2arVTSHIkRdBwHUVVif+3BXmLG1eplEU4edWVqSUu6a+RcMeuvZ52nPbk3JOXS
	HseIkLF6updMXkyyUBnKXFKDuBOuU8C8iHtyXs31Qa6+64PGrt4Q9vWj+mHBVS0VG14YHold4kf
	AwyB7ItnkzY3+9pzCY5elu93lEmrn2/K8XgenvK3h/qJuJRlOKcuhfdDyR4E1JeSdxN4uvWbVta
	iCZ5gssHt3AA8WY/SGmD9Giu1YMMQOpUV8WK52NhwKy1YYxZWm3DI+4mQ+NCHOIRgWBjUiV5/eB
	mQVr6mX+XVmcTx/9kjTSpAcJTUX2EkOqoUwizFOrjctkY79VhZCDU20r8XlF2u2Wwvz5kNmCoVT
	at9u0jXih+DdSqAP4wrP0qqr/45YVi232lvkwjcbIR9PP02VJP/Z0D
X-Google-Smtp-Source: AGHT+IEsSYkJd/FdkKfzHFclbNhdV73ou4fwyHJU3DgvCYF8sNlh+2gMj51qTXwK/lGbmiBeIwi1Zw==
X-Received: by 2002:ad4:5c68:0:b0:882:4976:5eda with SMTP id 6a1803df08f44-8847c49c7b2mr465642206d6.4.1764435847467;
        Sat, 29 Nov 2025 09:04:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524e5cfcsm51008366d6.19.2025.11.29.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:04:07 -0800 (PST)
Date: Sat, 29 Nov 2025 09:04:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver
 Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH 5/7] iplink_can: add initial CAN XL support
Message-ID: <20251129090403.5185f2ee@phoenix.local>
In-Reply-To: <20251129-canxl-netlink-v1-5-96f2c0c54011@kernel.org>
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
	<20251129-canxl-netlink-v1-5-96f2c0c54011@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Nov 2025 16:29:10 +0100
Vincent Mailhol <mailhol@kernel.org> wrote:

> +		} else if (matches(*argv, "xl") == 0) {
> +			NEXT_ARG();
> +			set_ctrlmode("xl", *argv, &cm, CAN_CTRLMODE_XL);
> +		} else if (matches(*argv, "xbitrate") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.bitrate, *argv, 0))
> +				invarg("invalid \"xbitrate\" value", *argv);
> +		} else if (matches(*argv, "xsample-point") == 0) {
> +			float sp;
> +
> +			NEXT_ARG();
> +			if (get_float(&sp, *argv))
> +				invarg("invalid \"xsample-point\" value", *argv);
> +			xl_dbt.sample_point = (__u32)(sp * 1000);
> +		} else if (matches(*argv, "xtq") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.tq, *argv, 0))
> +				invarg("invalid \"xtq\" value", *argv);
> +		} else if (matches(*argv, "xprop-seg") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.prop_seg, *argv, 0))
> +				invarg("invalid \"xprop-seg\" value", *argv);
> +		} else if (matches(*argv, "xphase-seg1") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.phase_seg1, *argv, 0))
> +				invarg("invalid \"xphase-seg1\" value", *argv);
> +		} else if (matches(*argv, "xphase-seg2") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.phase_seg2, *argv, 0))
> +				invarg("invalid \"xphase-seg2\" value", *argv);
> +		} else if (matches(*argv, "xsjw") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.sjw, *argv, 0))
> +				invarg("invalid \"xsjw\" value", *argv);
> +		} else if (matches(*argv, "xtdcv") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl.tdcv, *argv, 0))
> +				invarg("invalid \"xtdcv\" value", *argv);
> +		} else if (matches(*argv, "xtdco") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl.tdco, *argv, 0))
> +				invarg("invalid \"xtdco\" value", *argv);
> +		} else if (matches(*argv, "xtdcf") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl.tdcf, *argv, 0))
> +				invarg("invalid \"xtdcf\" value", *argv);
>  		} else if (matches(*argv, "loopback") == 0) {
>  			NEXT_ARG();

not accepting any new code with matches()

