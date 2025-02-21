Return-Path: <netdev+bounces-168421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE0EA3EFBC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D04F7A84EF
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66C1FAC46;
	Fri, 21 Feb 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d45go0VK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A101E9B21
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129282; cv=none; b=sZc+JNpsIqe6ozFocSz00CoOV6Xw8xy+74vU/u7VNA05CIhTOBakf1g4D0SeTGv8OFqFNc5/JwYW4CM0LhrnU3Td6ukkkx4Llj1rBVKmc3W+Obx1M6orUHbzQOaIKSkP/Q6GmMxMlGadX5USlY4+0wvns7i7nmHdbsChcLL092k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129282; c=relaxed/simple;
	bh=rt5+9V0G4LW6gQ9uPdfQrVn7BRqHLMirTjS25pQT3PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hE7d1FOfjrGa5sc2IYlzVSlThDCgqxO44y3lNHjQOE9bnGdxvyZS5jxh613cZyfI0MvmLxVXQMmdtVs9gD65KC4Nvk2OfX37sz8GSB5ZBKc2MHnumso2++SmpMz/zsy4xk+l+U9pvwtwtU2Zm/CtPzWcMRIkgH+6ELmz0S5NIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d45go0VK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740129279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW7JbOftMuDHv2Tg/g2O6LC2K9X0vcmQBZe4SJc7Rqs=;
	b=d45go0VKaOep6typbQ1Drazxv3W3tkIaIkyO70yBqT3gFxyOrQWIS3RTKL7HlVaZY0pP/v
	Sy8vDVp7fn6FnSgP0LZn8BW5KtiROAH56so4I0p+zjvLhG5WXlo5w/htN0PwgOUMD94bIP
	LxIOxawYRvFHr38w/lzCQvJmBqLELOo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-YrAhXgSqObaMCFAE5VOzVg-1; Fri, 21 Feb 2025 04:14:38 -0500
X-MC-Unique: YrAhXgSqObaMCFAE5VOzVg-1
X-Mimecast-MFC-AGG-ID: YrAhXgSqObaMCFAE5VOzVg_1740129277
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-439385b08d1so12541815e9.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129277; x=1740734077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW7JbOftMuDHv2Tg/g2O6LC2K9X0vcmQBZe4SJc7Rqs=;
        b=YfZn/gvlStWS70BB4foYcC3hxm6X8nwoOeKujoRe1uucOFlpg59TWepgi9w18OcsPh
         XjEeKxBKBtErf2uoBt83D2dH2UooHMKGcT38uJpMWzCziCVBiPovyTvOrPMqqMTPR0Lu
         yRcUjpcQCuquEl7t98oYacH5XQ7q2/iHorcLNoTK7/fY8OqxB4pX9FodtWY0Lg0Dw0cq
         PzIxTA9WkGNWN/dOL9gdlC2v6gEAqTqvZYnOPFFakfY5pzjIOg2gkDCqRlkAx0wsKTAh
         blq1gFs5UFLchT0AEEPbDE4pMVm5Fw8XifGz7zF55tujTjMHfr8KUJI5xcEittg9shby
         /n2A==
X-Gm-Message-State: AOJu0Yybwvpyj2MpSWe50ZcE+Y/5hwYZ/wF1z1uXCC3+pLpDZhmy1i2o
	MS1pW1q+ORM7wMPLCZTyp/QsYSSsWIqSjv81ai+cwnDL8M+oBFWTFGPyy7CNFSrEzbGIhOodp62
	UXFLeB2i+XkQbS64e4ww1tnESG6asJzB1MRmsQtBz2bPcsLk5Ztnxsg==
X-Gm-Gg: ASbGncszn5e+s3NsrsabK4HhnsSPskv0pgAZkkAz/m5GyJNCA0jevEzyQay1RS8Ro7g
	d1mihwMTZ8pbvVFdCceQx2IUiCoxdi2b9WW7Nx/SRhuGRPiFYkmIB6K+Xh04vlCFkjH/+8IjukA
	X7Hb/tNjNe5NOMqZDFJUas+mTCOg021O/1uVz+RQpaU6WIiTjTiBZW/a0zhhx8n6Ip5LMwMxJw1
	fi4APRyHBwpOVQjhwQ75cFaHOgaJp/aGP6YaijggaKKbnmdTWpbstNdiPTHxuK6BKykSIKHku+G
	1C7Mi0zyCnnQdibKNX1ZCVI+8bCfH/xzJ4czrOHZXs51XA==
X-Received: by 2002:a5d:47a1:0:b0:38d:e481:c680 with SMTP id ffacd0b85a97d-38f6e95fe53mr2265351f8f.18.1740129277018;
        Fri, 21 Feb 2025 01:14:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf+WRwDTb33IJoPZ7+e5x/93DrQHvITVmrIZRx2bl0UdXAaNkbCjTX3FOpsGPEGSWpjgCfKA==
X-Received: by 2002:a5d:47a1:0:b0:38d:e481:c680 with SMTP id ffacd0b85a97d-38f6e95fe53mr2265324f8f.18.1740129276668;
        Fri, 21 Feb 2025 01:14:36 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f85c2sm23603237f8f.91.2025.02.21.01.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:14:36 -0800 (PST)
Message-ID: <c36c6de0-fc01-4d8c-81e5-cbdf14936106@redhat.com>
Date: Fri, 21 Feb 2025 10:14:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests/net: big_tcp: longer netperf session on
 slow machines
To: Jakub Kicinski <kuba@kernel.org>,
 Pablo Martin Medrano <pablmart@redhat.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <bd55c0d5a90b35f7eeee6d132e950ca338ea1d67.1739895412.git.pablmart@redhat.com>
 <20250220165401.6d9bfc8c@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250220165401.6d9bfc8c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 1:54 AM, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 17:19:28 +0100 Pablo Martin Medrano wrote:
>> After debugging the following output for big_tcp.sh on a board:
>>
>> CLI GSO | GW GRO | GW GSO | SER GRO
>> on        on       on       on      : [PASS]
>> on        off      on       off     : [PASS]
>> off       on       on       on      : [FAIL_on_link1]
>> on        on       off      on      : [FAIL_on_link1]
>>
>> Davide Caratti found that by default the test duration 1s is too short
>> in slow systems to reach the correct cwd size necessary for tcp/ip to
>> generate at least one packet bigger than 65536 (matching the iptables
>> match on length rule the test evaluates)
> 
> Why not increase the test duration then?

I gave this guidance, as with arbitrary slow machines we would need very
long runtime. Similarly to the packetdril tests, instead of increasing
the allowed time, simply allow xfail on KSFT_MACHINE_SLOW.

Cheers,

Paolo





