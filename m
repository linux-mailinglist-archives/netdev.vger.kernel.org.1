Return-Path: <netdev+bounces-74003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F285F995
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0361C2362B
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E718B12D752;
	Thu, 22 Feb 2024 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Qq9S4MVu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE563F9ED
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608144; cv=none; b=VY2ijGdgU7CqAvyZU4arvQfBk1WQmn3842e6cB0e6+KVeR5xCIBbZLIqVwnP+rDZea+gx62UazoyIgu93gV3ZgVCgTzCUlPVRnBdbkozCXN+RM5zpGci6YPaoxmLsH5Xn2lDTE0CpOtQIAy1P9EYq/2+M619y6WMOe0BhSKzHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608144; c=relaxed/simple;
	bh=TySvDzYJXSdCZgcLlQxwcOAIILLG83oupUxyqRQSwdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itHUu7j9FCQ8IDKeB821L32oyYiCWZ+8yAvS5tDMX7TJV7an0BOuWIuNC/5XEzzDJCC5ttd3bNzqnO7gJlkHRf/K1uQIsTRfX0mDQEz2Lz0FBqp53l5bME8W/tuVDlpPV292nZ3CDu5n2/zYjv2QZkcety/15YK7xyWIyCmZVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Qq9S4MVu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d146737e6so5218202f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708608141; x=1709212941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/Sr5FIkChTbkaU7EdiknVp8OIC36l2utmGmnGMVRPM=;
        b=Qq9S4MVu7bSICKote1PWuHKERMNHyXE/FYkkUOgc2rz5E2Twc07uCFticDoZVraEM4
         hBaYMD+ttv6BXfUAZr/K99c69jfEdgoHgRjgNY+SqiHMxYyhwnbzzpGqWKcsK+eiKxmt
         M88y+3QnA3fIhZDxECjmpthUD1Z6j0IeGop//nHsqMihiEgJd2EdAa0tTTCVitBobuLS
         jLb1TBXJosqpyoBem8HVHZss1Ke7TQQ89ZIxn41TH+VXQ1j9LQeOWWhhJ5LiJs2XUUBJ
         KWj3iZfXHb1if2tiJJ7nZKd3bhlTNFp2tw2UeMe1lR7vBLNQPKAGz9x+t6fhXVehOC38
         cUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608141; x=1709212941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/Sr5FIkChTbkaU7EdiknVp8OIC36l2utmGmnGMVRPM=;
        b=VNXwuoujTVVVsGHCrY0pxB9ThlPiRCbv74JIDAcRHbvK/VoLFziBIJwXANaisTKcpU
         wCPFMQbp8iD8vobqg4f4vQJuoevv13kDpXBC7aPvK0nphKfVFSfApPQI8BbzXWsz1Bto
         WUiuekEuTDcZ3M50/xWA1yCXP35nemfnn+N4gCzR6gWdSquvtLTsr0ljhUzWfguNA34P
         Q9nmCYDdTc6fZutKCpAwIHFLNxZRqs1YaZ+c4ft68RB8s+0wOTPWkV1gChY2qsIQuvVW
         eDx1QNlceshnWPUQXQVlHs676hgoJktt3bjAZu53wqETORZPPZlOy9Z3jAF44vb9rtmB
         98jA==
X-Forwarded-Encrypted: i=1; AJvYcCWjQCEg2BRAU1p9owgCHF3otQE5vWWjlsAYz7J7M2wrKNwoCHcQp/xdE99C5x3Jgl0wD0QwxuLSiD3xt67E9EqvU3i07E0I
X-Gm-Message-State: AOJu0Yyzr1cO/wfD/IPWAcEps2mDiwO51+KwEUeO+FBnsbpsKUgCDkEN
	G3C8hmoJWuKuHDnsH5XLGlikie8WS1ooHW4YVFW7wsOMJ0pB5IpzhLq0nLDG6hY=
X-Google-Smtp-Source: AGHT+IFra6ItDFXWxhNdhaD57+kPLzlPjfeuY93NA5sgFeczEf9BRhKowWEEfh0sRszy1RhYuvlL8A==
X-Received: by 2002:a5d:522d:0:b0:33d:9c56:37f4 with SMTP id i13-20020a5d522d000000b0033d9c5637f4mr615379wra.46.1708608141361;
        Thu, 22 Feb 2024 05:22:21 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d5184000000b0033b4f82b301sm20628726wrv.3.2024.02.22.05.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:22:20 -0800 (PST)
Date: Thu, 22 Feb 2024 14:22:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Yochai Hagvi <yochai.hagvi@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: Re: [PATCH net 1/6] ice: fix connection state of DPLL and out pin
Message-ID: <ZddKiZt1-OSAX39M@nanopsycho>
References: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
 <20240220214444.1039759-2-anthony.l.nguyen@intel.com>
 <2d4d91a0-5539-4cc0-850a-3ccd44fcc648@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4d91a0-5539-4cc0-850a-3ccd44fcc648@linux.dev>

Thu, Feb 22, 2024 at 01:31:53PM CET, vadim.fedorenko@linux.dev wrote:
>On 20/02/2024 21:44, Tony Nguyen wrote:
>> From: Yochai Hagvi <yochai.hagvi@intel.com>
>> 
>> Fix the connection state between source DPLL and output pin, updating the
>> attribute 'state' of 'parent_device'. Previously, the connection state
>> was broken, and didn't reflect the correct state.
>> 
>> When 'state_on_dpll_set' is called with the value
>> 'DPLL_PIN_STATE_CONNECTED' (1), the output pin will switch to the given
>> DPLL, and the state of the given DPLL will be set to connected.
>> E.g.:
>> 	--do pin-set --json '{"id":2, "parent-device":{"parent-id":1,
>> 						       "state": 1 }}'
>> This command will connect DPLL device with id 1 to output pin with id 2.
>> 
>> When 'state_on_dpll_set' is called with the value
>> 'DPLL_PIN_STATE_DISCONNECTED' (2) and the given DPLL is currently
>> connected, then the output pin will be disabled.
>> E.g:
>> 	--do pin-set --json '{"id":2, "parent-device":{"parent-id":1,
>> 						       "state": 2 }}'
>> This command will disable output pin with id 2 if DPLL device with ID 1 is
>> connected to it; otherwise, the command is ignored.
>> 
>> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> Signed-off-by: Yochai Hagvi <yochai.hagvi@intel.com>
>> Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_dpll.c | 43 +++++++++++++++++------
>>   1 file changed, 32 insertions(+), 11 deletions(-)
>> 
>
>For the series:
>
>Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

I also find this set okay. Feel free to add my rwb tag as well.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

