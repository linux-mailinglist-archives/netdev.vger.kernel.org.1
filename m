Return-Path: <netdev+bounces-175770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9FEA67720
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5233B97C4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401AF20E6ED;
	Tue, 18 Mar 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYz+Rhbt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9B20DD59
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309905; cv=none; b=lrKcInSta+gUtW0xrjuoPxeftTS5/s2qR31kJae83oUfEXI2Zgv6IR0d6z4NBT+L9PvkYCS8DLluDYeoZjxHU2Jg9I5WB2sUbQkQEiDiZ1zsGvpxw0tVeQbglKsvUSs/RIxRRYx5KZkEQe/7nUNEmDdJjzxyBZ3d/xXMw50xh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309905; c=relaxed/simple;
	bh=vAkLLRriZpF90VI6CgmIyqs3BdfO2ti5N7u5dAQe2GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDFB+dQoVGL9tMULgbbdkNbcs09yFj1CHX6Nquj3TcHzHM7PjO4S0B6IrujiFLRVjoA/JJ32axvT2V/H7+PppEtrLLNLqH7dWpVmdQ8VOSE6Rx9oI8l28S1ZYnxw2BLybuuDJWkebj2oRli7avSfFiBuDHQMJlYE+koGIjjES1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYz+Rhbt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742309902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YE2U1AJQp8TD7bURlzflaNXSGB5MC0CVX9y1TtlZeE=;
	b=eYz+RhbttRY4VMHxIRPSz3Lb3mQLT4ypFP+Y+olgw64emAIbfYDzLmomh3pYq/g3lMEGqx
	jsZo5KkukhYOwmSNuvACPO6s2fxd4J1E2blKFQZgG+tb8x1FPPVRlm6AgE4Z7u2n4P+aP7
	JeW8BEn21yhoQE4fRbNFtSsjpEBH08I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-iwwXPzn_OAGsyBhzbmmbYg-1; Tue, 18 Mar 2025 10:58:20 -0400
X-MC-Unique: iwwXPzn_OAGsyBhzbmmbYg-1
X-Mimecast-MFC-AGG-ID: iwwXPzn_OAGsyBhzbmmbYg_1742309900
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab397fff5a3so707626366b.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309899; x=1742914699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YE2U1AJQp8TD7bURlzflaNXSGB5MC0CVX9y1TtlZeE=;
        b=CjOS8/Aq/pp8z4PJ8XgA1Zt6u742DoUwRvoW88gGIXNj6+ucpzS2JEYgH3kJE0fkFC
         RYnr1aGpCbA2GxtIRjj0J8mILFw1y/Y03HsMoJO1YRsyGbQTMo1z1ORXtiYCBJqKRceo
         CIQ2aLjG2mpbEmvusr5mfS1eOf82oKP/eqebr29RbC6qw6q0WicKhBpxjJx6ZWIMyvQb
         JCiFDyvO6GN1DjFEy5ilzYfcalaFSsq6n+wdFq5Cw5KyS6TjPP7nylVKTJ57OwOBbI6o
         8X36+cQhDfrI6+NV8YVKKz0ebXF/LgZp6YP3lHfv2YCulTV3E9ifvK04vG2OnLSIo7oS
         0dDw==
X-Gm-Message-State: AOJu0Ywubp47mQrTeVhtCQGQD0rIdYALFoM03T/mhwf2Ffrczw1zG4JU
	UEq/3/SihOZ+GQCXfYXTYi4SehHoFN987tp8giRDMYzh76ODiIOihU3H+mIEj2FhJRIvmvvWD4y
	SyQyG9NlWM24xTdRY5ZVTiqfku6StG96WKnLxcOjJ1aDuVYCyaTYGVfgnJDztx7d8
X-Gm-Gg: ASbGncsIZgCwY10m+t+URCePr70AZCB5gynPVpescvZmLwOYDE/+OEvfzUV19kGfRtl
	ywktzkl3/CqjWOaow5JkpQP6DrZRKtOEjwa4EdFYMWFWUuUQ8wm4y0Le5d2XqLR79Iw8GnlUjiY
	fneXqy8IUV31U4BZdfveNnrZlBCTtzv5sypHMEcnpNtUYz17jZkL7ZAUDv5qYKj2lrOId5qc0rM
	+UssfuufMA1624ecMNc0fh8kjxcwpe559hOZ8B1L6PhTewx8ufB5BEV/ID2JLuokpcw0xiifXJz
	Li1Uk627DMIr1eLrwYjQFGTNwwWALfo550FoHKYdsMdHeg==
X-Received: by 2002:a17:907:d786:b0:ac3:9544:4d4 with SMTP id a640c23a62f3a-ac3955347c0mr395839966b.16.1742309899378;
        Tue, 18 Mar 2025 07:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4OKuXzwt4nAnOYSWKPu59vGXPhCw0Pfh5FdijLop33RuyL0u78o0kbQA5szdBLBbWOBsxdw==
X-Received: by 2002:a17:907:d786:b0:ac3:9544:4d4 with SMTP id a640c23a62f3a-ac3955347c0mr395834666b.16.1742309898812;
        Tue, 18 Mar 2025 07:58:18 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147ec3bcsm871196166b.62.2025.03.18.07.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:58:18 -0700 (PDT)
Message-ID: <a9c961ab-a90c-46ee-b2e7-0f160ecae99e@redhat.com>
Date: Tue, 18 Mar 2025 15:58:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] MAINTAINERS: Add Andrea Mayer as a maintainer
 of SRv6
To: David Ahern <dsahern@kernel.org>, andrea.mayer@uniroma2.it
Cc: netdev@vger.kernel.org
References: <20250312092212.46299-1-dsahern@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312092212.46299-1-dsahern@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/12/25 10:22 AM, David Ahern wrote:
> Andrea has made significant contributions to SRv6 support in Linux.
> Acknowledge the work and on-going interest in Srv6 support with a
> maintainers entry for these files so hopefully he is included
> on patches going forward.
> 
> v2
> - add non-uapi header files

FTR, the changelog should come after the '---' separator. Yep this is a
somewhat 'recent' process change WRT the past. No need to repost I can
fix it while applying the patch.

@Andrea: we need your explicit ack here, as this is basically putting
some obligations on you ;)

/P


