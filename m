Return-Path: <netdev+bounces-274447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM1gEkk+zmkImQYAu9opvQ
	(envelope-from <netdev+bounces-274447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:00:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BEB3875B2
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45625300B50F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45043D9024;
	Thu,  2 Apr 2026 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VW9bQhbv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+kV8++Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A703D9DA7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123333; cv=none; b=pO0fEdl2Y3vL3sHZUIRUDEKCRQBbs/Qezw5yO2emcfi3pcDTk1fst9nSYVt9RmeHwoDPzUMgrxjprwM1GV4x5m6If1xQIhGw0a7RjgHwifn0T60Gpmvg8YjePOwNmewMJzQFCSePjNjGtQoeVSTT/Fk9rxKGRGvUj5tNfk/Balo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123333; c=relaxed/simple;
	bh=FxR2bhBkRY0ikaJ1Hs1fd9nHf+FN0AGKBDKZwHlC+gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC+4FPKGO682Cz6Je9mtg+SNoOms0VHjWTS7LCixEQduNnrsbbTd9RMFEckwsA/EL2ZI59eTL93MPf/mvGuXNPS/YrFwmjRVZmGP7BGF/Afvj5N/Cd33RzdrTQ0qa13iVX6LxRu2u/cLECNlbYqfBykJdCE2C+LJv2Ukkfo5fx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VW9bQhbv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+kV8++Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775123324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLN44LxxXgYTiWrwLkxzAK8Zoqz3iKp5J7224wtn/u4=;
	b=VW9bQhbvVZQ7oLqHqk11vd+I2/mQnpiG78NxGL/kHbdn257N2qsdKbr1frRsBsEygvM7HH
	MwhOKfFa7t6KZL7bvBGM5mUqcfrdJlzBKEKDO/k0FjqWR232BN3iQ5Y1x2iBfSAu3Ek/zB
	kj/qxIDtt26MTNxddvTPHtYH7yKuR64=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Wyuj-eeJPxa43oKgOCt96Q-1; Thu, 02 Apr 2026 05:48:43 -0400
X-MC-Unique: Wyuj-eeJPxa43oKgOCt96Q-1
X-Mimecast-MFC-AGG-ID: Wyuj-eeJPxa43oKgOCt96Q_1775123322
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4888873abc4so8552245e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775123322; x=1775728122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLN44LxxXgYTiWrwLkxzAK8Zoqz3iKp5J7224wtn/u4=;
        b=Z+kV8++ZG8I0b/VTs68aucsnVGe8e4N2ThrqekVy5f+PN469KC2Vpm51FR6lSWKBsN
         SvJrwCZd78z0vE5/PknU7G9YVW2qV60KqxLkhVkZ8CruVwX1QeFvy5vbBvhTZAohVbsP
         4jTYGTUHM8T9Nu5hIbn33hsmDmPa2uMwtqCZWwZyuyKTLsD9QM4wV5NUqfYtBG0sWV5W
         U5cNbV0B0FQ5fM1QuBboCQaaelwbqr8CqBCMY+jNmsCt5tS4uQ19EXBbhXtH8qWAgq7k
         gjt0LNNMWDHRIN/UiPtwU1GiE9aYN/4k+Bqfa8QI3yfJJBnVlpN/DUSZcWUJOwZt0kvY
         XllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123322; x=1775728122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLN44LxxXgYTiWrwLkxzAK8Zoqz3iKp5J7224wtn/u4=;
        b=ScnRTKws+uyjWUkVuLwtlusVP2yzGPAh3u1IJ7UA2u76OMJ2HCv39J7AT1vmYqO6mI
         0Q4y6mWhFhfeTCkRHVpGhD94Y0dB4CG4Y7Y3VtQTloh8h0+QRvP9WtFvIthh2uAMKmo2
         Sk3J9TV/UzFJs98QcIy/gsKLPz3MLMldrnHA6gprDkOZR2yckkUkEz85gYriF1rFc+ky
         Tm7CWgNo6OIyfX5TFHbqVSvkCZYTj4BYHd2w4Ap1XfjmqxnxZnyBk3nIxCvBaGLyCzBn
         01QGRDZhUIaunbg7nW96KT3Z8rcU1t5gsT1M9z1B3pakQVQlXOXfG5sd73ATHZiqRWbD
         mnNA==
X-Forwarded-Encrypted: i=1; AJvYcCXngi4PVD8G+TWAFhqsnRBpiPMoaHOOWbWAmQWUvjFAgSweIyXvAr7IhjPk3RYACEprHVLz3wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnS+RWYBufF4U8sw10lg8EMFwWRAzbcNlTFGS3cfwZFgmOUvKV
	pDdY3Wmwb0ICjaoqdxD6S6Bco8nkcWhKG3KPPcp9Pd/TN8uY4NQfEXCxfI0pTRdMjOun70vNglR
	8N4K8bp0taw/myaN/UoVqy1AhZ49naTPUDHzegqzHF/QacliMijqv4ET7Zw==
X-Gm-Gg: ATEYQzwchVrrXLGsNxkARjfIJ50alft/I8nUm88O222lsdCMUEjRBsRheWTTwvgcDm6
	Q0nhdVNUemLWoYMhHj0VtSqxPmDkcH0+Do2R6e+Uay3mjFw2d4FGPd0ihyNWSJGP/LEE5YrIFuL
	EXlXxX6etCNSbKi4JMF8rfH6J0Uw6cCtgy82V8kuozWTVmGjHdNfEcMJStMWYwSK1D0yAeSzymp
	SY/fViIeoquIvRmI9sMT1PQhRit4HP+G6LAyDfY7dts7O3DS1PRbukW2njWXJVspou/kUVv7fki
	NwFmTGuPS+WkG4JjO7hvT0D0g4x8FK4z2x9ypSbrqg3bZLSwTD9nowlIlDM60fvjDT7KGIsbDSX
	c0EQ+t738DMM+m2Vp3N9hh3ndKDgsMNid3T61sdRVyeOcPKNMqWLEn8/k3g==
X-Received: by 2002:a05:600c:45c5:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-48883592213mr114334255e9.23.1775123322346;
        Thu, 02 Apr 2026 02:48:42 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-48883592213mr114333895e9.23.1775123321886;
        Thu, 02 Apr 2026 02:48:41 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm148784745e9.9.2026.04.02.02.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:48:41 -0700 (PDT)
Message-ID: <50ae3c69-2c4e-499f-a46a-cbd207ff5f09@redhat.com>
Date: Thu, 2 Apr 2026 11:48:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] selftests: net: add tests for PPP
To: Qingfang Deng <dqfext@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Dianne Skoll <dianne@skoll.ca>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Felix Maurer <fmaurer@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
References: <20260330035604.133073-1-dqfext@gmail.com>
 <20260401081030.29b050d5@kernel.org>
 <CALW65jahWApDnVmFReW+Y3HDxBEmCwzsT1oyh03SW7X5ry6PzA@mail.gmail.com>
 <20260401175621.549c492e@kernel.org>
 <CALW65jaTbaosbO8ypKZ6G37HxuxXabeTaP_Fhq72xTovmDj+8g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALW65jaTbaosbO8ypKZ6G37HxuxXabeTaP_Fhq72xTovmDj+8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274447-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,skoll.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pppoe.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47BEB3875B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 4:26 AM, Qingfang Deng wrote:
> On Thu, Apr 2, 2026 at 8:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
>> On Wed, 1 Apr 2026 23:45:38 +0800 Qingfang Deng wrote:
>>>> # iperf3: error - unable to connect to server - server may have stopped running or use a different port, firewall issue, etc.: Network is unreachable
>>>> # TEST: PPPoE                                                         [FAIL]
>>>> not ok 1 selftests: net/ppp: pppoe.sh # exit=1
>>>
>>> It looks like pppoe-server fails to start. You may check the syslog to
>>> see what's going on.
>>
>> Hm, we don't capture syslog automatically :S We capture stdout and
>> stderr
>>
>> I'm not even sure there's something listening on syslog in virtme-ng
>> Is it possible to make the daemon log to stdout or a file and dump
>> that file to stdout on failure? Even if we fix the current issue
>> it will be quite inconvenient if we have to go into syslog every time
>> the test is failing. The test output should provide enough info to
>> debug failures.
> 
> Add Cc: Dianne
> 
> I checked the man page of pppoe-server and did not find such option.
> We can instead start our own listener and redirect the syslog to a
> file or stdout:
> 
> socat -u UNIX-RECV:/dev/log,ignoreeof STDOUT &

Note that similar failures in the past in other test-cases were usually
due to timing issues. i.e. the pppoe-server starts in background too
late for the client.

Possibly a somewhat clean solution is to wait in a loop for the
'pppoe-server ready' event, somewhat similar to wait_local_port_listen().

Otherwise an hackish sleep in between should do.

Note that you should be possibly able to reproduce this kind of failure
in a virtualized/slow enough environment (i.e. using vng as described on
nipa wiki)

Finally, note that in this test script you should start the socat
listener only if /dev/log does not exists, or ignore socat startup
errors - because self-test should run also on different systems.

/P



