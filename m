Return-Path: <netdev+bounces-135585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03CF99E473
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37D11C20F33
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6821146D55;
	Tue, 15 Oct 2024 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wn4XhrL9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D616A92D
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989218; cv=none; b=df/W48WD4bcQjN9rLY89ycNxxb4cS9jWqrFfcuSGZt76qX6lyzoeZ1jiqdDeLeTJ7Ryuhqvc4NfQ4zOMrXXu/WOPbbJEKyZogNOVROlas2f87sZEMYwbY2XZu1Mx/UITiE56CI1jKOj231WhsY5FFUrlUTueBqnaRmYcxDDR1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989218; c=relaxed/simple;
	bh=JbGYC94SBTd36kaLgYONpoB5/edTGqERj6FLvw8mhTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9LC69MxFeKBMdpRB3ONw4VzE7Ub8fjgBpSxtcQwot5XqLq9EXCKFp4xOG0awa8L4PDmYOD2MpHssFWrIKiIiOsxxRak+0ns9lpfyU+Pm6GPPQCKKiAYOqYITEFEBYg0RNvvFxh0ts5AcZl1qaf4F4nPTz5W78Y7ZAz4CYSoE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wn4XhrL9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso106420766b.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728989215; x=1729594015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=520DfjHdYRRP2GFNU0/yY3BItKCuA8awUDQGTCRwXIQ=;
        b=wn4XhrL9MzyE5n8dTaoMUuLsz46qXnHMgX4rnDetwZT+LzGAqgdcMLGRlZYTcFsb7F
         f7n0i3JXxEpXuJrinPOqmgdNp3Xag33AnbACdsCIol1VBJZ9YdHN8SjPo85tJU++9ZtH
         qEVIgzDiwewMB7RERWGGplQAdE69GtQl1ppHyOUZ4/pnvs0OzcrMqKTP/8I2Ok7/IB13
         ES5I0NqwqVx+Nd2QWt5DMvUmqqNnvxmSnr38R40oY6cp2pe5kc5pHTqGNTWeElYcmhv3
         z9CDCr6kMnxRpd6kCGK3tSm+2AeNGb/T16GCVqfE8fc6KJLPLIjlx8rwM1HPAN0UZ5CL
         bu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989215; x=1729594015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=520DfjHdYRRP2GFNU0/yY3BItKCuA8awUDQGTCRwXIQ=;
        b=ocVPeLAfiZ1lhaZu8PQcruVaSfmNO8/zF/ZDftIt/GimYwk2tTk2fo3UQiq5/jGvYc
         +YVR/ofhDGNdwKrBT62PKDw8ZNZ1BVvKYJDPD5eyj+ixAUGlkmB5CykS3VZ1GudIUBNu
         9xbsObmYX2pQMFbHVmZ+eCZBfCC7jbXcv9T0cYuKeKw+ACAcgX9rGVHoNzSp3dvOgOqM
         I0oN78ZO0PSSVkV3ptjXUB1Z5HVmuCZDv4YgISj++a8+PptSSSt2HVaSRqNW/zq9n9lI
         YQXu7Ww3j+YZxPgO9RyMUe16eZcy6JeiO3xQFPUrsLbEV/xRSuvp3pFXlQz9XNtZMHMr
         tTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXheXPFxMxmExe5UppDBAOd1FIgqawtPv7IyNZAYmuAGGshh4vsIecKt4gMZHrqMK4IKg83ciI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMMeD8byueJW4rwXRYqt8JIA9tpAS+n+jJI/PqOW7V+LmQvbm
	nxQO4j/sjU7yTW1SQGwoht50H+rx7OSmKiuW/8xDuMK1Of4q5wnN8dSmPSV8xeg=
X-Google-Smtp-Source: AGHT+IFD6hmt8hzEHRuoWoYB8e9k1HX3rhZ3I7fiMF/ztMLUUs26xHrhkT81z761RfYRJPnjMCr2Bg==
X-Received: by 2002:a17:907:2cc2:b0:a8d:439d:5c3c with SMTP id a640c23a62f3a-a99e3b20d62mr1070172866b.8.1728989215149;
        Tue, 15 Oct 2024 03:46:55 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29717303sm56424566b.7.2024.10.15.03.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:46:54 -0700 (PDT)
Message-ID: <8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org>
Date: Tue, 15 Oct 2024 13:46:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bpf: xdp: fallback to SKB mode if DRV flag is absent.
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20241015033632.12120-1-liuhangbin@gmail.com>
 <8ef07e79-4812-4e02-a5d1-03a05726dd07@iogearbox.net>
 <2cdcad89-2677-4526-8ab5-3624d0300b7f@blackwall.org>
 <Zw5GNHSjgut12LEV@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Zw5GNHSjgut12LEV@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/10/2024 13:38, Hangbin Liu wrote:
> On Tue, Oct 15, 2024 at 12:53:08PM +0300, Nikolay Aleksandrov wrote:
>> On 15/10/2024 11:17, Daniel Borkmann wrote:
>>> On 10/15/24 5:36 AM, Hangbin Liu wrote:
>>>> After commit c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags
>>>> specified"), the mode is automatically set to XDP_MODE_DRV if the driver
>>>> implements the .ndo_bpf function. However, for drivers like bonding, which
>>>> only support native XDP for specific modes, this may result in an
>>>> "unsupported" response.
>>>>
>>>> In such cases, let's fall back to SKB mode if the user did not explicitly
>>>> request DRV mode.
>>>>
>>
>> So behaviour changed once, now it's changing again.. 
> 
> This should not be a behaviour change, it just follow the fallback rules.
> 

hm, what fallback rules? I see dev_xdp_attach() exits on many errors
with proper codes and extack messages, am I missing something, where's the
fallback?

>> IMO it's better to explicitly
>> error out and let the user decide how to resolve the situation. 
> 
> The user feels confused and reported a bug. Because cmd
> `ip link set bond0 xdp obj xdp_dummy.o section xdp` failed with "Operation
> not supported" in stead of fall back to xdpgeneral mode.
> 

Where's the nice extack msg then? :)

We can tell them what's going on, maybe they'll want to change the bonding mode
and still use this mode rather than falling back to another mode silently.
That was my point, fallback is not the only solution.

>> The above commit
>> is 4 years old, surely everyone is used to the behaviour by now. If you insist
>> to do auto-fallback, then at least I'd go with Daniel's suggestion and do it
>> in the bonding device. Maybe it can return -EFALLBACK, or some other way to
>> signal the caller and change the mode, but you assume that's what the user
>> would want, maybe it is and maybe it's not - that is why I'd prefer the
>> explicit error so conscious action can be taken to resolve the situation.
>>
>> That being said, I don't have a strong preference, just my few cents. :)
>>
>>>> Fixes: c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags specified")
>>>> Reported-by: Liang Li <liali@redhat.com>
>>>> Closes: https://issues.redhat.com/browse/RHEL-62339
>>>
>>> nit: The link is not accessible to the public.
> 
> I made it public now.
> 
>>>
>>> Also, this breaks BPF CI with regards to existing bonding selftest :
>>>
>>>   https://github.com/kernel-patches/bpf/actions/runs/11340153361/job/31536275257
> 
> The following should fix the selftest error.
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 18d1314fa797..0c380558a25d 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5705,7 +5705,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>                 if (dev_xdp_prog_count(slave_dev) > 0) {
>                         SLAVE_NL_ERR(dev, slave_dev, extack,
>                                      "Slave has XDP program loaded, please unload before enslaving");
> -                       err = -EOPNOTSUPP;
> +                       err = -EEXIST;
>                         goto err;
>                 }
> 
> But it doesn't solve the problem if the slave has xdp program loaded while
> using an unsupported bond mode, which will return too early.
> 
> If there is not other driver has this problem. I can try fix this on
> bonding side.
> 
> Thanks
> Hangbin


