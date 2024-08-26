Return-Path: <netdev+bounces-121936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ED395F5B2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1701F22654
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026919307B;
	Mon, 26 Aug 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CwWqb4UX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07EE4F215
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687958; cv=none; b=PEo2kBvhNOqCUlYm0AFB0eOpwOzXUERNvVFYMZBQfSdurBfCZ3OrOv1M/GhZBc4SolsxpPFzLWI6WH20UNDyJCo5er5zikw14zQuQ0kVQntSWZ/XUwb4mM9LS51hXJWEBmDiVXeKlgrIfOqOzRteN6huEFjLfYJ6DA9kJzstLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687958; c=relaxed/simple;
	bh=wr51kaAN8gDXRvz5oyws0wRtQ2/kmMO5SUsombtuTuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7siB3xXTE7l7YtCOpqe19Vsszjp1VOSKzax3HPEu3aflIK3yx3AHCtOlVIuG4t6YvNG/T1I0KRkcmgZghi3HuQFMHDFzQLIC7VBb/hxQlbirZl8F78zBHdPUUZePYouqNDaEJb6VU7fOG+0+Ssfk6E8HxIlyphCTIgJdmVMUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=CwWqb4UX; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-268eec6c7c1so3193334fac.3
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1724687956; x=1725292756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwu8uf5G51vXpv3ghWts9mRgAKLkY/6ySNnnjL0Jj38=;
        b=CwWqb4UXnzCqiolF/sXS5U9/ClnFvxlWi8SY5JLg6sD5JgiYAuwX5A4DQiFLnYzldc
         jdqhnwnvVwmlJ1bpgwL3Bu0vxamAN8cJsirlonmPabzqinbjVISTZOku0GNoRmJQxMIl
         9LFJQiOnc1ooSOvHwvq0JflyY3mlpDxzFFDvo7gFemvq/67ds2oc5RTr8Jon95LyHp4V
         ptwzII4wb8KStji0zcGU4dIrgHOy2uXIZddfiXxvCao78dvtPr2+6HBhOBm9L8cSiBDM
         nTtrbmdgEQHs0GuwwNAVQgOQIFirvukjv1xcIfjpmjON0OXSzrWt5cgFTwy9XTD8WQP2
         lPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724687956; x=1725292756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uwu8uf5G51vXpv3ghWts9mRgAKLkY/6ySNnnjL0Jj38=;
        b=UV/Z+QTHkq1NdCT+EYclTxzjBroH9mIjkX4RbO9C24V+4RahOSUSw76ULGDX3zuMj7
         2XD7nOhmajA85PUCNishxpgDY4skTB5MnFH5Lc7cGT2lK/ET5nID1bscOJJt8Grqe7D4
         Ud/lZPJaiGAS/EJIi8WEv1etSkVS+EO4QSnoXmtmPWbaTp3h7qYK8GkCpPvz8gKQgyQg
         FSOUdRVWSPXsNDgKfBujKf+HepazdPILqwXkUNuMJ70fFVRZzTF1m7vQbJ2ohVrXcmeY
         U8NTiRaDOatLw+t3884UV6MIkTc0HbYBppCKzACz90lF6KTWVra0J6/iJ38v69ADjQzt
         fNeA==
X-Gm-Message-State: AOJu0YyYAJHYUM2fFZTuM2uwy6FhlywHwgzs6EMQJJhrXlYMiwojK9e7
	yXurwEPvSJVxUJP+c3U0DIrtZHjSYtIk6rSGdiJ+vNXIw3zPhRPxP3o9483W/xePuin3v7/SoFj
	i6LwQ+w==
X-Google-Smtp-Source: AGHT+IGRRkZtdYHsnB3dOiwtSBCFUChVU5+sFHKDZoboV7FFTOy/Ej+gz+Wk1jx13cXgp4og0uc5zw==
X-Received: by 2002:a05:6870:f2a8:b0:260:3bdb:93a8 with SMTP id 586e51a60fabf-273e6725ec2mr12428476fac.41.1724687955930;
        Mon, 26 Aug 2024 08:59:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad552aasm6720510a12.59.2024.08.26.08.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:59:15 -0700 (PDT)
Date: Mon, 26 Aug 2024 08:59:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH iproute2-next v2 1/2] ip: lwtunnel: tunsrc support
Message-ID: <20240826085914.445c3510@hermes.local>
In-Reply-To: <20240826135229.13220-2-justin.iurman@uliege.be>
References: <20240826135229.13220-1-justin.iurman@uliege.be>
	<20240826135229.13220-2-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 15:52:28 +0200
Justin Iurman <justin.iurman@uliege.be> wrote:

> -	if (mode != IOAM6_IPTUNNEL_MODE_INLINE)
> +	if (mode != IOAM6_IPTUNNEL_MODE_INLINE) {
> +		if (tb[IOAM6_IPTUNNEL_SRC]) {
> +			print_string(PRINT_ANY, "tunsrc", "tunsrc %s ",
> +				     rt_addr_n2a_rta(AF_INET6,
> +						     tb[IOAM6_IPTUNNEL_SRC]));
> +		}
> +
>  		print_string(PRINT_ANY, "tundst", "tundst %s ",
>  			     rt_addr_n2a_rta(AF_INET6, tb[IOAM6_IPTUNNEL_DST]));
> +	}

Looks good.
These strings should be printed with
		print_color_string(PRINT_ANY, COLOR_INET6, ...

but that is not urgent. Just to follow convention.

