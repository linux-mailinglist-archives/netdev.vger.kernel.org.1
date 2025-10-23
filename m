Return-Path: <netdev+bounces-232118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278A0C0152A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FC31A07358
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0F19C556;
	Thu, 23 Oct 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3ZgCRzg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8C2FE573
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225570; cv=none; b=qen3MeXOeRcbpXsXuLKcNJVmosFn645zuz7wPEwO8z4QUkyPWGkpaz8ISpzEFZ7nZEmAfHg6n9erJKO5vwHKhTxH9pcPaeAFElOph+CfYRTw/Fw7Zhxv5MTf5z0qDqaY/vjApBhQEMPLdSaoBQC91F6p9U2z+WR/D+jMa5eduZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225570; c=relaxed/simple;
	bh=YTo5/4OMOd3lWDLDsXUjpHjutYHubtO/IGPFyF3mFho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXeiP+IL7mr6sUjosA84ExHWyT38EBEYLqKgSYVn30VswNP3IbXfiK5plXbdNx6EiyqB7z/F+IvSWelNynD//TY4oFtRikgQcyv7cw3pyizzpVZaKVsjYVDvrA/4io0US39IWLxmWONrNTouW2eX+KSi0xOOprGspPe43paXGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3ZgCRzg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761225566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orDVHo56Q4ZPAR2bGgHilNt/ebSuO9xA0ItOWYqqNtg=;
	b=G3ZgCRzgf1qZqlWP6HpiUBcC37ClfLKvhUE4yCt07qJZq7PYlvRt+OAap/be6Tg19SSVxP
	4rTVK9BSMF6jSISl0eyhAxEfwxZ7gmuQBrD0gbkUzSVKia/UWEAEC1l/q12wDEgNToDQ8w
	xuPKrlLrc1Wu5uiqJbkpt+EHA+NNxl8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Z_HSF5HEOb6wRMBOOy3inw-1; Thu, 23 Oct 2025 09:19:25 -0400
X-MC-Unique: Z_HSF5HEOb6wRMBOOy3inw-1
X-Mimecast-MFC-AGG-ID: Z_HSF5HEOb6wRMBOOy3inw_1761225564
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4710c04a403so6935155e9.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 06:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225564; x=1761830364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orDVHo56Q4ZPAR2bGgHilNt/ebSuO9xA0ItOWYqqNtg=;
        b=kD0icAgraJxIbLMHnqM8gy4AjiYQo+iFUi9NHl8c4xsySzobC8CnCXpZXSURXPZQvP
         9/+ZiLSUqy5G7vZ//cgCK9rDCKkbsxFGE4+U9VqwAxDuvPqF9ExXwkNfpKwQbW1AA3pK
         ot0cnhxx6AITnSTamtrUSfRuOLrlMeZRzwKP0o5S++95h5NO5jonc9RnkvO5EAo6kBX4
         gX6vZgVDHImPV58tgO0zk/c38wpQFPZlusoZJxaN1bna5d4CsVAai5t9dTUtRjy8uoDk
         D7i5s5x0OZZqWxznEdotlUXAzHExZcETHm5gpcj22R8ntF1daxAmfHzP6iayx56S91na
         YxDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS5brEKeIh66o2AxZ+oAdBm1Hnlv+OJ9FwqgEov3oUYlfkp/gHdnfI6XSftFJdP92kqfpX6M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrEyC2Mx8E+K7yWpUVae3niW0UflskyE00ztYxgh7mwzB3Gmw
	Mmy1KYUl7MTbQxfURxDfO0CMTlF5cGcpDoylP6Oc0B4XLoj9YxGnN5MRkwqRgZ1Y7VRgpTR2GIQ
	zNSBNjnRPmgWGualvkIiwZ62dT7og+/McfdKFbdaIoOtHXT5Kut6Fe7ksCt0327U9lA==
X-Gm-Gg: ASbGncvewoKxrYnPukf4Y/mFsqB/Zq3/CrGGRKtLt8WN6TItJZHqE99Cu+cjaVse2gR
	sgNEBc+YFII5SJ5QgEv6l3Uo1A/mlk5HJg5kJieazZeUmrAXWCWArJeBJtjblcxqT609S6/ozon
	oICaV3ndEO52fluP3N//SV3K4JNQtZqm6D7DvUCkz1YKTWrDxGCztga2RXToFnxGg666uGg5SBq
	WMIKCJsMuP1HQ2Z5A6yd/4u1eyMfphYhCikRbJcuelnyVgUTqeLPrtu7hAKsRXZQ5QfPlPZh9ra
	mWWkdP7Vco7Z5Y0pFfdI3KCZ08e1vil+tbFU3ofd066JA4ja6OxbRxzI2G7ICdebDy+rcEJ7RK1
	+QCOI9ZClHN+BgLpQKzWWjymi8+nn/mjLIfdPNXkc+RkId1A=
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4711791c5dfmr201974615e9.30.1761225563921;
        Thu, 23 Oct 2025 06:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm45xr0VDSbSJhLiSWA+vgtMsBEedTS2GKmfKwkQzymQykk44M2qlEqmdNAaMLntjlczmRqA==
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4711791c5dfmr201974325e9.30.1761225563543;
        Thu, 23 Oct 2025 06:19:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae9253bsm36163435e9.1.2025.10.23.06.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:19:23 -0700 (PDT)
Message-ID: <0f3856ca-5d09-416b-a424-0d0f00b3ce4b@redhat.com>
Date: Thu, 23 Oct 2025 15:19:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sched: readjust the execution conditions
 for dev_watchdog()
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
References: <20251021095336.65626-1-tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251021095336.65626-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 11:53 AM, Tonghao Zhang wrote:
> readjust the execution conditions for dev_watchdog() and reduce
> the tab indentation of the code.
> 
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>

This kind of changes with large diffstat to just move around whitespaces
are justified only within the scope of larger functional refactor and/or
new features.

/P


