Return-Path: <netdev+bounces-289128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLKVGT9CC2qsFAUAu9opvQ
	(envelope-from <netdev+bounces-289128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:45:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C8B571245
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C71A302E7C1
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4D748C3FE;
	Mon, 18 May 2026 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hn8mHaf3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B548C403
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122681; cv=none; b=TwiliIFO5iGUlXsHQVTBha0O3dDRw6+6GbMRVJF1LLBtiZL3MKMT3ksCorwX7dDyNJmY4eTS7ZTwgypYs6oQFHBrdypJkzCugVbmIjNB0loF0MpoGuDesNTYT6sQgGTErKIJBSSv5OIR7SuTek2Nz3p3ePa9niGRCYGPdImQdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122681; c=relaxed/simple;
	bh=YE3HoIFb8FxWqSA+l6qK/mJkb4FDgYWDmcyId5B2F2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyUO46JM5LttBC9d38UAGn1BPth6Ow7YZIXywSfQDWz7K1FamW9oClOSOV23C/sWlT1LUfZBypE6AUeXcaPZSnmfIsX2elrvOQrvyHJ2GeFLWPXtOKQ6s6514NEa+hq+0xvW9SneECYkof/kXaZi9LeutA19ldINX4P1iP77SDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=hn8mHaf3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso18224475e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779122677; x=1779727477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UJetEPl8iEmaBxBdu9lhTExkMb01pXnVK0wWC0qPWM=;
        b=hn8mHaf3nN/G3EfwPa024Vkd8ONlhvOtFgR13hg6s3HBfpKyLg3EiGeajgfqb5LM//
         F4A1NE5/ifh87TIiq+vXf2rTQ3axPqO3W5i3xjGbeNFKjFxg7eSZ06xODR7nVuICYPEK
         HrpDkNYU3IbSWSw/peRlcTTqgnKOL/rxmyQ6fQI0NaVe4xbkK+Ozdmn3DOr85h4LQbgl
         uU8sYFaMxJFZJiELk/y9ddDlI9sWPVgENRvadCts3btR1xF5rD2W5qsCPGgIQhrmehgC
         WHFyzrmtB5P72wQABnR3Qni5pJRO5xsICPmiuLNrbFBthvZum1/C5Ho+p2OmSgTYB0QS
         i5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122677; x=1779727477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UJetEPl8iEmaBxBdu9lhTExkMb01pXnVK0wWC0qPWM=;
        b=b1n99NIZ8/PXo8/oMPuiRoe3cd8dD4e/UmLq7uFLrmZMRrYHYG9l6FJI3Rafl31iXK
         dk2F4BCnfUVW9QMqFILwCQFhT3eDwvPyBNr9yuAUxQ/eEihliPwC6RIJdGlf3R2GJz62
         a8D+wHdho41n/qQ6yEPYwfRh1dSNwQqTCfypwx7gIa1cRNyqRH0sRms7eiRLxS+0mzYK
         6QZKC48LGC1G8NICvQ5kUJdv/I/dgf5xHTRjNfVpkeKjSvFTy4W9TM+Zk3xr2w6O16o/
         gn12ZRk4jz/gweilPdmw/9Ylb/iHYOGv5dP7jE4BRApnY3ul4xcCGIwOuSz7VjPQkwR0
         xeNg==
X-Forwarded-Encrypted: i=1; AFNElJ9a1gYi1BAbjEMupUr8NhvWjMD0rfQ+Z6mIoZmWM+/v2mtAG9tq4yDltwMyk5OQPZdrALmZxBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60mGl4BQn/CdlJZt9W0o0lMWlgrNIhdhsHrvsfAl8JQ3dIDkh
	2vAThPevnWv0oDkQz/Jn5MvAIpDqADyzInOh13hy7D81q4WRc2KddtWRzDn0EbWKIQ==
X-Gm-Gg: Acq92OFFGCdt9diCZRaGZQWsZ/dKVe0X5/i2IBoDFDNj/tho42BZspYlp8wIhR5lbiW
	uwQwHrMuIGV/IqoS3Iw1TTvRs5Gc+hXE6mym86GQhumFn10u/2TO/fQYyrvS3XvphMMyDT8oYeS
	YfVSvxDBCRv3NNgs6Hyq4OjsxIa/WiTH7ogVRsRVGTF2Tytx2WQMh+mdMv60Sp4PUdenVsRlChB
	k5dbm/se+ZAgtNFy2QnlMZNkHqwPlVAT/qKsU3QuXuS01OrkWuAbQkE7Hjw35bjj6601vIlvZit
	KL7EeWKQQtIhQUsW4L+n+WCxZNSXfbW+TvlbbUH6SfR7u41UDcgqzMrZ4zZA8p07+PKSGdh7H33
	2MJx7z2/8+7JTpSO/Trp7wL1Q79VD5W8TJL/2EgB3wzdcQtc7ih20Np+ob/h2KdepQz64wbuDPQ
	Tq4fL9KjiKd/hT4M/QiZrjE8JFxBNZKD7SMw==
X-Received: by 2002:a05:600c:870c:b0:490:320:949 with SMTP id 5b1f17b1804b1-490032009f3mr115980855e9.27.1779122676802;
        Mon, 18 May 2026 09:44:36 -0700 (PDT)
Received: from [10.83.43.186] ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6aff4sm86122385e9.25.2026.05.18.09.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 09:44:36 -0700 (PDT)
Message-ID: <8ea0f79a-a8b0-4d1e-85dc-6f5b8fd3c135@arista.com>
Date: Mon, 18 May 2026 17:44:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tg3: guard napi_disable and pci_disable_device calls
To: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: mchan@broadcom.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <CAPzpGcTtw+ou+8jid_qE9w96UWt+4KUZXN-aC=44Oqkk=qdERg@mail.gmail.com>
 <CALs4sv3XH1DEB+EXmSjKvPz8Av-53HOrJ+Dc_mjOv+3EnnuV9w@mail.gmail.com>
 <a120c9f5-5818-4335-ac2c-caaf4f6f4fc7@arista.com>
 <CALs4sv2bNZkBvqKwSMOM5CtJG+GM8P6D6PMHWFJUqtNS4xw34A@mail.gmail.com>
 <CACKFLikhxsYc6zP2ksV4=_MwZDLC=6Q2rD9CGwEACKOiVgXBhw@mail.gmail.com>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <CACKFLikhxsYc6zP2ksV4=_MwZDLC=6Q2rD9CGwEACKOiVgXBhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arista.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289128-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurypm@arista.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:email,arista.com:mid,arista.com:dkim]
X-Rspamd-Queue-Id: E4C8B571245
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yes, mostly this patch is about adding a flag to track the NAPI status 
to avoid a double release.

On 5/18/26 17:27, Michael Chan wrote:
> On Mon, May 18, 2026 at 8:43 AM Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
>
>> I am not sure if we should allow this fix for what I think is a
>> situation arising out of an unsupported topology..
>> I will defer this to Michael or netdev maintainers for their feedback.
> If the question is about adding a driver flag to keep track of the
> NAPI state, I think it should be ok.  bnxt has a similar
> BNXT_STATE_NAPI_DISABLED flag for this purpose.

