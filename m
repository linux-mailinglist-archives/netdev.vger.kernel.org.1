Return-Path: <netdev+bounces-282245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAVkLoqq8WkAjgEAu9opvQ
	(envelope-from <netdev+bounces-282245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:51:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 514E548FFB2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96BE23003D10
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD639B95D;
	Wed, 29 Apr 2026 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FR9CQHAW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8B3803D3
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445512; cv=none; b=W3eFhhx9bRrfTSyuAU2IvG5qScz/bMKWxaVXyA14YXqJFOo89ks0bRLKYZj3GcucgBBcJRNUGDIo3kVA1q/amrGzQlHP3PAKGFTvMxxzx4WxavRYKKzK9kT9WwRDSgkSqBgxg+mRFQXw7vlMfWNkW+DB7xi7gp904X5SZdHnJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445512; c=relaxed/simple;
	bh=2KVzJDW98C1opC/+q5S2P5LsDTckws3OaCSMoRuOgIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcxXRAA7x9QM9iLGofiLi9EdpJFYPJsuDWjtexLfqgTTTnqtmV7ID7zJF6hgQsEXqsSfmA2mEXH244/aknDy+THWL3wAlZIkHBm4mC3mIInzAnJePJqID79EW+5+C52UDCA+ra4tA3DLNQ1+SDEcFkU2OQrJYZ36VIzEBjEVPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FR9CQHAW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad21f437eeso3998625ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1777445511; x=1778050311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJR0wUneST2OobSctcgeuLs6bttBTQJPSlbTZVLMlC8=;
        b=FR9CQHAWJDZZ73KQVsu+az51WYlsJviJZ4k07UfLgW9Cwk13giJgH4H8Bq2QfVdx8E
         xUQ9pD+e186ssYdN84vCCyuhk1BHY4IPL0MDqX9yPuiiLaDm85mk5TqMVjnuO8p/yfZh
         mgvDcDYkyS3L0vdiEkfMYeMOj2Lm4Mv8OdAcORv4Xe/+H1+fbTIIooVDZvKFly2wMFNM
         kDmqSdUUTAQ7Vv2NQ5DLPsxjpFkN/Ai58EYIYs7K49BuIZINALVaZZydHIBO3Yq6E79g
         HVFcZKmUq2RGbpdXBckWm44LQa/OQYeHH9YaerUPLQrTrlxHdY1sP7PFcqjdUYwmnGTV
         16pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445511; x=1778050311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJR0wUneST2OobSctcgeuLs6bttBTQJPSlbTZVLMlC8=;
        b=btb9HTlfUXdKCTcK0NKnWI/zIGvif21uTWM5+Buyoh3jym4HG4XdT6jdKeyRZM0wtd
         GX0mmVtMySr+m9vVyg2hVkvlEb0WOPgGj8+eTpGnBCtK8mabWmPlww4JyQDZefn2TuIY
         2jwQYz109tIWpAm8XHXYE+OMcmCfc0zWOPwxsmZ8XYqZdXf7gxHc3C574fhQ5r6odSr1
         3dL5FNEACjPHFAPinKYBIHpT9lU0KwMsYZmaNvXZ3Za/PnsOkwl5vur/inQ/RU9z9c7O
         C8S/xT02m0DjvQdry/oaB6Oox18vBYol1ef6qkbpvnqg4Bsl3SX4zkmTkTbpOF75QZ0G
         N+Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/Oq0jAqE2Kzk2CTqN4DHOxNMBdsikVDoSr0RgmrO6WdOSkbxQKvvobVlcgnpwE4NL9aCuCE5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNcsb77+ukFlm7Ga++bIVw9l6jj/DxtNvbJ2hk2A+AEkJgRHR4
	ZxSfCdJc/8NvNP14EzJ7xUcmZRuxp1nBn49Hbyn/mqqZnmjFSTRqmKKbD+e2zWkTFoY=
X-Gm-Gg: AeBDietqzBPoGWorxrbWiCXFrMGkvbqakM0GAiiU+gJE08WkqmIfAQ6HSV2wZTEsL6Q
	RYktuAsD9siZZQDHXfhgmaw5HVUNuIU6QzNER4WrLEnJSkDpuYUw0ZBH/3lxh3m3Hy/AhN+q/YM
	jc1M83Gv5bAHDFAmlmbFSyB3cUEFD3Yh5YfNyF3H8GM3dM2WUMonMZx8rxTwS0SD83zUAE85pR/
	0cpZxQgSyFRTKMkbw3BKtjwj7ALmaCWmTqCmKGJC/zjxXGPyQ7tWquitXGD0hDvmUU2WuLC9+Cp
	4zSABYTyLcxSoCaA4gxUmcmMrGCfUxwMMWVOvyUuXRnNCUy2PFiFY6C0j/74UPNPmBIqxZx3R24
	wwNE/yWwEGLzqSZ3DjkyCjIdiujkOx8jYCUoEe4j7mhHAi7XBYqsFAaTLby4DVwpgpkmxA0ymC6
	JL//v6Njoqb/AC8o+DHex9mffkSM1151XwiNWklObarGAlB0Dl51oT0tnbjBG+xF+RcW4GHMWzH
	7DohA==
X-Received: by 2002:a17:902:f652:b0:2b2:53f5:461f with SMTP id d9443c01a7336-2b98825bdb5mr18430485ad.25.1777445510644;
        Tue, 28 Apr 2026 23:51:50 -0700 (PDT)
Received: from Vincent-X1Extreme-TW.internal.sifive.com ([136.226.240.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98895afaesm15038105ad.57.2026.04.28.23.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:51:50 -0700 (PDT)
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
Subject: [PATCH 1/2] ice: allow creating VFs when !CONFIG_ICE_SWITCHDEV
Date: Wed, 29 Apr 2026 14:51:26 +0800
Message-Id: <20260429065127.423949-2-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429065127.423949-1-vincent.chen@sifive.com>
References: <20260429065127.423949-1-vincent.chen@sifive.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 514E548FFB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[sifive.com:+];
	TAGGED_FROM(0.00)[bounces-282245-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.chen@sifive.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sifive.com:email,sifive.com:dkim,sifive.com:mid]

Currently ice_eswitch_attach_vf() is called unconditionally in
ice_start_vfs(), which causes VF creation to fail when CONFIG_ICE_SWITCHDEV
is not defined.

Fix this by adding switchdev mode checks at the call sites before
calling ice_eswitch_attach_vf(), consistent with how
ice_eswitch_attach_sf() is already handled in ice_devlink_port_new().
This is similar to commit aacca7a83b97 ("ice: allow creating VFs for
!CONFIG_NET_SWITCHDEV") which fixed the same issue for the previous
ice_eswitch_configure() API.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c  | 14 ++++++++------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 843e82fd3bf9..6a0b724e46f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -484,12 +484,14 @@ static int ice_start_vfs(struct ice_pf *pf)
 			goto teardown;
 		}
 
-		retval = ice_eswitch_attach_vf(pf, vf);
-		if (retval) {
-			dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
-				vf->vf_id, retval);
-			ice_vf_vsi_release(vf);
-			goto teardown;
+		if (ice_is_eswitch_mode_switchdev(pf)) {
+			retval = ice_eswitch_attach_vf(pf, vf);
+			if (retval) {
+				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
+					vf->vf_id, retval);
+				ice_vf_vsi_release(vf);
+				goto teardown;
+			}
 		}
 
 		set_bit(ICE_VF_STATE_INIT, vf->vf_states);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index de9e81ccee66..71595410174c 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -807,7 +807,8 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		ice_vf_rebuild_vsi(vf);
 		ice_vf_post_vsi_rebuild(vf);
 
-		ice_eswitch_attach_vf(pf, vf);
+		if (ice_is_eswitch_mode_switchdev(pf))
+			ice_eswitch_attach_vf(pf, vf);
 
 		mutex_unlock(&vf->cfg_lock);
 	}
-- 
2.34.1


