Return-Path: <netdev+bounces-221061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3549AB4A025
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 05:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268F01B22ED8
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45752741CB;
	Tue,  9 Sep 2025 03:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV6ru+sT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2710C5223;
	Tue,  9 Sep 2025 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389352; cv=none; b=DPhTpvHeLPEoheuTkYGJU4k6PjIVscK5X6iVcqUJm3nQ/Hx1IRLyNbmeGvfLMf7lQjeavottdjutQkAvpPM7tsOBkE+I3LHWxgW73pGysoIFG151esP5izZr4pcAyOvkCQt98B6NdW7/PMBA3ckbQpTjhxm/nH5Vnb15aksbfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389352; c=relaxed/simple;
	bh=1Ae+/fwtT4ZRD9qxLS/6YMdSm81I36JERH8lzddxHxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PleEs+qkOMW/adlIAYVPbof4FGS/6Qz2EFYoWmP+inhQ7QQMKdrRlsm99Vo5a7IlDrOovl46lYlDx+tdVSSJBws/F9nGcUf7bf6Cfey3s/Jnnd9Ve+UOl4lKqga63ZW4QnRU/6H2a9T5xPfL53taH95lzO4tlYcW0BThy7xmGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV6ru+sT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7722bcb989aso3865085b3a.1;
        Mon, 08 Sep 2025 20:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757389350; x=1757994150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6gDEZcRLnpHqXbC6n8kz3kbBR3GWvcpJzuoB2qUxys=;
        b=WV6ru+sT2ppAAVXeTX2J1uRzs6Nh8S0InRFRumjRcGEGZflGyCNiecEmqn7pbH+kRH
         SL8sdMOq3dnQ6UplwJjUV8mIIJn4FsaE7nimNwnH0vkYpr8Zi4P53t0NAA1Bds6f+JWZ
         IY9AJoDjoYl55CPJl4f9Wf8Yamu7jTBO0M7/+vwhHvrpwu9a1alNZ6T05nazto3cm3ld
         uuYYPxhereecXvqC6wB/YEuZCUJg4liFGu820SHtehP4O9zaGEU/K8nQ7Tk6KYjNLojS
         vonUtrpIC+iE1HRyMPjC8SIycTCbQ1xDvWF9U6+e+Mp+LCtUChfYWPaGXUYoUdBRU1q0
         5Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757389350; x=1757994150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6gDEZcRLnpHqXbC6n8kz3kbBR3GWvcpJzuoB2qUxys=;
        b=iW3XZ3f8lMm29nQWvWtIwjVHaLWRvllF5snM+zMQxnKZgZxj6cSIjouY3BOz4/HM/0
         PBjHV10VI0dkdSbhPqYADE4zENdxAETQRsdGuS3O+Wq9Ly/Hizh6ai5q11vKFiDtyXHc
         HPTOy3DFxlgrAWHG8i/Ql/Gz+XwHDXMOsqV4/mR3wq9pmPGm0+tTU+CXBlsQUGoALNpe
         p23UH3F0JPVP7Oich3dUHFdb4wixuFHpobebj8lLhPzNy24anNoJx3SzravULCnIXV9o
         OLpUr4xyd7usCYP1mqzGrHjQdkCxZDnkyikF0ArgfMNXoToh1HVHfS2A+sBxJgFOzYMl
         YLsA==
X-Forwarded-Encrypted: i=1; AJvYcCUC/kX9+fVDWyc3AiKHONozaitvW/rLgpxJkKRaVUP8AMDF9NVyCAe2mtoWeQ04AF2xi4Pcv4n3JOxPfxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTw0gNe3fUuGKp/fnDKsyFphwhl8e5g+I2gPlzWLTfoSzJO7d
	ZmKgpmFEZguB+3gSh1xbQemBjiRnUK/vtCVLuV81U+fx4U3RgvsIbFUu
X-Gm-Gg: ASbGnctyWbf/T6Axsg9Xz+EzLm4Vmfl86Gzh5pY2IDLSO3GrgG9/GO3z31wcyShTRvD
	CwteOz190SUgJnB+qcUDtHNnQWZw3ZAj0nJwJM++D42Og15BuOb7+ed+Z/Ke454eY7pYUwcX3ba
	ca8lvQ+wtVqNGWhyykp3XIGwMCXIbtJRlpp3wCKQl9bEomLxv0zApUSIjLXb83NPMNaUbIqK/Wm
	wwgMr2iRORLRyrmld1Wu9f768KFbLL1Qtg7gTA1LvXwgSf4Vzb5K3DdnNLxXcOKffswP+nHwpin
	m+d74eZtgbd3RfbsbDTYqxhJLCHttoq790jpGifWRW06xI5m8R5EdgBDZcmJQ+KdezLM2dnn0Pp
	0EABO0SAVStlX/30Ni7BBLiLeM5o=
X-Google-Smtp-Source: AGHT+IGpNtQ90UEAqdOAHKUHUHSzPdBdgK9BK63YBM6Puv1cPEB5nPvMP/kewWqqgro0ciHWm/i/Mw==
X-Received: by 2002:a05:6a00:138b:b0:772:553:934b with SMTP id d2e1a72fcca58-7742de6a675mr14150966b3a.31.1757389350248;
        Mon, 08 Sep 2025 20:42:30 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662eced7sm473126b3a.91.2025.09.08.20.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:42:29 -0700 (PDT)
Date: Tue, 9 Sep 2025 03:42:22 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Liang Li <liali@redhat.com>
Subject: Re: [PATCHv2 net] bonding: fix multicast MAC address synchronization
Message-ID: <aL-iHkMmHKrnAeoW@fedora>
References: <20250805080936.39830-1-liuhangbin@gmail.com>
 <83bef808-8f50-4aaa-912e-6ccdb072918f@redhat.com>
 <aJwO3vcLipougMid@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJwO3vcLipougMid@fedora>

Hi Jay,
On Wed, Aug 13, 2025 at 04:04:54AM +0000, Hangbin Liu wrote:
> On Tue, Aug 12, 2025 at 10:42:22AM +0200, Paolo Abeni wrote:
> > On 8/5/25 10:09 AM, Hangbin Liu wrote:
> > > There is a corner case where the NS (Neighbor Solicitation) target is set to
> > > an invalid or unreachable address. In such cases, all the slave links are
> > > marked as down and set to *backup*. This causes the bond to add multicast MAC
> > > addresses to all slaves. The ARP monitor then cycles through each slave to
> > > probe them, temporarily marking as *active*.
> > > 
> > > Later, if the NS target is changed or cleared during this probe cycle, the
> > > *active* slave will fail to remove its NS multicast address because
> > > bond_slave_ns_maddrs_del() only removes addresses from backup slaves.
> > > This leaves stale multicast MACs on the interface.
> > > 
> > > To fix this, we move the NS multicast MAC address handling into
> > > bond_set_slave_state(), so every slave state transition consistently
> > > adds/removes NS multicast addresses as needed.
> > > 
> > > We also ensure this logic is only active when arp_interval is configured,
> > > to prevent misconfiguration or accidental behavior in unsupported modes.
> > 
> > As noted by Jay in the previous revision, moving the handling into
> > bond_set_slave_state() could possibly impact a lot of scenarios, and
> > it's not obvious to me that restricting to arp_interval != 0 would be
> > sufficient.
> 
> I understand your concern. The bond_set_slave_state() function is called by:
>   - bond_set_slave_inactive_flags
>   - bond_set_slave_tx_disabled_flags
>   - bond_set_slave_active_flags
> 
> These functions are mainly invoked via bond_change_active_slave, bond_enslave,
> bond_ab_arp_commit, and bond_miimon_commit.
> 
> To avoid misconfiguration, in slave_can_set_ns_maddr() I tried to limit
> changes to the backup slave when operating in active-backup mode with
> arp_interval enabled. I also ensured that the multicast address is only
> modified when the NS target is set.
> 
> > 
> > I'm wondering if the issue could/should instead addressed explicitly
> > handling the mac swap for the active slave at NS target change time. WDYT?
> 
> The problem is that bond_hw_addr_swap() is only called in bond_ab_arp_commit()
> during ARP monitoring, while the bond sets active/inactive flags in
> bond_ab_arp_probe(). These operations are called partially.
> 
> bond_activebackup_arp_mon
>  - bond_ab_arp_commit
>    - bond_select_active_slave
>      - bond_change_active_slave
>        - bond_hw_addr_swap
>  - bond_ab_arp_probe
>    - bond_set_slave_{active/inactive}_flags
> 
> On the other hand, we need to set the multicast address on the *temporary*
> active interface to ensure we can receive the replied NA message. The MAC
> swap only happens when the *actual* active interface is chosen.
> 
> This is why I chose to place the multicast address configuration in
> bond_set_slave_state().

Do you have any comments?

Thanks
Hangbin

