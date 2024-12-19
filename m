Return-Path: <netdev+bounces-153452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419A9F80C1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AB31895C88
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2F194C96;
	Thu, 19 Dec 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTdWqlbx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0438D86337;
	Thu, 19 Dec 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627135; cv=none; b=stC6sUUfiZ7PFMsAV7jcOeSYLi6gd6tW4jzh2H3hFbb6DIjXTB2TuguM/r0UnVL7vddSErd6o/5uhnoLSbIF811qlH6K65NmxdAN67YP125khdPNL/J/IPmJlB1MesZorjNWMl38D5V0Is1m0d8FIZsCVKGbizY5fKcNs2JDXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627135; c=relaxed/simple;
	bh=a/BRd3NIEPiabpqEG1o3K9PedgeXwxpL4/11DuWuriw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVuG5++1rvEasls7+O4MXIHyfHjoRMM8nvu8Kf3ewRYgva005bsyKnSKaZF8vIlf4D0oT9Q2si8Pj3irt9ecpO1S4nXi0qUCyVwnW110QnlcykdiSSq1vzQfG9CkkwXYN0n+Tn6ehwqBSR/dWa9gJbIN3SED075PCBZuga8BeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTdWqlbx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21636268e43so12025305ad.2;
        Thu, 19 Dec 2024 08:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734627133; x=1735231933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lJNkoUSC8PE1afOsAICayx5NPlgiVDXkKG87nqLNXEQ=;
        b=RTdWqlbxDO67Fdswmaf6t/6tu0xRna5heK5UzUoilAl4KdUJV2zxqFVoPu3tVA/PFZ
         m/1dCd+w1e0x0+rKv3aRSfy79vdN/f/yD/qFr3B6F1EjvB64FmnH53utjEEVCQrpT8LQ
         aK3k0rWJZ7U+AoE9otPG1r5mdahTXrYfD9wPQ2UwbfL0sCL+ctXSEOmmyk3q5POZCAm7
         2CGmplePNNC0zd6wk88wvNrV1GHZJSF5D3KGPEdqpyOPtNAkjSBf4tCaT9WsYE85GYIg
         BE+Y24oASm5AVkP92tIPgaUnuJyfyTVlxxTiyLwHBM8NFWUaMpRNn+1CQMzkRRi0wisJ
         +KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627133; x=1735231933;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJNkoUSC8PE1afOsAICayx5NPlgiVDXkKG87nqLNXEQ=;
        b=AA0xAp/xi24vYocKU4LVyJSNXDTUSVI05gCS5W09aEl1zDf7GaTYgWLN0DdnbRnWp4
         8BrIdvv0QEaW9Cj/sjrs1sISa3Ct/mtR+DzWugi6Gh+sjLdbdVdN1TeV9LeLKe8jftlC
         duU4lzxCW16iBrlqmub0r5VyR49nN4unqN6EFcOvRKy3H+NEHFffFoR4xgXwktL9OsPe
         9W19OB33VQFnK1ksv3tUUrfM8Ec+9C1uhdRho89bPQvJOeQsfznPhZdymhlJP5TY82VD
         8KHYPSjmEfjv5FD13mVY0c4RDIdf98T3VS2fLJZ96I8v8hqxCEqOY9s4S7n2olopoBiG
         utKw==
X-Forwarded-Encrypted: i=1; AJvYcCU0cWdt3kIVczJ4BH756NPOlVhuSlDwkS/RzpXPZeYMSF86A5LIPJG9THfEsusuFz9inLxUyy/YtroyNXo=@vger.kernel.org, AJvYcCUzR2PSb9BcDhZT0tNCWElE6zQC+emLNvtOX20kUfYteirt3FhWpwk9KS7EHQ9lNGa5/ZxwNLSN@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYbx7IvPTY8v4onCbb7N4AbBGGp7RviTLfUsXEJrHGm5sqW0E
	SudgxfFEEKNB0VwZtW4fbAf76VXmwjbhNwdL0tmU9cEsbnLbiE7P
X-Gm-Gg: ASbGncvPA9VuowquvN1ALo6JOwrhesJ9NzAts5IYCbDfPXJhLGkSUkf0EQnuwo5Y0eE
	TMUE33srlPkIxX6/8AWiFuq4+/XoQXsvLGLIhQmE68FRQWQbWaZBNa0dNTLtPNObhEXmVu1IJJy
	X8mMMap7z+rqH7WGq8GbAJH1GxPNi0yfDyV0e1LxtEQeQC3LUhQQCFfPSDE5uAEt4BSUH4g4H74
	HOBrwwH9KQfeFaMI0rvs3mD3oc+N4KTK+Gqk+PLfgJkWIo9QIZ7O0hyrP47v1Tz+rvWxlgcQTzM
	jyGlg7wD
X-Google-Smtp-Source: AGHT+IGt4oWU5+OY83PcJ2e/yA9hr6uX6Op9bJ0viaHN21jJTaoMH+3okbuPAYRlmBYojGTvvmwJdg==
X-Received: by 2002:a17:902:d2ca:b0:215:8695:ef91 with SMTP id d9443c01a7336-219d965c6c8mr54262795ad.6.1734627133208;
        Thu, 19 Dec 2024 08:52:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f625csm14210505ad.208.2024.12.19.08.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 08:52:06 -0800 (PST)
Message-ID: <40cbb576-edd9-40c1-8f7a-8dd6dfa5d7ed@gmail.com>
Date: Thu, 19 Dec 2024 08:52:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mdio_bus: change the bus name to mdio
To: Andrew Lunn <andrew@lunn.ch>, Yajun Deng <yajun.deng@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20241219100454.1623211-1-yajun.deng@linux.dev>
 <f062d436-5448-418a-9969-f1c368e10f8c@lunn.ch>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <f062d436-5448-418a-9969-f1c368e10f8c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/24 02:20, Andrew Lunn wrote:
> On Thu, Dec 19, 2024 at 06:04:54PM +0800, Yajun Deng wrote:
>> Since all directories under the /sys/bus are bus, we don't need to add a
>> bus suffix to mdio.
>>
>> This is the only one directory with the bus suffix, sysfs-bus-mdio is
>> now a testing ABI, and didn't have Users in it. This is the time to change
>> it before it's moved to the stable ABI.
> 
> So are you saying nobody has udev scripts referencing MDIO devices?
> Nobody has scripts accessing the statistics? You don't expect anything
> in userspace to break because of this change?
> 
> I personally think it is too late to change this, something will break
> and somebody will report a regression.

It is too late, merging this patch would be breaking ABI and that is not 
acceptable.
-- 
Florian

