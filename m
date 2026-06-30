Return-Path: <netdev+bounces-303285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7QX3Kt/lQ2rzlAoAu9opvQ
	(envelope-from <netdev+bounces-303285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:50:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 067886E61D2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:50:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="XAwD/gR2";
	dkim=pass header.d=redhat.com header.s=google header.b=lWjJCdII;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303285-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303285-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DB6A30158A8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90AA450917;
	Tue, 30 Jun 2026 15:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D333BD64D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:46:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834390; cv=none; b=JZ62R3C6fu0lp0vNWdZDvEnAhUnTFRDyu0heMTIQY9DwuAgbLoIVoHlCuxvK6XcjOlQLhmpWA9OMeOLnua1edTlfbU2bMlQtR8b40ey9X+TZeUd8Z4ldHLbTn1/RFObWxnsyytpQ2osFbXHz7gYX7jz3pP6eFMEsg04dm0Fj6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834390; c=relaxed/simple;
	bh=mkJTiRV1PHwusUwXTFV4OUl0PG9ZE0em1zdcd9R/LVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2/0Qw96GqxZRIfc+hGchddkcA5ymUF8Zd1owN413AKMcJX4jguwGv0/FtO5Ecomojmjlzwme+yeJPXILUt6Mz+6/a7riFAIx7xRroH8NQ7itB92LMj3hLBFzfhhuP5lbPzLxlSdm6/C9913V2VoW3kv9AqnbmTFPfyYD55UjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAwD/gR2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lWjJCdII; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782834388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IN4CMbnBr4jIxiSJoX/PRTAeUZ2FeEBYMQqWhuM1Zpw=;
	b=XAwD/gR2Igqe0ALhkn5KUoe8ubM3w9Mx1YoW8LZgNF34L+UW05jbegNVanW9cUseecQ1qg
	0099xF8n1V3OpcOPb85+6XNjnKGRgRO2kRITalKQRkzj88gO9kTa4LY6yjJcJ2Gd6z6Bsq
	6BZGkD1RwJ4kLn28PBfHpGPsuvnQIPI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-MjCRIsdOM-St1f7GAEf-bg-1; Tue, 30 Jun 2026 11:46:27 -0400
X-MC-Unique: MjCRIsdOM-St1f7GAEf-bg-1
X-Mimecast-MFC-AGG-ID: MjCRIsdOM-St1f7GAEf-bg_1782834386
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8068416764bso77913017b3.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782834386; x=1783439186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IN4CMbnBr4jIxiSJoX/PRTAeUZ2FeEBYMQqWhuM1Zpw=;
        b=lWjJCdII6TtfXhvHcnRId/SceVI3Rmw6+3H/Tupa3ZwUDPqCLwz8YM9cbZUF8JjXoe
         KjvzrApL1UdGCVgHhj5+MUyqu6ZCbDjYU9fstzC8ad0ulryfjG5dgVgA13TlDo5hqI6w
         4yVJIWgPgiUi8Rrat7c24zcmUgZsnnzAtDi3UTvrlhPnw9i/wH43K8iYKTW1jAVpd3fU
         F7eHjbxyFvpNeT0fpEWuT7zZRIzB7QU60U5dSPPDxGjTZ65nePWNMUx4MZoQVFNUDc6L
         wzoDTD+SheXWOB6Ozx+6iRzV2/y/92da+XYTJbw1Q753dWjPE0VQEkNkb/mWclFvxY/e
         y2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834386; x=1783439186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IN4CMbnBr4jIxiSJoX/PRTAeUZ2FeEBYMQqWhuM1Zpw=;
        b=YEmHouRCvp6A+jpH9lHg7VVCwHH2h8BngB/U6w3BGslPdX0hqHGUmzxYUerUZ7oSIy
         5St2ItH3H5tl1TbwIdpv9ogr1T0VhmapxhQILo8jCpm5pMq3pI7d3sc8rjmngKEHI/eB
         U2iIYpMYK4azjzCGSQThgMKwHuXmtNCQPgmwFNgpiF0/kf6/tHHBEdHxiYSPnDOlrIFJ
         BNN+nnig4qriNdrq6q1hbMwUzgF4CaZaePwHztZ9MoxPKfoBfDtJgew/1AALndvfpLDj
         oa0l861JurwExl61dpHSQBweOrAYtKqUmqqrkCnlin6O9QvWdEAh8gHBVIoyFASW6BGx
         NX3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrTU54Riqhq+eLQwfvIECVsGctRgov5jKgw9QMl8dmqz+Bm1OVnh6yGJ4a++5kKxxTDewG8HCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykqe3nz2DZsNUH4eSedr4cIxR4l6hpAB29HrsWHGudnX5iuaHV
	3oOWXaJuqakpg8ZasNP1D1vpKEHPpNQEkjdtGP3LtDnpcAlAYn5Ys5VhSJXlDPRe9ZG0xdhHCg8
	yg4l018xJOALWSmsjBPid3ynMWNxxw1NGD1/dMaiBpQCrDtSZCrzpFsQM9Q==
X-Gm-Gg: AfdE7ckuvt0GTLFL8lVQUi8t9cKxD9yn5SXALKzqTfyCt0d+ROI+7KFTh+RkKBCrcuZ
	WS3NVDpSaGGr166hnRymwlUI+mtLT8gs15w9Fb/XNlxlkgmHq0TNNx0iR1EORTMDBwYMrZB+KvF
	0B8mylXjauDppx2qPcG0Dc1BZBx14AMzyeO2kUt1mfDC/h8RKalo2bA2jNJ+LtHji1ulHiNWmH7
	Edpj71V4ctdkScwq2Lqp/VHqHWqLC7ZGcMMeraDa6kJEaYJ7JeNX8d6OM00yjmY76mg99n06tcN
	P7+XUFqk6Nb9xGuO6qNVE3v1F4gistEZRp3zJtqzLBCklX+M1/v7oYBk004EpgcWE7P0YeyIKUq
	rRIhugy0ef59LyJZ1q1cHR19Vc1EHbcsH66sGDbF950f1v5XYGjwBbRXuzNxQkqdbOM1BXQjE5+
	sQP0moljmhlg==
X-Received: by 2002:a05:690c:490d:b0:80a:9ff6:c43 with SMTP id 00721157ae682-810da80b671mr47504107b3.55.1782834386370;
        Tue, 30 Jun 2026 08:46:26 -0700 (PDT)
X-Received: by 2002:a05:690c:490d:b0:80a:9ff6:c43 with SMTP id 00721157ae682-810da80b671mr47503077b3.55.1782834385393;
        Tue, 30 Jun 2026 08:46:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e7d73113sm12555117b3.22.2026.06.30.08.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:46:24 -0700 (PDT)
Message-ID: <cea02341-fd18-4f84-845c-32664e5b4552@redhat.com>
Date: Tue, 30 Jun 2026 17:46:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: libwx: fix VMDQ mask for 1-queue mode
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>
References: <161F704D2C983E2C+20260626092530.551028-1-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <161F704D2C983E2C+20260626092530.551028-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303285-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,trustnetic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 067886E61D2

On 6/26/26 11:25 AM, Jiawen Wu wrote:
> In wx_set_vmdq_queues(), the VMDQ mask was not set for the devices not
> supporting WX_FLAG_MULTI_64_FUNC, i.e., NGBE devices. A mask of 0 causes
> __ALIGN_MASK(1, ~vmdq->mask) to return 0, which incorrectly sets
> q_per_pool to 0 in wx_write_qde().
> 
> Fix the VMDQ 1-queue mask to 0x7F then ensures that __ALIGN_MASK(1,
> ~0x7F) correctly evaluates to 1.
> 
> Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

The PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P


