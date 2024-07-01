Return-Path: <netdev+bounces-108198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2B91E550
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67D32845BA
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327416D9C1;
	Mon,  1 Jul 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXgmAbXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38916C86E
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851246; cv=none; b=sHC3NPT1vH5QpLVUMfttoAoGzb3T8vDXs1oMTNeReC2xBHbi2JvzNzUZPZvmERVtQXXQW8FJyOaa6hk/Jt50HWSlFM0iINaQTJEXlMNMYwVpEpqGOCKdC0zxPfIX8YR5n1kSZEFJwIF2WgbOX+1Er3FIjKxcUUuObURxBTSAkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851246; c=relaxed/simple;
	bh=F/0fyD3tuLE75kbEOFk9w0FuDMPGWs+Q66+UszKetXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COSP9wJRKy0WBdJfZki21Z1wMlzRAVRgFa3jllvAH7z4Ef+8exVUjYNXZbGkuG3vw97LZVHvl88gcePh1HPnOfu7QS+5jQmrTbwFi8bTRUOgccBDChLO1uWWp+rE9/F54/QJdMEzkdRKk79LBi4PaEOZYBme5HvCfQOC+K1slQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXgmAbXK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f4c7b022f8so22901625ad.1
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719851244; x=1720456044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7UBY+UV1dqUs886cQefaoyGAbVXuttEZvsE7IUx80NA=;
        b=QXgmAbXKDcriOnt0SWZQTWoQO8yFZ7p28URMAr7VB0GLz3pnAtUspOsQzEfHkIeY3l
         1M8WNUxz/Bb7W5m6SVrl+Jkn5Q7Zevjayk3zWEn95ddB5WuDb900I5f8rkW6nMfXdOw6
         mUWacWMjwopEXl7SY7u+DvEULF1bBwvtlfYF7YrBfUjA5CYsv+PMmzIaAUm6uLOLeypm
         Ao8qJuvI4moX90t20kx9Frw9iOinegs5zvTc/uBxrIPy+8mhvZgj6KtI1QDQ2vuXr6aB
         iDom2ueesjvgoUQ51AmXii7i5IVYeyPpRtsXTtPqtrhUCIO1yjX/zIsCSu+SKasrQNQJ
         iehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851244; x=1720456044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UBY+UV1dqUs886cQefaoyGAbVXuttEZvsE7IUx80NA=;
        b=rta6xwGnmIJtbHu5b+eg1BtkUn1fUu9/fNZvmlYggGIKtTBDJlluOuONfFwu1nlCQx
         CIGkAayUILv0X+IrNstynLVMvuzfS13TxEaQTzfR5nssjZ/VqZStR/e6ub105z0HbWqL
         ncfoVvi2JNO/0bxwNcpYoNg2mYfgCKSQKUKQni114ExSAazXWpqqNsLMfvWFKm9RmEh9
         oBYJHlqsGk891VF+J6MWChJ+R7S3KVJ053kfHyR8nhhr1b0Qd6865+Zwq3nL1n+63vt+
         j8TgH6OSGl2D5Xm80bHUId8SUygG/5s41fvuudRi6kWHrWLmaJV+BS7QpYKv37aXMRGC
         qaNA==
X-Forwarded-Encrypted: i=1; AJvYcCVTXwgdzAuvA1X/pH/jgq8CrYybps838sZSIHlDuLzxvJZ5qdpa46A8sP4zoQxboZ5MGDR62bif5bAB8NrIAxy6Aj8XCXXB
X-Gm-Message-State: AOJu0YwzOngbMmbveDbVDmyXdHbmAfS6ERqNdqNk7UKUwKo1U/qXLx7s
	/NP8YQlYeMssNFRLtaKZTKxAdczDZw6k/3Cua8MikmTd00/vCe1FpBIDjgZVGA==
X-Google-Smtp-Source: AGHT+IFQozfWAuNmYJp3g/hIlVwVj9JRmtZA00eZM1uMI3eaJG4lXuB+faND7zWMLiQpbH3R8hTCUg==
X-Received: by 2002:a17:902:eb83:b0:1f8:46c9:c96f with SMTP id d9443c01a7336-1fadbd02087mr46513535ad.61.1719851242883;
        Mon, 01 Jul 2024 09:27:22 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c6c57sm66855885ad.53.2024.07.01.09.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:27:21 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:57:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Slark Xiao <slark_xiao@163.com>, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	netdev@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] bus: mhi: host: Add name for mhi_controller
Message-ID: <20240701162715.GD133366@thinkpad>
References: <20240701021216.17734-1-slark_xiao@163.com>
 <20240701021216.17734-2-slark_xiao@163.com>
 <36b8cdab-28d5-451f-8ca3-7c9c8b02b5b2@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36b8cdab-28d5-451f-8ca3-7c9c8b02b5b2@quicinc.com>

On Mon, Jul 01, 2024 at 09:13:50AM -0600, Jeffrey Hugo wrote:
> On 6/30/2024 8:12 PM, Slark Xiao wrote:
> > For SDX72 MBIM mode, it starts data mux id from 112 instead of 0.
> > This would lead to device can't ping outside successfully.
> > Also MBIM side would report "bad packet session (112)".In order to
> > fix this issue, we decide to use the device name of MHI controller
> > to do a match in client driver side. Then client driver could set
> > a corresponding mux_id value for this MHI product.
> > 
> > Signed-off-by: Slark Xiao <slark_xiao@163.com>
> > +++ b/include/linux/mhi.h
> > @@ -289,6 +289,7 @@ struct mhi_controller_config {
> >   };
> >   /**
> > + * @name: device name of the MHI controller
> 
> This needs to be below the next line
> 

If this is the only comment of the whole series, I will fix it up while
applying. Otherwise, fix it while sending next revision.

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> >    * struct mhi_controller - Master MHI controller structure
> >    * @cntrl_dev: Pointer to the struct device of physical bus acting as the MHI
> >    *            controller (required)
> > @@ -367,6 +368,7 @@ struct mhi_controller_config {
> >    * they can be populated depending on the usecase.
> >    */
> >   struct mhi_controller {
> > +	const char *name;
> >   	struct device *cntrl_dev;
> >   	struct mhi_device *mhi_dev;
> >   	struct dentry *debugfs_dentry;
> 

-- 
மணிவண்ணன் சதாசிவம்

