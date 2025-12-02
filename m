Return-Path: <netdev+bounces-243180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBD9C9AD48
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 190094E067A
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C3F18BC3D;
	Tue,  2 Dec 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WARnC4u6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC5Y510X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178925D208
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667229; cv=none; b=rz+H1oGI+3c/hmCa1Qnk4ndS3CY03gwlBGzc4CE9ciweDoL6+pu0W12v29LvLDg4G8Pd97lbyFtskUdWWedDTor/i4cRPgdSYacsz6N1RBI59WSqeV4k19/ysMXh6RECvp0wVAdu7gq8BW9qbneI09O+IB2NfigxMw4zP/SkZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667229; c=relaxed/simple;
	bh=mW6omX4hbJSk+AtJkofaIfpSfIkjIPJplki/My7U9ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaD9x2mIDlwGh5wY40gbglxybKtMMLqU4T0ZwJ/VwAHXlIujq6J7a2a2VzJUOnCIlbIiy3g3ES2zC0XDND2aZ76E+hlRnknhQEIB5Hs3z/7rgL2rvoqekOrVj2n3jSiCM0Ou7ewhnJz+eAoWFVexKLlrzP0KlTrN+DGy1ItFUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WARnC4u6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XC5Y510X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764667227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oatEdA4iBeWiOxEtSPTvYxiqqt1MAIBLwkRLtAgmnzg=;
	b=WARnC4u6Yx2fkFCu9GmynjcDirEWStdYMRpYJH9bQkojvDeJ/MJ588DNc8/pOXZApzsngI
	Y4wc5eIK+2yvx/DXlg9Po5zwL6DbsTud7YPIjZKbwwTSFQ34n8db/EoSTFglTzRsVSN92j
	NQXiQtIV1Q/6NU5PDd5hS4LQJFl/FLI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-kfpqhK8RORSnjCsZNA8NXw-1; Tue, 02 Dec 2025 04:20:23 -0500
X-MC-Unique: kfpqhK8RORSnjCsZNA8NXw-1
X-Mimecast-MFC-AGG-ID: kfpqhK8RORSnjCsZNA8NXw_1764667222
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d110fabso39378805e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 01:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764667222; x=1765272022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oatEdA4iBeWiOxEtSPTvYxiqqt1MAIBLwkRLtAgmnzg=;
        b=XC5Y510X0xEIKuuokwWGFpJNnGeDF9EZLLbJcrWhT4PLzZb1nz3VCfSCap4kfNhbpU
         yDV53iQNlOeYZnZyxQYr3/QBgAxQjaqqxIfBzBbb/AZZKC0eQwnmJa8bUEHxNx5qNfw2
         Gnmxtpv1gibldv71ZLaMiEHj2V5WpFSn+GS2dsci/2ZyADDxpRslI13KnHILXaOfwepa
         +Bh+DkV6noMJIU7NSV/B4NKXTLIVoPXbIwNtoDaaVdNNLAeYGX/aNpgcZDkBrg6bde/z
         YWPuV8M8yyIQds9lXB/prg9DvC/182Gf++iWreY7ecqX/R8Fkpl8eFU6PW3YWOSVVCYD
         4xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764667222; x=1765272022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oatEdA4iBeWiOxEtSPTvYxiqqt1MAIBLwkRLtAgmnzg=;
        b=qP4be02Kl4CGS3L8dWogh8ioWBpsIMe71JZ14+AOHIhJjGuXyHGLrRIsVkCz3n3p6H
         hfbEHc0s47q04hhD0MB2ywahrBUaVYXdw6EDBWcqZY9a9xJivaUq0Hryj6XDBWZdxLyA
         P4MNGCUN8dSmysVseZo2YuTgCSvf85JN1o63zQdyiqVD0VpNLCgq10LuYjUmAQMKObH7
         1ldHnV/QYpqTIcp37AtkVhRWpmo+n0HgQxlWJIuL8uwMWQejK160t9W/QiNMfyvR4BeO
         70Xkd+meCLRkdDr/YFvPaqiWWLaO0gYbLi8Byg1GOAKQKJBJoHRfuvpbUo6XHlxY3svJ
         ze4A==
X-Forwarded-Encrypted: i=1; AJvYcCWT0IbH6CMJH5+kGadx7u8K5FwtuhUPfY0PS1t1q6jKiDngmNVth8aTUvoWiUNj1qi5uyjlDiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuuwrSP2U1RFLObkbOpo+54WINNa2CfwYYVnGomJ6LSSl1GC2e
	2v+/Up4KRY00XohOxKXi85gYMHRtB93h78W1w8ZTFV6DD2zYAfN+osc2kJhYPzV42VPiR59vLD7
	+raBXNy3BvYIpdR3gJDoEpsJh71HSUIhRwhoKE561dEE91i4yXfVIj0yOTg==
X-Gm-Gg: ASbGncvSKBY5xpDEeSh+fn0efN8G/2TfcpRhinDckG9cTpY681KsZJ2EcH4JxobVjY9
	gkcDF7zkoVOh88ElN2efwit0A7EhrJ/pWoTC7ZMPRkw23CLTKYmaLazmF2bx/FUaTGs/bdSQK4Z
	igfWR/ypSKI/7EQ8xs3fyDTyzyYe/zmKwjyn+ttRStx0bSSslt/qTymOHMgBtSI27s0vp9DMs3x
	hSDCczKtb+TtWwOo+MH+26V5vgn1b2mk61yNgduM+Lvszed+MNmouQxj7WE3PeIN2k7IDblmuYZ
	Cc7u0WvOVWblI0sQdhbRNHNUhDGQXsTAL3wfJs6+zm+KH9LkkwP8lw+2osPU2lmHkXmCoHPm/Yo
	t5dJ73KZrd6Wpxw==
X-Received: by 2002:a05:600c:8b37:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47904b1ab30mr299696715e9.16.1764667222479;
        Tue, 02 Dec 2025 01:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJP/MpOj9fI/xUOCHkgnXE2ioVTo6i1VyHwrICzConibJUOms9IpDo/weOvtFJRgZUyvJSmg==
X-Received: by 2002:a05:600c:8b37:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47904b1ab30mr299696445e9.16.1764667222114;
        Tue, 02 Dec 2025 01:20:22 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0cc186sm345710215e9.13.2025.12.02.01.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 01:20:21 -0800 (PST)
Message-ID: <278eb8cc-0564-4883-918e-0aaa62dfa851@redhat.com>
Date: Tue, 2 Dec 2025 10:20:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v5 5/9] net_sched: Check the return value of
 qfq_choose_next_agg()
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, kuba@kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
 <20251126195244.88124-6-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251126195244.88124-6-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 8:52 PM, Cong Wang wrote:
> qfq_choose_next_agg() could return NULL so its return value should be
> properly checked unless NULL is acceptable.
> 
> There are two cases we need to deal with:
> 
> 1) q->in_serv_agg, which is okay with NULL since it is either checked or
>    just compared with other pointer without dereferencing. In fact, it
>    is even intentionally set to NULL in one of the cases.
> 
> 2) in_serv_agg, which is a temporary local variable, which is not okay
>    with NULL, since it is dereferenced immediately, hence must be checked.
> 
> This fix corrects one of the 2nd cases, and leaving the 1st case as they are.
> 
> Although this bug is triggered with the netem duplicate change, the root
> cause is still within qfq qdisc.

Given the above, I think this patch should come first in the series WRT
"net_sched: Implement the right netem duplication behavior"

/P


