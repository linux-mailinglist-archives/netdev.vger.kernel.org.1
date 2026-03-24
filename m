Return-Path: <netdev+bounces-271000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGbSHddxwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-271000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:13:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217F30717A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6541304FE43
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E98B3E5570;
	Tue, 24 Mar 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfO5Un81";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpS/O6Dt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D31DFDA1
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349904; cv=none; b=CBJVOd0r+QPIPMOXqgKyjrqLnNSBM99/B8myYwqTuG25BqkZO4Ru4lunnXTA8uWWJ6oCjPunS31WWuXr3fVB6zYCjDEdGnq5jubfvEvUBzwl5y8TZuNrdwpCNrt7k6VNgImOECgX8UjhGrszMqWZ7G120zYVbmn0yR31EzegVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349904; c=relaxed/simple;
	bh=RvBBHM/r8JqLlusKXxze+0dkWwneeCrBFwruBfiQ4Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xba5tOd8UGpKfl7uKVk6xfjAjOFFFdXl0DE0qOGYvAD/YdxENQIRjYkym7uIO2I83E5kiKdnq5rYlTnLQnMBRn0UsFKJf23JlQlI2qs3aLsaafRD90GwawkyANJVnWFzkRoR29+VnwpwRb1e3rbCkyOox9Vi3yYvEyG8MfU/FTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfO5Un81; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpS/O6Dt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774349902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7fxYhNz9mypo+6RSdtGXJrr8xN/V7RBlg3/DS40iuY=;
	b=HfO5Un814ITQ2W13h4iEH6kgx7Uc+0mXoy0azqKR19pFa9CJ0xeIJxP+JEtnpuoMPwWhja
	NQm82ojxr1PrwicLKpiMhBXhnvYT9D9+QxSrYaD6jZtYbMlrsidPbGmNyCu9SriPQt85ud
	97qYZoKR8rA9gEVVnHyUrBebSKUKvZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-hqiUqYzkPoKFk_GiE88RSQ-1; Tue, 24 Mar 2026 06:58:21 -0400
X-MC-Unique: hqiUqYzkPoKFk_GiE88RSQ-1
X-Mimecast-MFC-AGG-ID: hqiUqYzkPoKFk_GiE88RSQ_1774349900
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-485c45885e6so56984905e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 03:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774349900; x=1774954700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7fxYhNz9mypo+6RSdtGXJrr8xN/V7RBlg3/DS40iuY=;
        b=RpS/O6DtKd3NJ3yjJK5Q1e3JfvUuspcqYRSEhws1bY7KD23jnSV/bUzYKuvVfIogU5
         eXQdL+nn/EOITP6IMdHpTnx7eBZrf33lbAnZm0NO4hvkBTH+FBh+i2ROKlPj500SqTqy
         WIzbWiypUhjNEoV/rjGU7DHrqXrgkHAm7tULRuMznsvUYuKXfD77rBcS4qxTkIG0EAXT
         SRDSbr9tdKlP026AH9NkY69EpzNiRoNBPjLF4133TiF1bC0Ps+2HK5lKqNS/Ji3BDiWX
         19EsqnfK+/p5j65R0/zj2e0y4XP0uiQe+X3wEkOu6Q91gJusL0+V15nm2vjpHmQi78ZS
         eSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774349900; x=1774954700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7fxYhNz9mypo+6RSdtGXJrr8xN/V7RBlg3/DS40iuY=;
        b=WYVIsH+Df/+b0rFaM8Og+6v7ODzFrkuKNTdfZyvP+A+mqViBbQvPUehQJNsvYQG2a+
         KvGEOQ920uM309wfRrSWQWcdgSCMMyxKv3CGz+urKR8VavXbqlGfDYig4dPr3bp9ExrK
         cPoWF+wlQ0gYLx3GLtcqFBXv/pfCVPOMVrgZiRmGd15NqyAQYz3JdXku9qJdF7Zf0y9X
         PWP2uHvP9Sj5q9iIyIQjapaNe27DLOAIMjaHRXD+BcHvVxeSYY6Zzg0HHKCa1W/nH6Bz
         Qf3xmuXQNkXj12JcHcODs82HeMSDMYiFCUsS59Q6gV68ryCWbnsVlIcnQBLJMp/fTROC
         g+Og==
X-Forwarded-Encrypted: i=1; AJvYcCUABW7b8bzEMXeDT0ToxQdr6sBOfJUfzJ+Gwo6IU59y2r0YjaSNroDju4bnhbg6+mAi/3sjQDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCe3a6LptIp+fUj1QMeMpAMY6xXbQOa2+sQD+DFI7tTA7gVDg6
	1CYhfiyMJL7O5JnBFiU0tl3/FOEPjxZVnLw4NL7r/aQw3wobEb2eZPWd7jLC/1+Z5+RplXfpWZY
	CRyIUIIc8yxdjvk1wu1obPJOrn+uqE4rhk5xwcWs2Cq/+yEZpZBFubCNFtg==
X-Gm-Gg: ATEYQzw5iHKE4IK0k4gY5YC9+fGR5b7KtNa82EN0KMUHqtwKZVhDCwZHDS7bD7HL93l
	pQ/AEF9ACreCut6pnMINRf1HJthr6dNWxXtzeAmX6qY0kr+e9i71PVsIjRwwDWiELDTgofu48Vx
	wWFrn019ef1xj12JVZwxWce207XUo3dNw0c+nFbLokJF9L/usxSQEqj3VBHMSGEiw8YJUYRzaF+
	yLWHOrHH18QpEJ4xmSvRYx3C1x6Nf/YyhV7gxRbgoMMeEJDdW4fmXmSK2Po94nBHpBwP8oG+C+Z
	DJrD4KKDnRL9y99boQovuE05n20xKws6F6lEtcH/W3+t+hOQ4ptTYA8uUvJU+aNEaHYlQyIK2mp
	bO9RwJ1Tc/Ge85MDrB86n8Gc9aW/7zSoRg0tTOatCPL9A+x20vKvDH2FY
X-Received: by 2002:a05:600c:45c5:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-486febb5f45mr213729435e9.6.1774349899757;
        Tue, 24 Mar 2026 03:58:19 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-486febb5f45mr213729085e9.6.1774349899327;
        Tue, 24 Mar 2026 03:58:19 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116d82e4sm78734655e9.12.2026.03.24.03.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 03:58:18 -0700 (PDT)
Message-ID: <5ff51617-deb6-48b0-b9e2-2d7066fa2562@redhat.com>
Date: Tue, 24 Mar 2026 11:58:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] r8152: Add support for the RTL8157
 hardware
To: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260320-rtl8157_next-v3-0-1aefeca7fda7@birger-koblitz.de>
 <20260320-rtl8157_next-v3-2-1aefeca7fda7@birger-koblitz.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260320-rtl8157_next-v3-2-1aefeca7fda7@birger-koblitz.de>
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
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-271000-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8217F30717A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 12:14 PM, Birger Koblitz wrote:
> @@ -2022,14 +2277,14 @@ static void intr_callback(struct urb *urb)
>  	}
>  }
>  
> -static inline void *rx_agg_align(void *data)
> +static inline void *rx_agg_align(struct r8152 *tp, void *data)
>  {
> -	return (void *)ALIGN((uintptr_t)data, RX_ALIGN);
> +	return (void *)ALIGN((uintptr_t)data, tp->rx_desc.align);
>  }
>  
> -static inline void *tx_agg_align(void *data)
> +static inline void *tx_agg_align(struct r8152 *tp, void *data)

Since you are touching this functions, in the next revision please
additionally drop the 'inline' keyword; the compiler should be good
enough to get them inlined anyway.

/P


