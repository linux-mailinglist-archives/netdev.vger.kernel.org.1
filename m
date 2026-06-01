Return-Path: <netdev+bounces-293630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J93BiRQHWooYwkAu9opvQ
	(envelope-from <netdev+bounces-293630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:25:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3A61C631
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B08305A8E7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E63905FD;
	Mon,  1 Jun 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmUCkA2N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkgwEhe8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D6390200
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305465; cv=none; b=f2G2bjlr1+JcUkMMNmRCByaR4rxzaeun7KvSiT71i/E/9DahX+lUtBxP403nEfjDzI1oF8+gidUZOOip/y750AW35KZ2tsZHsV/bGvTqmYKHp26bE/Oq6PfnjRYZGlzVuJtLAzPrLGdd7Pr4Jk0zD7sIMi0a+Qg5QSRoB263zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305465; c=relaxed/simple;
	bh=sP7MrsIO97AwpHGDXGET6WA5flYKm1lMdo5clI7N7J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSBxz01RrxyMWFm/wCWJmJQUWGDzxLZnLZkO4sIMi95UTZBMaFfYxbKFYB1pGpozvgWG5/xKJAA6g9/nbVwL5lwYdYISUhkaom+rFAVHppcZbJJ3YwZt2O+Y2YspbiDDL6/PynDGgFTjMdsNKJ8foluCdjyLraILIHqycTrkNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmUCkA2N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RkgwEhe8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780305461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sP7MrsIO97AwpHGDXGET6WA5flYKm1lMdo5clI7N7J8=;
	b=UmUCkA2N3nNWdKkFRLTaKNM8ys3K20O5NGeJZs3gs4irRfQfUld1WcCTmMeC/jVKqZ8HLH
	RzoRzpGQHtM0rG9BSvCIbSCnvNUoKGnAgxuYLf2hqCQx13Ser57HKO4l71t+alYJODBiJt
	9MPQs2yqubmOcCGjUmrMKi5CR9g3Cj0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-WhBcZKOPPlaj9I_rG7w8XA-1; Mon, 01 Jun 2026 05:17:40 -0400
X-MC-Unique: WhBcZKOPPlaj9I_rG7w8XA-1
X-Mimecast-MFC-AGG-ID: WhBcZKOPPlaj9I_rG7w8XA_1780305458
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efa12a788so976817f8f.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780305458; x=1780910258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sP7MrsIO97AwpHGDXGET6WA5flYKm1lMdo5clI7N7J8=;
        b=RkgwEhe8KZG+12odaE6/2T7DSspl/5hKyHcBjtUE9VKcO/a2u0ltk+N3YImA02IdmB
         EUr7WS7BVv0mg+N0+hSdtK1skPyZC/mqMMBxlbvHM8YQddwvJhqifV4YHek4bH9ETTMt
         G43T/1kgpabHEisnlNfJ7rJAGyuJuJf1r+59+x/QN8NpUfrnTRMGPO4QPJDuHjm9qwUZ
         UP1mA37tGkkbAi0h36FUySWZo1sOwSTu0OfutTGnlyzMkB2B+lrvFeuf8liPFHVG4Q/6
         M6kUGibiKuoYv5uQclJjPpCyxVJj3anpt5zssU8M0G1S0bJNmHyOQtMGcJRsp4HQjJrF
         3qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780305458; x=1780910258;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sP7MrsIO97AwpHGDXGET6WA5flYKm1lMdo5clI7N7J8=;
        b=gNm9L0KmT8EcxFUUKu2dwzNwaW6DNHHOCzLSHejFsqYg+1Wik456PUbHyo6P2vNhPI
         Q1ncqstFwXRQbrisB1SoIpexBvkkd/iJ4m1XjdbDViQyLPMGD21g+cEbnEp18uyXKcO/
         zKZrb26r87xgsaZ5diBaKxVWFf0COirhd8w9ksqhS7Evf76E6uZBXB1GkMdSkmdwl6Gw
         Ji+g1fWEDBuITbxSc1m3vlETAwjN8keiUudCkQrLqQZCVLj/IWBHK9jEGEsWLYv715hH
         tSuP+MAzFoF6zQD6ZbxG/SR0IkkyA3z1WhWuKEX3itgBFLLBc/wPYLKqxCRSGlWVSKkr
         KYdA==
X-Gm-Message-State: AOJu0YxIi3xcMivS+DruQofMg6p1VFxsX1BMWmCo7DL+GcGp/aT9Qrx/
	3Mi0WKbPZ2t78cZYHJ1iJEKb/pTJp8rkehYgBwAu8r/ivxUOOL6CibF8UpefDwFWm3CEBB+nD3a
	71ZcKbrmswHUr8UiU5EY6GON3gllCddz7+i9MKb44ye5IESVyfqp9CIpJ8nJ3GiriSw==
X-Gm-Gg: Acq92OF5H0FiUX+vImAgw4/AyjcXsmcdeLqUdQ3Ug/1CJKnEQMl1txBwteFBPz72bSI
	C2SyJcv4lqbQ/d5075UDZmaz8CQYmjQoFdgOJ9/AvDsdtHo3fjIQESNPYwiJYzF9RNRdvRi2DBJ
	gNuROmSaXSSp5AOPE0/7gbYWRKP87H4LJubGIKtaEZzlK5F90lpCuGNdzlpGSIBXEW9G0/2fhO9
	XuDljE55xy4VXgeohmlGQ7FCeTuASIjf4Tj6CsCPWTlxJxB33z7rBkjBxskhu+cRXxmHstVhXPM
	RXmm3VWk2pY10ff1fhiMIP/m1sDSzE7Q6UEVNX6lX76WoPyTr/rO/Lx2G4F7/pQzqfaN9KVHBsR
	lBLRvF6sIpx9ERT5tkbpjzncHPJzkxNWj1Z3DRCPbhh4+mApqwhujZA0ldYr6Y7fsJ4Hb
X-Received: by 2002:a05:600d:848a:b0:490:9d1b:f06b with SMTP id 5b1f17b1804b1-490a2943afamr127462525e9.26.1780305458152;
        Mon, 01 Jun 2026 02:17:38 -0700 (PDT)
X-Received: by 2002:a05:600d:848a:b0:490:9d1b:f06b with SMTP id 5b1f17b1804b1-490a2943afamr127462225e9.26.1780305457728;
        Mon, 01 Jun 2026 02:17:37 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68a925sm361104055e9.2.2026.06.01.02.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 02:17:37 -0700 (PDT)
Message-ID: <94938164-c0bf-4ddd-bb5c-d8e1c4725612@redhat.com>
Date: Mon, 1 Jun 2026 11:17:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] atm: fix use-after-free in vcc_sendmsg during device
 deregistration
To: Zhenghang Xiao <kipreyyy@gmail.com>, 3chas3@gmail.com
Cc: netdev@vger.kernel.org
References: <20260526103926.1640-1-kipreyyy@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526103926.1640-1-kipreyyy@gmail.com>
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
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293630-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6CD3A61C631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 12:39 PM, Zhenghang Xiao wrote:
> vcc_sendmsg() checks VCC state flags (ATM_VF_RELEASED, ATM_VF_CLOSE,
> ATM_VF_READY) before calling copy_from_iter_full(), but does not re-check
> after copy returns. copy_from_iter_full() can block on user-space page
> faults, and if the ATM device is deregistered during that window via
> atm_dev_deregister() -> atm_dev_release_vccs() -> vcc_release_async(),
> the driver frees its per-device private state. When sendmsg resumes, it
> calls vcc->dev->ops->send() which dereferences the freed memory.

It looks like that the release path and vcc_sendmsg() do not acquire any
shared look. If so this does not fix the issue, it just makes the racing
window smaller and on CONFIG_PREEMPT=y kernel, the racing window could
be still arbitrary wide.

/P


