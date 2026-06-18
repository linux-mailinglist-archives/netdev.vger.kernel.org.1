Return-Path: <netdev+bounces-300366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jNhUFXm0M2obFQYAu9opvQ
	(envelope-from <netdev+bounces-300366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:03:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9169EAFE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:03:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="Dr/Ydqrn";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300366-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300366-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7E8C3025E5F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6A3815E9;
	Thu, 18 Jun 2026 09:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B923822B1
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 09:03:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773431; cv=none; b=upMMzbFL+UGvk44ddm64gZNkHgmFfSAlhUzeWSmXJD5t/7ujQWjKgx2UR//a5eYgdXKi+y6OlXvBPoVpTk+BYhXvBaf+Z6usCDzUdNQuIsfw0fXydAifSoBh5YvG0bGNPGtt3j+X1EauxK0gG8JHpalzbx9n6Ia0dgfsG6f1J20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773431; c=relaxed/simple;
	bh=pDfYODN8eSb3Osdiy8pGUbcCjj+Vd5hRyuhJN7tkHGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+ehOR+LTCFJd3yO1LwHmBlap8wTN/YyhrJ9goCp2LfegQKaXsWrNdASt61NlBn0gX22CkDWveNSqPMT5KZZuvELvtRVuAjTkYlzgIjr9MwU6eB0QPEj1NvAxWXkiYQHaN4WePBFOybLb4vLw3M82wOs4ntQftNp1CbPHeqMqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dr/Ydqrn; arc=none smtp.client-ip=209.85.214.226
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2bf1cda2b17so4141005ad.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 02:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781773429; x=1782378229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpNixvCXNM3odqaYWueSGP2Z43EAIlNiUuWGIkEd9i8=;
        b=BeGj0PPjjbxo8lQyxtjqdbf25MoYtbMGPyn0dqufHsnVjlb8Fwn27UmZbYsPgxz04R
         F5LgJFbiEKtHDgQIFf3yh+6k0HC3xd9hsuy7KAsNrdEOop1EUnmQUqXPXM4wDdGZGUVU
         qYtODLWyrBPhCg1kohHkywPn5or0mq7+1VTCnGATkoJjbhoHBy4j9vH1PCNcAmsh0NWu
         AQlcgmQu8yPvMsOIltECun/+bOwxmwXxNRYCmAlSWRNtIn/YUnLGTtIMtgCaFevBWF/g
         56ZJue6fOs1Cl7TNp2mQbi9ABNMM0SwtDED2pibtPmgK0zvTJ8/IXNeAYxNLAW2Khn0V
         XTtA==
X-Forwarded-Encrypted: i=1; AFNElJ9/OwrXj5flN5Q8aXcwZUhWHd+nwRvWcqA6xPct6a/o0xOAM+DZOg5Oh+2qGUMpeS/bCd6N2Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFpIpFh17MCM6yR638EN4MqYwKrC8TgHyu0Bm7qFAha/btJUXQ
	6cb8j+8yqqn/ptPla+PHVq3mAtYPvyMJnrCl9DO8coPv/rB95TWXFaIl8NmOsxIS49IgOFnU1sm
	z6D3oBbOhADleRn2xdtKAp4s1sv4zu1l4tqKW9rPjLCFQZwz0nKGSfd//T0wYvbkdHqk3JFdXim
	2ALiJfIPpciITBoJtpB3fTsR9FNbNM6bcHSBWec+7np7EAVidKyaPIcT0plvKyEUVWvmzNTVbO4
	O0yY2DOn/ajTXc4ig==
X-Gm-Gg: AfdE7ckzkSlkLPZWZ5Rtr3MK5V60XMgRTG5usmGOopmXDdT/MnBmzsE9K0kT2PFiTZC
	HXzoltmeAcGEuPZiBpyUfQ+dgxJcTQBhm163+fVSgoz/Ff4DoMJMuKtr8MNh2zSZHN3I1kFx+Qa
	jpeNY5c0TAl4j+ijUgO/xC7BGNnwnnEnjnMqeXptcH2rjAhs5JnswexEWuJq+jhvlgL0V/o8vqa
	R0uNd8qMWaBYIhSLVhThVLFgaaeTt4MhvGxfiGBJnAricjzNJhh25sb3GqiR96I2Arr84SqDxV2
	GZevx5oa0qi7yX1MGFRq9qYwFVw0pYMWgivG2vHmvFY+PF2NkcGFr8wVRzKtMEb2hgPZtOjPLG2
	KIuSV8lnCfKRhC/t0U44stONZO1weKeNF2c3Kgw75Pc0RBysEOT0j9vKzFLWRETlu5Mz0s5zA3p
	nh2LD6WloYjMUrbVLQeD9AuproxdppYWFtt2BKp9npDzzn4f9k+g==
X-Received: by 2002:a17:902:e54c:b0:2c0:c262:b924 with SMTP id d9443c01a7336-2c6de6322admr29358345ad.13.1781773428962;
        Thu, 18 Jun 2026 02:03:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c4301998ffsm16590025ad.18.2026.06.18.02.03.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:03:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51956be1f44so33616121cf.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781773428; x=1782378228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QpNixvCXNM3odqaYWueSGP2Z43EAIlNiUuWGIkEd9i8=;
        b=Dr/Ydqrnwbh4TDAFnHL3FK7c9/Rv/ES8ODcuQahihVpAlAZWYGJb3gyzyybRI8NjpO
         YBBOLM/1Gt6yBlv/pDpl6C8fnEnql4CCMW5USxOQU4nFITglkckgSy3hqJkJscqf7MYj
         rlnjuWlh4EKQsZ6SmByMvOUMijYrOV5j4x3YQ=
X-Forwarded-Encrypted: i=1; AFNElJ8664WjveidVsWtd3ADGTAWnnz1+eD5skygmjLAjPKUbVhAtU16Wby7Cv9aGxwBl6hQfAk4QJU=@vger.kernel.org
X-Received: by 2002:a05:622a:22a4:b0:517:5ed7:d28f with SMTP id d75a77b69052e-519c4de0e85mr37505881cf.25.1781773427869;
        Thu, 18 Jun 2026 02:03:47 -0700 (PDT)
X-Received: by 2002:a05:622a:22a4:b0:517:5ed7:d28f with SMTP id d75a77b69052e-519c4de0e85mr37505371cf.25.1781773427211;
        Thu, 18 Jun 2026 02:03:47 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61eaf4sm191285561cf.4.2026.06.18.02.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:03:46 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Yiming Qian <yimingqian591@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.6-v6.1] netfilter: nf_tables: always walk all pending catchall elements
Date: Thu, 18 Jun 2026 01:34:38 -0700
Message-Id: <20260618083438.1269242-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300366-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,broadcom.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:vamsi-krishna.brahmajosyula@broadcom.com,m:yin.ding@broadcom.com,m:tapas.kundu@broadcom.com,m:yimingqian591@gmail.com,m:sashal@kernel.org,m:shivani.agarwal@broadcom.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,strlen.de:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7E9169EAFE

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 7cb9a23d7ae40a702577d3d8bacb7026f04ac2a9 ]

During transaction processing we might have more than one catchall element:
1 live catchall element and 1 pending element that is coming as part of the
new batch.

If the map holding the catchall elements is also going away, its
required to toggle all catchall elements and not just the first viable
candidate.

Otherwise, we get:
 WARNING: ./include/net/netfilter/nf_tables.h:1281 at nft_data_release+0xb7/0xe0 [nf_tables], CPU#2: nft/1404
 RIP: 0010:nft_data_release+0xb7/0xe0 [nf_tables]
 [..]
 __nft_set_elem_destroy+0x106/0x380 [nf_tables]
 nf_tables_abort_release+0x348/0x8d0 [nf_tables]
 nf_tables_abort+0xcf2/0x3ac0 [nf_tables]
 nfnetlink_rcv_batch+0x9c9/0x20e0 [..]

Fixes: 628bd3e49cba ("netfilter: nf_tables: drop map element references from preparation phase")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Shivani: Modified to apply on v6.6.y-v6.1.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 net/netfilter/nf_tables_api.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 196ac4e76..0581f6479 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -620,7 +620,6 @@ static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
 
 		elem.priv = catchall->elem;
 		nft_setelem_data_deactivate(ctx->net, set, &elem);
-		break;
 	}
 }
 
@@ -5241,7 +5240,6 @@ static void nft_map_catchall_activate(const struct nft_ctx *ctx,
 
 		elem.priv = catchall->elem;
 		nft_setelem_data_activate(ctx->net, set, &elem);
-		break;
 	}
 }
 
-- 
2.53.0


