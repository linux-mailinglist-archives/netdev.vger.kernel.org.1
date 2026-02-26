Return-Path: <netdev+bounces-261570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLtGIyCroGlGlgQAu9opvQ
	(envelope-from <netdev+bounces-261570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:20:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D72441AF020
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87C23302F246
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A342885D;
	Thu, 26 Feb 2026 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="px8svzRz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fOlkMZot"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA51389445
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137004; cv=none; b=KPZgbCOw8RNa0v0a3ic0iR0ApDVmAVJBONlA1evusaqQ4TDWkdgFf6XhqNv2VmAlMkL8bP7luR+h7GOcAitQgx3/9Pvbeuhrm+NlTfWmVXcu7rSFbp8jC3Hfl750d0mZ4x4zwJ1YXE2AbGUeTRptvi7QC5Q/O8QbzATGPyWPqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137004; c=relaxed/simple;
	bh=e6nINqDrsiAFsSrMClwWV1rRGqRwo9oJsqKXH5nkU0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouZwtT218X55VZ+5G5yBA/qdkaoTJ2TiXVCVpU3HGn7ftZIVZ1MBmoPJYJoWMu5atO/kA+uz3PAjnHfQlzvL6jakGY6w5u2/XQsxso67fwBMi4b2+kG74hXg7w3vm8QgvKc2P8N4Gwthey+s0Fu2wxI+Y2lHZWXpTeXp/ZnW1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=px8svzRz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fOlkMZot; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7806A1D000B0;
	Thu, 26 Feb 2026 15:16:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 26 Feb 2026 15:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772137002; x=
	1772223402; bh=87e6hKaiNySFPc78RM7Oj5ETuzZDjoaLPGpu8Tec0is=; b=p
	x8svzRzziNeqKPC7Bc9CZrKFhKb9R1p9g4/jtpN3dKcT1JO0RC4BeNDIcFJLhtrq
	Vp47C+rSB6nCtIBC0qN4G2mpf/JULnqfUrSVtxcddJZKiolV1TnLSCAimRXcPOHi
	WKljIan37oOdcVq2xketCsGS9FXLTjD2w0ZMxu5UhL3RNqgLeVE5i90th030UtuD
	5FWg2YhekJYMVLY1jRwZLkAgFmuFsOPLy0kc+vfHpbM+R1GDnsfvQaY+seXchhdB
	OBMEKDzyDpegQ5gbYFbuqxbWVQu3ETZMTZbiJ+hifMTgaiqu899Mgwd47fclFnaW
	ToJZefKcNvvffidzxn8NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772137002; x=1772223402; bh=8
	7e6hKaiNySFPc78RM7Oj5ETuzZDjoaLPGpu8Tec0is=; b=fOlkMZotbmp4FRr51
	xwq0tjcJxq0PlJnz1HwvSBW1jy5MRuXFlInexjv6OaCoQKtZxvWPYRGfWvy+Gx8Q
	gNN+kXWBF/uPfRN/VcKZ5mpX/r+Q0lyMLzqqHzUsfgkZ4tdo0RBGZ3cpBAbcZhaG
	xoMgBcp026ryd291KU17GSPfB8LHtQF8lGD4mWwYxNbkdakstNT/XQMqfa3FFOtS
	i1fQP8I3/gqPbccpY0ZNbmqhsUGvx/Eu/kY3xQDmGGPmqiqn5k/+RHCJ0RtXguO+
	vrfhcRM2KcV/OK44nuGmB7Tj6PVMvkoTazWXsqcAlQzipvANjjd7wYATxyGzfqmv
	l141g==
X-ME-Sender: <xms:KqqgaTReD_iTrkZc7gLolW37r-CJfs1UE2tTgfHsBBsxOsZJtV5jLA>
    <xme:KqqgaTQSpDzcdnUd62Mciv78_civdLfl6Xw2kDeDXknZdb5bqe8DhqvS1t1LoW9U_
    lwdiDkRARVoMY6JNvr0nJ6Ptt3ZAn8cft-a3eHtrfo-Z1SRejU0Erfe>
X-ME-Received: <xmr:KqqgafqTIpAmd5RtEiWi4kIpMUuEFx_cXrs9r4W-4Nh5O44sClZ6PAM4sDVkpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:KqqgaTDpiXfG7kKGKxWNjUptkzOqlzwb1tdYDJej1yp4uzDi-Qw80g>
    <xmx:KqqgaUuneDXrguqGlGwRtjZZKTP9_iK4u_E5tVnhZW_8U00Nu8GOlQ>
    <xmx:KqqgaSYbCaqPOkvPuZD4SwZQcVhhSLdnkSCNLxK0DtGjI_waDdUkBg>
    <xmx:KqqgaQG5-W1KcHLNodeBUimR1l5iFpE6rRSQ0H5LjUmNDSkEBtzQ_w>
    <xmx:KqqgaX_ZQlJXFLv0vylbiOXEOYo_80tmnLhQ1reFoSmd8FSOTz9Oh0Z2>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:16:41 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next v2 02/12] udp: gso: Simplify handling length in GSO_PARTIAL
Date: Thu, 26 Feb 2026 22:15:50 +0200
Message-ID: <20260226201600.222044-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226201600.222044-1-alice.kernel@fastmail.im>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com,nvidia.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-261570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,isovalent.com:email]
X-Rspamd-Queue-Id: D72441AF020
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
and fix the checksum (apparently ignored by hardware anyway).

The mentioned commit started using msslen for uh->len, but still uses
newlen to adjust uh->check. If the formula for check is fixed, newlen is
assigned but never used before the loop, and newlen is overwritten after
the loop. This makes msslen not really necessary, as we can reuse
newlen, if we don't adjust mss before. The adjustment of mss can be
simply dropped, because mss is not used anywhere else below.

This brings us back to one variable, drops an unneeded arithmetic for
mss, and fixes the UDP checksum.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Cc: Gal Pressman <gal@nvidia.com>
---
 net/ipv4/udp_offload.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6b1654c1ad4a..e831234326c4 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -483,11 +483,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	struct sock *sk = gso_skb->sk;
 	unsigned int sum_truesize = 0;
 	struct sk_buff *segs, *seg;
-	__be16 newlen, msslen;
 	struct udphdr *uh;
 	unsigned int mss;
 	bool copy_dtor;
 	__sum16 check;
+	__be16 newlen;
 	int ret = 0;
 
 	mss = skb_shinfo(gso_skb)->gso_size;
@@ -556,15 +556,6 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		return segs;
 	}
 
-	msslen = htons(sizeof(*uh) + mss);
-
-	/* GSO partial and frag_list segmentation only requires splitting
-	 * the frame into an MSS multiple and possibly a remainder, both
-	 * cases return a GSO skb. So update the mss now.
-	 */
-	if (skb_is_gso(segs))
-		mss *= skb_shinfo(segs)->gso_segs;
-
 	seg = segs;
 	uh = udp_hdr(seg);
 
@@ -587,7 +578,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		if (!seg->next)
 			break;
 
-		uh->len = msslen;
+		uh->len = newlen;
 		uh->check = check;
 
 		if (seg->ip_summed == CHECKSUM_PARTIAL)
-- 
2.52.0


