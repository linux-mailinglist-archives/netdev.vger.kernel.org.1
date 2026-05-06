Return-Path: <netdev+bounces-284913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IfuNqxc+2nbaAMAu9opvQ
	(envelope-from <netdev+bounces-284913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A094DD19F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E9083001302
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B204B44CF59;
	Wed,  6 May 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="au/g5mo3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMpeRqDx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94303EE1F4
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080934; cv=none; b=gR+i08OfNEeRWTW7fHkjWSSbkDZSEmYOqSfakoUbFOiwwlNc6pnNqfF4/yCR3DC3Bfpm6Bte2VGKDLXdfoxv38A2/OpObK8KfjYtZzn8rVDmsNlwQ53bvquJeMwkCHztEef4BCNyidJBm3TJIxi8a41DC1BDS4SfQvC9e6D5XNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080934; c=relaxed/simple;
	bh=GU+rpeFvu/c+ECLaLtY3bH6GaOKIvSDEkZsrPMB5ACQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNjsva3obqqUKzYFEu2MA1jJvupBUpbKgFxZgaLXupokIrFfZdKJOy1G1QI56eiNbiYCoupfzrp1dyrRxhyx58eJ58CYx/0SPFMiX2q5Pdz5fCU0IKLbV2DgmyJyejKF40djehzoKauxuVK+ByhqULuvbg0O2VT5jaGHOssXebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=au/g5mo3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMpeRqDx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778080927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lOFmECujKVw6rBnTfWmHI4ViWK6rRKv7cPq5umz4ds=;
	b=au/g5mo3wwUH5JtNwtC6kqWLpNlEzZ7IP+HpbJ5WZyck36AyC/4Vbn5otneUdRhZ8CXLlK
	HpnRGFEE6JYhrszD0BNMR2KaatQ/3gTQiZBLYMboWN8+Qy6h6sV+zUQ+jD7jFvWkNu/O6S
	F5mAvJBBPVs7+TpogNvyzhuOBYm5vjU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-5J8OdfCSNWiD3Ye5wp9UFw-1; Wed, 06 May 2026 11:22:05 -0400
X-MC-Unique: 5J8OdfCSNWiD3Ye5wp9UFw-1
X-Mimecast-MFC-AGG-ID: 5J8OdfCSNWiD3Ye5wp9UFw_1778080924
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so4127230f8f.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778080924; x=1778685724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lOFmECujKVw6rBnTfWmHI4ViWK6rRKv7cPq5umz4ds=;
        b=RMpeRqDx0Xyi0yMSuDMb74nxP20oXt5s7Il9R9RJ401qSOz11FkQz3HwsywimuMjCc
         IaGxpyUItI7pcHXEJkF6sFHiD+Jl5bsq/WNgJ4VqPj9QNAMSaEYKJDanSGyHc7s78lAe
         Z9iuO4szijc7nf7AKzuds7QJ+iNr3vipUR1qc3LAkcB5rNFPK0fcm2Xyl6qQIuxQKelf
         oIMr24vVJzkcLf92uU8dq6yTUWuzzmFFEhKxsb0EKc3bKb31VlHom+4IVwcF2++5qQim
         otyssSgKXl7dQRPb56d9dhZI4HMjTONVAo0pSmkYdjU5JbR84s8o8w6ulgk7OP15ikJl
         Q6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080924; x=1778685724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lOFmECujKVw6rBnTfWmHI4ViWK6rRKv7cPq5umz4ds=;
        b=mVkJfkctZQ83gWC2ywlTJLpjMUgtqKFOV+SiNuUuWRxJQSZIa6fQcRwoWDEEf9/8Nl
         Jq877f76Tfitb4VZAzi2W/CRb2VvzuuRd28q9CCP4jtlY6bGjLFIMXUPjGfWjZm2iNv+
         QW4VOIyctVKGcjurZQ64h/qAKSKlIvK1nntkDsPv95ToCCI12zdqvP3TeYUUfF+fFJZX
         swt+mkW77pOiVnbVv7RL1H1N5RvxeSi9Jb31H+uxHrgkB0G4hsG4feQmRwbxhcuWdBYp
         mR996vU8k1qYA8ic5jNA/TzlPqrwb1Fr2bA5qVAbXJwgzvHWrMhFCjekqIKwcLtSz+Ka
         ryRg==
X-Gm-Message-State: AOJu0Yz1n0VnW/Osx1e+Rs6eJzwSB+ne7XbrYQA/JZzA4dpxfRqSJXv9
	jb3gxTUpr8DwTvJ95+Yv5SIAzGYbqSIHPJDP21+oY9gfNNPQ3TMzXRHpvsTRgV8SJUtj9Jk24SD
	q8/0B3OxhQcxq39+t9SiL6L3B8oRibJUGR8/dv78jiUwLieZPJQ0shZx1Vg==
X-Gm-Gg: AeBDietL6zfuiKMFa+zibSL7yKKrQyQLS38i8KYedRaR+ojAd6sJHP7/uPn53Z9qDO/
	l4dGrUaXtjymr6rqoTchvczomenvEwwpuMF5ORME4CKbeLggrQN6Z2JpRyCVAMQV9r4dU5ObWMp
	KyybAvzgiMwjaxkBh8PlA4gJrJC40uO3iONvkTSvRbMSvRCIlVJhyI5GdH8x+4Df5DprKIguarW
	4ScjvqfR5NN7M6X7FXl+ETlFT6EChgYzEHuvkA0ndzURuuXwdeI6QXZEJMSZn9tjLs0gA35NoQl
	E4JB+pD2UJZVxm7sbO4aCljs3ag2Uac4QzqEDXoLDyqmyXkZQ17REPDkCJKZkGdVOkcv0uSraas
	VYNzaBXRaAjoI0aiE5mY0OqUEwe0ELJ+RysSRShKMJntxIlfrrjMBbUjFk/7r77b3G6c=
X-Received: by 2002:a05:6000:4010:b0:441:1fa5:457c with SMTP id ffacd0b85a97d-4515a6c2a13mr6722866f8f.5.1778080924406;
        Wed, 06 May 2026 08:22:04 -0700 (PDT)
X-Received: by 2002:a05:6000:4010:b0:441:1fa5:457c with SMTP id ffacd0b85a97d-4515a6c2a13mr6722802f8f.5.1778080923927;
        Wed, 06 May 2026 08:22:03 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm12837888f8f.0.2026.05.06.08.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:22:03 -0700 (PDT)
Message-ID: <59b26f1e-efd5-488e-8738-15e96b9c79e4@redhat.com>
Date: Wed, 6 May 2026 17:22:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 04/12] net: shaper: try to avoid violating RCU
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260506000628.1501691-1-kuba@kernel.org>
 <20260506000628.1501691-5-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260506000628.1501691-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8A094DD19F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284913-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 5/6/26 2:06 AM, Jakub Kicinski wrote:
> net_shaper_commit() overrides nodes which may be concurrently read
> under RCU. This is not a huge deal since the entries only contain
> config, worst case user will see inconsistent config params. But
> we should try to avoid this obvious RCU violation. Try to allocate
> a new node. Since commit() can't fail fall back to overriding.
> 
> Full fix is probably not worth the complexity, struct net_shaper
> is around 80B, and the allocation is with GFP_KERNEL.

I'm not sure if even this variant is worthy?!? The scheduler tree dump
could be still inconsistent, as the dump is not atomic. IMHO e.g.
inconsistent weights in the same WRR group would be as bad as
inconsistent values inside the single shaper.

/P


