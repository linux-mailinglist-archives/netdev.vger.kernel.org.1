Return-Path: <netdev+bounces-283939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ck0Jw3F+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D54C135E
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D026E300D9FF
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E713DE434;
	Mon,  4 May 2026 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFzKd413"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC73E0C69
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911049; cv=none; b=NMxjkXvR1pVqyTU3hix2Earq25ktHcK+4u3TGJsMckgrwvT2dn+8GQAv11D6fF8URG4nVTxDKCkTHar+Y9nBVXUAAQ3cxC3P3XLrUdALC3/VqD31mWbFTAv0jSJPdj9gXV6OQiRS6i0CioazDRDy8ZOllwDolLnGEbQdrIOWwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911049; c=relaxed/simple;
	bh=80c/mZQ1TywRay9gLYcZoyBqruF4Geh/LrcEOwxujt0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eaWQYcjr2D8+RtG9bfRDfhE2qQWMiFE86zr+cLaqMuy55NsVl/Clv9zHXrmlTEUd0e5VmyXQOextk/fEomn/i1ryDG3sVwNnK25XuncT5sv4mWpkzNW0w+T3tyyhj+9XNo9n/VuwJZoYV2ivHM8ivRtzN3CIavxft23DTGMcxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFzKd413; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2589c26e3so39474685ad.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911047; x=1778515847; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00AtaNBmq7SOz3Qoe4Cs/Zt/fZ8/8+CxzNgth7uSAv8=;
        b=XFzKd413Pd3NZbYS6sTFgiRyxKL0TQ91nj94ZLUk8mkTIRlcPIHUO7uUGiDQV0fgfB
         W7UVhF7PMkeH0r+x94MjNjp9ORsTxcJA2yLGBS/5Dn+7oXZUpnjscsFYbQpDetRQc8Pt
         XuKoNHgHIUfMcnbwrTvkqnabhHhfOK838uBQnDA2TZW32gZhpu7a3qvjRG+veErO3nHA
         fkjZJ/inuNCQBKbcsvG32NI6GihYVJ6bYhctm/8JJSMEqKqQTxJ9eUIMwvJ6ewZKJc7l
         jZQ8GEkH3kDNTa2WOgkkO2QXnIl67bzsZNdn+DfM08edi5/M9B5BxvlXwZNbgXxDMBSC
         E0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911047; x=1778515847;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00AtaNBmq7SOz3Qoe4Cs/Zt/fZ8/8+CxzNgth7uSAv8=;
        b=kTgmmdbYLpDClD54JLdH58KlvXkF3xBC2lrqFvHjmRPtqXKszcLXfK+nCIClVSxHgr
         yzv2XbKodx7Sp/LyjUOaymVWjzUMKJzjJZ58/Qayf6UhzEJQSzrmIX0uRZSkMe3H8aZz
         WXLQ5JsMi5KFMpQU4l4b6ZyZMmgUmrMbQ74MdyttQRjG3JshN9Ug8OdL5DIeeEFd2GHr
         cdkK2NgZComVwaDpPY3axPZb/+XcDXSDhkfToE8+G5MZxnO68Q+RrzcUC7au5e+HHbo1
         B2JQdQm/iW3xVFsdS4tNuUPn32ImaIBE3KrdNrqMaabZyZhrdomJCEraCJ8d4V3Hql03
         6iig==
X-Forwarded-Encrypted: i=1; AFNElJ9BmRbYG1gyZF4y9/EggIfDDFmqpRtkUOFQxXpSp6uElpk1Aj3bQgxprvh05CLYzO2q3t9ph5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSqcN18FjQ70rMEM20NW4f1B714jUV22A2ZI4YQ5H6zvBnITW
	QjzKe7D9zJipIFRHePjX0T5VM5CYIQpuwVFZGOngtMy3CT8F0EgDj9i3vn8nqLgD
X-Gm-Gg: AeBDieu2n9paciU3Es5fMaCuXULRFMU17UfqghD0i4tPbQ1WOpE2rjyHXKfVuxXsVkV
	c4gNjPsQwpY+n6igaPg5jQf5BdpFgVfzPHdHiZ/E+aZm1QbXiylh1LJ7ormmz/tVXHcVCu2RZd2
	8r4nWcwHOnRkQ+a0zuBStR3ubaO43UADbyiAr5JMl7muR8HB/U47/fWVcxlJGO7y15z/VS4j7dc
	fo7aQjmoqW4K8LKWnI2izLmhyC7JLYUrfVXfczFBJxl19CZVoC9hJZxbj3iRQTmsoNbD3g6+Z6i
	+Da2+ME7SRk1YSjIN5QDzqhWCFTzcqBdf+8GL3GKj3j4a0etnp9F5/8YPut6ZDM461D5DHjLGOd
	yMVWOLzdLauP/UB57+bWOtOYxosoe9uT5j73Cxu5pGm2jNBvsj60Q1vzT0ANqxR4wrsR7F++cF4
	ncqbX0t0yh550zfywBwmnhd5T9xUZydh39gRzd5MXUSyhu
X-Received: by 2002:a17:903:2f4f:b0:2b9:cd2d:6f14 with SMTP id d9443c01a7336-2b9f25343e2mr101014585ad.2.1777911047010;
        Mon, 04 May 2026 09:10:47 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae58906sm107674015ad.74.2026.05.04.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:10:45 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next v2 0/6] seg6: SRv6 Mobile User Plane (RFC
 9433)
Date: Tue, 05 May 2026 01:10:40 +0900
Message-Id: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADF+GkC/yWMwQrCMBAFf6Xs2YUlNkH8FfFg62td0aRk01Io/
 XejHodhZiNDVhidm40yFjVNsYI7NNQ/bnEE670yOXFBvLRsGAO/U6cvsD+2XrwfQpAT1WLKGHT
 93S6kU05zgeOItdD1r23unujL90j7/gF5Z1h7fgAAAA==
X-Change-ID: 20260504-seg6-mobile-5345055f6608
To: dsahern@kernel.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3057;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=80c/mZQ1TywRay9gLYcZoyBqruF4Geh/LrcEOwxujt0=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MUCaDYdGQJcIvHid4u8Jr6WwpWPFhBdvyS70
 Ko5eRJUlLaJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjFAgAKCRAq19F1Kl0b
 TWstD/49RtFpHb8Xvt265X/vtUYSbEE7vssCOIut+oaCjj2lwhviYlPDl9pa8es8V16KsMxYj2A
 Q7ru9wPoBauB8kmo51RCk8xEn51AQXsl4qRzs1bDAHBspXKh5dcF9P0EkiYUNg5L0uIrQkMH3Jx
 L9s0Kwa9GoKcfe5cku92C4m8qYZNynoVmEubacZjOHzLxuJCpChk7Z0YsU/rAkl95KsfNDv4KmH
 Wxb/EO7BG4d3uxGiJvJR8rGYwO5ROj3XVUklQWKjb6ErpmpgZykPqPg4aEdbMcNnmNEB0vUzvpQ
 uATcG10588sMvXZ3sFRnYdxmABfphfQORMqATXeez+FQ/7QVtUH8IPohVn2tsrmoyPFWnyCiFYm
 BdUqECHh+s4tHUjBP0Tmng3/Q0w1bsx1Ax7aABfaqHLpCaz4HugKAtn1UU4DlKVIPUkhjLRBnQI
 tUyI/GusPjZN7hXiTbsANQCRg9iGZa0OTTW7Aqo9ETlyeLNvo9gNbLpny2szwq3Z9glTuGTFL+V
 gR2rF4fkerPJsJu5DcnEaHSWvBPCHVTp3bv+fyVd4auXfYvfSKHTcybBoOCDrcvy0iFNYMjd3ZA
 sFd1en1K3Mku89Au9b/GfHeA/j8UnnSTpdUq4i/Ku1rfxLjtNQfi1Ts4sHAJuu1oH5PxK5kNs9E
 HUS1qb+Fwh5CNRw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 182D54C135E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283939-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ietf.org:url]

This series adds the iproute2 frontend for the SRv6 Mobile User Plane
(MUP) endpoint behaviors of RFC 9433.  It is sent in parallel with the
matching kernel net-next series; each commit here is self-contained
and brings in the seg6local UAPI bits it needs from the in-progress
kernel UAPI header (include/uapi/linux/seg6_local.h):

  Section 6.2  End.MAP
  Section 6.3  End.M.GTP6.D
  Section 6.4  End.M.GTP6.D.Di
  Section 6.5  End.M.GTP6.E
  Section 6.6  End.M.GTP4.E
  Section 6.7  H.M.GTP4.D

The series adds these seg6local CLI keywords:

  src                  IPv6 source-address template
  v4_mask_len          length of the IPv4 DA portion of the SID, in
                       bits (1..32)
  sr_prefix_len        locator length of the egress End.M.GTP*.E SID,
                       in bits (1..88, leaving 40 bits for the
                       Args.Mob.Session field)
  v6_src_prefix_len    Source UPF Prefix length P in the IPv6 SA
                       template (1..127, defaults to 64); requires
                       P + v4_mask_len <= 128
  pdu_type             GTP-U PDU Session Container PDU Type (3GPP
                       TS 38.415 Section 5.5.2): downlink|dl|uplink|ul
                       or 0..15.  When omitted, the egress emits a
                       short GTPv1-U header (no PDU Session Container)
                       regardless of the QFI in the SID; 5G N3
                       deployments must set pdu_type explicitly.

The matching kernel series has been posted to net-next:
https://lore.kernel.org/r/20260504-srv6-mup-v1-v1-0-e0a6791575cb@gmail.com

Link: https://datatracker.ietf.org/doc/html/rfc9433

Changes since v1:
- Drop the per-action userspace attribute validator entirely per
  Stephen Hemminger's review.  invarg() expects the offending value
  as its second argument, but the validator runs after parsing and
  has no argv to pass; the kernel already returns a clean EINVAL via
  netlink extack for the same conditions, matching how every other
  seg6local action is structured.
- Link to v1: https://lore.kernel.org/netdev/20260503154510.912576-1-yuya.kusakabe@gmail.com/

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Yuya Kusakabe (6):
      seg6: add support for the End.MAP behavior
      seg6: add support for the End.M.GTP4.E behavior
      seg6: add support for the End.M.GTP6.E behavior
      seg6: add support for the End.M.GTP6.D behavior
      seg6: add support for the End.M.GTP6.D.Di behavior
      seg6: add support for the H.M.GTP4.D behavior

 include/uapi/linux/seg6_local.h |  17 +++++
 ip/iproute.c                    |   9 ++-
 ip/iproute_lwtunnel.c           | 149 +++++++++++++++++++++++++++++++++++++-
 man/man8/ip-route.8.in          | 154 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 326 insertions(+), 3 deletions(-)
---
base-commit: 4f5de57e2ff11a5925dacdf3deeeabee7ba9502a
change-id: 20260504-seg6-mobile-5345055f6608

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>


