Return-Path: <netdev+bounces-157433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6967A0A462
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 16:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7213AA26C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89761494DD;
	Sat, 11 Jan 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGbHHlDh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0103D96A
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736609621; cv=none; b=uL7wDeBLaTAaGVlgorhwQo8i/nSe29SO1IWQ0Ej2Nz5lnBPzDaDh31zpjDJMEZsQjsF3QnO5blrQncFQpHUAzGgs1w48O+akMF6WCelP9ACsmq8OXZhRkT5lc1q+HmvNLRTZowRm26AiIm6da+dI5AlcW9R9FCFv0sAlT+51aDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736609621; c=relaxed/simple;
	bh=rWDS8aSrf4LiHlA+92mRo41B9PFI+djhTqZe89If/XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlmJGZvVX6XMnOeH+6I+SRoH3vp1utZgpC2RJ1OMXHnMP2McVzLf5blE3bjGbeYHo9ZW++yepiUuyb1FGKzOb/g3fUykuDEBBUkH512U/ldy3Tt1WgGuTLSjURtbhjUUllkYH5oYDOMxo5n4fUkIb0O5KyiPvcPuKFD5gFGZr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGbHHlDh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43623f0c574so21481825e9.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736609618; x=1737214418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D9QJSc3FhoBboiepedd14cI4aX+6vaL749OZV3l5HQk=;
        b=EGbHHlDhp5v+Upp6D2yW3Ntm4hZfWk4+jZNR2uZZUNxw2+w0atcvvJRbq6YGuqwVEB
         gxLAUuR2fb3yjuV91dHyFBAxnMzd2LQoAwGhLkk71NZcMseQ9DiplhRZYgwHZhJNMons
         Zzw8xIDeAsFuPuGWSjAZzvJZc95D2+RWPvsInI+F2TiTUCegSt7/cwa5Mq+HD3KL4wN7
         DEg8BqjxPjQKo3PX5I0pJf0E3CFNizv2ySOif7sGsKVUCLlcQC9+5BvTpTumyJ/x68VZ
         zKiSd9pq7edSzZnywG4g1gMsu8WdE7se0woUb8E99tzk52fXjQqy+S95/3cmSYUtoffV
         5vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736609618; x=1737214418;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9QJSc3FhoBboiepedd14cI4aX+6vaL749OZV3l5HQk=;
        b=Dopxsa7+Ba16wOOzVuhzYbMqMNcfFc59cJIJFAd4yNl/Do54/w+pP6dJ/gN7wsdVL3
         HTfWY6pYtjzhRND2gd+83hQ6OQRKll4VyWAglWaWDlhgKXYfKDklT13m3bBa9fmVGWz+
         ArnHQbmKKyCT6TMkfuEo3rrVaS+RCFyYbyVOOZ91py6UgGWKDrjuXw0NyiA03yIpBFea
         q1c/mE4W03G/gE0tjEMVq46+FMfhayQ7sjEUKG62Y1FMaKb0xTtOLZqyqu6+c0NKXZq1
         MUpTjJPMo6eu74gGlMSF1D3JusgnU6TiI1Y9dZbRgiXuMhkFXirVr3is9LF+MwfPNcAz
         EgSA==
X-Forwarded-Encrypted: i=1; AJvYcCXZrnvqnH8QUeamSLS1mxkzpufYdz5T/eSJMdNZRvNUWs47mBnSwV/z+KccB3fxT55sXtKcMO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MfgeZXzrbfI7qf5wYGmaso4EkJRNdElEJ+ASocaRk5anlsFY
	SD5W8PYo0RwuUCLo5oz0Hk/gX0aGYHQeszuP230xh3FT+y1ukK7FdVYM0Q==
X-Gm-Gg: ASbGncs0S+u7JbyL2hr4ftSDEnwVE5N1l4FBY8P4Dmy4kJ0reEGyMJVSbaUJ4rf+0On
	wF1ySDoT/CazUFtrcxJ/k+7C52o+6DUbPKqsk8FjfcthfIbqSivVrhftPQNdCdFqrZbHfYvyZRw
	OXPeMD0mzXwPVg/0fZbckIxCOf9KH9Sv++bm45wrhm4phYlJmrQ0ykreCbXd3lW6kqKiP7IRmI3
	KQHpFipOfJM5mkbHGrmdJl9DU3ob08Gr4dfRz/qr0DJFEzF3ci6xUESuDAUSEuY+PbpTUnpaVxt
	qGv8GUZugJeYLKachYV7gqCfwNREDJMaxMbNKPnOV5O5hR3artZFaOuGwo3jjFuzVP6xT+v3ERx
	eiCFtI9FrVXFWwbYOZRvv2NPrxC5KHSwTFLk7ZAWDm6mIYpk2
X-Google-Smtp-Source: AGHT+IHarlUVd4Qbqon/GW7Yuta3Wd+QPKovsp/pYB/Xm11lJt1WUgF/pDi3sO8zHrZrek5Wt5ZZvw==
X-Received: by 2002:a05:600c:3b8a:b0:434:f270:a4f0 with SMTP id 5b1f17b1804b1-436e26dda80mr114795885e9.21.1736609618120;
        Sat, 11 Jan 2025 07:33:38 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc5csm86214095e9.2.2025.01.11.07.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 07:33:36 -0800 (PST)
Message-ID: <b1d56e22-5bbb-4881-abc1-6f8832bb575d@gmail.com>
Date: Sat, 11 Jan 2025 16:33:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: phy: c45: don't accept disabled EEE
 modes in genphy_c45_ethtool_set_eee
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
 <Z4I4ADNO1nSdZRja@shell.armlinux.org.uk>
 <472f6fe4-18ff-4124-ba43-fd757df7cb4d@gmail.com>
 <Z4JBld9d_UkBgRR4@shell.armlinux.org.uk>
 <0212f9e8-8f60-461b-a7fe-bd4054f3689b@gmail.com>
 <Z4KKi2WxSrben9-Z@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <Z4KKi2WxSrben9-Z@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.01.2025 16:13, Russell King (Oracle) wrote:
> On Sat, Jan 11, 2025 at 02:19:04PM +0100, Heiner Kallweit wrote:
>> On 11.01.2025 11:01, Russell King (Oracle) wrote:
>>> On Sat, Jan 11, 2025 at 10:44:25AM +0100, Heiner Kallweit wrote:
>>>> On 11.01.2025 10:21, Russell King (Oracle) wrote:
>>>>> On Sat, Jan 11, 2025 at 10:06:02AM +0100, Heiner Kallweit wrote:
>>>>>> Link modes in phydev->eee_disabled_modes are filtered out by
>>>>>> genphy_c45_write_eee_adv() and won't be advertised. Therefore
>>>>>> don't accept such modes from userspace.
>>>>>
>>>>> Why do we need this? Surely if the MAC doesn't support modes, then they
>>>>> should be filtered out of phydev->supported_eee so that userspace knows
>>>>> that the mode is not supported by the network interface as a whole, just
>>>>> like we do for phydev->supported.
>>>>>
>>>>> That would give us the checking here.
>>>>>
>>>> Removing EEE modes to be disabled from supported_eee is problematic
>>>> because of how genphy_c45_write_eee_adv() works.
>>>>
>>>> Let's say we have a 2.5Gbps PHY and want to disable EEE at 2.5Gbps. If we
>>>> remove 2.5Gbps from supported_eee, then the following check is false:
>>>> if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES))
>>>> What would result in the 2.5Gbps mode not getting disabled.
>>>
>>> Ok. Do we at least remove the broken modes from the supported mask
>>> reported to userspace?
>>>
>> I think that's something we could do in addition, to provide a hint to the
>> user about unavailable modes. It wouldn't remove the need for the check here.
>> ethtool doesn't check the advertisement against the supported modes.
>> And even if it would, we must not rely on input from user space being sane.
> 
> I disagree with some of this. Userspace should expect:
> 
> - read current settings
> - copy supported modes to advertised modes
> - write current settings
> 
> to work. If it fails, then how does ethtool, or even the user, work out
> which link modes are actually supported or not.
> 
> If we're introducing a failure on the "disabled" modes, then that is
> a user-breaking change, and we need to avoid that. The current code
> silently ignored the broken modes, your new code would error out on
> the above action - and that's a bug.
> 
OK, then I think what we can/should do:
- filter out disabled EEE modes when populating data->supported in
  genphy_c45_ethtool_get_eee
- silently filter out disabled EEE modes from user space provided
  EEE advertisement in genphy_c45_ethtool_set_eee


