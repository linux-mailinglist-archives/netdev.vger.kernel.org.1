Return-Path: <netdev+bounces-201482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32AFAE98CD
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600D53B1911
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3651F298243;
	Thu, 26 Jun 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXUJPd3n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73179296151
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927534; cv=none; b=bgynaI07M05p4sXN9h29Ciqvy1XBV5Twpu4LDAD5jse8FMDA3OCMu7KiATBUQD3gdgoCyg6ahyPjYh53sSd0loIWq1f/084lZslyeN6RD9SkK1lfS42EC5G4yWt3AFT46ZrPoNZk+pftnri4y9wwohh8C3xgzm1SPXIkzPiRfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927534; c=relaxed/simple;
	bh=TtBYmGz09D1CMPRG3OSGWyOHLjbRQBekiXRFdglC5Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hklw5P+Nsi6SSAlCzv3Tl527yrLj6sV4vvsdk2i6KjPD2ZLLHSioCeqkYZS2G/DtkfNs9N3f+sIabXiIRadaC7jRt7CpNIdjGrcuu83xxs60nc11RRR/AT7lderlHieVvSF7cByI2gCi75k/HOSAsybvy5ApROU6kO6SaRMGl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXUJPd3n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750927531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cWzGMtcq1CX7XXiip+KlPwG5ITrP6Qiqqd5StDP8cc=;
	b=hXUJPd3nAQAGNON6NuEn9J4rG4aSDRlbu6gPRL4HspGs5ITZCe6XjxMeEPf9f49LX72hoO
	OCCYVk8AO23DSC5VptuzbDrS6AUye9iKxVT/WYn/IovWUJxy4LfVfGf8/xtLlSZFDYrvIe
	t7Odn5rFGy7TRDFEjWyr9dJUX2fH8EI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-Whc-mR9yO-Wdm3w3gLeeAg-1; Thu, 26 Jun 2025 04:45:29 -0400
X-MC-Unique: Whc-mR9yO-Wdm3w3gLeeAg-1
X-Mimecast-MFC-AGG-ID: Whc-mR9yO-Wdm3w3gLeeAg_1750927528
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a578958000so256101f8f.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927528; x=1751532328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cWzGMtcq1CX7XXiip+KlPwG5ITrP6Qiqqd5StDP8cc=;
        b=LBzwX7i1CJ5IFLh2KHyVXKOP+gYVS+3STpBsiIgFwF6ul6aUI4jMqSZ3HecSSR4lK4
         o9W1aEGvaCTLEVoF5B697aiwh1ufvi7ORsL1JLdxoMymzIWrPu7ZYLMhp7wME+ny3DkN
         qX/aGQIaSNPBcQZaHhMh/2r60mXTxZMBHzMRsaoJyDVXHrMUuP1Q0R49NHf7bqHAMKmD
         gwHOE0HVnZ4C/21jYBrtIZ/q021zezeDr2h68BRpu6oMIP5VfN5qA5SP7ltLPd+DIvQ2
         HaEVeKfLFzFfcRg0rNjQIU2o1s1ZL/oOXCRzCvY9riOYlXpYfrCbfaG2zrBTccT08QZY
         jLhA==
X-Forwarded-Encrypted: i=1; AJvYcCVWgh/Ez4K/vXIg/OWsgyWV+ySzp3JkAjN5g3JLMGwkpV2rnnAZkgQe+KG7amf5XufWLlsAh8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/BtyOMyO33r3gpe8X/xuUtNsfE4auPypY+xVDYy9aKpStwI5Q
	lTIG0iGMDOliOxlYUxVpxqBi8imhnC5iAVS1O0Bzly2dWh0XJX5SWdjkHPgOs9jFu+yJJTnf/yo
	O/Ejx9kPO57malXLIs1WpbkSRgfPZSPU7DOlVep/tHXFfbnY0awFA/2iJKA==
X-Gm-Gg: ASbGncuZKELkLyYMjIL9W5YSZOX1ONISDlSFqVNQcyRUJ+eMaQR7DSqEgSQq5ErMO05
	oBEF8hxLE47I95QsDB8l0BEDVCwext2RDWOYkEhdw+BUS5h4jK9Bt65hPIyUCLa8sCiIZRy5PYc
	tcB0rfbyBk4CSPC/W1lwgz0OWPF33QY0tFxPPTX4m2T7ao8G2fde90DI0Lvj51iXmO40y3sz4JT
	5g7ivp0H8GTPv3h+KN2GIyM/OeGyBEqCu2zWgKNheSXo0z7EWF/0uXY0tHL+2iwQb2zc7aY1WvD
	DPia1aZxFnCku+DcOcHVlnB3tTSwHxzwztDbshAJFX9xnX+MfYm1AfC2r6hYKlkzIwpYgw==
X-Received: by 2002:a05:6000:178f:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3a6ed6690e4mr5277906f8f.59.1750927528366;
        Thu, 26 Jun 2025 01:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfVGIXnx8DHzz8BcUPW88UwI44879NNMEZ1ofZ9l4yo10/vH91SYC8imFRfdyLgvvW1VRVWA==
X-Received: by 2002:a05:6000:178f:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3a6ed6690e4mr5277871f8f.59.1750927527937;
        Thu, 26 Jun 2025 01:45:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm42572895e9.3.2025.06.26.01.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:45:27 -0700 (PDT)
Message-ID: <182b7c26-2573-40df-9bfc-663dd53a394d@redhat.com>
Date: Thu, 26 Jun 2025 10:45:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4.1] rds: Expose feature parameters via sysfs
 (and ELF)
To: Jakub Kicinski <kuba@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
 andrew@lunn.ch, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623155305.3075686-1-konrad.wilk@oracle.com>
 <20250623155305.3075686-2-konrad.wilk@oracle.com>
 <20250625163009.7b3a9ae1@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250625163009.7b3a9ae1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 1:30 AM, Jakub Kicinski wrote:
> IOW applying this patch is a bit of a leap of faith that RDS
> upstreaming will restart. I don't have anything against the patch
> per se, but neither do I have much faith in this. So if v5 is taking 
> a long time to get applied it will be because its waiting for DaveM or
> Paolo to take it.

I agree with the above. I think that to accept this patch we need it to
be part of a series actually introducing new features and/or deprecating
existing one. And likely deprecating new features without introducing
new ones will make little sense.

Thanks,

Paolo


