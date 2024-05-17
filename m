Return-Path: <netdev+bounces-96881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA58C81C4
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58948B20CFA
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C804017BA7;
	Fri, 17 May 2024 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LoCTvtbC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888C179A8
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932350; cv=none; b=M3WyoTArKQUwhedbLPcRzg10kzjX4A6adIYSmQpQJwQKNfDFXKkuMTVoV1sXr4gkHbFHo6WJVeO+yF3gh1zKGwXxfgeO3s4qQnmZPgypwsFT8fBrc50cX5FnDjfybNIbIu6jDRRrWQ5gQvZiYs1hIMN/ThGEsXhw3pwb+fSlU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932350; c=relaxed/simple;
	bh=/v6sjHG+0+ZKEPpS9tqIzcUKC/LKTqQCiFB7jNWcUX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meMM2Qst15ZDs7ZjyHLtG2zXAEEUhh0FoQiAKb1XW0fb6ttmrU4hUC99mjTL8OcOl9kd+392KRyDYFQWrjyOKFwZQt16fiKgVfdQkW2xKTVFUBsfz3SkGRQAcrbFTigqrM7PhymmWf0VVxO/0250rHv6I8+owp+lFdtMaKsM40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LoCTvtbC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3504f34a086so5874272f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 00:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715932347; x=1716537147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFTsZHpcHAIaSjKi6HhILgkEVSJRgmc6M+HW7iQenNE=;
        b=LoCTvtbCtByX3rpJQo7jzVo/VJT7odVD6yTs0M/FlzACrcx7lOgqOm7SRN6sbyjFnS
         tZAEz87onBfeH/lAQbqY2mKvNAb67XHtwfyN4ePTZWVttMWa8jpgD6b3b/aqKGKcjfcg
         mBPFBrFnXCJs02gPA9O4QiT1LHoBw6Agv7QOryCpAi/IeUVc46CAaGJsyKbs5y4FP+I+
         3KxIlKdnFGIuWXPfl0ygkmcI2JHmEEVmhuhFRjBvW5dnZm2X0JOghDuBCLob3kqTNP6/
         Uxqj2N7tpVH9/DaOhckC20e/4NYRNfhgC3Q7TWyHTjKdJuikzoFMX2XEndwpbuQsJyYb
         uIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932347; x=1716537147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFTsZHpcHAIaSjKi6HhILgkEVSJRgmc6M+HW7iQenNE=;
        b=kZhs6VM2k7JyqcC2dpxt3QiqihHA+tn3vMqEG2b5i7g2zc5clWnzAjmI+/dv1kE/BC
         ALGr4+kE2Uw4NBOzSFt0uVf2ooSBUnwv8WtslCSKeqCyi3YrCzWKQoaIwuMd1JcM+GRJ
         gOb+LG1+WVXVqrolNUkRzFlf4TxHr9w6hf65D4a9Bo+TkVBewhcARA3JYC0b3c8rm+ep
         9EvmXvnBsbzo8flAZUPT7Ab2Q5PGxDQwrBV7x7g9q2oqz736kPDB28VFIpu3shhhICLc
         3q62NnaM7w60YFZ9CQ7gc0TzsxSP/YlZAR6OxKgg76TrSG2vFayVa9SBbcbkFSi1R9gX
         cz4g==
X-Forwarded-Encrypted: i=1; AJvYcCX4RdbQuuGNCOHnTH2m3hl82/CP7FEDNIgYAUn7ZSK+h0vREk8lzUOjQVAkoBCb8wEPxcQiLSD6otAFIV23LsSiI3A3q7/s
X-Gm-Message-State: AOJu0YzbBG6Q6Xg1HPjcZ9aXu2NCQWTBidv3KgVmjyEMQWvMl511HHSb
	IgdT+CQ+GcmMXbi6Mbc3cnFQ7sZU6Mku34txrzme925PY3XdKmasTxe1hkzryMU=
X-Google-Smtp-Source: AGHT+IGuekRx9JCbSJ8aPjEkgDSPx0b09Ah96HfjfNrA2JQkcpnO0zi7rNwoFiUHiHt0SWJgb+QhzA==
X-Received: by 2002:a5d:618d:0:b0:34c:9393:4c29 with SMTP id ffacd0b85a97d-3504a737a07mr16118061f8f.21.1715932346608;
        Fri, 17 May 2024 00:52:26 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d3bdad9bsm4337495f8f.46.2024.05.17.00.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:52:26 -0700 (PDT)
Date: Fri, 17 May 2024 09:52:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkcMthuRwhMsWJgn@nanopsycho.orion>
References: <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
 <ZkSwbaA74z1QwwJz@nanopsycho.orion>
 <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
 <ZkXmAjlm-A50m4dx@nanopsycho.orion>
 <20240516083100-mutt-send-email-mst@kernel.org>
 <ZkYlYLFthXVmHOaQ@nanopsycho.orion>
 <20240516150101-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516150101-mutt-send-email-mst@kernel.org>

Thu, May 16, 2024 at 09:04:41PM CEST, mst@redhat.com wrote:
>On Thu, May 16, 2024 at 05:25:20PM +0200, Jiri Pirko wrote:
>> 
>> >I'd expect a regression if any to be in a streaming benchmark.
>> 
>> Can you elaborate?
>
>BQL does two things that can hurt throughput:
>- limits amount of data in the queue - can limit bandwidth
>  if we now get queue underruns
>- adds CPU overhead - can limit bandwidth if CPU bound
>
>So checking result of a streaming benchmark seems important.

I understand. Didn't see any degradation in TCP_STREAM netperf. But I
will try to extend the testing.

Thanks!

>
>
>-- 
>MST
>

