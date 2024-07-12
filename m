Return-Path: <netdev+bounces-111013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7D792F42E
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B3F1F22C26
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8B99450;
	Fri, 12 Jul 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMItN9oP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C638F70
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752693; cv=none; b=Emin4zs5RXcSBK7joGjQeV/sy3oh3WR1+WE13TivnAw7q4KZNbTdz/M1Sq+QdKc9V9JNEEWHTdj0WGYBr2nAYy89seUPgHeqb5BW9Ayg2wZHagaatNMNMDeQpfZAiEqgR9nWQYUfQqANxXsVAhxFDfH+H4SDiMKM6O4C2jXUr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752693; c=relaxed/simple;
	bh=pQGC2nkrNbvYLY1Gr7OOTj8KEmnMsrikayO52ElqvW0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bv5E2SV7puPtqzjtYaoR3TjObhQnAv4+ww8nDSa0FKBXGWmH6uPwiKGqlCUhUBCFUDD3Ey1m8zn5wGQqwALsY4+kRUkerUTk3ujg5hiSei3judznVMJUvoTxrMrUvU0fGbLeoqkpG2JkpP7Jz1eEvESeV5C0yYXGhuc6F8NDV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMItN9oP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6590a57788aso25059517b3.2
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 19:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720752691; x=1721357491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B0wtnLVSWX/3DGwDkd9YtqoqRNRyIYTbZEkHlA5FEjM=;
        b=KMItN9oPuoMdlMg74g7INJyZdVO46w3MW9gDUAfKT3v9wExSSMewr+1eM6ebwfOfQ9
         t6QjTaBjypYZIpcCwaqe5e43pkf/w+bInug4EpJUP4kQTDV/x6laU3+ikpw4NbN/tM4U
         fZ4CGaQCIzyEMEVP1fcfcL1rqp2VGFn65nsOvFbqoVKuIRNVsb74JnWy1B03QI8VA0xo
         8W67Jt1t80Guid6aYbz7ZIJ3m8A1MV3bC1ceSpWBEchE1cKdcOHjZLrcZ06vI8PF6Z40
         J8YPmID1HOkHdWsETzCOrPkWAYHXNcjUvq4+/riZtJU1bG7vGSlWsQGflZIMWNuanklI
         HI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720752691; x=1721357491;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0wtnLVSWX/3DGwDkd9YtqoqRNRyIYTbZEkHlA5FEjM=;
        b=JM0PzkO8iE5cMJA/uoRkJ0fvnyFE6mzqVbG5w9Xdgvtpw2AftYq9n6J/gR9ptCkRfR
         HJGVDQQLFtLb4dCkPtlEKpvW71em5JPsUsRyG/DpmLewquO1ySf5W4MNjUEK1mU9Ei8R
         IXJhIdsckRsM7v+uDIUrEIaqHtMjeydBz0rwBU5ZR1tGxt+ctvcV8jd7etXHv1y/M+UA
         wxLbTQSAuDLU/ngtJo9xd19Gj/unjkDK9gufNrKj9geb03JSu0DnJJOAi0Zl0dvIXmsZ
         UDopnXbNHdWugyNI33eN+doRKwdoJdySwoTYRk6rLH11Xq6pW6XaXYyFdBS3WkWhCiNp
         bbZA==
X-Gm-Message-State: AOJu0YxrG5FKf95eJl8TPNuS6tALG36xToq4hlyP/2Wpj3RG0rqVzfAV
	lZlj1fjH2KrzZLRxfsfXquVGgrdW+Uqojg25SvMBG0ALkLYNPwJb6yePL26G5H0ET1a2+QHPsMt
	vjUg3JhNcyBs4igYbU5f/HWQMnE7jTJKMYgkCKpbTaLu5Gzs6lUCcaMARQmV8mgxdMQv5D0GuAZ
	6Xo8pbY+4IWbK4OECZU+0MGpEyTGHzLOeE
X-Google-Smtp-Source: AGHT+IGMEOnO14alVyORBI7WPRZJSuctX1sNirH/sCgwVKQcMan8TuFjqggTp1In5n+WFK8vU6tA6xV16xI=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:690c:700c:b0:61d:4701:5e66 with SMTP id
 00721157ae682-658ef055bb9mr2719157b3.2.1720752690508; Thu, 11 Jul 2024
 19:51:30 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:51:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712025125.1926249-1-yumike@google.com>
Subject: [PATCH ipsec-next v4 0/4] Support IPsec crypto offload for IPv6 ESP
 and IPv4 UDP-encapsulated ESP data paths
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
Content-Type: text/plain; charset="UTF-8"

Currently, IPsec crypto offload is enabled for GRO code path. However, there
are other code paths where the XFRM stack is involved; for example, IPv6 ESP
packets handled by xfrm6_esp_rcv() in ESP layer, and IPv4 UDP-encapsulated
ESP packets handled by udp_rcv() in UDP layer.

This patchset extends the crypto offload support to cover these two cases.
This is useful for devices with traffic accounting (e.g., Android), where GRO
can lead to inaccurate accounting on the underlying network. For example, VPN
traffic might not be counted on the wifi network interface wlan0 if the packets
are handled in GRO code path before entering the network stack for accounting.

Below is the RX data path scenario the crypto offload can be applied to.

  +-----------+   +-------+
  | HW Driver |-->| wlan0 |--------+
  +-----------+   +-------+        |
                                   v
                             +---------------+   +------+
                     +------>| Network Stack |-->| Apps |
                     |       +---------------+   +------+
                     |             |
                     |             v
                 +--------+   +------------+
                 | ipsec1 |<--| XFRM Stack |
                 +--------+   +------------+

v3 -> v4:
- Change the target tree to ipsec-next.
v2 -> v3:
- Correct ESP seq in esp_xmit().
v1 -> v2:
- Fix comment style.

Mike Yu (4):
  xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO
    path
  xfrm: Allow UDP encapsulation in crypto offload control path
  xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP
    packet
  xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP
    packet

 net/ipv4/esp4.c         |  8 +++++++-
 net/ipv4/esp4_offload.c | 17 ++++++++++++++++-
 net/xfrm/xfrm_device.c  |  6 +++---
 net/xfrm/xfrm_input.c   |  3 ++-
 net/xfrm/xfrm_policy.c  |  5 ++++-
 5 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.45.2.993.g49e7a77208-goog


