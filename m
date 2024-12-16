Return-Path: <netdev+bounces-152309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB19F35FE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B88E166517
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21702046BA;
	Mon, 16 Dec 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xhT9luJy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583BF202C50
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366464; cv=none; b=d1EAeO0qbqSDkBg2anmID+t5ib6Doa6G8W8MUO4NWIJI2wDjmVXqOksKVQcsBks6wXjQFPfKZo3wdte+SBtqTCFOuydv7sx6oauTtqUVa9Xm3ME6xK/CbdC3Bp31ctO9/balMmyTbX/xPKmoz6a5lkcfbt7es9rluiEhfM6rnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366464; c=relaxed/simple;
	bh=Alkl5JK8XXPDhw4TegKE51lvaTrA4xkYrWRmB0nId1Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o8UqP9oHfk3wnPlqOEChBdvIJSOpmv3v82EUD/1ycPqy+KCaGjWi9yGzxE6PPSfHVorw+qbV72Bdz9WEFnEeQQ4c86C8Ago4DXoC0rse9/tkusoXG/KYHJ47p4ldDsjcMGtuhOgQ48pPALTDy3/xci+obVlZlPxaH2ePzwEcSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xhT9luJy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2166f9f52fbso61746495ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734366462; x=1734971262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=474yaotgwCzzWyKV5Ltdz6258KpTVXmf9MtVet0h7Es=;
        b=xhT9luJyhtXB3cSxBPQp5siFawaoojrebXkf/t/VJjmr2CnwOpZL/SaQ712B/Z+2Rv
         Tbw6+cmi9ykJtYauYC7YBB2ibFbdufdZ+slI5J6jo8EMPbboYKj96UZLqU+mYMjzbdfr
         +l2wCZoHqJwkSQl6awGuVgib7pDx80JzaZwjZEL6VUcIVrcDsKwKIW/2voIFY73O+Glh
         SByu6DpjP9dro0RGAugm7L+8yorRNbvPlKje9+dTXrok2zSRSJOTovfI6PO33vtOwo6H
         NvPA7GdKRj15wQ/mPSZ87Cb4cqeV3VN+q8EWQ2OQfgwjqGVNrTe9u89FyKrhW16KDrTc
         Lbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366462; x=1734971262;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=474yaotgwCzzWyKV5Ltdz6258KpTVXmf9MtVet0h7Es=;
        b=VJ1xwkRfHX/AjtdP4eMl5cRIBvzgaUnBttOtAY51tyNDdonAN06BwjHr08KuKuREwc
         bahDtXAuOcnTWoaPZ7bO8bdxRPSXiNO4ltiYYFlgtd4lWqiSIFZ3A8rSB5ceMA0KbO65
         exFjimk7VQ+1fHMfYhP0RYr/xQd5O4kKzWhE+Ssmc1vHidyb8w660rH6Mo7BIjIhl4zf
         cvEypn5FM2jZWcGpTeWKYCqDCTyzSc3T8Jds+HDFsw1pv6VB/5DfcpR5Dnaz0XkIAdpt
         xiBhmxkeP48fBwI8gl6+dNi9tMDHv4zVBdo0v9CAtSMmyl5/YZfKlnnS9zc44tRHXIOu
         FWLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Wx6NO6zT76wFARTxalkEZG6BrUKmZUZ8De7uC2M0LxfRPT8G7vz5Q1Sh1z7TOD8gICEu7vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiIFc/xAKllA3XSbpMlf97Fqk1sjr0Q9FC4JZXSRit1l+xueR5
	UTq+rc1QRxRYV8FTRqQPWIzAia4J/3WHyE66dHt5H6A2X6JUKmBkk6uSDRQlzHyMWv3jqZMWi52
	90nIJ1w==
X-Google-Smtp-Source: AGHT+IHSei2yGRztaubYbqKCul3QQv1EHtbndGGlv/0ZZYijOdz2zocYYRlRLidwM2ED0OUQcir6SLdjFVu3
X-Received: from pjwx12.prod.google.com ([2002:a17:90a:c2cc:b0:2ef:8055:93d9])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c86:b0:2ee:7411:ca99
 with SMTP id 98e67ed59e1d1-2f28fa54f59mr18372516a91.1.1734366461730; Mon, 16
 Dec 2024 08:27:41 -0800 (PST)
Date: Mon, 16 Dec 2024 16:27:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216162735.2047544-1-brianvv@google.com>
Subject: [iwl-next PATCH v4 0/3] IDPF Virtchnl: Enhance error reporting & fix
 locking/workqueue issues
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Vivek Kumar <vivekmr@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series addresses several IDPF virtchnl issues:

* Improved error reporting for better diagnostics.
* Fixed locking sequence in virtchnl message handling to avoid potential race conditions.
* Converted idpf workqueues to unbound to prevent virtchnl processing delays under heavy load.

Previously, CPU-bound kworkers for virtchnl processing could be starved,
leading to transaction timeouts and connection failures.
This was particularly problematic when IRQ traffic and user space processes contended for the same CPU. 

By making the workqueues unbound, we ensure virtchnl processing is not tied to a specific CPU,
improving responsiveness even under high system load.

---
v4: 
 - Addresed commit message comments (Paul Menzel)
v3:
 - Taking over Manoj's v2 series
 - Dropped "idpf: address an rtnl lock splat in tx timeout recovery
   path" it needs more rework and will be submitted later
 - Addresed nit typo
 - Addresed checkpatch.pl errors and warnings
v2:
 - Dropped patch from Willem
 - RCS/RCT variable naming
 - Improved commit message on feedback
v1: https://lore.kernel.org/netdev/20240813182747.1770032-2-manojvishy@google.com/T/

Manoj Vishwanathan (2):
  idpf: Acquire the lock before accessing the xn->salt
  idpf: add more info during virtchnl transaction timeout/salt mismatch

Marco Leogrande (1):
  idpf: convert workqueues to unbound

 drivers/net/ethernet/intel/idpf/idpf_main.c     | 15 ++++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 14 +++++++++-----
 2 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


