Return-Path: <netdev+bounces-282247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GTfA7+q8WkAjgEAu9opvQ
	(envelope-from <netdev+bounces-282247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:52:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0AE48FFE6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B44A130465C1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F2D39C01E;
	Wed, 29 Apr 2026 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R42QwDmt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5839BFE6
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445515; cv=none; b=cH0tbgf678GD8Boy7VQoDV3guyaTbg+uDFv9QLwsm2+U3oZ5dTJRAya4v1+ryWFH4PIxPArKHQnJL8RuY1HbNi4qOHCX2Nn9dkYEYA433u1VthZpZrUtMZHChGVO3bNOcNf4rn7Csun/D/Cn0A8BNAYrp3nGdqyPPsb6U7HWiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445515; c=relaxed/simple;
	bh=BAj0cdmJ8G90qi6/WC53cGjLgnpwZKQOsLaIfNaj8rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkZoRpuYiqWsmiM4knMCDSsh0nX1jnDD7Q6Hnddcrt6wqD5Pbqjp0d9gb2dIxr9WcjJUM3tRgzcHD1YWrD+SfKlfCesNhVJ6RIrD8i/SVoHGvxf1jNx1YEnRZ2gBrJpu8JFnZFXItG3l0KMEG07mDN4YaopONDEG1ZEtIiwq7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=R42QwDmt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b7adb38d65so58986625ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1777445514; x=1778050314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUnzqF1b0jZfPUvpn/ylBvB7W/64BC9cpo6hVx+ffvE=;
        b=R42QwDmtN4BfzkMIYuty+i8f32izmH4RZw9pCwU1DTQp6zzHG+zlOSeOrV9yNNCF56
         9ycVKumQ6L8kVpEDNtgmzdRD12XVBG+ULhQbytVHdFqbA2kaXSzBv7lbhBvTl46DjdZi
         SVob1gsBSJFfkyntQpRiYz8u1nTVmmlpQ/n0andKSIcE8m/93uMUlIlJasp8Ye31ar1e
         RiydRxtj+oNhrTmoHKbGjOAoH/p8E+pwn3rN/Kta8J4WkabS/TTlGkEhRma5hzld8Jn+
         dsKP3IWSwPFY2NhHpkuFuxf9LTx5auZdbAbBqwZKnjGmcRZTVQBPFBZrNadDYvkxBO1K
         44AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445514; x=1778050314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUnzqF1b0jZfPUvpn/ylBvB7W/64BC9cpo6hVx+ffvE=;
        b=h/i/zwsLIhcX0fONwkuY79uq09qnIJ/S1rDa2jeZp6Jk4nk77E6VvbFvCgjUTSQo0F
         OpCqyVjg9SqsxMMNBfpfZpW6MuyGo4egbsltyDrYrDGU5HgU62pKU80dnwyexsTBd0lx
         9keAPklpdcfXEnAqpbW2RAg2/T19HYWTvr+D247emP45uCXIy6Sc6nzDe9B9jkm61Lko
         P1HEqsU1ypV5AyN8+RUDcvnehuiOzTIH+K81chDM04kUgoEjDA0Fb1sgwOWXaExwP157
         lsvTK2jJ9hB1ypzX0O8Fy3pZhXdTCrXPbaVuifR+J9GpHc3b5QyqKKK+kke/JY4zMk7u
         LtUA==
X-Forwarded-Encrypted: i=1; AFNElJ+i96Ky9HJt3tJFx4krKc2VUV68Y4YJTE9wZ5j3BhOrcNjZXsb3K8fyJ5IIwo3GIKxE7XwNoZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ULddsImeAoZw5RaUnqdcPT0IJyaCG2/IgyDmhiCNh91eZ9IU
	/u+EICCBSAMVEoY+OWlKt6cUngZeo75mJigc18d77zpounMV4Lux1kBoHt+0WJBH4Oc=
X-Gm-Gg: AeBDiet4J5MBmhxd0l7S3442fBU0VycTIkSeG0iE/PosPLhvQrJYoWM6LB4avUWkYX7
	U8gEbEePsqcNoiMYCFmHBgF2sIS+yXk+CAp/RPy2no+VSftqcILQGoUYenZsceF20drp7onb5SZ
	Y2siEdXWoNNlchSIhwLN6kTF8fjIqt1N7375Kq2vz/UeLGgk8iD5AaKVpkBkLYC8XLUeSQ54s2C
	LG+fIXJJ3O/ZTtszO5Hbjkzhkm1MtFb9qly7ry2KfMjVLKzth6+x3A0jIzV9YlkOt0y4wgHKDuX
	oR7TNVLo7E1+rjiBPM/37JorQiNHXxxNnBKkSun/ozDus17riHtYOGO7C0ebE4jCV70JOwndPeC
	i7LMOjwpw0dDgdwKNGA0JqKVZJSH4bM4+werVQcBTD8d/zyRwO/6oHwnD0EQunluN02EDxN+tJ4
	QXEil0T3ytQvO99ZlWoBd387WRAQ6orfNrVa8ly166hSUFoH/nyjmVqUuckhRyG1dFH7m8pSlcZ
	zevL7yxuwIyCr0Y
X-Received: by 2002:a17:902:cec6:b0:2b4:5a2e:98d9 with SMTP id d9443c01a7336-2b97c49a59amr73951545ad.37.1777445513745;
        Tue, 28 Apr 2026 23:51:53 -0700 (PDT)
Received: from Vincent-X1Extreme-TW.internal.sifive.com ([136.226.240.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98895afaesm15038105ad.57.2026.04.28.23.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:51:53 -0700 (PDT)
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
Subject: [PATCH 2/2] ice: remove redundant switchdev check in ice_eswitch_attach_vf()
Date: Wed, 29 Apr 2026 14:51:27 +0800
Message-Id: <20260429065127.423949-3-vincent.chen@sifive.com>
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
X-Rspamd-Queue-Id: 5A0AE48FFE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282247-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sifive.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.chen@sifive.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sifive.com:email,sifive.com:dkim,sifive.com:mid]

All callers of ice_eswitch_attach_vf() check the switchdev mode before
calling the function, the internal switchdev mode check in
ice_eswitch_attach_vf() is redundant. Remove this check to align with
the design pattern used for ice_eswitch_attach_sf(), where the caller is
responsible for checking switchdev mode before attachment.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f..c709decb26d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -512,9 +512,6 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 	struct ice_repr *repr;
 	int err;
 
-	if (!ice_is_eswitch_mode_switchdev(pf))
-		return 0;
-
 	repr = ice_repr_create_vf(vf);
 	if (IS_ERR(repr))
 		return PTR_ERR(repr);
-- 
2.34.1


