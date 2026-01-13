Return-Path: <netdev+bounces-249529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE57AD1A81F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 846CE30C59BB
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801F134EF10;
	Tue, 13 Jan 2026 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JhDK7wHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230D34EF02
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323492; cv=none; b=Nrn9Vhm2JcxbTat2dNHD6mmDi0YTIxDqRPc5CvsUk3LJ0iS8MoyzDFM9X9eI2N2JYBy6kzfwePFVnepOkmhJRmIX/SfsdA4mrycqcGuwYI9roqFyOScoDxh27H4oxfEJcOX97v1/MsR/oiZTrDnmPARsvzKiTaxa0F3uvenn1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323492; c=relaxed/simple;
	bh=tSOcPb7ZAFlwQU6op9fudwzWNn1hmHkkASUV4coELWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LN7OGqgjZwW42T/AW0uVHWrpOZRUhLLL/uA7V2g39E5gUgM6n3rHmttalMs3Tn1JpwcGYi+sF5xWdWTdYpMNLXnvRIaRtixRTFq/kKOc1Z5HB6wuG31oUFrnkAFTo+oS0nJKNVWkht8pHzbxXt4MJ585juhz9lVDn+EvLc2HQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JhDK7wHk; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-121b14d0089so8651248c88.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768323486; x=1768928286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ON88RRtAB2t+A02dvq9Ch82cNipWI4+bDnMpxNyjngk=;
        b=JhDK7wHkTwMKLDV2L6IAKLEx8KACxj0l1psCIX7tCfCs2cY3ktIOQqvOb2Yt3n4Rm2
         7AqZvJajl6FF4HsVvfdD8TMReqz+8/1DTU2/+PYuC7boUP/Bd7dl9ih6t3cYnG8WFXtX
         f5vt6uhp+j0bpX/vLGuOEqfNx+GTHX7Jw6sAfM9Y0HLasy3IFor3by1zifwwYAQSB5Dm
         5/5azA7ORvFqgrA7Rv5FAfYHAhfDrTHqHQ7X14gmSXn2Fot5JQJPVGOX5/7hJN+YeMBF
         Yw5+BUKlphEtaflT88R16jT20O1qiINm/WS2iMlF5DKnaTaCY4wpKDFnvHUBaC2bkfXm
         Zzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323486; x=1768928286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ON88RRtAB2t+A02dvq9Ch82cNipWI4+bDnMpxNyjngk=;
        b=ijkQMz0Z8V/Z977Hep/2cnc0jt6UfQM504VQiyW5ZavQIQPcBndJdDXnhJWMR0+ve3
         jn24V8/VUYTe7SBmhrVPXeyy/p7cp45hbD0q4woJXHuvo26m0OMsyfwuQ10lSTIO0ynQ
         +uqFmqoPE7RCMnAI0Lygu0AE4Ry/568+Ve6bcKAbgaRoM943faF70ob11FpKOrt2rCRz
         dlljGujwRvmfKevQcpqELSzjxuX9dn/F8JhwGpOCAB2iYC2GzoL9685tykOldfvxIDHR
         EM1WodOJUDC0jLMRCy8oElyljDTt3bof/YrnwixdtK9YDF4iaRYco8wxH0t7lTw7ryA7
         pRGw==
X-Gm-Message-State: AOJu0Yzv9JCxNOmX5OOGffs8bn/s6NqzeUSkxjvM8g01fYLvUgI8vsSP
	Z6rh3NryIXvZN3wNct5oCJD+Zt7nLdN+qqaMw4Joj2IFd+ID3ACZQmBKQERR0rhXXiU=
X-Gm-Gg: AY/fxX6apH82KxlOKYWvZForiHIsYuXXwTeroDJhMNE1GkvbZZCFcvGhYF7czpjnO10
	Gk+BFsHPVLY9MVJIL1m0PN30WefkWido7LJo2zP9ps3CQvX4Z7pINpuLNS4PFeXFEquy60LiXuC
	B2z//c2QuX5NthQLZqQNjhTmdOyeBA9e/pFloSDf75R4UCfc/2bvF6McSUg8SiWsWZIXVVaLp81
	eg9cksoQVYD3IqCBnqvmmjbxCO1JUSV1OTYgx03LF5Vq3IeA4BTl6HoYuisp8HWsWaq2fCRShQi
	gjoTsoU5y0yhRoeauNW5hL8H+OBfsBzKylkARDDmG9y9uWM6wgu6sRxf3fpfGrnB54lvtKAtwoM
	iz4I9fgwbTsRZqgYOCpiBdPZRm3t7utgbGk6OtrkkvtMM2eVV31mrcJUA8l8DEcL5G/NKa3JBwE
	cDT9Mrq20sEhIWuKLpypD7cozgY4P07piXWBohjxnDTDaW/5ta7KY4s2DdPHlXHsFPWm65u8z/Q
	5GSNKIKpQ==
X-Google-Smtp-Source: AGHT+IGVQRe1fdI9Qq2JBPWbzVxXkMCTfRiu053lQwRYE6yRyJOQ4RpPEZHGOsc/7AMUQsuHSS9lmg==
X-Received: by 2002:a05:701b:250b:b0:123:2d9d:a90d with SMTP id a92af1059eb24-1232d9da967mr2625938c88.17.1768323486006;
        Tue, 13 Jan 2026 08:58:06 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7ecc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243496asm27149784c88.1.2026.01.13.08.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:58:05 -0800 (PST)
Message-ID: <1b35b5d4-f1f5-48f1-84ae-fd975893ef19@davidwei.uk>
Date: Tue, 13 Jan 2026 08:58:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 14/16] selftests/net: Add env for container
 based tests
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260109212632.146920-1-daniel@iogearbox.net>
 <20260109212632.146920-15-daniel@iogearbox.net>
 <20260112195834.733c0ffe@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260112195834.733c0ffe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-12 19:58, Jakub Kicinski wrote:
> On Fri,  9 Jan 2026 22:26:30 +0100 Daniel Borkmann wrote:
>> +            cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}").stdout
> 
> tools/testing/selftests/drivers/net/lib/py/env.py:380:12: W0106: Expression "cmd(f'tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}').stdout" is assigned to nothing (expression-not-assigned)

Will remove and remember to run Pylint myself in the future.

