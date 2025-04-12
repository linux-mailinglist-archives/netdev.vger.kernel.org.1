Return-Path: <netdev+bounces-181894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB4A86CE3
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 14:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5378C3F69
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A71E7C2B;
	Sat, 12 Apr 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRwZKsie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD6199EB7;
	Sat, 12 Apr 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460677; cv=none; b=Q4e1TOSQAD0OI8TPTgUtmEqDJcE2fLKajKzo+7E1l64boahcDOo2W9hzFkD4sZhE/Q51YhlOvfHvhaAOnKgzmGQ7qYlhbrqcQ7lupgOSe/bX/McOUm/Fgn5dKPBffJmNv5hIKY3O+lbX6IeIaPhM4OyUklqb3GOHpvsZ8bb7zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460677; c=relaxed/simple;
	bh=NH5eGn6YE0HYD57U3tcNn0RG+jMroQa0IL0NGEFRWvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfGo7w4azjrv9OXptFoi3JL6QEv9Ia9KCc2uTnCyfb5IAKQ8LZGlxWgB88YF87mfU5f7ZOLnOFWl9gSxUAAK/j8Jbc9pYi5KljO9c9oGvM9c3l2lqSp9IKBK++ljWvmDUG3q/sX34tPm08EiWIky4JlKWuCRIkchiloywqiZ8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRwZKsie; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso559482366b.0;
        Sat, 12 Apr 2025 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460674; x=1745065474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h62p5OZhNIxTCZKWZTx+snSUEMw+Ce8DbeAiOfkzjuk=;
        b=FRwZKsie+F/6zGsriPIoznd8vz4XKigaBN3NlCDhEbCAjjId0SXd92WGKJhenHwLnJ
         WtBAW+esG08q2Ftm6D9cZxhfmw3inWGPyRcd+Ny8iI8UtGBIzlZl1ARbHXPCWQflOUOy
         Vft7Zi7QwmtdVGWz/KYFI3Jorao7sbmFrgJILIOrflPE1JxKZlwgxb6hR9zQ8ahy2KrL
         nX6sDeAmMGVzYENifPK7HlE7GjEGHhCxDmPV4s0hejG7a7FAPySLCR7gA0DltYhl8LQS
         gqKcWo262z3vUAnwtIQbrw8hBXxaVopOURkm5LrjFIf4cqgf28zDCFN5h6pWvdVyzBcv
         7BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460674; x=1745065474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h62p5OZhNIxTCZKWZTx+snSUEMw+Ce8DbeAiOfkzjuk=;
        b=iCqdpf4Vh/LNcFmY6wjyzYaoIbkpOVfsba1xm5Q0TAyVWvxBSlCd07L6gz86IfJu0/
         H02piicKaa9FrBNbezCEBCGrHTxjcoa/ptXSyzrB9ys4XlUreFK6b+pAhOpjgC/g1JbN
         GmVCTOFLeOirU8PPbwESusDFkGx5aye84bDbhcMF64iWFkzh6i7AcnwqWekt3q2hGgqJ
         XPFMhLhGgoD1XyFA5UenCUI/J08oIGa7QvpRmVoV8tVEY74pbr8V5lR3BYRNgrjzDXDV
         mt7nch/u9AXqi74JULKbAdScsINEPbN2LwbvNYbz8URA8MTWmwCy2MQqKQU1vHEGuNVR
         5zog==
X-Forwarded-Encrypted: i=1; AJvYcCX2GZFCq74K7zZpQ9nlo70sCvXLYZnEiFoZU37gA5cGDbRxTzxrzrusZURSzUlJV6tzVLyrH3bM2hQwaDY=@vger.kernel.org, AJvYcCXuphfungjzsMbjc0T50mcmyuspcnt5RIVdsP4xbGoDdZUDfT5CnFpEY4ZHZ/ICRl8PuY3DyHoS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx15I+baFq/gZgLAzuQePJfheby95bhDFEtritWThfPD97bGHO
	ao0HsgDUae2HPyfI3jomfql+pp2pWwOMHdthiLyd2VahiIKsaJcg
X-Gm-Gg: ASbGncudPLngFJsT9B2VAkh+G2l9zNCnDuy2azp3ZD6TM7FmxepfAVpW1B64n8tYllD
	/MswE4AVBvLQoyTEFF6qE9ZFnJtEBR+6xq+OQrhjF4SIIVmcsgudtb4pPR+BmYiIgAHpuLjaJ9L
	3kfAoZGTCNKgq2vo/ixXgAoIdgt0OFzFUEHDSblMd0+vs0+Gr5cmReN5sSnGDmV8DOcBRJxLYg3
	R+YkrqbY7MPViVHWLKjATtoCOWJUsHHdYDsWeKksAEJQF9lfWD64T5I+nG32LGnOU4mVAIFYC+i
	1J6jr7QIMx4nsKovFUyuN2+3kXB4CPZl3/8Q7c4AJVag380OyVGpV0JwJXeanuK6qQepT33WaAi
	Cks4tmLaRflWzCFxIIAUR
X-Google-Smtp-Source: AGHT+IE3PQsp0woHKCAQep31M5T17L80A7LsFOn3Z/6unyMlIOgH87RRTA56azZ4MIpFb8C9y289zA==
X-Received: by 2002:a17:907:9496:b0:aca:9a66:9a2b with SMTP id a640c23a62f3a-acad36d93e8mr477078266b.55.1744460673553;
        Sat, 12 Apr 2025 05:24:33 -0700 (PDT)
Received: from localhost (dslb-002-205-021-146.002.205.pools.vodafone-ip.de. [2.205.21.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccc363sm603439066b.146.2025.04.12.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:24:33 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net 1/2] net: bridge: switchdev: do not notify new brentries as changed
Date: Sat, 12 Apr 2025 14:24:27 +0200
Message-ID: <20250412122428.108029-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250412122428.108029-1-jonas.gorski@gmail.com>
References: <20250412122428.108029-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a bridge vlan that is pvid or untagged after the vlan has
already been added to any other switchdev backed port, the vlan change
will be propagated as changed, since the flags change.

This causes the vlan to not be added to the hardware for DSA switches,
since the DSA handler ignores any vlans for the CPU or DSA ports that
are changed.

E.g. the following order of operations would work:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
$ ip link set lan1 master swbridge
$ bridge vlan add dev swbridge vid 1 pvid untagged self
$ bridge vlan add dev lan1 vid 1 pvid untagged

but this order would brake:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
$ ip link set lan1 master swbridge
$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 pvid untagged self

Additionally, the vlan on the bridge itself would become undeletable:

$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 PVID Egress Untagged
$ bridge vlan del dev swbridge vid 1 self
$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 Egress Untagged

since the vlan was never added to DSA's vlan list, so deleting it will
cause an error, causing the bridge code to not remove it.

Fix this by checking if flags changed only for vlans that are already
brentry and pass changed as false for those that become brentries, as
these are a new vlan (member) from the switchdev point of view.

Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs from changed ones")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/bridge/br_vlan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index d9a69ec9affe..939a3aa78d5c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -715,8 +715,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 				u16 flags, bool *changed,
 				struct netlink_ext_ack *extack)
 {
-	bool would_change = __vlan_flags_would_change(vlan, flags);
 	bool becomes_brentry = false;
+	bool would_change = false;
 	int err;
 
 	if (!br_vlan_is_brentry(vlan)) {
@@ -725,6 +725,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 			return -EINVAL;
 
 		becomes_brentry = true;
+	} else {
+		would_change = __vlan_flags_would_change(vlan, flags);
 	}
 
 	/* Master VLANs that aren't brentries weren't notified before,
-- 
2.43.0


