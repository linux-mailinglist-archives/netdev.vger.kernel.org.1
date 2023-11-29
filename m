Return-Path: <netdev+bounces-52154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C457FDA45
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE86282678
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A5315A6;
	Wed, 29 Nov 2023 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ITWudZqc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF30610C3
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:47:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b427507b7so28782745e9.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701269275; x=1701874075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GslxNtb6PPSbqhj+SL4+0cnAIH0pvzJXG8XzOy3oC9A=;
        b=ITWudZqc9MQLekM/o0ttdK597B1hpabWKBJ0hR5eC8/JvWBAelbZcr+IQDlGOfRucq
         1LWiCLba0xxI/8e4tdcOAyk1dmhPzEhB/Pc8hJ75kkxB3G85eJIBh4fhJ0eDHx6DWJU0
         eURSj6iVUrZ7jTe4c0FGeZFgp6IoXbTHB1zgxs1eoWbJ73E5PxTUbYJjOn8RcpGEKbcO
         Hff+0WNIcovup01KqilgD7FSVabY1pKWHUUkRSsH0dlafzCOiJ/iByleWTJfdB7pLnSw
         9Ee2qMDSsNuhVBLiVAaXdjXZdV+4w+rKNQHFplp/tdpYrq7FHJADD5FXoov706M1yT6D
         Dfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269275; x=1701874075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GslxNtb6PPSbqhj+SL4+0cnAIH0pvzJXG8XzOy3oC9A=;
        b=Inqn5fu5k6UhntkflTNZDovmHXJ2IUPLEPieaO+WKxT6xh5tQpUDCrRqgwT0wpRnyv
         F90QZqpmvjTdRUwwecTq5uA15MftBfxainDa/sQnYwiujieGlS/zxe1j5PVOyJJrf2tF
         aTgrRCpO//VA3X1Vnhvf016t+GYj7wzysWlfyRDCnU7fBqCvd3j/8ionqDbu9+VyKIE2
         ILn6mx5aIVGJcLJfIZ+CAJohNVt4lmgQSWaBcSvPWUt1//uROz227Sx+YpjKWDoJMaGn
         dVkUveyVMPkjZ3FpfCA4F5gMF0tz6A92MDMwmPx3JaFxgKOBH2est34qgTPNsIf/nI+S
         E/bg==
X-Gm-Message-State: AOJu0YyJ5cpgDzFcJKfwCFTGlvSvUbhgBdV5UTq/ha7kzlyNBhh5jNqd
	cBl30CPWurXz3ayRoWjfy3PTqQ==
X-Google-Smtp-Source: AGHT+IEnBYi2RWaQQmw26oeqgeVMqTreeHbMhIVCzg6y3e6heZYgvhbZy/KQHEnbN7ppaTzyXM/6kw==
X-Received: by 2002:a05:600c:3b22:b0:40b:3566:e54e with SMTP id m34-20020a05600c3b2200b0040b3566e54emr12253902wms.39.1701269275167;
        Wed, 29 Nov 2023 06:47:55 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b0040b3829eb50sm2461432wmq.20.2023.11.29.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:47:54 -0800 (PST)
Date: Wed, 29 Nov 2023 15:47:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Breno Leitao <leitao@debian.org>,
	Donald Hunter <donald.hunter@gmail.com>, corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2] docs: netlink: link to family documentations
 from spec info
Message-ID: <ZWdPGD1AEDZgwPfK@nanopsycho>
References: <20231129041427.2763074-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129041427.2763074-1-kuba@kernel.org>

Wed, Nov 29, 2023 at 05:14:27AM CET, kuba@kernel.org wrote:
>To increase the chances of people finding the rendered docs
>add a link to specs.rst and index.rst.
>
>Add a label in the generated index.rst and while at it adjust
>the title a little bit.
>
>Reviewed-by: Breno Leitao <leitao@debian.org>
>Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

