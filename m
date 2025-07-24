Return-Path: <netdev+bounces-209747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A666B10B0A
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7A91CE234E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852E2D63E5;
	Thu, 24 Jul 2025 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BB61TH7B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01902D5C76
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362667; cv=none; b=GMvqH7WRzFJD5UpkUflcQfFPjAZKQpT4qFBNMPgGgojudzQMKxRj8hHWxx5brblrZTWpgz91QcWMTLGjXGjhrqJGlfCY9TXF1fi7eDFZRIk4e0zZgeRF23AZUqZuuztwcgcXQ6t5OAruI50494+Si8W8KXmZrjLt/vqmJBxrKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362667; c=relaxed/simple;
	bh=keOlY8IaAAP4UK7nEyK2eSAQe1k4TUyTEO0v5TsdGIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uNnfBKpFOY7TRi1N3E8syxoiLkeGd56jeq+nH0rfJZfLQ900Nw6OMh4EJJeTOgrLxTRAIxMaQ7ixtgc5swq7LHpOu0wneWxiVOowr90qMhLkGDVgkn8EAu09kygG6W22jwslv9sbb07Ly0+GxXlANhlSJptaJ/Flr7HKH8oLKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BB61TH7B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753362664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzMToL0msrSZ/KKMxmuznJBdXGU3S4ZL56R4KdRa7go=;
	b=BB61TH7BPG1btsSu7D7dR3xBvBvLYcCcE/21W8XHYGHowQsP6fZS76T5cDEfNuIUreic+2
	L9STSFrUeWtdrvWE7FyEzLvSGZYk1KzXNS2+iidFQXlxxYGILRY5gX2oo480mydDDrv4B3
	e+fLceLxuc2atV+DaLHPxImnL70AGlQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-nh2WXxXsNheZtIae9pTtUg-1; Thu, 24 Jul 2025 09:11:03 -0400
X-MC-Unique: nh2WXxXsNheZtIae9pTtUg-1
X-Mimecast-MFC-AGG-ID: nh2WXxXsNheZtIae9pTtUg_1753362662
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso669557f8f.0
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 06:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753362662; x=1753967462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzMToL0msrSZ/KKMxmuznJBdXGU3S4ZL56R4KdRa7go=;
        b=ZEhhXXjdzdvjQG1JrNzFbmbnvUcqAZyQDCWwcY41yFY+2hoxNwleRHbbpdaXSOk/78
         omeQQKV6sMf60E4sFebiGbNicm9mjeW22w7X8rLhQiZhO1FMin4CGNboOmbzv6B9wLPe
         yr/JGi9BYhZO8cJSvT+VyNzTQBrMPtf7cATxQOCvgIBagZSHp+Z1/UEV1P4oVRRHjlvW
         OZq7AqwF1VzwA3rugPtU3FnI2P58KA2xLF3VaLPp4Syyj5UCKTTBA6V1ychf8mcMWAF2
         A7VMOCNKPYD+BkP9/GNqSJcC0PIm9QQhFjthxjy2JezJYpt3eF0oV0+s2HCDYnHHgFih
         Y2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVOY+vtTec37rNXDrDvdELnP8ayVs71Qp54LQBx+QROwaYYUdT5cyUA/AAaF+j2FP0Em45CQf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDEsoO7DsHnPZP7HYZcrWcHT3pG7OqK8E6EsvrfMXOWjf4uu/
	/p28l3PsoiC3dNiqHWXhl1RiYNMMGOQwhh84mOt3m/8jgUEoj2D1wY+dJu5wJ3+yeDTcaBl5pdj
	lxsOLdls+F3c13gIMdIt1SJRGy6/kuw6CQZ67wPok4Q0ibyB4lpQtOm2NoA==
X-Gm-Gg: ASbGnctelF5QqypzHBjUquKbpqR20CYcGniDLUWtbXne4HzifGoSv7Y80hgDcfA2CdO
	MTODniX05A8L8sIS51QAEow72CmAxtk28iHi6nIGkfeE8PMgvTknkQi5TlwAtrfdSBk19fIRkkF
	H20TY9mhKNTWoIYF1MTU0LfubVMgq/Hy2GQmd5zTxZvDs7IRtpM4F9o3ySttIkWSvjNcvV+P5Wp
	psxNP2TRcEaaIWt7map7QyBi1dois+fPrAZFL1NdUTB1UU6yl5a1ozEediHyz9blOxmSzaRwl/u
	Fr7zqim+K7SBQO+/21zhtO0RmFuN/vjKG2Jegp0NtrLxiee4ihGdseyRY7ElK+GbFqLhDy1amli
	uYRvnklRpgls=
X-Received: by 2002:a05:6000:40db:b0:3a6:d2ae:1503 with SMTP id ffacd0b85a97d-3b768ef6f18mr6952659f8f.34.1753362662149;
        Thu, 24 Jul 2025 06:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9uXjjqVyQTr1AvkZtxeDHHOZSkmpUhu0Uhy7GWwFd3tbgN6rpLR2iWPHM6a6vJBIw8pnGSQ==
X-Received: by 2002:a05:6000:40db:b0:3a6:d2ae:1503 with SMTP id ffacd0b85a97d-3b768ef6f18mr6952627f8f.34.1753362661709;
        Thu, 24 Jul 2025 06:11:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcc3ccasm2177679f8f.80.2025.07.24.06.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:11:01 -0700 (PDT)
Message-ID: <e79b4382-9421-498d-8b8c-6157ff070a34@redhat.com>
Date: Thu, 24 Jul 2025 15:10:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 00/14] AccECN protocol patch series
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/22/25 11:59 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Please find the v14 AccECN protocol patch series, which covers the core
> functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
> and AccECN failure handling. The Accurate ECN draft can be found in
> https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

I don't have any additional comments, but let's wait for Eric's review.

Also we are very far in the development cycle, likely this will have to
be postponed to the next cycle.

Thanks,

Paolo


