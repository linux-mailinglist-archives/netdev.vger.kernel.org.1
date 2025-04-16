Return-Path: <netdev+bounces-183061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F5EA8ACC3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED32189FA15
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AC51CAA97;
	Wed, 16 Apr 2025 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pieli/QA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093B81E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763719; cv=none; b=LRyMl5kQMo2v5/ZJx1yAzqWwYuAxRMp6CBlYWHm93PWzfogHIApyRnJk8D2WYWdoMnO5KAZN/JIYOAr+Glr/1sEiF2PEmPEEp/8hFEfDqQC0WpzSreuetdfMczOBOK9dDOhVJr/a1RO6UDvNAr7tPV8Nq24mhZikAfAm3lWNpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763719; c=relaxed/simple;
	bh=c3w/cww/hKY8YsDyvfqlOtU6pCx4OZRIDJ09qMpdmKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkJm5ufMPqiYLXtBc1Oy353NGnxtV40pvT48Xe9t/misBgzb6YM4SXTuqvP/G3U9UFmKndjsacZAY7TuX3KnMiRLSnMNFE0yaYoHF2+lI+37KMK28/Rj/q+N29Ru8vQNsns1OkExxwNaC3Cv49eeR05Xz1JX6rfjLiZa4+4aZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pieli/QA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744763715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OqQ1YTSTJJUKkFlxIuDS71mLe4oyEpxEPnrftDCzEKQ=;
	b=Pieli/QAUojwzFlHy2yF89PlrvYBv2JVZcE6QzALkR71A3XeUfa6gBN3QMfhNTw5HpP5iU
	AE8k60YUXFA7n+2NMZaAIRSPtNdWy3JOuN4k0/2w7FqSeN4u8ryDBtkw7fJfjMxA7OQ3GI
	4mZg4ZX2iEdZi6sCcUGQXPC8xCk+eXk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-W2frdVDqNG-XI8jGJp6G0g-1; Tue, 15 Apr 2025 20:35:13 -0400
X-MC-Unique: W2frdVDqNG-XI8jGJp6G0g-1
X-Mimecast-MFC-AGG-ID: W2frdVDqNG-XI8jGJp6G0g_1744763713
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7370e73f690so6662361b3a.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744763712; x=1745368512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqQ1YTSTJJUKkFlxIuDS71mLe4oyEpxEPnrftDCzEKQ=;
        b=Dz+fec2on3relCL8sxWcSt3wRo5GMmIhvnMXJarAIO2uB4tM8efNd0gHr+xR1eYFjS
         KiYCNuvxboDp2NgVYAKuxgW06ahk7RWgk+47K8Vp6CW6DTuJUHHetp2DzU8fKcpsCrZb
         Pj93nzWaQs7Xat3yN7cGgEpWnXTF8defRYyOMiPrT2c48jIMHesE7T3kU3r6cxkweWZi
         sWsRLg7qEM9O3xaoZ/AWf6rG//R2i89n6zOkMjYSI9F7Y2lnmciiosr3wW6/IxDH/m65
         h1osl7lZmKA9tV713HCpxfQy55gIIUvGeKtpenUXolumKhHmq/0QLcm6ATYvM4b69ppz
         4s5w==
X-Forwarded-Encrypted: i=1; AJvYcCVOwagF8os/h+/qNw18xhpAfuevV+/VXDpxUdIlbTg5w4LA8l76W08R305ee2BYqSpcJKKKkk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAlvFpkdLV1CjWty6e+WwiI4rIZZW3xpPxeRoyJQYii9EV3E4
	gMi2eMpm4kYmxL9DA2Cc+JYfdSfYhoBuU5ne4fCzGW3M/OTLgSpJqOgJjQ4U3fkN0fLv88KfbvL
	Oiwq8scxJhmW2GOJbl0S6mLqc6VZVlV4Uj8VtHD6nREijGd+8LnR3
X-Gm-Gg: ASbGncuatvqbWg0xOTZU8+i3cHT7E2XI4/G8mZsUpPrgiqPdxhN0gjwn+l+qgWuyTT9
	aQeJdYZL33zRgB04OgByq48QP2XRKlEHQ7obTR6ppUYbmh5AyNjvzPlC6u3jyaAnN1gora+FLdv
	P+g8IMJCTvLnODS/W76xT/r/Ukcw76WjkHRZfobGc9J8Pv7RRHWSRbbgGaTKJ1TBWAJno47DQnN
	B9Kir7EmNpQ3VMk99HsTP+/wkXUPIukL0eo1s03mz4BqsjlrcqGxv/aSxjLL5f+H/ppWW5WN8je
	p12rHwDJSg==
X-Received: by 2002:a05:6300:668a:b0:1f5:87dc:a315 with SMTP id adf61e73a8af0-203adfc1699mr1499052637.12.1744763712635;
        Tue, 15 Apr 2025 17:35:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESmh55jz+291Dq/91ibqxucuc/JG+x5nUer4M3PeJgsNIbjMm0hVYWqRPMhIQzq3z2y9FxFw==
X-Received: by 2002:a05:6300:668a:b0:1f5:87dc:a315 with SMTP id adf61e73a8af0-203adfc1699mr1499027637.12.1744763712230;
        Tue, 15 Apr 2025 17:35:12 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b220e9d35sm151243a12.38.2025.04.15.17.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 17:35:11 -0700 (PDT)
Date: Wed, 16 Apr 2025 00:35:06 +0000
From: Hangbin Liu <haliu@redhat.com>
To: David Wilder <wilder@us.ibm.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Ilya Maximets <i.maximets@ovn.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
	Pradeep Satyanarayana <pradeep@us.ibm.com>,
	Adrian Moreno Zapata <amorenoz@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP
 monitoring with ovs.
Message-ID: <Z_77On1togfQ1vgM@fedora>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com>
 <3885709.1744415868@famine>
 <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
 <MW3PR15MB39135B6B84163690576F95FDFAB02@MW3PR15MB3913.namprd15.prod.outlook.com>
 <4164872.1744747795@famine>
 <MW3PR15MB39138C432D2CD843C20C0C10FAB22@MW3PR15MB3913.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR15MB39138C432D2CD843C20C0C10FAB22@MW3PR15MB3913.namprd15.prod.outlook.com>

On Tue, Apr 15, 2025 at 10:13:18PM +0000, David Wilder wrote:
> >>> I agree that adding options is almost never a great solution.  But I had a
> >>> similar thought.  I don't think this option should be limited to OVS though,
> >>>as OVS is only one of the cases where the current verification logic is not
> >>>sufficient.
> >
> >        Agreed; I wasn't really thinking about the not-OVS cases when I
> >wrote that, but whatever is changed, if anything, should be generic.
> 
> >>What if we build on the arp_ip_target setting.  Allow for a list of vlan tags
> >> to be appended to each target. Something like: arp_ip_target=x.x.x.x[vlan,vlan,...].
> >> If a list of tags is omitted it works as before, if a list is supplied assume we know what were doing
> >> and use that instead of calling bond_verify_device_path(). An empty list would be valid.
> 
> >        Hmm, that's ... not too bad; I was thinking more along the lines
> >of a "skip the checks" option, but this may be a much cleaner way to do
> >it.
> 
> >        That said, are you thinking that bonding would add the VLAN
> >tags, or that some third party would add them?  I.e., are you trying to
> >accomodate the case wherein OVS, tc, or whatever, is adding a tag?
> 
> It would be up to the administrator to add the list of tags to the arp_target list.
> I am unsure how a third party could know what tags might be added by other components.
> Knowing what tags to add to the list may be hard to figure out in a complicated configuration.
> The upside is it should be possible to configure for any list of tags even if difficult.
> 
> A "skip the checks" option would be easier to code. If we skip the process of gathering tags
> would that eliminate any configurations with any vlan tags?.

+1 for "skip the checks". If arp_ip_target=x.x.x.x[vlan,vlan,...] doesn't
ask bond to add vlan tags, there is no need to set the vlan in parameter.

Since OVS, tc, netfilter can add vlan or change the output ports. A "skip
the checks" setting looks more reasonable.

Thanks
Hangbin


