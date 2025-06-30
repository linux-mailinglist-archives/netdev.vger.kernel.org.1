Return-Path: <netdev+bounces-202351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9A9AED820
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032D616BEFE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D57219A7D;
	Mon, 30 Jun 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOtKimIZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FC11CAF
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274297; cv=none; b=YBfMS5XP69fWXKj6DZsoBnHB3bJ4h9Tvb0522izcn9Bt4rQPatoqippP4gy1UN6wAxjY4TDRQrXncpfjFwdrqVtlAUZpgamrfFlHvhW5FsD2eYDyJjpGx/mK5vA/tMg+1kVS3c9Xc3YNyoGumIwJdR31xshkh09O+J/6G+xk1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274297; c=relaxed/simple;
	bh=+v0QRJUIlCgBCZtPBfzgb3Ma4Y6G4+2LuEvI0glH2rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgA3OW3jedWgncsp0yfwcJ8tZHuEg+qbonPtSIISmxUXT+OeEIHMQpEUUWFiCX7GMQR2eOgMmydD3y83ivoKgjdGQ33rgcz25XKyogewO1jAhyJzGY6ug4VeW24IH1lzqoak8ORW8OmGja7cQIwqZDUSfl4XflMR3lo9bUS+Prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOtKimIZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adfb562266cso688543566b.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751274294; x=1751879094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vx73D3BjkBS7xqu3PZTLpysE9yeAtBFApKxKDv3J1TQ=;
        b=hOtKimIZMJhhgRonYTv9r7rTNkm6f0O8BDeWiCBrrAP+YuNseesmPznPYIFeYLp/5S
         322sWf+ApIYprJ+o+wIXLzFbt7nRNy4luusOqE+yNGjn3cTCmomgTc8XhHPYH14vjmG7
         P/FbtGO5KiP96+SVL55g2gbUrnhC2QICZ2Z8hl9V3RuPMJp/uj3khYUykkWJ6fcXxSW1
         kHj0/NpAwohlAqaJZop1QJvlcnRuxOTVNnCd6ADEEhx/7HqwfzcjQbgt0SvCTdzV89Dg
         3nIp8LDcpHl8mmCt3nflRh/SZFjVx2S1amBDc5JlKJTpypHgRem71N7MyJb+LK3STO2B
         zP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751274294; x=1751879094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vx73D3BjkBS7xqu3PZTLpysE9yeAtBFApKxKDv3J1TQ=;
        b=q9hy5nxjU09VU8419HqBBw6COuIEl3OYFv+pj2wCCTGbIx29HcpparKUi6M7aTfbNa
         jHDmGB3w/7ndHGEqGixmpZffTMuBbH7btxKtpMo1t7hzW+I6sjzO7Q+C21bK1ve+SWdF
         19PJyBrrE4NkC4VnrAcTqlOW9qdqfZWLMLuO3dLlVnGNHuEP1NCP86gVIIU7gpajEml4
         FrPKpuWBYvYrI43m2fL0NxFRlJR/b440ucf8/3MEfMKbVsyM67KuJl2wGKt99cjTD2EV
         wMn8mSJ8WMHb+fuDo7DP9nkhAMKCytsgya23mKPsiXL5mACQBHwKK3JhGGifX8egupuH
         hyNg==
X-Gm-Message-State: AOJu0YwSwbjblR244J+Bec/wgtbeLjBgkmlO6KLgY++gMaSJ9c4pz4Ek
	n6+m5S4Bwm1TomO0M4g7ZOUfTJ7xEn2u5fkSyDXhJmMsgSvAH8PJGE/0
X-Gm-Gg: ASbGncv2ILgi2TJGqnSL/fI3BRpZnZtMSkTD7b3RMG7Fh0j/zUBYqzzLQ/eFCOBP6ZY
	HIPtKbKuLjT/0cHK2PqFQVgm+0LXofbueCVKw5c0L4smV/HzlIm4i3LLbMnmWnwEQ2yAYdjgbPL
	/UWJa2QUeqon3iwxRI8928gmDSvFLUTBYDDTegRZnG3M4p4MJ6N9WtaVTnxGmfPVgA3Gpgbjsin
	pcxuIQQ29jd5AMfehniZXxjpiqsqEn0Mtz1+pOK8a8tO/7Cenx1fIu3KHbZWF1sVQ/Gpr3I5gB3
	4WOCyKripldqLGi92HBcJw/GMP7FEbkMO6XZ2zobztNTU04g90imN1xslVff9cOEV6WIoQjrAdd
	/MGLnTQ+QkMHa7Y0SHpAwojlY19qCpVpLHrctjYwjmvaVg/c1B1NUT0ABhWqhO9m7y8HidQ6WP7
	b14rsf1Abzde7s0I0=
X-Google-Smtp-Source: AGHT+IF7whq7K7qaK4tPfZ7QlG6SusgxnCCkFAh0FXGtC/Q4RSU4nY1oHUX2sIZpgqMeVK0J6xyM2w==
X-Received: by 2002:a17:907:2d2a:b0:ae0:cf2e:7ea4 with SMTP id a640c23a62f3a-ae35013e822mr1125840866b.40.1751274293462;
        Mon, 30 Jun 2025 02:04:53 -0700 (PDT)
Received: from ?IPV6:2003:ed:774b:fc79:8145:5c0f:2a85:2335? (p200300ed774bfc7981455c0f2a852335.dip0.t-ipconnect.de. [2003:ed:774b:fc79:8145:5c0f:2a85:2335])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b416sm625157366b.28.2025.06.30.02.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 02:04:52 -0700 (PDT)
Message-ID: <8e19395d-b6d6-47d4-9ce0-e2b59e109b2b@gmail.com>
Date: Mon, 30 Jun 2025 11:04:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Mingi Cho <mincho@theori.io>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
 <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <aGGZBpA3Pn4ll7FO@pop-os.localdomain>
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
In-Reply-To: <aGGZBpA3Pn4ll7FO@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/29/25 9:50 PM, Cong Wang wrote:
> On Sun, Jun 29, 2025 at 10:29:44AM -0400, Jamal Hadi Salim wrote:
>>> On "What do you think the root cause is here?"
>>>
>>> I believe the root cause is that qdiscs like hfsc and qfq are dropping
>>> all packets in enqueue (mostly in relation to peek()) and that result
>>> is not being reflected in the return code returned to its parent
>>> qdisc.
>>> So, in the example you described in this thread, drr is oblivious to
>>> the fact that the child qdisc dropped its packet because the call to
>>> its child enqueue returned NET_XMIT_SUCCESS. This causes drr to
>>> activate a class that shouldn't have been activated at all.
>>>
>>> You can argue that drr (and other similar qdiscs) may detect this by
>>> checking the call to qlen_notify (as the drr patch was
>>> doing), but that seems really counter-intuitive. Imagine writing a new
>>> qdisc and having to check for that every time you call a child's
>>> enqueue. Sure  your patch solves this, but it also seems like it's not
>>> fixing the underlying issue (which is drr activating the class in the
>>> first place). Your patch is simply removing all the classes from their
>>> active lists when you delete them. And your patch may seem ok for now,
>>> but I am worried it might break something else in the future that we
>>> are not seeing.
>>>
>>> And do note: All of the examples of the hierarchy I have seen so far,
>>> that put us in this situation, are nonsensical
>>>
>>
>> At this point my thinking is to apply your patch and then we discuss a
>> longer term solution. Cong?
> 
> I agree. If Lion's patch works, it is certainly much better as a bug fix
> for both -net and -stable.
> 
> Also for all of those ->qlen_notify() craziness, I think we need to
> rethink about the architecture, _maybe_ there are better architectural
> solutions.
> 
> Thanks!

Just for the record, I agree with all your points and as was stated this
patch really only does damage prevention. Your proposal of preventing
hierarchies sounds useful in the long run to keep the backlogs sane.

I did run all the tdc tests on the latest net tree and they passed. Also
my HFSC reproducer does not trigger with the proposed patch. I do not have 
a simple reproducer at hand for the QFQ tree case that you mentioned. So 
please verify this too if you can.

Otherwise please feel free to go forward with the patch. If I can add
anything else to the discussion please let me know.

Thanks,
Lion




