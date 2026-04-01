Return-Path: <netdev+bounces-274125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCjUF9MlzWlkaQYAu9opvQ
	(envelope-from <netdev+bounces-274125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:04:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 410B937BC8B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 729B8303C615
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CE1441022;
	Wed,  1 Apr 2026 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyqIHB3z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EDA43E48A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051588; cv=none; b=KvPrRQECXyutyrhdfQc+NkEk6n5kHvUlL2MNibOGMfCTx2dgFGkIkLpw0IZ4qf+3WLOyawLVEy++uiKtX3q/uPafcIDmjfxsC4Uq1zm0OGaXioyeDMGmLM6iM75jkD+4B8R28lQ9yVFDP7UyRwuk/xDUnGyXz2OtXaYHSYGyi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051588; c=relaxed/simple;
	bh=jTEzlMBCLfzL2mxhEE2qzB2BE+TlWpIbUDF27UYhIcs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hz8bT0+DJAUuF99fzWTZ4Lvf+hr7iiS2qkgykXjn2A/KvDxvHT7A6B12nSQzQBZP8suAE7onG44iUUt8VVphMecSLeHnFyxFyPWzW5KYcSVNSq6vscIhEZPnTs1W9PXBhouHH2fAi7CoiX3giVVimJpnvfB7CXI2WhdV/o5TNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DyqIHB3z; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5094741c1c1so78107151cf.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775051586; x=1775656386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tdffwDrjjSBRm1n9/yeF1CLMVUbO+O3NDUev7ttY7gE=;
        b=DyqIHB3zFiKnP05ltgFIyUfFj3ctQjczSH/XsS+HgPAvuzXMEeLYCi5/+v3HFXBnrq
         a2elmkueKeQdTBo4C0mT7dEQbuGR2pcj9gSi0iiPlPZ0zIH+L0ZpzXxxUWfHLzpjq8JY
         I+YHOweXNXAnAFp/ZKl4V0Y7DIG1l/70LJ1Gt/nuaxk+Gb7VAsAaUZ/Y79TUAkmFR9Ky
         kHor3uKU9T4ALgLJLEnvcONciucIGLHB6O3dNnFQLWR5Cg5gl254aSu4eadq+NvO1rof
         ujE9N2cB1T73ie3eW/OUE+iwIOwoD69UYNbFnum+MiwY26nijCRjZj6DFciFd1DBKfBK
         Kx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051586; x=1775656386;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdffwDrjjSBRm1n9/yeF1CLMVUbO+O3NDUev7ttY7gE=;
        b=rEfQT8MmPgtEBQgiyXf17v0YcUN7IOb57V42wHHN5uJAg3pM84lrQGF/9t9fMUc+N4
         H7TYsERq9oZ3zYi/HjuiCKf2s8IXTr2eSlnxKZrZt//lTupuWRpq1d+SOE2hAErbUxDp
         273vzagnEfkjIiqPLU8VQk7+kwCLdEWYzTfN7zTyWEVekhp7BF92u4RFqvoZ+G2+dY3l
         VCScqz9AiJsBakriJM4ufCB8FKgJvtB8jwGg2fgAhivvCzmIxvHlaAeSlioeH8jrJ3pl
         0/oJRf+FSrb5imvy4wcTUL2rOySH7Fia3VeuZMD3o2u5705YPhtKXnEW7t7/12Jfi5Z/
         Pitg==
X-Forwarded-Encrypted: i=1; AJvYcCXFFE32cTpdgzwf9UIB7vqD18djzRVMWNOhfJhontID+6iFAExDXYiEZs/OCQK78eS3dWcdmfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+aORGBwdsCe6uqInDHTU494YZLnFa2pXdfbKaDbVzitORqImj
	F6T3kBDdxAG8n6j2EQnt8Cq65ZGjB8hwtIba4XDQT9U0cIn5w0kSr+uJ9IBSu4fLnnZON30Z0Nb
	0u8+s0LyEWUwCKg==
X-Received: from qtjx22.prod.google.com ([2002:ac8:7ed6:0:b0:50b:706a:dee9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:58c6:0:b0:50b:4984:148b with SMTP id d75a77b69052e-50d3be22da4mr47008631cf.64.1775051585481;
 Wed, 01 Apr 2026 06:53:05 -0700 (PDT)
Date: Wed,  1 Apr 2026 13:53:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401135304.3629615-1-edumazet@google.com>
Subject: [PATCH net] net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274125-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,d8c285748fa7292580a9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 410B937BC8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lapbeth_data_transmit() expects the underlying device type
to be ARPHRD_ETHER.

Returning NOTIFY_BAD from lapbeth_device_event() makes sure
bonding driver can not break this expectation.

Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
Reported-by: syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69cd22a1.050a0220.70c3a.0002.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/wan/lapbether.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index f357a7ac70ac4756967730fa61c07258b4b3ac00..5c91160dd68cc1dfa4308d38fb111032206fae75 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -473,6 +473,9 @@ static int lapbeth_device_event(struct notifier_block *this,
 		if (lapbeth)
 			lapbeth_free_device(lapbeth);
 		break;
+	case NETDEV_PRE_TYPE_CHANGE:
+		/* Our underlying device type must not change. */
+		return NOTIFY_BAD;
 	}
 
 	return NOTIFY_DONE;
-- 
2.53.0.1118.gaef5881109-goog


