Return-Path: <netdev+bounces-116800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B2694BC31
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6F92844E6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0718B495;
	Thu,  8 Aug 2024 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGCJ4Fa2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552B18B482
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116167; cv=none; b=rf6Emw/W4gfhmB8u8JuEc5KDyNLKbn73QGkrIEUFY1Hd11mKrIxFg2zxra7bicr5s0HSQAXjl8+UK+aTYemO/didbaYP6Wm2GKpAlhzY6nc37mDsDaEbbYk3CnvkPNEiKMz3HmbuYsKUZlMvrJFXGZL0fxIhOL9494hP+GS/e7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116167; c=relaxed/simple;
	bh=ODsm5pH6Nv0sga8hExSMtpjmnYVYISkHWKdCxOCCGsI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QNJa02Rin1Y1gP876xGlNIn1ZSXoG4w9H+3dEJE81AWs7t3kew0lGBtBXJLxPeJmicaQQQBtiOo3xv8BgNTLNHXm7Fx24mZ3YpilaQm8o5H6RHSbRB13DsS4P7j5CMOUFhzwH0QP5AArw+zGB1BWS+wyIx/l9LWZ/OKsGSCjM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGCJ4Fa2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso6190365e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116164; x=1723720964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKUGP0PE9AD005oieGjmMPIIMJBw4vdLnTdJKeF/xA4=;
        b=FGCJ4Fa2nMuXWIyNs2WSXRXArbEXEIrjCuRPYkXFmN/7cH3v8Y2dstRrsSfau4qOmO
         yn1hURi6yb8seE1gGH9PB7VC2+2Rt9kFkOwp6gEBwCirN6/+dofvnPDks+X0IQ07DpNT
         XX+/hSvggZf7gfBi8Uqd+1FBtW7HhVv5xT61XeChjz/HXTPD2PFFZtl3CNkXZXVCTWq0
         naEa4JQbTnAMMZfOArih9sm0Md3I26kOK+4Ojvt56KEn0h7AG2v549GFhqP1HwbbJF78
         KMJeovPdJ9EYNiHgT09eCF3osxzpYGMIVnLnFy9bBKCuJXuuWoO41wziwGi2cwAYz5xa
         Vkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116164; x=1723720964;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKUGP0PE9AD005oieGjmMPIIMJBw4vdLnTdJKeF/xA4=;
        b=YdmulhF/4Dt9xTi2X347fiaK0vFUQ5/7/3VvEQT9ubhZFsVuWQ7/PN0wpWvGHwjEjw
         //MspCWoTQ6RKq8nrn67zb4ggXfFVOVUeR7mZvilcu+MSzmpYOvytcDtzbf6ccP4BhSh
         bodizZieubBECiiWZYuVITtWveR6ghMaTtUm/rC3GpdmrkMD8O7hPHsmB42Emr4HrvTi
         3SxdK40lSwF3BLYP3+dYfiRpcLdaaX8nUtNdMBXaH9q3Vc8i+6xSaoC8ftIx/7LGakut
         HchZSoqPTFWmbKv6wjxU4FtQbQLYmXpeTYpFTx27S1vuOWHesy2lH3UA0q3hc4U2ybSW
         om7Q==
X-Gm-Message-State: AOJu0YzocgFEbEy693G1q0eBIkte9yCwgtvzbzxCHcnvxlARQp8njNHT
	yRVL7RcjxM4oFM3gdmvxLBmu3P0+L/+q/SJz4Ghm4ig4g9aSGyhQ
X-Google-Smtp-Source: AGHT+IHH3A2sWUEWwtaKGPLUrp8oRJ3SBqJRDJ33joKAA/nHqvwX+YZkfNDh2wx+IpPKLqbyYaR/8Q==
X-Received: by 2002:a05:600c:1914:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-4290ae03407mr14960505e9.0.1723116163780;
        Thu, 08 Aug 2024 04:22:43 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c746cf0sm18103695e9.19.2024.08.08.04.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 04:22:43 -0700 (PDT)
Subject: Re: [PATCH net-next v3 02/12] eth: mvpp2: implement new RSS context
 API
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com, shuah@kernel.org, przemyslaw.kitszel@intel.com,
 ahmed.zaki@intel.com, andrew@lunn.ch, willemb@google.com,
 pavan.chebbi@broadcom.com, petrm@nvidia.com, gal@nvidia.com,
 jdamato@fastly.com, donald.hunter@gmail.com, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk
References: <20240806193317.1491822-1-kuba@kernel.org>
 <20240806193317.1491822-3-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <2ff9da37-8389-a82c-4890-1dbe92e60a7e@gmail.com>
Date: Thu, 8 Aug 2024 12:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240806193317.1491822-3-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 06/08/2024 20:33, Jakub Kicinski wrote:
> Implement the separate create/modify/delete ops for RSS.
> 
> No problems with IDs - even tho RSS tables are per device
> the driver already seems to allocate IDs linearly per port.
> There's a translation table from per-port context ID
> to device context ID.
> 
> mvpp2 doesn't have a key for the hash, it defaults to
> an empty/previous indir table.
> 
> Note that there is no key at all, so we don't have to be
> concerned with reporting the wrong one (which is addressed
> by a patch later in the series).
> 
> Compile-tested only.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Fwiw,
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

