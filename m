Return-Path: <netdev+bounces-267356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB0SO/Tas2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:37:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567802809CD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70D4430F1BEB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB7372EF6;
	Fri, 13 Mar 2026 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auYYBnmM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7pfSVYq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9D350D46
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394592; cv=none; b=nSKKfDX9/4WsM/4HlM5HvZCoJQFGOQMytTfV/+z3mbay7unGQ6XXFS1d3/tWS8oOJnVabcYaqC8rm4bq7yNnitru0XNbdlaCMwzA253Lq0pl6Mibr5e4Okxi6ujy3HXKZhzXiK7/hrlVNfVAc0H0D6F4PPG9fPQsNq3Mmh3Hi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394592; c=relaxed/simple;
	bh=MDPISncaQk/j+sg4lRSOUn1FD/PZXrRXpiRVuog5XwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHfMUfogTK992D3OOTQlErRF2Sf4+eQvqQ+3hAM13XW8G4iyU5dBhizRAYxcFNx+qJRA1B0TThIQlnVdYZpcUQyRq3WngEaFAi9hRg9sZGIPdCoh6RiXdzFqSYLOzpFksfb78SCLw36fmsPyrIGRRuYEsJJu1bt4Wutq4zdFVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auYYBnmM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7pfSVYq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773394590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ik0jcpyuM4uQ3ciTkmit5WfEePrPHs1SgwiGTBY8tgs=;
	b=auYYBnmMDHbEQFWXP9Ljxge7cLKDyQdHEyJcRt1glYUCKpy/37xtu+EgjuKIfYM0vVbmga
	1hj5iGSS2Cg90y1HUGlRa5A/TRr1d/tbNEfc1Lbqw4mS5QAL9PnD/Jbl/BZw2La8Zt+Fc9
	1xFgzhkiYip98hDxiD1+bu8vyECBBBc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-FbIG2cdLNfy85kOH0BYFHg-1; Fri, 13 Mar 2026 05:36:29 -0400
X-MC-Unique: FbIG2cdLNfy85kOH0BYFHg-1
X-Mimecast-MFC-AGG-ID: FbIG2cdLNfy85kOH0BYFHg_1773394588
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439c112b1a4so1352989f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773394588; x=1773999388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ik0jcpyuM4uQ3ciTkmit5WfEePrPHs1SgwiGTBY8tgs=;
        b=P7pfSVYqQrbvZZvHJjRrMUZ9b38FHrelUwCbMCFoCn1Gw9IddxgpjFY1gayevqj8rc
         4sYK6TtUHUJREqHSuw8zV/O9QPpBmdCKTgq2BAfI2RblHkZ5KQgFWP85kvgTKkV4wgUq
         1x6HH1MbX1g1sQjfyyJi6PxUwi8CroeTPo01/zMY8YxvDUrsCo4ayzuifrUIlfSuItzy
         4zWmnAYM1zpmA5LeuwGFGGvZCIfz8bbObQiuyCZ850T5brzxRXG5hFKywgjfIdocSBZF
         IuFDhg76jby9opPtotHWRl5bPFdbUxTlQnoeeVOwD6uQI7NMfSvojnc0kkM0P6uUj9Bf
         XTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773394588; x=1773999388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ik0jcpyuM4uQ3ciTkmit5WfEePrPHs1SgwiGTBY8tgs=;
        b=pgyZT4Wa6IR8vCbeGs0B8TqlK1S/p0kKeO2ctmSUgb3x0Ev51GbUHBuceel5xYUxDw
         w3x0Fq5NE7rhIesm/sC6P126OaF7rJpaw/ItMcBRP37Egpq3SPzNaT+DHCannURO9e0v
         Q4OYjmINXaUHTUSKvFX7Dlmak/+lBLbJ8iNJX55vaVpWxTNqZgjGXZY4j6RY2Sl3t4K1
         +DZ02Ah+Yo2zwemgiusZ1fWaUXjlt/MWABlmyLir+roP2Zvxbr4i7nmL+tDPvNZ+7ryf
         1wdIjaoW+AUxIdYXBK8dlC5qMqF9pZVHK3pGciN8Jl99gf+FNlVqr77PrAsNziPVzeKE
         wQBg==
X-Forwarded-Encrypted: i=1; AJvYcCW46rFZ80y7dcGkAhqXCfBy5EUcQ/FTrCNjib2B1xFUUdC7lbi+nKVS4MgraDvcjELxTayxJco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0bHiU+i37zMqT3vkNdIdcOQg1dpPpqWwAs3wpD2+7XcDFwR8m
	8N8EBpsS1f7GxZzTMFY0aLE5iFKGof6JbdWo0lfsDtRZGdVUfiD2c2E3eF2Af2Ncr3uhaHNleM+
	BTp2/v4xMB/EoKrpye4j0+3JbKEglow5ZzT3QIR2t5DDDZUqqAHyT0Wbt1w==
X-Gm-Gg: ATEYQzxyrO9fNmA2x+d/hX/W/HPkM7mDHNQbZ7pLWtad+JMhwQdd+sABejgghjyYZiG
	V7DCjxX5GPt0SVTowzsYzB6oo1+j46ixFoL7cU84qsjwkZPpm9/oUqqDwmq8Y15OKxHdRssky24
	I/eS4PvtqfAQ75zMo12+oQx33WVRvnpZ8RHOFelF4vcR4YArnCx1mJecLZJI5OuZwnDC70V04eE
	tKTkaelqsUywG4EdcXiNdTcQmgICotBx440x+Kbegnw6niRrVv5HNPtNLRTg+h2unrK4t310o5O
	8hkK8gFuRpOr12rUfIwZFGRDCTnKOOH4Aho3WIXxem9BizitF5SrgxLSqaEn0SBLzmk9k+E1NYt
	8Th+aL9Oid3skW3Q/YLA/0ThaVjBywOd818AJ34LAw4zrDm36zmQXYOQ=
X-Received: by 2002:a05:6000:2c06:b0:439:b715:6f49 with SMTP id ffacd0b85a97d-43a04dceabbmr5256615f8f.59.1773394587628;
        Fri, 13 Mar 2026 02:36:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2c06:b0:439:b715:6f49 with SMTP id ffacd0b85a97d-43a04dceabbmr5256562f8f.59.1773394587136;
        Fri, 13 Mar 2026 02:36:27 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19acbbsm16991060f8f.2.2026.03.13.02.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 02:36:26 -0700 (PDT)
Message-ID: <da079dc9-4698-4e87-b7b4-ba60ecebf4b5@redhat.com>
Date: Fri, 13 Mar 2026 10:36:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mltQQVRDSCB2NyBuZXQtbmV4dCAwMy8xMV0gbmV0?=
 =?UTF-8?Q?/nebula-matrix=3A_add_chip_related_definitions?=
To: Illusion Wang <Illusion.Wang@nebula-matrix.com>,
 Dimon <dimon.zhao@nebula-matrix.com>, Alvin <alvin.wang@nebula-matrix.com>,
 Sam <sam.chen@nebula-matrix.com>, netdev <netdev@vger.kernel.org>
Cc: andrew+netdev <andrew+netdev@lunn.ch>, corbet <corbet@lwn.net>,
 kuba <kuba@kernel.org>, linux-doc <linux-doc@vger.kernel.org>,
 lorenzo <lorenzo@kernel.org>, horms <horms@kernel.org>,
 "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
 "lukas.bulwahn" <lukas.bulwahn@redhat.com>, edumazet <edumazet@google.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260310120959.22015-1-illusion.wang@nebula-matrix.com>
 <20260310120959.22015-4-illusion.wang@nebula-matrix.com>
 <f669062e-16f4-471a-9884-6441c478dd09@redhat.com>
 <388ff939-2eae-4cee-aac5-ca88dd37ef49.Illusion.Wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <388ff939-2eae-4cee-aac5-ca88dd37ef49.Illusion.Wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 567802809CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 9:05 AM, Illusion Wang wrote:
> I am so sorry, Last time I missed a 'not'
> 
> These data are used to configure P4-related registers. The driver’s functionality
> 
> depends heavily on these register settings. They will be declared as const.
> 
> But they can be not marked __initdata. Because it will be called by pci_driver.probe.
> 
> They also should not be moved into firmware files, as the software functionality
> 
> is tightly coupled with these configurations. If they were moved to firmware,
> 
> users could easily end up with mismatched versions of the firmware and the kernel
> 
> driver module, leading to functional inconsistencies or system malfunctions.

Please add the above explanation somewhere in the commit message or in a
code comment.

I appreciated you switched to plaintext for ML messages; please
additionally try to properly quote the relevant part of the message you
are replaying to: it will help following the conversation.

Thanks,

Paolo


