Return-Path: <netdev+bounces-276339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F6AOFwM1mlnAwgAu9opvQ
	(envelope-from <netdev+bounces-276339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:05:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ADE3B8BAE
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A24B4302676F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9938E5CE;
	Wed,  8 Apr 2026 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1NnDJQu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jrB0tdXB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2939B97E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635517; cv=none; b=LNFBi9pYIRjUrI4aD+x6zNmc4hZgnM5/jgep7M3cWQriSz4y02R1J+HETfCEMO1NeoFHezNy7NJ/SUlvukCkCwYSmJfZT0z7wfZZ8JYjABT7zWw4xgY1KgUGqUDnoSOXy+XRWnpdhA+q2/H5fxYSuZo3MOTs1c1P6eOZXylc9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635517; c=relaxed/simple;
	bh=6RLOQdYMY9nOfPi1M3htm+Kjw3fTl7G/eiZvZC/OXpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3SyH9XZeIV/2o6TcfKN/mm2O3MYi27vwcoOFJrActMVXLGMm1NYEQLSQduDL1vYeQEDqIqpEVxF2BVd3kIQRKzOcQQD5PuMaLaMHold3Vs9zWkdgk4uJRUwmwhQ30i3zqmadzwqCIVSUb67oQHkpfmxeaH20wyvpwmwZLr+uT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1NnDJQu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jrB0tdXB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775635515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=krK5N8ZUpkA2tSzYdkTyJTPNIR/Rjakxn7OtZbYaxaw=;
	b=b1NnDJQu9HbwM2w5xqTWoZgpznbuoIvoWQdBvHyf1YixhTaISOr/COmcDusCJJa+P6iaHR
	ZDOI5bmZMbJOK7iTmzl4XdFF1qjirA2B0OGxxtLDrV17/kmlnGWhv8uu2hSJMxXAANL1GU
	a4mnXvZLuqk2XW+aXfWhWik7JsmShzs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-KFP3G3mCN4SHd4U8FgRQYQ-1; Wed, 08 Apr 2026 04:05:14 -0400
X-MC-Unique: KFP3G3mCN4SHd4U8FgRQYQ-1
X-Mimecast-MFC-AGG-ID: KFP3G3mCN4SHd4U8FgRQYQ_1775635513
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c2764f83so6410905e9.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 01:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775635513; x=1776240313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krK5N8ZUpkA2tSzYdkTyJTPNIR/Rjakxn7OtZbYaxaw=;
        b=jrB0tdXBVY7Va7SsQEa7brZbWZXGxsZTkBtozmTXtYCz+9f29Bw5pY3k950Xuvbgj5
         BOIbC9TDoQr+NVoSbaGh20fJ1Zmxp2haRy1PiewZTrkrsZKgLxtWaczdA03xEXvqPSUn
         DaXyoJNNcrAF9iQUMfL/yRkp8kb+CKdMoDTtCxADHvNGxN7BThthXJkQBDIkmqapER91
         c9CLbf58OEj0FdU/rnryTl3G26AWti9EgIUIKvZVYqfHMPXRnxUIvMIbumnV/sKyPGLj
         rhYaJpI41OSPBHsPCJ6/zYL+fRIqnRW9A9nKPBYs/wgIF7EhGnQiWtg1zXZkaVSWJb6j
         LasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635513; x=1776240313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krK5N8ZUpkA2tSzYdkTyJTPNIR/Rjakxn7OtZbYaxaw=;
        b=OGNbholNp6l+Z0+0G9wLGVAOZww58hLqda6ta/vWr6Y6hVefK2BFh06sDGmtNbNaSi
         HxArIeddYlksAAM+mcAmhPnmA7qCntd0zq0yFceiQc6xCHYDLhHeKgT0YLZDrLXwWTAA
         tU3XyTCvQ8LYAZnEHOurYBh9WIpqcr5zLB1bYdaM9zG6LpOm1lr4O+OHe6r/x6l66vwm
         HARzfMqW2zns9yU5z78jZyFgWzA7TVfxpI1dEnK5sW+YJ/sCfJwxNdwb9380TyclXw+d
         BE8Am/RK16SuYWUbZiHq2T8hwDY88LMINDQA4Vl0QyooMmAgMOVOl2rucU/rozt7JapM
         Uimg==
X-Forwarded-Encrypted: i=1; AJvYcCUOjPUzquHq5pemOtgfItQ99TeoPN21uX0D7aUei3qhzK0gi2r3Jc/4XEl7Cp/XJeIS7kHDY30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4qXW6WYP464xNld427l/L0W1XQgpkbaUAhNiFwxhtDZMrpM7
	Q3/e9yuwLc2rpla3cXAY/JEJwUxfc/JQz5jSo7tZSTt/vCTikR7+Ph6WtTwTXzyNhqg6vIBsC7n
	XxkCL8SbU+p7dNSbde2Fvcl+CmzuqefL02pKs+XnvYPJe2AK3v+pOJjhENA==
X-Gm-Gg: AeBDievDU0YjCg8l1akWesF53D1WX+dacmZnLgv7fATunEKjDTQMByWWRUn2aPSR+As
	bsckLt41X2ucnx88r/f2asTOZTL/a0wIOgC0l4/Mj5ibDkbUDLB9eMEMcNBWvOmaK85KiWAdGl3
	k5fpr36QO+v8LAAPQJocII1zJyoBonCamm1Hsy0lYEY59qwZE1qRh6UA6vcdIRL6g8IzyGiuUaW
	MUek4xxSLn4rAA25vc78xvm1eBZ6cPva+KolIVdipndZOPRTi1+EyEgbjd0mrsCCIGhK5zBFVyi
	ECsW3m7RZ6S/gE57i9bgOFMB5PKI66BobP+xJ3BVZLEt1Hayki9F7YYf5QegKu3RfFUM+FKNpNJ
	J8em0nCALEotaueYswgvCbqD6tsTj413Ru4dsbq8ET4wOXJt7T5PXn/8HaxIPMunfS9xW/TLHcQ
	==
X-Received: by 2002:a05:600c:c493:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488996da0e3mr265541685e9.4.1775635512667;
        Wed, 08 Apr 2026 01:05:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488996da0e3mr265540995e9.4.1775635512078;
        Wed, 08 Apr 2026 01:05:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a65635fsm507702835e9.6.2026.04.08.01.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:05:11 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:05:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, 
	Norbert Szetei <norbert@doyensec.com>
Cc: Norbert Szetei <norbert@doyensec.com>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Villamil <john@doyensec.com>
Subject: Re: [PATCH v2 net] vsock: fix buffer size clamping order
Message-ID: <adYLmNh0_pT4jd1E@sgarzare-redhat>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
 <acuKUpZQq6z1DY_n@sgarzare-redhat>
 <102981F1-2CAE-481F-8FAE-4F3085E25E89@doyensec.com>
 <69317E49-40AA-4985-8A4E-447C58665A68@doyensec.com>
 <20260406173702.56239557@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260406173702.56239557@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276339-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85ADE3B8BAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 05:37:02PM -0700, Jakub Kicinski wrote:
>On Mon, 6 Apr 2026 22:04:26 +0200 Norbert Szetei wrote:
>> v2: fix indentation/whitespace issues in the previous patch.
>
>This is not a correct way to submit a patch, but please wait until
>Stefano responds with any further postings.
>

I just replied to one of the patch inlined in a reply to the bug report 
suggesting some changes.

Please as Jakub suggested, send a new version with at least the Fixes 
tag, but follow the process, see 
https://docs.kernel.org/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text

Feel free to reach me if you need any clarification.

Thanks,
Stefano


