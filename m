Return-Path: <netdev+bounces-99146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B98D3D2C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB00287263
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9832915B553;
	Wed, 29 May 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q68pLBHM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB69A55;
	Wed, 29 May 2024 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002127; cv=none; b=daHKiGC99SDXcJZw+MTqAUKjGZnwnEysd0/k6u5xlVsWmC+yB2Oejc/QJKE4TqSg6r4hK498JkMQ69N+oHYQlzxw8O91SUT4lmXgW9GFkDZn5LEFUhp6uP/st4ZKtjF4cTVEYknZp6lUB/KG1PRcnZ4t4AvhCz9DZpB/uoPE7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002127; c=relaxed/simple;
	bh=qRUi+BxD5LWVhf84M+E1St2XwsNAbf09JDb4OqBHrCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIBJZ5c+ft/UQ4tdSrYfcnzqiADGzd3dpMCp5268xVqdx9hEsHloabQ+vSB+uHAO6OSAzEg0qJOCv5Qvtd0BzlUDfwY9fIicC8ZQSOUagGf/DfkRzvRV24Srx9C+ipmKLb06MlJt99GS5yKE10/Id8w/6/8+CmKEioqEOPiUcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q68pLBHM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so1891251f8f.2;
        Wed, 29 May 2024 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717002124; x=1717606924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qRUi+BxD5LWVhf84M+E1St2XwsNAbf09JDb4OqBHrCE=;
        b=Q68pLBHMGiQiWMCcXo2HvEpBH07gj8v+bh27SXgGtW/3Eu96efPeYd1WGMR8uxi7By
         U2z3bKPbmr4XUqevpfAVyumBplJxl5y1HNBBfJKf9E8dagKIHCytA6OdCYTNMbIrCB90
         loW5iy8RSzXjgbqVRVSNxqhBEQ6JO8i98bVP4bjc480gKADW6/qGdRFR9Jpe/Gbkuofn
         1uuWRdNcpjF2BYL4lSNGzhreXCIuo1g8vdkXp6GdA8h6z13V6uiS1O3v8vnEN2M7Bfls
         pNLoxg7rXidqkaiPKQhZ1Aw3QiILMLZsFubS/32PU3rV3vaM8tcDDyLeoRuWfLubzbKU
         A5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717002124; x=1717606924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRUi+BxD5LWVhf84M+E1St2XwsNAbf09JDb4OqBHrCE=;
        b=PxwCT+PPuAwowpuDg6s9BPFWT5+8Xbsl8BUtqXBDd9O1dluGOAkyLvdWFd/R4fwKNx
         1dVBQMktBCj1ieviSDRv/2fR75lr4rovj2GYtKAfkEUDag7LyIRUNi9S0VILcmLvWYn8
         252dbdR/re9nNi0TytsMUwhE/4DLqF9uWm03zQTwz4jKNBRQRPidcuc6rolD0z6cQY5l
         duPgaBlM9pP9/tp2MWsJQO8Pib9m1KU/nmJwrS4u/9ud2suAMtURNcyqr4MD2oubQYYj
         Fm0ZJNJa0kly5oVmLvihCO+5zOteq4muUHnJ82N84iSisPPCFA69H9sVBwcZyaCBdIWj
         u8BA==
X-Forwarded-Encrypted: i=1; AJvYcCUtdCCqphYmutoBAo55PqBXj56F9bnBPNaWJkZqihOqMgFuMAquX8B6Gj4lPDdH9xB+LddkpU690JFpsX1Og+fIW2pqeA10i62sRTHtJdzRYBzcJhG7YNSJ1yfLyq/zg6n49S5oBg3Rqp0cA9HNofIpzuv1ca4ddx6x2cRjyN3krDwQbYoQsnBm
X-Gm-Message-State: AOJu0YwRc+U466fNxHa558FiImxpHQTL9xWL1i/NVgfB0MC+OuncWZvY
	OxCBoeGlx7lokI4ynrYGlznaM4CjtTQAnB9RTgGmpNGNXAiCdP2VBpztGj80WTu58G2qb1p/7JY
	9UIiNvNNaQLDaSrScDSMDW32hwLU=
X-Google-Smtp-Source: AGHT+IFNz9q3eHw7cokSw7Gv0ysA3gen1WNPL9pBmXO8/77eXmSI5YO18jC8O77X5aN47gvnc89u7gsEd7aT0M+DKBw=
X-Received: by 2002:a5d:4ec2:0:b0:354:be7c:954 with SMTP id
 ffacd0b85a97d-35526c6ade8mr10792189f8f.15.1717002124173; Wed, 29 May 2024
 10:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528143420.742611-1-talycb8@gmail.com> <520cf8db945cf8dce4afdaddb59ceda65463a406.camel@codeconstruct.com.au>
In-Reply-To: <520cf8db945cf8dce4afdaddb59ceda65463a406.camel@codeconstruct.com.au>
From: Tal Yacobi <talycb8@gmail.com>
Date: Wed, 29 May 2024 20:01:52 +0300
Message-ID: <CAN7-cG5w9rjhJnDJJSOTiopxkj75mOJEC9eKZqmJaqbeMudPQQ@mail.gmail.com>
Subject: Re: [PATCH] mctp i2c: Add rx trace
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeremy,

Thanks for the reply.

> > mctp-i2c rx implementation doesn't call
> > __i2c_transfer which calls the i2c reply trace function.
>
> No, but we can trace the i2c rx path through the trace_i2c_slave
> tracepoint. It is a little messier than tracing trace_i2c_write, but
> has been sufficient with the debugging I've needed in the past.

Oh, I missed that.
I had to test it with an older kernel without i2c_slave tracing
so I looked only at the regular i2c and mctp trace paths.

> > Add an mctp_reply trace function that will be used instead.
>
> Can you elaborate a little on what you were/are looking to inspect
> here? (mainly: which packet fields are you interested in?) That will
> help to determine the best approach here.

Sure, I basically wanted to trace the i2c packet buffer in a simple way.
Although, it seems we already have that in the trace_i2c_slave since 5.18 so
it could be redundant, unless you see any other potential use for it.

Thanks,
Tal.

