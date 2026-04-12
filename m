Return-Path: <netdev+bounces-277922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KEXAaEY3GmeMgkAu9opvQ
	(envelope-from <netdev+bounces-277922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:11:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F20DD3E6404
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 033693004417
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D444C31E82B;
	Sun, 12 Apr 2026 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WS92gcM9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E674318EE2
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776031891; cv=none; b=dzW9en0QPCJNCrSGr/hWyqMqeQn1XS3wcotB7x+GyDP1xO9uEmBJotF6qRJIly79ixho0QcY6B8EpOnDZVEQzxusf7Mx/HpCRHGfhi6PXYzTlaJftbI0yrJaPRhy5+qKWGv8dKyUSiJs7S9/0SLQTT+05gY5kk1zNke433ltPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776031891; c=relaxed/simple;
	bh=yo7KPxiOiE1KIpXu9K7GDLl8EICUyJxNYAB8GD0oeio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpNUUWebOPjtREL4sBu7+b3Uflf/pmlPc9jg36eCvUqrrWpWa4FvJKQCkZrTEFxf1b8i+/dcHt+7748aBscNbehElfPP/RZ7woG2HoGYO3N4l2yvM2+BLmaq/c2ceIXq+c4OPrspH1rcftMnpnSqyrOUxxPrpDF4Rd3DyjG5XBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WS92gcM9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso64528595e9.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776031888; x=1776636688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5ywhllaexlTwspCc1qfpzXM2PQy8HyPxKA+SoFBdGM=;
        b=WS92gcM9BT1nz1S3wtfOlxDaWZuvsqGZfii3JWY/3kuBRQ/TnawkKxDVpAZdKFhOEq
         hGRkKSGjgsmWWUhnszhkZEso4R2bvvp6mMkXuDzrIMl2g3lTLtgTRSOAVv5irWparbMA
         ziVA8XimdFIhD8l69rJ6fMhpekZjT2O6mSUplI+aSkLtqJ/cGmIybi1h6yvxdq+NOpR+
         C9hHihB+bhjlK5yXy4R49AJ/jN4UdLq9ssSx7HXocWHgee36s2hID9RCteZold4cutQ5
         4qrnuVeU4o5GvGpDLSJpL/XgB0i9DwTHUmb2AeH0u+obMW9HpfmaeaE3WCOrSDyAjedv
         p9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776031888; x=1776636688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5ywhllaexlTwspCc1qfpzXM2PQy8HyPxKA+SoFBdGM=;
        b=TGjWFXg7oBPz+NXfV5HblpW8xe/vUndXjC45PcsMRO+uFVbnG6rCzr2Ybk+tbD+CR+
         KNC0afGNnwm0t/ubr7gbxRGMVVk7HceTQXDXn5cqr5ndHFjuFAiLPvB+m/f2h5uRMcIR
         WPaRESPIkrVHCjJXrVNdcSgP5s9n3NPzVj58QhAr8WZgtcjRNIHZbacz79LWrSLtor9x
         KDT8QwF9HuXnx+IGW7u72k6Mk5mVGkfuHSZurdVP3HDLR1WRAtPRtLxEFprOh7IRYQQV
         YJoV3eJTgyHyrC4Ux2bsofrRvkYJ0ZR4Zfapml9LqZXG0GBppiq9cVtCYR5zCBq+oKxc
         4IsQ==
X-Gm-Message-State: AOJu0YyqpMmWkKMMb/sZYmF9iwYo58O/X1Z/ZzT7IhqeUOFA268UnrMh
	IwJfmHA84EGNKKVmsHF57qdhsFcGYeEZrEwA2fQ/O+Gfrr5XcsadOuPiKDVn6mbGM1zIuUPF06e
	O6TICzb0uI+fseeoOQPWBB9eDOzrEiDejSdEKvPtVvDWtmmc3xesG1A7oHGRchhvJ
X-Gm-Gg: AeBDievlWW+FThsUgxzvphExKgbLh9cMAo0bmYWMtpfk8k9y3L3mVXSiuV6yBcg0EjX
	9npHwxLrvxTozM9kdA/vtSN8cydJBEBiRleOyJayotaJe3reH5bQycRnuQWdTpa6adfLVh4bSeo
	Bm89TrL04j/fIfX/8Ea1G6VQckDftlnjCvZbZ+eqDzpO+FlNUW2u0XHgVPQ4BI7CXHGsNxa3mQy
	uI6l+DF9dpxa+Bzqh3Kf0UjFabDjEFGRB+4lR7a9vAlI19Uc8A6Zo3jXs5KjmeIyppPeEKDiWuw
	I/wq3/Dj/uQcAfM3miy8USPj6bZ2WOEF5QWxA7YRFgL0Wf1FSUu3m1IdQyFH1lW/5ggEctHh4KQ
	/8/6cuf7RxWegNur1WNK5c4tNX+C/FxInlY6ucTP9FAL8SRSXCJXCoeec+yduJabfoL00tKhWo2
	edjgF2XLPJwfOloc9FD9KsWT66JNOw56YKOwak
X-Received: by 2002:a05:600c:4f83:b0:488:7ff5:2c67 with SMTP id 5b1f17b1804b1-488d67f0aa2mr133538245e9.12.1776031888358;
        Sun, 12 Apr 2026 15:11:28 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:e36b:fb32:ad41:43a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d70891sm84910805e9.2.2026.04.12.15.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:11:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/5] selftests: ovpn: fail notification check on mismatch
Date: Mon, 13 Apr 2026 00:11:18 +0200
Message-ID: <20260412221121.410365-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412221121.410365-1-antonio@openvpn.net>
References: <20260412221121.410365-1-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277922-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid]
X-Rspamd-Queue-Id: F20DD3E6404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

compare_ntfs doesn't fail when expected and received notification
streams diverge.

Fix this bug by trackink the diff exit status explicitly and return it
to the caller so notification mismatches propagate as test failures.

Fixes: 77de28cd7cf1 ("selftests: ovpn: add notification parsing and matching")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 4c08f756e63a..336a2a14285f 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -140,23 +140,34 @@ add_peer() {
 }
 
 compare_ntfs() {
+	local diff_rc=0
+	local diff_file
+
 	if [ ${#tmp_jsons[@]} -gt 0 ]; then
 		suffix=""
 		[ "${SYMMETRIC_ID}" -eq 1 ] && suffix="${suffix}-symm"
 		[ "$FLOAT" == 1 ] && suffix="${suffix}-float"
 		expected="json/peer${1}${suffix}.json"
 		received="${tmp_jsons[$1]}"
+		diff_file=$(mktemp)
 
 		kill -TERM ${listener_pids[$1]} || true
 		wait ${listener_pids[$1]} || true
 		printf "Checking notifications for peer ${1}... "
 		if diff <(jq -s "${JQ_FILTER}" ${expected}) \
-			<(jq -s "${JQ_FILTER}" ${received}); then
+			<(jq -s "${JQ_FILTER}" ${received}) >"${diff_file}" 2>&1; then
 			echo "OK"
+		else
+			diff_rc=$?
+			echo "failed"
+			cat "${diff_file}"
 		fi
 
+		rm -f "${diff_file}" || true
 		rm -f ${received} || true
 	fi
+
+	return "${diff_rc}"
 }
 
 cleanup() {
-- 
2.52.0


