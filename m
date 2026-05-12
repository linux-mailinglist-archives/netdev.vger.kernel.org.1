Return-Path: <netdev+bounces-287005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDApLajmAmpEyQEAu9opvQ
	(envelope-from <netdev+bounces-287005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:36:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F451CCC7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DADA9307C0F7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199FC494A19;
	Tue, 12 May 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0I0s12H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXM1Zubc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC2481679
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574677; cv=none; b=Khe+9HHuhWIqSTd9G1ZwT//9Ewf+HuwtLJNg32bEOipZFfZrx5TFd6X/xCR5unSZ+BfmTtKBqpwz/ZwgmkOnpvTebUuRYQ4C/DPPvn8Nk1auGxrmbIX64WEuWK5825BR8ZpUxFfzMKy0BoufxaHzFupwD+etGj+PRXPg8NIEIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574677; c=relaxed/simple;
	bh=fTGplt+watJ4CCJ48471v0saEF+Ue/1jSJxh0KQ0ZFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS788vsVfg+lfUplNzONPnLY21UsNa0f9ZyRTkuAFcJkpMvFV1qFeyW41wVAl2XWDRonv3JtUS8Q1q/NMQFQvdOI4rmRz003mjaMCTgWGg/ZkJCy9ZFkTJ9dydJ+a0H5sLpUjrchyKRx/iIvWBYyUOME6Licw/a0NbcFU82NwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0I0s12H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXM1Zubc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778574674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaygQPrE3vEfN+hpcIqqhfjFYc4/KOM3g2S8tsFLr9s=;
	b=U0I0s12HeLoaQgoXGTDqH/aawiYOFDDCEkpR+kPpbSBmLz93eiB9zg38Ui+RAlNG+Lh7uQ
	8RGUt7tOS2nVG7ier/QS4ijBSdDfEAUnRySurXX8OUJ9kkTDqN6rLqghKXSnYgFL6qfkQz
	3ru2vW16MZmN8hT5evDqJvubQYZ5I84=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-tmOnpG1TO76ckBd6BdNWTw-1; Tue, 12 May 2026 04:31:13 -0400
X-MC-Unique: tmOnpG1TO76ckBd6BdNWTw-1
X-Mimecast-MFC-AGG-ID: tmOnpG1TO76ckBd6BdNWTw_1778574672
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c0120047so30870995e9.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778574672; x=1779179472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaygQPrE3vEfN+hpcIqqhfjFYc4/KOM3g2S8tsFLr9s=;
        b=iXM1ZubcFs4fu4W/ayBLZWMiqMZOOKDTtDbyjHXofib5CIgcLwXfYibmfGFVw0n7nj
         G7FR1UvhoKrgpdk+NEiXbQSTDKq3qMBwV3mXCC/w1mFfpQCQl/VG9ObcQqcZyAnLkOA/
         ZtMqy0tIEpXOKXwMXd0YHAWNlEK0McZ74gsp20WS7Kq3lxDP/TAPqXoDCFEoZ4HGd3s3
         xDNZ/4wMYlYzopEVu+N9PBtkJSzyuzQj0Es1CPznfTIwo+R+XIhYFAgL7VsjS05e90ZI
         LBH8IiBXZHVCWq6QtfnsdXbk17nKPUVEM58ADc4dG2n5MgWMQ9YrVhFLDrkWYVGBQXOP
         bAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574672; x=1779179472;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaygQPrE3vEfN+hpcIqqhfjFYc4/KOM3g2S8tsFLr9s=;
        b=fPr8aXjvhdzFCyQ39VLNaTUsYQ8/U70WD+a4meczdpwBt99mw05K/Wq0Se+oMGq7po
         bPlRDxDQ4YR+QLVicu5gI0K6i/bGPMPgbB93pNzp0hw+v/5aZGKWueJrbN31bCWVAIBe
         QPk0MY1a4DXbmHSiLMdVucV0qWMhlQdZOZE2YSg9KiD26t72P6dXQ2Hd3lYbTaONlqyE
         6zuwE3bPhRMabaao3WPD4kZtkO5w9KhEYEH4lYPBzN22mtEaU4H30PlZc49ZB3pn/uAo
         8ZxLzFKORz35yASTPhw0b1z92Kb/R0ZQIUUf1sTwoH5L5a5HNY9dG1AMD0coeH94E8+X
         PetQ==
X-Forwarded-Encrypted: i=1; AFNElJ885TWPqfSz3rL19CQU6V4YiPJojkw4quB9PcmBHR80I3eEc4IV8vXpqMzsEwA0erZiq0K+BUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrCCMs3PyKkhSPEIHyVlFXFpICM7GX/5vWoMXlyn36TytlLdNc
	WstQT8IEqB/qV5l1+aLaoh+VqRbHN+7lzje3uIrL6eFBm3szv0rwNyqff4K3wlAwHj81K+SJMhk
	YDCwo9cbWgUW4w4AgHjIq9V/CV6eR4dfJR1Mi6VV4H9GdRGemwxvCenYnBg==
X-Gm-Gg: Acq92OH1+CX6e5p08vFTAOpuQA1MfvkSrCMYh4E7f02kGdExZEmYPgzoowvnsOZomp7
	foIEM7/X5H5ZcLJiXytU+BkDfo0UY/KToYj3AyatcqiRnontFoCExoKnkph3c4r0WXzQ4RV0o4H
	qEwLJL1lgkzJmv/lyz09J1Pb9oqK0Jcbq4H4DFsrswpJ3pkP1cVJzCYSLU00nI7OhG4LHi3k5JC
	/ZrfOWWaZUhiwYsWEzgE199GVPk3F0UBE9GmrkV5e7sqLS9wCCbFf2M1XI11Mv1qlj1Fya/AMgz
	IpFLwEN54IHcdgG/vvHIBa4dVqFTeya7D3Ht+TJFd/iBU9UBoJUunbuMtBV3NIOie8F12dMjfAn
	Kt79ILWSgLP611VVmRmlirthqTTCtQ08SZE5YIlAsbeVdzVMatiEcthY=
X-Received: by 2002:a05:600c:c112:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48e8fe7b8f4mr22343285e9.20.1778574672098;
        Tue, 12 May 2026 01:31:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c112:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48e8fe7b8f4mr22342675e9.20.1778574671605;
        Tue, 12 May 2026 01:31:11 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a68ebsm29414592f8f.1.2026.05.12.01.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:31:11 -0700 (PDT)
Message-ID: <7aeb534e-cf2a-4a3e-83eb-d98a3a5787f6@redhat.com>
Date: Tue, 12 May 2026 10:31:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/smc: transition to RDMA core CQ pooling
To: "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>, Simon Horman
 <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, oliver.yang@linux.alibaba.com, pasic@linux.ibm.com,
 Eric Dumazet <edumazet@google.com>, Leon Romanovsky <leonro@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20260508063718.101622-1-alibuda@linux.alibaba.com>
 <20260508063718.101622-2-alibuda@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260508063718.101622-2-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 634F451CCC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-287005-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/8/26 8:37 AM, D. Wythe wrote:
> -void smc_wr_rx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
> -{
> -	struct smc_ib_device *dev = (struct smc_ib_device *)cq_context;
> +/***************************** init, exit, misc ******************************/
>  
> -	tasklet_schedule(&dev->recv_tasklet);
> +static inline void smc_wr_reg_init_cqe(struct ib_cqe *cqe)

This and the next 3 helpers are used at init time, hopefully not
critical/fast path; the `inline` annotation should really be avoided.

Note that the sashiko gemini instance has more concerns on patch 1,
please have a look:

https://sashiko.dev/#/patchset/20260508063718.101622-1-alibuda%40linux.alibaba.com

/P


