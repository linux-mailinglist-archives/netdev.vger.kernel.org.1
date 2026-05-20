Return-Path: <netdev+bounces-289879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD7mDZCODWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:36:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5F58BD5A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B7C5301F9BA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E78F3AA1B2;
	Wed, 20 May 2026 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDn8UbTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AF3A544D
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273152; cv=none; b=c0XnGiFFVG25yeHHCF6u4BLEarm+RSjtNyTt/Cc3zLIOzpHfl+lywPb7PBvgtODFu8ZKUBB8e4MuHDO0+kI78lvMU4quYdDZp3Atx7lqeOHfaLS3J13INEbE6HO0I3yjpoe+dGwY+LEIFyif5buF6W4re4mYBvg5TSzGmmLqSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273152; c=relaxed/simple;
	bh=EsuMteTS8wv1emfFeo7Evcv8TqjuK/axQXyFjKcgLWM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rTJPFfNxtGPxZJmziy+pDQAdRgqZ7FMMrX3ibbJmRNkKpoYvkelp+u8cp2JGzuhX5HwLrQLweeO3eDQtRvH0Gk5iapGXMDNMZjGv6MtFvJTVaBF09mbaHLU+hPZCfuc3rUW0CXsfOq/aB55m7YY4asHXL5fF/6gnRDTiQ8sgNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDn8UbTL; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50fbc70cfbdso139976471cf.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779273149; x=1779877949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ap5x+xrKtC09Ru67F9w90PyjG2arP/ZeCIIk8BQlDUk=;
        b=jDn8UbTLHkKo7AgBgtHU95rLbsgNP9OAjBmH20m/4+P7K8BNMv5BRkQmE49/EO+nFw
         MJSL8ryaTiHOeOnmOcejUnNKutB68TFMnoox/JGcMmax5fbXX0w4FYbPcMIaj5oouv2R
         b0cu7GawUKGhImfsOChpv7peQwAxGMvK9O+ziiilmC9hnsWkLP8rwISFcRdFl3LVmhYM
         EPIfxdmSCLLmJw90QhJ33ZGsYYuvgZTr51/B383iZOEFwPXnXpFHVXU0c1pTCfI9zOx/
         7zYnMRIjo6KXdf188cTiml9atNh4x/oMVBSHci6gIK5Cko1boCgB/bojdo1C5cG8yGf2
         fPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779273149; x=1779877949;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ap5x+xrKtC09Ru67F9w90PyjG2arP/ZeCIIk8BQlDUk=;
        b=soCsvTs3LdSjELctNLmIOinm4C+DpiXDGfDMsLwFHvjMSU4IeEaWHCDCpodbZZKDbs
         +iBc7PHljj+PzdzUjNcHl9M2ZH/ev+0u0p1WJ4QiqUS/fy35jkfu9+zXYMjC+QFAZVd8
         et8pkZArduLqaIX5E1oBneMxIvW5aBknTBnI1ICOM8321W8OwaD78phEX5CJ5PNHwPrU
         Z5znlAxGwlEROwLAHwK+v9DDAU6duX1g25kPKgrjSfVjDhQFejKGtNmXY2g9tGstJZDs
         4u4zGtAvCnENAaBhzC9mysuBSshX1DXt9+uzlFW67CPdC2xqEsA8f+G5cZdQE36khEsM
         Rm/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9G4yA4A2n1a3iyO3IhkYNJKae4t46ywt8ilxfb5CTsOxo+mGl+AFYffOt4VnU+6NTFCKuIXyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsK6deKYYVIqzZja+z74+nSb2Ba4B5ie2ksFYmfxYsEgCNgYzi
	IeAG/fOySghsvXf7dlMvi6/gt2WOLpEv4on+76XbaqlL5ycdPQPeDHaGjGCc6qec4waq/M3i0LP
	yEEQs0en/0YXACQ==
X-Received: from qvbfn11.prod.google.com ([2002:ad4:5d6b:0:b0:8c4:b10a:1250])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:584d:0:b0:50d:91e3:b668 with SMTP id d75a77b69052e-5165a051e3cmr299120561cf.20.1779273148347;
 Wed, 20 May 2026 03:32:28 -0700 (PDT)
Date: Wed, 20 May 2026 10:32:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520103227.1133277-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/3] rtnetlink: RTNL avoidance in rtnl_getlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289879-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8CD5F58BD5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Many shell scripts invoke iproute2 commands specifying a device by
its name.

This series improves their performance avoiding RTNL acquisition
for their (repeated) name->index conversion.

v3: insert patch 2/3 in the series (Jakub reported a KASAN splat)

Eric Dumazet (3):
  rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
  net: defer netdev_name_node_alt_flush() call to netdev_run_todo()
  rtnetlink: do not acquire RTNL for RTM_GETLINK with
    RTEXT_FILTER_NAME_ONLY

 net/core/dev.c       |  4 +--
 net/core/rtnetlink.c | 86 ++++++++++++++++++++++++++++++--------------
 2 files changed, 61 insertions(+), 29 deletions(-)

-- 
2.54.0.631.ge1b05301d1-goog


