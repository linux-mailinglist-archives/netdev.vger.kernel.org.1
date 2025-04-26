Return-Path: <netdev+bounces-186216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E9A9D748
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 04:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1771F4A60FE
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378071EE021;
	Sat, 26 Apr 2025 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DZUbW1rC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D301E834D
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745634898; cv=none; b=a/FKhDSvaqFB16bVPvEhhQ6NdNmt5j+TYErDKUDkxtGPCNv/jcmkZAehCWaV+NTEYzYUsQfZe+9vD5e15RX1eVTlrR9ytry3icjHG5q6xDLzJmX8HbjK1scxJuGahTu+SYqj8Z1RIr7FlhNvefBZ1zTfCuo87RKoYVBVn1VY6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745634898; c=relaxed/simple;
	bh=q4rUriAtVYWjyBCD8kKdQUMo1LA8Yzc67T5C2L0cd8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNupPRwoa9WYiJws9G3S5R03payTQnqD4JKF6qu4Zen1nhfbFOqpZZZQOs44w0Slc1+ZtAsokRPV5Ml0d3e8c7ycsdYnd8AdIhUSwvpzyH5GOW4YG2Fn58yeD2bTQtzfoeBXQHpObYaMLZVVhKcPIc64YKw57n/rmdcH882eWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DZUbW1rC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2255003f4c6so32851465ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 19:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745634896; x=1746239696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kexgwb/isOr/vaHuEmwk1CcC/+1i+xYRx4Pu8K0YJuc=;
        b=DZUbW1rCXE+UiwLr4wStBw30/my/gvuSI6mua53hB2Q+OXZzm0zIWX6bRGCbEW+mZd
         T6HDIL7K80cni3oBJsOIaLkaS4b1/IpQ4iNs12fyrpf7IuaHKHpboykDnkC5yqS/jMEC
         yxk6JA6MSwv2G9dqqeeR7o5d53U6F4qP3BtWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745634896; x=1746239696;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kexgwb/isOr/vaHuEmwk1CcC/+1i+xYRx4Pu8K0YJuc=;
        b=biFcD0/Z5ls8Yh35vXoyPOLsUzUoH6owQ0j8XMUTXvSwNsDhYF23uwHCkQ0CEEDhWu
         oeG7hLNMBXAV2u03AObnxMem+G3O2FmgZnocKeb0q0jIY69bRiyXuqfrHGBKZR4Pxbk0
         xPrJPoaVrWGP12Fx5bIt77bNCEtPOovTIc2o3IQr4L6db2a+M/QFY0Rp6vQlrb1JgycL
         ED8o/afALs41BnJLzVwFank+xa7kTuSiB3UHba+iw0YJXPyMPVfkoAyXCiKauL85a9hx
         PRSc17R9xRdaZWWDzJjhWF+V+3Sim8RDUv6Y0HQk1aAb0GnLTADU66y99foW9MlWKRTT
         vtTw==
X-Forwarded-Encrypted: i=1; AJvYcCX8zCGh+efh1SZnylS+q5b73H2kh+15zmoIeM5/4ajr5jWtM8q4YC+a4nVGGT5R02fxg2Vp7Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhX8Z0qMWHWML7mApBUNqbfibqW/UxYHo6ex27W4p179UBYEU0
	wGIcJ+2FioXupYQeyejy/eCx/lGqpcP79YdAvu9bGYniq97hPcjGc2Ev8pFCf3I=
X-Gm-Gg: ASbGncs3s04EaqazA8WYQfzh1dh/A3pjQ0GwPBMEHALnosPW1JKuRwOIqCQXfCCVzzq
	NrLqPIq9zVapQUbL6Vix7gg+8p1jqMsQb/pMv8qphyJGBcbdZWlroOuyDRyGL3nakyJNeQnLMgU
	g09t2y/Z0j7HFH1bH0tJvPainYY0lEHmBXBwFs2AzMBURzR8xFLnD191Zj9hGg3aT514ZsSSYAM
	1jboSmQXzV2rsPQ8+HUQSoYa0dT9xcP7960Guf0MIl9jcoEOlTROr2NcRLgxDTyhJCwOkpOP9iu
	gqlJngw683YDIUIGUc605MuwgsFnzOS/LOxtL5a8WZ3pc44rHN/B+bm46neB/QhARqWeOREL6EG
	L7Yw23zCyP19o
X-Google-Smtp-Source: AGHT+IFT3L27dv9XvdlfWusRGi9YKybtJ9TY5EwYxlefyerjsoi6FIJLX0VWJ+Qb0tZ9lvHa6jCBxw==
X-Received: by 2002:a17:903:40c8:b0:224:1579:5e8e with SMTP id d9443c01a7336-22dbf5d9efemr70450775ad.1.1745634895801;
        Fri, 25 Apr 2025 19:34:55 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76fa2sm40382535ad.19.2025.04.25.19.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 19:34:55 -0700 (PDT)
Date: Fri, 25 Apr 2025 19:34:52 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <aAxGTE2hRF-oMUGD@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250423201413.1564527-1-skhawaja@google.com>
 <aArFm-TS3Ac0FOic@LQ3V64L9R2>
 <CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
 <aAwLq-G6qng7L2XX@LQ3V64L9R2>
 <CAAywjhTjBzU+6XqHWx=JjA89KxmaxPSuoQj7CrxQRTNGwE1vug@mail.gmail.com>
 <20250425173743.04effd75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425173743.04effd75@kernel.org>

On Fri, Apr 25, 2025 at 05:37:43PM -0700, Jakub Kicinski wrote:
> On Fri, 25 Apr 2025 15:52:30 -0700 Samiullah Khawaja wrote:
> > > Probably need a maintainer to weigh-in on what the preferred
> > > behavior is. Maybe there's a reason the thread isn't killed.  
> > +1
> > 
> > I think the reason behind it not being killed is because the user
> > might have already done some configuration using the PID and if the
> > kthread was removed, the user would have to do that configuration
> > again after enable/disable. But I am just speculating. I will let the
> > maintainers weigh-in as you suggested.
> 
> I haven't looked at the code, but I think it may be something more
> trivial, namely that napi_enable() return void, so it can't fail.
> Also it may be called under a spin lock.

If you don't mind me asking: what do you think at a higher level
on the discussion about threaded NAPI being disabled?

It seems like the current behavior is:
  - If you write 1 to the threaded NAPI sysfs path, kthreads are
    kicked off and start running.

  - If you write 0, the threads are not killed but don't do any
    processing and their pids are still exported in netlink.

I was arguing in favor of disabling threading means the thread is
killed and the pid is no longer exported (as a side effect) because
it seemed weird to me that the netlink output would say:

   pid: 1234
   threaded: 0

In the current implementation.

