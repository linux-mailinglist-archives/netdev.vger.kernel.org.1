Return-Path: <netdev+bounces-280782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO+uEKQz6mkCwwIAu9opvQ
	(envelope-from <netdev+bounces-280782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:58:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C20453FAE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B29B3070378
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18033ADAF;
	Thu, 23 Apr 2026 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dV1tzpp+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnA0t39G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39582222CC
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956088; cv=none; b=NAc4RWup+Wz03Gd/o6yyceedatlqz6x9KG8Oxq8iFrEpD9RdBXm7gY/Tc/UBFhFeC+mw7dbumNiUo/o8qzBsla0elxVRUAMnNKOPmRksfyuCy6w70GW48Zw3lhcgwMzTAZQZDyoA2WW7qK1bgwCteOmtYOQZRBsTngAQVE30uqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956088; c=relaxed/simple;
	bh=hfUHLyKJSvrgtYgi0uQNctjhIyNjTTEmXV7g3LiZRcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSYZKWXIb5dCKtxMownxwy4LNXoFntwxAZixyiKWPkZpDhvUb7t4cmWtKH6juxuAfdAxgR3PYo1TWZuG072q7vgAhGV/2DrU+6oxu6So2saUyu18ofVhRDrbsMghfn3NPIy/nRhdTMi0cmh7Mne2fIEAPUp/hTzGkE90Vtk5IaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dV1tzpp+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnA0t39G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776956086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdUVkFiLAqBCJes+oJ0QB0pTbT2jdIw+uaSjtun6geI=;
	b=dV1tzpp+JGeoe/daPipG6Clwob+O64hgsnMkp/Z6gm4LfvThcwuXrqyra7fNPl5Bf3k/5o
	SgBJ7fyoo0bXcR5gXaF/kPX0b6yg/QaEUPv6jqntEycM0/mD/bqpTbd+pOJuHLKlEaeMkX
	Nv3o5nC0r44dUQVn0A7yIk1na1bQ4Fw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-2uv11gLVPuuo0B-kh0uPnA-1; Thu, 23 Apr 2026 10:54:43 -0400
X-MC-Unique: 2uv11gLVPuuo0B-kh0uPnA-1
X-Mimecast-MFC-AGG-ID: 2uv11gLVPuuo0B-kh0uPnA_1776956082
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so4264436f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776956082; x=1777560882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdUVkFiLAqBCJes+oJ0QB0pTbT2jdIw+uaSjtun6geI=;
        b=CnA0t39GN66aBCJ4CDapQLEd1l/vYCwSFJVzw3qIP3LONwah90G/Q3P4BoRjL3USHz
         tlOtLuR5Y0ss5TTjpQe3njEOdeveV068jGv89jjpLnQYln0ZleIpCcJMi9xrBS/9Ntsm
         s/H6E2YaeTs6uFA7TanZZHwDwQbcJ2rqKI5s0uSDpTgiuOREN4w9JVWTKwXA3jqLUvwl
         CCfhjaQvTG2pmQ9JqeqQJe5VMtWaIqQn0SxeX4fu89daIa+IbvmplirS96ucOMLOJgFi
         0ExVMmPcmx3srJbPUgKDIB7HRFXG6bChJez5ViuIwziPCcsjoB4YCtadti4McbKqCOMq
         NsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956082; x=1777560882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdUVkFiLAqBCJes+oJ0QB0pTbT2jdIw+uaSjtun6geI=;
        b=Ard0y83cdncR8vIXS7tKeefDmm7TzfaOJ1Z0diVk3FmmyW42SsaW4KMvT8xOPa+8PI
         ztDnF/sG6F+hWJt93UEXAdQ/HvN7iHHYA4dJtenLVHZUsZK2rHj6xNvrIForPgvkpNJL
         BXCks+Cghfy9/Kx/uBzvvwL0d6xxX0OwCB3mJXLJXgvSxXb8tEN21jEVvqzkg7CNfCUt
         BCzamhYngFZVcnTU5/oS8pvM6iqmajE+dz/mmF6PSMQYxQ/Yswos2NSLglA8u2MbvBn8
         pJx7CSKMO0Jb/cqmcg9d6A4MndUnlCfLM5rzLNifZVO8125y2tlBSy9xRfHrxTBxW9oy
         GrBA==
X-Forwarded-Encrypted: i=1; AFNElJ/s+PYsre59PqETp6hRvyJ/CslJUA2Nr1fH8DvFF3d7JaXLGAStf0bQtW2mvsagN4nKQeBQ7ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAgCFRCUq5GeLglPZuTfCOPMatj0dBLbBvdfo8yDshu/5XWp3
	+WtWpnix8dh0uZl7OA6s46lu2H1iJRSTKH4R1u+r6Ux+Tj21pn7pKTytGm5OXMvqCYEiUj3JfEG
	njJssuSR2rflPaiL+WG3GsUObbh56mCObN2s47dPT2COjRM/2d4xW6Zz/Mw==
X-Gm-Gg: AeBDieu5rhGJ0hwRMihhKze8imLieMq8kUSPhGqIGUQlk6dIoJZt9nyBd383rIS41J0
	UzWh/dnElAt8P/10dgG8DbADTcA43+HVd7ZZr8XYjjL0uQURCA/MayjPft0DlLIxK4NzzqLMDaO
	YWr67MXAzryakQ2kwsVt16G1UneBsGivbQOnc0XeHVoQyF51m8vQ2jheuH/rmz+805TFGs+gCHp
	4WXfAwMHUOwIhl9GYGIoQ0UBTppj77GgkdEF5Z3pKckDZrIky9+pFz/Mm0EY22sIS5hr5MRU43c
	04ZFOXoBi3EutaD02PhOPFPDnZ0O23RYweETgB1uybeaYUYGxMNsI6b/iRzJ5o72HTGY/gQmbUZ
	CD/GEw89OSsZFlmqACTWN3Zk5ITdP3PgaWAnCJi+TJlgKlw7FlE+P2eXJ+VhGe5xcl2s=
X-Received: by 2002:a05:6000:4a1a:b0:43e:a8d8:f3dc with SMTP id ffacd0b85a97d-43fe4052190mr36059641f8f.13.1776956081716;
        Thu, 23 Apr 2026 07:54:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4a1a:b0:43e:a8d8:f3dc with SMTP id ffacd0b85a97d-43fe4052190mr36059588f8f.13.1776956081154;
        Thu, 23 Apr 2026 07:54:41 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm52345982f8f.33.2026.04.23.07.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 07:54:40 -0700 (PDT)
Message-ID: <8e81d2a9-e095-4687-ae37-e4328bedb7a6@redhat.com>
Date: Thu, 23 Apr 2026 16:54:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux@armlinux.org.uk, tsbogend@alpha.franken.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org,
 idosch@nvidia.com, jani.nikula@intel.com, mchehab+huawei@kernel.org,
 tytso@mit.edu, herbert@gondor.apana.org.au, geert@linux-m68k.org,
 ebiggers@kernel.org, johannes.berg@intel.com, jonathan.cameron@huawei.com,
 kees@kernel.org, kuniyu@google.com, fourier.thomas@gmail.com,
 rdunlap@infradead.org, akpm@linux-foundation.org, linux-doc@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bridge@lists.linux.dev, dwmw2@infradead.org
References: <20260422041846.2035118-1-kuba@kernel.org>
 <aeh0CV3UQw1quCXv@ashevche-desk.local>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aeh0CV3UQw1quCXv@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,armlinux.org.uk,alpha.franken.de,linux.ibm.com,ellerman.id.au,gmail.com,blackwall.org,nvidia.com,intel.com,mit.edu,gondor.apana.org.au,linux-m68k.org,huawei.com,infradead.org,linux-foundation.org,lists.ozlabs.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-280782-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9C20453FAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 9:08 AM, Andy Shevchenko wrote:
> On Tue, Apr 21, 2026 at 09:18:44PM -0700, Jakub Kicinski wrote:
>> Remove the ATM protocol modules and PCI/SBUS ATM device drivers
>> that are no longer in active use.
>>
>> The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
>> drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
>> over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
>>
>> Removed ATM protocol modules:
>>  - net/atm/clip.c - Classical IP over ATM (RFC 2225)
>>  - net/atm/lec.c - LAN Emulation Client (LANE)
>>  - net/atm/mpc.c, mpoa_caches.c, mpoa_proc.c - Multi-Protocol Over ATM
>>
>> Removed PCI/SBUS ATM device drivers (drivers/atm/):
>>  - adummy, atmtcp - software/testing ATM devices
>>  - eni - Efficient Networks ENI155P (OC-3, ~1995)
>>  - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>>  - he - ForeRunner HE (OC-3/OC-12, ~2000)
>>  - idt77105 - IDT 77105 25 Mbps ATM PHY
>>  - idt77252 - IDT 77252 NICStAR II (OC-3, ~2000)
>>  - iphase - Interphase ATM PCI (OC-3/DS3/E3)
>>  - lanai - Efficient Networks Speedstream 3010
>>  - nicstar - IDT 77201 NICStAR (155/25 Mbps, ~1999)
>>  - solos-pci - Traverse Technologies ADSL2+ PCI
>>  - suni - PMC S/UNI SONET PHY library
>>
>> Also clean up references in:
>>  - net/bridge/ - remove ATM LANE hook (br_fdb_test_addr_hook,
>>    br_fdb_test_addr)
>>  - net/core/dev.c - remove br_fdb_test_addr_hook export
>>  - defconfig files - remove ATM driver config options
>>
>> The removed code is moved to an out-of-tree module package (mod-orphan).
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> v2:
>>  - keep BR2684
>>  - correct the claim that Traverse Technologies is defunct,
>>    I'm still deleting the solos driver, chances are nobody uses it.
>>    Easy enough to revert back in since core is still around.
>>    The guiding principle is to keep USB modems and delete
>>    the rest as USB ADSL2+ CPEs were most popular historically.

A possible alternative would be moving the solos driver (and others
similarly old, possibly not used anymore drivers into the staging dir
(and let them be removed after some reasonable grace period).

/P


