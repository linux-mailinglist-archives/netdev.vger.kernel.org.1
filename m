Return-Path: <netdev+bounces-188601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A3FAADD13
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BC19A3999
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9002144BA;
	Wed,  7 May 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+FtGndM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8EA2135D0
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616525; cv=none; b=UQ0XyY6TKxl4+2+Qw6foSVM6a2O3aUhs7AMCFXyXQN2EH9XRsZId3LggI0xSzOlLEOs8NOKDyId4g4mLiJciaEOmSm/8K9Kbl+MJc3FMgrC61i+gF78yMClDs8XphE2U0FJQZ5DbOE46M+bxDZKMXYbEawo84co3+UFhA5nsppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616525; c=relaxed/simple;
	bh=MfZtBXX/WL/wnlUKMr1y6MpVWBp8aWJBWS/BUCsQ1FY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=TJNM/7vz70lUM+9/VZaWUGJkgLavkshMMUrGsPbsx+W1hxo4ztfdXcTVLu2ZTPUy0HV8NZGUxLkuCYS+64W8C0CaOCG9p/Blr5kvYurCyzkOpGUdXDbEFHx0iZTGpxa2XL2M0M48kXdOVKN0pAT8sWe53ugW9Tu02LjO/G3Qgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+FtGndM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so62780975e9.2
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746616522; x=1747221322; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfZtBXX/WL/wnlUKMr1y6MpVWBp8aWJBWS/BUCsQ1FY=;
        b=K+FtGndMdlrEDShYtwAHn7+qqD6qLm+LVv0JbP8MINlSPbiqbstidAgZ2tz1P3f7tH
         UHGRE8jxveTRGUKz8k+eDjmq+eRjnIj9/OKJ3fs6h4xn0LqgnA0QRxN/Pnft5rvd9/ER
         Wk+ZsF1vH2FozGpK2DgMIocQwij2R/PuevDz3co29gZxdjt2OrrXVatZiO25lETDyz4W
         On3uEB9VyCI51/SyvRorgz7PprYuSvT4z7EtmZ5m1oGGnfFAhYQGhQqQl1gCoAB/kOeC
         hhSy/wPIjhnXwSAnoIRPpWDSsosYZXAtrou8VdeGhsrWt45bj4YoA/suls2eS57EYlyq
         xCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746616522; x=1747221322;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfZtBXX/WL/wnlUKMr1y6MpVWBp8aWJBWS/BUCsQ1FY=;
        b=jd1sD7Sl9wm5a7TsMITcvdgzvQpvA2QnG6ro2/5N/MfBemaxtawBOmBS8Y7iZvZBUb
         ftQsNAl9ucpvvtdyTlEpgHG7j2xEnI/Hc+2uHyg1xLHIQGNLtgP4lrVf0k9VMjd3l7oX
         31UCp57W4CyJhOfYN6aGZPKjczY7X6hnUfw7yhHdUJ1LuwZXNMcz5i2MOxsB0+XCRPF4
         u+RXf7BBCX/NO3ygShxhaW6i0mf9WOqvZjQGMAnqWyJx07LYHeFHHesNaB8QeHfL2LzO
         PtJ9w7vHA60q1AVhOzzHx3uN44PuBEjhCGXO+rjrYTktBz104sLu63KLVUjDkgWl1r6T
         SJdA==
X-Forwarded-Encrypted: i=1; AJvYcCWtYUpKYIL/yAuRvr3Smyn0nQxeWoU5TRYBsB6HhEUxv6BAvl7zM/U5GvoWbkCaF6UiqJxZZwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnhyG/qnllo9rA3Cl7h9YqDpH3LPD2ANhvyovGjcnKr7oDj5R
	LwvIqtF+jtTOrWH43DUv2NmvTdudkP/picXmBzX8BYv8hJPyMBIa
X-Gm-Gg: ASbGncvjq80bZHmXkW4UBPbwbh1+GnlEMkx3QLnoG4B1/jh9A9ZrZEjFBLWVlEDnQJq
	99slpZ+PYQO8z0mHirxW9/+sYpruAiEWlS7qFm8f/UzejXWizdLSovNWdTUMBwznZZu7RxizICg
	+IQQhtWyYYJO83hYaEMD83Mc8169OPMhTi6HzsZXulkeb3Ak9W6xOszLNxEmmM8Brcx4A3zTf9E
	H/S8vpqVnFPV704vuduiJYlW7XIslD4TWrosq+G3HLPkiKznMvcyxUc5qL9j/cuH/QaY0aaW4D8
	0d851T7e2+r9d58CCogd+riHaQHmBN5DQbk6SPGPXz/TJzOEJAn8c4kW7C1WOMQr
X-Google-Smtp-Source: AGHT+IGsepQ+KV6NbPIZglKE83MTMDlPy6EqMhB5uG2oZt8PipvFmMoXQr/60Ep/KzsN/Be3Dv2fog==
X-Received: by 2002:a05:600c:1c03:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-441d44c805fmr23020365e9.17.1746616521832;
        Wed, 07 May 2025 04:15:21 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:dcb5:58d9:1622:6584])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d438e7f0sm28415635e9.29.2025.05.07.04.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 04:15:21 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  johannes@sipsolutions.net,  razor@blackwall.org
Subject: Re: [PATCH net-next v2 4/4] netlink: specs: rt-link: remove
 implicit structs from devconf
In-Reply-To: <20250506194101.696272-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 6 May 2025 12:41:00 -0700")
Date: Wed, 07 May 2025 12:15:06 +0100
Message-ID: <m2zffon03p.fsf@gmail.com>
References: <20250506194101.696272-1-kuba@kernel.org>
	<20250506194101.696272-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> devconf is even odder than SNMP. On input it reports an array of u32s
> which seem to be indexed by the enum values - 1. On output kernel
> expects a nest where each attr has the enum type as the nla type.
>
> sub-type: u32 is probably best we can do right now.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

