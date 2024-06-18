Return-Path: <netdev+bounces-104487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C337290CB58
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F8EB278CB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195615DBBC;
	Tue, 18 Jun 2024 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="x2H6q3tH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F515DBBB
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711173; cv=none; b=RH8FCDTDo5cdGW5V4eH5tStf6qPMyJ5JWqReGj9EDjDtkpYyatYah9YcSbT/k6KKU2uSHMbBjVLcbksF6kU9eG2DSG8hGvt24DWTCAeVobeI1SsLoVn3z5MCUtlGV6E9o5LGDy6QQXECRZgIqfXpRWkmBjX2hbkr8PZ/fJkhpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711173; c=relaxed/simple;
	bh=6xJooJYBglE33Byj6IBfQACf+GC98VsPHGDfTsJ7DFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hccZuq0NtMScDuPhsxa7U5d7cEm3A68c+MkeDXvTXV0cnQCJBIiOHs9cLYIOuvdYwo0Dcpg6z1yzbkMfgjooznfdn3SvJ6E0MBgqJQNTC745BG8HlPb2zTKx+rRfc1+Qm9dZhXrQNF8b020xUFTKcCxa2X2MLU+sdu70i7f6f+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=x2H6q3tH; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a6f176c5c10so647070866b.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718711168; x=1719315968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3DmCbEPnNE2kQGdnobXvTGiecXNfiA/xqVHCbXaVFM=;
        b=x2H6q3tHCeNYoPjNBEGAQbi3/d9eP4KHIS635pmF6o19hbP9TO/voo+mE+vvGtFGon
         CzrNC+w8BOQoZuk/Um9dy5uLRjS930JXVCj+rdI/bfsgEtrCXKltpAnB8bpC2wjmCrQ2
         +bzF4yNqiknqUkdPVZMZk6u5YCx1lCOAMn/vs8bSB7kLV7d6+x7MzCoydLS5Fpj6KGnN
         eVS2M53tOljTW1L6/DM4mrXA9ZSg9MZulAGPmN0JvO6IBFWpZx7ZR1OVBEXH4WvU9ECk
         nseTNd6HARvlVEqDxKzU0VclmnIVbVP4k3JdU6MCOcpFumc+WOYd3s4diQ+vZgPhcnMv
         hxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711168; x=1719315968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3DmCbEPnNE2kQGdnobXvTGiecXNfiA/xqVHCbXaVFM=;
        b=R5E+fpPjA6NsJEeL9VvpQVMTo2FQS1uRvBt37Q8uqAerHCTdNbFWbME4dSqO7Gi+fL
         uZ4dyO+elN7PJmuDew2tHnuzymKhsgQ/Mh/hN0CtCsCfMa/DcJ8EZx40I4fe1WEIsc+n
         knoqt5tUSe6C5njUHqRD0pBTf8ItW3hB9jtlYIcNehhVjDKiNZ7mMx17GbaxhYs3ZYwS
         VuYWtF/tjipnVoxOZstbwmhgOvM5lFLQe6I4tjMyqApMJz/CiOZ8yOuMNrAqd6rXG7fx
         bh8C2Pg5fLxgF8a7Oh4MmTEzQYDcvuo5bsvuveAb0hhWhPo5R+tPWmNhNpaarfLkV72r
         TmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBDh4zf4mS5AKRTNv0KuHDAtPoP4ynha8GL59EsHcr4z7KUty4nT2JdJFqT4e3clFY4C67wuRevu+DVu7h7allRPY+mVe1
X-Gm-Message-State: AOJu0Yw867SUJGNlRaBu753LieZab8pqhbVsULE++ybgRJxzmXEiZY9y
	o9yPrO6uBRK7AnQ76qQqfzfbzOpzj9NjahHq4FTm2gl/03wATJRaadCmEl1M5mo=
X-Google-Smtp-Source: AGHT+IHk1ydf2uzPu+/ATnBL9qMehU7XnWpx3qGwhdlkALisz++eFf7GtS0PIoOI2PpBRdgsDBSZLQ==
X-Received: by 2002:a17:906:b4e:b0:a6e:fa0a:4899 with SMTP id a640c23a62f3a-a6f60cefe7emr762689166b.16.1718711167998;
        Tue, 18 Jun 2024 04:46:07 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da4038sm607673266b.31.2024.06.18.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:46:06 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:46:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] virtio tests need veth?
Message-ID: <ZnFze5vFv6dWwQgL@nanopsycho.orion>
References: <20240617072614.75fe79e7@kernel.org>
 <ZnEq3YxtVuwHdFqn@nanopsycho.orion>
 <ZnE0JaJgxw1Mw1aE@nanopsycho.orion>
 <1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org>

Tue, Jun 18, 2024 at 10:21:54AM CEST, matttbe@kernel.org wrote:
>Hi Jiri,
>
>On 18/06/2024 09:15, Jiri Pirko wrote:
>> Tue, Jun 18, 2024 at 08:36:13AM CEST, jiri@resnulli.us wrote:
>>> Mon, Jun 17, 2024 at 04:26:14PM CEST, kuba@kernel.org wrote:
>>>> Hi Jiri!
>>>>
>>>> I finally hooked up the virtio tests to NIPA.
>>>> Looks like they are missing CONFIG options?
>>>>
>>>> https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/1-basic-features-sh/stdout
>>>
>>> Checking that out. Apparently sole config is really missing.
>>> Also, looks like for some reason veth is used instead of virtio_net.
>>> Where do you run this command? Do you have 2 virtio_net interfaces
>>> looped back together on the system?
>> 
>> I guess you have custom
>> tools/testing/selftests/net/forwarding/forwarding.config.
>> Can you send it here?
>
>According to the logs from the parent directory [1], the "build/stdout"
>file shows that only this config file has been used:
>
>  tools/testing/selftests/drivers/net/virtio_net/config
>
>(see the 'vng -b' command)
>
>> CONFIG_NET_L3_MASTER_DEV=y
>> CONFIG_IPV6_MULTIPLE_TABLES=y
>> CONFIG_NET_VRF=m
>> CONFIG_BPF_SYSCALL=y
>> CONFIG_CGROUP_BPF=y
>> CONFIG_IPV6=y
>
>The "config" file from [1] seems to indicate that all these kconfig are
>missing, except the BPF ones.
>
>Note that if you want to check locally, virtme-ng helps to reproduce the
>issues reported by the CI, see [2].
>
>[1] https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/

Hmm, looking here, I see only command outputs. Would be actually good to
see what commands were run to produce those outputs.


>[2]
>https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
>
>Cheers,
>Matt
>-- 
>Sponsored by the NGI0 Core fund.
>

