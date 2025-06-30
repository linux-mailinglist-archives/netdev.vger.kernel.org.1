Return-Path: <netdev+bounces-202400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ACBAEDBAB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E8E188FA61
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C28B277CBD;
	Mon, 30 Jun 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dtlUjWVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5054918
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284348; cv=none; b=rgtT6crzpzplsF0eSx+CewhZdXA6EzaL99I4JK2o+Brxkm7FhHzjlHkWTbjPoE1NY1Felxrlqa1j1WTR8uZqV2+7fRixQ0e+xbE9sNVT81jeXTWiev5Ki7G+TdQG0Rc2Bk0MeoCdcTncQ4J1LKA/k53QrK7m0xhsh7pIPY+fx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284348; c=relaxed/simple;
	bh=AhYEdZNiuImuszvLlVPrFupwQ7/XmZGuzny+xHoh3H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neHKZVMlewP1huFnI7oYU/jGbjTT9nw7fSEBavY5AVWeBqHOaECHcgbiCyasRDwffXWi9IvnwGz6tHtNPkG09ZJsV7Yir0aWNYqCTMDQj9VlNXXA4cfId9KFpkrQSIjHGvhG1BEa4gy9IYSerDfhc0zb0I/OCyNrEKY9CxSD4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=dtlUjWVw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d21cecc11fso741747585a.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 04:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751284345; x=1751889145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHVXbyXuiwtB2/73cWxg7OdkkEX1KH9/l8aDMD4iqb0=;
        b=dtlUjWVwIo6dknq2kxKvZTYNu8vKJyT2xbJL+y+9CGyb5vgCnvTvxDFt/gJdo4WzwL
         uS2iyvZ9CNc4SuOjK48Yk8DeF7i7SnpnQV5A7IC7plVhmr7epYcae4I92wUqejQmC9eW
         TOY9DVEmJ7dcIhNgn7SN/YDi5Q3Lf9oa+SE82FM3laHN41htE8grK+TZrR0kPatUk5RT
         +c1Dyf+gVn2ZhlrqIZD6XIsJC5PniB/dVAK8PHPK0/Pt1qzJfER+nKNEi3B3GkXX084E
         J0ESV3j1I2UgafBm42U8pQKKXY6e39oRuG4jEbngwSiWt6dw1mAq1N3eWpwSO73GPeFU
         WZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751284345; x=1751889145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHVXbyXuiwtB2/73cWxg7OdkkEX1KH9/l8aDMD4iqb0=;
        b=lfUjbO0/uW7ek0e7EvDrRwwpBSnOjyQXEF/XTcwfxK58vc0cZx5a+W9+p9+ArOGPjx
         dBm/zEI37+o5Nr+MpMiuY7iKw7tngdyCiRfjqRH8QTGXjT6uhogVjBkoLdoT22g1WEia
         Cn5bu8MS+a+aiRgTHMCW+MKByzgb86Sg7e96bUkcwZRc0FsDpLdElrQYZl2RYPZdmciz
         wzk1OS86hAt9kg6nHHWoE0zLuYXEcAzOEZBCY6gJYGW5UFmo+jyi7OEJAulqvj8oufto
         AFs9PDENhnll+Nt062AZnAg4UkHImJ0LudR+gxo1NoqqG0NMeyOzmuClT3dMTpn3hENe
         eyVg==
X-Forwarded-Encrypted: i=1; AJvYcCW27m235JEufYcEl+qpdE07ZJiOUSgcheVCpcRbD7pz+kag4ycYV+8XEVmIs52yuc79gEFZNGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5jv05kp4HOhYF4d08jx5ysajCNkiHfjdVmA09pcc14KKlNJU
	z0oDnZrorKEUSyruDUmE+5oAFDIW6boQMb+TU6aSANnzj9V4i6LMcay04egSJxqXmA==
X-Gm-Gg: ASbGncuDhCEqwjM+K7yEFZq+4ftxbrhhaTCIoTI19ZPBts/Lbd8PZE6uZbdJMiP/Njo
	vJ3nn+XNhx8l1s+VlX+XXjkaIdpU0aIRjRs0WHz55iTxX4cXSJ+sT3+6Mz278AsmTHuz5AfeRnW
	YglMavP6hF0F2ATdB9kaKtO2krmqKqKaniaAYMk8p/653kCXtC8yW6z2+URXmsHci2Hxd4zCINK
	7WGhXk8Yos0gca//YkExh/we4xARgS2YfNosIg+y6dIEY82tuOq688Fko//w9Ux+Jq9RVk0LP20
	3CteLchV9DSzBhv+V2HiNK2OKp0aodZY6mJNr5I6pwLr0bP6Z3x8XI7Jg9RRIH7DkA9J8z3vaku
	V9ULCtShh16JyNnsLBjQXV79lfzO5Uw==
X-Google-Smtp-Source: AGHT+IEkaSqwK3rMvbVNWZk/IPnSOuFiw+dNFfDf72TzfSpKXhaAaJ9DW42fpSdJhV2jCkfLOa3e1A==
X-Received: by 2002:a05:620a:2984:b0:7d3:d8d6:1c89 with SMTP id af79cd13be357-7d4439a669bmr2011721085a.43.1751284345554;
        Mon, 30 Jun 2025 04:52:25 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:ca4a:289:b941:38b9:cf01? ([2804:7f1:e2c1:ca4a:289:b941:38b9:cf01])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317e285sm580145285a.45.2025.06.30.04.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 04:52:25 -0700 (PDT)
Message-ID: <1a169adc-fe99-4058-a6a7-e32bb694e997@mojatatu.com>
Date: Mon, 30 Jun 2025 08:52:22 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use-after-free in Linux tc subsystem (v6.15)
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: Mingi Cho <mgcho.minic@gmail.com>, security@kernel.org,
 Jiri Pirko <jiri@resnulli.us>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <CAE1YQVoTz5REkvZWzq_X5f31Sr6NzutVCxxmLfWtmVZkjiingA@mail.gmail.com>
 <CAM_iQpV8NpK_L2_697NccDPfb9SPYhQ7BT1Ssueh7nT-rRKJRA@mail.gmail.com>
 <CAM_iQpXVaxTVALH9_Lki+O=1cMaVx4uQhcRvi4VcS2rEdYkj5Q@mail.gmail.com>
 <CAM_iQpVi0V7DNQFiNWWMr+crM-1EFbnvWV5_L-aOkFsKaA3JBQ@mail.gmail.com>
 <CAM0EoMm4D+q1eLzfKw3gKbQF43GzpBcDFY3w2k2OmtohJn=aJw@mail.gmail.com>
 <CAM0EoMkFzD0gKfJM2-Dtgv6qQ8mjGRFmWF7+oe=qGgBEkVSimg@mail.gmail.com>
 <CAE1YQVq=FmrGw56keHQ2gEGtrdg3H5Nf_OcPb8_Rn5NVQ4AoHg@mail.gmail.com>
 <CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=hSfRAz8ia0Fe4vBw@mail.gmail.com>
 <aGGrP91mBRuN2y0h@pop-os.localdomain>
 <CAM0EoM=jc7=JdHMdXM9hmcP2ZGF0BnByXWbMZUN44LvaGHe-DQ@mail.gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAM0EoM=jc7=JdHMdXM9hmcP2ZGF0BnByXWbMZUN44LvaGHe-DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/25 08:06, Jamal Hadi Salim wrote:
> On Sun, Jun 29, 2025 at 5:08 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>
>> On Sat, Jun 28, 2025 at 05:26:59PM -0400, Jamal Hadi Salim wrote:
>>> On Thu, Jun 26, 2025 at 1:11 AM Mingi Cho <mgcho.minic@gmail.com> wrote:
>>>> Hello,
>>>>
>>>> I think the testcase I reported earlier actually contains two
>>>> different bugs. The first is returning SUCCESS with an empty TBF qdisc
>>>> in tbf_segment, and the second is returning SUCCESS with an empty QFQ
>>>> qdisc in qfq_enqueue.
>>>>
>>>
>>> Please join the list where a more general solution is being discussed here:
>>> https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/
>>
>> I think that one is different, the one here is related to GSO, the above
>> linked one is not. Let me think about the GSO issue, since I already
>> looked into it before.
> 
> TBH, they all look the same to me - at minimal, they should be tested
> against Lion's patch first. Maybe there's a GSO corner case but wasnt
> clear to me.

I did a quick test of Lion's patch using Mingi's C reproducer.
The patch seems to fix the UAF.

cheers,
Victor

