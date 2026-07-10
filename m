Return-Path: <netdev+bounces-306466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +sTLLUa3UGq13wIAu9opvQ
	(envelope-from <netdev+bounces-306466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:11:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 043E0738E21
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:11:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oq7emSAB;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306466-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306466-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B7F431265B2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637693B895A;
	Fri, 10 Jul 2026 08:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B562397E85
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:58:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673902; cv=none; b=pYzFGjiqKs+Bc3VnRAjJHpwAYsr8t/92A8aEG73WRWtEGisoWvY1R6mBAl7DUHTRSim8k7KHb5bLiIM143HlnGQsi348e8/MGc/jqMSk3dxGf2b8YEwIYIhNXGVTfJgJAb1Y3ooWjfoFGqcDxEXM0du6m5kbB5VnVTeqAgVhvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673902; c=relaxed/simple;
	bh=x0PDnUbmbST57fVde3MCSNyBQGCvCEtUe+N9UTz3/aI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z0QxY2rm446vvOAJ2U33r0cp+jvP9F65p9d5cDUZITMC97KMLL6EXcURpcUHTylHWasuQDTrlnTEnmv6lA1hkd9uezmcueg9H8gVRMdIOajMFgggJidYbfXld50yoL8ymAgIBXz+CK/9A3bYrirOuEJ2lMoVM+ALXI87t8G2yfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oq7emSAB; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38759bcd877so596660a91.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783673900; x=1784278700; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SkRSQsv1PTfc+Fy5UiQqK3wcmODgXgxN9h+0UhNs/H8=;
        b=oq7emSAB72SF4RtUrwP0ekEjBP07hl1N5n7ZPnbkSedgcXb6K1Upv4+abbe5MZJnEt
         ka4Nu913MOwmHQTc5U8p0vWgHTcPq8b34jY0bWtnWOTLHgRy3DW+TmRlVqvhq0G7c4VQ
         JCXwxdqZCnyPhegL/nxfVgnVxpgscmWaqNBj4YEsA6V/Tge5bJD3JqKCBJNgWHC4dWmJ
         3M5n0gMOT0eQmZ/m29KDgJFGD7HmtaLQk/9OMkB3l3M6MSMZuX5m2DrgGpBNChe5HaBc
         4ykSAJiLsFpzB98mbemZyw5eQYAoFy2rQhHlFG+TISf4hI8zAPRBKipvz39FccPs6Ivg
         qxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673900; x=1784278700;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SkRSQsv1PTfc+Fy5UiQqK3wcmODgXgxN9h+0UhNs/H8=;
        b=fvNa9gVpZrmq4VPj5bb4Fhd+0YfhAHa4ZmXbMnPTiHkjbH2chMyLdtTSYezdmxsJQm
         OjkElGudWBsSiTufpTZ9C1Ecg325e9y4DUj9gwjBUPqB5wsfUieA5gV3oajjR19JOS4M
         d4MVKue1UEN0gf9I7yC1/hdkEuBxGkJFhiSYvgbLuVKp1WCaDwz6zjx1viwu5EAFuAM6
         6xZCEK/tVTaPeAYlllqve1EVQeTfNauE3aw2udNIzWK8dNEmETVGgplwn9GSTbEyVXcO
         LQJ0tXOvZONsfYQByz4Q+c97Jtc2Wjxk2sy7Y8Zq6IpTbwRpWRWj5kVjOZsk05YEER29
         IKyA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9NIjJAUPqO2+ASTgngD02h2eiGrDGYX1Kxcpf0YAt94FoorMzY0BijLfVekgKqUJhjQASFUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQr1mYWsYY3tv5fMVPTvNxaP6FSaZ66gyeJsJhqBetfg2/mHkD
	5VdILD4ajTh8FncO9y5WVJTAGmlie1Yg8fNRbyJCsUpDs+3ITO53p5Ml
X-Gm-Gg: AfdE7cn1NpwDSxvY3Yz8jatkensrofN2bOmVwTwZI2EjfccQ8akJIx7Z7x8X1cq+Mc/
	nkUwv1MNsvYYsujDfEr7omhq6gnL/9yqyii398WZuyQje0xJN5Ehc3Qgfy2hKDeHYd85SEb/GFH
	fEYwe0FyRqCsBCA7pmUslwPBMeKW+MXf+MLlF/xJSCvuSpiKXlCpRiLXOZdWpFEPXmFkifux2fv
	QTB7kGL4Zq+LqFcb/a05T5rHaRoPvZUXz90uVc1uwvFmffiW9C2XBUnXwwyj1aqJorgCv2Qi9vV
	Cob/7bO+cJbAIgBYwigeHICsV3sCvCfOJJDbg0oky9EuTxOmW3SDO2+gX1L7HQWX0faTHjbHri8
	GS/xh6c2nmPmv76JivgXr4pYXrHlJVI0sZDg95hF2d2psHSD3s1k+/T1cRaXUd6D9Zg8DRxJMpp
	TGmVVcC+bVmBK/PcqNO8VtwWzRt+42aoD3YQ==
X-Received: by 2002:a17:90b:384f:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-38941ad3910mr9822608a91.20.1783673900201;
        Fri, 10 Jul 2026 01:58:20 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3da55sm56674275ad.71.2026.07.10.01.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:58:19 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH RFC net-next 0/2] seg6: add support for the SRv6 End.MAP
 behavior
Date: Fri, 10 Jul 2026 17:58:15 +0900
Message-Id: <20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACe0UGoC/yWMQQ6CMBBFr0Jm7SS0KopbEg/g1riA8sUxMpC2G
 hLC3S26fD//vZkCvCDQKZvJ4yNBBk1gNhm5R60dWNrEZHNb5Hu75YCu4H5o5AWGttzXI5cOzu5
 MaY7mQMkcPe4y/apXupyrdVNEVkyRbv9DeDdPuLi2aVm+aEHcm4gAAAA=
X-Change-ID: 20260523-seg6-mobile-end-map-9cec24191817
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2679;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=x0PDnUbmbST57fVde3MCSNyBQGCvCEtUe+N9UTz3/aI=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqULQoLc2xzwmtsRFIir7X9o6cANVW2zLbMLZ19
 os0VH2gqBSJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCalC0KAAKCRAq19F1Kl0b
 TSXtD/9qGpo2LcqrxjsF3CCZ3ud3qNABK7BhCMZmtgPn5sa6AxNXBZKgYNQvGS3DwJ2+N3mfyuS
 8l931d7zS5KvIwIeSdROJQhwjeyFtqSyMT8Dk2jVa9dgQy0etvU+fo99+HxKadYYP6YNSJAZdq3
 ekVdZWXEMpsj4etE5X1PXDtKKFaAdgpSQGkhvEGi3PzAFu9AMt0O5K8mCpOZDb42XoTaHdrZL4x
 0Po0yvu3/1TGQo1JKnld2O2PNBxROMcZMjVy7o4Ku43aV67GZZ1nylmRo/8euQgzv6mH+hKJYIY
 ErE15/DOtn6GxOTSzAvE1swJRo7mpmkO8P8CliPXCU9POdCnATxIjFqsEVxtCFFNplXlZvh+RMF
 IWzc6SW6Ulda/Sum7WxNpMN81kaOXstRziRvt/fOmUl6AxHN2f4U7YDdZq/wChJBjhbrRDioCeT
 c3Nz9lZTqMZJ0WtcOtpE9vS7VkrtwOLpn1epclGl1wBLd1uoICV6WsC+yIAb/YJjvTPNH3Vw1Jt
 QqGuze1GpdITuzVa/U1S5agT6g51PwKuhKElrBxxIzchDJkrghP9LTREqDU1PwWj8nhsVCJh70l
 7J7VIlJ138qr/k2504STgMl4zDwj8fvZqhes7Py2tyKkfbtuwg18x65d14MONNC9qxIUg82POqS
 O5ozTETgGkHarRQ==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-306466-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea.mayer@uniroma2.it,m:andrea@common-net.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:yuya.kusakabe@gmail.com,m:yuyakusakabe@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 043E0738E21

End.MAP is the simplest of the SRv6 Mobile User Plane (RFC 9433)
behaviors: it replaces the outer IPv6 destination address with a
configured next SID and forwards via the IPv6 FIB without consuming
the SRH.  This series is the first per-behavior rebuild of the SRv6
Mobile User Plane v2 submission [1], split one series per behavior
following upstream review.

Because End.MAP is the first behavior to land, this series also
introduces the SRv6 Mobile User Plane lwtunnel framework that the
subsequent per-behavior series plug into:

  * a new LWTUNNEL_ENCAP_SEG6_MOBILE encap type with a
    CONFIG_IPV6_SEG6_MOBILE build option,
  * net/ipv6/seg6_mobile.c, which hosts the action dispatch table,
  * include/uapi/linux/seg6_mobile.h, a dedicated SEG6_MOBILE_*
    attribute namespace, so that attributes whose semantics differ
    between the mobility behaviors and the RFC 8986 behaviors do
    not overload the SEG6_LOCAL_* table.

This layout follows the discussion on the v2 thread.  The encap type
and the attribute namespace are UAPI that cannot be reduced once
merged, so feedback on this direction from the lwtunnel side is
particularly welcome.  Per the same discussion, netfilter hook
integration, VRF support and SRv6-specific drop reasons are left out
of this initial series and will be revisited separately.

A matching iproute2 series adding the "seg6mobile" encap keyword
follows shortly after this posting, since the selftest needs it to
run.

[1] https://lore.kernel.org/netdev/20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com/

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Yuya Kusakabe (2):
      seg6: add support for the SRv6 End.MAP behavior
      selftests: seg6: add selftest for End.MAP behavior

 include/net/seg6.h                               |   8 +
 include/uapi/linux/lwtunnel.h                    |   1 +
 include/uapi/linux/seg6_mobile.h                 |  58 ++
 net/core/lwtunnel.c                              |   2 +
 net/ipv6/Kconfig                                 |  12 +
 net/ipv6/Makefile                                |   1 +
 net/ipv6/seg6.c                                  |   7 +
 net/ipv6/seg6_mobile.c                           | 725 +++++++++++++++++++++++
 tools/testing/selftests/net/Makefile             |   2 +
 tools/testing/selftests/net/srv6_end_map_test.sh | 360 +++++++++++
 tools/testing/selftests/net/srv6_mobile_send.c   | 139 +++++
 11 files changed, 1315 insertions(+)
---
base-commit: 08030ddb87b4c6c6a2c03c82731b5e188f02f5b9
change-id: 20260523-seg6-mobile-end-map-9cec24191817

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>


