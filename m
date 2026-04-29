Return-Path: <netdev+bounces-282246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOWDF4uq8WkAjgEAu9opvQ
	(envelope-from <netdev+bounces-282246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:51:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B404348FFB9
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DEED30182A1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA339BFE5;
	Wed, 29 Apr 2026 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CTBNzO4x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BE35A381
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445512; cv=none; b=P0nSakADuruAev1tcu2uE2Itl/1OnqVvUOJLPq07MjX+dVsCILy76Zpp/baxi0ooufA+ORKpoY6YQ3MtLttZgdfBAk+FKrRLUe27sKDpkuq4KpkWW7Be6MJr0YiB5zDyerqodDWQA4QpdEcC1iXdhIaJDatV2QLT37KSc8LaMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445512; c=relaxed/simple;
	bh=ANsLwTO+kyeAhXqXmZWtED1qgfADSn/30UwqnPezkIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lP0e4F51DgDZ1YYCkI6t91Wm9EtI6j8Vvxb3BPnBJg8ZzEPTR0syzb2iCTnElISJOxJ6tQTiPaMfU/ya9mTlNUyXE+Z+Tt/tuO5jTsEhsgNHiSpEkrDEW7IOePzHCeozALJftAstPSjPYnsxSzVSkOYSzhkM/6I8nR+Qk+VmMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CTBNzO4x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b299b3c739so56815745ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1777445508; x=1778050308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1oIA84XW+a8Bh4ovzb4hgVcCSUxwgN9bGakuQa7qX0=;
        b=CTBNzO4xJyiIUICQk/UvdDEGm/209dwRqNqbBUPD9opwxJLW/vnt8pw0HGphwlcBTU
         gmV4oOiBXSwOgSxDBk9R2cVIGtpT3Eu8HjcmfTIU0VrZCXCBXvys+LM44c5HHErtUtBD
         WzhG8v5hYCx1njksnw1mXiC/2x1l3KDusIQ+4GReyNPTx7ZOvsFjqbKfgC+a7wPR7eeo
         Pu33fX/6i5dKE4QO073XQq53efgJUBr39/5yDgC1jxslEhvt1Mx8m9KGAL+Wbi884Sqq
         cCK4AKHEb866BByTZyox9WPBa17w0Cw7cANbOsaZimkf2u8gkJwY2Zas8ipZ0gRxWo/t
         NLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445508; x=1778050308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1oIA84XW+a8Bh4ovzb4hgVcCSUxwgN9bGakuQa7qX0=;
        b=ionsMZlwcqdD7XMIkGk5z9M2xJ8n7FNZox3hbheYr5+OwiEo94C1+zqcQNSEmgEUJr
         OEr/GbgYTDKxYbpH6VOLSmyADzzc137DOsQRQaqJE9dQ0iUveUFPJkNFXNQtDjyIdu9/
         uq8MgVGO7C/0ctbXLfs87wFLFGFJy8xFH0I711sRImvyTs//aBfUz9HefXKnoUaYnH7S
         2HNhuGu3Az56Z35JE7d/yXxjz6q2ugDV2L3MhJ4dYXW7z3/kZmxQV20enGcbdW3wtkWa
         AhXjhzufnP6rDIQpqHBuH+58ZHm9h3R6xlF8fidhmvfFsOGG+ymnvjnip2rqqAJ3q1cl
         BRSA==
X-Forwarded-Encrypted: i=1; AFNElJ+GhL+RuusvOiZCiPKrOK+YGsBMkFiL9lCeJudlgJE5H4N1JCm0IAUZ1uTZDpCEJ8pwdPShIjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwXZvun8gfdmmYor4tJZFgEu7c18GVvwh+OIZl57O5XsAixmTF
	NtrQpgfVyDwuY2mUYKPd3TnG73LwdfVKjJYu57EB7lzYoeItPiil8gfuwF6RqUJlPFc=
X-Gm-Gg: AeBDieuJv3tFzjzCZLCcqiesJs0Q88tx5n45ghVDF7agI9b5IZPbXTeqg2BmTHZbyKN
	NqwNR2JTMDsCQgkfvnu5WCBIS+NxBf9uat+AEkAz7IKE9m5OhI35+QG6g+/LFTCAoDNUZWNzXqR
	IfjYK4IeEnhqUkuxr1iPAq1Xiw/wfxpjvqQcWKUETPMnTZElHBdvbOYXasdTFdCqUVHIEsGzyrH
	H4V5lvZWQstQTb9itSR8F1c4bUCrZI1uadhmLgA8k+LGYTiDI+21NaXIqnSSyPqSYo1casuuvG7
	WukwO2Je6UCYgKc6iNVWBzVCD8c0YDX20bHXDB7jzfBkFUtlOqr94CAke4sP8sXjmrUy/kQuGPA
	sgi44pyABSSYrZY4EUSz9jRlKGQCPtmgI1/9Sisedk25vIB+I5WcftfpliRPjir6h7jVfWMr2og
	ga9PLogV+08AOOcKotZoXr27QsWYzD8QeDhlD+7G0GjolFoWWkzmNcgalb1+t7WZN504IzsRGD/
	Thk9g==
X-Received: by 2002:a17:903:11d0:b0:2b4:6367:7b86 with SMTP id d9443c01a7336-2b97c4a9217mr63297495ad.37.1777445507739;
        Tue, 28 Apr 2026 23:51:47 -0700 (PDT)
Received: from Vincent-X1Extreme-TW.internal.sifive.com ([136.226.240.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98895afaesm15038105ad.57.2026.04.28.23.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:51:47 -0700 (PDT)
From: Vincent Chen <vincent.chen@sifive.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	vincent.chen@sifive.com
Subject: [PATCH 0/2] ice: fix VF creation when !CONFIG_ICE_SWITCHDEV
Date: Wed, 29 Apr 2026 14:51:25 +0800
Message-Id: <20260429065127.423949-1-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B404348FFB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[sifive.com:+];
	TAGGED_FROM(0.00)[bounces-282246-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.chen@sifive.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sifive.com:dkim,sifive.com:mid]

This patch series fixes an issue where VF creation fails when
CONFIG_ICE_SWITCHDEV is disabled.

When CONFIG_ICE_SWITCHDEV is disabled, the stub function
ice_eswitch_attach_vf() returns -EOPNOTSUPP, causing VF initialization to
fail even though basic VF functionality should work without switchdev
support.

The fix is split into two patches:
1. Add switchdev mode checks at caller sites to fix the immediate
   issue while maintaining backward compatibility. This ensures
   ice_eswitch_attach_vf() is only called when switchdev mode is
   enabled, consistent with how ice_eswitch_attach_sf() is handled.
2. Remove the now-redundant internal switchdev check from
   ice_eswitch_attach_vf().

Vincent Chen (2):
  ice: allow creating VFs when !CONFIG_ICE_SWITCHDEV
  ice: remove redundant switchdev check in ice_eswitch_attach_vf()

 drivers/net/ethernet/intel/ice/ice_eswitch.c |  3 ---
 drivers/net/ethernet/intel/ice/ice_sriov.c   | 14 ++++++++------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  3 ++-
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.34.1


