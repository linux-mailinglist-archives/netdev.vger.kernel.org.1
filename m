Return-Path: <netdev+bounces-200523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32386AE5DAB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232B34A7164
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F61253355;
	Tue, 24 Jun 2025 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHTfpFtY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F824EA85
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750103; cv=none; b=bT15N1cmcsUnGEWKa6S2WZtx70m/ZjAGEYtLyikBFyzNZ5Pxa6P6y5e/n/scRccpj4BIoCosSJ8B29ncDyXl9Lx8bopYpPw6q0Xh4fom1lRnmis3CjqjuPaP1qX7gTgEu2SF8lrw5viyl5Jwfm81YUZtrreI9jI48NtPnsBD2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750103; c=relaxed/simple;
	bh=WTyU4uIoL45lMqVlFAlsJ7iFEAkWYnXl0ZCY3CDJIek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTb/whvFXUZA9ogA1Di5fZu/oA6bmu5AfCMpkoDidf/f2QLpl14XJ4YNtjcUGO7F9L8ZGHH8cK+X3pPTWK2IFqOVdKR6Hke5B6Sdjwk1fAWyW1KdxIokm2FRnQbGZaYU0cfe6ixN4gcxmLzhiQQy6EYjPb4TtJg0gsRridpYQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHTfpFtY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750750100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H93KP2X9wKia0oxgYl069stHzy0a79pbdFNyKfhSK1w=;
	b=GHTfpFtYOP6DZvewapWIER3hrnY9zVh/vAIWtFECaZdd1bydTPjw9uuMmozpkeDtZ0NSmF
	QBTsGhQt+o8KvnsirDdoI1gnb4RVYI39Qw1rebUuMKOc0ADwuukjRPZdzEaspypGKMi1Rj
	sWBSsueieqe8P3v7e2le8ww7/3/X0y4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-czFz8gq1ONSOvt8YB-rlcw-1; Tue, 24 Jun 2025 03:28:19 -0400
X-MC-Unique: czFz8gq1ONSOvt8YB-rlcw-1
X-Mimecast-MFC-AGG-ID: czFz8gq1ONSOvt8YB-rlcw_1750750098
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so52843f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750750098; x=1751354898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H93KP2X9wKia0oxgYl069stHzy0a79pbdFNyKfhSK1w=;
        b=wyfv6sxfrZ/8ZXwfVl+NUvL+2pgPj5kA5agmuVfVVTYuSNoS5JrfjMdHuL9HvgrhXy
         IMlMtAacZakrVyyjMzMPVb1MkbgM6PfdbfZ/x7oPq8pZSB6hAK1SQWLzGdIEnJLqsTk5
         ShTR8/W3rsdX4/vhK/77v4ZVzGQXLhVkUowXXSfFIHpWJoKvGnS9L0iMmexfngghdsVn
         byw5OQf955x3N/HwlSneEGd38UW+MwDZE2onaZOTq6iJOGMF5VMJf5eFu/DCd0ph9oRZ
         BwHGTn1rSf4GcLqpdAkDmkiiVIxN3UlN11k593WOIlVEuPYDKUUp3BUxZFwYLqxtEZ31
         tKdg==
X-Forwarded-Encrypted: i=1; AJvYcCW89qPt0jnFe88+1Ndq54zN0DQc71FEA71elMsumAghYfL22iZ1kCv/KzcqyP7Jk5ecOZIxx/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaJVV9mgO5dOaguHqm5UuJEHJWp/DjVAHYYtUTSf9jHGcdmwk
	Yf52qBveRyVNgeG4ZkXoLks5zEGZSWgKAJpKXCUgJNeb32sTFmXmg2ruywD0wxrfZHuCxQPmxRb
	ecgJPbYHtUYg0n+LYDBBFa8DccoIQB8fiY086ea8ktpwf9TmQoT9+mtShKw==
X-Gm-Gg: ASbGncuRoTRROFJ81ji/w/+khIA5l5lf4XGegasH8+NOxQCRDcv8JzdySs9qgyorP/c
	zwTjIt6dobqqIq3PGE4/uTcmZKmsd+8ZsTG6bmGbDc78HcJzx8sZqgQt4DX5mc6OxRNr9q5L+It
	853tXNBymSae3pH/7QCDCC5FPS7dGF0NTliLLS5uJH0xW+1yMB6sDRdqrNmaZE8KUwv0UjiyCpJ
	rPgsRVu0BJUq4HKDWNgOcK9ZZo33A/dhvpy/oi3U7h9mHCHmeDIcAAvPgxoroc1yqyDDV/jfu3W
	NLotp2GbCiNJlgkrHZ6AU42kKDQ89Q==
X-Received: by 2002:a05:6000:2906:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3a6d130b3b5mr11787494f8f.26.1750750097875;
        Tue, 24 Jun 2025 00:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4US9Z2OYdrK7D8E0VF4/l/TVl23gapFn02nrrA4RMD2EOy2rkOxCQvpT3wA+JYCKYL4wdvg==
X-Received: by 2002:a05:6000:2906:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3a6d130b3b5mr11787468f8f.26.1750750097493;
        Tue, 24 Jun 2025 00:28:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8069534sm1172291f8f.44.2025.06.24.00.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 00:28:16 -0700 (PDT)
Message-ID: <923746b8-73d4-483c-b687-388a7cc2b74a@redhat.com>
Date: Tue, 24 Jun 2025 09:28:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 0/8] Add support for 25G, 50G, and 100G to
 fbnic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kernel-team@meta.com, edumazet@google.com
References: <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
 <5ce8c769-6c36-4d0a-831d-e8edab830beb@redhat.com>
 <20250620073602.5ea8ea6c@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250620073602.5ea8ea6c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 4:36 PM, Jakub Kicinski wrote:
> On Thu, 19 Jun 2025 10:44:41 +0200 Paolo Abeni wrote:
>> Apparently this is causing TSO tests 
> 
> I had a closer look, I think the TSO test case is always failing,
> the test that didn't fail before but fails now is the test for
> pause statistics. Since the driver didn't support pause config
> before the test returned XFAIL, now there is pause but no stats
> so it fails. I guess we may have been better off using SKIP rather
> than XFAIL in the test case, so that the CI doesn't consider lack
> of results a pass.

Thanks for the pointers. I agree the issue is in the selftests code and
patches LGTM.

Thanks,

Paolo


