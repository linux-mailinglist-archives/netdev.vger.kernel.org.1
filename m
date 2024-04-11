Return-Path: <netdev+bounces-86937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D248A103E
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D682D1C212F7
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E414B07F;
	Thu, 11 Apr 2024 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9pcmQrL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF914B076
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831498; cv=none; b=Vp3JLS218UJybmtFVLSdMJYuntcyIj401GApAAEwe+dUwu+8JgqcgrBQuetYO9lZGSt9HovUqwEpi4OpHMRnWfJdBN7DL15AU4BKMnYfmsKfHkNOH2xiqWulAXs0q1G42qECysvs4GBAVrTh2yj7MjWK3vU+rBgGVmqeAS75mYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831498; c=relaxed/simple;
	bh=WaXysxKJe+vS1i8j5oNGaoke2Hd03sYBfChSAqV5DuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTjGM1LZt7/O0gG+3PiuLkfpNvCSfP+Xpax0Tt/G1DRblHwNm/S9MnHPHZtBjb+m/4/5NdsJQLPR+qz5OEHO3lsyI4K/6nH/6Hb3dSlY3wiQxCJ9uPy6FlnlvaDx329UJ8p6BxZ59nv8W84aCs/QJRixGdwmL3e2sPrMIIgQBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X9pcmQrL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51ddc783e3so516889566b.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712831494; x=1713436294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcnjoJrjLylLXAH3rtU2vKqJq2FaC8fgwxIrZFCTV4c=;
        b=X9pcmQrLIlBOqIqdWBYOi6BbTZyrOy0WDTlLlM9aR2rZy00a11AVoM1d/I5vuXgz4y
         hlBZwSoXZy1Z+xLOzRINP2sAlNRtKZr/wVCLADfIreAK704WxjhVNCMmqaSjacX9f5O9
         wI93CZGmvdcNNXstf1e/fLKBARp/1ieP87oCNbTJMDSU6ExdSH+gkmXNtY+TYe4WazsV
         t9r86dzKsM/BaHAsP3VwguoABsO6ogtzeK0bZ9u0iXlijJl/dmlPGpdds127ABt3nSJn
         JEHG65cU38v4HGuLa13ttkRkLeD5jeyZnyeUm+eQMDK2P/SxFHMlV+W/w4RINc0Hmbk5
         93qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712831494; x=1713436294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcnjoJrjLylLXAH3rtU2vKqJq2FaC8fgwxIrZFCTV4c=;
        b=Hu0+gFJt725l35X73IwANOWyCMhsM8wJES2RtW+65hDy+Y2TSaXFPGmFe2cw6pb9Ka
         bF+8S/QuKz57SoM0VTgJXJ6gUfwSwZ7AYPvo+YVEQQesd91Vypmcao6xD+ekIJLoTeYf
         Kjd8TIrohceLlzaw9O8R7LaWtft1Jn3tEkjz7+mDZlIWFBsMJ62mD8OzR9V3zsPRd3/C
         EQ+Q4aGU0S4yhb4iGAp6uzNlsAxkSKaZ5lk1zf2bpaO3Ed/p8WEe1NFjMFij5Y2HeZaj
         ZT8FqxVXLT7p4I7M2kvXvc0btx3yXZZPLRxzopuUY13Wq6ucV54IURWiTLONP8thSGHU
         Rhmg==
X-Forwarded-Encrypted: i=1; AJvYcCU0SNUMGL0JO5iwyZEV3SWxWhtd+3rXwH+IKt4WOLo+Av/lK/zAyPaFpLXcGUctCuxT7ZAoOmXjCcfd5QCmISTMEGqIqMpK
X-Gm-Message-State: AOJu0YzmftO1Efty/XCTvQqgqf1RjdODRDX8/83jEf+gksAgnWtbz1yX
	70IkA6JqJUV8d1/tMCy6nmlB3Ze/4F+mN33iX82iH/XQodhOLn7/r2h1kMqlp5s=
X-Google-Smtp-Source: AGHT+IH4wZBnbCaLwIvzN1RatSpqcPKcnXIaR8FNtF23Nq7ZPqPfkqzwLsjxIbox0YwuhK0SFzIL1g==
X-Received: by 2002:a17:907:9302:b0:a52:1466:4d1b with SMTP id bu2-20020a170907930200b00a5214664d1bmr3301095ejc.17.1712831494384;
        Thu, 11 Apr 2024 03:31:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id kk7-20020a170907766700b00a51def4861bsm618040ejc.91.2024.04.11.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 03:31:34 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:31:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
Cc: Colin Ian King <colin.i.king@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] tipc: remove redundant assignment to ret, simplify
 code
Message-ID: <ce0a63fc-1985-4e25-a08b-c0045ae095f4@moroto.mountain>
References: <20240411091704.306752-1-colin.i.king@gmail.com>
 <AS4PR05MB96479D9B6F9EC765371AA8A588052@AS4PR05MB9647.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR05MB96479D9B6F9EC765371AA8A588052@AS4PR05MB9647.eurprd05.prod.outlook.com>

On Thu, Apr 11, 2024 at 10:04:10AM +0000, Tung Quang Nguyen wrote:
> >
> I suggest that err variable should be completely removed. Could you
> please also do the same thing for this code ?
> "
> ...
> err = skb_handler(skb, cb, tsk);
> if (err) {

If we write the code as:

	if (some_function(parameters)) {

then at first that looks like a boolean.  People probably think the
function returns true/false.  But if we leave it as-is:

	err = some_function(parameters);
	if (err) {

Then that looks like error handling.

So it's better and more readable to leave it as-is.

regards,
dan carpenter

