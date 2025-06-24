Return-Path: <netdev+bounces-200817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05482AE709F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E049817E40E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592702EAD1A;
	Tue, 24 Jun 2025 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6G/kkmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D42D5C92
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796785; cv=none; b=rEyAQ0HCS09+K0vVB4TA21GZpz1mr83UsNA7ycUkF+Egyn1E7ViNbO+1CqL7CYEe0FeGADrjs3/2w5zmND2hcvV0tCMzHPkS5H4LH7ScHaPxVeTN/cn+ZxPguLHuA2lxog1hmQQL5TxsBuuQnH4SHO13PJ6PSORIJU9+bJ5c/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796785; c=relaxed/simple;
	bh=rVnT4tOUDdzLgyakYvPOMFZCyoADUyFKpR1P3ySUJE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxoIp7lKnVxcwWz5/9nJgGGkEBZ2ALUGdjSL/xIi+SCzZ+52hAupMu3+vp+algG7Cs5vwq1apj6chcAmk/7+WzrLTMjSA/zrLIyQUEXL8gCQazTM6Soa/I3CdJWtMsS1jCvbHqxUFHh2oKw5UrPpaF1THZmRbAn5k2XhfE09DLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6G/kkmY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7490acf57b9so3231632b3a.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796783; x=1751401583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob4ty4YtjdzwVrPcxBRjkX0uy675JNDz5qf3llHVRHs=;
        b=O6G/kkmYIaYEh1WlN6bJmFQiM0Lrd58092XhiM/I0Ur04Nn1T4dto4AEHadeC10NYF
         MgsqahPRILTywskPjlOMYHbgGUgLoh59YsaUKxvCuse9Nz8BuROWBw9IpN7IkxqmhSY7
         hEGjj+zCqXqucxSmljwWjbRgjeOWnuucfZ9YWeKpApwL0TOaGj9xg+30WQATb+5qL6l5
         LVDPe/bF+e2p4uqfUfWPxn5ESG+j000R+LRTDfXnweoLAwOQoXR1UCJ5cROLJ/0h1Kig
         0Sjnma6S1xG+wTRrWQ4zgL5yII6rbKkhi5Ih4BoXhmjJ5edIhKG32XKcdh+3ucyCqbZf
         cejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796783; x=1751401583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ob4ty4YtjdzwVrPcxBRjkX0uy675JNDz5qf3llHVRHs=;
        b=OryMw7sT+En1kj/HuhIeOc8IFX9H/CeQBCbAs+w4+YN+A0Sh8RNFf16yroVfOzrsoF
         Uca0/JW+U/Jh9WfJvy+Qy7NkzoY4CflGOwvVpZ6pmKpSp9wsKhfj1tlHuV1bY95s2941
         /g7Kzwi/DDnen/RGsEAMDEXCZtdAoP/K/GW1aR131xVxS1P14siBFVCBCAXIFm6btbS5
         QWzTglvDFr4XCVPTTpM9Dn3ucLQpo1r5czWOM2GWFEt+eBWe/L7HUYSK/r+5RPhYUqiV
         pDwaRmuqxJUryBW/w1Tej9orltP0zXSKoirbA1o1Cg8qOV5VAkCDI/sRWCoi+0q8v2+U
         /C2w==
X-Forwarded-Encrypted: i=1; AJvYcCV76PfoL+ZAuXwLH3tuCkCLJ4oGAKAFtvbEmHJzhqJgJQpNpcccnmgG4aWxgW5+eGkEa8Ur3tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KHbSk5QBQP0X0sRecifLpiUhqQoZSoOXBin/mmoFeqFLZiXm
	igsr64QU02gvVRQt6s7yLpHazul+FqM5W7ocMs6KAghbhktopo9/hVQ=
X-Gm-Gg: ASbGncs1qZs1iXztiwPAS/FEkDFEpmI7Oku830TngPudpj0du+qe8xELhANzxKuMUnk
	mNsUSE1m6JO8rir0JB51iWhHkjCZeraGcQ9SNDlabXJ/6rZc/dhw66li7qHKnA2vJDDOPNRF2TR
	CIi/fFraXi2jc5vug1KZZzrE5jbCvdt8tBQPxNzm3eXWdXGCulgEfLOcEqF93S8/5hIzIo//M/u
	wO69xnQbYgT4tg0wDXi+v28rMPXZVjpoDv6Ef2mD8QkwHO6X1T/bwOfGINSLk1DX9slWTym7IqI
	AF4PJ2A0/SEid2fRDI+e4BOF5lrE+jhl7TygtXE=
X-Google-Smtp-Source: AGHT+IEK9hYF9it9N+ZZDt1/o5OjTaMwRTDchnEAdMhO54iHmXgEcPPczkYc9wumH+YQtx0NafnKLg==
X-Received: by 2002:a05:6a00:a93:b0:742:4545:2d2b with SMTP id d2e1a72fcca58-74ad443cb3bmr938327b3a.3.1750796782852;
        Tue, 24 Jun 2025 13:26:22 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:22 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 00/15] ipv6: Drop RTNL from mcast.c and anycast.c
Date: Tue, 24 Jun 2025 13:24:06 -0700
Message-ID: <20250624202616.526600-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

This is a prep series for RCU conversion of RTM_NEWNEIGH, which needs
RTNL during neigh_table.{pconstructor,pdestructor}() touching IPv6
multicast code.

Currently, IPv6 multicast code is protected by lock_sock() and
inet6_dev->mc_lock, and RTNL is not actually needed.

In addition, anycast code is also in the same situation and does not
need RTNL at all.

This series removes RTNL from net/ipv6/{mcast.c,anycast.c} and finally
removes setsockopt_needs_rtnl() from do_ipv6_setsockopt().


Changes:
  v2:
    * Patch 2: Clarify which function doesn't need assertion
    * Patch 6, 9, 14: Call rt6_lookup() and dev_hold() under RCU

  v1: https://lore.kernel.org/netdev/20250616233417.1153427-1-kuni1840@gmail.com/


Kuniyuki Iwashima (15):
  ipv6: ndisc: Remove __in6_dev_get() in
    pndisc_{constructor,destructor}().
  ipv6: mcast: Replace locking comments with lockdep annotations.
  ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in
    __ipv6_dev_mc_inc().
  ipv6: mcast: Remove mca_get().
  ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
  ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and
    MCAST_JOIN_GROUP.
  ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and
    MCAST_LEAVE_GROUP.
  ipv6: mcast: Don't hold RTNL in ipv6_sock_mc_close().
  ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
  ipv6: mcast: Remove unnecessary ASSERT_RTNL and comment.
  ipv6: anycast: Don't use rtnl_dereference().
  ipv6: anycast: Don't hold RTNL for IPV6_LEAVE_ANYCAST and
    IPV6_ADDRFORM.
  ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
  ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
  ipv6: Remove setsockopt_needs_rtnl().

 include/linux/netdevice.h |   4 +-
 net/core/dev.c            |  38 +++--
 net/ipv6/addrconf.c       |  12 +-
 net/ipv6/anycast.c        |  95 ++++++-----
 net/ipv6/ipv6_sockglue.c  |  28 +---
 net/ipv6/mcast.c          | 328 +++++++++++++++++++-------------------
 net/ipv6/ndisc.c          |  10 +-
 7 files changed, 254 insertions(+), 261 deletions(-)

-- 
2.49.0


