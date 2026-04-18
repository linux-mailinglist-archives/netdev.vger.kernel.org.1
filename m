Return-Path: <netdev+bounces-279448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKEqGB3u4mlLAQEAu9opvQ
	(envelope-from <netdev+bounces-279448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:36:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F0541FB1D
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A96963018C2B
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F22C3259;
	Sat, 18 Apr 2026 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U9fLSatL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5526056C
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776479692; cv=none; b=WHewWLTCUfkmctIStsHvyio+EbG7mAhxTiK/bbPBhd1egybCy2ITHyjadAf7+D1qGHCzjCO7ugBFHTVszkv9rMel8dL13jIuMVsZlr0kjB9lw1LiAx5G3rVUX27SiDnWDIS+NBZVNHsEBHTqwMIayozNXhHcq5NxxtPgLo/cjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776479692; c=relaxed/simple;
	bh=kDXsxeNKiEEQNs/OfT/AW9W1/NpXdP+bhO6RDjpfseQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzbtTrpQ9E8sMCgKej1BkR/qAGGp8mSSUaWKowF+JtSUm90yp3XBAtS9x1qNbKffvk/oVPKGNm8Q8UlohM2HoRqq19QDdyu+sxVBXA0chUU1cJFvxk+fxAgPkVSCpN5rgrRZ2ZlThX82M4DfX3P2t3apInHbIY3bchl/mTHSuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U9fLSatL; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-652fcd5a6d7so1755846d50.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776479690; x=1777084490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tePCcQ4//A5gm4gf0LFviYsHlnWZ1evZmw/Ul79JIk=;
        b=ntATIk9wiQ2vIufonFpDPjlrbbmrIXEM4a830Bt2XDYB5QPSeKhn7bxMwVh3GGhPmD
         v1l4QwpYpiQI87mSqua7em+x1LJSIhSWILVpNrrVcA7SXXaUDyI7e4mvLbj14+KzfFFn
         kht37Kvx+irvsSAhB+3+r5/jvtCsz6o21pWt/ZkfKO0XPsZn9htdX1j9ujxx33AmjOAK
         3mWx4DmuPR4dYJjjzrCrG27Gc3Gq6bztky84jI/CENS8+h24b9++T7htYlbIMtRHkU55
         B5HGa4VL2ZfJE+XcZKQITYK+xCqMaq9c91vO/g4w+p479yuOwJ6yiJEmcuXwC6n00ljq
         ObgQ==
X-Gm-Message-State: AOJu0Yz4XqAFoKtcaJsG9f4OaQi6mwgbQPqj4YZp34ZAnQw7u6fg6M4Y
	7SADQVtGG2SHBqbnuXTrZkeLabqV7WPFkNdu3bE7Ac4vFa2smVxcJ8Qad2Tzyo4Mm/SNlpLEJyQ
	8Ld3GEk1Z7SpMjWxOA88amadFejs1/FvFwy1baNqLTiCHXSOVJbCeToDYhk7bwPzpDqaYfFNRu2
	ct/wYtEN1/qmck9ZDPwk3yS+yk6pkjDjMVUqM2ssjw7AN/Vg88dNk9I9dtH4h7pDNbmyvE37SIX
	LF6xL5p5g==
X-Gm-Gg: AeBDietLIKfgGgBt2s9ZRePvrXKtQHxM1oh8dgEvFRgGctLIxfqxd4DofrCIn5fbjs+
	NACMnziZS28VfedQm2V8oJRZALrn6aq5kppGRxFNGPgEAp8oz+odQxUSwwq3z3Atryc44AtwRO8
	jSayJtDgWfH2PJWogsGA8SURJcqtEk+bufeerPhoK1XR7i2pu/FVEsIAE6DyV0BFQxF6SQWXLEL
	86k+rVqTyT8owpOBpIFmnO1eMizQ6QtIAo274zrZRrx1XM/qC6KHBJu2+91ZszVE4AyjM51oLnV
	vE6JFRP2KEzxh/IHyVVyvHS/mpmIgSn/ga6yN64GSa3y5JZljSLNnjFmK9vstwEQAkvjQIZaRP0
	YhQ+BnFuD+5l+08aC1ytLGYfIqiRgpKakiU0iNhPd1gSjYMcjL/bJe63l+/v817v2Rl6wKnvbJA
	e5g7pT5e8FloIgDUgg3qxYm+nMNRngSvdDDQf0BwiIxThiSl/THeqyN2Jau23kKEOqFg==
X-Received: by 2002:a05:690c:e04f:b0:799:3a3:2f25 with SMTP id 00721157ae682-7b9ecfda739mr43754417b3.38.1776479689946;
        Fri, 17 Apr 2026 19:34:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7b9ee78c861sm2547167b3.0.2026.04.17.19.34.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2026 19:34:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b249541063so11173305ad.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776479689; x=1777084489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7tePCcQ4//A5gm4gf0LFviYsHlnWZ1evZmw/Ul79JIk=;
        b=U9fLSatLSOryokL8NmmVXDexj0t4B6sbZMaK5WllFK/KzsY/ZLUiy6PbATiCKrGRQj
         /JtF2RJiJpirI2mkZUsihfrbOXnTGH5QqXZJCWmB8k2b556YD5XO4UNWf3ziX+DzKBqW
         IgrFy2rhZJnZNkF+axzOQw8DfuMewWCsNgWpA=
X-Received: by 2002:a17:903:3c43:b0:2ae:6259:5aff with SMTP id d9443c01a7336-2b5f9e77400mr56341585ad.6.1776479688633;
        Fri, 17 Apr 2026 19:34:48 -0700 (PDT)
X-Received: by 2002:a17:903:3c43:b0:2ae:6259:5aff with SMTP id d9443c01a7336-2b5f9e77400mr56341305ad.6.1776479688232;
        Fri, 17 Apr 2026 19:34:48 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm33427715ad.20.2026.04.17.19.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 19:34:47 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	bhargava.marreddy@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net v3 0/2] bnge fixes 
Date: Sat, 18 Apr 2026 08:04:36 +0530
Message-ID: <20260418023438.1597876-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279448-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C5F0541FB1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
 This series fix two issues.

Patch-1: 
    Due to wrong HWRM sequence, driver do not get the correct
    information regarding resources and capabilities.
    The patch fixes the initial HWRM sequence.
Patch-2:
    Remove the unsupported backing store type initialization, which is
    not supported in Thor Ultra devices.

Thanks,
Vikas

v2->v3:
  Addressed Jakub Kicinski's comments.
https://lore.kernel.org/netdev/CAHLZf_uARgZzoTPnnPjxRu5AGeHEOw3yyTEbNHYP3brfwuW0Sw@mail.gmail.com/

v1->v2: 
   Include Fixes tags.


Vikas Gupta (2):
  bnge: fix initial HWRM sequence
  bnge: remove unsupported backing store type

 .../net/ethernet/broadcom/bnge/bnge_core.c    | 30 ++++++++++++++-----
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 16 ----------
 2 files changed, 22 insertions(+), 24 deletions(-)

-- 
2.47.1


