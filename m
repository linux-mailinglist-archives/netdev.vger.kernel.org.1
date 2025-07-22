Return-Path: <netdev+bounces-208844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D58B0D601
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9B15608C7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEA91A3A8A;
	Tue, 22 Jul 2025 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jo9iLYVY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E0539A
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176730; cv=none; b=OE+rtgY5KHLEIWzEzvMtize46t6Mmo5qKtR0DkNjyjphVfmmOSzY0jUPUpUSRgFMNA6QvJQ37gjZxmxUmAL8n0Q0IwFxxqSR+wsgiycuXe+4T/afCz/URAHjsnQgqRK7x/Y5xHiBGvQgpICwj1KyGDmjLXkFoapMsEVD+RGojDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176730; c=relaxed/simple;
	bh=F2cD0lh42oqXi5BEc6kGuYPLi06w+y7Z2KqPM/63v+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUgIjXJFS8eBNDzP64aifSQZyyielJVYP5oCT9XG1oTh70lgBkVGjUDIseckAM0yj+T3ixzDLZhJ7SmY6KZrxL3JZxzvYCkT3zQnXQLLQxJXmmPFI9QrkyMvvL/zZlu5c2cFRVIm2fQyTE57gWITo3repnPlYVUxoRklJ07lVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jo9iLYVY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753176726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7LWZokVF/1hrAIOvo9v+bZrv5fbjEPa8YAjh4c6+4U=;
	b=Jo9iLYVYUmw1rz92Wv68SFq+wl5HDme9KWxWWTVb0I8v+j/wFm9W6sghdK5xB4Y5Btu9PW
	isTucic82w/I4eWFguoXtUbvpDhRyZE8oCURjYOQ4yFb4TDktSIBQP1w5Y3sJMEnXykGjB
	vfMbghiBj9w2/832FgVkqI8iQIjNlp0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-ZK9j-hv3MVCWYwo0mdvwcQ-1; Tue, 22 Jul 2025 05:32:04 -0400
X-MC-Unique: ZK9j-hv3MVCWYwo0mdvwcQ-1
X-Mimecast-MFC-AGG-ID: ZK9j-hv3MVCWYwo0mdvwcQ_1753176724
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so32441825e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 02:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753176723; x=1753781523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7LWZokVF/1hrAIOvo9v+bZrv5fbjEPa8YAjh4c6+4U=;
        b=DyOfXzG4/aVte5HH0Q+LaDQrsFUWN9Xvk6Ou01MIIm3WAixpc0IZn8q/l31Me0eojQ
         /F1r7oo/k2eMgUmJwu1b63dt2XEqJ0gn2RTL17xCB5LM6Jd6/Kfnqy8jZPSgPsAnSdps
         juQm4ZBh+jtBBkcbhy3GHf+DWOveWmdL0He0oiWg9fo/rDA8DzRW4D8vCViYyr3nGBCc
         9OtyVppJohKz+ihk/mEYwvT746397nn0XXYLoZfqN4hGaNqItkCDluSnUEJ4brLhkhJ1
         wpDOSA0mlJHK2HvsH2wjjmZ94KK2nYeliJvHdR9oyx+wWcRASoRtRuThRSZh2p8mOPzp
         iTfQ==
X-Gm-Message-State: AOJu0YzUCpMHw9IO433c0GbUDYJXg5Sn1TeKkllRwVHum9R1W5tdyXuE
	wdGU2KmrYUVGGrAiraMnHGcUPT85LQ+Be8K3G/WdzJ3oOcDlkrJD+aSF11u/tjy4EtDBdDLD7tS
	ZN5NyQuIhxpm1Txyi6FAKxtCoUcLv+onrhaMZKI6OZLhH6mLsjyQ2z+4wuBYyVJBQCw==
X-Gm-Gg: ASbGncv3qKsK7XFvRk6F1U25PUo49YJXAtmBlwVHuaLytiFKMHvZLl2yGlTMWtozdO1
	2HFchMmnzS0uNAtQuvr9oWrkUc88LJFxOsAG1y+ZKIFfiWdCGV8KAHtCa47Bn+xOqfedl4KM+NK
	KRHIfR75Hq7/wxagunVBSNhgdKZ/tPnCW3sTArMHaZ4d6L8ds416V5unu3BBLv8vBE+YbooDdcD
	QdwcsLHlEexoBDo78H8gp1ezSd7VDyHL/+uqulc5/4Adb7kZyjZLN1wQrqfHJ2lhHpJfQsqoKVE
	/WZ/8WpdaprHrXVgG2xX/mMrO+W0wK6vbQBWqOJLhSsWPFDWQLcMvGe7a6XBxVc9eMdTIYsm4Kx
	KI8kAw9Vo56E=
X-Received: by 2002:a05:6000:178b:b0:3a4:ea40:4d3f with SMTP id ffacd0b85a97d-3b613eab0d2mr15579514f8f.53.1753176723111;
        Tue, 22 Jul 2025 02:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmsa4NK5CvXrlrvzjlVtB18euqqeNBYO+LlnRx23yLJFvIP3MyVY6T65aKKwavruY+KJ3CVA==
X-Received: by 2002:a05:6000:178b:b0:3a4:ea40:4d3f with SMTP id ffacd0b85a97d-3b613eab0d2mr15579475f8f.53.1753176722584;
        Tue, 22 Jul 2025 02:32:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d581sm12788758f8f.64.2025.07.22.02.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:32:02 -0700 (PDT)
Message-ID: <534146d9-53b1-4b4a-8978-206f6ad4f77e@redhat.com>
Date: Tue, 22 Jul 2025 11:32:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] gve: implement DQO TX datapath for AF_XDP
 zero-copy
To: Jason Xing <kerneljasonxing@gmail.com>,
 Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, willemb@google.com,
 Joshua Washington <joshwash@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>
References: <20250717152839.973004-1-jeroendb@google.com>
 <20250717152839.973004-5-jeroendb@google.com>
 <CAL+tcoBu0ZQzLA0MvwAzsYYpz=Z=xR7LiLmFwJUXcHFDvFZVPg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL+tcoBu0ZQzLA0MvwAzsYYpz=Z=xR7LiLmFwJUXcHFDvFZVPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/22/25 1:37 AM, Jason Xing wrote:
> On Thu, Jul 17, 2025 at 11:29 PM Jeroen de Borst <jeroendb@google.com> wrote:
>> +
>> +               pkt = gve_alloc_pending_packet(tx);
> 
> I checked gve_alloc_pending_packet() and noticed there is one slight
> chance to return NULL? If so, it will trigger a NULL dereference
> issue.

IIRC, a similar thing was already mentioned on an older patch. Still
IIRC, the trick is that there is a previous, successful call to
gve_has_avail_slots_tx_dqo() that ensures there are free TX packets
avail and operations racing in between on other CPUs could only add more
free pkts.

So the above looks safe to me.

Side note: since this looks like a recurrining topic, I guess it would
be nice a follow-up adding some comments above the relevant functions.

Thanks,

Paolo


