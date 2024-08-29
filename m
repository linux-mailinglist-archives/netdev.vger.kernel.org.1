Return-Path: <netdev+bounces-123170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF70963E9C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E15288C96
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E290A189F3E;
	Thu, 29 Aug 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTMBhRlI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61418A92D
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920243; cv=none; b=UY8IJvwsyiKrKX+hCTwLtvCn6IMj8zZ4vxO/GTOfb8uqmTzSjUpfVc/+hOd1qVvmRE77mzfyjm1tpbXaHGlOro6Z38tXuWKeZajg2pT3hVI/KX6oCJKYA6/sB6z4j01q9pXpnPqdLK6Oai7gpokHHR0mo1G8AfZRfkdgG2aptWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920243; c=relaxed/simple;
	bh=uS0lQ6fVn+ubBBwBbVgMRJqxeIlXoLrJBWEyU8mTaTo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HAa0+SaAgRwYqCrYc/6ksaD2jAsFO1Lhzn1IdYHbtiwBliojMTLP//iUT6XpPoIKdlFidrljvQ9h5fkyD4d2ldkxzxVdvIErUfIRppwr8Vm5NfpZcHWEDvxhs9vY3GTQXu25Q/iPUSVuT4aSDbK5aUw0lbeud+l+X7CV2rnpPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTMBhRlI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724920240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qvb93xLBJQ52OShbGm3thAYoRvo5bzwOoOyNaEarO2E=;
	b=KTMBhRlIhkF+P+VUrFfKTxdACYMo/8kdeiKQ9LofYpGOIWAL3ukL9mJHHPBEe+cw/PhcvV
	jvv1jjlxjYNRuHQYvYEoPOlzi/0FsDATudZjb27xoV7T+0m7Sg2xaVFvbDS57pF4PLUpae
	YMlScfayciKLi5xoW3ugdT6zvCfkiZg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-yC6gvLidNhyBMB8VUwQKjA-1; Thu, 29 Aug 2024 04:30:34 -0400
X-MC-Unique: yC6gvLidNhyBMB8VUwQKjA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-429c224d9edso4169275e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 01:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920233; x=1725525033;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvb93xLBJQ52OShbGm3thAYoRvo5bzwOoOyNaEarO2E=;
        b=tkL0wVV9Os2Vxan1Sd02oOb1uPxqbxW9OySAf101sepSuMOJu5IOs5NERHXEa40Lvj
         EK/wQ9dwvmaqcJJYwTUtQ9ceJCb7hvXNt8oVvZV5xdA7ul51p2gDfJf8T4GSd4up9pok
         W2lswgFjxTEHRR43ZesVRejD3JiPthTDZZ9ffs6NfhxnP16worFrifFM3rC3IuFtIm4L
         rkDedX09XEo34XmWCIpO+dJWjxGrLBENXnzE5P+H0CPUWAcXuK8uUFdDo9ZrvKjstGJ3
         FEfzLU0BliJjjq7R5hGhrEoEwdcuS+d04NPw/i2kv/fwZhTVsnAb3UOAC1WFCPt1O0HH
         ZKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD2TQCiumREG0DF0HRsBK/KmaJ9t2xYAot3++uE40FNASbQ+yrmwrpLKkJOIqfAAABu0fDhXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXE1Zq2pGy0WoE43Iw8loooncJmMUXEAeHy6zvalzHRjF7etC/
	uGJ1AGWRt4GwH3M55fN6EeKxU7NEQ4+ADepDkSD318jLHdhJVbTX94tpV3ZrUKH9/TjX45+XkDZ
	auz0NL194/k48cv6HJmklU2kVtsf/6QY0wyjnekVrcc/QF8v/hIXfqwrgAF327ZXo
X-Received: by 2002:a5d:40cd:0:b0:368:71fc:abbd with SMTP id ffacd0b85a97d-3749b54686cmr1375643f8f.26.1724920232743;
        Thu, 29 Aug 2024 01:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjKOfkBcyxNk8aRtN8xRTAWPJvrk7dkI8C75aJSmoes3B46tcFsjjT/IQq+JhIMmfOY+7W5w==
X-Received: by 2002:a5d:40cd:0:b0:368:71fc:abbd with SMTP id ffacd0b85a97d-3749b54686cmr1375623f8f.26.1724920232252;
        Thu, 29 Aug 2024 01:30:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efb1a25sm800269f8f.107.2024.08.29.01.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 01:30:31 -0700 (PDT)
Message-ID: <49f67272-b9e4-4974-9959-cada446e3811@redhat.com>
Date: Thu, 29 Aug 2024 10:30:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfc: pn533: Add poll mod list filling check
From: Paolo Abeni <pabeni@redhat.com>
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Samuel Ortiz <sameo@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240827084822.18785-1-amishin@t-argos.ru>
 <26d3f7cf-1fd8-48b6-97be-ba6819a2ff85@redhat.com>
Content-Language: en-US
In-Reply-To: <26d3f7cf-1fd8-48b6-97be-ba6819a2ff85@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 10:26, Paolo Abeni wrote:
> The issue looks real to me and the proposed fix the correct one, but
> waiting a little more for Krzysztof feedback, as he expressed concerns
> on v1.

I almost forgot: for next submissions, please include the target tree in 
the subj prefix ('net' in this case) and avoid reply to the same thread 
with the new version: that usually confuses the patchbot.

Thanks,

Paolo


