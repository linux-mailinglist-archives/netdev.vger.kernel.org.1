Return-Path: <netdev+bounces-267034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBWXNs+tsmlGOwAAu9opvQ
	(envelope-from <netdev+bounces-267034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:13:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC1D2717FA
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14DC53159232
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618523BE653;
	Thu, 12 Mar 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeC8RTSu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKQIKyCw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FA3BA25B
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317463; cv=none; b=iYgjsLeE66V0FZ1IdWwlD2LdTHumTXSkRlu6rzNfRqg+Yuv892m550mrDgcatyQkbXzndKSt3gOAEMQO8rLqu62a8Se0sRCSxx2WSA5+VNzdUyEr6xhnuhjM2XMcYpdMrm/UkjLjraSqe89JaLSu5thrmEyzvTdqj2TMkSOT6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317463; c=relaxed/simple;
	bh=p+91oaBdy5LOr7ECHuqNTLxmHXL5qoG8aRovl/HzNKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT80n+W4SUPs3wijloI8noWe9S8IlBEP6+9u4sAAqfFQZGo8LHh5cvAfEKWn6wv1PVUJOkYWl1H3SjnxhkL4vNAt8fWQOk2rd2SGa/BSJ3cLGbRwl3W3/aLLWSlPz3wAGtCkkRo9QJsRW+mv+TZmbwQbyaUfiLsPL9tW6xewd0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eeC8RTSu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKQIKyCw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773317459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHd0YRN4Qe0P795vXGYLjKVeRfTp0aVarxI7kacSSBw=;
	b=eeC8RTSutocvZ1Ler6OE/IucqZj099pTf2s5iIDqK+tcApCUlI+Dwe7K8S9IKVluBSZHdJ
	VR5znOzJ4CWdm8Wtr322R1bA7CIs5hPNPH95cKlIanOKVkBzhXpmUoEJ41i2gUoRFBXH7p
	7e2N9LtfPDl4BrejEsStPq8mH5FVyTw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-0UROx8OtPACGV8sVzOPyjw-1; Thu, 12 Mar 2026 08:10:58 -0400
X-MC-Unique: 0UROx8OtPACGV8sVzOPyjw-1
X-Mimecast-MFC-AGG-ID: 0UROx8OtPACGV8sVzOPyjw_1773317457
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439ae2cba40so875419f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773317457; x=1773922257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHd0YRN4Qe0P795vXGYLjKVeRfTp0aVarxI7kacSSBw=;
        b=NKQIKyCwItyVaGkoJnbOHnklw1cRILvO8uzsc92hWJda9JQiDUhTPMVZ11ta0VqOzT
         0HVw/yW4obksSqqa2TMlpVNat1oY5vWcZZ1OlRgbPFa+sxXEBo4nyePhnGEFF254OK5z
         +n3RGcGZw4YtbEZZarEMvQVLfw6MXV0f/ezCcC3YK1hkVw3QHWfsKDYjwwDQnSYb6LYA
         irYueyqqAYFtM/+UMPWy6MWsYnSi4r7J/wxr5U6z8D16Asp7Dl799Pz0TSqafXcXCeAR
         y8zwOAc7fjZfOXtmBl0avkQ6cwT08G5q7ztGWGR2GpVEzNETycqd6tMsNSS3gg4p8tKa
         mRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317457; x=1773922257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHd0YRN4Qe0P795vXGYLjKVeRfTp0aVarxI7kacSSBw=;
        b=PqTpO5SWTej4Szclq3dWVUB61C6dIXd4qLDoauTpsKTWC+O1dIOcoVL5+4TH/jRTPW
         B3vR5QOmdra/4NOy8hHXw/VW4sy+DlieicaWSPRcxHBuzvQXvm/D49jluhxzIaTKm8Sb
         UTHIIaTWF71VZJrt7rwAakopW7qj1NygZTHzFv6914P9W2VFlUUcvikTO9UHPuFHk49P
         tEkORjai7Y1pVMrvuqijeFFSMA88eeZ8LC6CIBLAFEZgj+kYWhZ1L8FtFe+Z5+kVGp3Y
         oBNTsXncs6W9X5qqSe3PWSoA+RIRi0vzTcB+34Y/ZzpRhYv9LwAByZ4oiHJRABdp46Dt
         DNBg==
X-Forwarded-Encrypted: i=1; AJvYcCWtZwQahs+uByZAU5bcntJWr+hdPSzHBwJSS2SRrsMQ/Ug/gdUrkjCuiN1gHcix19+mTYEork4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRg5XbqbLK1V+z6I5YTK3VIbZctOY4w4f2nUT5W41iimCkJx6z
	CcnbMz1B1UGPTkAFPVu+cqn0lFow4UAaAN4lWaOa+BPBPPNiKAkCOi/RaTFwAIbJ+xE344xHRmL
	XwsQGldTxnXFm/cvOjYZ5jjNLhLEB0jRvSRwEt1kFic4WOC1gmGcx2A2aSA==
X-Gm-Gg: ATEYQzzxZG3Jov/T/P+i+PlkargQtXZFvgYLYOXOZYsrwRZx4KTfzOz/CMaCNx1Vl96
	80wxY8XMI90bCE/uGBV8astg2Own3FAAnAZKwzrB/h13DOMxmEFQgC2qkMUfQEcaYSVjqzPF9tf
	T7TkmQAtVs46uwIXjkJxS+gEpUpaRK7S1Wk7T7/g/saWjrArwIWlwNZHZ4eHOt8uyhDC1tIFZd8
	1gNistv0oNs1u9F32cTVckwEHZy0xaTcZF0+KWcH6I3EDkh8l43irmU7MYXrREF1SRJPyLpsc+6
	e0wvj3qP9pjv20dOzUP/EODYH0/v3haAvOSyMdkvxMtyo7CKCHeqvgPiAp1eqvxWV9kfK0KCCFC
	dnc5nqVkNpZluXLsMU9siBUBLLD5EAQUdlyhv9pu5JriClp4mFEKsTYQ=
X-Received: by 2002:a05:6000:603:b0:439:b6f9:b426 with SMTP id ffacd0b85a97d-439f81dde75mr10991301f8f.26.1773317456875;
        Thu, 12 Mar 2026 05:10:56 -0700 (PDT)
X-Received: by 2002:a05:6000:603:b0:439:b6f9:b426 with SMTP id ffacd0b85a97d-439f81dde75mr10991247f8f.26.1773317456386;
        Thu, 12 Mar 2026 05:10:56 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fdf09abesm7439722f8f.0.2026.03.12.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:10:55 -0700 (PDT)
Message-ID: <dcff36c0-2d63-4f4a-96f2-6b7cb3d933f1@redhat.com>
Date: Thu, 12 Mar 2026 13:10:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 09/11] net/nebula-matrix: add Dispatch layer
 implementation
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260310120959.22015-1-illusion.wang@nebula-matrix.com>
 <20260310120959.22015-10-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310120959.22015-10-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267034-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Queue-Id: 4FC1D2717FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/10/26 1:09 PM, illusion.wang wrote:
> This patch can have a quick review, 

I hope so :)

> function is similar

Similar to what?

Possibly this sentence was not supposed to be here?!?

> The primary issue in the Dispatch layer is how to determine
> the routing approach
> Two routing ways:
> Dispatch Layer-> Resource Layer -> HW layer
> The Dispatch Layer routes tasks to Resource Layer, which may interact
> with the HW Layer for hardware writes.
> 
> Dispatch Layer->Channel Layer
> The Dispatch Layers redirects hooks to the Channel Layer.
> 
> The primary challenge at the Dispatch layer lies in determining the
> routing approach, 

There is the same exact sentence a paragraph above. Possibly C&P error?

/P


