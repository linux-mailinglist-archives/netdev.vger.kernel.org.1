Return-Path: <netdev+bounces-296989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DaDMCInYJ2oB3QIAu9opvQ
	(envelope-from <netdev+bounces-296989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:10:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D64F65E20A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:10:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="CaMXA/CA";
	dkim=pass header.d=redhat.com header.s=google header.b=f8jUnCKA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296989-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296989-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F26B73131950
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995693CFF79;
	Tue,  9 Jun 2026 08:55:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586EB370D4C
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:55:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995309; cv=none; b=co2ARpZNqX6LDTVeYRKNnz6rO99JqRNikQLs5abS6IzYIUX2zcPrsdNFeK8m7dg5lpIn7stobvthRhToQOgT72oSJ81Pz8FdKpq2nAAQoBRBIqBxPW2l74mzhohCRr9gCo9AQQcSMOkg91s2pUrq4zDZKa+edJ30oaXCJVv2LpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995309; c=relaxed/simple;
	bh=vtqnwbB0exq37hW3K5DWsmY1WEmWotF0SoGjv67OpdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSaNDEO9hbMYwvXpD+or9rrPRu/nOc82WF7tqEFyA6y6zIZEb8y6MHuBDJl//iK/pcyo10WhkuF1HgU5AdAUcrq4+8+TfLPgTSgreN79h2AlRstj5P6rpfBb5gLIJOaR20KJW8YPfpcVKwGSMVCe+KPctw0niBPQd6VcwuTGcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaMXA/CA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8jUnCKA; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780995307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFkXaKSGjNQUZCN8lLg50D94jNF33SHSoppUjLuz1kw=;
	b=CaMXA/CAdfKrld4YDy0ogyhSdkuTD4UO4ofTQAo1V1pkxwVad+aQR09kamyGMlgHYSMwNC
	pG6PxEoziSAhlSWgm+R59tfohzwTcgNGcbpzhPdCaoFAZ03v9lWIFLGKWnRar/JDIDgzOM
	lY8j8+LhXQI0Amkfnzz103mUtuKmmrM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-o3mxBRBpN1uDatCe1coDOQ-1; Tue, 09 Jun 2026 04:54:04 -0400
X-MC-Unique: o3mxBRBpN1uDatCe1coDOQ-1
X-Mimecast-MFC-AGG-ID: o3mxBRBpN1uDatCe1coDOQ_1780995243
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso3355018f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780995243; x=1781600043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFkXaKSGjNQUZCN8lLg50D94jNF33SHSoppUjLuz1kw=;
        b=f8jUnCKAhJdcTbd5J1xk3YEJDzWn/aJpRquLRn7PNEEWrq++JX7tHLCQ5RapcG8V8O
         9/jFGu5PXhb52RHckWSKSOioYg9S/ccscjfSs3PEELNboryUU+08a3BuibMHP+lNY7wT
         fzJEsk748xf2rkIMkJ82oOeOs71Du1UwQaFsPhirL/OikRy4M6oXzs1FSvEVrGLd0mGc
         bhm2itqZn9jsSW1qsmA9Ov6mSD+2B8d72VNPV9stF0MSsTk+zRDBLh7KyaaU3oFAgj4U
         9ZiCXPfrVjNyH6hf8vsb8/ncKKxq3/wK4TfBZ/qSxlfzfV8/4s4FhXR1knGCd7jXtOUw
         PJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780995243; x=1781600043;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFkXaKSGjNQUZCN8lLg50D94jNF33SHSoppUjLuz1kw=;
        b=DQljfoUe7Z5GyuZ6uHjJ1G2358pMBE4veo7WHto7CPnp+I578jI3j0iD1+z2dqqnkX
         /drtGdjcHhQsJbDM2ngkyNmZ8O2wENfB0iUzx5zG3DcdEArViCos4oknoFZrExi4u+Ee
         JqSIvmZy8SIgbDPBr0cySgjVvvjRSgh4tbKc/NY3M1KTqR2edZzlHrt5aQrWBfd55Iwh
         R9r0KSZ7lr7lY35f5FkqFNNlDztsr7/73MToXiGLLvgPhqJ+6vxRS3Dj3MGO7vL4dsFe
         GdQPRHZyuUp8RTc6jESsABSIftNQpUI5eRTvU72bLFjnFye9A5y8x1XLFMBrrype5X+6
         3ONQ==
X-Gm-Message-State: AOJu0Yz5WXvDQ5hJLUlinV7kObessb7AiSo5IQ1VuHDjxh1iCMGmWzPC
	aI9HcczGxxfJH+gx8o0NVia9drGoeb8ZyOrAPyvWYIADXNG5RNbFF/mKZ0uwEzz16ybavgaIcL2
	zKe018FptE4/jjVkaArkm7BDqZizjcGPczydDlm2GUK7do+OH0q8jL1leeg==
X-Gm-Gg: Acq92OHnBfrOWFODjW0PNs6BA+6/MUjtsUeT40qN7snYSZfuAFqBRj4r58RMqpU2/E/
	XEK9P4SaAnx5kMtx9Qbagh6e2wwf+X7hx3g3pgXg7KuHDVcfWGtEKMm+ERj3MbfdwmY+FONrR3q
	FWa/MX3MyQgP/oJrOEQFOBWrtYuHY8DPNo10uIiujP70RKAhSbUo0wfV9Rxvm1ku5QIIeplznFQ
	7HVpSJlsUBFkh34xs3aQTyxB7z9uf6dmxcHcn1ijyAzd4HqGDxHY5J4iu8TePhNY5POwr4y05sc
	RNQgLv+qMeFc0wRy/+VNbU7nRPdIzmv8BYP3n+GIZtiEJVA+axitGDyaFm2Ny9Qrk4n76tFHsOq
	kX8qngzXe6cvqqKdIEfIvYKrTjbib1SO/GRvyQx82XxkxTU9TDiH6LdirSETIrtngrg==
X-Received: by 2002:a05:600c:3f0a:b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-490d71fa51cmr19821795e9.9.1780995243334;
        Tue, 09 Jun 2026 01:54:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0a:b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-490d71fa51cmr19821465e9.9.1780995242881;
        Tue, 09 Jun 2026 01:54:02 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm409565745e9.1.2026.06.09.01.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 01:54:02 -0700 (PDT)
Message-ID: <377b117a-b29a-4761-aae0-3236be1f0b49@redhat.com>
Date: Tue, 9 Jun 2026 10:54:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 4/6] bonding: 3ad: fix carrier when no usable
 slaves
To: Louis Scalbert <louis.scalbert@6wind.com>, Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, fbl@redhat.com, andy@greyhouse.net, shemminger@vyatta.com,
 maheshb@google.com, jonas.gorski@gmail.com, horms@kernel.org
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
 <20260603150331.1919611-5-louis.scalbert@6wind.com>
 <1041444.1780954642@famine>
 <CAJ5u_Of1+eEL4iVe-sWzhOOva6xx3gPCeXeRP4Y3yCqny8=gOg@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAJ5u_Of1+eEL4iVe-sWzhOOva6xx3gPCeXeRP4Y3yCqny8=gOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-296989-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:louis.scalbert@6wind.com,m:jv@jvosburgh.net,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,jvosburgh.net:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D64F65E20A

On 6/9/26 9:56 AM, Louis Scalbert wrote:
> Le lun. 8 juin 2026 à 23:37, Jay Vosburgh <jv@jvosburgh.net> a écrit :
>>> @@ -1179,10 +1194,10 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>>>               switch (port->sm_mux_state) {
>>>               case AD_MUX_DETACHED:
>>>                       port->actor_oper_port_state &= ~LACP_STATE_SYNCHRONIZATION;
>>> -                      ad_disable_collecting_distributing(port,
>>> -                                                         update_slave_arr);
>>>                       port->actor_oper_port_state &= ~LACP_STATE_COLLECTING;
>>>                       port->actor_oper_port_state &= ~LACP_STATE_DISTRIBUTING;
>>> +                      ad_disable_collecting_distributing(port,
>>> +                                                         update_slave_arr);
>>
>>         Is there a functional reason to move this?  I don't see anything
>> obvious in ad_disable_collecting_distributing() that depends on the
>> actor_oper_port_state.  Since you want this to be backported via stable,
>> fewer actual changes reduce the chances of an issue applying the patch
>> to an older version.
> 
> The path is ad_disable_collecting_distributing() ->
> bond_3ad_set_carrier() -> __agg_usable_ports(). __agg_usable_ports()
> reads port->actor_oper_port_state
> 
> It was found by
> https://sashiko.dev/#/message/20260526084048.1696544-5-louis.scalbert%406wind.com

@Jay: it's not clear to me if you are ok with the series in the current
shape, could you please clarify?

Thanks,

Paolo


