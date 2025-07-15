Return-Path: <netdev+bounces-207055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63CB0578E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B5C1C21E53
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211F2D5439;
	Tue, 15 Jul 2025 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCZXDGKW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAB26E6F1
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574481; cv=none; b=Spde7pKoevJGEaPiioRGWwBDndaTL4TVP8qkPWcdmvE/88q4zIFE3YL/1VLOgI4xgsVDNCv6sii0UCOVgN9Tj2i1+fzFMPU+pJY0Nv9GPNthOL0LAOEn7T6eHF6SuBaMy76xInqTK+H3L/0ngUCmjtMaezYeHxJJ8jhGRXBlZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574481; c=relaxed/simple;
	bh=7tnCFfO8LmuSttuDeD3aPSCayV3emS4p64hXZdOcS1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw5wUtRCLMZzAS+rNZCrBw7XFa9DWTOEqjfaF+WztKJcRfiHJbdV1TzVe5jg/Bl9i19Sho9ipRGwSSSvGayZIZc2RiQKEu01lKlj3+yckbMDP/xFQQO4Tqrbk5IfdP55tOWDMuhlIP38/oJPnza7d8rVauGuKqulkTNFAEkFRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCZXDGKW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752574479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypP/3uPIX92OwmKob+XiSe/xCQ8jkJ5YtrfplHAzH/c=;
	b=PCZXDGKWOEVZDoigKiy5AF5KcSyotxs3sfjFeGFT7M/bFrFZgUSQZTYThIsV191qpMMHC2
	6gmKd/MU54vxHlm1FP5d5kpJEQNOht8s9KWtou1woecesdthF8nwRiYRn1bzs9HtxqUWOq
	ZkHgqZrt8lDpKyAhAOE4ChZuz3rCP4M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-rDDMORyBP-y9_LggR9if1Q-1; Tue, 15 Jul 2025 06:14:37 -0400
X-MC-Unique: rDDMORyBP-y9_LggR9if1Q-1
X-Mimecast-MFC-AGG-ID: rDDMORyBP-y9_LggR9if1Q_1752574477
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so2008626f8f.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 03:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574476; x=1753179276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypP/3uPIX92OwmKob+XiSe/xCQ8jkJ5YtrfplHAzH/c=;
        b=PElcjRUxEYcqgGNOeFWPIAFr07n1dWo9jewkNFWQ/LifYqlKlimYvgj5HK2R654ZG8
         F7BTCKATPsLtsckW5ui1azc/4JOt3h5uJKW6G0s8cXwWCCH4nWH1WYg/gNtleh0SLWeD
         1fCC/f13bwwgOoed87F9I3eRK0ktib9HE0DtQLc65ov3tzgpgEK24wcPbtZd9xSsdov1
         Qi7O1Ea0Xy+qnsuXug9r5DM1KkyXIND6vwydbeR84hkQfyXMTwR+Gw04VdUd1fx0iMmW
         C5s8+xIlZzWd0XztYOvBY88naW6k197ljFp+U/U0vf4iV29QY7GcLzNjnoYHDuJR9HEJ
         LhIw==
X-Forwarded-Encrypted: i=1; AJvYcCUimktG5Z1EoqEg1w0dt11Dx2CDXy+N1ky0msJ0y9ckcIAkYm4Jh/BU7sjfHG/nY39gnMYNWBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0w4IQJlB6zqTuub7L0/zAno5DY0g4vPeqVIC8HX4jXQgSmG1O
	iCyrbnvPIVy/GOOT0lXpvRvlu7cHfI2TtweMyDUUc8wNjZaKdx6W6Tn/YeFvBnVoqQkzFKFc1Ti
	xJvb1PBF05JSBp3DtwsikVfp2qmuJyfFaKSnH2q+Iho+2/Rrc0Hnx+QjFzA==
X-Gm-Gg: ASbGncvGYZOj5CwHpnfR1AR9Ts0S0D6s5oHE6XqVkwDv8X+lZU1EEXbw2HMEt5dWRNh
	HEcyoORWANYh6SQiwxrOB/xsBtOw8y8lVZxqGnCVPShlflcG6yLXj3K77usXXp+zg7sOWsMl/89
	+h1aqoxVSDYjv2KFM+QmlmgPW5/QF8lJYHA8IWKgQ7Rf6da8bw41nGpzZz7J7Of+hgMh2gGis4+
	bh/7oLjae7TWTQxMQO4XwVcIE3GKhnCsNpZzBD1EAQf1P50oXTV6QRPj+CQCPExVpzUurJ2/LXh
	i7G9WYRYIDCLB/gz/RXJqjGZXbdRMN+rWmjsHTqa+JuullgHKQPy5JMYaLPohoR6sHvTSuiB74K
	/Y6uWUW0hang=
X-Received: by 2002:a05:6000:2dc2:b0:3a4:f50b:ca2 with SMTP id ffacd0b85a97d-3b5f187591bmr12723891f8f.8.1752574476611;
        Tue, 15 Jul 2025 03:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqDt0VhgbUzm12djJ2+ozvgKflQ0ud+f0lK7/t33X3HfnxhC+iarD7GFhf/FxzMJk6bpTmWQ==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:f50b:ca2 with SMTP id ffacd0b85a97d-3b5f187591bmr12723862f8f.8.1752574476178;
        Tue, 15 Jul 2025 03:14:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm15054723f8f.38.2025.07.15.03.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:14:35 -0700 (PDT)
Message-ID: <6a599379-1eb5-41c2-84fc-eb6fde36d3ba@redhat.com>
Date: Tue, 15 Jul 2025 12:14:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] tcp: receiver changes
To: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20250711114006.480026-1-edumazet@google.com>
 <a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com>
 <d0fea525-5488-48b7-9f88-f6892b5954bf@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d0fea525-5488-48b7-9f88-f6892b5954bf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 11:21 AM, Matthieu Baerts wrote:
> On 15/07/2025 10:25, Paolo Abeni wrote:
>> @Matttbe: can you reproduce the flakes locally? if so, does reverting
>> that series stop them? (not that I'm planning a revert, just to validate
>> my guess).
> 
> I'm trying to reproduce this locally on top of net-next, no luck so far.
> I will also continue to monitor the MPTCP CI.
> 
> For the moment, I don't think it might be linked to this series: 

Agreed. I did not notice the pending mptcp patches, which are a more
relevant suspect here.

> Eventually, because the failure is due to a poll timed out, and other
> unrelated tests have failed at that time too, could it be due to
> overloaded test machines?

Not for a 60s timeout, I guess :-P

/P



