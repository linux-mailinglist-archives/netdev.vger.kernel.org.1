Return-Path: <netdev+bounces-137928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E09AB246
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71491C2232C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA41A00D2;
	Tue, 22 Oct 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yg5GZziJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA419D06D
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611560; cv=none; b=GPOz+y0EDKaNWavimi3OgXrwgVTgVj9yPOglbnEO4P40XIW8u6vs/9cf8sP8n4GsLfcJCbbZxdCXvKEDDytarclWFMSDbPbsk6FD7WycnLMP/jlbL+CnFPwoOQgZo+7hWzxaUP+v6aCCgS2enWZHQZ7uYQDuE2Mjy048DUafzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611560; c=relaxed/simple;
	bh=KyehdRFnOqClt4ckcijRDX2btN2UgjYXojkVtGk19rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMnV/XbBAt6u8gY3EgqQXX8WY8M6w9B25WJfO06tKOyQgmFtO22Lw2qditZpQTcTDyARy82GHdHn/totExYwly/fLKnWWd9qXvAxLynaTLESIwV0RmcB+8ZL5jTWtZdfYpyhfA6hCEvHsHttbH+Gt3kWzkIILogvRpGfzLOxMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yg5GZziJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e983487a1so4140015b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729611558; x=1730216358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4UhBP+lxA4PuI1pN/Opr4ffBjn9LJSMHIGdfxJak84M=;
        b=yg5GZziJfv9IcGwyz9GmsygvMkwdTDM0Aq0gC0AKOdl2ULRcJ9GDmP8Nuqe1cTrPIw
         HMxDuMZ8vAaydUl0x3S1a6vUZqsSf7p2I4mZ9Yx8tjUZD05LwqIFMJdz0pWRryXpcIcQ
         P7boRmE4/VKE+vzBBq9mhpEWNPpqXzQXmHRwReZV5iWpgCJOkUGG5K8r0tJTQS9bTVoc
         1WgbsrSUQTkwd1Ep7L9ogrKB/8ezpckhSnRVWCVh7THK/xDwp8kY3mX9KN4aKNiJv9PM
         UCqooa0kkBwE3/5TqoMArdcEMk8tPlYI8wCckpifSZearmcaQI2nEL0sWC696yp+2yi5
         4I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611558; x=1730216358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UhBP+lxA4PuI1pN/Opr4ffBjn9LJSMHIGdfxJak84M=;
        b=jaE7g7pobAagfurTF+V1N3a28WSLXzaT9kVCYM2Nj8deLBYcCF9v/Fgtr1RpyDkVkC
         tBZCIPldXPXvTAD2F2732LL1FG9966MYAEu+ydejjLUQrleF4ob6IRaua4Emo3V0zH6b
         D7veY1xqyPHLvbF7nm+vOozeCF7iMh+eLYAMfNtvbKJ0diFG+mD4DXwob7wvgDg3lSTP
         BYtUiZ92baEZ1i85Avmpqv4uJIFasBinzZaBIhXhAFTQ3qBBpYGf0ZsYFtRna5EudkeZ
         xvXH5hHGqXCwL4OVTdlyF4CcBLSs7sT54aZhQTxjkzBRkGWd+PfxnWLIPqZvXDU0fcGm
         4ZNw==
X-Gm-Message-State: AOJu0YwCnJpqsBT4T3DA0ZbkwBddHcqIuZdZpWCF6BXCQ6cbpmFllsDg
	e93yJuoP9L8fC/UugiByP3FB/bgxfNMGKen76PxegLWdzl9cGDiqMPwkJBHK/g==
X-Google-Smtp-Source: AGHT+IHTLfLxPFhRlrarKiYn46g4SklVOs57wHpWONQ2VMauVhk6JqEzb66pf6djTsJvgzguysbpeQ==
X-Received: by 2002:a05:6a00:318f:b0:71e:60fc:ad11 with SMTP id d2e1a72fcca58-71ee4b07d49mr2955925b3a.16.1729611558265;
        Tue, 22 Oct 2024 08:39:18 -0700 (PDT)
Received: from thinkpad ([36.255.17.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eb0c8sm4889990b3a.182.2024.10.22.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:39:17 -0700 (PDT)
Date: Tue, 22 Oct 2024 21:09:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Denis Kenzior <denkenz@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/10] QRTR Multi-endpoint support
Message-ID: <20241022153912.hoa2wbqtkvwjzuyo@thinkpad>
References: <20241018181842.1368394-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018181842.1368394-1-denkenz@gmail.com>

On Fri, Oct 18, 2024 at 01:18:18PM -0500, Denis Kenzior wrote:
> The current implementation of QRTR assumes that each entity on the QRTR
> IPC bus is uniquely identifiable by its node/port combination, with
> node/port combinations being used to route messages between entities.
> 
> However, this assumption of uniqueness is problematic in scenarios
> where multiple devices with the same node/port combinations are
> connected to the system.  A practical example is a typical consumer PC
> with multiple PCIe-based devices, such as WiFi cards or 5G modems, where
> each device could potentially have the same node identifier set.  In
> such cases, the current QRTR protocol implementation does not provide a
> mechanism to differentiate between these devices, making it impossible
> to support communication with multiple identical devices.
> 
> This patch series addresses this limitation by introducing support for
> a concept of an 'endpoint.' Multiple devices with conflicting node/port
> combinations can be supported by assigning a unique endpoint identifier
> to each one.  Such endpoint identifiers can then be used to distinguish
> between devices while sending and receiving messages over QRTR sockets.
> 

Thanks for your work on this! I'm yet to look into the details but wondering how
all the patches have Reviewed-by tags provided that this series is 'RFC v1'.
Also, it is quite surprising to see the review tag from Andy Gross who quit Qcom
quite a while ago and I haven't seen him reviewing any Qcom patches for so long.

- Mani

> The patch series maintains backward compatibility with existing clients:
> the endpoint concept is added using auxiliary data that can be added to
> recvmsg and sendmsg system calls.  The QRTR socket interface is extended
> as follows:
> 
> - Adds QRTR_ENDPOINT auxiliary data element that reports which endpoint
>   generated a particular message.  This auxiliary data is only reported
>   if the socket was explicitly opted in using setsockopt, enabling the
>   QRTR_REPORT_ENDPOINT socket option.  SOL_QRTR socket level was added
>   to facilitate this.  This requires QRTR clients to be updated to use
>   recvmsg instead of the more typical recvfrom() or recv() use.
> 
> - Similarly, QRTR_ENDPOINT auxiliary data element can be included in
>   sendmsg() requests.  This will allow clients to route QRTR messages
>   to the desired endpoint, even in cases of node/port conflict between
>   multiple endpoints.
> 
> - Finally, QRTR_BIND_ENDPOINT socket option is introduced.  This allows
>   clients to bind to a particular endpoint (such as a 5G PCIe modem) if
>   they're only interested in receiving or sending messages to this
>   device.
> 
> NOTE: There is 32-bit unsafe use of radix_tree_insert in this patch set.
> This follows the existing usage inside net/qrtr/af_qrtr.c in
> qrtr_tx_wait(), qrtr_tx_resume() and qrtr_tx_flow_failed().  This was
> done deliberately in order to keep the changes as minimal as possible
> until it is known whether the approach outlined is generally acceptable.
> 
> Denis Kenzior (10):
>   net: qrtr: ns: validate msglen before ctrl_pkt use
>   net: qrtr: allocate and track endpoint ids
>   net: qrtr: support identical node ids
>   net: qrtr: Report sender endpoint in aux data
>   net: qrtr: Report endpoint for locally generated messages
>   net: qrtr: Allow sendmsg to target an endpoint
>   net: qrtr: allow socket endpoint binding
>   net: qrtr: Drop remote {NEW|DEL}_LOOKUP messages
>   net: qrtr: ns: support multiple endpoints
>   net: qrtr: mhi: Report endpoint id in sysfs
> 
>  include/linux/socket.h    |   1 +
>  include/uapi/linux/qrtr.h |   7 +
>  net/qrtr/af_qrtr.c        | 297 +++++++++++++++++++++++++++++++------
>  net/qrtr/mhi.c            |  14 ++
>  net/qrtr/ns.c             | 299 +++++++++++++++++++++++---------------
>  net/qrtr/qrtr.h           |   4 +
>  6 files changed, 459 insertions(+), 163 deletions(-)
> 
> -- 
> 2.45.2
> 

-- 
மணிவண்ணன் சதாசிவம்

