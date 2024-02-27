Return-Path: <netdev+bounces-75261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1562868DD1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828021F23EBA
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AD139579;
	Tue, 27 Feb 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="BKnoe0JV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA213958A
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030315; cv=none; b=ftApBRUAsF/s5iKRxbCVNJL4zjntSfz0uU+PaNLA0QuAxZx27Hy7qIPyF8p+wc0W4vKc1P95zTczQDy0RWTY0WAt6N7Irv+hIO1uqbspYa70E4t5bT0P2x4UadMYRa0/Q/tAj6/W8TmvahZMLT46L87MGfrHx19S84J0/Vq/I9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030315; c=relaxed/simple;
	bh=f9Hw8otfee5jKWQP9fZtjkbxyJNoJM5ibGuMLhKdd/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8ePbhXnA5nEFgRQw7WYAzytzBJCyVO+g0oCQUhNpZoNO5vMU45D8pPXU6anXeAb9BSUtqD1cOa4rp1XbSNIKMLpXrbAl+BRfVRgI6pL8/SNWSWvu3aK3YyjW/uijqJ+HlVMM3Yh9grFkWyLkWmTvx5isBCOCNe579WHc+UsOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BKnoe0JV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a4055897so16882275e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 02:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1709030311; x=1709635111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7VwNbN04JWTallq057/EBC9NJOCUI5wMaFIDU4gVgcQ=;
        b=BKnoe0JViq9F4qrMZpHDQNOi073OgSF+HuDh3AVw5nmgNnmt1ZBOczbX/DTZOn56Ed
         8WIIIXDLNks8M4ED59p6rNMA/iQaslsnqNQHrOGJOMQ/KJB+B5/9vFMHZ2CXq4wKAuTW
         nGhezwYWSAsbP/FT7dpfD5VxKlb7MNYfzccJCYkXwshxo5YkBQnROFmJ1PBN0FE1hpvK
         TK5t3UHLgOgZHpwMOWmLPK7UYlJ2Lp0RgGrLhZtjj9PES90HjLP4jNX047J52Vc/dF6n
         J1L3+jaRF4tGH23bqKleA6afUuBWGoHj7KVqMJSUtBBSLzWFOESN0FvEKQQ/MjW8gNxL
         nCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030311; x=1709635111;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VwNbN04JWTallq057/EBC9NJOCUI5wMaFIDU4gVgcQ=;
        b=AGTD9xWKwDFV/aNcPQrHizDpwlnzfMjDWdmVUEK3YOPcDbPCKlXA6pMB9OszcUljeo
         EYZTPKPPAVPCL47jKtHSZ6b0MvJ1QxjhcnbRnpSKmSqvq3LXORKMfctCJqxM0K8JL2LL
         BRk0gwZN2kQzQpIGCghlweAFlt6kLf9FMmLrM4CtzhC7BEElUOC8UMf+wweAeWkI37NS
         Y10YQz2PF7ryaNlh9WE5QSMaWheFvbhoCmm+Uq3j9YNV3GiOWY1J/bSEoLUjf2xQkOfq
         4FVWR58G3rcegwIdxRCOHTwXwXnlqkF1oUGmGFWP2wtX9+ncxh2EntLfF7dUVbNWeZqi
         yxYw==
X-Gm-Message-State: AOJu0YxPa1pANOOqZBw5fnw+qN0g1DqDWaGrgvb13xN48WlXGkl0HEJd
	yBgowVZCO1wdlmCDHW8ck69LjTo7WWdPVTYcY1ro24i5g9zSR9gLNo0z0I0Uf4w=
X-Google-Smtp-Source: AGHT+IEmgS02CaEoNwSPVo7iVrWfYGXaQbKxBzFBuTdroiWpPlk/obT3Rkw7g1fgoIf8tPmxn/gX4g==
X-Received: by 2002:adf:e34d:0:b0:33d:a943:48f3 with SMTP id n13-20020adfe34d000000b0033da94348f3mr3862109wrj.66.1709030310936;
        Tue, 27 Feb 2024 02:38:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:535b:621:9ce6:7091? ([2a01:e0a:b41:c160:535b:621:9ce6:7091])
        by smtp.gmail.com with ESMTPSA id df18-20020a5d5b92000000b0033dc3f3d689sm9926352wrb.93.2024.02.27.02.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:38:30 -0800 (PST)
Message-ID: <38213599-2a3f-4d88-b9cc-acc1f715545b@6wind.com>
Date: Tue, 27 Feb 2024 11:38:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2 01/15] tools: ynl: give up on libmnl for
 auto-ints
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, jiri@resnulli.us, sdf@google.com
References: <20240226212021.1247379-1-kuba@kernel.org>
 <20240226212021.1247379-2-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240226212021.1247379-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 26/02/2024 à 22:20, Jakub Kicinski a écrit :
> The temporary auto-int helpers are not really correct.
> We can't treat signed and unsigned ints the same when
> determining whether we need full 8B. I realized this
> before sending the patch to add support in libmnl.
> Unfortunately, that patch has not been merged,
> so time to fix our local helpers. Use the mnl* name
> for now, subsequent patches will address that.
> 
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

