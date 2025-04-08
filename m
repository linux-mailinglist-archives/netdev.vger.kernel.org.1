Return-Path: <netdev+bounces-180091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F4BA7F8FA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA33BB20E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45283264A77;
	Tue,  8 Apr 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8plxmtT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF72222DA
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102894; cv=none; b=nli2ZBdHDsQ1uTJASb5Z6QiS/3zu2attbvlWligKuhHukE/9OJ9TKBaIf7pyngJwBd9cglaRSE/9hSteOO9qzPbybAD/2p0yLs+wQMciD8DD417KKPtlwJVgPaUjshIa0BYCklvvwhKXF5WfU/pJ0ZVxQLq099tvTpYnFwKN7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102894; c=relaxed/simple;
	bh=7tvCmDYJakj6To0lTbYGqeUkayvkZgch91nabghKSzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZN6TcWdXQh9THanB3Ig7MoGUZqnBOKMDhTfQQ0n5BzdD2ViVh2VMvul6FHysq9hHh0pkpa9/AdZ7cCO+CgTgZLPm7bIlpL7JjI+FwhK204vN4xYlZzucBAL1M2k5ggdu+vN43+vspnct3xeAPlPBgZYLeU9R7XlV3cca48RAobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8plxmtT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744102891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPGkwCBEbwCVVGfg5la2O5f6dBUMcpAf/en+SLXpjaE=;
	b=N8plxmtTD6QsPUFqktINZbCLNW21CDhMvXVn7tbZtWt42btQbLjFpQEEF9BFpflecIkeE2
	lqlqq4bCnrDwHQRnfTD85eDZaJbvhKy+OkUZ+tBfbPb0yLVD0x7X9LjzwC4GljoNKXZUra
	shuJjDSFydJZ11CvU2HBnaDMFhbONU8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-K632IA-sNneqlatJv8Of-w-1; Tue, 08 Apr 2025 05:01:30 -0400
X-MC-Unique: K632IA-sNneqlatJv8Of-w-1
X-Mimecast-MFC-AGG-ID: K632IA-sNneqlatJv8Of-w_1744102889
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so42627265e9.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 02:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102889; x=1744707689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPGkwCBEbwCVVGfg5la2O5f6dBUMcpAf/en+SLXpjaE=;
        b=Vk8Tw5SyylxXpY/KAmdlnH8eVrf+e+m1WGMAxZjVgW93HNM0YuuVgFnQ4lI/1z/tlZ
         oHqhLdYIIzyENdg0/lrTogoBwY8YWJNPGT+EfVaylDs3yDQKhIqmRGeRi3p3cAL7MzjF
         Ru3ru7s3mMejSKZxfngjUtFtoznLV+5sisdHnHIHdR0ouasAaVtK+DU4g+O0WVrsdn0o
         BbGuQXQJ1386X1vaxNMwyd80bMY07DUmlarMr+DERl6e/ExC0+rynCZXWVV5QnN1Z9Gp
         arWaEhmXvDm+bve2wQId8HmCQ395LzzZkdEsZxYqYuokzBKzUfuUjCKQgaIK60eJFAh7
         p81A==
X-Forwarded-Encrypted: i=1; AJvYcCVYKcqBjweiT4HzbuSFLxjKJtzMHSEfaXz+Bv8scG1PoE/rts2S4LxNCC+sS9b2Qqrwr6ktwxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIxHLpC+WlQjXlEI6eZbHShaR2y2yXiiBi9/JMhGubqyearYo
	KUwkTRfxMrREXCQwQmpRZ5trJJDciOAix0Ap+U7kZRX2VquBEwvIyNwSzZc1VCAbwEYhBaY6fAw
	BKkqaNCrv7aaJp/i0ZZQGPhLYuJG8+o60rgHikuesynVU6IlaC/JpyQ==
X-Gm-Gg: ASbGncuKtQRAiTEZ0OWvMN8Dnxn24Cg0W8NOipTe43VNUc4LQwPzTfQWkXmLC4ut33H
	GBgEyQQciRjwrToafg2r5AGdgZJcM/4DKdKbUPzMsSMONAroOuwSxBDgGOaRL6smDv/NPhKYcxT
	8lAdlnkE/mdELO0ryGfQLTiC8wJPNJqANi/MxRBDGZGIh3ukOiJc2nSgEhz/CeUtwM4VMZFEq9z
	4o3+b0B9jMAo8H8djGZE4xXJKj5vYJt6X9Kn+Xg4sqroJa8Kxgpem4aOXd7Cc7Y7SRKF5tnF1+9
	/2pkLihnNoOcQJYNr/O2JzCMNSn00/eFTUdYL3aDpJ8=
X-Received: by 2002:a05:600c:3b14:b0:43c:ec97:75db with SMTP id 5b1f17b1804b1-43ed0bf6aeemr146665325e9.11.1744102889051;
        Tue, 08 Apr 2025 02:01:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNv9CNaPJThrCi2wBeMk97glWQprLz4Vmj0KKCZvOKeSubJVrB2o+0JTvzW25pUvIW+KDV9g==
X-Received: by 2002:a05:600c:3b14:b0:43c:ec97:75db with SMTP id 5b1f17b1804b1-43ed0bf6aeemr146664545e9.11.1744102888157;
        Tue, 08 Apr 2025 02:01:28 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1794e94sm160953935e9.31.2025.04.08.02.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 02:01:27 -0700 (PDT)
Message-ID: <584c74f6-a5c1-4842-ac5b-9f3639b5b5c4@redhat.com>
Date: Tue, 8 Apr 2025 11:01:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 00/11] net_sched: make ->qlen_notify() idempotent
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, victor@mojatatu.com
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/25 11:10 PM, Cong Wang wrote:
> Gerrard reported a vulnerability exists in fq_codel where manipulating
> the MTU can cause codel_dequeue() to drop all packets. The parent qdisc's
> sch->q.qlen is only updated via ->qlen_notify() if the fq_codel queue
> remains non-empty after the drops. This discrepancy in qlen between
> fq_codel and its parent can lead to a use-after-free condition.
> 
> Let's fix this by making all existing ->qlen_notify() idempotent so that
> the sch->q.qlen check will be no longer necessary.
> 
> Patch 1~5 make all existing ->qlen_notify() idempotent to prepare for
> patch 6 which removes the sch->q.qlen check. They are followed by 5
> selftests for each type of Qdisc's we touch here.
> 
> All existing and new Qdisc selftests pass after this patchset.
> 
> Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")

FTR, I think it would be better to include the fixes tag in the relevant
commit message, as such I propagated the above tags in patch 6.

/P


