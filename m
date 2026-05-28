Return-Path: <netdev+bounces-292538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE9tAc2tF2qiNAgAu9opvQ
	(envelope-from <netdev+bounces-292538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:51:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F605EBFD1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1758C3003314
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19C1EB19B;
	Thu, 28 May 2026 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA8Kxuf5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A251255F28
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936370; cv=none; b=qgvVkF1ZN91Wj5oP7jMGFKANXD+EAbNz/O94562YH0DTkeL/WryxLCQGFzlubYx8pQp51NkprjrvPwbHKGlbisHCJswZIBySL0M3E6Jw89qkJQHz1vMnPPB+SzX/M2D8yoP0R3k3QbHV3bYEJ4hpvcMYRTnDk7+r8HTYlok7MJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936370; c=relaxed/simple;
	bh=8/SkSltABa8TVgtx6UKCLoPQ5oXKPl6z7sgIQNvtQTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mcWRQWBmQ4saypJj7XhNq2tu/Nj6/7wVSSI5dnA/8+1nqROCYZwaE45z8MhiLtqS+Jt8dUpxRfJTU7OGCu4wx/FlUiXiRAyYQMgeo1Hpi8uv/oyY1Y5QTLRXNcMi0eZlR/CyOHQs4O0vQmbmG9womOhTeUQNPnbPWDEQR1ONHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA8Kxuf5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso105020055e9.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936367; x=1780541167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/SkSltABa8TVgtx6UKCLoPQ5oXKPl6z7sgIQNvtQTA=;
        b=UA8Kxuf57izqQPaAxbv7UON5a571i6K3o8NrxzP6iiw/9c3FSTJ7ZCsRtZzHvZXwjj
         pMlZMlC9vEK25ccg7YlMrmIEix3NkR1GEZ53swAFgruLtGXqucXhdBpU1zIADx5+qcXz
         P7oSz4L1u3EQiNk2NnpUfvQj+GHV/3NYLsC67pRZJzzITYzVOPMAJWpPdAaJe/X+OaEQ
         C7h49H+PS+5FZMqHTmdrykjIj1bTK4FWl0m+X7zfUuAitxYR1silJ2QzZZBafTjjVEiI
         d1V1Z3FCh5ypAEXzUM3Z8fadIPL3FA/4TklbGwQZRDBCtEl/25h6pxtX2zQZzmxqcak7
         XyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936367; x=1780541167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/SkSltABa8TVgtx6UKCLoPQ5oXKPl6z7sgIQNvtQTA=;
        b=TyYmrMDBgnrOWuslTZE0QYCNf3+hIWH7hWghsH0sv7yGo0Gg+66U+0VE4YeCzghi8O
         sxBQ7Py5pk0qJZaY2Agm/lBN54yzPuusCwZ86JzpyDnzjlNGeZGAlIqsUKfMVYocsfex
         Oi1zftbtKKNHJX9VRV/LUUhFyjlqGxytSWYCb4gOpk5wF8ZUX3r5JjSwAF6rcJNpy7r0
         3rQ2uEPnU+WPTGTvfJm5ihY/ZuMHcVzhjFonvV/YLhzqvHEOBESZY+vbDiivOa1NTsVW
         QA9hFuicn0x8EokEJuUZno7g+hgDAJOBrayiMJcxbv4b7UMG52JEJqd2sRMZqx8gE+s1
         B3aw==
X-Forwarded-Encrypted: i=1; AFNElJ/+f0SwDarPgztpmpa8eXVpe/pL1W61jtbrQ3eSCSBwvPAkMBSYv8nerLu5cHkflDILAtTkRTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5to4/oPQUNNvcF4ZeawHLtvG5rP0Z1fhE1cithGsX+3Sxh2U
	Kqw8bZZ1ZHduk0/aCZrwUMvPl2uPlSCEZZ4y1Lg3c+HJpRCrDUAcPGON
X-Gm-Gg: Acq92OEypKujpxjdhHJZwiQECF164b4kzXsiNLeY537x70s6h8s31hBR/RnSQ/Dp+f4
	9YbbNdYG4ATwdv9Ilm/E0Tnd+ga2sQM0N2npkyKQhOFdddZnxAou+Q63agi/rIy76FyTCMEe9Pn
	QVu/eoCBMyRso9D36S8hgt/RMI7RrQFAJYCUp4QrBxn1GlMyD6nw9NDdd7BOUcZf9ffHylqxb84
	1rVfRxoPZwq642Vd1gMvVx9L4KXMpcZDMkzEaIv4k52z1kkhZtLyzIeTf257nc6DB9a6gXBb3vT
	5GeQ7Y1im9TJXKzhqf3MX2Lb4NCLQCERArUIvqx1qDvl8W+i9ZEPWGmi71hB9Dthfryys95hCRD
	M0f/8TnxlTJemtetihy8JNBhYVRNBY3FfPP66yHSN4EgRqWs3wzcPtNsfb6OGvkGm82MRLJZt9+
	GuwJd9US5tGKex47P4UMr7UmuMR7jTSFwVyH4mDU1edxcnj0j9eIwOOQyQUKWdfKEN27P80d/ZF
	/oJXjxBtWN7hnEVPT0fQWssbYib
X-Received: by 2002:a05:600c:35c8:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-49044ebc2d5mr462413595e9.30.1779936367138;
        Wed, 27 May 2026 19:46:07 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a902bfsm13900335e9.12.2026.05.27.19.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:46:06 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: sd@queasysnail.net
Cc: Petr Wozniak <petr.wozniak@gmail.com>,
	netdev@vger.kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Subject: Re: [PATCH net-next] xfrm: fix xfrm_dev_offload_ok() returning true for software SAs
Date: Thu, 28 May 2026 04:46:04 +0200
Message-ID: <20260528024604.1399-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292538-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,secunet.com,gondor.apana.org.au,davemloft.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 60F605EBFD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-28, Sabrina Dubroca wrote:
> But the packet is delivered correctly also in the bridge case, right?
> Once we enter async crypto, the original datapath becomes irrelevant.

Yes — async completion via xfrm_output_resume() -> dst_output() delivers it
correctly regardless of the bridge TX path. The -ENOMEM is just a misleading
return code to the caller, not an actual drop.

Your ERR_PTR(-EINPROGRESS) approach makes sense. I'll work on a v2 based on
that — propagate through validate_xmit_xfrm() and fix up the callers.

Thanks for the pointer to f53c723902d1, that explains the context well.

Petr

