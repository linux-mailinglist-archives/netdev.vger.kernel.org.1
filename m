Return-Path: <netdev+bounces-272012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I5FEFcixWmC7AQAu9opvQ
	(envelope-from <netdev+bounces-272012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:11:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C3B334FCB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5D56307B97C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA283D2FFD;
	Thu, 26 Mar 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwFOng7u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyZcEI3m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9653F7ABD
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526783; cv=none; b=kolWlIzs6Q07azOD0JYH1N+S0gQP8FcV4XyM95x92VR9HjMpO0VuRQjfu99L/oiHg6nXC7TI3OGsG62WtgdgZq+iuDt6R56Oux/zRxz9FoHg1UkkwaDhOi1Dsp/fwKpwN0xXdLOjCG62YxLAHgEDO2DP9c0E8aMBMbyavuSyXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526783; c=relaxed/simple;
	bh=sA3fB4BnnjLeu7CvPj9Yn5D1hipVVWeUuYvt4csgyKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9YUoV3SIaX/hlhKA+pfqgZG8pb9P7lk4/TqupSjE+sKgLOotSzSYcEJHa01805LrJHIHdZMLfNasK+ZT4kNCZADshzgmgSxSFwIqwc4QUphofSoJDBNJfPiu494tpkvXUMg6HCicjqyoGvqaQ0hWri/IhSM8NpSKDTuNJMjYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwFOng7u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyZcEI3m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774526780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjrMgKzBqipC8hTiEvXLT8/tmMZts7qyqc6fr+ObvzM=;
	b=NwFOng7uyQWvENh/V6jEpUEbSvYpkyol7P46VXUm7m51jun4NmTDDy7iV+o8olhS3LlkP1
	3C9pd8vx3OeU3ElgXOugc9IZQPdIFA3lrVauJERJB1baQOfi2AYFJvAcC08Mq85vO2OCYL
	ui2Z+Lto2NqvrRVRsWLGduH3PpeBTyg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-oQy-qBDTNemYv20qAn6g5A-1; Thu, 26 Mar 2026 08:06:18 -0400
X-MC-Unique: oQy-qBDTNemYv20qAn6g5A-1
X-Mimecast-MFC-AGG-ID: oQy-qBDTNemYv20qAn6g5A_1774526777
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48544725bdeso17090875e9.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774526777; x=1775131577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjrMgKzBqipC8hTiEvXLT8/tmMZts7qyqc6fr+ObvzM=;
        b=CyZcEI3m8+1bKSrjMTbTpoH79Wi8ysEXkS1fvvtiVqfDBZfkXQH/7JX5XpB+7yKm/C
         rcznmm4Kk73mqF+SE5D/tBu9U72G6DXOoMePPnRzMd9+M+x/6fN3Oc0cFg4EaSVo3FCb
         hYBjUyYHbOdFM2tR0vEyRN8UdIEJFdtgmvDnfFsPzaGDVrPVGrkDVn7P+I3RS1Z1bsqQ
         1/sIpMhHn7m3J9nAwFyjVKswyYqYwiMId4/Qq64UTy6fN7/zj3Oo4CFvtryLwBfBYICB
         7DjX2hOsWHi5eJTInSj331NNZfzBIKMUY0+qu7XUTkHIC+fOeQngrdSLwWUZaZcYCFJU
         KLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774526777; x=1775131577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjrMgKzBqipC8hTiEvXLT8/tmMZts7qyqc6fr+ObvzM=;
        b=rPrQHf+StnGrdcRoNkb6dUf71BdkhTUmOQntYMkg38QffIE9tGJ8oqQm5jfhTg6sUm
         Wp3DdWtA9s9nE6/PY6WTesaPw66cQWNgxdn8xWtAR2SVjkrBII9bRb3u48xKH4NzN0cj
         yJjeNdUBEFGGiiXEW0Rk/heT/ATkdqB5Detlc+LFnwa15BDx5l0Pn5iRJSw2aUHKMbsp
         ZZnXhmWiaymfgxP/lLr17r/oJzlNcGgF/FwOrESVpnH+Ay6nT8GSGH0QHQc+eVCq1Y8U
         7Rt7D+x0+95yRH2Xd00VA0+BaoYPE8VtvKyNoixb/cQHNDlmCG1demjQ1sTVWQMj9/M1
         DnRw==
X-Forwarded-Encrypted: i=1; AJvYcCWn9aysTSpRjPPa19HayaDAEVD8W6FcZSMXw2UsXJfRcvRx2zjCq9UTUsgj3kPQKN8mwk45Eqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGu+KhYWX6IWfUBJHndUdq9ejvzK7XXQrbZw0gJezHnkrJzTq
	gqBrnj11j1+3/sBTFFlZovI7lFxUxNE+jt3GKt+5VNobPZecjao+QRwSQ8NHCGXktIY3eUCCNp9
	PYVSvcNg+eMUuhUbthRL6Hv3MwJX/IEqDffen3JckSSOTZs8X4vMwATv8pA==
X-Gm-Gg: ATEYQzxKtTZ5WAL6dHmy04EFGNZaHufSeXUq7loRMWi4Cc73W2+1X/IITeELyjgTGR2
	HhCnqb4J1sOhfNgaTUExmHZxnfuyegLaUEYMT1FJbLHZUOP/K0SQc5eGTJr4U7CiTNZg/VpuHW1
	lsEjyFuEF6rHNKx6Hkw8QqitLsFZuSOJ6vYBmbtG5YMzvRRnk6oBp48ZycTqFUsUoeoz37i+zJ0
	kbetalDIy52Yf53PX4bO/1HRPRDEZNGzBAKslR5yY98AULoY1UK1sQouLIegeKAUffhwmQez3XB
	2sAAGscFC3wpbTst9175GZqW677q/mSyS+QrQ9a8K+w/h+TTgTRFqGTrMfdhFocA3VqfU/sYtQZ
	er+dPiExL0+gQrPxJVDFBrtkBHGbqjl0RmhKOklwRhFe0tQKgoyUwY8KG
X-Received: by 2002:a05:600c:45c4:b0:485:5981:1411 with SMTP id 5b1f17b1804b1-48716071b48mr108961045e9.23.1774526777255;
        Thu, 26 Mar 2026 05:06:17 -0700 (PDT)
X-Received: by 2002:a05:600c:45c4:b0:485:5981:1411 with SMTP id 5b1f17b1804b1-48716071b48mr108960305e9.23.1774526776688;
        Thu, 26 Mar 2026 05:06:16 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm44008265e9.11.2026.03.26.05.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:06:16 -0700 (PDT)
Message-ID: <cddbd5e9-6df0-40df-9ae1-6a6f296b4061@redhat.com>
Date: Thu, 26 Mar 2026 13:06:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v35 0/8] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Vivian Wang
 <wangruikang@iscas.ac.cn>, Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260323074441.91691-1-xuanzhuo@linux.alibaba.com>
 <cb8280ad-fd08-4201-9faa-d8b1bc4f0bd7@redhat.com>
 <1774525085.4029815-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1774525085.4029815-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com,iscas.ac.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4C3B334FCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 12:38 PM, Xuan Zhuo wrote:
> On Thu, 26 Mar 2026 12:26:33 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
>> On 3/23/26 8:44 AM, Xuan Zhuo wrote:
>>> Add a driver framework for EEA that will be available in the future.
>>>
>>> This driver is currently quite minimal, implementing only fundamental
>>> core functionalities. Key features include: I/O queue management via
>>> adminq, basic PCI-layer operations, and essential RX/TX data
>>> communication capabilities. It also supports the creation,
>>> initialization, and management of network devices (netdev). Furthermore,
>>> the ring structures for both I/O queues and adminq have been abstracted
>>> into a simple, unified, and reusable library implementation,
>>> facilitating future extension and maintenance.
>>
>> Unfortunately sashiko fund more stuff:
>>
>> https://sashiko.dev/#/patchset/20260323074441.91691-1-xuanzhuo%40linux.alibaba.com
>>
>> AFAIK checks vs malicious values from the H/W are not due, but stats
>> endianness, 32-bits, truesize related concerns looks real.
> 
> I've looked at this, and I think most of it is meaningless. For example, since
> we have the following options,
> 
> +	depends on 64BIT
> 
> there's no need to consider some 32-bit related issues. Many other points are
> also unnecessary.
> 
> I will go through these comments again. I'll try to fix them.
> I might introduce some defensive programming. ^_^ Just to make the
> AI happy. However, I can't make all these comments disappear.
Please, don't add defensive programming for AI's sake. AI reviews are
threaded alike other reviews: if there are valid argument to counter
them, should be ignored. Please instead mention on the ML why specific
comments are not relevant.

Note that defensive checks vs rouge H/W are AFAIK not needed, no need to
argument that.

/P


