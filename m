Return-Path: <netdev+bounces-285035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIH/Lz2v+2n0fgMAu9opvQ
	(envelope-from <netdev+bounces-285035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:14:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCE24E0865
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19FEB300809E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 21:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A93B38BB;
	Wed,  6 May 2026 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhMwgl4+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4FA3B19A0
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102072; cv=none; b=jvB16AdgqwPdH+OBqPR3Gna3M2oRRkEFJKqhj3Ii1yTvZegWNy14z9Qh5/n4jcgY1fT/A3S5dQWoIRLhVqNdZrUmunLmePGLPg0n9tlDoOsPLJyj96XumPVkpb98LTZQX/I6ik06iinOODWuFdduAUbvIAbAq1QJXJH8gaoOLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102072; c=relaxed/simple;
	bh=8AsPe1/CnmmthQk6ZSsNAP7+vFIbShFXKYv/t9fjbys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ao8lwcF6XQW486CQlwa9H+B8m3uM/fadXG/GlWRUlaT2jY3sFtxlUA/E1GrQkuEmUCyqb1VXawgceyY3xHP4Fckr0obAamaHXXduKXlPdlP6Uc1X22QdX+0VrQOA+QrEU2vhS+EY+t30xJqT3uGDbqzeEXlqYtfB1BoAbgz3dB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhMwgl4+; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso439208c88.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778102069; x=1778706869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nDev9YNkvZ2QavnSFCr36C5vNn0a8N3LeIk14oGej3s=;
        b=HhMwgl4+exInTBF/k9/L15y9uP2SP+MVI/9FenbRR5TvhMQWud2OJvQBvIB2sc+MVI
         m35P2MAzTbUn4xu5uO6K0B0c0X1eGkcs0jnFtJSsTYzSyH1rzFo2/m903njgx9ynRro9
         NF48LH3UMuKCnl3n+UO6MApTj8ZcOQME/3wl53nSjy7hN5+xQ+VYHHyS3FbqiyS92TJg
         GAgzDbdFA3eTxyzWt7lEaQLZW3UFQKVAlztYht6wZjol5ZX+QP5utk9EgcSEI8KSKtnw
         TQ+ax/y7skmdLwXER75od9aZvBJepC03mHWqIYx1Ij3zi19uLgves0FHNXBpXk7Dduwx
         V81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102069; x=1778706869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDev9YNkvZ2QavnSFCr36C5vNn0a8N3LeIk14oGej3s=;
        b=I4wCAZO81Nxq5jP4aVLw2T5hXy+BT5jYZg/5orPBtywv1lODrNZ8Xj63Q+u/nmWl1q
         6RtCU45RS0bIJ0keIu6tnBOvgw96ERXMYYXGKSUWzA+c8yICzzOe88/+v8RJecmWVtY9
         DMmd5rD20OoK9z3CcWjdLxbIYP6KtYXP9dC4IjWGdE+PlD+z09x6Ilo4XDct7+meZmZ5
         OMXy2xTcqa0prA1rd4bJZqc/6SZinf79NLGek9HzO1CaJZjZ+I3L5jc+XURa4pp4Ojwz
         7giDeLzryzxHTFwdP1xRPJ7dGF4ztTCh2uq5OTlU+IqN8SQ6VFr4aROH2OG4TdEAizMX
         fGOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AoBrX4fPAVOYqrGkw8PrdIb7dL0dJXf52o6CiABL3fsqsGgcg6lKlH5tReAQ0Zp3PUMlVsPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0o20aqYDfn+LRAvFA83zAaRnNI6LuxlbHGQ9T9JsZ7TKUEPcu
	RuMnCwlxAQywhGAufa86d/o2ZEBrfowIxQaxQ8Vu8+98c54a6LhrQ/tb
X-Gm-Gg: AeBDieuM0Y6JnO3cUVdw4AEEjnUy5MK1HXFYGg6v/rxLN0T4UNSl5zi8Imr7vG09zgi
	CJGrkDKKpYWCp1wofbgAhCx6Rk5cdEjZIN/UvnTuaVrgoO7HTZBPt0uAdjOqKMOX/W+8is7CfB1
	znC0cOCgxnELip8hchhvJs81zpxXCAcFK5++olQ2UjcoFEKf549wXTZb5PJ1YMpYj2OrU/aumtK
	ZKPbxVNNr4bfIdmfW2Zy9jM8kWtuVcNi9iJ0BEe5NunQRhNZLw/+X6XNulu+3fEiQMwVMpS9Wv9
	KYYwKfUBvsxOPZRv7zDk44mYfQgcnSr9YIyWVIqe57Xh8WYGLaP5rxqiWDW5gLcwmwqQ7eUuceE
	KbbomHojGNtDX9U2aef2Ctr41+HkBGl8FPmhzIKnOz6J8CjwYOAoFHpaJagHh+Cy8r0T3vWKVDl
	p3gJmix94b4a9aqmshbJh8G5PuN+aq1PspBxVWmc6q8S+sl9+LyKLMHHYO++5eF9eDnet/PdKZM
	u7AxKA=
X-Received: by 2002:a05:7022:458c:b0:130:68a1:a235 with SMTP id a92af1059eb24-1319cd28b14mr2790416c88.27.1778102068713;
        Wed, 06 May 2026 14:14:28 -0700 (PDT)
Received: from localhost (201-68-197-254.dsl.telesp.net.br. [201.68.197.254])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-13202db1914sm6071240c88.11.2026.05.06.14.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 14:14:28 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Costa?= <alvaroc.dev@gmail.com>
To: jiri@resnulli.us
Cc: =?UTF-8?q?=C3=81lvaro=20Costa?= <alvaroc.dev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:DEVLINK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] devlink/param: replace deprecated strcpy() with strscpy()
Date: Wed,  6 May 2026 18:14:11 -0300
Message-ID: <20260506211415.16343-1-alvaroc.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2BCE24E0865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285035-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvarocdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Replace strcpy() call used to extract a string parameter from param_data
with strscpy(). Since strscpy() already performs bounds checking and
ensures the destination string is NUL-terminated, remove the string
length check as well.

Signed-off-by: Álvaro Costa <alvaroc.dev@gmail.com>
---
 net/devlink/param.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..26695b7e2861 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -536,11 +536,9 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 		value->vu64 = nla_get_u64(param_data);
 		break;
 	case DEVLINK_PARAM_TYPE_STRING:
-		len = strnlen(nla_data(param_data), nla_len(param_data));
-		if (len == nla_len(param_data) ||
-		    len >= __DEVLINK_PARAM_MAX_STRING_VALUE)
+		len = strscpy(value->vstr, nla_data(param_data));
+		if (len < 0)
 			return -EINVAL;
-		strcpy(value->vstr, nla_data(param_data));
 		break;
 	case DEVLINK_PARAM_TYPE_BOOL:
 		if (param_data && nla_len(param_data))
-- 
2.53.0


