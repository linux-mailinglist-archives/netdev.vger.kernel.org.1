Return-Path: <netdev+bounces-123209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 605BE9641EA
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E611286208
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136A1AB500;
	Thu, 29 Aug 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8PaUcA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417D1A76D2
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927087; cv=none; b=siB8fWdz6K2GWwlVRdxj/Lg7o7ZCVXoDii3dtByRrrQipr4/Tv6VzQ3tMKMgLL/wkClgE+uuRW4enIA7Jd//RtVZG3wqzNQjD0X9sApygJA7HffGICdKLs9/6ek+OdgNVFDfDM/xqLJlIRNGrsj66clxOmhK49W5zai2SyptMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927087; c=relaxed/simple;
	bh=85nAiCVJwW62QrE2b6r88lCjF1lPmNgCQtLklbdsK4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIAWBwI1qnI5QrlZS9zVJHqKrOyFNlfZdnCmabn51r8NkYGXOOOLx/J5ganvzxVqy63BUv6EcaHVBhDI5CLESMOGAitKLXcFsb3hanQVtQ1mvP8GVdLBiXEHgo9MFS84kJgaHiJ6vNM88F7v9sNdBRMkqR6N8GiWVTiggrJD1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y8PaUcA5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so589352e87.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724927083; x=1725531883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ/w73AaDcXnHgRTfa/18n3sPpKrgC+SUsJfs6EyD5I=;
        b=Y8PaUcA5moJt9cLegY3MzGmNXt1jn6nP/fptdePOHLYDlWP6mMxUeIx5LnjFiLLdS8
         D88yl3TiB9vksXbY+bWWnffkYyMTWdFrhdGSLCAt0jgrfcH6rFKi8xxX0ToDmWYh89xk
         vEVuH8zsnBDO1I52+38E2Ku8T73NuiBea3fzs4OiFe4WCzL7eOpHshFx2rPnRNLfjXvW
         Q6OdkOjERhVTzj21EyU/BuT0TKL77Ndpa6AVDjx1uq8l87yNiQDkPxmScIxb2EbQDT2N
         QzrAWHEmZnLileDmOAHppoJGLUR3Qq25xsWQYrqUABeBARydWIzyugts+PuZczmzxQL6
         /hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724927083; x=1725531883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ/w73AaDcXnHgRTfa/18n3sPpKrgC+SUsJfs6EyD5I=;
        b=YBbqjNHTkHbhrebnXCtwTbiECpuB101Fh1iHtqQcUqyFoO4RVLLns5hUo1V8TH1OG5
         aY4Av4D1yqZ2W9oAYgv2rHR2pS0kKmXlAFu5gBKnVIGrp/bUZKNzedytt9moAkb4uBWD
         FaQJb9tZn2JtaLcPXO7Fq5JdSFmqtnEB7CTII5v9R44cSy6coktlMHpsgXT73A9nmlZO
         HvUdPjWKuLmlwbVj7ySNuenP6azNGljf5MDwOVRMQ/2zCrlJAYnpdoQ5D+QMFA8MheKF
         IM89gRNyyUkRqAs+Zhx6K4BRjyCqrlyRKt2NH933FpTaqkxMZohSNWW0j6xWTv9J/vtW
         8nYg==
X-Forwarded-Encrypted: i=1; AJvYcCUy5rYln3bKZvTG9yaGx74+UCk9wI+wtkEYXQJbyyfz298B7XANqILLyvX5g+ZNZvzc4sG7J1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAtDhjinewb+xqGnt3wyPPaC70Yq/9OUTT5mCEyYVFzm6LscQ
	trDGIenmCCGuIMKXSFCFvV/GSs+q+bm9VUIFpBxEjzCZgy6L6qTZKnuOrfXy9Vg=
X-Google-Smtp-Source: AGHT+IFvU8hzzwqySK6Z6GUIQ8oD4NTRyF61j/91mZyR2mOx6xG0K5M+rBICRiQtcdWNMlY5YDmVng==
X-Received: by 2002:a05:6512:b0b:b0:533:3fc8:88b1 with SMTP id 2adb3069b0e04-5353e5bf859mr1504710e87.54.1724927082870;
        Thu, 29 Aug 2024 03:24:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540840f44sm117424e87.202.2024.08.29.03.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:24:42 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:24:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, djakov@kernel.org, richardcochran@gmail.com, 
	geert+renesas@glider.be, neil.armstrong@linaro.org, arnd@arndb.de, 
	nfraprado@collabora.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 5/8] clk: qcom: ipq5332: Add couple of more
 interconnects
Message-ID: <kscjtfse3rkdg2sp2uzxiueadf5l66g253vrahfir364yk57lv@jbk4qfbricxx>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829082830.56959-6-quic_varada@quicinc.com>

On Thu, Aug 29, 2024 at 01:58:27PM GMT, Varadarajan Narayanan wrote:
> Update the GCC master/slave list to include couple of
> more interfaces needed by the Network Subsystem Clock
> Controller (NSSCC)
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5332.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

