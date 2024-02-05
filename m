Return-Path: <netdev+bounces-69136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9A849B4E
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 14:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D75D2815A0
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BE1CA95;
	Mon,  5 Feb 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOpXhKkA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD61C683
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138065; cv=none; b=flVNzc3OyySY+M4NqUm/Ur7X6eZu/N66BzVFEeSrhwoD3rtSoaL/qg+MgjGiElY9uqLXUYmIkstLzngCmAR+8eiff67paMRJoQAjx8CCnKN9chdxs5EbmgfWlOoyu+75czH7Zv6bnJlFzTXYg6VrbJ3sfblySWlVAJGNontB8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138065; c=relaxed/simple;
	bh=KDU5Sap9KmERo+IOTSOxwD/wM01vjxr94Mz5wDzVw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DggmvMl+RKmQmlIt9/av1i1LDhBtphNNjgXiOg8MbzdxDIh+0IKWEY83u7P4wjoyOECTPJ7AoTy8YR1Ee2S1hnPk6qcBD92Aak8kwJKvDTkQgJcfQgbV8aae8yssSk2rYNXuJgW0WNBz0DNkMm2LFhSSS19xMtOl7fzrmsLIq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOpXhKkA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d93ddd76adso31176055ad.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 05:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707138063; x=1707742863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7f+YPdLV02rXa/1f3nKaHnsp07nRY0/vdqPS1EubdSo=;
        b=DOpXhKkAU+4zmVvIZhSlA5LiaPLm9ru5YqgvQ1o4cNlRRgM6RonUWEsQ1koo2hDx4q
         Kug2qoh8cp0V83QxpalcCzL7cuBdt7Qe3GaZnYmMnyP28KKosiFBhXDqy5I+r1mM6uol
         4gC8tWk4+9ZuYBH6/VKo95+UNRsdaD0u6k7sc71dOV+TYlYnqPgt29d6/hiNOg8dxpA+
         wJgFo+rqmIT8DkuI7Qcz2o2Is5M2RLodbrtxB4OAbfEBwy40RMcafN85lSdNEE5jHRg+
         HwQx+8yX2YP6WkU+l2dEQZ0S+0olYDwbdaXKqP7NlWMZrffSspfCwYgCwG5wL9iVSGxK
         usdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138063; x=1707742863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7f+YPdLV02rXa/1f3nKaHnsp07nRY0/vdqPS1EubdSo=;
        b=n2aXKgo4JkID1ylIBmuts2ZAImthZdyJK5NmaBn0gTqbTTC+xOgi89N2S7smb7N/4G
         HWQtNheKxW1gr2f+6dMm+JCu3sA3tOcLPs2sPdX2CCc77COQvjajKeQdcDALb0G7VwG1
         nH+9sxoPnN3LG/4kVyZA8iN+Wd3PwuHH8H0svApAtuhnntoUnNX8RUrcwBY0TioN4I2A
         Z1qA2fXytYVDtCO9rg+5OSJo7/3jlIO+0Zw1ObsqUR2OQtcbjQ9lyOvrjOHs8cDwHV+4
         e42YqS3iBOK00Fq36Rwyk934VdUkA+h9oFRll+h8rSijoEjpXILZm8Zmo5mw6uP/0fkd
         24ow==
X-Gm-Message-State: AOJu0YzJNUPz9V1T/ybTKHqNbx75wUWEsXwh5sa8zGf72XhVL3V4vRUy
	yzcMSTSjwm1SKZgg0okCFdoibSDdvwI2dZKWgBDYhmXcHyQcrNrA8vnhBr0W+Jaf4A==
X-Google-Smtp-Source: AGHT+IHemZ/xNPaJGIfO0LBOVGKdhEA4RoMUBYfbaMX5P/fl+2bU+TlQYwtXODZatLs47tnVzKlbVA==
X-Received: by 2002:a17:902:6b8a:b0:1d6:fcc3:c98f with SMTP id p10-20020a1709026b8a00b001d6fcc3c98fmr12916232plk.29.1707138062832;
        Mon, 05 Feb 2024 05:01:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGI8zVljFEqkgfF8qM/Mzu1KIkE8rRyG6jsxEwWhPQq/Q1LnjLwIr5c0D7PKRZzr74CfH42XTIea+n7DzKS+j+hNEt85nxv9kQiquxmo4Mf0pHocl4Igcci82yRAyyPpgO5pYW/Z6jBkc+maCiZ2hmZPI8dNpQOZKmcMVpwI00ih+N3lRlphyk9NjwvGSz7sbWTqM59Uxw358DaC5F81qFAhbJ6l2phvGBayvPBnjrFEBZ1wGlfI6xCoK+DIuoZd091g==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001d9351f63d4sm6252159plh.68.2024.02.05.05.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:01:02 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net-next 1/4] selftests/net/forwarding: add slowwait functions
Date: Mon,  5 Feb 2024 21:00:45 +0800
Message-ID: <20240205130048.282087-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205130048.282087-1-liuhangbin@gmail.com>
References: <20240205130048.282087-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add slowwait functions to wait for some operations that may need a long time
to finish. The busywait executes the cmd too fast, which is kind of wasting
cpu in this scenario. At the same time, if shell debugging is enabled with
`set -x`. the busywait will output too much logs.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a7ecfc8cae98..db3688f52888 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -37,6 +37,32 @@ fi
 
 source "$net_forwarding_dir/../lib.sh"
 
+# timeout in seconds
+slowwait()
+{
+	local timeout=$1; shift
+
+	local start_time="$(date -u +%s)"
+	while true
+	do
+		local out
+		out=$("$@")
+		local ret=$?
+		if ((!ret)); then
+			echo -n "$out"
+			return 0
+		fi
+
+		local current_time="$(date -u +%s)"
+		if ((current_time - start_time > timeout)); then
+			echo -n "$out"
+			return 1
+		fi
+
+		sleep 0.1
+	done
+}
+
 ##############################################################################
 # Sanity checks
 
@@ -478,6 +504,15 @@ busywait_for_counter()
 	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
 }
 
+slowwait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
 setup_wait_dev()
 {
 	local dev=$1; shift
-- 
2.43.0


