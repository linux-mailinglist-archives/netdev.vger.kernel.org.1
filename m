Return-Path: <netdev+bounces-70559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475C484F895
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BD1280CC4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A071B3A;
	Fri,  9 Feb 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGpa9JAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184CB4C3A9
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492667; cv=none; b=CArHVCARLhuF7+HbxIOP3BSuG4FxnB37lVYGuyFR8g24ewzaN3cw/8sonlezyxcJ+TK569gZ2mIYdoumq5f92SuPe2+MBCZsw9KgNV2DuZoGpxrHlzxXFgJq3bcI7s3hM7doXuveL/fInLH6H5Is9NMTI7PtjIrgKcy+r48Y4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492667; c=relaxed/simple;
	bh=vGNBHOMuxRfhpRv/yIL6gOP4V0QpfGDr+ALDbT+wW/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JLt4Aub55NHBjxwKME57lOE6j3WKGO9CEu+ZPVX8as9fDB6jwBoKbLRmHB1oPdhB+DQdCWxHOZONEeE6qxk7tpxDxNiSxhRNZyaPHOKO+V22eA301H8dSpfLg8HFoNbmcrUYAg/u1ix4fElCybmfrKz4fGVhHkyFuBFBNek6/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGpa9JAr; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-68cb1a41299so12948246d6.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707492665; x=1708097465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SBmg5KCXgc7oKw1oQORLpb6SPME1N66Tam0h1+6zOr0=;
        b=TGpa9JAraIwuxegWX7HjQmHRWiIxvZ0Rhd5j0Qg77sHK0ho+Ea3GX6OD621Qpv6a9P
         wKqXHLQJo861MjOJfipfEFA89ZuoY/wdtJCFAlwOqEKGJbSTt0NlFl53hgUg0C1vYqYQ
         OS+I+BUr2rlL2DmwVdpLx2dX9SDtlQqe5N63QoCxhT0VmGKAewuaX2jZIMYWvPddce5a
         IXNTO3AGbbtiXssT7SUWfme6xlqcIC+MIx2ac7/SFfNzndc8K0rOLZW0LtH5HKtUeDNW
         VhF1lhl/B/PQ6X0l2qhTlCjoua41EQHoV+NR+Mxa65JFbwDEdJi03W6xTEjO2/Wm3AKl
         btLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492665; x=1708097465;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBmg5KCXgc7oKw1oQORLpb6SPME1N66Tam0h1+6zOr0=;
        b=gbH42n7favmVyd3YNwfeCJ05EQb5Cm11D2ZCF0TLvJCD/yYFS3uBTo9DKCSyl/hHt1
         +/9HR4+MWX7B0FLD8nUIch6csz1IJ6M5LUx2ZqrN+XhpMm5yb5N5wtNklBFbQxJlzzCS
         PgNdQ1isOK94y59kU9Ur98cryEeOQXfcyGxS+zWS7aOVZZzKYOoxdo+PVWHVq4PBXb7M
         sfY5/8F2yi0xyzLam1BJRlAouDYqjn8xFzWdsZiUhAmv147I1hDZzF4YGQy5RycXFcDi
         VdMOnLENpleYkC1CNHlYV3l7l0UUng1Z2/ZQ1Vhma1F1nHEtbem4mU/aMq9yLp5tM1PO
         +J1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU24uSuCIA+zn8hd6FVQgXaN/3gFKXXt9zaJevdYNEsZNpap1HlHqBV0Eg/nb3OIJVvZdu1+zYJfefafF0jvDsvXCAmKiNK
X-Gm-Message-State: AOJu0YxxXGp3Wx37gVz1U2OsqhPsBCJ4JOA/x04X/VF2pgl2C+byUsg4
	PIG4gYxqX3ZyCCSDXLsXasJEaLknj/3TC76cr0JDSpr1UnFdOmBR8GrDHDU7CWoOkl2T5xeaO5P
	5Ia2Wg1SORA==
X-Google-Smtp-Source: AGHT+IFplo3Lv1A4fgPKR+zmyvL8PbRI6b/9H6a1xnzUc8RVP8HHm5DgLnQW/ILRLrytjzbKZ50WBN/U/RWNlQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ad4:5ca7:0:b0:686:9feb:e92b with SMTP id
 q7-20020ad45ca7000000b006869febe92bmr60581qvh.13.1707492664863; Fri, 09 Feb
 2024 07:31:04 -0800 (PST)
Date: Fri,  9 Feb 2024 15:30:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209153101.3824155-1-edumazet@google.com>
Subject: [PATCH net-next 0/6] net: avoid slow rcu synchronizations in cleanup_net()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

RTNL is a contended mutex, we prefer to expedite rcu synchronizations
in contexts we hold RTNL.

Similarly, cleanup_net() is a single threaded critical component and
should also use synchronize_rcu_expedited() even when not holding RTNL.

First patch removes a barrier with no clear purpose in ipv6_mc_down()

Eric Dumazet (6):
  ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
  net: use synchronize_net() in dev_change_name()
  bridge: vlan: use synchronize_net() when holding RTNL
  ipv4/fib: use synchronize_net() when holding RTNL
  net: use synchronize_rcu_expedited in cleanup_net()
  netfilter: conntrack: expedite rcu in nf_conntrack_cleanup_net_list

 net/bridge/br_vlan.c              | 4 ++--
 net/core/dev.c                    | 2 +-
 net/core/net_namespace.c          | 2 +-
 net/ipv4/fib_trie.c               | 2 +-
 net/ipv6/mcast.c                  | 1 -
 net/netfilter/nf_conntrack_core.c | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


