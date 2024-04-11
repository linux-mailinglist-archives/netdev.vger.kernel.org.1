Return-Path: <netdev+bounces-87164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808D8A1F5E
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CDB1F23D3A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A2E12E5D;
	Thu, 11 Apr 2024 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfado203"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92314AB4
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863289; cv=none; b=X44rFaYlQhL//G9bZzdJKvwR1wyKUogA++afPLLGzvvvRsjPvZO/hXOn1N/DBSbxd81PN5qSs+0Fln2USdEpkCpWHiYkNuhK4v1AocYw2LEyyEUy1rqEHsboeDmew9GR0mALQQDf6Pc5FWydGtUGBBlwcdX5qmjA+mgxUPsdOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863289; c=relaxed/simple;
	bh=Ik+5avN+F3onRNtV1PB619O8pLeIV7AzjthBG+4V4qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hupFVnWasve/7JKn8rQ6PdB+KeCvvwXvCVE6Ho5CDccH8gz1DHzBdBDnJEJ8pi+mqiGKv4kvOlQApkErMNtNnK4yDPzP/n2xLFp5Ffrbn3wcFqBdBd6hpy7Is/MdXefNrnLPZhrGaClsys5ZIkyykDr4OeuYyw2iMf/SvmYMJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfado203; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-436433a44bcso678701cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712863287; x=1713468087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UM2zuMgd2tTJ9l2V10ApEN63oRSs92Yz7I6KOrw/UzQ=;
        b=Bfado203S/AohII9moQyCKBRMwi2fzN4BzIkdtcbqIcdxPwKqMLuWabB1P0NRRz9XH
         rvGTSn/zP9d1FlCPWoq5OI8f4cWCi1aYMwRWgPo80Mw19LbPw/yOwsSUXpX8UjOKciaY
         sJ8100pcziw3N7WG2eQGJiPq72D8qP8eiwHaRy15HoW9nA0fdQTCfU42KdyUXkJfWvcE
         +/f5YDx82eQU+oXPNDcd7DOqWPn4wuzzBd8BcUhEQZH/X4YNANtsFoR2c66KIMUKZ6/l
         Md0uwH80ydBPKZ24WcVr9/8ZIArVPKgGZZk0kXVYyPkAkQNXUh/thABafQtSCBoIaQRX
         7Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863287; x=1713468087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UM2zuMgd2tTJ9l2V10ApEN63oRSs92Yz7I6KOrw/UzQ=;
        b=EZOAPSCZ04a90ORu9uUbyVHJDqfco+D9mzjWVn+Ux9WRPgyOQT9zXMxNPI2tZuVI06
         avoZHV+41OMO/E0DKtVd01Y0W0i/x/4N3abaOgEocM9lBaxMyuUX/Pq0enzQPjT0oIHQ
         DH/8wdlfzphFar34qah+GBWwQo67MlS9k+kTtqeFrxF4sN90oQoYfY04J3iKHC+7MrXR
         YN4rvHiKlAPTQ9yZ0ytyUFN1HQ2canF1snAu5jmLzitScA0HACeBTAlzDhq6LoV0mGri
         IKxXVPEwvhH2RdVX+s44nNnmj22oIsEJRfLY7Fw7WloaDAYrGwZiomkt3PeaNrmyw+S0
         XenQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpUDtWq2qUP6t5BiL/ag+T/Wz3BDJ5ut5iD9pst+aKq0OttwBUk7AvXvifv/6MEJoJMSIEQ8T33v/7xulCeA4WQmQFVcVK
X-Gm-Message-State: AOJu0YwcKbAKRpMIgEgBz5m/bSZ71Ck/W/l9ApgEt+H42d55KxOweabF
	eziH9zfARzZFiffHsf8WVrZEut0VJCNhA+plW8AQwThEKD3YtL1i
X-Google-Smtp-Source: AGHT+IGvHxA54aKOClekMdzRkSKoQQavDjhgxAQk3dRTaypFZBWOKdo0kFNXxP05O1GXsQzB8/QW1Q==
X-Received: by 2002:ac8:67d7:0:b0:436:8736:f0c1 with SMTP id r23-20020ac867d7000000b004368736f0c1mr150864qtp.47.1712863286926;
        Thu, 11 Apr 2024 12:21:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p26-20020ac8741a000000b0043123c8b6a6sm1274004qtq.4.2024.04.11.12.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:21:26 -0700 (PDT)
Message-ID: <a59e2164-7159-445e-9f87-fcf6cb4b57d6@gmail.com>
Date: Thu, 11 Apr 2024 12:21:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next:main 26/50] net/ipv4/tcp.c:4673:2: error: call to
 '__compiletime_assert_1030' declared with 'error' attribute: BUILD_BUG_ON
 failed: offsetof(struct tcp_sock, __cacheline_group_end__tcp_sock_write_txrx)
 - offsetofend(struct tcp_sock, __cacheline_group_begin__tcp_sock_...
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, kernel test robot <lkp@intel.com>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
References: <202404082207.HCEdQhUO-lkp@intel.com>
 <20240408230632.5ml3amaztr5soyfs@skbuf>
 <CANn89iJ8EcqiF8YCPhDxcp5t79J1RLzTh6GHHgAxbTXbC+etRA@mail.gmail.com>
 <db4d4a48-b581-4060-b611-996543336cd2@gmail.com>
 <CANn89iJMirOe=TqMZ=J8mFLNQLDV=wzL4jOf9==Zkv7L2U5jcQ@mail.gmail.com>
 <20240410183636.202fd78f@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240410183636.202fd78f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 18:36, Jakub Kicinski wrote:
> On Wed, 10 Apr 2024 19:33:54 +0200 Eric Dumazet wrote:
>>> Jakub, I do not see a 32-bit build in the various checks being run for a
>>> patch, could you add one, if nothing else a i386 build and a
>>> multi_v7_defconfig build would get us a good build coverage.
>>
>> i386 build was just fine for me.
> 
> Yes, we test i386 too, FWIW.
> 
> Florian, does arm32 break a lot? I may not be paying sufficient
> attention. We can add more build tests but the CPU time we have
> is unfortunately finite :(

Yes, that is why I mentioned multi_v7_defconfig, you an see the build 
failure with that configuration. Of course Eric fixed it now, thanks!
-- 
Florian


