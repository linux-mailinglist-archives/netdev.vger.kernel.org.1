Return-Path: <netdev+bounces-277438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LOzDoAN2Wl+lggAu9opvQ
	(envelope-from <netdev+bounces-277438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:47:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 891BC3D8C90
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CD1D3008A59
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3B3D1CDB;
	Fri, 10 Apr 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNSq9jQf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BE86329;
	Fri, 10 Apr 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775832238; cv=none; b=s/T973y8ylpCSzuKUTTEPt0ueK/2tqZuN9qzIKL5asWX6zbm0N4lA7HhBKiGPAPGakVeYbFiJ+WLt7PrbiBbOy6YlNiDQQAnzozjk/O7eFL3Tr1YtirPPhWQBOe/WZoA65UKqpApgdDM9uHNw8ifl8+uUVnnVXQJBuC0UNbkTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775832238; c=relaxed/simple;
	bh=Voqoe/SBjfC00sZXFStUwTcAzHx4Q+do243mfexnCt4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ghs4QBYFdIEjAf87BTdoYBAzWokyDcY8nFWcrhqJxfxp81fN7RPvRDNecOJOSYB/Siw/9NCACPfEIRzFZe377LisTAUwJ/Od61unVa0QlDpu1v+jgCTeMTxERknvExpmGAcpXaIv3mfeX8Y88ExUqVoEKBM+V1htBz0VidKfDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNSq9jQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901D0C2BC87;
	Fri, 10 Apr 2026 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775832238;
	bh=Voqoe/SBjfC00sZXFStUwTcAzHx4Q+do243mfexnCt4=;
	h=Date:From:To:Cc:Subject:From;
	b=lNSq9jQfVP4xrdNEqT6Hayhxn9fHQEXK2NOHhYr82UaBYsUbyygPxuOL8bKNnJ7+A
	 jpccOgLCgJFVlH53fGgsRpleJmTA2kJ2BenxUfUVSPcK7iZK6pfzV2DcUPxsU9fkOL
	 6yCfWTKr/XkQ46K2G8Spq7TGmeroVNmHW7jjkVrhV7Otwgp8pop37nWLxFcFdJGemn
	 Adcwgmy8WA2YsmdyTEi4T4+t8MiXy1V0XmdLcQMuUked9HIX5p/aWmR8U/JN32HBVo
	 fN+i7fxEVaVWrj1Mux+Og1J2MxpqvokR56URQ4ztFD3mM1JIuG/ZY70ltVSJQsVMEH
	 3H9mmaBVXcDpw==
Date: Fri, 10 Apr 2026 16:43:54 +0200
From: Helge Deller <deller@kernel.org>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>
Cc: linux-parisc@vger.kernel.org
Subject: [PATCH] net: Optimize flush calculation in inet_gro_receive()
Message-ID: <adkMqgP6QeBPgqP9@p100>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277438-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 891BC3D8C90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For the calculation of the flush variable, use the get_unaligned_xxx() helpers
to access only relevant bits of the IP header.

Note: Since I don't know the network details, I'm not sure if "& ~IP_DF"
(& ~0x4000) is correct, or if "& IP_OFFSET" (& 0x1FFF) should be used instead
(which I believe would be more correct). Instead of possibly breaking things I
left it as is, but maybe some expert can check?

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c7731e300a44..58cad2687c2c 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1479,7 +1479,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	struct sk_buff *p;
 	unsigned int hlen;
 	unsigned int off;
-	int flush = 1;
+	u16 flush = 1;
 	int proto;
 
 	off = skb_gro_offset(skb);
@@ -1504,7 +1504,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 		goto out;
 
 	NAPI_GRO_CB(skb)->proto = proto;
-	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
+	flush = (get_unaligned_be16(&iph->tot_len) ^ skb_gro_len(skb)) |
+	        (get_unaligned_be16(&iph->frag_off) & ~IP_DF);
 
 	list_for_each_entry(p, head, list) {
 		struct iphdr *iph2;

