Return-Path: <netdev+bounces-279272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHUNEpn44Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:08:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A99B9419180
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A59FD3175B7B
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C283B38BF;
	Fri, 17 Apr 2026 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FVXNbnzO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4C3B38AB
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416615; cv=none; b=pkq+sjoK1q0TRyM+UYabgBrLjG/gsoRlpg85krkbazOHRst4d4O/WF61Nwr99uS/S8F/aAeKZkDuvQPatmTa2H5paHmXSVRmQl+fYcdzMGzvhmEVfrDX4l+8ZVwpcfHNDz1JVvmoHHLMIBqKNz1voEyS/irHz9DwjUUekZTGQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416615; c=relaxed/simple;
	bh=JYAUMdsasJPl06sZO7EFfgQlhVPg6lvnkZJszQEYOQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVqG07lib682n1rNuDudroEIfQasLj6USQV8QcN5C4fLhQ0+E1roAbTqhFGBRiEu5EllVNKLyEuxggSL3H++MaBFOGaVU39vH5hqoL4Vhn2/DpCRHkJsBxMz+asWA5VDHuzrg5tBXOXGxMghUzXL/sEvLqQnYjMW/OgUKky3ca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FVXNbnzO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43eada6d900so404533f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776416612; x=1777021412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIrUg1Rvsm+4pzFacQ/KJjHQViVXR880fKFraWdV3so=;
        b=FVXNbnzOfegYhhpbW/+X9eQEP0llQ+hNSNDaTePYTJczTlqVzif4iX7HShGFZUuFZP
         4i3EwetR7ETZhBwTYvO4YfaaMlUai6u5CVhd3B90bvoPjkBRu7z7T/QpVGtzu5UA5ank
         Yno82ZqLqaq9luUAntRJHt28yQUasqKMO7GVpjgZZaqNRixA6mrbMoFCIMIul/607sWY
         k/8TlaVWHkL/EQ7xQf2CftZ7nB87bsTcXiWswNzUwYCNOIHstWoJzidEbDCfMTA/P7FX
         LBTQ0Sq0K1w7XTSIk38kApAcIqZ9UMxuxEZv5/p+CwZERAsot18bfeA6FuQWo5lLN4Z+
         Khuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416612; x=1777021412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIrUg1Rvsm+4pzFacQ/KJjHQViVXR880fKFraWdV3so=;
        b=QkKyzC3RPbP9szykqjKG7139+RqkYsrSXsCXJlpjYdb8WyzsosJW8uBz9ulOc8d2Jl
         3eFGtoxlfypCbRJ9HEK5wKwbpz8m3mb5Q5cHqEr4dqClmwICajmpL0k2dLVB10jldeaI
         0ga2eV6bjcdCnjxPp38jYeRFnIdsECZs9y60FdGAV/o7oDzIB6xf0b4+eSVGoRZjCPCy
         Z/777y1T7/DvnTRw3co65o/vg7AVly4no2X0gf5bVY7r1C9vnKMQkZwytugxQOIou0x5
         9n/6C+2RTlC/hmQCvJgIZ7xpCxEFbtIuBcZ3J6VoXFOmGt23UI8UmfymEQO+gydKL1U4
         ETWQ==
X-Gm-Message-State: AOJu0YyGyil/5/b2EO8WAWNOiFQvIQy1Xz4do9zteZKrRlWDVODh1LEy
	VmJfd699+BZLT2UlvbFUDX+hafP+kPya5A/0U2lK2H3MdD3AOQvZsthuAsc851gp8bFbVsV/tkK
	DKDFu+fMGPn8aE9VPzCDqzu5V/jh4Z3PrJrjP2+VSbWBVyrw2EyAIB4GV/CJe9vDV
X-Gm-Gg: AeBDietQ/pXsMSFRBZqlIpuOk1q0/0EI3xUFR8zJg/IawIwMPmpj/HT0S5YFZnaNjz9
	H7LTJ2eiV1hyVSUp3WEPz4jn3wdwZJ/Yp+lA16EAoeC5rZzzy3p1ucm/iibMxWnYKQkyvQ/OUGO
	XNlKBNNywLVDZNUNj87LnmGOmXKRItQ1gtjYTjUfoTPe3UrznepZ0C4A39Z2K771l/D4ekKN9wq
	Ucdm8Wlhrd2sZcwXidSpiqNFSR8BWjbfBEdYvxh+fQjapprLlo1SFZQmTDaWrHqqk8ZVwJ7Kw37
	hRFwbBAlxjDe2DWGTeB+Cf2+PxfuWrKTNaTavlr7H42yAAClbMvGIxD+YwBBRo8+mcRi+bA26Mm
	UPRbw/r0h4xogp86BRnk2KpG6UhWRgY69wWBtzO/YVGpByY0tJSPF8cMqfCxalvqG+GJaccgCv7
	9fU//DuhfpNRRry9Tg/f4Kn4GlSqPBtvuVYgdbJCMBsP2Qn1A=
X-Received: by 2002:a05:6000:2282:b0:43b:3b80:6776 with SMTP id ffacd0b85a97d-43fe3e0b7e9mr2887764f8f.30.1776416612017;
        Fri, 17 Apr 2026 02:03:32 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7524:fc82:dee5:4129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e591cesm4120151f8f.36.2026.04.17.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:03:31 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	shuah@kernel.org,
	horms@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/6] selftests: ovpn: flatten slurped notification JSON before filtering
Date: Fri, 17 Apr 2026 11:03:02 +0200
Message-ID: <20260417090305.2775723-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417090305.2775723-1-antonio@openvpn.net>
References: <20260417090305.2775723-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279272-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:email,openvpn.net:dkim,openvpn.net:mid,mandelbit.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A99B9419180
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

Notification comparison uses jq -s, which slurps all inputs into an
array. Some inputs can be arrays themselves, and applying the .msg.peer
filter directly on those entries triggers jq type errors.

Expand any array-valued JSON items returned by jq -s before selecting
.msg.peer, so the filter handles both normal notification objects and []
entries without type errors.

Fixes: 77de28cd7cf1 ("selftests: ovpn: add notification parsing and matching")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index c92415aaddfc..d3b322e84fab 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -15,7 +15,8 @@ SYMMETRIC_ID=${SYMMETRIC_ID:-0}
 
 export ID_OFFSET=$(( 9 * (SYMMETRIC_ID == 0) ))
 
-JQ_FILTER='map(select(.msg.peer | has("remote-ipv6") | not)) |
+JQ_FILTER='map(if type == "array" then .[] else . end) |
+	map(select(.msg.peer | has("remote-ipv6") | not)) |
 	map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
 LAN_IP="11.11.11.11"
 
-- 
2.52.0


