Return-Path: <netdev+bounces-112275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52333937E8C
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 02:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21D5281F38
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9461C14;
	Sat, 20 Jul 2024 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixTh4/rA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DD38B
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721436102; cv=none; b=hvhyEuekfFgl0xNvnPvfUxXbzWx7c4PJBf/2AVUKjSwCNTgu38GzTp6dwq929/wWVgwOTVGBPZ5dlLjW3zi0W3h0TdBBWUvJ/WnMv2Z/ykxywC+ndsse9Axh+8pSnttIfAANmKD6z1D74uLjknn+2b67++hTTuBFwHQ35FkzMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721436102; c=relaxed/simple;
	bh=RD1oDEed7ti9Y0a0A4Hx2lgk5j/1qe/7kbL7nED1lmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMS71EPdEjhcXKP/mwTQBWaBgSX/xq9FIW5qLpLKm7FhtjF2MRSSmZjWWiu9/CjSmueDisqBdhIkXUdlmNA1O7wAfmEoQRK/znj/JxBgDTtWum6GNeBHEpuPEIg24hIHAY4IpNnaZ8mnIBnxVebUGQR89NQ32OaOuy8LaIHC308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixTh4/rA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53562C32782;
	Sat, 20 Jul 2024 00:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721436101;
	bh=RD1oDEed7ti9Y0a0A4Hx2lgk5j/1qe/7kbL7nED1lmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ixTh4/rAqsCGPUyYYP03bYhljqR1gIzLVdM1rP7xTMhyhr1q8W94Fof7S6O/twNsO
	 E3srE1kcMiaDh9UGXsmwDh+b1yOV4R/D3bVMYoc4QrlinAgnqFZnzb+Xz7eiYKU6pr
	 HxCcqaaUtI8yZ7jM592ZQpWWqnU/Wy6nBQ32sdjsPddxZI2nlmQbH2U2J1272pUc6E
	 2Yih1Dru9K+RWPR6NTsWRqTv4esnAvFp8/DBR9NGKj1DDFt79zB9UxgCdeATs8IF5V
	 yXI0QH3ln0/RuN80UfHjjtUrLjwIzmuLEa9eneF5wcC17e4Q7WZIqlrTJIQ97QnGQK
	 lv3bVaGtLR/JA==
Date: Fri, 19 Jul 2024 17:41:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ken Milmore
 <ken.milmore@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Realtek linux nic maintainers
 <nic_swsd@realtek.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: r8169: Crash with TX segmentation offload on RTL8125
Message-ID: <20240719174140.47a868e6@kernel.org>
In-Reply-To: <Zpl004GjvJw3A3Af@gmail.com>
References: <b18ea747-252a-44ad-b746-033be1784114@gmail.com>
	<75df2de0-9e32-475d-886c-0e65d7cfba1e@gmail.com>
	<20240522065550.32d37359@kernel.org>
	<Zpl004GjvJw3A3Af@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2024 13:02:27 -0700 Breno Leitao wrote:
> > > Yeah, that's an excellent catch and one that is bitten us before, too:
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D20d1f2d1b024f6be199a3bedf1578a1d21592bc5
> > >=20
> > > unclear what we would do in skb_shinfo() to help driver writers, rath=
er=20
> > > than rely upon code inspection to find such bugs. =20
> >=20
> > I wonder if we should add a "error injection" hook under DEBUG_NET
> > to force re-allocation of skbs in any helper which may cause it? =20
>=20
> Would you mind detailing a bit more how would see see it implemented?
>=20
> Are you talking about something as the Fault-injection framework
> (CONFIG_FAULT_INJECTION) ?

Yes, I started typing the below but got distracted & uncertain about
the exact hooks and test coverage:

=46rom ca7e88fb85f2e905b99c4c35029ea7ac8d35671c Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 29 May 2024 13:21:19 -0700
Subject: net: add fault injection for forcing skb reallocation

Some helpers (pskb_may_pull()

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/skbuff.h | 11 +++++++++++
 net/core/skbuff.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9c29bdd5596d..dcc488875374 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2665,6 +2665,14 @@ static inline void skb_assert_len(struct sk_buff *sk=
b)
 #endif /* CONFIG_DEBUG_NET */
 }
=20
+#if defined(CONFIG_DEBUG_NET) && defined(CONFIG_FAULT_INJECTION_DEBUG_FS)
+void skb_might_realloc(struct sk_buff *skb);
+#else
+static inline void skb_might_realloc(struct sk_buff *skb)
+{
+}
+#endif
+
 /*
  *	Add data to an sk_buff
  */
@@ -2765,6 +2773,7 @@ static inline enum skb_drop_reason
 pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 {
 	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_might_realloc(skb);
=20
 	if (likely(len <=3D skb_headlen(skb)))
 		return SKB_NOT_DROPPED_YET;
@@ -3194,6 +3203,7 @@ static inline int __pskb_trim(struct sk_buff *skb, un=
signed int len)
=20
 static inline int pskb_trim(struct sk_buff *skb, unsigned int len)
 {
+	skb_might_realloc(skb);
 	return (len < skb->len) ? __pskb_trim(skb, len) : 0;
 }
=20
@@ -3900,6 +3910,7 @@ int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigne=
d int len);
=20
 static inline int pskb_trim_rcsum(struct sk_buff *skb, unsigned int len)
 {
+	skb_might_realloc(skb);
 	if (likely(len >=3D skb->len))
 		return 0;
 	return pskb_trim_rcsum_slow(skb, len);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..a9f4275bb783 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -58,6 +58,7 @@
 #include <linux/init.h>
 #include <linux/scatterlist.h>
 #include <linux/errqueue.h>
+#include <linux/fault-inject.h>
 #include <linux/prefetch.h>
 #include <linux/bitfield.h>
 #include <linux/if_vlan.h>
@@ -2222,6 +2223,32 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *s=
kb, int headroom,
 }
 EXPORT_SYMBOL(__pskb_copy_fclone);
=20
+#if defined(CONFIG_DEBUG_NET) && defined(CONFIG_FAULT_INJECTION_DEBUG_FS)
+static DECLARE_FAULT_ATTR(skb_force_realloc);
+
+void skb_might_realloc(struct sk_buff *skb)
+{
+	if (should_fail(&skb_force_realloc, 1))
+		pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
+}
+EXPORT_SYMBOL(skb_might_realloc);
+
+static int __init skb_force_realloc_setup(char *str)
+{
+	return setup_fault_attr(&skb_force_realloc, str);
+}
+__setup("skb_force_realloc=3D", skb_force_realloc_setup);
+
+static int __init skb_force_realloc_debugfs(void)
+{
+	fault_create_debugfs_attr("skb_force_realloc", NULL,
+				  &skb_force_realloc);
+	return 0;
+}
+
+late_initcall(skb_force_realloc_debugfs);
+#endif
+
 /**
  *	pskb_expand_head - reallocate header of &sk_buff
  *	@skb: buffer to reallocate
--=20
2.45.2


