Return-Path: <netdev+bounces-285064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDbyJ+nD+2keEgAAu9opvQ
	(envelope-from <netdev+bounces-285064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:42:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8E94E1547
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35D42300F78F
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BFC36EA9F;
	Wed,  6 May 2026 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="F7eQkP/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834836BCDA
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107328; cv=none; b=vAtvhkcraWawUUPNy5PpcNS9M9eiMYUsHGrxIeNCpxsl+ssmxhAQX3MlRzsGORYRLu/SY3ENBL5TvyZ5Y+Lvf8j1D3HSfstdxHixfMAol5n/sM+svB0wn8f/U33ks4U5QnHAfLfDRh2UB1Ftes9ugMdFdVlX9o86fT4RxAIKoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107328; c=relaxed/simple;
	bh=w7cRobtLVG64nO7OrIOLfzd9Sc3mLub7YmEZgH17sXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/A/Z+qOa0AIcHVVGpIO1pD/OBPN07ud//HltnJwtN/B8rdtFbDIC6hRAloktKzPcqYY5o8mRrpJZGkhP7i6LlzswQ7s/Ymy4aFg77o2Hhz4bWpxtcoUKedAgf3rEWaf4kN6iELDWsthTJBQLdQCjub65L7P3cL8eeSsRqTUGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=F7eQkP/+; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba895adfeaso251793eec.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778107324; x=1778712124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/rBu0tYuQwihUJHe0i1kYkc69adHjv66QFbm/3O1Vxo=;
        b=F7eQkP/+OsT1WZu2dr8ZGhKTBbxo2xFaVydtp1GIlKky2cI0ecYdWoK7z0DHMHGCxN
         mwJNqwTwBSvtv4F73XLAjfhDrF/Rxj31qBC8K2gP4dMbluIq6NWSKZZdIuacBvvdARDW
         G2i8Lh2S53xAKtzNkOUJwaE2u0rIi2sXfAuI6iIPCo7SfkNnpxGh4AmNcnwlXDba4Zvr
         8rxL/3tIGEDjjbVAMIysrh6ZEh9Y4Ig/DsiRipLrxFBc7AC6+Exhdzztibu0gmpjb6P/
         dHACZHHLMHxTi/2srIltC6cpESY47qO9M1GJK0l/Utv8sx2uAzHV7iZ94Lv4muX85Q8C
         Hj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778107324; x=1778712124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rBu0tYuQwihUJHe0i1kYkc69adHjv66QFbm/3O1Vxo=;
        b=pyFKKu0RN6ipGy3M/4wceUO8Rs9AMSjoyp+xLV3UmpPBUFLEvhpiGFUu7AEurzu3qg
         9PS+UbXc/UMwxHWJUg2mp/BnsUymZ8MmgdSY3Aap58XlunwmB//lHciM55c2CFS/jlNQ
         lm8n+xU7+xt+Rxkb2LnC+odVj5m5tZkNtmzHievJd7+614PrDINEHPcSPKnsplEU54Wt
         iKhsBhm9tIOPSAG2HZTtrIR1Is3vAhJVacy8/DQok54wAwj6icNRA9cb8yA6uO2kR5l+
         Z7cWMJFZvtTQFCo5vqHH2NYNOJqEq3ocwvr8S+9g7Ce9BhiE500bgxvT2K2M8TLIk6Eu
         oc/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OAfYhDtShQzQP4LG4reZ0rZHAoBJIwnVT07FZ60t1tZGjCEp6dz6DwUhZCvfBh9xm2tCYE6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy360j6Dvev5xivUz/vbMX9qmpRuEobwL9CZlr4JnC1Vwn95lyr
	TYysmuNJ0DdH7uhNI+Vd90gkRg7RWQZRs/WJIamti9LBdRGG+E3JnUtLvalyA4HGd3k=
X-Gm-Gg: AeBDietONk9TVtNj+p1cj/0nPIk8z1yYGMcc5Nb1BRkA6hoxXI7tAD94P7/KrG+np2V
	lEZtEnvv3P1GkESuthV0f7YxS+cFBr4apYVCFwI5F3biy7nJ1wK7RP9h6ervwx8i26izBeUx8BX
	S+6mDwSua7j54YxqEgEV1U7yRQVFXfige7Nlp9FG4DLJ2Gyc90Khz8hTt5wLLcaF/smeAf49p/c
	ToSMfQklONTjiG7ANWV7/XAjngHNucNc+M+HN1MBRN3vnul9Mfx/9EKEN+6VngPSJMsBAtAMy+x
	CQCGsyD2U/+VIsmpedIkLlTj0WzxSh0MuPL3u0ywL1fua/KkepHxq4zM0HIq7BkS8PEJZozVfBY
	zynWgque78IAAdCTCgogQyuz8ELLx+HCAoI6yymjlUjAkEue8wO4QQuLxjrVnYX8S1eqaCi/691
	ILsSX2EyfcauEZp7ugDvjnqGRxMBuzH7eKEVeFshAk3Frpu4UWaDumxdZ+2mJU/wLbV8pb
X-Received: by 2002:a05:7300:a987:b0:2df:c5bb:3720 with SMTP id 5a478bee46e88-2f54c587faemr2885736eec.15.1778107323983;
        Wed, 06 May 2026 15:42:03 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2f57038c644sm6008472eec.29.2026.05.06.15.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:42:03 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i40e: Fix i40e_debug() to use struct i40e_hw argument
Date: Wed,  6 May 2026 15:41:23 -0700
Message-ID: <20260506224123.691160-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC8E94E1547
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285064-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[mkhalfella@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mpg.de:email,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Action: no action

i40e_debug() macro takes struct i40e_hw *h as first argument. But the
macro body uses hw instead of h. This has been working so far because hw
happens to be the name of the variable in the context where the macro is
expanded. Fix the macro to use the passed argument.

Fixes: 5dfd37c37a44 ("i40e: Split i40e_osdep.h")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/net/ethernet/intel/i40e/i40e_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h b/drivers/net/ethernet/intel/i40e/i40e_debug.h
index e9871dfb32bd4..01fd70db90866 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debug.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
@@ -42,7 +42,7 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 #define i40e_debug(h, m, s, ...)				\
 do {								\
 	if (((m) & (h)->debug_mask))				\
-		dev_info(i40e_hw_to_dev(hw), s, ##__VA_ARGS__);	\
+		dev_info(i40e_hw_to_dev(h), s, ##__VA_ARGS__);	\
 } while (0)
 
 #endif /* _I40E_DEBUG_H_ */
-- 
2.53.0


