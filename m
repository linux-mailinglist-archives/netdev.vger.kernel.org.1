Return-Path: <netdev+bounces-277103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PSIAp3y12n6UwgAu9opvQ
	(envelope-from <netdev+bounces-277103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 20:40:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B9A3CEC4C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 20:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD3363013AAD
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E8037472D;
	Thu,  9 Apr 2026 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ05Ean1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A98311956
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760020; cv=none; b=FF5KehqFtbkYBZPvRf1ZSLE9rMP5qP+9y/X85AubMPooSph93NDHP20alzbDen9hcI31kAt9ZVkJ3paAx5sgXJSWdN28Zh5kW/4xxrOGNzpYEmmY3Wb/FAvxXb5r72aUcXzSNpJSOYMp6LpxfuMHATD3zc0O1jF5tXjVFAT0AEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760020; c=relaxed/simple;
	bh=thQzeiykELo/fwsdgBZVW/jDFIHzD6ZTl+5yJsqQizE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPwHEWBU8epDDy2Rc9ts2/0yZwkmlhXnUoRs9lRwAXFYWiFUuJP9xhqo4Pf5xxmMIQDV2R3wb5Up/0C7+jN2n0JyGIlKehkU/saOiIBA+/KzHAKZmLOuZ5bekRfbP3Rgm5I3er5BVQJaO5OnD96fJDLivZUndkohDpOf2BP6F4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ05Ean1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so13227445e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775760017; x=1776364817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pbe/Y5t71TqJtBY58+ahinO1W1322QS2uIOhop9klfQ=;
        b=HJ05Ean1kY0Zjm/WXUgOYgXd/f9sIjlOa28uTsSZjuXP136eD0KWwQUtrnRLZvn+0U
         959U8YqAkr4z43xYjb1i7SSpsYJ+Fqd0LFFACi0CKf2wYsEgBbPCXLMIHGfYe/WiK0a5
         TBzeGVQxhg695NvYdLuU6zaqXO59cF5alIgNajiIJYLX42Won6jRBkL+wjVQk+1iYIQ2
         IOtg011gmERCQWphmuuCXELp4gkIuJNKl6ZImFMEWekcXFliePOPZ2cBrXAj7saunJiZ
         Z1V+zvJA4LZPwk49kAOGKSt1i46TczdW1nWzbVjEGDAq122BTRZshCxOPhy9Z0R53USt
         +z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760017; x=1776364817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbe/Y5t71TqJtBY58+ahinO1W1322QS2uIOhop9klfQ=;
        b=ZcH+8pqJNN4lqBPb6BCLw9CI6UAGnTE1UjgavbD0g2zmo59rgh6gLONuQfPTxYS7Ec
         H3GvuQ6w9xwA46Uyuoe6HBmU1SEbbkneurSNU+IAG/TWHMxbXe6+rbNPfkOT3vGMs05W
         e8kF7w04fL14q8V5T9jKOPwOEDV1UgzyROdhAKopbrK55+p/wh0GOmb91KcHurFzAkWj
         ipBGzOhERGqvMNI1AhS3m7q/7GudBhIGbnGoYxMjZ93kO8+1TJcFyAyd60Sf1n9tsJ4Z
         mpnEZ0KkIISiE5qcyvWBl2vnDKxZTXl7DwcqQzkz8r1szz9GeY7pcaMH0QSKokD3njBG
         cw8Q==
X-Gm-Message-State: AOJu0YxLvyLbxp+x5TB3DMkqZsTfD5TP8A6oSf7aTm3uHWFAjGk6Tqgn
	eTW48ncUwETp5JpdKb8H0ovaz9PCchlKrsJ3Nwljvuw2n3VnOzXoIylutT3C9Kaj+rqowg==
X-Gm-Gg: AeBDieuGGZfnPxb5uekOeLZX8Zaq9Xee/sL8Mei6TQeGIrWG7LPIy9Zr8XlrXzpwJMv
	5c3yLB3bOyyAy+gcGsG47D+80cHh9zwW0tJlO6BlcjynNjQVnN8TNibrihwNVu0r/IF3oZNuuH3
	LRbUT42WutPbysziu2oEOh6w9xdl/gcGiz0lY3yjHVSWzZWCw5gPIDgmzN2N8dcXFHTdIAz0nCQ
	fKPXStDhje1goz8lIfc+gsDQYPuIifaLrBzCGY2q2Rd7li2k9FRRoPgMF0T8x38Et3nRzegIvcL
	yEbQeXdLWQ0XAQqgB4w9GQee8ssIwzKaJ3RgFC9kpOfQahWIeERrGbg55gXHigZqB/kuoZalzOO
	sF7Z+81Xtg0euhVix5VcgqfstxCUeswfPvBdSoEObiNHhL41/4AKN5qwNt+VvBu+NNNBeo1W+Wx
	BlSzvFerpr0r5v0BHXD02WVN96WHkPJAPX9DX9tiZFWxtdt0UqFNSpPK/fYNvecq+YFzad/d2D4
	4doO1y2XFgJ
X-Received: by 2002:a5d:64e6:0:b0:43b:3d54:3154 with SMTP id ffacd0b85a97d-43d64254b01mr278430f8f.7.1775760017303;
        Thu, 09 Apr 2026 11:40:17 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5d88bsm560563f8f.37.2026.04.09.11.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:40:16 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: vburru@marvell.com,
	sedara@marvell.com,
	srasheed@marvell.com,
	sburla@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2 0/2] octeon_ep_vf: fix napi_build_skb() NULL dereference
Date: Thu,  9 Apr 2026 19:40:07 +0100
Message-ID: <20260409184009.930359-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-277103-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2B9A3CEC4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

napi_build_skb() can return NULL on allocation failure. In
__octep_vf_oq_process_rx(), the result is used directly without a
NULL check in both the single-buffer and multi-fragment paths,
leading to a NULL pointer dereference.

Patch 1 introduces a helper to deduplicate the ring index advance
pattern, patch 2 adds the actual NULL checks.

---
v1 -> v2: split into refactor + fix per Simon Horman review.
v1: https://lore.kernel.org/netdev/Z-6w5kfCJoGhb30g@framework/

David Carlier (2):
  octeon_ep_vf: introduce octep_vf_oq_next_idx() helper
  octeon_ep_vf: add NULL check for napi_build_skb()

 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 47 ++++++++++++++-----
 1 file changed, 36 insertions(+), 11 deletions(-)

-- 
2.53.0


