Return-Path: <netdev+bounces-269394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APEmLu3Ou2mXogIAu9opvQ
	(envelope-from <netdev+bounces-269394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:24:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBB02C96DC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36839300BCB0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB6136C0C1;
	Thu, 19 Mar 2026 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZZ2ypJZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iESOMyTY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B922580CF
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915773; cv=none; b=K21N1+2M5KZ+N3bOGwE4mUFBtw0WDzAh8goukJDNMBSFKeuoY0AtQzkKHPb+R/XsbAbXRXVyvtYGmK8tHYMFuNqI1IopGwKEjvyITy9o4CemMRQZqTxirhIorvlIlXZolkVL4UoBroqZprjj3aSl6qjQXMxl7zchlOb6J70Ohes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915773; c=relaxed/simple;
	bh=jI3T4fyaHJI7Z6XuDHJkgpVgH5BlNdf8DNKrN8B7PzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STLUhhoxBtmgKEup05hI/rFIIPNF6PkV4QZLPGGhK5aI9062b94SkWvm8y/4f0JdGAOtBLFO8q4Gnu2vETIQDqCu4BJ51ucQyPLU0xeTBTaLTU9dmN4JBcgp27Q16oWuu83MF4Oz9fCqV9gp+C12MPPOYibF3wBhpKNK71PLUrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZZ2ypJZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iESOMyTY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773915771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wR/FecceBEZR/0EE/23yp6rr47owa2Fbfb4UxboXmxo=;
	b=eZZ2ypJZeZFqjSzjoyvSlyjI8lKlcAFU/xfwb98YjEtGVzsn17XtuppUWr6GYxz0UH4x9t
	1J7VomQDk5PyKIrm5KAQVLD3iYJQSF7mktQ7+FIXQ2wXJdZcJHNw/7Sd14nSp7VfCeEGxj
	+9GI3plT1fFhLzZlNrptABHUwgwg2Vo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-2vL14ep_OGSVOPY7Hf0Hyw-1; Thu, 19 Mar 2026 06:22:49 -0400
X-MC-Unique: 2vL14ep_OGSVOPY7Hf0Hyw-1
X-Mimecast-MFC-AGG-ID: 2vL14ep_OGSVOPY7Hf0Hyw_1773915768
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fb142205so4175895e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773915768; x=1774520568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wR/FecceBEZR/0EE/23yp6rr47owa2Fbfb4UxboXmxo=;
        b=iESOMyTYksoObvFcqstvFxcykWzlrXhnY2Sz5gzqsIEaZciKIBXLMF5hn061STe0xS
         A7dmjd8GJEHWR1v2Hdz7PMOU1NDZ6LE4mgpe8+NyurKvIlDNr8Z5mHfa9wJLr4iJY/jR
         Taj4vpBcAboVqvCMTFuJ/Tc6lj0GP5d3QBNRENGLiVTjDiBscKnH9tVYMzCkgD4eNzIo
         8IlGVuEwGB4/5uU/L3hb8LvvD/eMC29rCI/E24vSr1P8mmuLMhd3mc0rkwyv1FbnGHLX
         u9zgLo7W0ZyFM2/pfDf08Ytq6RtJCUrF6PUHm0QuYLtdNn5AETigPTaKfpe0+OGdOQhR
         vynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773915768; x=1774520568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wR/FecceBEZR/0EE/23yp6rr47owa2Fbfb4UxboXmxo=;
        b=lXduwpXs8NfOquHSSnJtPw4ggp0HDOVCExBne7eZs4dkNOrhcJwSYWqZsC/JUr1fA8
         XT98/MiVt0EKjzvOlFFEsRks5KFYSFEh4LNSk2BxQlj2PnxunLU8ktJfRNYCvYBr89B/
         CgZSEHM4Q3/Y956M9xtW3k3EXp4sq3/AiJfz3ZMcDEHw48xUrnUwBEyKky2T5PwWDqN+
         DVGRs7fnPMmABZEvj1+9uXIGzhk32RVGpQTo5/ESG34dsoWNZonnsyjwOiGjcXtFx1H+
         qpLA1BPubYDEx/6T1+gDirk343zTH0VZWoNHV03qxmFvx6jfBI9s1WjUPezivS2MVKmg
         zseA==
X-Forwarded-Encrypted: i=1; AJvYcCW4PfnkQcr7u976hHiUZtdHxHpqrizofIu2R+NttFQdT3S352KMYMPJl/3DSIfIfM7aSweeyss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUz/2tjMaMD1IATzIrFH0XFayvB7eF/7952J8QlMbgg5WxOZgm
	iyKVSzxI63biei8I9HFlt/VAvDuWf8J2YP/+Lvx5UUppOYsWhfLWIO9dS7LYQLA8NjuC/w61GQi
	SWS2yKtg9hF4K4amZGyd7aRt8ydbdWmQJBvogAKkblFvxmgDsbdsT74CkUQ==
X-Gm-Gg: ATEYQzwjmXCVkIfUoaSKEa7MdCJNYGXvk5kmYAVWo4ElggQ2CxNQ0kSIrahrI6aZ2dF
	jgXYe4WZchGUHoKJNhgjbkwP0UtqfDsY92OWj0+uZbdKzYc2gKTKGoR4k7vbfZg09LpGQ2K2JzW
	Y9ad+r2KqS8lCHrX95EjsUqwCxeZKt0ML57zx7qnmQwU2O3FtRWFHhHVPKb4IO+ADfpHfuxKfJD
	yPwMtXGKGQDuIVb1XRRq+Y5UOa6/I+jhyMIpbAglnxeoSMNpkprUJddNFrCt+R78ol3tniuMivR
	wd9leCc4gKZ/OxPOMuf96WNgIm1Zxp3oDue6k9Lne1bR7POo1/563XFKCAXtX/qdad0meFM/E3p
	UciEnNDt6dGrqL8+afVwMHEZNkQqnapMNLzW5GxegRHT8ALCBIPlA6Bq7
X-Received: by 2002:a05:600c:4e4a:b0:485:ae14:8192 with SMTP id 5b1f17b1804b1-486f442d3d1mr109792125e9.7.1773915768389;
        Thu, 19 Mar 2026 03:22:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4a:b0:485:ae14:8192 with SMTP id 5b1f17b1804b1-486f442d3d1mr109791725e9.7.1773915767939;
        Thu, 19 Mar 2026 03:22:47 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fbea40c2sm32983445e9.5.2026.03.19.03.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 03:22:47 -0700 (PDT)
Message-ID: <d0ab8cc8-f734-47d4-b402-9c62ae563b4a@redhat.com>
Date: Thu, 19 Mar 2026 11:22:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] selftests: packetdrill: stop pinning rwnd in
 tcp_ooo_rcv_mss
To: Wesley Atwell <atwellwea@gmail.com>, netdev@vger.kernel.org,
 ncardwell@google.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, kuniyu@google.com, shuah@kernel.org
References: <20260317065137.1533226-1-atwellwea@gmail.com>
 <20260317065137.1533226-2-atwellwea@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260317065137.1533226-2-atwellwea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DBB02C96DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 7:51 AM, Wesley Atwell wrote:
> tcp_ooo_rcv_mss.pkt cares about the OOO SACK state and the resulting
> tcpi_rcv_mss update.
> 
> Its exact advertised receive-window value is incidental to that test and
> can legitimately move when unrelated rwnd accounting changes adjust the
> ACK window.
> 
> Drop the hard-coded win 81 checks and keep only the ACK/SACK shape and
> the tcpi_rcv_mss assertion.

I think it would be better to keep the test updated with the kernel
behavior. Having the pktdrill tests bundled together with the kernel
allows for tightly coupling.

@Neal: WDYT?

/P


