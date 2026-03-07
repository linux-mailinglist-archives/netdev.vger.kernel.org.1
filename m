Return-Path: <netdev+bounces-265014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCzgMdmPq2lFeQEAu9opvQ
	(envelope-from <netdev+bounces-265014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:39:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B2F229A39
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D03D3037159
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 02:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9622882B4;
	Sat,  7 Mar 2026 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGUeXUUs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37039165F1A;
	Sat,  7 Mar 2026 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851157; cv=none; b=OpBaDkHVG4xtJ5yXhfOfaDvs0/cSGMWMwPNQ9B8MyXQ6vbdffXcGMcNACvX+AAnBoQn1A8aNpdQuCyC3Zjw/TIGRrtT9sybKLe6COTqyeRDa65zNiLfZbJpfwxsR4ExiFz6Wpz/iGanOtvcYIQwQa1WtbTagvfOK2A0KLe4Wnd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851157; c=relaxed/simple;
	bh=0H36sTVyK5dWU2DndX7adMV2ULPpGWcGy2zaigqVilI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McufsXU6qAuBSEn8TbGF1Nuvprn1jBy2s8b66MmBaPRgyqYC0Q3WHFleKUZYrq0hW8n1xb58XhT/ynYO25VNdyGOoLHQJfsLpMXqIVa5YURIcKfJd/yPvSsG4tsQ9zjfEtXNSNLDXO0bdARqPR9XG+fDBPWkq3yFvlwftU+xCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGUeXUUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B257BC4CEF7;
	Sat,  7 Mar 2026 02:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772851156;
	bh=0H36sTVyK5dWU2DndX7adMV2ULPpGWcGy2zaigqVilI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rGUeXUUssxJTWOfmgY1YpOQ4x8FZPetg8EvQ0nL91p2ilGInrM88oUjRUWMCOYYTM
	 5sUrFhT79T+pgsTUBPG1Tul3VK7J9oiGtNXXwTb8LyIgxt0vU2TJqopqfpFFHkvTVN
	 iH2mkAbFuig/hXrB+tzu02GmC85Rc0YNC7b/h0G7qt4KoCRd3D3yAshPNAC7GPhG0k
	 O20IoL4s0Rd0HdVoQPFQWZ6Rkwm41SmwiszIy9uii/OOypkXL7sB1mA8MRapIErqgD
	 tQzpK593AmUBOdaCyqQE+x2TNU4H4KU6+ukDjQ2OVirrqzFclI9xsFqY67rMesC0gx
	 ufSjsvifeJasw==
Date: Fri, 6 Mar 2026 18:39:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, David Ahern
 <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Message-ID: <20260306183914.4b13a03d@kernel.org>
In-Reply-To: <b3477010-6fdd-4bec-8951-152b12bf56e6@suse.de>
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
	<20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
	<20260305182521.0ca7313c@kernel.org>
	<b3477010-6fdd-4bec-8951-152b12bf56e6@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 52B2F229A39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265014-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 10:58:44 +0100 Fernando Fernandez Mancera wrote:
> >> +	if (unlikely(!ipv6_stub->nd_tbl))
> >> +		goto out_drop;  
> > 
> > So neither Fernando nor you checked whether this code can be built
> > as a module? ipv6_mod_enabled() should work just fine
> 
> I checked it. If IPV6=m this is not fine.
> 
> ld: vmlinux.o: in function `bpf_out_neigh_v6':
> filter.c:(.text+0x3231d60): undefined reference to `ipv6_mod_enabled'

Guess I got it backwards :/ Should we add this to the series?

-->8--------
Subject: ipv6: move the disable_ipv6_mod knob to core code

Make sure disable_ipv6_mod itself is not part of the IPv6 module,
in case core code wants to refer to it. We will remove support
for IPv6=m soon, this change helps make fixes we commit before
that less messy.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ipv6.h | 7 ++++++-
 net/ipv4/af_inet.c   | 6 ++++++
 net/ipv6/af_inet6.c  | 8 --------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 443053a76dcf..e5b6853d517a 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -333,7 +333,12 @@ struct tcp6_timewait_sock {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
-bool ipv6_mod_enabled(void);
+extern int disable_ipv6_mod;
+
+static inline bool ipv6_mod_enabled(void)
+{
+        return disable_ipv6_mod == 0;
+}
 
 static inline struct ipv6_pinfo *inet6_sk(const struct sock *__sk)
 {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index babcd75a08e2..f1944e8fd9d3 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -124,6 +124,12 @@
 
 #include <trace/events/sock.h>
 
+/* Keep the definition of IPv6 disable here for now, to avoid annoying linker
+ * issues in case IPv6=m
+ */
+int disable_ipv6_mod;
+EXPORT_SYMBOL(disable_ipv6_mod);
+
 /* The inetsw table contains everything that inet_create needs to
  * build a new socket.
  */
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0b995a961359..03c175cbbdb6 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -86,8 +86,6 @@ struct ipv6_params ipv6_defaults = {
 	.autoconf = 1,
 };
 
-static int disable_ipv6_mod;
-
 module_param_named(disable, disable_ipv6_mod, int, 0444);
 MODULE_PARM_DESC(disable, "Disable IPv6 module such that it is non-functional");
 
@@ -97,12 +95,6 @@ MODULE_PARM_DESC(disable_ipv6, "Disable IPv6 on all interfaces");
 module_param_named(autoconf, ipv6_defaults.autoconf, int, 0444);
 MODULE_PARM_DESC(autoconf, "Enable IPv6 address autoconfiguration on all interfaces");
 
-bool ipv6_mod_enabled(void)
-{
-	return disable_ipv6_mod == 0;
-}
-EXPORT_SYMBOL_GPL(ipv6_mod_enabled);
-
 static struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
 {
 	const int offset = sk->sk_prot->ipv6_pinfo_offset;
-- 
2.53.0


