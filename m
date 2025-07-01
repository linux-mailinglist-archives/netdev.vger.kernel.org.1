Return-Path: <netdev+bounces-202778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9D5AEEF91
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC2817BBAE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF125C807;
	Tue,  1 Jul 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObiJIHUq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102D25CC4B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353998; cv=none; b=maNagL0xsKtmRVJtLYAA04VfrcOyU5w1hxq8gx+Ut3I9TFcLOq5VG6F6DaPvX9gvOD1fOptwiRtK1tCi/p3/9kd3VG9K8TIT9wYNA5xXUYMspRQi9Tb0jVG1mmC96uKjFrlTRb6aF1MrjeP/7NHj6L1TOLlAuDhuPr4NDgN1b/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353998; c=relaxed/simple;
	bh=+GlJB6XuAjDtV72+76yY6A2Araw683xgMAKMOfq0uyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdgwtZA4UbzY8aMW9d44+ySMYB4eAGuI1ZPHUJ6H/6VQ8cx1t1P69pnl0SevZdZeNcfGQGhaZ7RqsnCK4c/v254AwOWisVgA7g7tX5zCQo+6qxDYxvwaAy7gMSOftUYTS5tXpS+LyUCnsL45UUYc/R/vTF080qOKTiVyCzdayPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObiJIHUq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751353995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tyD5jqS4b0RnDvAiI4jcKA77puvcHT4CLp5MXzgbY3E=;
	b=ObiJIHUq6+WYjbqjOKI6jz4iXO5RdREh3znvhXH/onrjCc6BRhv/2VRZR/LgAPqT+ipBXo
	FXdAma5kyZoHOwDJWnewbFb6vn/gkbS+9ItGZwiXrBts9XCypSAQCFUnQ31N157Z32Aqo0
	OdU5IpPzlECF/FSzPQj7BoMzT/3uFWo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Q1IOmFOvO9-aBWzNCg8jGQ-1; Tue, 01 Jul 2025 03:13:14 -0400
X-MC-Unique: Q1IOmFOvO9-aBWzNCg8jGQ-1
X-Mimecast-MFC-AGG-ID: Q1IOmFOvO9-aBWzNCg8jGQ_1751353993
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74927be2ec0so4918504b3a.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 00:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751353993; x=1751958793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyD5jqS4b0RnDvAiI4jcKA77puvcHT4CLp5MXzgbY3E=;
        b=O2/YyeVHbjZaB3+NV1BRvbbZKzkLLh8rPQaM2EAyd8SUYWhW7WZyJMdRVlQSJg2Clc
         ok+u9M7TVlXQZkLP8d3kUY5ScqRAqC8dfrK/QJ2Iz4yF2pjEdzYY9JdDztGkAQziPF6d
         FvAEoj9proKi62VK0KAyYCskTZ53nNtD21RKPsRCecIP5f1RFepUz8jLCiKICmqZ4v8X
         vqYn5YUJsn6XP4dzCZt3/1yc2pDRQQMWRR7Xt//tE9PmjnSp3YIMzL/7N5pyUb4nhLVA
         8pGlGoFQMNRIbcNOqlPr1hHzaA7znm7orx40S6BUgj7MaCg4Nx3F0fNZfr6cMY4osUPS
         EJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs76Li8EQxWGijQpkcBWIngoMeEHj8zVuRKZ5YRkT2uWcC7z9NA/pUOHv5CC8LYDtD+R0uyK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy586kT0rmwm/jcHmMXcLLaX4kplXJrqVMXIeFfv3eRNlCXBg99
	Lx15od5QStnik3FcQ8A+tS5q/lpySUIp7h6lhan1ggNuprU73S2ZNKaMc5R7wkM+beXtwz7b6gT
	ArbSPvqAPPgA1zNAZKejYpK0sbo59T3dBZ+SrhW8h1KLIIrJNMU5VaNZC
X-Gm-Gg: ASbGncth2JauZCVoPwFQttMlykonHhIS1X7FKVdlFP+EJdy1jAAmERo+gJyi/nmSWU4
	TJ8+0ruv9+dtyxW8S/RmQGFmfrH+cpYtHuL2c4i3VwSkPQCmKW1pOa+uJs6AVAvc9BHtI6zLjEG
	Jny/prtaT0qYgmqWSuAVjrLHoVOfjbWGlJoSNFYzZmAGX12+u0+wGvyMxDRIyywYWLbXzQCERKw
	BhCQ0PumXPPnR8/ndI/d3llpq/ar/21ckbyQWN6jpgZ8Fn/cXQpwLYt2DxDOueHPDZ3eUGgiJy8
	9xNzQvOTLgGG+w/TxXnI
X-Received: by 2002:a05:6a00:2d95:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74af6f26d10mr19176494b3a.15.1751353993532;
        Tue, 01 Jul 2025 00:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVlMVvnGZ2sGTXiWfzjbWSUwoPb2Vo2GHc/Z+DRV2t7geGqZG7Smv4ky6vWnE6J34Fp2R3+A==
X-Received: by 2002:a05:6a00:2d95:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74af6f26d10mr19176471b3a.15.1751353993214;
        Tue, 01 Jul 2025 00:13:13 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57efae1sm11025838b3a.163.2025.07.01.00.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:13:12 -0700 (PDT)
Date: Tue, 1 Jul 2025 07:13:06 +0000
From: Hangbin Liu <haliu@redhat.com>
To: David Wilder <wilder@us.ibm.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
	Pradeep Satyanarayana <pradeep@us.ibm.com>,
	"i.maximets@ovn.org" <i.maximets@ovn.org>,
	Adrian Moreno Zapata <amorenoz@redhat.com>
Subject: Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <aGOKggdfjv0cApTO@fedora>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
 <aGJkftXFL4Ggin_E@fedora>
 <MW3PR15MB391317D5FD3E0DCE1E592EE0FA46A@MW3PR15MB3913.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR15MB391317D5FD3E0DCE1E592EE0FA46A@MW3PR15MB3913.namprd15.prod.outlook.com>

On Mon, Jun 30, 2025 at 04:19:22PM +0000, David Wilder wrote:
> 
> 
> 
> ________________________________________
> From: Hangbin Liu <liuhangbin@gmail.com>
> Sent: Monday, June 30, 2025 3:18 AM
> To: David Wilder
> Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu
> Subject: [EXTERNAL] Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
> 
> > On Fri, Jun 27, 2025 at 01:17:13PM -0700, David Wilder wrote:
> > I have run into issues with the ns_ip6_target feature.  I am unable to get
> > the existing code to function with vlans. Therefor I am unable to support
> > A this change for ns_ip6_target.
> 
> > Any reason why this is incompatible with ns_ip6_target?
> 
> Hi Hangbin
> 
> I am unable to get the existing ns_ip6_target code to function when the target
> is in a vlan. If the existing code is not working with vlans it makes no
> sense to specify the vlan tags.
> 
> This is what I think is happening:
> 
> In ns_send_all() we have this bit of code:
> 
> dst = ip6_route_output(dev_net(bond->dev), NULL, &fl6);
> if (dst->error) {
>         dst_release(dst);
>         /* there's no route to target - try to send arp
>          * probe to generate any traffic (arp_validate=0)
>          */
>         if (bond->params.arp_validate)
>                bond_ns_send(slave, &targets[i], &in6addr_any, tags);
>                <.......>
>                continue;
> }
> 
> ip6_route_output() is returning an error as there is no neighbor entry for
> the target. A ns is then sent with no vlan header. I found that the
> multicast ns (with no vlan header) is not passed to the vlan siblings
> with the target address so no reply is sent.
> 
> The ipv4 code is simmiler but the arp is sent as a brodcast. The broadcast arp
> will be propagated to the vlan sibling (in the linux vlan code).
> 
> This could be a testing issue,  I am unsure.  Can you help with
> a test case with the target in a vlan?

I can reproduce this issue. I guess it's because the IPv6 route code is
different with IPv4. I will check this issue.

Thanks
Hangbin


