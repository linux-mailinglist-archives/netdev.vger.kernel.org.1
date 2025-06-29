Return-Path: <netdev+bounces-202212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC8AECB84
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 08:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC92E1896697
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5C1DDA15;
	Sun, 29 Jun 2025 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moedove.com header.i=@moedove.com header.b="NGjZ2Sc5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288A17A30F
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751179242; cv=none; b=aAjz3/RGoMJDgZErGRHe30y8QdatnG3Vl2rQXSCbzShMCu1da8YRLH4hqrLTzwDGly6FDt0EyEoy7vwN4KKwKZ3qYjv0SB81sZZg2U1qdTTgNfDlFSPUN1aY1WVqlMnVrD1e1iPyAWcq8ExQG9FNO6ZxNZQx9RLyY6pES4+H8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751179242; c=relaxed/simple;
	bh=nxhElIzIotjw8/BJMVmlrVpliiAwQ1enVpzwo1j0DK8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vu5AlL2vYzRNVXtTZf5sYOqgjGSKI1Ag1am0cdezkytnfz7A/9+KRGf2wL1jXiG0eaaKEqG67eFLDEAF4EDGsa33p3ysuFcpQ1owki3HRQ9Z6YPRM0yOA6v34Wp1mxHn3LgpXAftvXbKmNNTvwbJ30dmqxbs3HAp89sf1beY/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moedove.com; spf=pass smtp.mailfrom=moedove.com; dkim=pass (2048-bit key) header.d=moedove.com header.i=@moedove.com header.b=NGjZ2Sc5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moedove.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moedove.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0b6532345so865310066b.1
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 23:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moedove.com; s=google; t=1751179239; x=1751784039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eu6mtCQ7K2xM3E3xC+0A8kVa3gVWef57IR0vIWhYJ7s=;
        b=NGjZ2Sc5RFzCxNX8HOjF4dvBd+uXs9drmSph0qhz6NrNw/6xgrOEv/19bCATz59TiV
         t5MvEBrcRYItQE/Z4cWJfDt8VCKKUfcAX1hYzyL2M44UKDO//0F9l95XFuiBqVNxLIe4
         0M6A+pCk9T7dxFdTK6LQ9RrZazzqgXPJLHURvyUnHD7VLF/yiOlA90HVFpROcOv6U1R6
         O9HZHXORvLLQpHW8VMdyMu4FqYh/pNi0PuOIyfuGel7Y7ADIFyTPeRSKxvqnToDvrIj1
         SBjEuEyikZks/5kXkpsYO1mBsLmqA787tbfToUj9iKo9H5NwxnC4dE0YuGfP0cf1RIKC
         uMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751179239; x=1751784039;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eu6mtCQ7K2xM3E3xC+0A8kVa3gVWef57IR0vIWhYJ7s=;
        b=p1SPGQXwvHJ8FogT6l3HZspOYSxb7AXGTo460imgdGjYbZ8v1HqLKUTnesXy2Jubdi
         97jnwdEEiIWPNTUSDBhLfpZcFfc1RKnBABGUT7wFpSFA16u4aW8sNg+EcTKXjyudPhVx
         sMAOWNVmIHwhFKAaz/MJAtHZvtFrb3NljiLxnHCeRitCWhLHk8AwUc2QU3+Z0N4Z96iE
         1VaIQb684OopOhw18uRm9twISlJirWDSDzzacfVVCU5EZs6VWojLOg5D7csxetc8ewsy
         HbDZMVbSJkPFnwD/ZSUTTBnnY94CKD7pq2wunW/MmKGqiLWLOrom2ZZ3usDxgylp8dib
         F85A==
X-Gm-Message-State: AOJu0YwVqXqjo9tIz/KschU0gHN4stVUqalM5EZGf1cvPPnmmlO25BPx
	ob7XClNqVdU5KxCJ8Q3vjfr02Y5TrmdNQufYoSBJaUH9vxSXmkEklGZ6NXpfXRj4YClEbF/TcF5
	jaWhI01+ya96Cvv8tB+TjgtyyeKAXbYPWs+/QJELy5o5Ou+/CB9hS3u1kfUqCfm7B+9rbGFsBvd
	ogX+zI1El41i6J1NpHs/Hzc/FDfKZGiUbwjqIJhcCG40at
X-Gm-Gg: ASbGnctBXXZutva7ZIZbFmngv2slTE+l9l663iPPh+LYXUNr4bZLCNgdH2mANdX62rW
	G/T9S/kR8IVsmk3r9TJzlC0ifR3pqhkhinuynGTScSsLaQHHhCRW1cIG8VnhuUf84Loqxd2h+5m
	t6B0WC6bTY2Bjcumh/aCPBzZOzYqIL4Zv/i43yluhhyrBLJp93JnF93Ho71m0MqWKbW5dbL/Zm
X-Google-Smtp-Source: AGHT+IHo7yqtSxyXjVuf4c993E/WClr3/lXuK7/2W1d/gWJqpzGlT8Te1rig2iY9QQEszld8eNHU0FPn/jTvIS15GYQ=
X-Received: by 2002:a17:906:eecd:b0:adb:2f9b:e16f with SMTP id
 a640c23a62f3a-ae350364f92mr916565566b.16.1751179238753; Sat, 28 Jun 2025
 23:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aiden Yang <ling@moedove.com>
Date: Sun, 29 Jun 2025 14:40:27 +0800
X-Gm-Features: Ac12FXzxpIM0WHPFkdzSJEJ8Ev18f3VYH00PwobftzbmbhgMULHt7aLQhTxXSpI
Message-ID: <CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com>
Subject: [BUG] net: gre: IPv6 link-local multicast is silently dropped (Regression)
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	MoeDove NOC <noc@moedove.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

This report details a regression in the Linux kernel that prevents
IPv6 link-local all-nodes multicast packets (ff02::1) from being
transmitted over a GRE tunnel. The issue is confirmed to have been
introduced between kernel versions 6.1.0-35-cloud-amd64 (working) and
6.1.0-37-cloud-amd64 (failing) on Debian 12 (Bookworm).

On affected kernels, the ping utility reports 100% packet loss, and a
tcpdump on the underlying physical interface confirms that the kernel
is silently dropping the encapsulated GRE packets instead of sending
them. The sendto() system call does not return an error to the
userspace application in the default namespace.

===================================================================

Regression Point:

Last Known Good Version: 6.1.0-35-cloud-amd64 (on Debian 12)

First Failing Version: 6.1.0-37-cloud-amd64 (on Debian 12)

The regression is also present in later kernels tested, including
6.12.33 and 6.15.x on Debian 13 (Trixie).

===================================================================

Steps to Reproduce:

Use a Debian system with an affected kernel (e.g., >= 6.1.0-37).

Establish a GRE tunnel. Replace [PEER_IP] and [LOCAL_IP] with actual
endpoint addresses.

ip tunnel add tun_gre mode gre remote [PEER_IP] local [LOCAL_IP] ttl
255 ip link set tun_gre up

In one terminal, start a tcpdump on the physical interface that
provides the local IP, to monitor for outgoing GRE packets (GRE is IP
protocol 47).

tcpdump -i [PHYSICAL_IFACE] -n 'proto gre'

In a second terminal, attempt to ping the link-local all-nodes
multicast address via the GRE tunnel interface.

ping ff02::1%tun_gre -c 4

===================================================================

Observed Behavior (The Bug):

The ping command runs and reports "4 packets transmitted, 0 received,
100% packet loss".

The tcpdump window on the physical interface shows NO outgoing GRE
packets. This proves the kernel is silently dropping the packets.

===================================================================

Expected Behavior (as observed on kernel 6.1.0-35):

The ping command runs.

The tcpdump window shows outgoing GRE packets being sent from
[LOCAL_IP] to [PEER_IP] for each ICMPv6 echo request. (Receiving a
reply is dependent on the peer configuration, but the packet should be
transmitted).

===================================================================

Additional Diagnostic Information:

VRF Context: When the failing GRE interface (tun_gre) is placed within
a VRF, the failure mode changes. The ping or sendto() system call
fails immediately with an ENETUNREACH (Network is unreachable) error.
This is likely because the VRF routing table does not have a route to
the tunnel's physical peer address, and the kernel correctly
identifies this dependency issue.

veth Control Test: The issue is specific to the gre tunnel interface
type. A control test using a veth pair inside a VRF works perfectly
for link-local multicast, proving the core VRF and multicast logic is
sound.

This detailed bracketing of the regression should provide a strong
starting point for identifying the specific commit that introduced
this behavior.

Thanks,
Aiden Yang

-- 

WARNING: *This email (including its attachments) may contain confidential 
information protected by confidentiality agreements or other rights, and is 
intended only for the designated recipient or individuals who need to know 
it for the stated purpose. The recipient is prohibited from disclosing this 
information to unauthorized parties without prior permission from MoeDove 
LLC. If you have received this email in error, please notify the sender 
immediately and delete this email and its attachments from your system. Any 
use, dissemination, transmission, or copying of this email by someone other 
than the intended recipient is prohibited and may be unlawful.*

