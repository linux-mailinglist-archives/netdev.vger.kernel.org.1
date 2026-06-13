Return-Path: <netdev+bounces-298940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HvfKFdgnLWqXdAQAu9opvQ
	(envelope-from <netdev+bounces-298940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A554F67E4A6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:50:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="SNiPj/Ol";
	dkim=pass header.d=redhat.com header.s=google header.b=CfrPX0jI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298940-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298940-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C60300D940
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E933905FD;
	Sat, 13 Jun 2026 09:49:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F6385D75
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 09:49:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781344190; cv=none; b=q5XbTBxZhs9wZfnLF2RSE9njFcQRiWGEnLTh7UQJf/5p3IChy3GH5L5jzqRnAg9a1YHJYF5Hyebkqc+S879IuzGR3C18fX4ePQZ8pT0S5dCnEqMYw29MX2cyJnh8jPBH5+EIQOL76Ci0Uibp3EqHS5ZhJ5TuGpBzv5Madwe8JAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781344190; c=relaxed/simple;
	bh=FcO7a0tPZNtFdaMgrEMuMy6r832rujLhlrS3eIAZsis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ4KPdi9D3HO3Lrs7zpjkPX9RBpdge+5VErh3/J6wZjjU0CeTp5HXIRtH39r9Cpz1DJsZgJ1Dm0YhHNNyu9qIaT3Bt+F6l7wuvqWikucj/ADGsqbhUzGDfd9nuKG5XyeyqwxnUk8USDJPR/RVj381c8QbrxkrFhoCmE3ngfSffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNiPj/Ol; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfrPX0jI; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781344187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSbIAxY/PzSgmritHJK40bRpcHkfHk/PE1pedi4ge0A=;
	b=SNiPj/OlhpQW7wxoYyZxhDuI1Ur8Huq/0eGW1AQtrsZgRraNEM6mqmLY8+ItEyoKSiZ3f9
	Uo+ViYBEeBXMuGTtBIz74APVh4ZzW5efVggNyZdangEkV3QN/nxUV7COgWIrsuOT1xWufV
	Kwdgn7A9+gaHNGr+9GB9Zre6fauHAE8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-ZfeYrCHWNWW5pThcFS8_nA-1; Sat, 13 Jun 2026 05:49:46 -0400
X-MC-Unique: ZfeYrCHWNWW5pThcFS8_nA-1
X-Mimecast-MFC-AGG-ID: ZfeYrCHWNWW5pThcFS8_nA_1781344186
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8cea98a0effso39096616d6.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781344186; x=1781948986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSbIAxY/PzSgmritHJK40bRpcHkfHk/PE1pedi4ge0A=;
        b=CfrPX0jI2xElh4KdpfcmT3sYAC9T8g+EzF+eTteyKXj1CnrgFS0hIR8bzY1sfU1RFi
         hdU6yQsGla6H502Bi+F1o3L6MY97WjAUQW0ix7qx4/lOyyeTq6lBL5+3IkBvPQb1DeeT
         z6IJ0d7uDJTgIj03nBg50XEzfB9HCmEuDJ3vb593W6n87KQfyNvdpcdkcri3N9BiUle2
         3PF7yZU12H7CNtnj1X+/hR4HHoY4Fkw+FEuryVy1a+9tHjafhc+SPP1CpUv/vHyaenT5
         DcHoLPCc1SqVnUXYa4mJ0ewfpmnnmtiJX6eOxApMtYbqc61weTqHYiEbOiC0S5tmg7qC
         N1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781344186; x=1781948986;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSbIAxY/PzSgmritHJK40bRpcHkfHk/PE1pedi4ge0A=;
        b=Mtmqlq+INPQH5EiTNO5afJYWVjOYTU+nXGncE0Q96KmG8HuXY4MVVSDbrnW15jkNjN
         a1Pcbl6TnFEC/CNhep2ujKWZ8RWRBFQz0u9YgbSsAHI7q/cYlQsVu+J/tS0HW2ck2ivw
         TDj/WNEaZYX4h4qrVR1/VKRry7dVCpz9StgJkyRudiUhxVE2VQ/124OnRCUNMZV539g4
         WBS2slW4IuwywPI4OGB+umwkRSLMoliJ74qpjvOdBqjaT9UMRMTojMWBnJdGjGAiG6tY
         SZK3FbKXbHL+16zIfVugKlzOpxKqSLxKMUNwuRLBNSXL5OermFWxGvLsSzmcF+I7ajbx
         j/sw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZFaoLhnDGoNTNW2eA3GBElR8hXhuyrNHgnF4+gk+WJplTV6el7+gDcLN5+wJo69AQIVs3P3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBIcq6b7LYOxgP/8EgPuHeHMAE5C3Y+2hitDMTqCHM2atbclPA
	fje/wBIKKeBXX5g0igfQeF7nayBMK/JhNNeb8GAPYkDmB4Mf17agtcCAtsQ/4LNcvcrC1T55sk1
	ufqy7WsdYHZEVV3mhXC+QXNRE45yk3lv5A5Kk3PddKhCsjo6/0L5OF7uhJzWVvWHnJQ==
X-Gm-Gg: Acq92OHOc09oCKulbbP8aR6HEsfNCIUB+hXJcDCzXAcFcfW0xX9rciD0qHQUdPxSS6O
	KGGA7ZwN7ybKeRlmdFjL3aZrZNZES7DQgJkCF6fBt9MRNtyN1IAVk454CXtvbvi7Tv/KJkPY/gr
	qAzn7QUr/xbgEjMA7fz3dnmgvrxKLkOZphQwTIYdXFrXR0g0OUPxbdkkvcAxVS2RYTSCofAsUxm
	Fo/qS8+jibQ0t8S3OOSP+Z47g6ZHxaTgD3yyJyxKUN1b1Ex2cyWYwTIN2W9Cuf0BnZFGJpUAWFs
	EbvUm3YE3NYifnZOWdIFLexgYKG4BDy8fJj3BjRDV1tZZCTQm8K0CRddbI2JaiIxuU13R85fJXA
	Xr96By6IU5hULWvNHse3fNOr3til4dcXU92hYhV9yM5zBr2UZ+T0bBjY=
X-Received: by 2002:a05:6214:3a8b:b0:8d2:bb05:e5c6 with SMTP id 6a1803df08f44-8d32cabced3mr106841106d6.19.1781344185988;
        Sat, 13 Jun 2026 02:49:45 -0700 (PDT)
X-Received: by 2002:a05:6214:3a8b:b0:8d2:bb05:e5c6 with SMTP id 6a1803df08f44-8d32cabced3mr106840786d6.19.1781344185400;
        Sat, 13 Jun 2026 02:49:45 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d3045783b9sm47859446d6.24.2026.06.13.02.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 02:49:44 -0700 (PDT)
Message-ID: <7ede2980-e7ac-4311-99af-5cca54841f36@redhat.com>
Date: Sat, 13 Jun 2026 11:49:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2026-06-09 (idpf, ixgbe, igc)
To: Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
References: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
 <20260612120309.GA671640@horms.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260612120309.GA671640@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298940-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A554F67E4A6

On 6/12/26 2:03 PM, Simon Horman wrote:
> On Tue, Jun 09, 2026 at 10:24:53AM -0700, Tony Nguyen wrote:
>> Przemyslaw adds needed padding to idpf PTP structures to match firmware
>> expectations.
>>
>> Larysa bypasses XPS configuration on XDP queues for ixgbe.
>>
>> Khai Wen corrects offset into packet buffer when handling for frame
>> preemption on igc.
> 
> Hi Tony, Przemyslaw, and KhaiWenTan,
> 
> There is AI-generated review of this patch-set available on both
> https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
> 
> I would appreciate it if you could look over the AI-generated review of
> patches 1 and 3.

Going over such comments looks like pre-existing issues or things better
handled as follow-up.

/P


