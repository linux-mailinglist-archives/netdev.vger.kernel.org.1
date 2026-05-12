Return-Path: <netdev+bounces-287072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOYoKE8BA2rdzQEAu9opvQ
	(envelope-from <netdev+bounces-287072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:30:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 098EF51E935
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B13B4305EF04
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00156349CD8;
	Tue, 12 May 2026 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaIlfS36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174C277026
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581716; cv=none; b=t4m7hz7o1T6M9jDun98eFkLHFNbKxDvNEf3OhaM7OlKVQs8UQ9aEHXovCyweUjnOFHfrX+d4snZP1x0FIKoihcFkm/wONn84CkXyXkN+l9mlZ8LJUNIigFGroz8248TQ/8rS1ELA+pquEHx1qYV/g6lg/3eEclHBlhNtAJpwF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581716; c=relaxed/simple;
	bh=NaAMaZ0bKG71oaPj9HHfGmZV0qYFxCPtr66OS72Tnok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKcwSy4ai7TGextcJy6HxB0WF/C2gS4MdDTzg0NyXkBnN8+YYUDTIgFHnsRw51WJ9ifEekb/Z1ohNYKfLxLLRDmeWjfVXuOGbdIq9K/4j0gnziC8V9gwkFfo5qid2EL5mJvEV2pyi8cq0EiNgLkG2GE2MMVSEib3z2zld6Oehoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaIlfS36; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so56709355e9.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581712; x=1779186512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+rvi2uDnDxh7KewyaG1ZXvW90bkNCNdmlZWrmTYFyI=;
        b=BaIlfS36ZR2m73RKwDHJmmZYROP+UPK0ignZ6SneDb8Yq8F1e21p7AX7E2yer0UqmH
         9KEniKPuUBtt/uAO0eWagS8ekUZYG5mWxggyVFRjRVRJUhgy45z8KvTZiot02m/s0xq4
         zOBhGGroa+SYugSG+8pzwtWy2V05Rh+/dCFiaX3nh28J1GFwB12oYpgkSVosNOTBgYi3
         QiUi0GfoMsaGdjnusr8c0iHNmN/RnZs9dRPeMBnOhcB2DfPfw+vhZxyM8fJGxiYD6VoX
         sI7sp2Zm0PYbJBiTZ+Ve5ab7j0ezIDjMUMKdyB3jMVTurmNQd64qdH+D6SEo4bz7Fbdl
         ptCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581712; x=1779186512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+rvi2uDnDxh7KewyaG1ZXvW90bkNCNdmlZWrmTYFyI=;
        b=F1jdgTjTIhkcKh+hOYxzq4dV4kO6QxOfDL5eQA6laZDYu7iNx+gVWhv7OI6jXLDdzw
         0QbCeigP1YjDSrT5s8F5hz3/O9slpzXpI4LrlxSmWU5UaJtIdnMf7NNqetEXFPQYgmqz
         weoQe6HYzVZaEJ6SUz+4ilG5QUtqldsnXrJwZgLLKPX9Yc3Pzo/a462HUCdoGK+T54jD
         PquuEqsMSxD34Kux0AitMMBcq1ofHw4GJaQOrrNEcCaMIcwm0HrpQ7tsCVt28taLcprM
         IUZMQLxYbtx8zLWMHGSvF0IUxqf+02b6V1pWZxxe0OinW7r1XNpyQdXwVRdO8pmIgsbo
         nwfQ==
X-Gm-Message-State: AOJu0YyWy75MF0/bOFuMclM8HWLfwr2ZpYXdbgZoo/MnpeTcydQ7ps64
	CvmzS4HFgg59LZtnAkXQ3+kWh7Txxl8Q5PUgAPH/vYQ/I+s4dSU18703xT2VNw==
X-Gm-Gg: Acq92OFE89nJBuxeP3aHfsQPYpCnPkEV2ShAUpTbsU5Z6fCkl6vjl7IczwJT9QamKYY
	kYVBKRjzCZTurozR2j/KNsl9Y8tKcj9YL9cSlWfL9PkCKDusKcFPQvsLjGKeGj6woGJEc2HHDNC
	k/PO26g0FubaTR9Y2dY0QsXC7Y+uogn7gBZnVk6zAOy0kSV8Abw9haSARswbq8P0LAP2897elZG
	RYReV26t5vDvHRpZYiwrOD7hhU/OinDIQcDI2h6RJFQlEDauTNFeoe33M+uMByoqtV8P+ddCf7s
	qwoIrRq3fATmGEGvagnDKGY+0AurdweArRuyPmfSUmBam2hyk5hOUfEyLGAAZvM5hzCw7LGrC8A
	awIb2D8jphxhaqZ9X79DGxvkoU1y4wlZMYdr9FmSfIDafBiwXgNxdmaRQtXXIEkmLvVn9EpOM9W
	D9RUn0gRZQRtDJawbwgvrxLdokAcDz1N/s1u5kgdbVfJAlBpRsmbMYZIUbMA81hFSQkTXepond5
	ZWcLVenOZanAN1uR0100RnQ1Ecp6itix6GwnR5FTDG41BSatA==
X-Received: by 2002:a05:600c:548e:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e8fe774d6mr35255135e9.17.1778581711685;
        Tue, 12 May 2026 03:28:31 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ba2aaec3asm1285744f8f.15.2026.05.12.03.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 03:28:31 -0700 (PDT)
Message-ID: <a9600af1-f9a2-466c-8ec9-d0d437083f4b@gmail.com>
Date: Tue, 12 May 2026 11:28:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/6] dynamic area addition
To: io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <cover.1778581283.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1778581283.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 098EF51E935
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-287072-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 11:25, Pavel Begunkov wrote:
> Currently, the user needs to give memory for the data upfront
> when registering a zcrx instance, but it's not always easy to
> predict for the user how much it will need. This series adds
> a way to add more memory / areas at runtime.

There are some tests in the branch:

https://github.com/isilence/liburing/tree/zcrx/area-create

-- 
Pavel Begunkov


