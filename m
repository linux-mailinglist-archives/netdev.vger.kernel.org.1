Return-Path: <netdev+bounces-65402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7979E83A5DA
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838E41C288A5
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57418045;
	Wed, 24 Jan 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRntU99J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354D1802E
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089698; cv=none; b=fbkIl+zNzcZYXBF1mPWY6JTYHMndz6qSWZfo42cE4lBBfpUUkiBW52PBihnf/bdjO16RdX9NDQ6uf+pKqchWyhuQCiLwoumQZl7mdDDUpT56zE8aGf8Rh5ArXJsGjvj6arqRnvH++HBrL4bJRh1R9/JHuacHSFZidd3uSc1dSBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089698; c=relaxed/simple;
	bh=qzxgBVsbZvEsEsWyO0S63ywg3dKcwZnUp7kSZ8xPhnc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ImfImls+9M/ONqo2HKI8D1UQZn3n2aEAt4XlZkVFPHcFQozQHzBbAgxFNZbAom9Wv+B+O06WnN/feX6Ml3hLjd372EotXAib2V7gvGdQcwCy74y2uZdlQ1mNG8fwC5AQViGF3laPVBrwGdEBLaRsM4uJHwHIXLuxCmf2iRMKjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRntU99J; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso57656475e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706089695; x=1706694495; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwO+PusDvHxvjyYNxsxocMhLLcCKqruiEt9c9sMD0rE=;
        b=CRntU99Jg6PR+N3fQQAl2A8NIBLuuN8bRp+mcqp5025DnX/f3qDAhKNfzjrzsMz82Q
         50HxJh+KRoNV2mK8b4VlBMSPLGxiNj6jJPM2P8POSfi+W4L/4q3L5LxEvOKdK+16uIXb
         qWi686j874hLqBW+SiPbEPphuK7faY9nBeZuIcEGyhrYPE16uriOVfSb6ZdXJqZwcX9h
         cBRzDlb5LTh3xq2yfAHPVLgykHTCFtwAg0INAeZhQzOTdHHLxLks3uLFNWbwTw5hzEir
         bX+V/MMpagf7fL8+GTgxXnQD+SrD6rOV91UEoFameAbv6EHPt3xWQgv6RVlQIK24x6bi
         jjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706089695; x=1706694495;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwO+PusDvHxvjyYNxsxocMhLLcCKqruiEt9c9sMD0rE=;
        b=a1GQsrbu5dIuBYNe4k8A8t45NO50VhF80ST6Xow8Q2OU2UkcwE1ckgkFbSrMmTS3cc
         pCZPu3aVZgoggeltIp0pSCukU/dKroaqocMoF+HDRiLOmFiZjVF6vCsRp66APOPOdmCm
         2JeS6ti8wIKEhuYeafVnE+ht9jjBi2VhKp1PAtHZeqOPQQuTx0msToWnFYTkrsnDhEGM
         ig9CxWGj1h+mFSwXeuabyoladYk8ThpQCUGbNR10bwKdzBWMZnu+a7T31Nlev4/18l95
         +nZBxYR18B0jWFAZytU1BCJn8FMPpIVAPTrlhCqjjA+l8uGeFhtEogkN82LvVipXbwDX
         TIEg==
X-Gm-Message-State: AOJu0YxveXLjX5WXK9phYKHEDNMUMJN72AXg6VLRq7jtT/xh5xktaVA9
	thOdK95rScoWY2uFj9LT3GZzRo8T0FWj5sCW+CARwPsU0Hsl+vFATwq+5u6HofWz36LL
X-Google-Smtp-Source: AGHT+IGezWDIeYoamsXYHRTlKYk/ZD6+VasV3R3nqmNMpCQUthUo+A2KT1jtxntVdXPs/KKCpC2DrQ==
X-Received: by 2002:a05:600c:1656:b0:40e:4492:ffa with SMTP id o22-20020a05600c165600b0040e44920ffamr1242736wmn.61.1706089694902;
        Wed, 24 Jan 2024 01:48:14 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:bd37:9ab2:c68c:dd0c])
        by smtp.gmail.com with ESMTPSA id k13-20020a05600c1c8d00b0040eb99a7037sm4747933wms.44.2024.01.24.01.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:48:14 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  sdf@google.com,  chuck.lever@oracle.com,
  lorenzo@kernel.org,  jacob.e.keller@intel.com,  jiri@resnulli.us,
  netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] tools: ynl: add encoding support for
 'sub-message' to ynl
In-Reply-To: <17795933-a5ca-44c6-be4c-58ed2e573aff@gmail.com> (Alessandro
	Marcolini's message of "Wed, 24 Jan 2024 10:12:02 +0100")
Date: Wed, 24 Jan 2024 09:45:47 +0000
Message-ID: <m27cjzxdx0.fsf@gmail.com>
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
	<0eedc19860e9b84f105c57d17219b3d0af3100d2.1705950652.git.alessandromarcolini99@gmail.com>
	<m2v87kxam1.fsf@gmail.com>
	<17795933-a5ca-44c6-be4c-58ed2e573aff@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:

> On 1/23/24 17:44, Donald Hunter wrote:
>> Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:
>>
>>> Add encoding support for 'sub-message' attribute and for resolving
>>> sub-message selectors at different nesting level from the key
>>> attribute.
>> I think the relevant patches in my series are:
>>
>> https://lore.kernel.org/netdev/20240123160538.172-3-donald.hunter@gmail.com/T/#u
>> https://lore.kernel.org/netdev/20240123160538.172-5-donald.hunter@gmail.com/T/#u
> I really like your idea of using ChainMap, I think it's better than mine and more concise.
>>> Also, add encoding support for multi-attr attributes.
>> This would be better as a separate patch since it is unrelated to the
>> other changes.
> You mean as a separate patch in this patchset or as an entirely new patch?

I was thinking as a separate patch in this patchset, yes.

>>> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
>>> ---
>>>  tools/net/ynl/lib/ynl.py | 54 +++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 48 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
>>> index 1e10512b2117..f8c56944f7e7 100644
>>> --- a/tools/net/ynl/lib/ynl.py
>>> +++ b/tools/net/ynl/lib/ynl.py
>>> @@ -449,7 +449,7 @@ class YnlFamily(SpecFamily):
>>>          self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
>>>                               mcast_id)
>>>  
>>> -    def _add_attr(self, space, name, value):
>>> +    def _add_attr(self, space, name, value, vals):
>>>          try:
>>>              attr = self.attr_sets[space][name]
>>>          except KeyError:
>>> @@ -458,8 +458,13 @@ class YnlFamily(SpecFamily):
>>>          if attr["type"] == 'nest':
>>>              nl_type |= Netlink.NLA_F_NESTED
>>>              attr_payload = b''
>>> -            for subname, subvalue in value.items():
>>> -                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue)
>>> +            # Check if it's a list of values (i.e. it contains multi-attr elements)
>>> +            for subname, subvalue in (
>>> +                ((k, v) for item in value for k, v in item.items())
>>> +                if isinstance(value, list)
>>> +                else value.items()
>>> +            ):
>>> +                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue, vals)
>> Should really check whether multi-attr is true in the spec before
>> processing the json input as a list of values.
> Yes, you're right. Maybe I could resend this on top of your changes, what do you think?

Yes, that would be great. Thanks!

