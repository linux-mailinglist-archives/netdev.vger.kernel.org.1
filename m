Return-Path: <netdev+bounces-269680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCSUK0t3vGlWzAIAu9opvQ
	(envelope-from <netdev+bounces-269680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:23:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 057512D2EE0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA4930075E8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7F3B8BD9;
	Thu, 19 Mar 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuzWM1lw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C83B8BDA
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958984; cv=none; b=VfuFqE4/3ekJzNJfMW1hIEx3aaQHTMyEuTBrYZ5MDXZFtpR0hsEAnOHBJW8pZkjArTTg2iNcwcNWsO0WPpVaTXB2MNqdrHY59LteqzEMBzOV7d/iStLftZDeEnSAIZg5AnzXL1YB6F9F0Ru+ClNCLvMJcWBM+fKflrXk0tj7tG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958984; c=relaxed/simple;
	bh=RwjqPW3hdKbq12/VtiolNMkns2Vf6kLHBAL4x+OMV20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fEE7Chlod3ePeAK4MSBMWVrng0yjC9Gk6ZbUr50P4c0RIaiqn7e+Xv9O1k1XRHACJEUeRrg0gwXrVTlHzLU7TuSDuWcFBpXunk46nbEcZ8r1P5sGFEn1kejT8dofIC88Ke/+ZAEO43fJIIiiH7c6oi483Y78pUkwkiG8EN9uCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DuzWM1lw; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12711ec96fbso1508804c88.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 15:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773958981; x=1774563781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21CCv2QhWEuG4RWtTFKNgnyM/pUG+/d+Ba5VzMpYDr8=;
        b=DuzWM1lwemao7q379F+lf66q0kH3M/ZpzJ9mG7f4oIYwIjhjnyqTqsVIV5F2amhbnF
         OUBoCK4D4RTAVgCd/76YChIRW06XBfN6EicErjwTsZ2XTSzc7niIFh5KlMw+op5lmrmq
         4bOcCasxwHyt99tG5iYzqTCCy3bT0HypQpIvOd+DBs4252yvE7maO6czTZOriWlmkeKG
         BnSFltrqh/4l6q3wDarvlvBhhUsO+SJnZ+XVTXmEN/BnzgPV6qKUfGTPwt3SV4Iw2EHT
         ImSklYklJ+7EvpVZMmco+IUdmTSZjD3vfAeGZqgQmLCug/n7lErtpmOfijPBwhaVqKpv
         ZtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773958981; x=1774563781;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=21CCv2QhWEuG4RWtTFKNgnyM/pUG+/d+Ba5VzMpYDr8=;
        b=SWb22AzfoVeqpdgN/AcpcMw4QzN2OdU460OvlJ0YvH3Q2c61zHnTiaDvRFmu2NynhK
         cGU7tLWiXLQ4Uft+cme0p1/sjagenf4ftG1JUDdQwx+VTOQeCCR08g6PWZNzHktFfWhr
         3aiBzcIhkquHDLn2/FSS5yEBsVY2/xpyzcvzKoYU0LidzmnDPnDGDK6z30wAQaF1I4mz
         DSeqDLhbBkjZg+ostUCVazedQampnEWVBIhy2hzFOw1PiPgmejuhqUVv+wV3lCanzx8E
         HsaJ2mrPAw3O59KOSx3WwejVZTqkQpgs+aydqO+vG+GcVzLLWslRJW7XL+9R/+ajf6jq
         y7kw==
X-Forwarded-Encrypted: i=1; AJvYcCX+RFL6q5igw4lU+1SMXCPquwplLuEcGpoI26+YFTCVLweLblFQzMAM7Zv5ArTL6NP7+OPpZ8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrZCo+/g4WI2pqmwepnkmDLYBeUhhqnqPKXWS50GY1N15DZgU
	G9uvuTDGdQt/QopMrs1gjefx4zvR446oHLIqTV3+YUpcTw1qc4fw2l6FbfmhNmXOY1YDDXKGw5J
	PGE2Fn1Emv4rl2Q==
X-Received: from dybsq4.prod.google.com ([2002:a05:7301:7104:b0:2c1:771:5786])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:e8a:b0:2c0:dae2:9c50 with SMTP id 5a478bee46e88-2c109804a43mr536456eec.31.1773958980702;
 Thu, 19 Mar 2026 15:23:00 -0700 (PDT)
Date: Thu, 19 Mar 2026 22:22:43 +0000
In-Reply-To: <20240617093620.12a9b539@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617093620.12a9b539@kernel.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260319222250.2588501-1-cmllamas@google.com>
Subject: [PATCH net v3] neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GETNEIGH
From: Carlos Llamas <cmllamas@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kernel-team@android.com, Terence Tritton <ttritton@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Carlos Llamas <cmllamas@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,neighbour_test.py:url,davemloft.net:email,android.com:url]
X-Rspamd-Queue-Id: 057512D2EE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maciej =C5=BBenczykowski <maze@google.com>

without this Android's net test, available at:
  https://cs.android.com/android/platform/superproject/main/+/main:kernel/t=
ests/net/test/
run via:
  /...aosp-tests.../net/test/run_net_test.sh --builder neighbour_test.py
fails with:
  TypeError: NLMsgHdr requires a bytes object of length 16, got 4

Fixes: 7e4975f7e7fb ("neighbour: fix neigh_dump_info() return value")
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
Tested-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
It seems like this fix slipped through the cracks, so I'm resending it.

v3: Rebased on top of mainline and fixed the conflicts as v2 from Maciej
    no longer applied cleanly. Verified the fix works as explained un
    the commit message. Added tested and sob tags.

 net/core/neighbour.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c56a4e7bf790..bdee4cf110bd 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3953,7 +3953,8 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_h=
andlers[] __initconst =3D {
 	{.msgtype =3D RTM_NEWNEIGH, .doit =3D neigh_add},
 	{.msgtype =3D RTM_DELNEIGH, .doit =3D neigh_delete},
 	{.msgtype =3D RTM_GETNEIGH, .doit =3D neigh_get, .dumpit =3D neigh_dump_i=
nfo,
-	 .flags =3D RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+	 .flags =3D RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED |
+		  RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
 	{.msgtype =3D RTM_GETNEIGHTBL, .dumpit =3D neightbl_dump_info,
 	 .flags =3D RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype =3D RTM_SETNEIGHTBL, .doit =3D neightbl_set,
--=20
2.53.0.1018.g2bb0e51243-goog


