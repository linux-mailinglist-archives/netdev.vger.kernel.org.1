Return-Path: <netdev+bounces-240092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E9CC7065F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63D4934E128
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE222FDC55;
	Wed, 19 Nov 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="G8c6Ka7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53D28CF6F
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571795; cv=none; b=XZRg6Kr43sWTBDJQTA2KCpjueS5tiDZiwZUbKGWVBq3rr48TGmBXe802a3HfzSOsVqS8t+RXKOgk7+UjD0poePB8oUOgLOy4VmB8qSE9vtnXJjQ5EHlzg+MIFJBwAuWPaiqlSVgxvchPBH9YeXYcDDFsP0FH0osgMpY8vUL0/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571795; c=relaxed/simple;
	bh=VEQxhRQzksqQnHbDBTAG8PHofzw31luJF8BTCh2+4lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcSFk/K6zt+X5wJG9D5nsjl9nkOwP8vIWJsei8+PlrLgBIchcDg9Mghln/T9XnamCu1ckYkus5bYj6MPOR+rgtQ8U7ilgZbupfcH6QyTWY9kO1kpVJ7efB/LcA5lxFyVZo/4Focu8QnuWFxilfJN7AlyzXWsQPwjib1zKYnEfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=G8c6Ka7r; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b71397df721so1048974366b.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763571791; x=1764176591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Aq7SoQkDPefXTnydjjfdctowbfsVatqatQ/Cb6wzSc=;
        b=G8c6Ka7r/pV+Er0+257LFE9TPQL0iWHmhSOLA3ouQNavLju4UXvTgYkh+eiXZE6uHr
         EPzaxf87yoMNm8oWfd2h1JNzlHvr1aegrq5y+3D6UaA9teNfJEi5u/xbjhlcX2OJX3G/
         i6UseZKunAR2Jefh4Ahe1erekHUytoe/2ojNVpYaiNahZzMRLM1s+Ks+mlCVNoa+jIVZ
         UjCRiVWe68YLWS2NhwuEjpN+Ri2f3rVjKG3DlZCaHoQ/2yruE9+opcOCrQCY/IA2rQ7p
         eUdhgWH5e426NVLE7C9YsPxRsnve2UqbUKzCC6Ia7FvynafKf+8zO2E3Hi8zR+IMGF/8
         zTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571791; x=1764176591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Aq7SoQkDPefXTnydjjfdctowbfsVatqatQ/Cb6wzSc=;
        b=EmnuVBQ2KXe8EY2BRbEQyV3L0uZJP4CJq6oiGnqX8/y8nqKW5hl6z89yW0+gHqoaPY
         33vNnY+UYYyeJyO6CaMkmdmgQaN+nfruEwtQx4J5Q3SpeIEnYwOHrRSkn/w2qmN2VCyO
         QjKNrfOMgADNYksa1Cy8pJe2DTxgSuRbIN/EHzAPReaDwEi2rdIVxqouyf5skdg/lJAt
         TLvBUQ/eOtHSfVwWloTKNcV5nZTlwGGEyZmSoRnDL3GiJcMyBSljKCzXHY0D/KPUn4GN
         1lqkFSJu+zNyKP6HV5LoAvBwiBCYJA8Y3njXdMmEBhr8p3Ej3N91IUOfMCIoxDf6ifq4
         UkXA==
X-Forwarded-Encrypted: i=1; AJvYcCUlJ1f46WbcREG0o+SmOiCssZ3BmBnvCpqzy+iUYrIdjuDhbwHrrbTT7Hl7BbRkI1Ll9CEtpSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRN0ze4MpfLNETf1+4Hwf9Z4H8WBELpzbPNyt0cpIV8Wz9wHkT
	dRtCYyuRJqH1EEJQ5xsZ57kxidY5vKTXai0ragtaKAUhSEhrDjeAKaIU/zeuQzYfwoc=
X-Gm-Gg: ASbGncspJkV0fXYEgpH7TO/0X37Ra5Iwd7yk8z664nP5laN8qT/wmwxDKkKhbnFWcKr
	JLFR4IoSDDBxwj3E67BqSXjWS1y2HVXFYkMZ1txuNw1N6tGIhN8IgOjWbc33ro0evbchXJ7aEMa
	6s4gJN+42nsf+CzDH4yh1Xhzb21ij8KWUQFubNTEkigP71BDIxzsjlYsd7L5c4wTGoMhetYUSrN
	18WlGuFdFCK4biVoGEYbZNxjtCnglEHa4xPNXf/6mavOs5u3BmVdh1OxTOfpD0Ur7J4LLcBtJxh
	StFiOHHsCpPYKaNt6+mBQU1Ho5zRNMTIoCxt9KgqmugGQo6Inc9NpvBK3xS3mwZUaf7K7vKl/PN
	rnIqFXiHHWwE6DSZmaF2NjTU0ZhpBSCtYSTsjCn67szc85qDfsfCY2P1WAhSlhrVsldzsO40fgr
	4lC58yC1OzsLFPpulmMm1dvTY=
X-Google-Smtp-Source: AGHT+IHNG0xR2Nj78a6qtdjpZdZDZ5RfLZiNVmgkDjdRpL+nRMJfSXaidAcitRE0u5t4Gn8M0gkc9Q==
X-Received: by 2002:a17:907:2d0e:b0:b73:9fea:330a with SMTP id a640c23a62f3a-b739fea3954mr1260508666b.17.1763571790991;
        Wed, 19 Nov 2025 09:03:10 -0800 (PST)
Received: from FV6GYCPJ69 ([213.195.231.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed90c0sm1680149666b.65.2025.11.19.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 09:03:10 -0800 (PST)
Date: Wed, 19 Nov 2025 18:03:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: Move team device type change at the end of
 team_port_add
Message-ID: <admyw5vnd3hup26xew7yxfwqo4ypr5sfb3esk7spv4jx3yqpxu@g47iffagagah>
References: <20251112003444.2465-1-zlatistiv@gmail.com>
 <c6fa0160-aac6-4fc4-b252-7151a0cb91d3@redhat.com>
 <mekjl7qqrb6nkk6ru4fztqxzemldzbsplf5tzuu7amc7yaa5j3@rulh6ijsppaq>
 <vv54er56wgnehntr2zh5jk6iz5s36jpyi4jfwjnkfabfwithtl@aizn2anzknjm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vv54er56wgnehntr2zh5jk6iz5s36jpyi4jfwjnkfabfwithtl@aizn2anzknjm>

Wed, Nov 19, 2025 at 05:24:37PM +0100, zlatistiv@gmail.com wrote:
>On Wed, Nov 19, 2025 at 05:10:15PM +0100, Jiri Pirko wrote:
>> Tue, Nov 18, 2025 at 12:46:36PM +0100, pabeni@redhat.com wrote:
>> >On 11/12/25 1:34 AM, Nikola Z. Ivanov wrote:
>> >> @@ -1233,6 +1231,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>> >>  		}
>> >>  	}
>> >>  
>> >> +	err = team_dev_type_check_change(dev, port_dev);
>> >> +	if (err)
>> >> +		goto err_set_dev_type;
>> >
>> >Please don't add unneeded new labels, instead reuse the exiting
>> >`err_set_slave_promisc`.
>> 
>> Well, that is how error labels are done in team. "action" and
>> "err_action" is always paired. Why to break this consistent pattern?
>
>Hi Jiri,
>
>This pattern is already broken in the same function by this:
>
>        /* set promiscuity level to new slave */
>        if (dev->flags & IFF_PROMISC) {
>                err = dev_set_promiscuity(port_dev, 1);
>                if (err)
>                        goto err_set_slave_promisc;
>        }
>
>        /* set allmulti level to new slave */
>        if (dev->flags & IFF_ALLMULTI) {
>                err = dev_set_allmulti(port_dev, 1);
>                if (err) {
>                        if (dev->flags & IFF_PROMISC)
>                                dev_set_promiscuity(port_dev, -1);
>                        goto err_set_slave_promisc;
>                }
>        }
>
>So I guess I should also "break" it or do it as you've just
>suggested and add another label "err_set_slave_allmulti"
>so that we are at least consistent with this.

:( I think it would be fine to fix it, by another patch targetting
   net-next tree. Thanks!

>
>Thank you!

