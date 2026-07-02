Return-Path: <netdev+bounces-304029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1JqPLWIfRmpXKQsAu9opvQ
	(envelope-from <netdev+bounces-304029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:20:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D26F4B77
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:20:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BNfTfm3G;
	dkim=pass header.d=redhat.com header.s=google header.b=DyJcbn+W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304029-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304029-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B5AC3063402
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E215412283;
	Thu,  2 Jul 2026 08:13:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8593D4128
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 08:13:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979991; cv=none; b=KLZrPQyLGk7Gt02fSUiv2u5S8L5gOyMspzSJzfomddJZH0CIxkAx6S2DpxUHdrlTz01pZETaG6LgQD4Ph1wIO/6s8t5yWJ2tcWaDuLViJdBAb2OgEtPl8ZVKGrY2CU/etr+/VRBHO4RhnqI+LCrhy21wjFwVLOYegW4v9z4K438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979991; c=relaxed/simple;
	bh=yKgsiBTlWpyhIBqLdGNB3VUXLncLIeflsLghTkT7/dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7QWfSSqVeGVAuC7dfUy0JGV53CcU1Ft6ayxt7Suja+m0pVryzhDBBk86PPYflgob29Nzvxv4x3X9Ud2Z6nklu8DBY3qmCgPIPGeWqhEB6shQhqwK5re0RUZoIETD7ZZN2a8Ky04gYHLDmVyRVs1IIFGx5tc2azmuQMFU960EdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNfTfm3G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyJcbn+W; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782979989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pdGhHss3Xqen0DZK9pAzpW664RhJzQOrMrPN6SM8ho=;
	b=BNfTfm3G3amILqsQ0Biz6Y+lljm+1QWbksNhq8CgRZFjl+br5UW0kcdL52bz5AvaP9EfpG
	nwyBpDVcDefPYAkJPv0mqLO7xANb1RegmIEMAgFHkL8b+92Oabq1cjF+iErXueSYTHiSVy
	cDuVWd6siGcJyiF/M7Z3OIxjVxUgTAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-SOBdmN9JNR6VBLFEMWq8dQ-1; Thu, 02 Jul 2026 04:13:08 -0400
X-MC-Unique: SOBdmN9JNR6VBLFEMWq8dQ-1
X-Mimecast-MFC-AGG-ID: SOBdmN9JNR6VBLFEMWq8dQ_1782979987
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bf840a69so13836845e9.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782979987; x=1783584787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pdGhHss3Xqen0DZK9pAzpW664RhJzQOrMrPN6SM8ho=;
        b=DyJcbn+W1N285Uv9So/XSysyhnMcKCtZs7t0Sq2szf9+BnvgLdXyKu6tt10iZibKVC
         7wWKlu9iYESPvJ1D+aDN/yMJET9rRyb13DUY5vUbH7oLDIiSBYRbbBr1q5syL1svOuny
         mx/8oZpbaqmIOhFML0wRJWA1lr1F+ZN7YDtidsq97YU+aY3rqDhtvHcmMtLLEKxrPItZ
         1f/dJFbf+07PVVhzy2n/65E1gVI5AZwmH2jGodYXZZfYKJAYZkVRvlsK5zci7BI9VnJM
         LlKG01h/yOmgdIRnGyeaxUdpuJmf4ZIy449TMT9Aoojhe6EgFtiWPOwk2UrnmB+/eFbv
         KjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782979987; x=1783584787;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pdGhHss3Xqen0DZK9pAzpW664RhJzQOrMrPN6SM8ho=;
        b=Put9kZC58RPk8uGFcEfwDJpw7b/XrZ2mP729G9Oqpq+5lg7vb5K0TbirJfwqPgXmgw
         kr1HrwflHrOYLuIeAH8L50xWYlIwxVgVbopoC55A48W6AIO9LWbspl4EKFbgMWxsRNXn
         mxiXkZc0FIYzQMiJJy1UG7XcXyVtK3Dz7Lp8sPySjXEZa3aIA3uy6SZg3u5J32/U16kq
         5JwDKD4lqfoL780NOiL4BTgCq0MGTyxqcrqvkkiL7JwUT6CH2CYNZ7whkk+4aFkeA473
         a9hHVklKl9FB1KOivKvn8ckxoNHpbC3tpWOkv6+l37fecu502dZPcUjRN70AMIhJvQB7
         V5fQ==
X-Forwarded-Encrypted: i=1; AFNElJ9O4DL4YzJ9V43+FvBaRQtTz2CIQDRL+yZpcmqz8+Uxw18T/aCoVUmBjgN/zVwXPGsJ3gikCvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbSe6nd78A0e7z/SCpV9JkqhghV/dJUkqY2ckmkQnmybeKJxy
	jatOpL4AnUvtbBI0ZsJdoGJQDniK+H9QJhzB0dk7hCCHC/UWU+ELkJC6LNlLkWfvUbikvXu+xvr
	DHiMu/L/KUTs0AP8W7ZPM5+5pnJmrkzbp02A3t2YNl/HjF53P5RCZLSls3Q==
X-Gm-Gg: AfdE7ckU/VqzTmbDPgQkDIWYLiZaBt8vOHQDMNjbUSrPmh1rZhMThKAxD2lOBmTibTz
	Vl2BT90VID9gMoPVNL+7GBYTvnBT9OahkODV48bLAVLPX5mg3v+hPy+QOFZsg4UVhKj3OmcqU8k
	UbZRquWg7beW61NwyOewHrx09rcWPo7sTL6Nz6NCxu0a/EW+DradzXfveXW6l9zGrqalLXSj0Ga
	rKoBEAsOMXgmg9bH/xVapl9DzHG04d4QmTJPFal204NQepi0EZK86LH8SPMgDWmTHpAX5GNh8AW
	cc3QwKS76hssT90oV1Wushe868hijrqSPhM5etzxOdyNtNp7qxNtdB0772zMgR2LWI3/j6D2Qui
	w8SQEYwUWjJ83O3uZoiXR5ib7ujHY3+79Q5N8d/9n/rDebPWiLtsOVY0V89WGT/j2W0dmoNOoqF
	PJrKEAoePDsA==
X-Received: by 2002:a05:600d:4452:10b0:493:bdde:e400 with SMTP id 5b1f17b1804b1-493c2b38c42mr52782925e9.4.1782979986847;
        Thu, 02 Jul 2026 01:13:06 -0700 (PDT)
X-Received: by 2002:a05:600d:4452:10b0:493:bdde:e400 with SMTP id 5b1f17b1804b1-493c2b38c42mr52782595e9.4.1782979986414;
        Thu, 02 Jul 2026 01:13:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bf11eba5sm77231425e9.0.2026.07.02.01.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 01:13:05 -0700 (PDT)
Message-ID: <11c0ee2b-96ff-4e27-8688-485dc4605f58@redhat.com>
Date: Thu, 2 Jul 2026 10:13:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] pds_core: fix use-after-free on workqueue
 during remove
To: "Nikhil P. Rao" <nikhil.rao@amd.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, brett.creeley@amd.com, eric.joyner@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com
References: <20260629200358.2626129-1-nikhil.rao@amd.com>
 <20260629200358.2626129-3-nikhil.rao@amd.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629200358.2626129-3-nikhil.rao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304029-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E40D26F4B77

On 6/29/26 10:03 PM, Nikhil P. Rao wrote:
> In pdsc_remove(), the workqueue is destroyed before pdsc_teardown()
> is called. This ordering allows two paths to queue work on the
> destroyed workqueue:
> 
> 1. If pdsc_teardown() -> pdsc_devcmd_reset() times out, the error
>    path in pdsc_devcmd_locked() queues health_work.
> 
> 2. A NotifyQ event can trigger the ISR and queue work before free_irq()
>    is called in pdsc_teardown().

I think this should be 2 separate patches.

> @@ -121,10 +122,16 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
>  	qcq->accum_work += aq_work;
>  
>  credits:
> -	/* Return the interrupt credits, one for each completion */
> -	pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
> -			      nq_work + aq_work,
> -			      PDS_CORE_INTR_CRED_REARM);
> +	/* Return the interrupt credits, one for each completion.
> +	 * Use READ_ONCE to get a single consistent copy of intx since it can
> +	 * be set to PDS_CORE_INTR_INDEX_NOT_ASSIGNED concurrently during
> +	 * teardown, and skip the credits if so.
> +	 */
> +	intx = READ_ONCE(qcq->intx);
> +	if (intx != PDS_CORE_INTR_INDEX_NOT_ASSIGNED)
> +		pds_core_intr_credits(&pdsc->intr_ctrl[intx],
> +				      nq_work + aq_work,
> +				      PDS_CORE_INTR_CRED_REARM);
AFAICS this does not look safe.

A concurrent pdsc_qcq_free()/pdsc_qcq_intr_free() may free
`pdsc->intr_ctrl` before setting PDS_CORE_INTR_INDEX_NOT_ASSIGNED.

I think the teardown should:

- disable the IRQ
- cancel the work
- free the structs

in the above sequence.

/P


