Return-Path: <netdev+bounces-86301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A4A89E544
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AB91C213DC
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FFC158A3D;
	Tue,  9 Apr 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="eIltjpsm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8431EA8F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699975; cv=none; b=L+Bv2cw0rbFJdUr458Q3g2BobxdFAOWRJTKC389fz82f6CM0v7pQX0S1fcVYlR1Tm4CPkIpKqhnhU+FgdU0l+fVAHJfDtFs0uZsx2T6UupAs/9IyqCutmk9SXlznnRIA/wIhpTaiBUcNP3R6N+XpP3KV2xpjk3VPLuwGLZ/Ju5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699975; c=relaxed/simple;
	bh=hSZioaMtEzYO+OAGnnkX7ud6CfuYU2r+5hKSAs4f6tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD0x97vdgF4P30VJVgo2KH59jnJPPRCaEu7An+MuLS2RvEwnPZ4dfR25/E0SjgoK9uCv9uhKbGBIV8EHRdUQwb7JHMVMhHZ2ZOiv13QehjfU7uZowuCVWAUpm5NKhrYFQIUmMIKXEYmmgLAWDsJdOvIDeZTcN+iq9EUcfTvVY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=eIltjpsm; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1e3ca546d40so33838955ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1712699972; x=1713304772; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+x6ZLb1OZNUzaBMqjiV3x+omrWVEieL7ZSGXmmbLmCs=;
        b=eIltjpsmdDW8efLQMXmKDa0QNCMaXO7B61NO0R2J6HGyDXSoWdyM8OTlCNBjT+Zadi
         2FYIrf8/2yHn650VjDzU4+R9Z83Tn0m3vkydako9FJZCfXf9ou9UCOzBOt8egqlgbqFs
         vu1c8Rp6xN8PX/qca1u2Fu5Gz5QJp/QyF6wIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699972; x=1713304772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x6ZLb1OZNUzaBMqjiV3x+omrWVEieL7ZSGXmmbLmCs=;
        b=fz1/Lz1vsasOGtt5PHZ+NS0mx0jeZLreFbQnKp2owcCoWyHk5x9O8DRMTxFxiXzB/W
         2S/8b6Vk5ONUFZIHnFR1BqMO50a/PArg13itMjXs/pPHQFOaFh2oyLYy5DV9p9nSexjP
         MXqkWD4fDKM/rW1pkAmQZIiUjOe+2WvQFXmjFMsbAJiDvhGzHj+0nTkdSmjMDLRkJxpr
         wlAcOWcok19TGBW3muZjYfNzMPMTNNptfFqDbTFOBpcjiYS1I4YSevjVsQ8NUCqIZetE
         xUlYOngE4A3VQ6mdrOpSJVWmeZtapog3n3DDTs8X1cW7G+Pba2rFk4kWxOXOKr3DsujS
         TiWA==
X-Forwarded-Encrypted: i=1; AJvYcCVJfK/OFhpGK0ha3DoOA4bYULboJVnEu+HN+Amzu9Wvl7RpMosTClhe5719mK1nAQkCfRCmiQDV5sU6VnIlNjE6SOFfsM3e
X-Gm-Message-State: AOJu0YxcHJcCJkWvmLbsVIppKaqRLTicq5FskkYbei8ZcRAmJPrEuplv
	GMR/XK5pcbFYqvPFn3TYDOi1yQyeExr0DGihxIlV876t3IL+gNXFg2FuJ6pnuYM=
X-Google-Smtp-Source: AGHT+IFOTl0KuZBYWzrsTRZNQLutnvcuh+RNGaXcb3CuPG2zxwExqgCIZSsM3vcUm0TyZw3Ki4UPgQ==
X-Received: by 2002:a17:902:f64b:b0:1e2:7916:6b7a with SMTP id m11-20020a170902f64b00b001e279166b7amr1141553plg.6.1712699972471;
        Tue, 09 Apr 2024 14:59:32 -0700 (PDT)
Received: from localhost ([2607:fb10:7302::1])
        by smtp.gmail.com with UTF8SMTPSA id lb4-20020a170902fa4400b001e0b3a87dbbsm9414434plb.177.2024.04.09.14.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 14:59:31 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:59:30 -0700
From: Hechao Li <hli@netflix.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org,
	kernel-developers@netflix.com, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH net-next] tcp: update window_clamp together with
 scaling_ratio
Message-ID: <20240409215930.2f27laoh4uoj6s7x@lgud-hli>
References: <20240402215405.432863-1-hli@netflix.com>
 <CANn89iJOSUa2EvgENS=zc+TKtD6gOgfVn-6me1SNhwFrA2+CXw@mail.gmail.com>
 <CANn89iLyb70E+0NcYUQ7qBJ1N3UH64D4Q8EoigXw287NNQv2sg@mail.gmail.com>
 <b3kspnkcbj2p3c5q6rbujih72n7vouafpreg5mjsrgvf4fpu52@545rpheaixni>
 <CADVnQykMeQDbUg4H_xbL=7o95N76bKhO3tz=Pa46-H7O-bm-pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADVnQykMeQDbUg4H_xbL=7o95N76bKhO3tz=Pa46-H7O-bm-pw@mail.gmail.com>

On 24/04/09 12:51PM, Neal Cardwell wrote:
> On Wed, Apr 3, 2024 at 12:30 PM Hechao Li <hli@netflix.com> wrote:
> > The application is kafka and it has a default config of 64KB SO_RCVBUF
> > (https://docs.confluent.io/platform/current/installation/configuration/consumer-configs.html#receive-buffer-bytes)
> > so in this case it's limitted by SO_RCVBUF and not tcp_rmem. It also has
> > a default request timeout 30 seconds
> > (https://docs.confluent.io/platform/current/installation/configuration/consumer-configs.html#request-timeout-ms)
> > The combination of these two configs requires the certain amount of app
> > data (in our case 10M) to be transfer within 30 seconds. But a 32k
> > window size can't achieve this, causing app timeout. Our goal was to
> > upgrade the kernel without having to update applications if possible.
> 
> Hechao, can you please file a bug against Kafka to get them to stop
> using SO_RCVBUF, and allow receive buffer autotuning? This default
> value of 64 Kbytes will cripple performance in many scenarios,
> especially for WAN traffic.
> 
> I guess that would boil down to asking for the default
> receive.buffer.bytes to be -1 rather than 64 Kbytes.
> 
> Looks like you can file bugs here:
>   https://issues.apache.org/jira/browse/KAFKA
> 
> thanks,
> neal

Makes sense. Filed: https://issues.apache.org/jira/browse/KAFKA-16496

I don't know the reason why kafka set 64k as the default in the first
place. But I was wondering if there is any use case that requires the
user to set SO_RCVBUF rather than auto tuning? Eventually do we want to
depreacte the support of setting SO_RCVBUF at all?

Thank you.

Hechao

