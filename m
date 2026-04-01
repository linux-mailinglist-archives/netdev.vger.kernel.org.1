Return-Path: <netdev+bounces-273851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NdGNKiEzGlXTgYAu9opvQ
	(envelope-from <netdev+bounces-273851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:36:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A60373ECA
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05C1130D3E45
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E531F991;
	Wed,  1 Apr 2026 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBrFzVAw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701F318B85
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010535; cv=none; b=eyUWxFCWy0nXBdhB/3IE5Bp6rz5e5yfLGakP42oui9ia0gk/nlF9HOR1kSyaNGtCaxHmppdxC864FOsA9Xnk2aWnG6a9dVOGc0P1ZYetqzMgEk+yFoFPwbUcBK6pZQOm4w7UNcLzG49R77VVaWqFVM/7tiZlGl+MTfxZzhX8POQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010535; c=relaxed/simple;
	bh=utIcGGxWrzqPWEW1AAsDsaxekc+LTZ4/NSafgS4cQxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ieuc63spsDiYSN1CJBPMA2Qw1D6C9WgXdyHzeJJ3grLibYtxbGgihR6lAywyVfPwYvo0tCA0tibuVzrW4RAF/v3Xv526fbG7WwZ21KRBuAWQRp0kxSjhHtaxbLh2YGanlUjt083X5K2WaV1QyN4a9/qVn/JjfV5ukf2oRqux3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBrFzVAw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c11eba219so76133366b.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 19:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775010532; x=1775615332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAUKg8cLwZJABnBUOsfYjkVaIYT+TKbKJ+l7V+/aKsM=;
        b=KBrFzVAwk/Ves/oqqvMVlUlLB4EBaAbBGkm1gQGpNfccFn6xd+LGdNybKaQ/rf4bc/
         blj2ed77fmj62dRYpHtCbFFIfzt+k0biDONuKd6QaN2eKHRrJ/8C3cF2thaC9PIiqxRR
         jlbnXkuqlSXwHUA6MFFguzuhxXwSSH+gVEDY6l2VwlRUoZ2BOg9IqN83qDDVC1+VU5dA
         1O+0JbofrODu4dJkW8lVLy222+At99J5XPJolAX6dY9bVoRXgH4ZmP5P4pyxNMGZ6YuM
         Luwbnl77pIVnSryrwF5LgH7MhYwPMRiq4nQVgpcCjcYdeFsbh7TqAQz99o2UkmlDMaUS
         YcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775010532; x=1775615332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAUKg8cLwZJABnBUOsfYjkVaIYT+TKbKJ+l7V+/aKsM=;
        b=Se0VpssKKPW9f3Lhdz0XZvGh0ue5ZZFjowARe9SOjbBOIX/OLopZZkUURxwDKLYmvz
         ZGn5IForA1Id35bDlZwVRyHzkZwR62anvg95EyNABCz+gvssR1x4qMAD4PFl7K25U4AJ
         kiCQIJPk9r4oZhng4/6qu8mA/rtsOXDjDjQfcuTwyJ9vOGIjOpp9csbziOTtd4ROPNpj
         HGutDZTzfzBE7nt4AiHyEiUkB6CV6FreyRKmx2EzFEW7QZCopUg0f+wit6g9O7iUQ7Sy
         8Trdn5bhF3bazYKHX67L5GDcmp7LXjcyfC79la4BXo18N4MjpBIs7XgXO1slyfT3I/iI
         vedA==
X-Forwarded-Encrypted: i=1; AJvYcCWuhduR6Y7umgWT0MdpzwAgw/ZO3ujKUFaXn7L1T84Xz/M9gCVIAt9hZ9mscsA+7/NbUL2ZAxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGN/X6g/fTEHsAC6hjIQvVKKZOvfmFuTMb7xlUZprSg4MMWnXc
	R8vgvTEo0pdZ+d7OJRUPew4or2bzx53Mwto5cqY9eFv0pvnemaVk9JHc
X-Gm-Gg: ATEYQzxDu5b1s0hqVm9A+aWGdddOALPH8tczNxmB4SGCN6gzNFRdTPhdnYcIeQBXQAe
	y/kx3mPH0TLmU3DhLDXitN6ZeI7vQfNEIsAIy6RaNgSlRMsCrFkwm+hl7RoTk+9aSUEeCsdY83T
	hW9hKnb+8Jnl/qB6xdqAwSih3F3WPGmer4UqK6GNugFJwW2zbwJQjc8MA98sPFltKSSUSFFzrOp
	RmxURIT68enwObXHztb3FMFOct/5F2MyI5NNKH/Q0bos/DFR/KDmVUsjPv4eRQRkzWxPcJfcl4d
	4v8S0/0FvdFdRvPyYMtwMLuRgwa/LA7Qy/b5pwmtWAeG2KTpQ71huFGm1cKB8hpZEhAML/c1kvN
	CkCNrkN9nwGftEOD4a5hv3q0MuLTZuqbSZw+07Ce+pNe3rqPHWnTNBs1xi18+sv8b237bzNv9Vv
	GgsJLYx/o0gucokQ==
X-Received: by 2002:a17:907:d096:b0:b98:33c5:1ba6 with SMTP id a640c23a62f3a-b9c138e59bcmr123794366b.17.1775010532194;
        Tue, 31 Mar 2026 19:28:52 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e22:2719::3e5:12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b22530dsm469507866b.54.2026.03.31.19.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 19:28:51 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Michal Ostrowski <mostrows@gmail.com>,
	Michal Ostrowski <mostrows@earthlink.net>,
	Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [PATCH net-next] MAINTAINERS: orphan PPP over Ethernet driver
Date: Wed,  1 Apr 2026 10:28:39 +0800
Message-ID: <20260401022842.15082-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,earthlink.net];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-273851-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22A60373ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We haven't seen activities from Michal Ostrowski for quite a long time.
The last commit from him is fb64bb560e18 ("PPPoE: Fix flush/close
races."), which was in 2009. Email to mostrows@earthlink.net also
bounces.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d5..3b7b7802ff95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21064,8 +21064,7 @@ F:	include/uapi/linux/atmppp.h
 F:	net/atm/pppoatm.c
 
 PPP OVER ETHERNET
-M:	Michal Ostrowski <mostrows@earthlink.net>
-S:	Maintained
+S:	Orphan
 F:	drivers/net/ppp/pppoe.c
 F:	drivers/net/ppp/pppox.c
 
-- 
2.43.0


