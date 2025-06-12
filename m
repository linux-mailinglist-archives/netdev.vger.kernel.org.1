Return-Path: <netdev+bounces-196877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6346CAD6C1F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15963AFA95
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A4226CF8;
	Thu, 12 Jun 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q94Z/Ayl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214C2288C6
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720530; cv=none; b=lZO2q7X/Mo8+YuRu/3G6Z67k6hASMzkDH3vjlgEgj6NY0oIcpJm8Lm+qye71pilLFY3WqI/6TIcQciRiU7kYWClasHArYeZpQDzOZiIkTmYGp8vkNoID+DxjbdesqmEJQzzFljqRDfUchrN/lNOnwSIFusy+m5x2XE/9U2cAN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720530; c=relaxed/simple;
	bh=15A+Jq7bf64Y0Sob0l+shkxqSMyV+klxuzTzYl+nPwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9qKuDyrvAUWI+qSgcPD/RzTjG1wwM3x5bHIthYecoyzixWxGVrVeuzonuDGad+L5Svewr8AmH0ieRm83dSyk6d91L/jeCVF90UmS0rLPvZlPidUwU70j4I+eAb4W+oYpYRu6XKFrQwar+aYS87yHN0NWCJmtJCRzB/byOX1JMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q94Z/Ayl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749720528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFdgvb/gxCfOxh7wiM2uvpJKoACuWo2ZO3Xgqk/MBn0=;
	b=Q94Z/Ayl2hF+khK59GEGt3s8LchhTuD+Zeoa9chTXIs0wZyZH8Q+rFW8e2HuB9N/3lZg7h
	sLkZo0GVRa5nP3Wq+K/DPZMoj4T305QgCzfxAf9NFjZCVrWD3w0JpgQByy2uU5Nw7t5Vyn
	5sNdmNzMesk7j8nKWNu/4yxpkpTRD6Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-EA_LOS2-MPShvB7g-v1Kcw-1; Thu, 12 Jun 2025 05:28:46 -0400
X-MC-Unique: EA_LOS2-MPShvB7g-v1Kcw-1
X-Mimecast-MFC-AGG-ID: EA_LOS2-MPShvB7g-v1Kcw_1749720526
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4530623eb8fso4605825e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 02:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749720525; x=1750325325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFdgvb/gxCfOxh7wiM2uvpJKoACuWo2ZO3Xgqk/MBn0=;
        b=mDaLHT9D1yFFfLihjWWU7U/Pn47/an42DLIJFcNmpwnaBktg3dTDDVQcljG6T55B+K
         Gc31u9FI76MT9kFTreEz5GpaP31Y0n+NyxCnO6xksjusOdKNJ/KsPFTV8mC4jSTRIFje
         lxDvDiaWEr1OqtYE/QzIfcBqx7UaJ3SiyytNn6HEPgCQce7XFJw3w8licK7sVvE728B6
         JQqn3/yBPEVLVKlJs0cwrdsN9hwXC5+HYovO94Ja8ZBIq0tkEYrTwJT8TQkpvHqi4dcn
         V+v2FHpLZXneNh8TT7eJYZ8U2pYG6UAoRC24fTOUtJY5+lPa2+SbTZJuA0h2IK7ddCyJ
         /zmw==
X-Gm-Message-State: AOJu0Yyl7NzzkN+VQLN9D9xUdi0ItOErDqJuBbqXimT3kARsOmNRocjF
	d5El6XoZhsEVdEDfJoOMZx1+FfCqtU2kzlH7UT0FISeY4V0vgK8OD+go5NQHbjTrvLGJOwjMtTn
	tC25V6RHphGIEiy4VACEaPLNQnhz7sc+ey/XEAErzKWnumjY1sgRdhfdN4w==
X-Gm-Gg: ASbGncu8J8AI2egj5aAbjuRrH2gpoK+5frvx2AsLCLfPP91z4LnDm3dGojvA0NAh86s
	2aMxQx4QrNY/S1EzqY8VGNu0yaJA6tbGmUm11qyDGZ0wSYdIjEEqn2LcT7gPq7u0jW4Xe3wYrP/
	LMvQLeL45plxKZdirABzbM1Yq/ECPNsyC/St2u8NsH7ORGlGNl0WKL57BUzfuFt5wqGDWn144Hg
	CmSlIvist4S+cTu4yS0w9Mt9ya0DSKjU6lU7KkZKyQB+uo4J8IFrTiBWH2H5WABnl6l4PLJP1j+
	6bwysMbVd5VQsvfOYXP/kN/UeMcRF+u0GC+U8MdCQv0oUL0lfQz4xlWm
X-Received: by 2002:a05:600c:4f95:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-453248dbf28mr62663505e9.29.1749720525540;
        Thu, 12 Jun 2025 02:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdhTavuGh0Cum2rAbeyftkpMyPY9J+DGmx0/nwN3QfQd4jm1p2rE5yEec6J7zmpY7sb/Fe0w==
X-Received: by 2002:a05:600c:4f95:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-453248dbf28mr62663255e9.29.1749720525187;
        Thu, 12 Jun 2025 02:28:45 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:8b4:8b:591b:3de:f160? ([2001:67c:1220:8b4:8b:591b:3de:f160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45320562afbsm53511295e9.1.2025.06.12.02.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 02:28:44 -0700 (PDT)
Message-ID: <9c2fca05-baa6-4da5-ad9f-df3361356db9@redhat.com>
Date: Thu, 12 Jun 2025 11:28:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: sysfs: Implement is_visible for
 phys_(port_id, port_name, switch_id)
To: Yajun Deng <yajun.deng@linux.dev>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250521140824.3523-1-yajun.deng@linux.dev>
 <10a15ca4-ff93-4e62-9953-cbd3ba2c3f53@redhat.com>
 <be52bdf3f1f4786f73b618369f63ce035ce8b955@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <be52bdf3f1f4786f73b618369f63ce035ce8b955@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 10:51 AM, Yajun Deng wrote:
> May 27, 2025 at 2:08 PM, "Paolo Abeni" <pabeni@redhat.com> wrote:
>> On 5/21/25 4:08 PM, Yajun Deng wrote:
>>> phys_port_id_show, phys_port_name_show and phys_switch_id_show would
>>>
>>>  return -EOPNOTSUPP if the netdev didn't implement the corresponding
>>>
>>>  method.
>>>
>>>  
>>>
>>>  There is no point in creating these files if they are unsupported.
>>>
>>>  
>>>
>>>  Put these attributes in netdev_phys_group and implement the is_visible
>>>
>>>  method. make phys_(port_id, port_name, switch_id) invisible if the netdev
>>>
>>>  dosen't implement the corresponding method.
>>>
>>>  
>>>
>>>  Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>>
>>
>> I fear that some orchestration infra depends on the files existence -
>>
>> i.e. scripts don't tolerate the files absence, deal only with I/O errors
>>
>> after open.
>>
>> It feel a bit too dangerous to merge a change that could break
>>
>> user-space this late. Let's defer it to the beginning of the next cycle.
>>
> 
> Ping.

I was likely not clear. The above means you should re-submit the patch now.

/P


