Return-Path: <netdev+bounces-161300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA510A208B2
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8993A3D3F
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F219DFA2;
	Tue, 28 Jan 2025 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="ehGEcu4d"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25434199EB2;
	Tue, 28 Jan 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060750; cv=none; b=huOJumBPVw+M9tMCJ+tFcSWXBOnkFZkgj1iECkuPeBjYV6ud06J6oO5hvr5Cnkr6Ve1ce+htTO9HEISBsJbcexO6113gk1yV/QiTCEOTz7VmLGJDtwkv79x6m537CGMqPkm3sHM18SU6yUji8M2gkLUmxeVUqEa6SrHhk3ScOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060750; c=relaxed/simple;
	bh=41wcHiYxeFxToMryqAfdaZMgTBLFcU/9qhaAj3PSsTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMeZG3UUt3JiiBOXupMvp/37/GOhdv1nO0WQfQNaatrIqlqJxsoAPZpA+sWaY0j+1wAKLiasFTO2USHN6bs3XnQ0DlI39qAfjvyOA0Krjv3schTYuQyV8WsvBb6/SYqsFRAi4BakN+LbPKeqOW09mxrw+3q1NdxFGzvL0xMyZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=ehGEcu4d; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD6D7442A5;
	Tue, 28 Jan 2025 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1738060746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ku8Urfs6x+yp3O43UoWTObdPouPEDHLl4CwrrMtzQ40=;
	b=ehGEcu4dH+SRKaoo0maWXTdGzaOFNdcx2F+SrPAsnnX3ItiFjX1gNV0p+rs2i4vB/Hnr/o
	uCBla2/I5vOtVuSsX1mO8gdZS3GY9TpFfc93xMrim3J6ueJSw9uegQlF+tvuYgfTVvOcui
	9OqwwqOKziJBf/6hzjU63zbCofbenuf+mexljFXYwIbi0WYTsbuafRRqXrv1A56yvhubd2
	NfvEKDPWMQAvL5nxIhbaHj7xMDMOL/MzA4A7a1XzKoR7VRtgN8hwZm7ofW/nnXtFBCFFwx
	DqZ1uMTZC9uOf6oI6qO1WMaeu70s0ooKBZ1zWFLRldaIPVXTJU0BjaxidwXKZA==
From: nicolas.bouchinet@clip-os.org
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2 1/1] net: sysctl: Bound check gc_thresh sysctls
Date: Tue, 28 Jan 2025 11:38:17 +0100
Message-ID: <20250128103821.29745-1-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgnecuggftrfgrthhtvghrnhepieeigeehteehfeetuddtieefuefgfeevheevvdeiudetvdelleejveekkedvleeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdeifedrvdegiedrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrieefrddvgeeirddukeejpdhhvghloheprghrtghhlhhinhhugidrrddpmhgrihhlfhhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdgsohhutghhihhnvghtsehsshhirdhgohhuvhdrfhhrpdhrtghpthhtohepjhdrghhrrghnrgguohhssehsrghmshhunhhgrdgtohhmpdhrtghpthhto
 hepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

ipv4, ipv6 and xfrm6 gc_thresh sysctls were authorized to be written any
negative values, which would be stored in an unsigned int backing data
(the gc_thresh variable in the dst_ops struct) since the proc_handler
was proc_dointvec.

It seems to be used to disables garbage collection of
`net/ipv4/route/gc_thresh` since commit: 4ff3885262d0 ("ipv4: Delete
routing cache."). gc_thresh variable being set to `~0`.

To clarify the sysctl interface, the proc_handler has thus been updated
to proc_dointvec_minmax and writings have between limited between
SYSCTL_NEG_ONE and SYSCTL_INT_MAX.

With this patch applied, sysctl writes outside the defined in the bound
will thus lead to a write error :

```
echo "-2" > /proc/sys/net/ipv4/route/gc_thresh
bash: echo: write error: Invalid argument
```

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

---

Changes since v1:
https://lore.kernel.org/all/20250127142014.37834-1-nicolas.bouchinet@clip-os.org/

* Detatched the patch from the patchset
* Updated the boundcheck between SYSCTL_NEG_ONE and SYSCTL_INT_MAX.
* Reworded the commit message to make it more clear.

---
 net/ipv4/route.c        | 4 +++-
 net/ipv6/route.c        | 4 +++-
 net/ipv6/xfrm6_policy.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 0fbec35096186..96641ae15049a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3453,7 +3453,9 @@ static struct ctl_table ipv4_route_table[] = {
 		.data		= &ipv4_dst_ops.gc_thresh,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_NEG_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "max_size",
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 67ff16c047180..3fc7f336dfa04 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6379,7 +6379,9 @@ static struct ctl_table ipv6_route_table_template[] = {
 		.data		=	&ip6_dst_ops_template.gc_thresh,
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
+		.proc_handler	=	proc_dointvec_minmax,
+		.extra1		=	SYSCTL_NEG_ONE,
+		.extra2		=	SYSCTL_INT_MAX,
 	},
 	{
 		.procname	=	"flush",
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 1f19b6f14484c..1e212d5341839 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -189,7 +189,9 @@ static struct ctl_table xfrm6_policy_table[] = {
 		.data		= &init_net.xfrm.xfrm6_dst_ops.gc_thresh,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1		= SYSCTL_NEG_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 };
 
-- 
2.48.1


