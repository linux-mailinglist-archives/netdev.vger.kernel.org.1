Return-Path: <netdev+bounces-288374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKJYJotbB2q70AIAu9opvQ
	(envelope-from <netdev+bounces-288374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:44:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9395557CB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 206A134892D3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DCB3F871C;
	Fri, 15 May 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJZycQTE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758B3F660B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863289; cv=none; b=MBENFkPEUjDkBe0J7DbswrYraS886U4HUrBStsF20oR75VtqlrX7muGZqJMNubCWkN2uC7+Ene0bn93PLGtjp5z0kDOmHLHltF4x2G/cToPUobBQ8dfLBIPYItPvLzyxMXlA+6Z3ryL4hZ8wnesQm7Tzn2gzDmwKULBjRCjXtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863289; c=relaxed/simple;
	bh=VQrt6Kb8j8BwVo0kBZX98Mz7U5mvGhyJexU+/XCJAyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToSDqyHVlYNCw/J4EREJe3sla3vXcd8PCtYdOaxV6Gi78BGPMa7GsIS/4/scUA8P58Wr3DapPCaGHrh7lPlMICtyPHxe06OracsRxyOnOGe8FaCIh1uDZ1LhWBLoEvdKNzZupj2e/ct5ScKDA3fudS1iEGOUT5DXP2acTYUAApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJZycQTE; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dbd7a1e989so921040a34.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863285; x=1779468085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUh3g6NF2/hDjdQJcgRgRluSwJT7rJP3ZfpYW2WdTWI=;
        b=HJZycQTEZKCwZPdT9amSYOIRjWf+pVC2bxgOk5u/xkOinCwjKURBXZaFYlhyyuub7H
         k9LhIAsyCQjXKzYrcesNAF72rOrlE46uGHmj/2E5Ax2IpkRwZGyc4zKNKE7VHlbUZjze
         Al5M8A+tYMgJ/bD7dzue/XZro4JWjhbD9/Nq5A+kl0QKS2P/2s8dbxnm5iSyMV2E9Nhv
         zMdUaxNUhGxEJSx7++ZsmlAxZBqcHGefBJ+7rRLD/pUIi+GJI0iXPvdzVuMx4RP9BP4j
         jONTvisBU9LXlvspi75dmlPdLQJSM0ocSERnxOzRtwa8OXt/Fn9WxgXxswRbO6Vkq9ud
         1kDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863285; x=1779468085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUh3g6NF2/hDjdQJcgRgRluSwJT7rJP3ZfpYW2WdTWI=;
        b=m9tn0pWuMlJ8M5GwNJOoLeH1ZSUB3DApEt2YeSdUMeUxMVDBmVDPpctz46L+8UAm1M
         V5L2+2r5ZJ8BtZSjUOfnxcuA17Qrq0YkPoOZqWZbfyUFOzKSexvpTSuWQbe0nmMT02LC
         C+eRr7HUhN6krDqL72Xz3ue7zNgASnqkH8tsSwu7ueMNXuUq9TBvamIZ2M5V64JZGtUl
         CvW2z1VP5jmckRX2nLxg5Qsr2a3I0HgXdEJycFEnEKzembbIPj+dgElq4EdVQIdyAWsc
         bXMKmRrq/l+P+cpvEIP1XJyCxFEBdfATuAxU7o52HNVGU7YokfK8eZR0Ea0Es159IbAu
         Cmaw==
X-Forwarded-Encrypted: i=1; AFNElJ9XzUGW/eXZtOj6xb9PSlO8NyX5ys8jdcQqmB+2YAn/XIw1BFHKkxX3eXqeTH52684uwzR9pmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxo+btCmC0SVKEIlFH+SOEIi0c+haBdKRXZqE5qdN2zJcyVLyF
	IsdA3LRQdO1ouWDstxJEAltVi06HtDnztEGwqDcdGthRm9oPDwi5v2bX
X-Gm-Gg: Acq92OHnyyOsY3NBl8hM+FS5FpkB5UumCvi2fLC6HE3JvULulTdLe9pgG4NUdUt8pTn
	XCiOHDG5saWcW/zlwvSCB5C78fs+hcI6PXz6vVCBGXQUdLE7sh8wZpelsEvIhjQ6AJBCQYR3lBf
	Y1iEELaXxz5QNB2Wqf85ypsivxjac8bMnm6LXHKD5WAmxWwoqdqXd3QPzHfoYwjp7Cskb+/cQ8l
	g5F4EYZYerIZh0kvxT5GfHisZ5CBWyVhsEknYeasWWUn92IZtWJZV2R/Rgt9lPJqbV9+DRYiHV1
	V1HfGLr9xDI1TmveDdtDQ+YlTGSNGP0H22UQOwBV37AmZGtCFhIoJryD4cWhWnelU9tBdn0TVRe
	sgQacftA0enmabTG9Qhya6F+SMJmvs2vai8EVKhvVyvYFMz3/nnqJxdB76voYO38OreBEDjpDYO
	1FK1bXdhqOhxhNLwTWDwt3N2m/6wJyGAV2M/LBYrn92N42ZTkXy+yOFEytKMwnm2dpP18NnqWBp
	jFr8iruhGcqw4VqREdkg9Gu
X-Received: by 2002:a05:6830:4104:b0:7db:e661:bb52 with SMTP id 46e09a7af769-7e4f2b15f9cmr1890167a34.4.1778863285020;
        Fri, 15 May 2026 09:41:25 -0700 (PDT)
Received: from localhost ([136.49.184.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4983asm1608373a34.26.2026.05.15.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:41:24 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: imv4bel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sultan@kerneltoast.com,
	sd@queasysnail.net,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through frag-transfer helpers
Date: Fri, 15 May 2026 11:41:21 -0500
Message-ID: <20260515164121.2608076-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aga1VyHpHaUhnGZa@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A9395557CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,kerneltoast.com,queasysnail.net,secunet.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-288374-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

skb_segment() propagates SKBFL_SHARED_FRAG from head_skb only.  When
segments pull frags from frag_list members, the flag is never
propagated from those members into the segment skb.

There are two miss sites:

1. Line ~4986: a new nskb propagates only from head_skb, but frag_skb
   may already point to a list_skb carried over from the previous
   segment's iteration (i, nfrags, frag_skb persist across the outer
   do/while).

2. When the inner loop exhausts head_skb frags and switches to a
   list_skb (line ~4999-5002), frag_skb is updated but its
   SKBFL_SHARED_FRAG is not propagated into nskb.

Your v4 GRO fix means head_skb will normally carry the flag, so
skb_segment() picks it up indirectly.  But skb_segment() itself should
propagate from frag_list members directly --- otherwise any non-GRO
frag_list producer re-exposes the gap.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4986,7 +4986,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
-		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
-					   SKBFL_SHARED_FRAG;
+		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
+					    skb_shinfo(frag_skb)->flags) &
+					   SKBFL_SHARED_FRAG;
 
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -5000,6 +5001,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				frag = skb_shinfo(list_skb)->frags;
 				frag_skb = list_skb;
 
+				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
+
 				if (!skb_headlen(list_skb)) {
 					BUG_ON(!nfrags);
 				} else {

Site 1 covers segments that start mid-list_skb (frag_skb carried from
the previous segment).  Site 2 covers segments that switch from
head_skb frags to list_skb frags mid-construction.

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")

