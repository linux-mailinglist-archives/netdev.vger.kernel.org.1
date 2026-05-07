Return-Path: <netdev+bounces-285195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NJlN6tQ/GlOOAAAu9opvQ
	(envelope-from <netdev+bounces-285195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:43:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D8B4E5020
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2310C3007492
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7C388E71;
	Thu,  7 May 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMjipYNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82962371D1E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143400; cv=none; b=RUj83ijQF2fTb9TsuYxZn1Cfs4WAtJEjNPieOMebJE0ig9hdKqE+sIy+0+B+EIg9CS9TbJ8ejcunqJBG0vUJLMlVTn/HUkVqO67nMBhMmH0DRgk0NodHqqkk7utzBCOlj9OJT4r4qkXW22Ps+tlsC6bbqPeq4w3C8+TX97GOzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143400; c=relaxed/simple;
	bh=SHw5P0LAa/XsxtWPaiSpgyWkEZk4GrFd5GvP11BsyU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gz0skdmHVIv94bGkpfOyWxrDP1Akhk+3eHv7LCqUUnWKrundZZK3ReK4Xx1xX8uSoH2LV1a8U8BRwnS30xrKjn2A9q3WW+8TgYD1V+WECM/T499m7GkZKmgcH2ay7731ZSztxOPsVNCNWnvpTqq0eKQjohcIYQETSY4NUxpAgl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMjipYNi; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8acb85a973cso6539686d6.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 01:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778143392; x=1778748192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRu1fN5aPR4iVOTELoZmdLrAmJwJZXGrgcEXhq13bEY=;
        b=eMjipYNiDhemQvhFfIzKOawCZBLy5qjWVFZMXcWrZLG9t2b/XSPhe7R1Ij4qZSaFqZ
         hiOph8MQ70ivKrqJTkUtMqn65UNbqtogm59P7EW21bfcQjehz5HbKVHBF+FCQcBA/c33
         54tk2pCzXIh3dUn1DZGcl1TtpPMy67fZvYJsD0nHye9eT/ia+PLgAJ3hAdH3SbFIzN1Z
         /1hPLF3tjHr79HMfK/NAq+eMy6Z6p0VO3EjuGbhJpWF4LPQx4sDccp/d59bqE9TcOht9
         ISNRFzAxZhO0cCiQNz/xl6LcPVswR2Gw/ldRYRun1eOiB9Lmeb1DKGayaSR4kkxlG1un
         /23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778143392; x=1778748192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRu1fN5aPR4iVOTELoZmdLrAmJwJZXGrgcEXhq13bEY=;
        b=ju6K/ZAjdS1s3lh+NAJgZK/nEg0gfnAUiPNQ9Fyi+ghxxLoCwLVKgp/ml6j50Mk3Kj
         RjrerfH7ScYBSKNXzH2V7pjabWg1Jt76cTWWoaqc3aJ1+15DSFz//Y5MBXxJOAwbCF+U
         foCC70GTP3vc8BB5Cskd1tQ8oYEPLYAdRR//oFbLLUfVF9gDl5tTXm37pOJUVCDUmjHa
         wEP/VM7Z5f/PAl/8MMzW0gmcoXp7ut4smuDcM/vDYl/OGuriZDFMsD9TDnYSpoM6qhks
         //b49DP1emc3o+a1Tw3nGpu+OLBztN9lojVP0C9Xof8U3Fxg1ZXAsIYDvpRC32NQyrde
         AK/w==
X-Forwarded-Encrypted: i=1; AFNElJ8GQSxOlERwFFE1pMptOPNQPbOkKvmZdC3RIJ2K4RUSb6DPe14zN2X4cVsGcYQxaCM1F5DG2/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsix9A1tqV8TgO1eSSZpgTG0e1Ak0QdpjcgmaVCAgiZO/T1qMY
	O6Y4NvV65wDFeHh3tcc3QW9p8mz51tgbGG7EhSqyTA7OmBq6iZTxBlwGb7HQL/Ge1Pi2RhgsyAs
	ezI1JZif5WTfZiA==
X-Received: from qvsm5.prod.google.com ([2002:a0c:ee45:0:b0:89c:e5f0:8f32])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5d4e:0:b0:8b3:f911:c1df with SMTP id 6a1803df08f44-8bd8ec82cd8mr42417856d6.21.1778143391772;
 Thu, 07 May 2026 01:43:11 -0700 (PDT)
Date: Thu,  7 May 2026 08:43:05 +0000
In-Reply-To: <20260507084305.2506115-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507084305.2506115-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507084305.2506115-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C8D8B4E5020
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285195-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Replace a bare kfree_skb() with a modern sk_skb_reason_drop() call,
and provide IP_OUTNOROUTES drop reason.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/inet6_connection_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e1168992c44e1400dacab87e79d04c64a41..4665d84a7380d90b7d180a429017f577fcb6936a 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -102,7 +102,8 @@ int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl_unused
 		if (IS_ERR(dst)) {
 			WRITE_ONCE(sk->sk_err_soft, -PTR_ERR(dst));
 			sk->sk_route_caps = 0;
-			kfree_skb(skb);
+			sk_skb_reason_drop(sk, skb,
+					   SKB_DROP_REASON_IP_OUTNOROUTES);
 			return PTR_ERR(dst);
 		}
 		/* Restore final destination back after routing done */
-- 
2.54.0.563.g4f69b47b94-goog


