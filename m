Return-Path: <netdev+bounces-293673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJFdMz9eHWojZwkAu9opvQ
	(envelope-from <netdev+bounces-293673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:26:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD0261D4ED
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E571308EBA4
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5343A0EB3;
	Mon,  1 Jun 2026 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHbYhR2q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+9If5H/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AE39EB5B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308365; cv=none; b=abHvb84zuHzoDF1iuSj/XQgEcT4JsyT64Xi/V8xp3D/O3695TN8yESL+rZx5NM+TXtwB10IobgYUc14zWIUvix3H4Yf9cqnYHwWKZEa/xniGw1oH12G8JCYHsOAQNh5OdWHc+EmKN3b1G34ZZ52quOO1XMTRjCGOd1YzujJqvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308365; c=relaxed/simple;
	bh=DZfTjGAzsPRDSEn2O90GDxv/UttrfYERpoJ2JQ7DZWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWbs7cXj7ehHJq+IBNsdnna6fSY+iLUchw6ZFRFtEIJMFQP/Vyh7ZY5HfEbhBelEzHixQTsMDSPcduTh9+rSW0AjrIEvyaqZYkOt+uQsBPJVRf71dbYMGEkGHZKKsUONP1qXbZzIUKOpVpQcXfLAr82S5x7INbmOB0agVheuEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHbYhR2q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+9If5H/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780308359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZfTjGAzsPRDSEn2O90GDxv/UttrfYERpoJ2JQ7DZWs=;
	b=QHbYhR2qidDn4Gn14fErpYsJOuph/4Fbg2p7K7Dzh24On6w3FCNVrmDaXi5OnNtulPJoFA
	Rh5aah5TlS86YCzo6PwhvPDujHHZCoFyMnqPTmGJH4J5bSL70nV6fQcXEAve8Kw95zUwQ0
	QCAQl0Zj/t8GgMfpxGlijpnuvAyWiqk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-RRTZ1Z03Mwey7oNWPk2-fw-1; Mon, 01 Jun 2026 06:05:58 -0400
X-MC-Unique: RRTZ1Z03Mwey7oNWPk2-fw-1
X-Mimecast-MFC-AGG-ID: RRTZ1Z03Mwey7oNWPk2-fw_1780308357
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490ae4d89e2so3022145e9.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780308357; x=1780913157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZfTjGAzsPRDSEn2O90GDxv/UttrfYERpoJ2JQ7DZWs=;
        b=P+9If5H/XGtNHcztXT64ZV4jfSyY2Lmfbef+H7x1riGQ+54yjN43vrBxwFdxJ8po9+
         xp/09xNEqdefnBV87ZMVCKyzNKszzO1GGATowa5SE7Zgt/5yHXc1/Cr35goGgBtf74K6
         h1U7DPmCROIwxDhUwZLTjdOZ+C1Tr2vDShTzXuZTHFEAkR2nLpI4kTM3vjXiFCQ5EQEM
         epz4eVgSeBe5WJ9metIiPr6q0v6Lj74oPiH6ypUuVaqoMPChwkYO1zWXOV0BhBOtg2eM
         VN6IPWsEMiDx4FMkj3jaz4GNGR+EmedchV1a418fUYi+foclKlKpszbjHEfeCZmJ1slh
         bTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780308357; x=1780913157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZfTjGAzsPRDSEn2O90GDxv/UttrfYERpoJ2JQ7DZWs=;
        b=XtjB2lrqOl/m2EHwDzoumFWPrUbRrbqoqFwGMkBi0ee2IUyTbQ9+lBGTiijaPnVY93
         BsFksgtLbJVKuP0jzUB4uLqxYdRQrG0e7u7b0CZR5EHQvUMfXGkNosTnVQJBK7I3po+Y
         /LY7yD01/iqr7MdkWkvKmvKzHs47LVaZQNValgWuDx9QZ//Dj+uwPXd22WQgSxBhPhpT
         2Fv/hbelQKBNE8T+dfj+EPn0xpL6U1hqy3VEXQaAB4TeAfFcdfrUkkT1dAI6VHnBbiuh
         aS5J4g+/7kKc5tNjwbpg/04FHUXNBbyxkZfGybW5RCjgPLeR/bAALoFJk8JTODB6ewL9
         Q1xA==
X-Gm-Message-State: AOJu0YwlTNcg/B84y35ZTLcQaukUCbAWzVO8xMyG7TNzUKr/i4ZQ6QWa
	Qxf1UUbtE5nD5BJ2h05CV931Ube43BMXaq0YWbCQjDiqS2rahZEWrLEddOttLnUWLdqhdnMJkTu
	li9mCZDhIIRfs3VDiWVuPwGca1OaU+eeoFWanf7aWpipFLUEGSQ2eF5vKMN5ck0I1ZQ==
X-Gm-Gg: Acq92OFn8PxA/SsLiv7m3Gnx7pwJiMJbFHGpBtsoprAYsADB3oRh9RTRmCHzh+qdKBZ
	iSV1m39QeQQlmV78T0mymVfie43zAC6MLqjvv5sLpgjC5Hi4biqWEWFvT7V7xH3mZImhP89Er0L
	ar/GIAuaLmS8Gmsd4GJP9gU2NNE3ZI2SlRDTJlr+y+G/UbSmc8E3WcdHsXpmRWZCCHKSFTA2aEP
	Iw9b4s2NXHlKhtIlmDoWhUqdELcBiHLbp2UYAIXJDm5qdwNXr8of9Nxzo8CvwpAR3IbK4DF3n43
	IYpUwGUpa5kXkDB5aJU4bo/7XW0HIXEATSd/06EV45AUmvLM0ohTXOZb2qTDp59JGf3SkZ8XoQe
	GT6WefdIvbnYXUeE+OTHHwSa0XrLyjvKQ9Y6XSZFQbCQ6cbn3zs/JXexD6HHFGXrjxZLB
X-Received: by 2002:a05:600c:1d11:b0:490:5466:8591 with SMTP id 5b1f17b1804b1-490a291fa05mr185108675e9.12.1780308357037;
        Mon, 01 Jun 2026 03:05:57 -0700 (PDT)
X-Received: by 2002:a05:600c:1d11:b0:490:5466:8591 with SMTP id 5b1f17b1804b1-490a291fa05mr185108155e9.12.1780308356619;
        Mon, 01 Jun 2026 03:05:56 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm23922262f8f.18.2026.06.01.03.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 03:05:56 -0700 (PDT)
Message-ID: <a66a8523-bf38-4090-a4aa-50f92fa7be4b@redhat.com>
Date: Mon, 1 Jun 2026 12:05:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] atm: br2684: restore VCC push/pop handlers on close
To: Zhenghang Xiao <kipreyyy@gmail.com>, Chas Williams <3chas3@gmail.com>
Cc: netdev@vger.kernel.org
References: <20260526105523.99216-1-kipreyyy@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260526105523.99216-1-kipreyyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293673-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4AD0261D4ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 12:55 PM, Zhenghang Xiao wrote:
> br2684_close_vcc() frees the br2684_vcc and NULLs atmvcc->user_back but
> leaves atmvcc->push and atmvcc->pop pointing to br2684_push/br2684_pop.
> If the ATM driver completes a TX after the close (delayed pop callback),
> br2684_pop() dereferences the NULL user_back at offset 0x18, causing a
> kernel panic.

Lacking synchronization between the close and the tx patch, this does
not fix the issue, just makes the race shorter.

/P


