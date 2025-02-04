Return-Path: <netdev+bounces-162434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD5A26E42
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C327188717D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FCE207A27;
	Tue,  4 Feb 2025 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKDt8RU+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D996207A19
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661208; cv=none; b=rR6M1Bkfrtrs+K8PoPMShs0fMoGml59wgWUtq8yj3EJieSzoRAA4RWxbi4XJbbyiY232YBYqPiFm4IGfR100N8dESmXlPz+EiopL3pJsFMhKTzN+wZnRiCrM7T4zxqSHRR4JVZuXGpI8raiDQROfi0wzbL1S9sTMgWYeHN/ofB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661208; c=relaxed/simple;
	bh=9Td2emv6G7RQQq06HgJtIA/IxRo0meiVHHleG8thsmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPSzN+tmxlBAXQcT+g0JRUi8hm5w4lv+oEIGkrLRayLvCVAbT00D9x1A6RupDmBb7WAAv9qwah0+7v1zAe8gNRLk8No9sYp49aGTvBt3ddNLhkBf5twSPWm9S9Ya0V/0URbnBX1PXsJVbeaFJX6CNjtNBLq/JVXgnNejy7fYCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKDt8RU+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738661205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Td2emv6G7RQQq06HgJtIA/IxRo0meiVHHleG8thsmA=;
	b=EKDt8RU+6lOr/PfwVV9OQNvBNxczkc1Fexs2OjyHR0z/oc8oNzj8emeafHg2FFw/ZMVb/8
	tqAeQ0hALEIlRTt5GCmYKtIdk+ok1kG5ksdKw2/+Vv/beje4+pi8VUc8VSNwmgulanBEIY
	nMtrNl2PaVu5HVEMmKNqBy5+bdyRgKQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-HgFsH9efMX64TWptDJ__qQ-1; Tue, 04 Feb 2025 04:26:44 -0500
X-MC-Unique: HgFsH9efMX64TWptDJ__qQ-1
X-Mimecast-MFC-AGG-ID: HgFsH9efMX64TWptDJ__qQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dab928a84so214455f8f.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 01:26:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738661202; x=1739266002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Td2emv6G7RQQq06HgJtIA/IxRo0meiVHHleG8thsmA=;
        b=Kv+vaty9qqM+ryWMGoKLQnX2KutgiK2JrIQMh/mNJPI7R3ZFVfXidZZ82GqRJG+Abt
         vP4GbSDHaOA+ZQ7st54KK99WT3ChAD58DOWMkL/30cy6bFkReq6aHvd8+RsivM3tazq8
         XcrR3p7tXKBWPol4McgfL37CZf0IS3ezMMwTb7n1zueI8vKlINeCGpgXwFVjnnqPHaq9
         C+rllmP++9cs3FWTsTxhmtt5FhExWlSeo83NbNWxVKKK6kbVweJ3C3NkNqSfuSd4Er4f
         XHFKabRORs9Nk8LNq5FGLMFn+6//5axAOcmjVty8cx76aB4y20HKJfeDqcPXtCNp3IhN
         xwfA==
X-Gm-Message-State: AOJu0Yx2flz32UEpiW2xNZc5DyWlOP7VUQNMlXMgs6jiJPvuVUfFJjBH
	od9FCZw57b0F3K36zqItRd8ITL7yyBxMSTj7rodp9F6+UZFkY9XV19IgFr4ClGy1P9qzO3x33p/
	wOVft5Zgotw+uzYgCuk5QtEiYwUFogem9TwGvOUUbS25/rsdIGCS4HZdzMNfVQw==
X-Gm-Gg: ASbGncuBLln3g8+Fj8QcQ/Yy0AT5c0CZXE6oP4841TtOwedHXbBA61P63JahSeVFrHM
	dv95zHrhE05kdHTC55VRzbw06sWRzWvdG9LCvE/ZQBRMwwoGRH2egQ4Wdk4JIc1YhdN7zuEQkZt
	Aj2fwysLDOkcC6T8CPtPtXuTv34Ve1fQUA+IvsbAL9O8aq+lwYxHjDL42qpEL0nH6/ba41IBDFZ
	8ZiOYXbhfQxc/NJ7Bs5fXG2PfYYcHRhdHV0hZCrWoD3+RcNgSq7rkQd3vsADQi9o8HhjG/zP+9k
	EsmZAJdGl8WFu6sJlSvyuINml0dzlEmORz0=
X-Received: by 2002:a05:6000:1842:b0:38b:e26d:ea0b with SMTP id ffacd0b85a97d-38c5195f9bcmr22153582f8f.25.1738661202657;
        Tue, 04 Feb 2025 01:26:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl6oi0zEzHnLfkcUR/NKSOszosLz1eYkIx1h1w5uy3SOlgHBUhK8/DTwwe5cVNqRh6lAGQKQ==
X-Received: by 2002:a05:6000:1842:b0:38b:e26d:ea0b with SMTP id ffacd0b85a97d-38c5195f9bcmr22153556f8f.25.1738661202286;
        Tue, 04 Feb 2025 01:26:42 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b547csm15377916f8f.62.2025.02.04.01.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 01:26:41 -0800 (PST)
Message-ID: <8ef9275a-b5f9-45e2-a99c-096fb3213ed8@redhat.com>
Date: Tue, 4 Feb 2025 10:26:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] MAINTAINERS: add a sample ethtool section entry
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org
References: <20250202021155.1019222-1-kuba@kernel.org>
 <20250202021155.1019222-2-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250202021155.1019222-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/25 3:11 AM, Jakub Kicinski wrote:
> This patch is a nop from process perspective, since Andrew already
> is a maintainer and reviews all this code. Let's focus on discussing
> merits of the "section entries" in abstract?

Should the keyword be a little more generic, i.e. just 'cable_test'?
AFAICS the current one doesn't catch the device drivers,

I agree encouraging more driver API reviewer would be great, but I
personally have a slight preference to add/maintain entries only they
actually affect the process.

What about tying the creation of the entry to some specific contribution?

/P


