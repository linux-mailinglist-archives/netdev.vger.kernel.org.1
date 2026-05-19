Return-Path: <netdev+bounces-289419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBeUO8xRDGqmfAUAu9opvQ
	(envelope-from <netdev+bounces-289419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9BA57E480
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60055309ABE1
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E294A13AE;
	Tue, 19 May 2026 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCRDMiUG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE234331A6E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191039; cv=none; b=gszAQ3iVHSdks5oiATg2h1VvX34uSRHI+wDbmUY6UrwsdHJdN6wRnaAM7W48uUvRzGGwao9R4hDHvcBOGwos/Uy3SAvheA+hF4OVDP+r2Kbh9qXPUSU9xobBQcuUgqRKsQYjhRVGb9Y5INjznGxmPczwYXi3BjfCa/ZteV/f9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191039; c=relaxed/simple;
	bh=j0n2i1qqb7QEx6yBlpknzaa36RFp90V6VCOjjqk1Ils=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EsHtqP1UMtZyimy+0yzSp8ZK+DnywrXuu855g9Z1Iko5f2qZtAVmfN8/a7T4LlbbmYMFmS3ionA/G1MaEOURN+9cMVammzAK4QHh8KZYZKRG6qt19YL0ggfoEQNzpNsLx/EtxCCqEw+9zAZPvl50tXkjFWzLLWLlJ2CLTiWz6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCRDMiUG; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-514d2b22e7fso18579141cf.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779191037; x=1779795837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0VV0Co+RmezWRKvG4qKGgjPEjU48Ujf0A5MCPMGpp0g=;
        b=nCRDMiUGhYDrjsKwD9W2DrSgBGueUKJkwV/qTT75ztyCZFBbUzw6gbksDeN3aJE6Ye
         +GFPQuntre9I56xwFsdauxDym65uSasn9iKRIaUadATME2u750OUidU4ezfEFxHtbRGl
         BOOaSEqO2n41LdbZNNORWtBNSbchfpHYglZxHhyERAy+3MgXURzXpeTV8A9GrQmnJYv+
         t2R+jFQ0SpQddB1YqM7AfbBCuLTMwsaMQU7r1hNqhKchOgV567rFJHKGZWK/YHMfVsce
         PQlrtWHLBmdMOCsowBCmfvzDFxmO+VtohQIvw3MV4IVtISqqZ/tRFEybV+wJ6xp/OePG
         L6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191037; x=1779795837;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VV0Co+RmezWRKvG4qKGgjPEjU48Ujf0A5MCPMGpp0g=;
        b=ej722MGYIHfpl8b3Jpt6CWqJhG4tVUCrVamjATOAHMhbH4AZIahbskVzxk0NgOO8Ot
         Hl+PMPP2p2n9xlvqfPwY+JbdAf9qm7RewAKgKtG58rotlnwRkckyQ5fU+1Pc//owvjVy
         IEion0zmDu20H5KTCOa/nDh0nwlTrpvfLAiWO+Fr2qTIWuN14MaxCGTZcjW3kbMAaJC/
         bpDCOuexwtY7rVMWSmY/3fASEkyNCJovEwikWbXrzaOXdoAgQcz9upUI3jR45YQvbfeP
         Xwwr8VcJSY1/YmwU0xv5At2UofHuYonbT7HZq+GaTie98LKH+cNfbV8NPkEh42Quya/Q
         wgnA==
X-Forwarded-Encrypted: i=1; AFNElJ8JT/nkqS2xQpc1LMWkLS75iDN5sq/ALzfcTqzR6TwS8JI2laB2XSGauFuYenrQ+vWypZNG/Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysE0Go4elbOIh/wBlBUVOLNxaibLB1tYPt5AiR+yCK7KsLpL4u
	jaA2bHoZguzjTWblMOVP1YM17QpS2ncdmovPO6GJBVDtdfdI+VOK2NvHktXCFcT2iqI1YU6oq7B
	HcJ91JvXH8rOJTw==
X-Received: from qtny14.prod.google.com ([2002:ac8:524e:0:b0:50f:d9ae:6d00])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:6a92:b0:50e:5ffd:deb9 with SMTP id d75a77b69052e-5165a27681fmr185686131cf.31.1779191036618;
 Tue, 19 May 2026 04:43:56 -0700 (PDT)
Date: Tue, 19 May 2026 11:43:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519114355.2769474-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/2] rtnetlink: RTNL avoidance in rtnl_getlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289419-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B9BA57E480
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Many shell scripts invoke iproute2 commands specifying a device by
its name.

This series improves their performance avoiding RTNL acquisition
for their (repeated) name->index conversion.

Eric Dumazet (2):
  rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
  rtnetlink: do not acquire RTNL for RTM_GETLINK with
    RTEXT_FILTER_NAME_ONLY

 net/core/rtnetlink.c | 76 ++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 21 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog


