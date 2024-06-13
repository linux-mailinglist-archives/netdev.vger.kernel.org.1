Return-Path: <netdev+bounces-103197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7D906DEB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3B31F246FC
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA15B146D63;
	Thu, 13 Jun 2024 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Foh79bNK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DC146D5A;
	Thu, 13 Jun 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280048; cv=none; b=BIJ8WHBuk+WuocoCiV7uJeJlUDKd/uKM9HArryvt3RwgSNdugi4Ya4KChxm9ylvfRrKaZLm6x8PKPCD+7hvF3RVWA8PziMoJOKhqFoijxUMgHqPjITOwDtjRKQcMFM6yAee+7Dkh+z2lZS3ybpg112KbOwXGTvYF1CsenKV1LOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280048; c=relaxed/simple;
	bh=VCaWpKvKsf8aeow+BOy3YcYegLQYBswf/quMQlM7fv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/GBk5CYe6v9AhM4229fYggfZ1bSAAQCKfrHUUJSUM1NMqFoT3x9IjQ2Ka+/TdLG4jO3RuAF7qt/MAPgZEoUYXFunQqBzbLB3Olj60E+em+Ffqdy3odRKaj0DRU48CovUvwKCfSbZlsBLIKlBDdvrVFjQflh77dQ6h4/oCIltUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Foh79bNK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so118263666b.1;
        Thu, 13 Jun 2024 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718280044; x=1718884844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPRwwOATHBboUMQ5qpsDj8UiGy7DXVjepVSWy0R6Kgg=;
        b=Foh79bNK7kNRnOsdcwTqmREWyedbK/nJ7hSktP/u5lGtchBNyNP/5+24wmVbU3j5KJ
         mJjF2us2HF9T2cloAgbd/t10B7hOqmZhhV823tytnQ6EAm21E6iSVk32P5qgbSGhjLv7
         t62OaZJy5pVBjYhTFeMcL1rKYzqfZzZySGnwsS314sMJClyZ8oI2PJgFuRL2Js6mXLh0
         RaWEWKmPdhYDcHvwIKJvc+E7H2LFShzgdzwDAfPYkE1vxvN/xUMmjTLicr6lO2HOW3kr
         smJ8NSwkJ96hA6C/d2Ve9hlqv7nypc/YW54EWXMK+o7BUcM3Xw42e/Hd+1JnBn4S0IKP
         6ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718280044; x=1718884844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPRwwOATHBboUMQ5qpsDj8UiGy7DXVjepVSWy0R6Kgg=;
        b=qncoOCJVU57N3QH+RjkBvlQ3NXBRMjjntq7Q/ObIIGQSycVCRqXT8Vd8xJuNP1JLqj
         TGRXrMk2O5PuRFNKRZDwGxNNXIPb0pt4u7XoIA9G7LgIZEbPlJcebHyuxJHxzO8o0/IF
         yz6gkkGR1ZiRvWny0SQEgwwhtFoV5hCr+rE9rm85zH6jCc+ko9Oo9LhFo8CmQzPAB5gH
         m2u8veIK952I9/489KJTqlAFO+sCIzs6yMccHZxOEK0PyriETFCetwrA1mmrAIhofmez
         cJGn35pPjnChXooAQTfDxUB21ugbifR47MWN/HA+wxuIDmJVR+wPf89y8lpkMbkStfVt
         fTzA==
X-Forwarded-Encrypted: i=1; AJvYcCWPIvAEKRcV4TgyvXC29xjygua1KkpApPovLlnNrhwJcyjVG+7Ts9Tqqx2JG1R/qLxTcZDeoss8cfpnUJjtxPNIL8W32ORONVEBV5zbECwZJosgYYH4Q08lrKF3PjPeP9E0oSmdMMbz+wfRzHJWURKG0EdU9G9zVQmqh4WTLrDdFQ==
X-Gm-Message-State: AOJu0YwXa1PB2DvbKFcYdxqTOyyesvIvCSZYxkmNzFL+NeHt2z8CYsia
	tLe4mDiAdopO76PoC133ikDwolH1P48sGhbhshD3xUumoAbCGTGH
X-Google-Smtp-Source: AGHT+IGQFim6/LpV7/25BmdBbyWHw3U4AeNU/KDOJXCcHnjGazpE7NDtVGZx1uedscJI9EGp3brLmQ==
X-Received: by 2002:a17:906:7086:b0:a6f:37b7:52e5 with SMTP id a640c23a62f3a-a6f47d35a2emr286017866b.3.1718280044124;
        Thu, 13 Jun 2024 05:00:44 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6201sm64972166b.80.2024.06.13.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:00:43 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:00:40 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/12] net: dsa: lantiq_gswip: Consistently
 use macros for the mac bridge table
Message-ID: <20240613120040.agc2vlurospupqui@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-10-ms@dev.tdt.de>
 <20240611135434.3180973-10-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-10-ms@dev.tdt.de>
 <20240611135434.3180973-10-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:31PM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Only bits [5:0] in mac_bridge.key[3] are reserved for the FID.
> Also, for dynamic (learned) entries, bits [7:4] in mac_bridge.val[0]
> represents the port.
> 
> Introduce new macros GSWIP_TABLE_MAC_BRIDGE_KEY3_FID and
> GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT macro and use it throughout the driver.
> Also rename and update GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC to use the
> BIT() macro. This makes the driver code easier to understand.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

