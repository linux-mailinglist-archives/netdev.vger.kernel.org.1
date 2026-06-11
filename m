Return-Path: <netdev+bounces-297983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PuAVNrZjKmp6ogMAu9opvQ
	(envelope-from <netdev+bounces-297983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:28:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F266F61C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:28:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KVhKuf3G;
	dkim=pass header.d=redhat.com header.s=google header.b=EoYzBeNk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297983-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297983-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C76A830234D5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065483655E9;
	Thu, 11 Jun 2026 07:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CA363090
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:28:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162931; cv=none; b=sL9+PzVx6cfdfOX7lMZ5vFlUI0n+Q9gq31DAk+EN8SQBG8WgQTB6jM3PVvFX9QNO4eaWo3D1SrHiapvWAaWTvvmgnQMn9Pbfsvxn+BYVltNM47SoSQFEJQsZTndesIELWsV0/7YTTM7eXGRIhnsbbwT8PepglfyAax80y3gZh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162931; c=relaxed/simple;
	bh=QaqfHAczpbtT8cGTYb66uFZanVaUTd8LjL+QGZKif0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amw7NiBuiNxPI/v7InGpMTbMjghpq88qR9OEwPfNna4qsvH1yLbtaYGF8X9np7nSKzoI9xXywr1N9EK4z7GbV5wIrjzfSsv1u2M6iswjuf5MEhKocuwtSAd2mSZ1eQmE3IRRFf8EK4etCwazOCQGpzVT2UXiWH/DCXOAKQg3Sv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVhKuf3G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EoYzBeNk; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781162929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6EPp4PuFmtO2xH44RdCW6HHUd3lOCnDExqRH2uDRv8=;
	b=KVhKuf3GjoDryMrOQyymYAWBc0s97VmQnlzJEOucnjDD1Y6w3Upa5zZgrSuZu9nw/8EqJk
	OwDE6uZEcKYxa33SXkh92CNET4K/myjdGAejHvd4C3chw/ouEE8FwS1KYjHfT8txhbrugq
	6qQqNM3sFx/mhDaROLHFUDrrCD/TzeQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-8BW-PMYVP6anEX6PxWI8oA-1; Thu, 11 Jun 2026 03:28:48 -0400
X-MC-Unique: 8BW-PMYVP6anEX6PxWI8oA-1
X-Mimecast-MFC-AGG-ID: 8BW-PMYVP6anEX6PxWI8oA_1781162927
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-460129ef947so4572916f8f.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781162927; x=1781767727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6EPp4PuFmtO2xH44RdCW6HHUd3lOCnDExqRH2uDRv8=;
        b=EoYzBeNki9NsA/fFSHuJEwMKgHjb4ZGr0XUD/O5JcmFSoelIhMmDrzeku/XpAaIiic
         keZWIVYDNJlh4Hv5baASt1ayRKbGQ7HB4qYXsZKvcq3vqkZsVllKkJN/czKwDFru8xVl
         qEtulj2YZL7u61VUFjE7C7t6tLhFNqDjbPCtah3BLkrmu0cLYvWst0F1hJYoOkFzq99C
         pBV3ocH7bOwep5bGJPwiifgaJ8BkLSDcRV2Py256aEKQn3/pQiL1Q7pNl6Do/hTL8fj6
         Mh3g/eCP9riLohEeUa8k8wmrBGMf6WlfI5xyWA5s9dtT+Z1ukdRKN34xzzji1bJeQ+gJ
         aLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162927; x=1781767727;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6EPp4PuFmtO2xH44RdCW6HHUd3lOCnDExqRH2uDRv8=;
        b=KsaPU3m9P7U3cvFFoZUXFDxFCWG/HUPwSYqIRBThWUoxYo3C6U5+WkIBE6Cb3/Z/Hu
         bcR6j/gGJgyoAZuKspXYNj1jfhjSDpj25evhI5QeFKD6hvalw9Q7WPFftupucs0/yhd6
         VblQ3hsafYqfnyD7kSU739qXLvrmL2G9FJtVGpOQG1Ht3+/XE/K+OpXE56FKzhK6dpCC
         xc9N08eF96LXMhykaF47EqPHlWCAXkYXg/ymu/wg12fGUgnWvLJitXviVtAVzt9VYoVO
         bu2PzUjDl/4y5cyGlI+2xeicfujzQCSiEDt+sMp4OuwJXABTM99SKu8+q8ueo67EXq0N
         VzdQ==
X-Gm-Message-State: AOJu0YwpEAV7aMSbeIzEKBT8ual1P3ybDLtOosQS+CkOOEskuvBSWZ2x
	SbPgLIEWTKo14HRhD8sGUAZYHPKrxXVqNMTXuIpMt3Jky1Q+OIBEqaFhdZIhV0EKdRAIFACihgQ
	QR2WgyIq2h5j1Bd7/CyOps1qApImjztT7AE2a86p+DhaiKhK78kRTavLi2g==
X-Gm-Gg: Acq92OFvmzHZXyFhzTASaOiQ/ebT+oY0CpUhxU7P0dZVwQh7ifN5Nnu8j+M9kAv4qi9
	jnV9KFCLycuo2wuLSDzXrd5mm1KY9Yall3IixACq9hBCXJwISIVBiwy0W/4qmufV8uPdFglDcBl
	4OdCNET4M/KDD4ysTQ0vNnKmBzWx+G/LGyQEghSXtqoeoVpHJf16BgAJ6Np6rTsZQuo7BWJb348
	lZtSqStgG8vg4NtqoZmXXUoQZeAw0nhsQRkiU6YRr3RF3YLPPRgLDiIX8b5csOsgPAMuYNzuCxY
	ABqhJXw3UAyKWNkAEVPm2qXx0VoEtzMKeC6ZUvjTjSbbl4zSceu+BshbB2FHBG5zo1HmiPVeTSi
	k92cdP3NP2Vul2V7Mn1jsZ9uvaBBNH5CHAjv5VSdsugJPRCwGqbgXHkInTmLW0p66DA==
X-Received: by 2002:a05:6000:4687:b0:43b:5672:efe with SMTP id ffacd0b85a97d-4606758d337mr1416815f8f.9.1781162926788;
        Thu, 11 Jun 2026 00:28:46 -0700 (PDT)
X-Received: by 2002:a05:6000:4687:b0:43b:5672:efe with SMTP id ffacd0b85a97d-4606758d337mr1416793f8f.9.1781162926294;
        Thu, 11 Jun 2026 00:28:46 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm81186389f8f.13.2026.06.11.00.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 00:28:45 -0700 (PDT)
Message-ID: <7711d6d5-ff7e-4a8f-b69f-c06d1adec580@redhat.com>
Date: Thu, 11 Jun 2026 09:28:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: do not allow tunnel csum offload for non
 GSO packets
To: Gabriel Goller <g.goller@proxmox.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
 Willem de Bruijn <willemb@google.com>
References: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
 <178109396600.129329.5073003425673349392.b4-review@b4>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <178109396600.129329.5073003425673349392.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:g.goller@proxmox.com,m:netdev@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:virtualization@lists.linux.dev,m:willemb@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proxmox.com:url,proxmox.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C1F266F61C

On 6/10/26 2:19 PM, Gabriel Goller wrote:
> On Tue, 09 Jun 2026 16:44:26 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
>> [...]
>>
>> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
>> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
>> Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
>> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> Gave it a spin and it works alright, so consider:
> 
>>
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index f4adcfee7a80..07b8710639f9 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -6222,6 +6222,18 @@ static void virtnet_free_irq_moder(struct virtnet_info *vi)
>>  	rtnl_unlock();
>>  }
>>  
>> +static netdev_features_t virtnet_features_check(struct sk_buff *skb,
>> +						struct net_device *dev,
>> +						netdev_features_t features)
>> +{
>> +	/* Inner csum offload is only available for GSO packets. */
>> +	if (skb->encapsulation && !skb_is_gso(skb))
> 
> A small question -- should we maybe check for skb_gso_ok here as well?
> So add:
> 
> 	(!skb_is_gso(skb) || !skb_gso_ok(skb, features)))
> 
> Because skb_is_gso alone doesn't guarantee that the packets leaving virtio will
> be gso'd, they could be software gso'd at validate_xmit_skb, which is called
> after ndo_feature_check.
> leaving the virtio device.

Good point. Indeed disabling tx-udp_tnl-segmentation inside the guest
after successful VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO negotiation would
again break the connectivity in the critical scenarios.

Let me test a v2.

Thanks,

Paolo


