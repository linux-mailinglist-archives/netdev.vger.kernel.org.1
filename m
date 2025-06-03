Return-Path: <netdev+bounces-194757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E09ACC4AE
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4699D1893BA1
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB72322DFA8;
	Tue,  3 Jun 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfMDLrC9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EAA22A7EF
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947856; cv=none; b=jowv0ws7t/r0zies6xg2dL+FjL2DoH7vwmrx9o9uPVYvQSL6pOmKwAItrS3hkT2pNqVjeCPGuO1mWBGArA44l6U+PUBSqG0mopptQvDAuvEMr7Xgs2J9X3a3ioyiH9usch7avTRBtWuHcm5bC0s66vltGv5zPsnAJkVYyT/adkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947856; c=relaxed/simple;
	bh=pP732qkBtLWc1YarRschcEvEOBGT5QCpzr6OZsyMpXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEgJDza1LiCi69zQD5gD6NGYBIUstqljideYHYYc8MPxzn0/dOSgKZ1piDqwth3SsUQw5PdqGAHV0Hxv3J1c5iFT48hk7+7WlbSOzKHZwwG98kNUh2zUvVe8/WZfKJQ6Y9Dvs6Cn2+yxljzm2voDmX8KCUktSn/HzmJ5hwhd8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfMDLrC9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748947852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0+40Yg0Yos7RVqiMwJQqOocRWrul7ar29oZFeXB2SU=;
	b=WfMDLrC9Qs6S04He4s/U50A7bOnHn75xMNjWAWOS0YJrpR8ENd8IlKGlUvJLCA93pYRD5F
	sVLQnGA5gdm/YZOKfKAZjprvDJgv7BeIL+2mP8sLIBzEoeg5Tk6RC8tJvCNMdphKVhc17/
	IubJ6atTGqUwQpwBoQfoaCl6FDs2imI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-oNIsuY9gOu69bdtdm8WiyQ-1; Tue, 03 Jun 2025 06:50:51 -0400
X-MC-Unique: oNIsuY9gOu69bdtdm8WiyQ-1
X-Mimecast-MFC-AGG-ID: oNIsuY9gOu69bdtdm8WiyQ_1748947850
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451e24dfe1dso9089105e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748947850; x=1749552650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0+40Yg0Yos7RVqiMwJQqOocRWrul7ar29oZFeXB2SU=;
        b=KijVdlpPQ2/usfcge/+dJWlE7gm7H6dv4x89GpHC6+GUaVB0DE77C4Z7XHiOwbSQ1i
         Vfmfyp39lW1ClZjzg86z0J/9U+InS1d+aVoKPKQ3t6769/OszcbAVtLPcaKnabEDl5JU
         hOJvVayZUtgj0mzQhvTTeAy7aPFRYprQhAldjol/XxIMULZXjYIZDB65oOe4NMvMuLyq
         O22VS0N0pF6D6WXLhNS3AgKEc+G/h8Rl6QqoNxMU2i400Q10XV7MJwq1uHrZkYD98YcY
         m9qAjgfF5JDc9hLe18e3pnzT1H7AbLSPvuEGayGTJ/FBojixGDx9NLx8lVYkDymfbF8/
         CUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmIM3h489WbXsyuZY7If4zPLV3qX52YS6yqDHfnTImL9uzysSz/KqX24YfChivJpGZUdhk2Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOAQr+NarLMRBf1ZaNHcERbOlmgRU7aleBNCyer55HwchgrRmw
	DqKz4/VdW1AonU4nHiX6NG1B9o3WvFZop3YixTMZlcdUhHIBezosTmj8QXJ5DwEOtVS6Gg26UXs
	aCK8EeOJl8CMfA9lfYS5RVttie6mfwtepwb4aAfzl7qGv/OESdZeDfdkj+A==
X-Gm-Gg: ASbGncsVZcI1h/rP+7HsK0qKEWzF4MtIuB01zdH6WLHskF6m4RD/w9AviTlhwu9e3Bo
	EQgDzDKSnIm4qik4NsHm3r0abva6pqLGBlHz4kCj3ELiTxTNZabc7PwdkMYeab4w8eldRQx1Rvk
	0/3B2MldRw4ca+hqqg8UM0bNAOxhyrKmcy2qxcfARYD9xQncJLfP7ya+sB6Duf86GSHLMq+5KLw
	MNdSst4w1jwKm2j/9m3yAfW53WxaeppDtEIX0bhUVZ++u4Lwnrf2eUA2+UA0iCzuklJh9Nhguik
	jv5LMo96HDKN1KxPnLkifytwl7+8XPOQsBmNeFhzg2UDDdI2QW9jRoWr
X-Received: by 2002:a05:600c:3b10:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-450d885e485mr167351715e9.17.1748947850289;
        Tue, 03 Jun 2025 03:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtGECdKa1RWIrVSs41cY4rfCiCynHGO3J9EwYlEtBcnGInHb9ONotRvfoR7OrR5T/NIAl9cQ==
X-Received: by 2002:a05:600c:3b10:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-450d885e485mr167351265e9.17.1748947849868;
        Tue, 03 Jun 2025 03:50:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d80065e0sm163577265e9.29.2025.06.03.03.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 03:50:49 -0700 (PDT)
Message-ID: <b8d181e9-d818-4cf4-b470-a54b6df763a4@redhat.com>
Date: Tue, 3 Jun 2025 12:50:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gve: add missing NULL check for
 gve_alloc_pending_packet() in TX DQO
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, Bailey Forrest <bcf@google.com>,
 Eric Dumazet <edumazet@google.com>
Cc: Mina Almasry <almasrymina@google.com>, joshwash@google.com,
 willemb@google.com, pkaligineedi@google.com, kuba@kernel.org,
 jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 darren.kenny@oracle.com
References: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
 <CAHS8izOqWWdsEheAFSwOtzPM98ZudP7gKZMECWUhcU1NCLnwHA@mail.gmail.com>
 <cc05cbf5-0b59-4442-9585-9658d67f9059@oracle.com>
 <bf4f1e06-f692-43bf-9261-30585a1427d7@oracle.com>
 <CANn89iJS9UNvotxXx7f920-OnxLnJ2CjWSUtvaioOMqGKNJdRg@mail.gmail.com>
 <CANH7hM5O7aq=bMybUqgMf5MxgAZm29RvCTO_oSOfAn1efZnKhg@mail.gmail.com>
 <abb065ab-1923-4154-8b79-f47a86a3d30e@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abb065ab-1923-4154-8b79-f47a86a3d30e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 11:03 AM, ALOK TIWARI wrote:
> On 03-06-2025 00:54, Bailey Forrest wrote:
>> I think this patch isn't needed. gve_tx_add_skb_dqo() is only called
>> after checking gve_maybe_stop_tx_dqo(), which checks that
>> gve_alloc_pending_packet() will not return NULL.
> 
> Thank you for the clarification,
> 
> Even so, I felt it could be a bit misleading for developers and tools. 
> But if you believe the patch isn't required,I completely understand.
> In that case, I kindly request you to provide your NACK on the [PATCH 
> net v2] mail thread for formal tracking,
> so that other developers can also be aware of the reasoning and 
> understand the context.

IMHO it's indeed confusing that the same condition is checked in
gve_alloc_pending_packet() and ignored by gve_tx_add_skb_dqo().

Even gve_alloc_pending_packet() is only called after the
gve_maybe_stop_tx_dqo().

Either always ignore the NULL condition it in both places (possibly with
a comment) or always check it.

/P


