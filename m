Return-Path: <netdev+bounces-239531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B63C69624
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 13:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F239F34B8AC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F50250BEC;
	Tue, 18 Nov 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O83kRwuv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib+GeaHr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ADA1FECB0
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469026; cv=none; b=EomiwLqPnB0s3gfkgd8Nan0WC2E/i8gKr5rhbt2Gt5DzJcCGbSWTdyPc8dFolj2B6N8wSenHuqzGjkULurCeD6Etx2WO80sx873MIWoZCICmRO+ATq0CzQuK9z4tFCj/6yMm3hZ/rpsQYUo2f+Ivfg+mQ5DHKwX3TAsQKl7Jt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469026; c=relaxed/simple;
	bh=8B9ouElv+xeFaTKAh9MT9KBQGuCsWdhQ9skK5QulCOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upfdJmb/BjaYhDZsafWoZ0EyumHlbYWMqC5G4SrzQ1XGjhnWx+o5hAPowpA1NLCV9oBQrGKNBgJyQVaSAC5y1JISzeBrPE7ZrXG81TJ6IY0OmW6BFYXMcY5hA0XOkV4EernR2F8qO66exq6BNpfCbrlB4i8LNw1fRWMs+jkNxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O83kRwuv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib+GeaHr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763469024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1y6PrlUAcuxkkEloRxo0vMvd5pujl1anuTqxEZ8o/Q=;
	b=O83kRwuvD5AKFvQbFu6mrpO9JcXSk/KF+Xooa27/DRka+F8uuo/EEMh6SfG2wgaRcXlfry
	DnpsEUkCjNiA/JwkIgf2SLruFZagfTWR69uUe3Y44BqT195CnNuzkUfl3SQT2OjKd0J0hT
	fizHXj0aec845wY6SgcWNuEH+rnenQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-4-idqONlPJuSSKm7sH_lAg-1; Tue, 18 Nov 2025 07:30:22 -0500
X-MC-Unique: 4-idqONlPJuSSKm7sH_lAg-1
X-Mimecast-MFC-AGG-ID: 4-idqONlPJuSSKm7sH_lAg_1763469022
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so2258464f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763469021; x=1764073821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1y6PrlUAcuxkkEloRxo0vMvd5pujl1anuTqxEZ8o/Q=;
        b=ib+GeaHrpuu/avH9sUKzdMZIMuxV5MZqO5tDHbpN9aEOCFtPnmRi7sRZFCHcwhMshZ
         bhVdMgo2Z/C/8gNeQlA0vgLAfmwiEEGpd/g6Bq62EMLN1lRswsPVN+zLcrscKMW2Gdsk
         KYFv4V9Wp7weLllmBsnsnaTAvvH8a46HCyWDrPJzKUEf7kJiW6n34urmlZ1QU2BLF837
         wsOlAVG0mBJHydb7XzU38+hadvYD6sl1m7A6S+D41YSzlyu2vh1VBh8M3ZEjrLjLbwvH
         y8YhzUVSiwQ4+TThCmSBe8pn96Dpe0WnLL98wps+V9LWFDfkT61UmdX+txmP8p7L0Pld
         GIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469021; x=1764073821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1y6PrlUAcuxkkEloRxo0vMvd5pujl1anuTqxEZ8o/Q=;
        b=CS6hvyf5RdUW59N4clJBhUTOVD7QTHknFFyhXqzCDWnDA7qQTq50n4WlRsXJ8eY92y
         iRTdNUI98sC7a5LdtPgSlKnDgOJq8o4OT8ZI9GxgySra/A24TTa1NBSTZSLF/R1nXNBE
         U/aQuxKFSGzeuiFPTHxYGqaN/uL9FU8iAJ4XS1hUkvJ3MbmKlqbVTFatk7VRw3Ztw0c5
         MCiYvGx+gMzro3BslUyLuimTRS6Y16nqwmahnjeRaLxHShFXHCgDSFhzS7wdNKD+uNGg
         9YQ+XKyYx/R57NhH4B0dHAL4r3qMzexJtMOGpGBEFwKyO+WhlEbPV7CBYL6l/unr2OwB
         un4g==
X-Forwarded-Encrypted: i=1; AJvYcCWiOgPhVI5xIt6JzVLmYCXIvI1ivhvBWcJvQxIT+SfzECXya7Sd1/bYNaAGG/4J9+nAeJ/QhvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiV037kR08ISaZr/wMzkPYS0GYYGlqVHH/VDSVC65R3ST5d8F
	Lzt7C/iSSeshqdIOjszGhCeWW+E22t0Snroo0yGB5J+/kRVVzDISDJNxF88MzVnL2yctbkysIO3
	DLk5peF5aC2QgQ0vIc9ELhdWlE02XtflpBoXIge8aL9pkGDZNRZtpuWqlTA==
X-Gm-Gg: ASbGncuvv8gG28R+RSrR5kgP9B8Dy697wbAi0l/Imu0xP8Mdjr9Bw6rAnfNCh7MTKWJ
	evGllbEbckHCQuvoLGG9hQrb5shAzdaq1JSQjzelq8865JMzNiuRPYbAuq0VQ2bpFZMa7sO6uv5
	qRFPQ6yNsdfGzwzAzzqfJaPi+zcCjMnS4qHYivTAtAkBFl0Aqm/UGW5WWscqdr74P3O+wrTuqA1
	St48f0lO10qIk9yP1hxHFbLTOsdsngNZpLvkpOFxLo8IkxZQMy2ImpTdkUCsMe9tw+5dBrnXHpP
	H4D+B9uDljkl8a+JwSw1OodlkS/S9ZHs0NdZw/Wxk5CWtl+ryi+zYX/m/eGGB6SBYc656YGCPdN
	wbwQARa33aIPf
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4778fe5c820mr175963245e9.10.1763469021606;
        Tue, 18 Nov 2025 04:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOZAD7E1uZGLJ36i/AdVTCJbTikjjEi/nzH5t0pOPTGX1/txTaGcM5dmDEUHhqBH4ogD1aHQ==
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4778fe5c820mr175962585e9.10.1763469021119;
        Tue, 18 Nov 2025 04:30:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dcd891sm15757525e9.7.2025.11.18.04.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:30:20 -0800 (PST)
Message-ID: <715746f8-d1f0-485a-ab83-2f768722698f@redhat.com>
Date: Tue, 18 Nov 2025 13:30:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 05/14] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN
 identifiers
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Two CA module flags are added in this patch related to AccECN negotiation.
> First, a new CA module flag (TCP_CONG_NEEDS_ACCECN) defines that the CA
> expects to negotiate AccECN functionality using the ECE, CWR and AE flags
> in the TCP header.
> 
> Second, during ECN negotiation, ECT(0) in the IP header is used. This patch
> enables CA to control whether ECT(0) or ECT(1) should be used on a per-segment
> basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the expected ECT value
> in the IP header by the CA when not-yet initialized for the connection.
> 
> The detailed AccECN negotiaotn during the 3WHS can be found in the AccECN spec:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> 
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


