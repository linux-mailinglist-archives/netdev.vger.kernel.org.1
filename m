Return-Path: <netdev+bounces-253620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B0fQCEP6d2nlmwEAu9opvQ
	(envelope-from <netdev+bounces-253620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:35:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D218E36A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF553300461F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23F330FC12;
	Mon, 26 Jan 2026 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqIj4iK1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8QSgVrz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285E30FC08
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769470528; cv=none; b=lrC9SohXIgCGMtpMy1ue5BQA1fNzrzX5J76NxEUkd+0R9l2XgtTIbhKvZd8TC0HLOMNW1H/bLsgvWMMrm/xYWtBqZnuX2Y9ayo77ySDJ4CF3QW8pltqpbO4vtPY4ll6hfwDc4LGQ1R2JL4XRfPHFmOlzk1pJG+kSxQ+VrZ4hrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769470528; c=relaxed/simple;
	bh=qnb5LBQI7Vm5bizve+7iWP8JE0kKDxGuA9Ev6X3Wjmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QqMEOw86OPABzRhGcHSkW7yK3QkXqOLzXgfE3paAU9Sbldpayhpz7rQGUsApJJ24be1G8+LuXCMIZ+IbIe3/KK3/hwKRDf+a1kA78JHzSEYy7Do5syuqj/WI1EGmoVp+Jx9ahg7RIx/66RivXXZxVZxWR7VAGmBuGUaJZtSJpQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqIj4iK1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8QSgVrz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769470526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/driKKzzFwHxyVCCzLpuFXIDKP/GnRcGSdVsdP9480=;
	b=VqIj4iK1g6d99ocltpTA2ouGh3GGQ8QogVr9K7Fvaxoc2kAFYgOW5K8jO+DCyzhlnRiHm1
	HBcn1VG7jIRtEpzB9I8dx0wayYXr7mclVFwzj5F4HDuS4wUBYcqM7a4kGAcYVgtvhK75Ic
	7jcc7dnk8GK1qLBK9yTUV8piqhBkq8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-HNKFU7TNPE6nhv1Lfr5fhA-1; Mon, 26 Jan 2026 18:35:24 -0500
X-MC-Unique: HNKFU7TNPE6nhv1Lfr5fhA-1
X-Mimecast-MFC-AGG-ID: HNKFU7TNPE6nhv1Lfr5fhA_1769470523
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so53415665e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769470522; x=1770075322; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/driKKzzFwHxyVCCzLpuFXIDKP/GnRcGSdVsdP9480=;
        b=E8QSgVrzmB1maShHlLtqRER9aJuAfpZLKXqsCyzI3au2QunFRVWvRD9GMxkvzLt+oL
         sxrOMLQmkc9GZku9b1axm4M5N6pHqBiwjcfsOuIhEyCevOzhLPR/g09pI7hRtX9POEH0
         2WD0O/e6KhVmp0gS5SgOg3mEUfVNnI2AWJSKucWkRmGshYTLYuqbvnhU9bPTWsz2fEn+
         NDZJC36qyH+YSsyqREtmBdK24yB9/xsDItwGddi1OU9g8cvMj2AtvIFzOoPAl+BxbIIw
         3G67mcjE9OTJnRIcYJiog5Qa8fH+I7Bik+nYij5RCWdAdM9UcH72Cly7CtuqKkH6+3UK
         3JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769470522; x=1770075322;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/driKKzzFwHxyVCCzLpuFXIDKP/GnRcGSdVsdP9480=;
        b=Cjzc6ZepIcSLCZECcqePFn1oNFOlse10CGOuhYY3RKHDmnvEWmpFAzmVbjuMjUDKK/
         L12X5Qo1K1gNdL1YwJm7dqe2vjqpPeokGytQGApf7le39bMgX4YSJsKo1nrk13hvaNnU
         T2oZtqdvC+WODO8bxb+VDua8Nm4aA7NFUxzcKOIFIJXmxTHfqR7POFaBHSsSuel6JTGj
         PW/wQpCXhaIREIaTIFRtIcxIFayB6gNRjj1UbUnVH+oD+QdVqsMkJwjqjxqUgIiPAr9a
         nyS5EGHUuOt1OSkNUUqs0+VYsaj4LEBoRCE6eiqJVaYzy9nLNoJ7+Pbq/ht0WSA7ZHbz
         YUmA==
X-Gm-Message-State: AOJu0Yy3Gjdy+aBp1wodeIwmvhWhiZL9TGOOXx0nHmSJ5J9/h1NMo0wc
	5FJMISKgl8LbSpRgd5qoXW4ilVE6OVIgOdYl5lVEmuJAnDef2TNxCqT0fvUiR0eNPZSr4bFlxV5
	ziWl1ShcIznJ9mjnvYCcrVQMBA7DAnMMnNCWBr78TTwrLahPfeupP3GdPH8SP+4Ayeg==
X-Gm-Gg: AZuq6aIPoHOSNiFhJPK+eSFfB0gsQVWgp9sQsBnhU6rN8yOjQyhvEgxoEqJZnAtIewv
	o3r6lT05gFb71src8u4Qau8jBKDhNo3ESfmcX/R2apN1FIHCidm9L4FhB1wijDaStOanAuwhW6X
	zApBmwoGgNvucKnQtg7ZQk5yc71o+SwG+fPScr7aPwmjzaDN2WdSbyyfvF1ZFMXVwyvHMMz1qyN
	TZFw58zBmBGFh+YD5qivd38Z1rwwCA3EvEJHeuYksYAAZl1pXZO1G3UMT+IGTQ/RB3UqLNony2U
	wlEszPkoDA5HWQEo+7tXvUDxuNwJs8IU5Gdd7PKY5ZL5zT/t5RnHZNV6sPWBZp5mUq6sEEan8HE
	eLQNyYgwqQGcK7mDRPE1Edj+2HwjLTDCnRhWmB5qQhOWxVWo=
X-Received: by 2002:a05:600c:34d1:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-4805cf6725bmr94192695e9.18.1769470522322;
        Mon, 26 Jan 2026 15:35:22 -0800 (PST)
X-Received: by 2002:a05:600c:34d1:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-4805cf6725bmr94192405e9.18.1769470521967;
        Mon, 26 Jan 2026 15:35:21 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e715d3sm33764977f8f.28.2026.01.26.15.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:35:21 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support
 handle multi-descriptor frame rx
In-Reply-To: <b0bff7a8-a004-4eb7-bf1d-2137182e59f9@lunn.ch>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
 <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch> <87cy315lru.fsf@redhat.com>
 <840fd286-779e-4130-b544-913116c97a29@lunn.ch> <87qzrdecs1.fsf@redhat.com>
 <b0bff7a8-a004-4eb7-bf1d-2137182e59f9@lunn.ch>
Date: Tue, 27 Jan 2026 00:34:52 +0100
Message-ID: <87o6mgeyn7.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253620-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96D218E36A
X-Rspamd-Action: no action

On 26 Jan 2026 at 03:29:46 PM, Andrew Lunn <andrew@lunn.ch> wrote:

>> > I was more interested in plain networking, not XDP. Does it perform
>> > better with page pool? You at least need to show it is not worse, you
>> > need to avoid performance regressions.
>> >
>> 
>> I retested with iperf3. The target has a single rx queue with iperf3
>> running with no cpu affinity set.
>> 
>> |              |  64 | 128 |
>> | baseline     | 273 | 545 |
>> | pp (page)    | 273 | 544 |
>> | pp (2 frags) | 272 | 544 |
>
> So no real difference. That is unusual, it is typically faster, or if
> it is always doing line rate, it uses less CPU time. That might
> suggest the page pool integration is not optimal?
>

Thanks Andrew,

I can't tell, but the same numbers were a little surprising to me as well.
I'll spend some more time on this on my hw.


