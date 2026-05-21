Return-Path: <netdev+bounces-290557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCYkLj81D2qSHgYAu9opvQ
	(envelope-from <netdev+bounces-290557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:39:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C85A971E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A1C831103B4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D93815DB;
	Thu, 21 May 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMrEMCSb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLZBP3tQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5D22A7F0
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380370; cv=none; b=EpanaV9uuXmfEchXvl4sP4JvmoVLccRDtRg6Ls2p/eremqSwyixMri8mOuM9CwhQN02rkv/fgUqLalOaUzv04qLqI4tBCjAPGHMWLNzUd1M0D9PzvutI1gKWhWZuuxQW4HXzpokmzjbfYDgTLFFCjWgHsBbNz+uh/dMxpPiAL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380370; c=relaxed/simple;
	bh=XhTY4iG1YZxytqYgUnZLZi1+HEG3elLJZtNJsczuB2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJMYi2IXWXswkZNnFEH8YXYmRfcqfQrp9XpliiP+WzLeNI1DHAh4feCuFBFFVMyuuM2wxH5gO1Pg6YPBFrrtDKyC0yTBogIuSi9q8s/hviYSdfdn0kp1DoM8gwP8NSRz85Tzr+5klrn7J/TXjOwXkU6t1Gev1int/MwgFewONZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMrEMCSb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLZBP3tQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779380368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49ZJPsxvJ9twf1WBJAA5ghsdPxQ9lRVco3njpKCl1ws=;
	b=dMrEMCSbW+U9vux1xxhAoBczoKdNJzIGpIi1Hlbzfqs/KHxSOtwLq4mjj9ytfA++jd/1S4
	+OPGEyUYNu27oQIwid5Y+3BmfCkVTj/w9CtfPRuhRSx3RvqgaNtBW5SnN6/dma0td0bNMa
	Y9clDFE+jHhcjtLRdy4BnmjF1xf/FV8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-k77fe_kSNQOyKXwL-PoTlg-1; Thu, 21 May 2026 12:19:26 -0400
X-MC-Unique: k77fe_kSNQOyKXwL-PoTlg-1
X-Mimecast-MFC-AGG-ID: k77fe_kSNQOyKXwL-PoTlg_1779380365
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a589c7879so47273555e9.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779380365; x=1779985165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49ZJPsxvJ9twf1WBJAA5ghsdPxQ9lRVco3njpKCl1ws=;
        b=GLZBP3tQc8m+5oq6f/s+lOf9C03R/1ViYtpgTtk+tJhFZ16Zx6CT0qshDLNMn0e34p
         qcNcL7liakMOoKUpRogxEbF6MasPigbDfmgJJP70f5jqVKVfzjIwoQxgMCelmWOsqgTX
         eOCNvQpzVf/NWSovc4WSBNClWKi+hcyBaLbRiQ5vVlhEP38zWgrynCjQcDsPoxpMlUAp
         ngDKtAB7GqFtJJOzzNY37tVFEF2iP0LZlHGDMObLiroQPeVSPuv0afGr+CK9UtKaHkdk
         YLu+f/QaJjCrJSng5mS++/hwRvQ+Zb49gnvYwYvOEt8xSplVN4rCgL8goD73UhEA2Wc7
         Tskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380365; x=1779985165;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49ZJPsxvJ9twf1WBJAA5ghsdPxQ9lRVco3njpKCl1ws=;
        b=X5As0cRh+V75InRQXwulMOR5Vnj7UR8qrMqY4/kmaTh/LlROcVsWf9I7AQT9C8D2EE
         H0GnBNxpquywrhJmZhJJyqId46L7iICXBFk02VvAuqpNflAtzF1ipc3RIMqknIZCqKlu
         YwQhX30kY2bUCvNWkGgS82IxbzuQZJG+Srm9BtLQJccRwKScwD+e26e760yVEObnPjVv
         KqVFUKXzug7zZbmjlKwHoN2XtWZ2PETLBnv6TGFrndVbS7D1TuBL/QX2ZgedB2AIEHQq
         whViqCxTL8OnHVxU1JpZCMgE0EkWDq9cl9pR3sw0etZxbVfpxtsyYHHzM84R7bng2JGp
         3CCg==
X-Forwarded-Encrypted: i=1; AFNElJ9CdV9PlwmwUk6yyaC7pMOK3X+aH/gG3NarDR/ug7XvSpfwkcsBVmBVfnyZmt4PB+lE/k6325I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEDpvq0I0ISdKFiA4qJ7qah04zaIBuk6hX4t402iX0IPd1uRA
	UeuAr4TnkGNZICLDJiqv+bskldJp7/Wy1e1UX8vbPRa9Ss8/duJTZS5SjjxBRgTQN/PKaWGtYGJ
	aBEZCj8+H+6WBq85nnIAvRtieJPekDk/Grt8AK6Y5foOSfBozwpEBrlc+Xw==
X-Gm-Gg: Acq92OHUXf5cVE9FzeccbYqImVb0AfBSfwc1y2vY4DZtonfFGyb+khkl3QpCHGxeMyN
	m4bA5YM2SW1BaWtxZm9eD+ajExrLjkvaTSQVdhBLPm9r1vM9zdgVUvFY82UyuMbPZG9SLMIMoHp
	IzCpNiy4hggChlUf8OECa9TbleWnYDWUmx+MCbQPS9hIFIeazNVEiSYoNmajhHVGkdKjUHNR2Ds
	UFiFT/k54Y28yEod9bTSnJ7qBJzM7gudabR9sa2t4FW9jYX2SvYSOV5OhdRtJlrA/xHaXYv0Cbp
	rxeh0XIzHtQ+yVkA+AJgW7A0p03w/7QZj/TPMtYpoFUOD9fVJakUdewpgOawDt5Zb5DXPQEGNJI
	5hAQXSci/rBac6LttERA5IKnHHj77//GH1CvOAeCarbzjd2uGzeOqvuiHHw==
X-Received: by 2002:a05:600c:698e:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-49036048167mr39012245e9.2.1779380364712;
        Thu, 21 May 2026 09:19:24 -0700 (PDT)
X-Received: by 2002:a05:600c:698e:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-49036048167mr39011915e9.2.1779380364281;
        Thu, 21 May 2026 09:19:24 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035ef2d93sm26744775e9.9.2026.05.21.09.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 09:19:23 -0700 (PDT)
Message-ID: <c75646e0-8a1c-4301-b6e8-fa2faf21563f@redhat.com>
Date: Thu, 21 May 2026 18:19:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: napi: Skip last poll when arming gro
 timer in busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Joe Damato <joe@dama.to>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, =?UTF-8?B?Qmrvv71ybiBU77+9cGVs?=
 <bjorn@kernel.org>, Frederik Deweerdt <fdeweerdt@fastly.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260518181337.886459-1-mkarsten@uwaterloo.ca>
 <780d21ed-4ab3-478c-a932-6feb7aa6d7b4@redhat.com>
 <b785b518-3a76-4058-ab76-644df400cd0a@uwaterloo.ca>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <b785b518-3a76-4058-ab76-644df400cd0a@uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-290557-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 981C85A971E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/26 5:42 PM, Martin Karsten wrote:
> On 2026-05-21 10:13, Paolo Abeni wrote:
>> On 5/18/26 8:13 PM, Martin Karsten wrote:
>>> +	} else {
>>> +		/* All we really want here is to re-enable device interrupts. */
>>> +		rc = napi->poll(napi, budget);
>>> +		/* We can't gro_normal_list() here, because napi->poll() might
>>> +		 * have rearmed the napi (napi_complete_done()) in which case
>>> +		 * it could already be running on another CPU.
>>> +		 */
>>> +		trace_napi_poll(napi, rc, budget);
>>> +		netpoll_poll_unlock(have_poll_lock);
>>> +		if (rc == budget) {
>>> +			gro_normal_list(&napi->gro);
>>
>> Not blocking, but I find the above slightly confusing after this
>> refactor. Perhaps it should be re-worded?
> 
> I'd be happy to reword, but I am not familiar with the internals of gro 
> processing, so would appreciate any help I can get?
> 
> Should I try-and-error via subsequent patch submission(s) or can you 
> comment on this version:
> 
> 		/* Use the driver poll to re-enable device interrupts. */
> 		rc = napi->poll(napi, budget);
> 		trace_napi_poll(napi, rc, budget);
> 		netpoll_poll_unlock(have_poll_lock);
> 		if (rc == budget) {
> 			/* If napi_complete_done has not been called by the
> 			 * driver poll, the napi needs to be rescheduled.
> 			 * Use the opportunity to pass up completed gro skbs.

Possibly something alike the following:

			/* More work to do: no concurrent napi-related 	
			 * irq is possible and the current thread can
			 * pass up the pending skb batch.
			 */

?



