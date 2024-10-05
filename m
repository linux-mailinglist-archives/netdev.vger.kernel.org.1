Return-Path: <netdev+bounces-132326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C09913CF
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 03:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32709283C31
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0B6F9DA;
	Sat,  5 Oct 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGlW5TxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B1BE4F;
	Sat,  5 Oct 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728092743; cv=none; b=ZljWBbQMYVoedZpPSkG/b/zFO744qnQmRnLHKM2gmCw/Cja1Az4IP5cb3jwRvwRS25sFV/ZMjyT1DRrhXBnWa+R/FezNuHxmRKCCgYbFAe4uj8/ZBo/3s2CkMn6SF/xYIz8lSD4fykQ9mxKrap/Bg5P3NKZsTQ2HJm/fy1yYH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728092743; c=relaxed/simple;
	bh=fWG1fXg3ZYf7iX4DUU6mCyArA8Rxuz0fZncrjcXHktw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEyfVIi/SvzPTX1LHccVHAc4ETe6o9KD7A1fF0tcw0Gmd7GIgLRgQJ14rYW4wtG9gFiBwmZFDQfd8z6VqxPmm+PIk7SMRW+OATw8pLtCZ4DGI1hKPfuJJ50NJOx18DuyCfpdW4JqZAOkgH3h2sgQQkwFg0Gzmpg+FriWcO4j5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGlW5TxZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71dbdb7afe7so2235524b3a.0;
        Fri, 04 Oct 2024 18:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728092741; x=1728697541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eQLjV0HPL7dlV32BWe8r/nHswhCY6g8/wd5k2qXOZT8=;
        b=CGlW5TxZpmElJ3nlbDE1EkFAnNxmbjTOYfzCCkZ70CcYk1uQBfpX1TLTWioPPc6Lte
         XrNHm23I0+CcYW6pXki8+bw82P6Dm7/pPUcsyd6MuAR4N+5+7eGA6hTN5hpO3tt5WxjQ
         XgMqBA5vWIVtu0HXtpUnGL0m8awvJg3GSH+VEmKWwdvMuz3y8InRat4SUWWwNhrICSt2
         1AwA0PAaIEWSSw0X6ECTY2N2MQz4F4KT8MeDNl9kr0qu4DzLZGOryTkHxgd/tPLEoUjQ
         +aCCRenNN/T0mnbn0TpOqn207q4EmpJivwu6IYfrZSBzV1yBg0OTjCxoHLdPx5KJeAyM
         05uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728092741; x=1728697541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQLjV0HPL7dlV32BWe8r/nHswhCY6g8/wd5k2qXOZT8=;
        b=UiNFDJqWhyvgUY4hhE749MBkW3a/rPLjngrUG7QkrwgXAclpnL5x7KmYZ/yBFDV06a
         3+S/2pid/a1XE9Iubo1N221AsMt5cKKau/wO+/qXmdPIQVnbrsZvlbp0yczRit/hMSVE
         1tAqE7SpyPfZjSE6+WFieSz8qBDXsGDDLO71VIuj5IFYomkg0kILYbSeEF4gzhcJd2hA
         Jdj9RL/ixaFNiyzWFTNNVyvRXwQ5pDZrvqB7a/KsHPTTWJ5bT1Iw2lCAmie3VQOfk7Gr
         3CD6t8sgQuCyLQM8DZ7MkomHQOpxlAye5SCXnyUSb5v+QDh3mM5Iqh9XZxcwSL8kUP0X
         SNNA==
X-Forwarded-Encrypted: i=1; AJvYcCURyRAWa5v2Jy2wbGsdz1Aw5Ae630zaVrBCUJ3YvZzbjRBXS+Lul7WRC2rkaOXAMJEpJw/rOI/h@vger.kernel.org, AJvYcCW2q7jvysYL4lp6+iQn+ax8JxzK2+FgaM7mVYELKqBE8P0cgXtOMrGg6bgLXyuH+C8VIyQ6jevt1OLvgbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrshAwWYOQZksCNzuiD+4EsGpDxsm9ZGq0yU8fmVrzxkaDp/cs
	XrEixTva2cnC98rrXfW4Iw/kOU0ux9sVpp0kIyxo8Zc5GLRegF65iCWWm7f7
X-Google-Smtp-Source: AGHT+IGJsV3Wzf12hiFh9qTy7TwrEkm3ZPpXOQBfy7+FwWwQTYzpJDpgeJfXNnVTdHrULFkeDogufg==
X-Received: by 2002:a05:6a21:670f:b0:1d2:e90a:f847 with SMTP id adf61e73a8af0-1d6dfacac9amr7393998637.37.1728092741414;
        Fri, 04 Oct 2024 18:45:41 -0700 (PDT)
Received: from elite.lan ([2601:645:8800:2e43::abb])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0d695cdsm530175b3a.183.2024.10.04.18.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 18:45:40 -0700 (PDT)
From: Amedeo Baragiola <ingamedeo@gmail.com>
To: 
Cc: Amedeo Baragiola <ingamedeo@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bridge: use promisc arg instead of skb flags
Date: Fri,  4 Oct 2024 18:44:58 -0700
Message-ID: <20241005014514.1541240-1-ingamedeo@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
a second argument (promisc) has been added to br_pass_frame_up which
represents whether the interface is in promiscuous mode. However,
internally - in one remaining case - br_pass_frame_up checks the device
flags derived from skb instead of the argument being passed in.
This one-line changes addresses this inconsistency.

Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
---
 net/bridge/br_input.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947..156c18f42fa3 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
 	 * packet is allowed except in promisc mode when someone
 	 * may be running packet capture.
 	 */
-	if (!(brdev->flags & IFF_PROMISC) &&
-	    !br_allowed_egress(vg, skb)) {
+	if (!promisc && !br_allowed_egress(vg, skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
 	}
-- 
2.46.2


