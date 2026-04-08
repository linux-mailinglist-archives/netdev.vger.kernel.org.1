Return-Path: <netdev+bounces-276367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN/FAcMX1mnwAwgAu9opvQ
	(envelope-from <netdev+bounces-276367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:54:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F31F3B95A3
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1420B3005AB9
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D3238D54;
	Wed,  8 Apr 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iieoVT4M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A54X/sdq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7D35E94F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638462; cv=none; b=G0GJr/OyoBx17YD3WAZvZpPbkWCwzbejQOYgswadqy55Wm7NOhtFRWJZR6cQFfpOOu3YGF8shmSeSN5hTtwoDmSsOPEr7JgE4naW5KiSlbctUWK5Tw7f5luWgM0i2824DphtVo7tEFQq2AHY+0/tsDTw0LKexRqbiCnhBeVfD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638462; c=relaxed/simple;
	bh=Gq9JVzqu3RbrK+ulSwPbxKbAFCkTQzPJ7QGif9weboM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeUt8CKumOdHZMGGDbgq1Tw2fiDck5fnI0h12MHIKS6gxdBWFkzYh4l/xCNB+SJA+mY6Hdk9mXO1pCGu1xcWHit7F0gDoq08SLRnBgtfFx+RjdZndZRx+3MEXwC5fbwC8dAuGzUY8DgbGa1n5Wxy14O/xoBM9IOAywR27FVxUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iieoVT4M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A54X/sdq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775638457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gq9JVzqu3RbrK+ulSwPbxKbAFCkTQzPJ7QGif9weboM=;
	b=iieoVT4Mfr3gO3MH5aK/xACo6qtE5Q10ZfaVqcbPkF1S6KFEoMWhL8aKpxhAOpjSy4fG7B
	muhXHAR9TN/7Kj944L4I7qSF6dr/bFin8lNDzifLCoZb3Yn2HraenBLdSZRYTmhWYuLbiO
	5tKVWM6C4VsIBRk27e1n/4Wxfob90nE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-UBZyiKxxPjmUo_NJK3E1TQ-1; Wed, 08 Apr 2026 04:54:16 -0400
X-MC-Unique: UBZyiKxxPjmUo_NJK3E1TQ-1
X-Mimecast-MFC-AGG-ID: UBZyiKxxPjmUo_NJK3E1TQ_1775638455
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488b966e9dbso15447055e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775638455; x=1776243255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gq9JVzqu3RbrK+ulSwPbxKbAFCkTQzPJ7QGif9weboM=;
        b=A54X/sdqxCbh5zE6bd0JMH6I1k8ER3/+w4ZyVn6S5wHmyyJ+ECvdXV+ej+nuxG4sZz
         neQ4eY9JaBA1SWG8DoKbVeesxjc+e341PCqiEJKpRVGV4hwTfGjUUAHRK1v+uzaRUDzj
         /A7KdsHl85Hkq+pFwlLziPZAN6nZNh92czJSFPB7rYEyJNQTK6zDoixNl4zX95hM9qz1
         xxKrQd0CNZHDznBmMOWdVjpHly8DDH/fIjneoXQIUvu7LPnVv52DnLd2yxOcHuq8wlOp
         1O/eXw2JdV7CNHrYQyLPg/XpQzZxFxUbTmObLjKJsF6pU3D+zBkyqSrSkPj7hJKQzPWU
         JxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638455; x=1776243255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq9JVzqu3RbrK+ulSwPbxKbAFCkTQzPJ7QGif9weboM=;
        b=Z7nAZzmgpqLpSQKEJgaHQRZ7QvNHBb18w9Ej0gmzBhiAdjQKVeXx3F4uq5KmxkMLKZ
         kkiHlwODrRMP1o+3++d5as/bXUjCbioNWFUDM5N2hbUuni7pyJfi3msLHvHR7hnSyeC2
         oXLJT0DT9NOxOpSU5HNVnMXT2TKiJ/6qr2PH0bFpiIBK9R/IKBzZpefPghau0NfOq/Sa
         14cuNUdIHY54tMQQ5nStoKBI9VGKlSYFZPn9dapltNgyNW9npW7FN9/lD3kJcp/AvKoE
         e6LVkSNk+3tEihswGzRo91JTWO+fvctdTED3N5dQ3PUdII1xiXLI8wt5/+a4or98PTOU
         XkRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX2l+yk6+th06IUGg69m3jegDDlPaKFXrHDtCbVIwgaHbcq9d7lDtR4ggX6tpQSY2nLO68BWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDdW1lToX8rkirfWmDb3iMn7EFvxvjDhoIeViStz5qsMkLykK
	dPYqJ+4xiB4r8pOiJbFrEk1D3a9Ya7P6B35VIwQ1THrkDY/23blwf27Xg9/8UXd90rPhIQ1vkOD
	tgiZws+azb6aY8YNy5Ba2anCZfpFjH5Olmgg/ukF0d68o39vPcD+TnEm0XQ==
X-Gm-Gg: AeBDieveyg+ZNDlh4EcMm96J15lLFenyuWzl00ovzmtdEjV9HVyHMei24XYTVp01kme
	GdUVEXe9Y3YMKL53Yw9nX+BRYb8i59tzRt32qiEpfOozE7PAwTO9nzwXT8+METtpwdvB/B/lwJj
	o5e8m2iJHCbp+rAR8Ksmvgc6csMqPSZhWV6cp2Pbq9ww2ncr8yZLpm6GzgOgDoZw0tujgaq7KT/
	IoYISlfxO5OU8mhjweql1l6zweqAHnS+d9C0MWXUx2wsIZLWDUExmWznVuVP4B54lNNInjJJ3jd
	GLj0eYVroUZgwGJ1T32N0w9197UB6ZzfklDsT+rZgmv7O+Bp7ot2WDcrpSc1UD1Q8b+C3ynJl81
	aS2ePyIE7YqmX+19vLJ5N
X-Received: by 2002:a05:600c:5292:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-488996cd77cmr300561165e9.4.1775638455358;
        Wed, 08 Apr 2026 01:54:15 -0700 (PDT)
X-Received: by 2002:a05:600c:5292:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-488996cd77cmr300560825e9.4.1775638454876;
        Wed, 08 Apr 2026 01:54:14 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c76c6205sm15808305e9.1.2026.04.08.01.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:54:13 -0700 (PDT)
Message-ID: <d74a9071-336d-4fec-a061-bf9a3a444678@redhat.com>
Date: Wed, 8 Apr 2026 10:54:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix missing SMA pin
 initialization in DPLL subsystem
To: "Rinitha, SX" <sx.rinitha@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Vecera, Ivan" <ivecera@redhat.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260213141651.2231124-1-poros@redhat.com>
 <IA1PR11MB6241B58FF425A8684CFAE7A28B50A@IA1PR11MB6241.namprd11.prod.outlook.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <IA1PR11MB6241B58FF425A8684CFAE7A28B50A@IA1PR11MB6241.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276367-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,osuosl.org:email,intel.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: 9F31F3B95A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/1/26 18:29, Rinitha, SX wrote:
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Petr Oros
>> Sent: 13 February 2026 19:47
>> To: netdev@vger.kernel.org
>> Cc: Vecera, Ivan <ivecera@redhat.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet <edumazet@google.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; intel-wired-lan@lists.osuosl.org; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; linux-kernel@vger.kernel.org
>> Subject: [Intel-wired-lan] [PATCH net] ice: fix missing SMA pin initialization in DPLL subsystem
>>
>> The DPLL SMA/U.FL pin redesign introduced ice_dpll_sw_pin_frequency_get() which gates frequency reporting on the pin's active flag. This flag is determined by ice_dpll_sw_pins_update() from the PCA9575 GPIO expander state. Before the redesign, SMA pins were exposed as direct HW input/output pins and ice_dpll_frequency_get() returned the CGU frequency unconditionally — the PCA9575 state was never consulted.
>>
>> The PCA9575 powers on with all outputs high, setting ICE_SMA1_DIR_EN, ICE_SMA1_TX_EN, ICE_SMA2_DIR_EN and ICE_SMA2_TX_EN. Nothing in the driver writes the register during initialization, so
>> ice_dpll_sw_pins_update() sees all pins as inactive and
>> ice_dpll_sw_pin_frequency_get() permanently returns 0 Hz for every SW pin.
>>
>> Fix this by writing a default SMA configuration in
>> ice_dpll_init_info_sw_pins(): clear all SMA bits, then set SMA1 and
>> SMA2 as active inputs (DIR_EN=0) with U.FL1 output and U.FL2 input disabled. Each SMA/U.FL pair shares a physical signal path so only one pin per pair can be active at a time. U.FL pins still report frequency 0 after this fix: U.FL1 (output-only) is disabled by ICE_SMA1_TX_EN which keeps the TX output buffer off, and U.FL2
>> (input-only) is disabled by ICE_SMA2_UFL2_RX_DIS. They can be activated by changing the corresponding SMA pin direction via dpll netlink.
>>
>> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>> drivers/net/ethernet/intel/ice/ice_dpll.c | 17 +++++++++++++++++
>> 1 file changed, 17 insertions(+)
>>
> When SMA1 is changed from output to input , U.FL1 (input) is expected to get connected but is still disconnected
> Similary, when SMA2 is changed from input to output , U.FL2 (output) is still disconnected

Hi Rinitha,

Thanks for testing this.
The initialization patch itself is correct. After boot, the PCA9575
register is written to a known-good default state and SMA1/SMA2
properly report as active inputs with the expected frequency.

The behavior you describe (U.FL1/U.FL2 staying disconnected after
SMA direction change) is a pre-existing issue in
ice_dpll_sma_direction_set(), not in the initialization path.

I am addressing this in v2 of "[PATCH iwl-net] ice: fix U.FL pin
state set affecting paired SMA pin" with an expanded scope that
covers both directions of the SMA/U.FL pairing.

Is it OK like this?

Regards,
Petr


