Return-Path: <netdev+bounces-192634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F127AC097F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21ED19E5B48
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180B9288CA2;
	Thu, 22 May 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xb8zw0IC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE026A09A
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908549; cv=none; b=NZnA+ZpMazQ3o1leHBClt+uEluxQpYl16bXvMU0Gyy8BFqfCdYGgf7qvfgKLCPfFn08iUcMoWulJgAJv8Kqq087E3a09OLJC+KtTzD6+qPL8CF5tva8jVpgQ0yW0b8MSGaEacTuxyEmQQqfemsV2vok2mpenil8qB4P+S0i9hfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908549; c=relaxed/simple;
	bh=ZhOeW2TscYoFyXeYm71KTwS4Bp1Zf8k1T9tqklWASlc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FVPPxPApumrnPEvrRwNOaDJaNg/EYOUTAFQYXZuxcIFw6iyAGPBzRpMHrQL+as4pCIfOKDGfIfKpr0f7UM689txPRvnvjxmvJuNQ5uTq1sjhKwOqSoJunztVwyFKyutQZFNCxSgwXTWIAAQTjxoqUdaHB5Lh1vCcvFvguo9AM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xb8zw0IC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747908545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhOeW2TscYoFyXeYm71KTwS4Bp1Zf8k1T9tqklWASlc=;
	b=Xb8zw0ICwY1zhc9OFhUTutw0LH6CeVg+dsP8Rq4JwD04u9/S4fayima7KPARbG9iFTPIT2
	gykpcCEJqmelyXu6HqsBMzUxTbfeHIc6cg42ysA+aDEuYaUopz9fB3bi3rJXXD3TJnU+2P
	ub4/3mQ7mS+h5303A55E773rKrugi1k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-JG8D8NpMMS61E4QkTWDpAA-1; Thu, 22 May 2025 06:09:04 -0400
X-MC-Unique: JG8D8NpMMS61E4QkTWDpAA-1
X-Mimecast-MFC-AGG-ID: JG8D8NpMMS61E4QkTWDpAA_1747908543
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso4185891f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 03:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747908543; x=1748513343;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhOeW2TscYoFyXeYm71KTwS4Bp1Zf8k1T9tqklWASlc=;
        b=J5F8vSgKwaL/b21a/ddbz+6JoYcqmKmS+4luZ+okIPkX4Fxj7RWNFPy6VUjRVNgeM3
         SXxIQw6T197eGm4JJ+2CZIG9a+fPYQNZ/R2j8h58PUwgSQuOMNKIMZHGVZ8262WbXloM
         vcFkmZtwkqC1lLs8qKlLCOCCVwy+J+u+u9VpYCS+pVawTLGb0g2VpvQXMyKXZBaE0abH
         5gJRAvUfizYNGit8E7saJ7vYdH00sulToxLHIEpXk5BSnRRrscouhDwOt1Yrui/T1lXA
         IYGoWqIwxw901YP4TkR0SDaO2OGovcA1INq/GfgJxW76+hSNpNQ9BsE+1Oe7ydqNVxN5
         uWOg==
X-Forwarded-Encrypted: i=1; AJvYcCXNBJTql31OiiSiA2VXHtie4Qcy+Mg7QeBEq3RxoVvcEzzTpbRi2p5RkkgyY6lS+I2Yv7HmyjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2er1DNXWpuSthETtHImtoPcwtOb3F+FwfwX+ZVmf4JuKGb+k
	GzoTblBMs8Y0hc8fGzu7tsJCNSjXWcM9s+skmxQ8VAnEhkmooUWvn+3+0o3M5fCXruKxTtgC0FB
	TqirAihMCEvmiXAXx5LgVE/3dsZhlBGRoWvpFhy7fI3q0HB2e9/HLN147xRSximJCPKqP
X-Gm-Gg: ASbGncsgJ3c/2IGKdtBIMQo4n9rK7W6cuKjml/C/rlOZ5CK+/tJydJOX8sxp7bqYoXj
	6GwsCR0nVT+rMO/l219cRgxJUH0y8mi/q1fPN2/2SpS0UWDXbam0elj4VDxGE3wVbjoXhXq2bN/
	M0orlWi02xK9IUmdC/4AMe5pKG5aTa06bHtXl5eqcNivSr9Ou1fZbs0xYplMuWE5zThBvbDbbj7
	CeFTg/+CXdxtsd7Dpy+26TIxBh4bP6gJE0uGmw6XjA4hEFGqvO+e6vpDa5FbvSylKDeo0kZebWq
	SqTN8hoQtuFVGatxyek=
X-Received: by 2002:a05:6000:1a8c:b0:3a3:76e2:ccb7 with SMTP id ffacd0b85a97d-3a376e2cf3dmr11914686f8f.5.1747908543042;
        Thu, 22 May 2025 03:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/SOeQ2+VqjWJn117XcAJWF/NFDn8srPYGjQvlAENU5/eAr/jU/bIRTzUhN1KOmiMGW0ftlg==
X-Received: by 2002:a05:6000:1a8c:b0:3a3:76e2:ccb7 with SMTP id ffacd0b85a97d-3a376e2cf3dmr11914661f8f.5.1747908542744;
        Thu, 22 May 2025 03:09:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5bd8asm22981891f8f.33.2025.05.22.03.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 03:09:02 -0700 (PDT)
Message-ID: <584524ef-9fd7-4326-9f1b-693ca62c5692@redhat.com>
Date: Thu, 22 May 2025 12:09:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: nft_queues.sh failures
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Recently the nipa CI infra went through some tuning, and the mentioned
self-test now often fails.

As I could not find any applied or pending relevant change, I have a
vague suspect that the timeout applied to the server command now
triggers due to different timing. Could you please have a look?

Thanks

Paolo


