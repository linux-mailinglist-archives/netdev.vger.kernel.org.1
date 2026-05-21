Return-Path: <netdev+bounces-290211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADfQAkRsDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:21:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A982E59E049
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC01530438B7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307EC3672A9;
	Thu, 21 May 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBvCJi2X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B0363083
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330033; cv=none; b=IM/6mscDL/1KcZCaRXHHbilZHboBFOBMw2F3+6SgU7jfvdJGR4Fr+VjRyyqUPlYgueN/mdh50IugRTBLMGB7MOr3fJPqvwhGM/689F1G02a8UAxT5KsQUl0U39jqba33VLJXHxB+G5w/DsMTHaHCxbavr+6AuP/P2wvb4xqJSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330033; c=relaxed/simple;
	bh=sR0IMC2lxIT7oq78hReehczLAD93dLuWS2Pbfk9mJ5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pg6sENNcEtQqTq0uwi5xLcUWQvmIlcrdyuAaK83v7THrLYJuYzbpLmUHn7ur9vtN/6Xj2nH+Jzraeq0kmvd0xESH8BdDvXa5gJdbYLzTQytijVVM0a9+QOFF0HChMX0YDE+E5iNqUpnGg9S6zEXpsUl6o0DGT2fM+hb5wmU6Z7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBvCJi2X; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47c35be02fdso2025293b6e.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779330020; x=1779934820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wItdenP8OH+7UqXadpcXzkNSudYXM+oPYSE7Yb54pbE=;
        b=rBvCJi2XaMI85hMNQyfvJK1T3EfmoR+jbeFMKmGBFMJ2hbsS70aLf6HluSI1e4bUgr
         GZWqmrs1LfBiZJ4xAEa6yLTI4kbaI6914v5zzp3pE3LezNd6oBEpRrE3sJqvN3etZd51
         k8hF+/K+1oe1/P/z43ssO1GjZuSsSTSss1/w46/lIxZ0VsSTNBMbLInWq4yxBPxG51kN
         sT6gqb1tI6FAp3vy3mMSqMaDkQpu1IBF+1696OPEjaqi5n0YgLdpjvgBIveGWDQRPXSP
         4UoeoXTdWSHsEx6WPpX5rIWVFtHdmdquvXs9AJ2STiFTliYGk+JASL8PedNimaBV6i3N
         M70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779330020; x=1779934820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wItdenP8OH+7UqXadpcXzkNSudYXM+oPYSE7Yb54pbE=;
        b=ru4nFup2V4EHFKcmsh4ydIwLK54Cg2ChU70V2RkRcrGUX3olvQE8vS58DPcOcGO/T0
         A5hKaixXkKGkohqGlawFvR6ID0P7tdqID1o98EdYky/FklAhUIBC3WZUHSPykXGvI3NZ
         qnGfOSomAIOVN3W1NPv0VFb4xcgzXiq7zu9e0kV2qUHD1/eazdU0rI8sOazxT2BN3qP1
         +oS6zRtgfVf5FUsJZQ7EYY8ybW42+nwymHPVDWPjZe//8PFFxAROMXQiYulm3QU64LU8
         YNjP/Sa9FDsEeAQGb6nUqy5BHWkepn801wiR6LLQos4R9wxk1hoeCp3Gmi2RSWnkn2L0
         FTFw==
X-Gm-Message-State: AOJu0YwV80COrthXq8GvS3xgyiWjvjgQ6AyiMeDFx7UmdWWetXefkum/
	l8Mf4zVWD/wpLFHTfDww0MMEUsDBVFN9rQrG9LJsWX5uuLEbmwP1Y1smhfyRNP9EHVA=
X-Gm-Gg: Acq92OF5Dvwq547VsHPvGTV/jasraOQI+OKFPKe7dO0GyKudyJr0eTeWPqIDlGauR5/
	N8T2XkVc8EXxoZAgL/nO+VYRQW/pCAfoGCQKn7qwWmMMHwe2bR0xotdBtQ0HCvbOJLzZHlaPUbn
	PsRkNQymUaNfTefIhWg0pOpnO7mgkEfEEDyA9KSTsK+H3E+9O3PT8praHFzg5ABE+hAcvHr7ESP
	EkHm0iywD05Yp7PXn9rBiI/+Kb3KapQ+ZJHlyijyDOE6zo9/lehEyqDktU8IXT/c//OQD1MVl63
	VctOamwLW4MBmYl91Q5Fu6IehcudL+8v1iLG+4PIqsKYTxDt+Ee4PDTNLlMnY/ZavLvTcBFTwjV
	M1H/8+EspDLE+0S/8Twho3HwHIaYEJbf1oBNFspR43PQZaOfuPMKDRUHOxriiEdStffEw51kuQU
	ON42O+OxVtBg/CQz/Oump0CklbQg==
X-Received: by 2002:a05:6808:148c:b0:479:e96e:65aa with SMTP id 5614622812f47-4852edb4dd5mr435645b6e.42.1779330020102;
        Wed, 20 May 2026 19:20:20 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c6b38sm13791720a34.2.2026.05.20.19.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:20:18 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aconole@redhat.com,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v4 0/2] Add OVS packet family YNL spec and unicast notification support
Date: Thu, 21 May 2026 10:20:00 +0800
Message-ID: <20260521022002.879334-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290211-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A982E59E049
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds a YAML netlink spec for the OVS_PACKET_FAMILY genetlink
family and a bind-only ntf_bind() helper for receiving unicast
notifications.

Changes in v4:
- patch 2: rename ntf_listen() to ntf_bind(addr=(0, 0)); the name
  listen() was misleading since the operation is a bind(), and the
  address is now an explicit argument defaulting to (0, 0)
  (suggested by Jakub Kicinski)

Changes in v3:
- patch 1: add missing document start "---" after SPDX comment
  (yamllint warning in v2)

Changes in v2:
- patch 1: use YAML anchor (&event-attrs / *event-attrs) to avoid
  repeating the same attribute list for miss and action events
  (suggested by Donald Hunter)
- patch 1: fix enum-name from ovs-packet-attrs to ovs-packet-attr
  to match the kernel enum name ovs_packet_attr
- patch 2: add ntf_bind() to the YnlFamily docstring under the
  "Notification API" heading (suggested by Donald Hunter)

Minxi Hou (2):
  netlink: specs: add OVS packet family specification
  tools: ynl: add unicast notification receive support

 Documentation/netlink/specs/ovs_packet.yaml | 130 ++++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py              |   5 +
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/netlink/specs/ovs_packet.yaml

-- 
2.54.0


