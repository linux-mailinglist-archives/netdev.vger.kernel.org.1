Return-Path: <netdev+bounces-268120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBxWDAPlt2mzWwEAu9opvQ
	(envelope-from <netdev+bounces-268120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:09:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 571542987F8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C2BE30091FE
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F24274B2A;
	Mon, 16 Mar 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qyeza/+2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5jsB+My"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3557276038
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659384; cv=none; b=NAP+94xJ7FCm/w72+u/zRgTvVYzs/s73Q0dBhmOm9UZFBMcxYr0PJYQnEIrbjnHw8vHPnOV172k2B5afEd7mou2jStojOm6uRTPjZqZtEzPL5fo+I0naRIWE/csWioqZW7EIa8T45+yh5WMAoDcsXQE1N+d8Jfr2L4klqdLH4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659384; c=relaxed/simple;
	bh=4jmmhwQ9HX1nE0wu5X/8gnKDvmvDMxjNyuG7KPrwFyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/HJLHKklW/0Bh8cdsXtTtVNDfTJqZXTdmfGDVfLxrtiTfri1YBF4boEJsf7YNdYtlZsMvaoiVlv/EiqaCnH70SwNOyzhRQd4R3uhssUQLOiBXuECMTRwgNdPK2VppGOfhjHGyDdvbYMOCiYc6v6m+WvBLr1mpozbKxQ8SqPxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qyeza/+2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5jsB+My; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773659382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
	b=Qyeza/+2JrHj9NaOOXPC3kONSzujOzKH4H5ea12Zel9zhcMjPD5TKNiNRQu2WMHt3CFys1
	gYr80rl1C/rGuXtzTp4t/YDjSlKrW2g9PERiUXY/Qj8juPOQCC2RFBzZ89bVbLk9WSjaJs
	2kZrCvfdEsfNFMbR6IOGtymiczNl9nc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-e8TD3jfFOjSoimgYc7KYXg-1; Mon, 16 Mar 2026 07:09:40 -0400
X-MC-Unique: e8TD3jfFOjSoimgYc7KYXg-1
X-Mimecast-MFC-AGG-ID: e8TD3jfFOjSoimgYc7KYXg_1773659380
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853efceaddso39619215e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773659380; x=1774264180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
        b=O5jsB+MyD6sJC+l6b03wAvwt7tXz8urJU9RoS3N9L8GF8NOllShcElCiYg3oL+7VZh
         5wUZyiUB6XRd/GB34dSMZfNjpeE+uLDyvE9dLyhg3hL2iQTbuAFodOZuurZsxxAMj/WK
         7M7jYjlvIM/tNYepfeDM792Z2i2W4zNQfdfhLO3HRvtivM9WjSWh5GC7x+F41w+PyI/3
         aw9wm+7blFt9mDXpRC//SWUeCvR3MmT1DS3g+BeclggYhhKi6tqEEf2N6t9hp8OJ7MrT
         JvdKPso4FPW2gyZEkPO25DeWwglcX1rG6jNa4W+kC0wo7PQyxpWXnAlCaR6Ns285aA+d
         cFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659380; x=1774264180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
        b=UGLhPI1+iGl2aH7LMKq+BnIOoQ3UHGjReqBUlm6bYryO769AUnCGKhSl0hqROGPZuq
         DLvgE0MqjcMmTRDrd4s7nhGlc2a0e3JKB6BPT1CjN0Xrp81EvBrBms/KsmwmVcCYE7qE
         NzCeMA6bgNxCx6/3YTs5ppsU9IVXF2OeMhBbWyHaOnF2U6F9QcR3us8sVipHvQ20Iwo9
         YxZ7CZjXo11LCw+8bFOEqH6RZJwu83aquPnkeN1lnXkbJrLz3JcrEq1aCqMIrZXVN534
         DlMg+MOH+55o9IdgtzIAfid5y6GekCAXUsSW4257NvIKTKQC3W+lOhjnOG0V9vO8fSTo
         gjhA==
X-Forwarded-Encrypted: i=1; AJvYcCX8drGyrxFotSj8lxMvWEvxuksVjDNYNHOa+p3e5XsP+D9H8SYd56D4+QSt/CzbUgqMzngPfr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydY+p2u1vlszSE8LwBtYqiniyUl4mmTJRxApd47RtZ7M/c1Wbb
	WGjh50Tx/5VZmeIEZzFeNvrdrcVKBNz2VdbkNuyoABd9TH5iFeHJzRN2espc059gkAowdUiXBlZ
	zyECTkD92Hto2SqUpQauTyWP4URGT8pSO0GeEYfuUBpEjgpXFd1JFn4MqhA==
X-Gm-Gg: ATEYQzwd9cio17oxdl1FvKypFwe3jIM/61kZy3eLF4DkcRr1qNz4MRP2QslpOdfcRKt
	5peLAYk1o8L6ULHTrIPlD45+5GgmNSHKjPnCIYQWPkUaaX7Qqb+2xJ0Ln7M2UR+CkcTB0u8Kqo8
	0/zC94mhOtQq4f9WTTUbtB1+jQds3D2xRP0wEf6dJXSCHpEartPYVAGLZJjiNrmZIhgXrjcKN8X
	9/8ni6Aj/xA5l59bAdRlLz4EOUcm/cKjLdpfz+UZjDdkk1ocVW8aOzKknm7ZE/0LCwFYfCFYxiO
	rizroOkAbvlCEegwQzvNONZg9lBhFGiEtvAAAM5vN0GtqsmDdWk6Xsiqhw1AZQWdpX5gmGWcnIK
	MMWz6csJwIL3hMR2zo3MlAKwcKvldEIk64xgdw9HerAMVKLen86bOrLY=
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr211854925e9.19.1773659379628;
        Mon, 16 Mar 2026 04:09:39 -0700 (PDT)
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr211848875e9.19.1773659374904;
        Mon, 16 Mar 2026 04:09:34 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm1212991845e9.2.2026.03.16.04.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:09:34 -0700 (PDT)
Message-ID: <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
Date: Mon, 16 Mar 2026 12:09:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
To: atwellwea@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 dsahern@kernel.org, horms@kernel.org, kuniyu@google.com,
 andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 skhan@linuxfoundation.org, corbet@lwn.net, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268120-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 571542987F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> From: Wesley Atwell <atwellwea@gmail.com>
> 
> This series keeps sender-visible TCP receive-window accounting tied to the
> scaling basis that was in force when the window was advertised, even if
> later receive-side truesize inflation lowers scaling_ratio or the live
> receive window retracts below the largest right edge already exposed to the
> sender.
> 
> After the receive-window retraction changes, the receive path needs to keep
> track of two related pieces of sender-visible state:
> 
>   1. the live advertised receive window
>   2. the maximum advertised right edge and the basis it was exposed with
> 
> This repost snapshots both, uses them to repair receive-buffer backing when
> ratio drift would otherwise strand sender-visible space, extends
> TCP_REPAIR_WINDOW so repair/restore can round-trip the new state, and adds
> truesize-drift coverage through TUN packetdrill tests and netdevsim-based
> selftests.

The series is IMHO significantly not trivial. Can the end-user meet the
relevant condition in practice? How? What is the net benefit in
practice? Is that observable under usual conditions or require
exceptional circumstances?

I think we need a strong motivation to merge this kind of changes.

/P


