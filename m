Return-Path: <netdev+bounces-283951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA+1E+bJ+Gma0wIAu9opvQ
	(envelope-from <netdev+bounces-283951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30354C1672
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E5F230331B9
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFDA3E3DA3;
	Mon,  4 May 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqp/CT2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB5379973
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912223; cv=none; b=lScjWbf5f0GXyLGH2ERC7Pz+38TxQ11mFjkZVDMMrIG9sfTlOEicJozsD6ytBP14e0wC/SSBrm0u6dBdVpdDnqXjJxvwHXeiphC8jg/9H3cPnoeoq11RP+LEAxhjb76+3cf/JflVDm6Iw51TcL5XbGDET4LwFlwVFP8oTppAN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912223; c=relaxed/simple;
	bh=t/WDX834jlVF7DP9Ia8VfOzsGAXwCxpfBKZASbwEbQI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jsUOQL03G3PPLaReWZSPBC9brU5rAU8qQ5yrVAwlWVsXZ4lQISz/3BUoEwWyJqzpjgUUaOMKAKjW5tb0mZWVCC405yUTign2YBiF+MtiAOZGqJNUO/dUaHArziybOJEE9t7q9uGV9/6kIcqMw9F2fF4QDOdWVMplnQxe1DFi+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqp/CT2o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82418b0178cso2081413b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777912218; x=1778517018; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3qM+FJU1H6+E/i7TldQkDydNXf9wDxrZlqG3KlzPKhQ=;
        b=dqp/CT2oVY/cprtvk0NRc4TNsmnl6ojCgqBHJxBkXedqee7k5lUTf9I8F4DGHNAYZo
         vRcJyMGqATpYngx+p6gnjPggxMFlD+ckIAoL5BeXB1z5WQRw1rvOiGNwvXpxO0YLXSh4
         jqI+8vvJSK2zmgNG0BJT4rCtCYmCtxuvvhbhwxbAXlKfpHoYvsoWY9O1IXhxE8pYzFXJ
         o7VzgdOu393T+zXVAlNOETDfqlnfARVtIcsGkiWUlex81kLzokZcpW0SlVHOxM4+5dZX
         MlhTMhic/S8ImWFOjhU4k5VE0CBrtJG9I+dXDcbG/kJ0pZBmCtdVMy/gIe/NvKrLFYKw
         kc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777912218; x=1778517018;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qM+FJU1H6+E/i7TldQkDydNXf9wDxrZlqG3KlzPKhQ=;
        b=XAiAlHXkkZspPeoNu0SRGLbZzV2BE8+YeIFrA/DcckHeJSYj5V8lXCoV5R8382S9rG
         7O83M88DDrLZxw5oqU3wq10OfCLfxQbkaw0KB56RTkV2ksfyO960kk6yi/8a4dwDgcGj
         /TSdxr7QjKyNgHP+na+RZ8j2PTS8FOHsDZmPTpsmz4mpgAsZEjaJxqNtXE0NGpiztr+A
         l85Sy613OHgFaj6ru8HxKJ4z33dykKwHLh9A1vkz7uZXpvscp3OuoI4c2Z4PlYOvQogK
         LYgQ/W4r7+TFWJnfTOEcLzky5mXHk37z3D9Z8KQ+Mx2zrY+VG1R94Z4z0OvWsDfIXklU
         81rg==
X-Forwarded-Encrypted: i=1; AFNElJ+NdWb/o7sSnLpfx0ch5qYwZ5V/Lukaeo1u/fzJuAVP7V7//1SCtMs0ZWB5isKsRY6RxXroaaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbq3YqESKoal2HxaIzJYNzJarvIy0+RFG+pamBES15Q/nleOr
	MdwPvF/0kylDHXc31C4H9EK5VMmo8L6VFoohbnNbS5UnNk6wyVCj1Enl
X-Gm-Gg: AeBDievZQr6uDMFP/0MEWehTDOLf5/MpjzqYolcSbhBQxbkx5oSMnZLEfbyOajjfOcm
	kNMd1rH5cAI2PK7Sox8EBJg+k/O7a3FR6hzTxq88ujpcDWHZODym6hSskjfzjjsOSmiyxcVIhrI
	nW0l1OW3xswetw070VZCbJOxoY9t5//Xhya9f+2cVYoHaYuImevXxspPJuSoimQo1KG3hJNsjJU
	lutLyQVvrAHFbfSr7FjuMovbXl8jpQrV8xgiTcFwLssOL+3VFnAO/evM6aY5Q28Wxe9IwlG6Wte
	FNzfUA5zlkIlomFdTYzji6mRx7e8V3lP1MDX2qwAw8nx/+G1ajC2sN1uM8UJ8xQP7j76q13EiFC
	nIMiTNx7gy/mXRjNzlg/bLhHrFO3vPfuEXDSIQ87g47G15gMydUNM33t3w9YvbjkDWBB1uYTnOC
	l5LJ9DdJasWIDJw3wagYhllv8RH2RJH8dGoFa4nvBpiAME
X-Received: by 2002:a05:6a00:1826:b0:82c:9f7e:518c with SMTP id d2e1a72fcca58-8352d2029a7mr11070469b3a.25.1777912217603;
        Mon, 04 May 2026 09:30:17 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837081abadfsm4998663b3a.42.2026.05.04.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:30:16 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH v2 0/7] seg6: add SRv6 Mobile User Plane (RFC 9433)
 behaviors
Date: Tue, 05 May 2026 01:30:10 +0900
Message-Id: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJLJ+GkC/02NQQ6CMBREr0L+2pq2sQVdeQ/DotQPfAOUtNBoC
 He3xY3JbF4y82aDgJ4wwK3YwGOkQG5KIE8F2N5MHTJ6JgbJpeaKX1jATrPRNTQga8sKZSVRC2U
 hLWaPLb0P26P+cVibF9olK3Kjp7A4/znuosi9P7OPybzOLIoczpAbXV6FKpVt7t1oaDhbN0K97
 /sXNrrPNLgAAAA=
X-Change-ID: 20260504-seg6-mobile-f78e282e615c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4494;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=t/WDX834jlVF7DP9Ia8VfOzsGAXwCxpfBKZASbwEbQI=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MmUQ4uOSFqsLABgLmDA8N1QVqzEsjuuzcydr
 OUus2wHYGSJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjJlAAKCRAq19F1Kl0b
 Td83D/9GDmmQ/cP9O1v5vS9LMuoKdTKQR+f0681wFU1mdnXDZ06hGhkVw1X4bAxCXfNcVN7dtVX
 H/d3CLCYXEf69WAKByDWhE32nRCiEu+YhfT1J/8DxHQrrIC5UBfG3V3tLSHRhk1Pwu8gfY97/sT
 J+0hhla376kMaRymSW28ZzV0qEd3euKLipVgYakvf9NPZVgFy54NTdjLRoL+enROqSx1Ge4Xt02
 frxwNRaPNcvUL2PpZ1eRTRVeaudwRKm0Rv+0WK3P/FvpZnpbUPLidt+3LcjVLaNRTigCqXStCmA
 vQq5SVYv3+i1OBNvSKUs3CtvEmvD6nndY92/z20OErmG/r10QlYJro5+iOs3b9MeuQKaOoO0dfE
 wsKUps2XJK/j+SBUKGHCibJ/XkiVQMMBsXe30NPRrmIMo0KNuf4AYcjDWhIeIHvj+OCp1nPhjum
 vDZLGtqOnE/UtmarlQx9pFzJrlyP3T9NmcPhT8Xm4bp3qsTF4e1Htr5iJaOmHDvuuoVwM75uFSp
 vUY2fJv6WD09narTNivy8rG7RsGe5douEBRiW/jd0ykyD/bgEBMBFnl0gbO6mlahIy4VUQptPMV
 5B9jP4de03ndLKS80KD9kv2HSPbluxsyCDm7WJV22/kWe3F2jpu6WVbaRivkFzeAztPRNH8mkJ+
 ZJ4APW8Grq+4LWg==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: C30354C1672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283951-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rfc-editor.org:url,end.map:url,end.limit:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
https://lore.kernel.org/netdev/20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com/

Link: https://www.rfc-editor.org/rfc/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Changes in v2 (all reported by netdev CI, except the End.MAP one
which was caught while reviewing v1):
- patch 1 (End.MAP): drop the explicit hop_limit decrement and
  the hop_limit <= 1 ICMPv6 Time Exceeded check; ip6_forward()
  on the way out already does both, so the explicit ones caused
  a double decrement (verified hlim=64 -> 62 instead of 63).
  Now consistent with End / End.X / End.M.GTP*.
- patch 3 (End.M.GTP6.E): add missing #include
  <net/ip6_checksum.h> to fix clang / allmodconfig build.
- selftests: silence shellcheck false positives (SC2034/SC2154)
  and sort TEST_PROGS entries alphabetically.
- Link to v1: https://lore.kernel.org/netdev/20260504-srv6-mup-v1-v1-0-e0a6791575cb@gmail.com

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
 include/net/dropreason-core.h                      |   40 +
 include/uapi/linux/seg6_local.h                    |   17 +
 net/ipv6/seg6_local.c                              | 2660 ++++++++++++++++++--
 tools/testing/selftests/net/Makefile               |    6 +
 .../selftests/net/srv6_end_m_gtp4_e_test.sh        |  486 ++++
 .../selftests/net/srv6_end_m_gtp6_d_di_test.sh     |  427 ++++
 .../selftests/net/srv6_end_m_gtp6_d_test.sh        |  497 ++++
 .../selftests/net/srv6_end_m_gtp6_e_test.sh        |  402 +++
 tools/testing/selftests/net/srv6_end_map_test.sh   |  103 +
 .../testing/selftests/net/srv6_h_m_gtp4_d_test.sh  |  487 ++++
 12 files changed, 5155 insertions(+), 207 deletions(-)
---
base-commit: 98878ed91b68a3150126fccef125ee7b1bb86ab2
change-id: 20260504-seg6-mobile-f78e282e615c

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>


