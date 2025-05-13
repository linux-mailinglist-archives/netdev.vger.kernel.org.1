Return-Path: <netdev+bounces-189989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D02AB4BDE
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1832A864EB4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 06:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1C1EA7C1;
	Tue, 13 May 2025 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="gioOl9Hu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371251E9B12
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117437; cv=none; b=psdC0Pbz7D7H/OD/msOtmogntVV3xt+Z0ZqM6oVSXQf37yTwj/7HN12IZlEBHWgva22sTAcKyLV6kyg94+pGxD80a3EqZK++UHy/WrFgvziJM3hO1vOtHZGoOZcCiFEwFQMYHFdHKs07jJg3IJAVvWGYtehtByqS7l5kbdv/c48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117437; c=relaxed/simple;
	bh=NWDL4ww3BQl/HzMVL3Bws9NyNng7ta9aYTnl0hs9Srg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTPXRKqQGNBcsGncPrt7/P8eeAlT5R1LUXpqAD8Hdv3lRgodPJDxAnPmy3ZiXGwYuFZMqDVE9Ki66IMGecCGQKOYy2ZgY+VxXf/wU9Yy9hOwwpPgHnN68ooz4j6sUJhuYPKLc6mXtNFLZc+MrAOY7g3Zz4Mz967qyThAE/Sd/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=gioOl9Hu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7426159273fso1906033b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1747117435; x=1747722235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xe4uYghntGHOIEC3/13sie1Qhs4ut1BoBFJ4y42rbE=;
        b=gioOl9HueOoo+fAbm9efI7fx1oKwy3vyGzy+7wCsqLBA8D2Fqc8O9rFW5IrcV0RUcu
         8PssdqvhprsqZ8DiqYINK7DyTz8sqKr9eusgHs5ut6MN/LM24dsq/XfcmdjJYUTgbhdI
         NuzwV7p6yrc8EIEoYgp/KJspyvVdM59lTI5eT+AAKp/JUPxcS02MQP2QlaO0sLm3vPhy
         5ycUzOcNRgaPGAY588MfCeGJEzFzS27B6BwClhqePvGgSPjRkjI7rO1AthTo1TRxiruB
         8otXPJKAnY+4fcRd0kA/48ovlBGm1MRwYPzI0VRAyG1uyjYob+3sZQIgksOFfgankAf0
         wNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747117435; x=1747722235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Xe4uYghntGHOIEC3/13sie1Qhs4ut1BoBFJ4y42rbE=;
        b=tAQUQnKnDsUvgLq2Ry219D8DX00fhRUdz/XS6lUWqHY9mEhcOftb3SbAvCvxbRuRbT
         WczzliE9K55C6+R59fKAar7YaSj977p9OjhIw8N5pPmw8eNR4lOeiIjguw/wKxP0672a
         RjZKhp573zBAwIC3OJpm7VrcgQ0DYb+7/NjtnfqlZRKfPc7rd4dAiYGp2QB7u3lh+jgN
         zULHaSZfjqYZHyjY65MaowZhhmhBi1bNbtpVhttZX74hXgKxq7Ro5fqIB2N5MNafoOFl
         kZQprDakFJt/vQF+AxjY/fqjqxtf1rXyGqtv86wrmdcR8AYodIdImLUwAUunwKUjTLAp
         I3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1SWjdIo+V0d9HvgN2Fe0fNiOYq6ML1yx4pSnPfNoZpaNhUgo9IRsvM5oJNh8aPVLDLvXigY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDJeo0Oht6vi86zILGC8OC8Uhk0Sleq4VADh/+0poilnc36pG
	LcUkIv++dFKs1akJLVLLj/YtHg51EtexPk9R1Uz6Dkhc5CEqB7k1wt9ZnCkdvLQ=
X-Gm-Gg: ASbGncvtDISba60jTexTpvHKtXgBeUKME7tkhiHz/qTDyP+Hs6dlKbpbkk+uy755Re/
	4ZZssFEWcq3ath6Bdlf9wL/QpiBVqdnkXIlwqUpTBmtldlLJbLk02tAtCWP2ltfXUJwmx3tUvCs
	Y2s09aN9gPZl/r/eJ18VfzJB3rI4JaaunzI83DimcIDN6AOIpj+gfks6g9VlSrgvjkYxBswR6Xt
	dnSKqFwMH5Ke7svHIQT/BW2Vz02Lt+Th0K/qxS2aFSRy3OQL3jghSFRh74UbiOVa7upNEoTZsu8
	oOBoEOQVdcl1zWjxlnEsD3/6B1cTu7lQqlR/CRy01HZd3qPNQ6bkgfTo/Q0HrcOr
X-Google-Smtp-Source: AGHT+IGaYQuRICfs2SknzMpxDQM2zuaFYRjcuLtZoCaPh500iOYbo4XJp56Xa+ir6JeYYEIEzfycdw==
X-Received: by 2002:a05:6a00:4652:b0:740:6f69:8d94 with SMTP id d2e1a72fcca58-7423b3f12e7mr22633670b3a.0.1747117435423;
        Mon, 12 May 2025 23:23:55 -0700 (PDT)
Received: from [10.54.24.77] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a1088csm6987174b3a.113.2025.05.12.23.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 23:23:55 -0700 (PDT)
Message-ID: <bf9a3230-26b9-40f7-aff0-99c802fb7764@shopee.com>
Date: Tue, 13 May 2025 14:23:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i40e: How the packets will be processed when status_error_len is
 0
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0c8bf3f2-1620-420e-8858-fe1c2ff5a8e9@shopee.com>
 <CAL+tcoAYvN20aMz-WYFEUeBypS8yMJ53YgdMUHCX6FCr__qT9A@mail.gmail.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CAL+tcoAYvN20aMz-WYFEUeBypS8yMJ53YgdMUHCX6FCr__qT9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/5/13 14:13, Jason Xing wrote:
> On Tue, May 13, 2025 at 12:08 PM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>> Hi all,
>>
>>         If the packets arrive at the rx and then raise soft irq to handle it, but in i40e_clean_rx_irq, status_error_len is 0 and return.
> 
> Directly "return"? What version of I40E are you looking at?

stable kenrel 5.15.162,

i40e_clean_rx_irq
...
	qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
	...
	size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
		       I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
	if (!size)
		break;
...

if status_error_len is 0, the i40e_clean_rx_irq returns 0.
> 
>>         The data isn't fetchted from the rx buffer, so the how the packets arrive at the rx will be processed?
> 
> In i40e_clean_rx_irq(), packets are one by one constructed into the
> sk_buff and then passed to the stack by napi_gro_receive().
> 
> AFAIK, common drivers implement nearly the same scenario.
> 
> 
> Thanks,
> Jason
> 
> 
>>
>>         FYI, the every rx/tx queue has been bounded to one cpu(64 queues, 64 cpus).
>>
>> Thanks!
>>


