Return-Path: <netdev+bounces-170303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751CA48185
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF283A23E6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65D22DFB3;
	Thu, 27 Feb 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vFgLMJrJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB122E011
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666794; cv=none; b=mrUd3ZU1Eef3txdZhHjLtZPD7LvOyRZsch1HOfwU5CI3fJ6ekf36ARsJFEiGfqxsSWme2NFNpwMY68WPv2i9p5ErS+SWVojyVCjLjYmOQJqQYiDyxPsxvJZuf3+zn5Z2Uf75i1i2EFgkZ5QNgAQNiTKwz6uylX5hJ6KGxTH8kLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666794; c=relaxed/simple;
	bh=DkA+xdk8V44PLDar1soInWBxdgLcgkH47xUMlr3fKpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDjtdqRITyKhkDwNrlOl0kZ57MGYSk761FoxANYqpViXUzaq8Svi2xYPKdDyzR6jnuZflNGSPtDWHCNPzbXksHKla8vuE5OUrNHOmYmxTav9f8Wa30Xp/MFgx8j0VfPYdWuUDJi+bGwNFxWft+FPzfEG77caXHM/P4fErClxUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vFgLMJrJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso156241566b.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740666791; x=1741271591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqcI7bIKtRgMXEJtm//I62DrpllTijCm+8YLWN+QICc=;
        b=vFgLMJrJz7KsKJSNVE09xIQn+icpPVZ+MEMnQY9J6Y7qTPLeWx+ZZm3Ji9mDJqZt8q
         LJkYB9R73bzxZWfCK94KT34PnqRdLYJYwWDhAS0yDEOydYwVIRvzf5nvEBMNwFcF2Nh6
         EC5n0NYeLc17P2FN8Ub8PKS9S9TDFx19/SQ9vVqxigATnhTZTFm0Eyagfudjbk3EwzpH
         QhzwLR5ZnusyHJri7ridWef/EFKNUkhQOJdu8ET8D5eUiIufQhH2uatL/+Cr1ZHJEu0D
         /CBVfHf6H2jFI7J84ZcBeLVih74riQG8UZeQEJHV1mTfUJP7GkJ56pT2KIkv2/V4cw34
         67GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740666791; x=1741271591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqcI7bIKtRgMXEJtm//I62DrpllTijCm+8YLWN+QICc=;
        b=X+PBIm9Gc6MoeQEAFxhYu/P12tNTWqF7QHuQJvPQyGTjnfeLhFSv0hzsM1rVcLCkzy
         mGv98b37OoRQxyS8K009DftuxkP7pOeFduX2melNlGVi2Zjsa5pJMn6DiTxe4PS2vScB
         6t0ZvnsLb771GuLokfAdLa/qxx+xZxGcPXG3LLWUlgYhKhonm6Hh1SSUtbYNMKl8KE9/
         6fFW2nRkNHRaSpqqwbxzGWLmmd4Hd1PerAzqwHXzKlxoEF9yojoq7XPgkvi4ALCDMyTB
         tayTVdqesdQQTw3iwXna6ReOjTDaoPb5P4HITV9hwgwsISqzwikztAWJY4AseoLyOQhU
         ZWSA==
X-Forwarded-Encrypted: i=1; AJvYcCUYuNgDaUH5LwSCRW6SLpMfYNF5fo2pNut9spMSuE/E1oNMcFTAJKffbZE8NVrA4Zq/vLtpHxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1TFA500R4K7Jp7H9imgzZp+C3HvlnZeLwUNWGThRNQRgzJJhn
	KuKSPoRJjkhADD2joLCNiRhEAGls+jCYbc1GoLqONnQ0wJGnJ+fbcR7UCteFYuY=
X-Gm-Gg: ASbGnct9w+7PRx788uaNHGFNb2OE2oCJUM/n4NHdwpBY0QIt8xTRXB4HXZa1F8oXgzy
	Szl+FDjiqbZUZ/na9t2Hvk8h6AqPCUzkYfvHKK51f3igDN/8stlvsIcCw55KnZnPdGijTVCyVtQ
	+7WfR4Qg51nSeHZU6vOxl+IzmukrkKc5bNYcJcuUNE7grD+wFs2oYFcUmAO8jYc68YrNaWBN5Ii
	VRovjzelSA1PFTLU+hLHWFrBs4aK2j7NEnrYeV5EVrP6ohqA0I72+GlM0/nEOMNajMBlFnw6/0P
	+1YbiMEV0Y2/5Lbu60bq3h9AIf2CXpyLLhrtLlwjRf2EPoxmWQaHMyGQkQ==
X-Google-Smtp-Source: AGHT+IE8UmPRAd4qlsA4JsjOKEJQBA6U+1PAwW5p2zGDZCYrEJ1GjEjuGBTIshNRdWxIuX48Rd5JKQ==
X-Received: by 2002:a17:907:7ea0:b0:ab7:d361:11b4 with SMTP id a640c23a62f3a-abc099b7f3fmr3119521166b.7.1740666790352;
        Thu, 27 Feb 2025 06:33:10 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dc168sm132225766b.70.2025.02.27.06.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 06:33:09 -0800 (PST)
Message-ID: <5cf5c38f-1a1b-4e67-8f9f-7b37c4f270a6@blackwall.org>
Date: Thu, 27 Feb 2025 16:33:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
 <CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com>
 <20250225170545.315d896c@kernel.org>
 <CAA85sZuYbXDKAEHpXxcDvntSjtkDEBGxU-FbXevZ+YH+eL6bEQ@mail.gmail.com>
 <CAA85sZswKt7cvogeze4FQH_h5EuibF0Zc7=OAS18FxXCiEki-g@mail.gmail.com>
 <a6753983-df29-4d79-a25c-e1339816bd02@blackwall.org>
 <CAA85sZsSTod+-tS1CuB+iZSfAjCS0g+jx+1iCEWxh2=9y-M7oQ@mail.gmail.com>
 <ed6723e3-4e47-4dac-bc42-b65f7d42cbea@blackwall.org>
 <CAA85sZv5rQr4g=72-Tw47wSE_iFPHS4tB8Bgqcs59sdh1Me2sw@mail.gmail.com>
 <4604b36b-4822-4755-a45c-c37d47a3adc2@blackwall.org>
 <CAA85sZutt0Eydh4B5AUb2xgvPkPF2Wa2yU4iXprgmRFPVM5qUQ@mail.gmail.com>
 <CAA85sZsq4JnatO0TjhN=o6S4adq7pQDC8A5dtRrBKeY9ry0NfQ@mail.gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAA85sZsq4JnatO0TjhN=o6S4adq7pQDC8A5dtRrBKeY9ry0NfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/25 16:31, Ian Kumlien wrote:
> On Wed, Feb 26, 2025 at 11:28 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>>
>> On Wed, Feb 26, 2025 at 2:11 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>
>>> On 2/26/25 14:26, Ian Kumlien wrote:
>>>> On Wed, Feb 26, 2025 at 1:00 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>>>
>>>>> On 2/26/25 13:52, Ian Kumlien wrote:
>>>>>> On Wed, Feb 26, 2025 at 11:33 AM Nikolay Aleksandrov
>>>>>> <razor@blackwall.org> wrote:
>>>>>>>
>>>>>>> On 2/26/25 11:55, Ian Kumlien wrote:
>>>>>>>> On Wed, Feb 26, 2025 at 10:24 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> On Wed, Feb 26, 2025 at 2:05 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>>>>>>>
>>>>>>>>>> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
>>>>>>>>>>> Same thing happens in 6.13.4, FYI
>>>>>>>>>>
>>>>>>>>>> Could you do a minor bisection? Does it not happen with 6.11?
>>>>>>>>>> Nothing jumps out at quick look.
>>>>>>>>>
>>>>>>>>> I have to admint that i haven't been tracking it too closely until it
>>>>>>>>> turned out to be an issue
>>>>>>>>> (makes network traffic over wireguard, through that node very slow)
>>>>>>>>>
>>>>>>>>> But i'm pretty sure it was ok in early 6.12.x - I'll try to do a bisect though
>>>>>>>>> (it's a gw to reach a internal server network in the basement, so not
>>>>>>>>> the best setup for this)
>>>>>>>>
>>>>>>>> Since i'm at work i decided to check if i could find all the boot
>>>>>>>> logs, which is actually done nicely by systemd
>>>>>>>> first known bad: 6.11.7-300.fc41.x86_64
>>>>>>>> last known ok: 6.11.6-200.fc40.x86_64
>>>>>>>>
>>>>>>>> Narrows the field for a bisect at least, =)
>>>>>>>>
>>>>>>>
>>>>>>> Saw bridge, took a look. :)
>>>>>>>
>>>>>>> I think there are multiple issues with benet's be_ndo_bridge_getlink()
>>>>>>> because it calls be_cmd_get_hsw_config() which can sleep in multiple
>>>>>>> places, e.g. the most obvious is the mutex_lock() in the beginning of
>>>>>>> be_cmd_get_hsw_config(), then we have the call trace here which is:
>>>>>>> be_cmd_get_hsw_config -> be_mcc_notify_wait -> be_mcc_wait_compl -> usleep_range()
>>>>>>>
>>>>>>> Maybe you updated some tool that calls down that path along with the kernel and system
>>>>>>> so you started seeing it in Fedora 41?
>>>>>>
>>>>>> Could be but it's pretty barebones
>>>>>>
>>>>>>> IMO this has been problematic for a very long time, but obviously it depends on the
>>>>>>> chip type. Could you share your benet chip type to confirm the path?
>>>>>>
>>>>>> I don't know how to find the actual chip information but it's identified as:
>>>>>> Emulex Corporation OneConnect NIC (Skyhawk) (rev 10)
>>>>>>
>>>>>
>>>>> Good, that confirms it. The skyhawk chip falls in the "else" of the block in
>>>>> be_ndo_bridge_getlink() which calls be_cmd_get_hsw_config().
>>>>>
>>>>>>> For the blamed commit I'd go with:
>>>>>>>  commit b71724147e73
>>>>>>>  Author: Sathya Perla <sathya.perla@broadcom.com>
>>>>>>>  Date:   Wed Jul 27 05:26:18 2016 -0400
>>>>>>>
>>>>>>>      be2net: replace polling with sleeping in the FW completion path
>>>>>>>
>>>>>>> This one changed the udelay() (which is safe) to usleep_range() and the spinlock
>>>>>>> to a mutex.
>>>>>>
>>>>>> So, first try will be to try without that patch then, =)
>>>>>>
>>>>>
>>>>> That would be a good try, yes. It is not a straight-forward revert though since a lot
>>>>> of changes have happened since that commit. Let me know if you need help with that,
>>>>> I can prepare the revert to test.
>>>>
>>>> Yeah, looked at the size of it and... well... I dunno if i'd have the time =)
>>>>
>>>
>>> Can you try the attached patch?
>>> It is on top of net-next (but also applies to Linus' tree):
>>>  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>>>
>>> It partially reverts the mentioned commit above (only mutex -> spinlock and usleep -> udelay)
>>> because the commit does many more things.
>>>
>>> Also +CC original patch author which I forgot to do.
>>
>> Thanks, built and installed but it refuses to boot it - will have to
>> check during the weekend...
>> (boots the latest fedora version even if this one is the selected one
>> according to grubby)
> 
> So, saw that 6.13.5 was released so, fetched that, applied the patch
> and no more RCU issues in dmesg
> 
> Will check more on the suspected performance bit as well when i get
> home later tonight
> 
> I also understand Sathya Perla's motivation in saving power on this
> but things around it have been changed
> and it no longer works as intended....
> 

Nice, that's good to hear. Wrt the motivation - sure it's ok, but the code was wrong
if they still want to achieve it, they need to work on an alternative solution.
We shouldn't keep broken code around.


