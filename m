Return-Path: <netdev+bounces-86646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8FB89FB65
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9327A1F2209C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4816EBE4;
	Wed, 10 Apr 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="MPLaNcbw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6116E870
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762523; cv=none; b=sWaXvHFdUG4YlOklNYkSNIS0q/6/7/wEc7/LtR7uuBVjpDA5Ii5o8b/o17+EU5wN8XGum3MGWNEzaW/vBb60I+HIqGLN5jyAbuHAxOvReZjxTgxjd+qpChlnmwfaKbAB6W5h1vB0bgWFJkyVPZIwHYdVO1wzVwc4YSgA04f1cFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762523; c=relaxed/simple;
	bh=Vd6va2It1DvKDUq9KHmWzCIZ8X2a8vkhJC3c+3WUpDc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Wi1ibaUK9jJr7T0B6uWgZpRVYMyTXcTJ5Z/tx8k7LfMufYy8+iZg5Q3GGr2l0yhQhuU/nziD7RhqG3NsWHhXrHC1PWOx6uS63havyF+bg736Ue9Rq8ZfvA6ZvnOLWdaS305Oj8qQDGau0epdWRn2d9ZFvzavsBZmx217kauO9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=MPLaNcbw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3c9300c65so41910375ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1712762520; x=1713367320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nxu9+OjTNTk+qr7n62fdj7wRSZalqPNd/Thahqt/SSQ=;
        b=MPLaNcbwNKFmFcg4Md8fqb4R3qXRX/ZGKe14Y3wHFPSEcZ5wLR2xJtBoJSVP84AEul
         /V753r64vaaRRDlen2FF1DfS2dkVr6ohwbo4J/fRfIP9CNk7tEo/Tlh7+wjdXQ6G8ALQ
         hrHhwmrE7nrEJ9xgxfLsjR2FNbUWMly2dD3S351Nc3QkOq4g7OemtuQkz/d6bGrKSfZv
         iquIhayr3kzPWpcAdktTc040D4/vHi8xVPLPvKOAzejr4k57hnfXwAGPFxr4mQ+SB0k0
         SpkJcOLIsz1dijFC5tTIRNzkklU4Qipc7P42vTKk+U6Od42I8a4RJ6ssDiMOkc5fwkqu
         fNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762520; x=1713367320;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nxu9+OjTNTk+qr7n62fdj7wRSZalqPNd/Thahqt/SSQ=;
        b=hvYyFNkUxFsPGVOODskZcH2Ll3bax55ZdhogjbIdUtWx0Py2wzabKi7VbdjVBjnzx1
         ajxPG70EReMmHdhAubVcNqIzs01MAApuW3LQldRjWLpp2F9+g8kCuuYxXqonOQY+c2Od
         sRjl3IsniK/bsRr0GKhyduxSAwdmrD6CU5m0j66P0npGElQwR6FEsIF7RlqnFsfqydKt
         auUBnGww0RBLbD+g+A7Wofe2G4ObdcKqJtfaRuQNzmWi8Y4TMBGwQ0fUUT+kXzPR6wZm
         o0Viawp7rrwyeUJMPQ+pjJFzMR2yw3txMTyPQ8aItpdMtwG5dAwC9QS2XjzP2F30in55
         8uOQ==
X-Gm-Message-State: AOJu0Yzfx3uwn0wydcDUS4t58o1eHj+koxev8ZkpyDahOtvE9BKcoKhq
	LAIPdgDsxn9W/tx3Y9MlG9chU0OiQAST5MM3Jmaa5+imlPTwrG69jsea7Rg+KNntnF4GcN/pmWV
	R
X-Google-Smtp-Source: AGHT+IEjnP6SgKwwedqhX+wvS7diVc0WlZqEzaq4ZK5FwyNPRB1fXVIbnFiCBI+FqeRDszHSjq9rng==
X-Received: by 2002:a17:903:41ce:b0:1e3:e081:d29b with SMTP id u14-20020a17090341ce00b001e3e081d29bmr3314385ple.45.1712762520076;
        Wed, 10 Apr 2024 08:22:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b001e3d8c237a2sm8788617plg.260.2024.04.10.08.21.59
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:21:59 -0700 (PDT)
Date: Wed, 10 Apr 2024 08:21:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218700] New: the arp table may contain a fake IP address
Message-ID: <20240410082153.7d12bba1@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This looks like a side effect of the Linux neighbor table
and weak host model. So don't get too worried about it.

Begin forwarded message:

Date: Wed, 10 Apr 2024 07:08:57 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218700] New: the arp table may contain a fake IP address


https://bugzilla.kernel.org/show_bug.cgi?id=218700

            Bug ID: 218700
           Summary: the arp table may contain a fake IP address
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: a_s_y@sama.ru
        Regression: No

An entry from an incorrect interface may get into the arp table:

# arp -n|grep 100.64.1.113
100.64.1.113   ether   50:ff:20:26:fa:14  C ether9.3109
100.64.1.113           (incomplete)         ether1.2115

# ip -4 a s dev ether9.3109
1829: ether9.3109@ether9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP group default qlen 1000
    inet 100.64.3.62/30 brd 100.64.3.63 scope global ether9.3109
       valid_lft forever preferred_lft forever

# ip -4 a s dev ether1.2115
1822: ether1.2115@ether1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP group default qlen 1000
    inet 100.64.1.114/30 brd 100.64.1.115 scope global ether1.2115
       valid_lft forever preferred_lft forever

ether9.3109 and ether1.2115 are 802.1q VLAN, I don't know if it's important.

The ether9.3109 interface receives traffic from forgotten hardware (tcpdump -e
-ni ether9 host 100.64.1.113):

10:57:08.861954 50:ff:20:26:fa:14 > Broadcast, ethertype 802.1Q (0x8100),
length 64: vlan 3109, p 0, ethertype ARP, Request who-has 100.64.1.114 tell
100.64.1.113, length 46

kernel reply is
1) exists, although the ether9.3109 interface does not contain 100.64.1.114
2) contain the MAC of ether9.3109:

10:57:08.861972 3c:ec:ef:4d:94:ee > 50:ff:20:26:fa:14, ethertype 802.1Q
(0x8100), length 46: vlan 3109, p 0, ethertype ARP, Reply 100.64.1.114 is-at
3c:ec:ef:4d:94:ee, length 28

# ip a| grep 100.64.1.114
    inet 100.64.1.114/30 brd 100.64.1.115 scope global ether1.2115

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

