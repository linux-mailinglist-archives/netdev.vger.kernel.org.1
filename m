Return-Path: <netdev+bounces-283628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHeBFC9392mEiAIAu9opvQ
	(envelope-from <netdev+bounces-283628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:26:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A274E4B66EA
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57DE6300B449
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A03CAE6C;
	Sun,  3 May 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+F1ogvb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44AA3C455F
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825576; cv=none; b=j0NwfzhkYuIoWGeZPsPKHctT9YTq+zil6YYUajJk5zc6pyt4MrarEyfLrObzW5S41b+lGYdbnMbacDCt/sEPxTLo1SmVPC3jKfgPRhlIL0beeUFa9feST02tR7dk+HZbnpPuQUQz/WUCjTbH3A3rLm1ltgkwi+EsXnjABLqDP+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825576; c=relaxed/simple;
	bh=UppTCLyY+Jp0kvcUyw9ROuNW3CnyFay5/4uYFzEZpII=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hewnFrX97XFRTLETDraUKyL3WanMtcOCVBRczgBfCw2IZzEAST7w7drTkz6M81a70DiS5VUilMfBDSie9VDmMLyo2kBsrnXZqfAx4Q0IdkqepRTdF1OaISicxTf4ru7szwm4oMup8AXFyXYoEDK+J2vBuVzHwedv7Bqc99rx2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+F1ogvb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f8bf96b46so1454523b3a.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777825574; x=1778430374; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQu3AJrWbwHsNu5ahobfgefmMuxQAtBqu7LWlmYXgyI=;
        b=X+F1ogvbuHJKK+C0DUcA9KZ8vZkixFeY79JYkDfbHmpjsOtOVnqJcHLC/qJtyQKmWU
         Hc4CfoZuvaZgHmz22thHDvwMLmzZaSsHof9Bd1KI7MSSpVg5w/YmwobJmvh3QBRrmPgq
         BqCkYGcdVKJkLlV4Nnf/hxF24y2sYJKLpQyJOuFwDvKqfVjrWvFLCPH7uLW3Pu0PmAhT
         YvlvV4pPMrTrWWbxAtRtW6KQlqvWuw8w8jwiiNeaC9mGQIZqgheNbl6MTQlMyEEStk+7
         ml+U4oUh4ZT5ua3yXm/On2P7VHzJuQRO8NP6uKmmg98Uke7h4pRoT597EsqBY3l3vWf7
         xh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825574; x=1778430374;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQu3AJrWbwHsNu5ahobfgefmMuxQAtBqu7LWlmYXgyI=;
        b=QKRaN0xgvjI69c/aqT2JA62KbEx2PRu1AbX0Db5UgfvlDy5xSb09/R/WVaGcDHOiLk
         AGsrUhintzxDxHJDlzfoPE/klw03SWWwvMrtRhg3PNWFxQ9Gr6THrjH95VCltteOt1ZK
         J1P8iXtMkuONKTetbVefuHBbi7GuWGd7wCtB1x2/lRNlY2jau1cYr6fvd5pQO7lfgA1s
         +iu6hhuWQj/f8NdqJxka/Q860lY2+lGBwTk2hXJefP7Jp4jiqUbP4WtQLuA/MtWBZnL4
         dAP8K2/ljT2+yywppHVdw/WLhaq8a8UXJtMc1P8J8kQyg6LPJTFjocVyqAbbYaSI1yBs
         YDbg==
X-Forwarded-Encrypted: i=1; AFNElJ/7gLGq/tzz4oJqD5pHh6KdPq9MuCSGhS4+UjlEGT8UfCHmuaLTycKFXD5KfKJIb413wrEEs4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYC4RjwpawN0DKWtOMUCv/2ueawRMc4qOJqjnahWxZGeFmW7og
	+oQ4yJ2r59erwuRReQryjzPZg9iAa9N1AZ2mmdY+6ltqPyKV/nPRxfOk
X-Gm-Gg: AeBDieuNKCIjmNJdmL+G8KQONJF7tQjqP9ebrSVjlqrgZVVq1j34F04OTeB5slxcrM/
	4VbZOCtHx6t+cnuO2Co7aI6TcSEm2CcKvlZWE2f2gad7b98+YolDgrB/ds32e+gf2KMnsqzBrvX
	qjiOzjbplPLWocT4P0oYICUUgoyHm1VE4bSZCj+8Y7v92sbQBBBCvb+RiEiV/DYpwdNaBqMab9o
	/VhxQ/uNGYwBam6cemTG6aIHQVl/CGjdmNdeqmkBLt0E4HqOiK4J1iQqogX8GO7x/cnbfcBv/z0
	ArRRewfdoCysoYZCierlvtA0Lta6OgSDgtxQgymaUqf2DZIyGMOBo81zbeq3xtp2P6Kzvuz5qNA
	PMR+9bx6QWKGf9PMo3DEIFeiQ7XeTAl3oGfEvCtVaKsOM9K0bIHqQLP5BkeczLTfzaHzONa/V+y
	4znHsGF1ra7NouI1qptTDM04zJi0H9u1iE3HFaanXcLbwD
X-Received: by 2002:a05:6a00:2453:b0:835:41f3:f440 with SMTP id d2e1a72fcca58-83541f402c6mr1953995b3a.14.1777825573988;
        Sun, 03 May 2026 09:26:13 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b8500dsm9788911b3a.58.2026.05.03.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:26:13 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH 0/7] seg6: add SRv6 Mobile User Plane (RFC 9433) behaviors
Date: Mon, 04 May 2026 01:25:53 +0900
Message-Id: <20260504-srv6-mup-v1-v1-0-e0a6791575cb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABF392kC/yXMSQqAMAxA0atI1gbq0IpeRVw4RI3gQKNFEO9u1
 eVb/H+BkGUSKIILLDkWXhePKAygHetlIOTOG2IVG6VVimKdwfnY0EVo6qTTea4pSwl8sVnq+fx
 uZfVbjmaidn8XcN8PfmOSRm8AAAA=
X-Change-ID: 20260504-srv6-mup-v1-6a3d5995e74e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=UppTCLyY+Jp0kvcUyw9ROuNW3CnyFay5/4uYFzEZpII=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp93chRT3p0dGUt14JZMpqzhqDYe2S0A9I3gQgI
 NyWPwcvf9aJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafd3IQAKCRAq19F1Kl0b
 TZI4D/9AnhuRg1aQwCbjuglWmzzRnhsFsypuo7atbbXmOgdUKDHkoHsrWr9TrLLWGNPl3UfCUeK
 9m4JC9A0DoDFabdcD29kCJw1BtP5VbXD+00NsGNYxF/uTKfBAat8L8gv9SaCGNc5BfaZhiABYck
 6hRxefgJo1NSZEJib0eRj096dhNPCiOhuwX8kJPpGF//8zCGSFJw5p6SCVetH6ak/O/Ba83s6UD
 1KwQfPaPjA3EjG/PFtiwSR2Z7LJ+p0k34GmHr7l0Gj60AVfUykiU3J+nrgr4oh86DA8rF5J+LrT
 dVICBck0wd5iPpW7TceXvM3ZBmRGQ/VAnAyN1jTK3xdEzjSDNnfVrsycXyQfyzswkbUP1Ey3g6n
 C82p8pL1n6faibev6yWcsOx8jDvucDwCQHfwPhskdtllkFyIEDdkLzBSj43icAA61ZAxHtEGlOh
 WFrulNBS2fytMRVTtyBpHQz3vWrXjcPkhh43WyULyQP6lwWnV4TCrg+4zge3CgAR1KF5RQkmGy+
 Vv1LQ85JWlNF9Yyc4lzDnqd+EBC/rQyNjvawWaMYsj1SZvVaEyJMwPerbue4mugImRjYvtYL/fG
 ETuu5PNFqKoBsHaAwflEGmqp/akGkKS/qSTaB3HzpcyJHTP/xMc8Y5gpxw/teZPpnxjes1Rt/pe
 TWU3ytgV+779D9g==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: A274E4B66EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283628-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[end.map:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series adds the in-kernel data path for the SRv6 Mobile User
Plane (MUP) architecture defined in RFC 9433.  SRv6 MUP integrates
GTP-U mobile traffic into an SRv6 transport domain by mapping the
5-tuple (TEID, QFI, R, U, PDU Session ID) into a single SID, allowing
operators to replace the GTP-U overlay between the gNB and the
upstream UPF with native SRv6 forwarding while keeping the radio side
unchanged.

The series implements the six MUP behaviors that an SRv6 MUP gateway
typically needs:

  End.MAP         (RFC 9433 Section 6.2) -- swap DA with the next SID
                                            without consuming the SRH
  End.M.GTP6.D    (Section 6.3) -- IPv6/GTP-U to SRv6 headend encap
  End.M.GTP6.D.Di (Section 6.4) -- drop-in mode variant of the above
                                   (preserves the original outer DA at
                                   SRH[0] and discards TEID/QFI)
  End.M.GTP6.E    (Section 6.5) -- SRv6 to IPv6/GTP-U egress encap
  End.M.GTP4.E    (Section 6.6) -- SRv6 to IPv4/GTP-U egress encap
  H.M.GTP4.D      (Section 6.7) -- IPv4/GTP-U to SRv6 headend encap

End.Limit (RFC 9433 Section 6.8) is intentionally out of scope.

All behaviors plug into the existing seg6_local lwtunnel framework, so
they are configurable through the standard "ip route ... encap
seg6local action ..." interface.  No new netlink families are
introduced -- the new SEG6_LOCAL_MOBILE_* attributes extend
SEG6_LOCAL_MAX in an add-only way, and the new SEG6_LOCAL_ACTION_*
values are appended.

The egress behaviors (End.M.GTP4.E and End.M.GTP6.E) accept an
optional per-route pdu_type attribute that is the sole control
for inserting the GTP-U PDU Session Container (3GPP TS 38.415 Section
5.5.2).  When pdu_type is set (dl/ul/0..15), every emitted GTP-U
packet carries the container with that PDU Type and the QFI extracted
from Args.Mob.Session.  When pdu_type is unset, the egress emits
a short GTPv1-U header with no container.  pdu_type must be
configured on egress routes serving 5G N3 traffic; omitting it is
intended only for LTE-only / S1-U-style deployments where no PDU
Session Container is exchanged.

The matching iproute2 patch series has been posted to iproute2-next:
https://lore.kernel.org/netdev/20260503154510.912576-1-yuya.kusakabe@gmail.com/

Link: https://www.rfc-editor.org/rfc/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Yuya Kusakabe (7):
      seg6: add End.MAP behavior
      seg6: add End.M.GTP4.E behavior
      seg6: add End.M.GTP6.E behavior
      seg6: add End.M.GTP6.D behavior
      seg6: add End.M.GTP6.D.Di behavior
      seg6: add H.M.GTP4.D behavior
      Documentation: networking: add seg6_mobile guide

 Documentation/networking/index.rst                 |    1 +
 Documentation/networking/seg6_mobile.rst           |  236 ++
 include/net/dropreason-core.h                      |   47 +
 include/uapi/linux/seg6_local.h                    |   17 +
 net/ipv6/seg6_local.c                              | 2667 ++++++++++++++++++--
 tools/testing/selftests/net/Makefile               |    6 +
 .../selftests/net/srv6_end_m_gtp4_e_test.sh        |  485 ++++
 .../selftests/net/srv6_end_m_gtp6_d_di_test.sh     |  426 ++++
 .../selftests/net/srv6_end_m_gtp6_d_test.sh        |  496 ++++
 .../selftests/net/srv6_end_m_gtp6_e_test.sh        |  401 +++
 tools/testing/selftests/net/srv6_end_map_test.sh   |  102 +
 .../testing/selftests/net/srv6_h_m_gtp4_d_test.sh  |  486 ++++
 12 files changed, 5163 insertions(+), 207 deletions(-)
---
base-commit: 98878ed91b68a3150126fccef125ee7b1bb86ab2
change-id: 20260504-srv6-mup-v1-6a3d5995e74e

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>


