Return-Path: <netdev+bounces-253915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJQjFOzWeGmUtgEAu9opvQ
	(envelope-from <netdev+bounces-253915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:17:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C349680F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EB4D3033E5C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564EF35CBB4;
	Tue, 27 Jan 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVgdLwoL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rxa1AWP2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FA35CB86
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525907; cv=none; b=cekrc0usKENBDC5drK5fCmlD7YaY447PVdAfPN32LjToK3v1DPcgHAIAS64FyhRFxqclu3DV/VsY3r+H6uEa7pBKxs3xl8hDn/jcTbC2ycFZ6LwSEkteIs2//bfGZl7zQ0KOALMJR82k7B72sI4v6iLa6mK/hzIano1q3sbFWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525907; c=relaxed/simple;
	bh=qFtP/gjDarLx9Fs3nZYgV2ID1buA9BlEYHOYEJpVBok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFF2JLhc0ytp6OfKnkq42hQN3kHbDYVzuI/OsQTG5Yd6wL/dW8WQjKj4iD5Dc1A8FrhuA6+azOQwthLb7PvUjvW1UEdCYW5Fk4QJjJy0ts5zF4TNPjoIgHD6H+lScmK9/65OsTWK9S7SxiEKzsMOhIV1r7qaWP6yqvh11SO/rW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVgdLwoL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rxa1AWP2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769525905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2h2goAHWdjIgFq3UrSn8eEXzD+UQENUBlTE3tCDWnU=;
	b=LVgdLwoLsFT7Sb39UxxdT6PvI6WQZQsLYdstgn8KG6kBtMQzgSwS7x6eww9McaDXOZ99Iu
	2NFaukcR8Zn4qRY7c4TPaBq665BoiG6xmWPVeyWrRTmFV1ab70g4V+FiPSP0NuvoL2Yhoi
	Be00U1GaK4tmTUCeQT9X32AadnkLbAs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-KUsymW4eNuy74COy_0wqIQ-1; Tue, 27 Jan 2026 09:58:23 -0500
X-MC-Unique: KUsymW4eNuy74COy_0wqIQ-1
X-Mimecast-MFC-AGG-ID: KUsymW4eNuy74COy_0wqIQ_1769525902
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4358f90fe8dso3347244f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769525902; x=1770130702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2h2goAHWdjIgFq3UrSn8eEXzD+UQENUBlTE3tCDWnU=;
        b=rxa1AWP2DEZyE4pLjSAuwgUkWAyWLd4KNyDLxN743/PQPA2+d7XGPG9SxPzb6ww1cR
         TJRteQ9bN4iQ6U6HbpxBYyjxtgsDeo1vGMXIFhKJGAKVuOJ59vyl+vfQ8d4XgkIWGQX4
         atVo0qa5ePLA8pueiQVZUI7Ipp9lrtSYDZEE1DeJwvojnAKzUKDz366npcUKP4iDcZVG
         SgaxHdkLo+YdJpagNTxxo9c5WY8tM84XonLRd5MQO2fHrafPI07lRbjcEHACnL/LJYAI
         e32/8ASEhff5d+ndVxe6eGeenmcjncmP887JltSsSxxWBMFDMjP8RQuvGx+aVzSY/tlQ
         vy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525902; x=1770130702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2h2goAHWdjIgFq3UrSn8eEXzD+UQENUBlTE3tCDWnU=;
        b=tmnWK2FnNDotWmNr2ksnMk9Oe5mtu8g8F9ABIUSELYPoYdCQhZRMwtLK2TtYPYLC6h
         kd0Ika5YJc7FOD8H7XHSU4b/CitYFbJop2/aBSDUl0A+sMtJ4t1vZ7B9Oz1NEQaie2+v
         POrbM4sHQDDkKspWtUPhOTRzkqbB32Acc4OILZ5kBWY5U8hblkRK4GIxS5Qr21kFqecj
         Izq65YqrX76RZ70oj1CzPAvHnGG/cYHs6Is+UEy3/6f/8tzrSFdGxMEkAOL3xfa/IlCM
         NisOPGelfEVDrdL9sqxpByyetkZoUVylkioui3Lso9nhHnYVOHKsARivsqvTMKvLoRLN
         ZLzg==
X-Forwarded-Encrypted: i=1; AJvYcCXdT6a47D9fJbMJgKkmlN5MBy9BFV9XTYS5FemQarx3y4MU56kZ9f4eaxMuRynkfIZH8XaqIWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh05Pcrq4SHN1swrHVhK8iv7U7HSXavcrulKwb3GAfxJUWtjUw
	qRTcloSHwPmw16ovVrwaNE8NAKCVTUm7RQUvUXWbkbuCRBxoU9xm255vgXnnmrQz6cRJUzJ/JCe
	+CSPiPv8lDmo9xgaKstKLBhXGiNWv+yDDBONtkyBIy7hi0I5fbYTJV6kSRA==
X-Gm-Gg: AZuq6aKy+FX66Uz74qaRqkxVHbGYyss/jqAagK3+i2iwbTv/M9Escrq1ev08A65zHL6
	Qq5w5SlhAn+FxN+ZeoP/VuuEvwYWDpe1/ht2d6GbmFdFQbX6A/ruowJoBDVm6ELnpD6FzXJUUeu
	6csi3y8n0PCb4iyFv7VPbH4x3qOwq6/9pYKifFfhcYabf+j4urTGFkYqwbPMOJyq5WcHBan60TM
	mns70gK6NtKlats+XkkN0kC70UaEg9z/nzTcp6bAEdKvtEZmg0tvjbOOem2LxEsZpdkILSjxKEo
	83BvPh0lPBQL/oCu2MNDuadRkxHI9XqHXwpcd4UbvmRTYID5xT6A6TbF2beHsg9WqS++5jCMwlx
	oZqUaoyjevVjV
X-Received: by 2002:a05:6000:1ac6:b0:435:9144:13fe with SMTP id ffacd0b85a97d-435dd21d8f5mr2828315f8f.26.1769525902354;
        Tue, 27 Jan 2026 06:58:22 -0800 (PST)
X-Received: by 2002:a05:6000:1ac6:b0:435:9144:13fe with SMTP id ffacd0b85a97d-435dd21d8f5mr2828156f8f.26.1769525899962;
        Tue, 27 Jan 2026 06:58:19 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c8efsm39078800f8f.42.2026.01.27.06.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 06:58:19 -0800 (PST)
Message-ID: <a2540606-0cb5-474b-8a2c-57920bc3392b@redhat.com>
Date: Tue, 27 Jan 2026 15:58:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/5] printk: Add execution context (task
 name/CPU) to printk_info
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, pmladek@suse.com, john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 mpdesouza@suse.com, kernel-team@meta.com
References: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
 <20260123-nbcon-v4-1-46a5cf567926@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260123-nbcon-v4-1-46a5cf567926@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	TAGGED_FROM(0.00)[bounces-253915-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,linutronix.de:email]
X-Rspamd-Queue-Id: 10C349680F
X-Rspamd-Action: no action

On 1/23/26 1:17 PM, Breno Leitao wrote:
> Extend struct printk_info to include the task name, pid, and CPU
> number where printk messages originate. This information is captured
> at vprintk_store() time and propagated through printk_message to
> nbcon_write_context, making it available to nbcon console drivers.
> 
> This is useful for consoles like netconsole that want to include
> execution context in their output, allowing correlation of messages
> with specific tasks and CPUs regardless of where the console driver
> actually runs.
> 
> The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
> automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
> the helper functions compile to no-ops with no overhead.
> 
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
The netconsole bits in later patches LGTM, but we need explicit ack from
printk maintainers here.

Thanks,

Paolo


