Return-Path: <netdev+bounces-74330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E4860EA4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39ED1F21928
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021F5C911;
	Fri, 23 Feb 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MAtUvWvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E35CDCF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681865; cv=none; b=cHsqYFkLZSOTF3OmVQ81dQY6XJ26d7B2CU1t8e2khiwQ27BxV7tnAg4Lc2SVhyO9JGvlvdVu26FhHcXO2ec+o/cdegSIQwqKQ+hq/QEzJ1x+4nrcNClCDzc9nUSR5QDW1QxVPdalaRe+PaAel/wwdcdTaxISvofoAVHtMr5WCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681865; c=relaxed/simple;
	bh=6rc2IKsdp0kI1gJsguPjXdm+B0f/ziVYWpCy9UlWoqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKk4tdqk7+qiDz3DfV/nXMF7+v8KHA27jZMWe6r+twNGwdsUmH8yn7XNOm371Up7OVJU4EIVG7f5gkzVtGFbUC9S8XOnLDh59VIUfr/A6pao1WsPcXTLOeL3qBgDZ1tCOXvsr25uiyAkoLlUQ3+/tJSnOqHhQKQHvjWCsoRgNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MAtUvWvJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4128fe4b8c8so4388185e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708681862; x=1709286662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N44nHoSIsmRfXV7EWxEqpohsRrTvd7Bn6tnUjA0RV4U=;
        b=MAtUvWvJCuun4FBGlsIGkqPXwzV5mg51I3eOAlphVX8ofJpXnTyiVbcuibXU2iua5n
         dBgg5BR4wZXw9artn6XOis+VNB827aJUCa2sE/PLaAUVxfcSfXMkJ/H69lkhjKfwBZqb
         rUURgS/ZMTukrYKxIYDdsefs7tVEr+OB325xAf0JUkcbr0wayaV/NaL8x6ZXwfK2asr3
         Vpx/Y3wmqCqXNC8tMIQx6hAbxqLZ7eHow4wmlQBGMaj2BZOR3axglIgJ6afu+FDgSE6p
         13XUf4QFuMLRaxUcj3Yq76JXyP3AXRNU3TRLqp7/8eb515/u/lnxBeCZDTNvaUJEODvb
         rh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681862; x=1709286662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N44nHoSIsmRfXV7EWxEqpohsRrTvd7Bn6tnUjA0RV4U=;
        b=R2PzRW1uZP8UlZiUihVdhlVeBMCAP6P6TypzwvjW0xGFOxiWuyVwGjXnNInB2otPNf
         dBs5veKerlCVCLWXcDFjzkxZqf1dxJIQwrsjX/C2HuXSIEZh2n8yvng1c0K17aw+JNs5
         kCCOBS4yLdWg6BCGVaUnyRegyDBmoPmY7eTESI2BiOG2E5y+r4ew51VrFDvmN43Q2LHt
         oZ/BWn35YIx4xyAwVMCEk0OHGrZOV7UiKHw6T15UfS8dW7F2vuZwrl54Em9gEV1dr+q1
         qnnnMiIniRYt2n8MB3rOb/gQj1crNV96rhdEVnPSl5Wj45KSYJuuJY+BwEaQSYHslQ6J
         RF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZmiPKjGgMewK/b5xDkN4XR6oFNbOh6NGr3R9qtJ1pH0uZlJKWgesujitvOHK0ef9hwS5jREB/qyrSRACtlyMz9M9vqx1z
X-Gm-Message-State: AOJu0YwYvts3RHg+XdBz/bdIJqZCC4k3LJHy+zKqb5DA4bLv5PObOez1
	BBkj+71VQp38RemXxhslNI+pnAtt6QWZvYNJif38A0OhN8U2ZvqOAhiP6F9Ap0w=
X-Google-Smtp-Source: AGHT+IEV5tRdBC1LOwcCBnxEmX2xB0HocY+04A5qVmBQBBIpIx0CyxfA59BOQbBgqkTRaFOJDziSuQ==
X-Received: by 2002:a05:600c:4f54:b0:411:fe7d:ac4 with SMTP id m20-20020a05600c4f5400b00411fe7d0ac4mr779429wmq.24.1708681861970;
        Fri, 23 Feb 2024 01:51:01 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id jd17-20020a05600c68d100b004129335947fsm1633552wmb.8.2024.02.23.01.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:51:01 -0800 (PST)
Date: Fri, 23 Feb 2024 10:51:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, stephen@networkplumber.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	corbet@lwn.net, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	amritha.nambiar@intel.com,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [RFC]: raw packet filtering via tc-flower
Message-ID: <ZdhqhKbly60La_4h@nanopsycho>
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
 <20240222184045.478a8986@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222184045.478a8986@kernel.org>

Fri, Feb 23, 2024 at 03:40:45AM CET, kuba@kernel.org wrote:
>On Wed, 21 Feb 2024 12:43:47 -0700 Ahmed Zaki wrote:
>> Following on the discussion in [1] regarding raw packet filtering via 
>> ethtool and ntuple. To recap, we wanted to enable the user to offload 
>> filtering and flow direction using binary patterns of extended lengths 
>> and masks (e.g. 512 bytes). The conclusion was that ethtool and ntuple 
>> are deemed legacy and are not the best approach.
>> 
>> After some internal discussions, tc-flower seems to be another 
>> possibility. In [2], the skbedit and queue-mapping is now supported on 
>> the rx and the user can offload flow direction to a specific rx queue.
>> 
>> Can we extend tc-flower to support raw packet filtering, for example:
>> 
>> # tc filter add dev $IFACE ingress protocol 802_3 flower \
>>     offset $OFF pattern $BYTES mask $MASK \
>>     action skbedit queue_mapping $RXQ_ID skip_sw
>> 
>> where offset, pattern and mask are new the flower args, $BYTES and $MASK 
>> could be up to 512 bytes.
>
>Have you looked at cls_u32 offload?

Hmm, but why flower can't be extended this direction. I mean, it is very
convenient to match on well-defined fields. I can imagine that the
combination of match on well-defined fields and random chunks together
is completely valid use-case. Also, offloading of flower is
straightforward.

U32 is, well, not that convenient.

