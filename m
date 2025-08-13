Return-Path: <netdev+bounces-213174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E9B23F4A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515A31892344
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 04:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC6525B2FE;
	Wed, 13 Aug 2025 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsTQY1ga"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071541B423C;
	Wed, 13 Aug 2025 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057896; cv=none; b=u0W/yVUnU/9rlg1i207Spd7CYCtWdOt33w5hzIohOmE0MT9OKSpZIAIRxCwzBXrlVRj35nWrXlQxieCVbeBvJwGw+yEhlzlA7vFIOO9++daU1meIf1iF/GlryXeBjDsKEknnqIanAYWaRUfONgsh5AyUD5Zqp3giMzWaFrfHWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057896; c=relaxed/simple;
	bh=hTQXQ5POExKP44ItRkalxf4masoOAnjB4WYExq62XDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAPrY4a6xE5cLRaiHSe0q6PzjrmEz3nNIVSpxx8JvgGlAV+eKUEm9cLVlOIh0bjjb1wlzIUOXfBajBv0IisP/lQUyPcrXqbr0dK5Z4/STviqg1PDbRNnpohH5FikcYQ98oMKm+rpC+eUyibRgFEGJA+uMaFXpougUETEY1HleCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsTQY1ga; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2403ca0313aso51638375ad.0;
        Tue, 12 Aug 2025 21:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755057894; x=1755662694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/a1WvCweM9wyjANyIVn1PnZJVzqlQ2vaNc6W5ZsUho=;
        b=nsTQY1gaZQhFuAbOaRuR++dbhShjPeikNB76Wk2rYBIZT1ZydL9Cp/b0y2KwYOfuxp
         Mz4Wkz8QyePLVzrCc+rVCNkejRGm3NYlco+ctEoAoXAhtpsvmWEgd8j7g8i1bQaKAydJ
         MQZ0h0t75v/Ar5C4tSAtRGXW/oEO5gqiGEA+bhmJbGQSCWSTpgTLHDsFQrpDUIv3io5X
         v5xLHaqb51Lxo8pgtbNPSDflZ9EktasKn0rapH7JUHzOlg3DNkq7jyezRXVUizOpVspK
         U5Uky6e+8UiBYVpgfPw3jOcKH/fNKmZZ6znGv11ZVfXjGf0RCxXdD/ClPU5xolyNWWIK
         akMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755057894; x=1755662694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/a1WvCweM9wyjANyIVn1PnZJVzqlQ2vaNc6W5ZsUho=;
        b=Llxal5N0MblfsaSB2E99PjXRrbLpfQRHNBQTYxAnVCzpKEbeVD2123iUn1YubkzZ9h
         kiiLhDI9/HtB0baWx/RgIZOApHvx7CGOfZkLpyiX/Mg+gV5VLsjHCkcF62hfim07mpv2
         PCFFm/ucHxX5bH9oIn4V9SK9rUSQGXpWUfwM9u/+MjbOSMCWaduM0/AWvuqEKOV3VqWS
         DeHWOF0iK3pQvIAUFrgKsq5iCiHT74BcOI8BVIgSUKcHxfuVsLPVrBYJJvk9oLrvP1fV
         yv9YAccfCaHPzZOE/9fQIYj0AfKZWDlCWhWXxKaP6Ut6sNtXIRUSwjjb52FqdAM4jfqG
         Vd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9/pSMts05qQmXDCKYZ1rT0zSGiBXS1wZpgJYbQaFM/lyQ5O3iHhIjFhoF8FPU5cZaH+1EX6YwlGUt9Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuPV8chM74iW31Jl3KjVD6JIoUJkF1Yfy4oeqmvvCa2Kq0CWdu
	4DgNDX1QVrbU9JgrCNjf7RbaA6EqA6moekjVqPtOd6eKe4nDen5wdb3b
X-Gm-Gg: ASbGnctpG18num+C62o3cgQArw7Gb39sSrqB5pqYnsHVXLTAx9r22sL+HJbfWYf0bhm
	quY0yOO8PPjbPUkVoV7490RTNFlJx4NFVcu8pHX/mqvzk/1QQs1Nb0zPYeTyrDeTTtqYFY2ZiRT
	uLPzpNDphUQn0o+rMbFcJIWI2P57Fbf66Rzhv1dSZ2bMtLgF9tRZKqhHooRTnoduOJ2XnnM+5Z6
	mLOxxz+I/HXIOVzoaCakTcGN/L+jsXKNDfq5hMPoB35qQvoq0zpf+VAdCGqHLZnJTixFllH3TCL
	IBaQtMWkTGIUaTfsYAp2a+cnVFQSsYc5MAcPJBaUP4oStPYtHJ5wjso7AUFYz/HwYGajjC1xYTm
	bal/s+YeRovD1EdlXitB4qI9XH9o=
X-Google-Smtp-Source: AGHT+IGF/ZoPnE7X8BBJ/khsi/1/VGz3M6SXj8QnZ3kDQi44GyLMMn6XY/6ZRABzzJUvREG6PlX9mg==
X-Received: by 2002:a17:903:1a84:b0:240:1953:f9a with SMTP id d9443c01a7336-2430d0b3239mr28261625ad.2.1755057894097;
        Tue, 12 Aug 2025 21:04:54 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef75bdsm312130625ad.11.2025.08.12.21.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 21:04:53 -0700 (PDT)
Date: Wed, 13 Aug 2025 04:04:46 +0000
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
Message-ID: <aJwO3vcLipougMid@fedora>
References: <20250805080936.39830-1-liuhangbin@gmail.com>
 <83bef808-8f50-4aaa-912e-6ccdb072918f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83bef808-8f50-4aaa-912e-6ccdb072918f@redhat.com>

On Tue, Aug 12, 2025 at 10:42:22AM +0200, Paolo Abeni wrote:
> On 8/5/25 10:09 AM, Hangbin Liu wrote:
> > There is a corner case where the NS (Neighbor Solicitation) target is set to
> > an invalid or unreachable address. In such cases, all the slave links are
> > marked as down and set to *backup*. This causes the bond to add multicast MAC
> > addresses to all slaves. The ARP monitor then cycles through each slave to
> > probe them, temporarily marking as *active*.
> > 
> > Later, if the NS target is changed or cleared during this probe cycle, the
> > *active* slave will fail to remove its NS multicast address because
> > bond_slave_ns_maddrs_del() only removes addresses from backup slaves.
> > This leaves stale multicast MACs on the interface.
> > 
> > To fix this, we move the NS multicast MAC address handling into
> > bond_set_slave_state(), so every slave state transition consistently
> > adds/removes NS multicast addresses as needed.
> > 
> > We also ensure this logic is only active when arp_interval is configured,
> > to prevent misconfiguration or accidental behavior in unsupported modes.
> 
> As noted by Jay in the previous revision, moving the handling into
> bond_set_slave_state() could possibly impact a lot of scenarios, and
> it's not obvious to me that restricting to arp_interval != 0 would be
> sufficient.

I understand your concern. The bond_set_slave_state() function is called by:
  - bond_set_slave_inactive_flags
  - bond_set_slave_tx_disabled_flags
  - bond_set_slave_active_flags

These functions are mainly invoked via bond_change_active_slave, bond_enslave,
bond_ab_arp_commit, and bond_miimon_commit.

To avoid misconfiguration, in slave_can_set_ns_maddr() I tried to limit
changes to the backup slave when operating in active-backup mode with
arp_interval enabled. I also ensured that the multicast address is only
modified when the NS target is set.

> 
> I'm wondering if the issue could/should instead addressed explicitly
> handling the mac swap for the active slave at NS target change time. WDYT?

The problem is that bond_hw_addr_swap() is only called in bond_ab_arp_commit()
during ARP monitoring, while the bond sets active/inactive flags in
bond_ab_arp_probe(). These operations are called partially.

bond_activebackup_arp_mon
 - bond_ab_arp_commit
   - bond_select_active_slave
     - bond_change_active_slave
       - bond_hw_addr_swap
 - bond_ab_arp_probe
   - bond_set_slave_{active/inactive}_flags

On the other hand, we need to set the multicast address on the *temporary*
active interface to ensure we can receive the replied NA message. The MAC
swap only happens when the *actual* active interface is chosen.

This is why I chose to place the multicast address configuration in
bond_set_slave_state().

Thanks
Hangbin

