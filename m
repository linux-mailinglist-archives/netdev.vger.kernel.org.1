Return-Path: <netdev+bounces-167529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C61CA3AADF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7373C188BFB8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684411D90D7;
	Tue, 18 Feb 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB6SDTqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF551DA116
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914163; cv=none; b=K8N+i9o/EqUSw2Ch98tIIWv+C0FUvKRY00VVwF3Vo4d8xnHX5lAtH/urB56EGRLUoRQR46y6sA0p9huTHJ8xKsgC3ZPhY1SV24QJ1e77LNa4O3FD5mEInEUQUVqgd2xI1t3k5j2bCLjmsFnNJ6KirOp1iDiYsw420hZrr2s/W6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914163; c=relaxed/simple;
	bh=mUGdxQzECTuLuha/z7AhxqZ7/DDCXV6fprGA577woO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSkE5JOLqGML9tO61wDbrTez/XTFHFv2UT61f5XgE5QtApTSk526kVc2vxlarDcgtwua64Ju30D806vFqYIh3Mnx9QrC19pD9fc6qy1rE+PYihiuZIIpxJoJZ+atSzcJPYTTARgJ+YTNcDY2CSwnWTVvVz+zZZYg/79amNxSoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB6SDTqO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c4159f87so80083685ad.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739914161; x=1740518961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEj4UUxPHZAclT8rJKVvArxaN1Wsq3hx3VsHKowSfIE=;
        b=dB6SDTqOtC1HNicoteKTxLw6wX9mdaB1QmhnNmhHR9aRLhV8+PDHyFAV5LtxccLBin
         1asn56AmO6UNDMq+Zcp0r3Fl/uOpJEFCd4BskbCKxdo8/Z8cezDMuzpfVK1GoAB/fP/d
         p2pyj+TKQ0SXsxPAR8r84+o+s+3VJoASGXvbsTw7tqXWFE49Z3fgQnMf8Aqa/JoBq3l+
         pRpp2+h9vfaEpOpebAaX/A2z+XrhFlpXiD0Z85aLsFeuWS116Crz4SWIC0UQHkriR8X7
         KkFdpB9ja4SrTzVIrN3BGi3pCAJbcb1uOOjNqhM0xR1C1TUqcRLOX0MZIB9bdP7ewePc
         lftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739914161; x=1740518961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEj4UUxPHZAclT8rJKVvArxaN1Wsq3hx3VsHKowSfIE=;
        b=rQgycbrCJ9ouAI5axP46ggHjV6E6wnHj2arR6fqdOBshRPeOLvqjrhn2v+W0LfC8yj
         NQWVhk8NkPE6RWaYvJ3pqPUAECOu4b9Ewjb/dRSchOckCUz95Anq61aHT71rzS5Q+K6o
         dpggMEGUyxquytTYrcT0fNb81m0LCYZXUdbso8pzTk1INOrtcm+VZtXAc/lvpAKR0qrW
         MV/ehUQVpkAek4oy5lDwClnsDbGXEzQonf9DIiD7zePX+H8n5vUdHXHWz4/IPY9wvngh
         ry1hjee838u3w6I6Ps4G80ub0Bq+AJYx/Gv3DBTTKC2zWyh5tnekj8gqgMeZ/tjIk9GW
         eMJg==
X-Forwarded-Encrypted: i=1; AJvYcCXYKcUvQ5+VyIVrbKLwUfAVec7DNxsbKSY46dOpQW6VzErNmiMqMNwbDGZPYDzI7o+xsLQ8Blc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpiA5uNwqgT6gQS5PWlmyP3BBULkULq64JSq3d6BtBa8/7ajRc
	yNycYgDpsM6wSOrR4fWIbgf6k0GSPtlGZTdpmGJbnLOA4hAM4+c=
X-Gm-Gg: ASbGncudP5LosMqmieoG300ll6eb3m3GlTK38DZUg+AELRY+JO8Fc6DeuXM7HWJn2Qw
	Z5dtrTkQXXZflg51qr9cAfxhgZ2DcVfQpMes2bCCiXv9jMXI1MqaDv8GLjtd524RqTxMcpn7NZB
	LlG1nCHN820PsIJ4GFFCGj9bNyOrgJ+dTHP3Wyj/9E+ANxyvqyu/DlflHv3DpzOzXFfrF6v2nUV
	0W684xKRfFwEQd0vu1Fu0wyA58En3ajNtEXW8QEeJcNMUdkXlkYNKcB2hzG/iMPLfFBuHRHKr6o
	9ummqDKEy6btgVw=
X-Google-Smtp-Source: AGHT+IEJkyhf3sPbUwAEZIZi6Eerg3IZeKwAUaN3SjW8yFEjdcWb5QYCmSywT7kmpeopQxITkP7W8Q==
X-Received: by 2002:a17:902:dac5:b0:21f:140e:2929 with SMTP id d9443c01a7336-22103f16b04mr246715025ad.15.1739914161087;
        Tue, 18 Feb 2025 13:29:21 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5348f29sm93138605ad.37.2025.02.18.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:29:20 -0800 (PST)
Date: Tue, 18 Feb 2025 13:29:19 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	jdamato@fastly.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for a
 local process
Message-ID: <Z7T7r9VtuN78qhL6@mini-arch>
References: <20250218195048.74692-1-kuba@kernel.org>
 <20250218195048.74692-3-kuba@kernel.org>
 <Z7T3NqZtfCA5C53W@mini-arch>
 <20250218132122.278a9b00@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218132122.278a9b00@kernel.org>

On 02/18, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 13:10:14 -0800 Stanislav Fomichev wrote:
> > > +	env_str = getenv("KSFT_READY_FD");
> > > +	if (!env_str)
> > > +		return;
> > > +
> > > +	fd = atoi(env_str);
> > > +	if (!fd)
> > > +		return;  
> > 
> > optional nit: should these fail with error() instead of silent return?
> > Should guarantee that the caller is doing everything correctly.
> > (passing wait_init vs waiting for a port)
> 
> My thinking was that you may want to run the helper manually during
> development and then the env variable won't be set.
> 
> Given that we currently don't expose the stdout/stderr if wait fails
> adding a print seemed a little performative..  We need to go back
> and provide better support for debug (/verbose output) at some stage.

Good point. In this case, we can fail only on the first case (!env_str);
should still catch the wrong invocation and let you do KSFT_READY_FD= ./helper
manual run. But agreed, that not worth the respin..

