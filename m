Return-Path: <netdev+bounces-144202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1C9C6065
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F132CBE3E66
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5C21767F;
	Tue, 12 Nov 2024 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hs3FhlgG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D8217452
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435252; cv=none; b=dBuA+9CZSzz2jwsXF70WSKbCwI2EHEz+68qUePyDrFz4Oq0ssIBrpa1k4PnTUHCaqmCUyz8Z4xpMOFGBw/1GNKliBeqBLMsvsXErVijWSNadNREzC32XvWxrs/IwtpyAQnxybNx2FDz7B7KyRXJOBAnl4+PU0CMw1/GFAuZVhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435252; c=relaxed/simple;
	bh=KJNA/HS/V38dOF0HjcnnPpMye9DKRg+GfJ9vo58ukxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FINVYE4irSoU3+Z2JbenEkWW31W/TkKpvandjvGJ14nl1dZ6iHt5OTgrXt135i6VWCHAWLhOQ9QwfApNA4DE2fdflhlpI3Hps7GlQAuaq2q8csCqoelQZB42EtiJt1u3oxFlQPS/8a2c1VbP48foDZied6/Lq30KhZxJtb4vQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hs3FhlgG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20caea61132so52061425ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731435250; x=1732040050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEA1osGcew3Hs+zbGBeYbe5Wrb34ypC2zAINbLjOcIk=;
        b=hs3FhlgGLcS+8ML2Tqcv88TmooIxprDtiPXewcmL+h6RYJVRSx6HGtUIS8seugYCHN
         10MMPMp7y+S7r6G7C8pjbMI+ZZPBRJv3JDI9JuNObMS+AOeVi9zr9VxHUOPAJaU/s7PS
         gQAyKaUurSjJrLNf7MW+ikBoOauT1NVSUYcDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435250; x=1732040050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEA1osGcew3Hs+zbGBeYbe5Wrb34ypC2zAINbLjOcIk=;
        b=YwT77nBctAb6sClI0S4zlSwy+AsZ7he5pNOh2GseYCkRjcbBC9NEZoWG529x7huBLX
         WjfmD5hAK9aInYsWarByvURAjf+RhlXuxeuLHWjyHi6PMLI4LIbmTyF/mEsQm4BiAWm0
         rqPfhMtupaA6OPVf7+fkOgv1JxWxPw/JkoEtqRQdP18Nd6jSA20qiloYu6EbNEuBBkB2
         jrF9vG9FLW2yH7q4IWdhOj1FUqmL7dYJVSR10mifvGaCozsyQIkSRR+XgTC1xTekrCxp
         J9HQUcl7zSmeXKWF2lmomTmOj5bJ3nXcLEMt0yTTtgIOaS05VXXZoKOQ7uy90TxZaJqc
         CmLw==
X-Gm-Message-State: AOJu0Yx6wCljRtM2J4P35dYW9prPHk+VG3ahuYpImA7R97XgCr8iO7wk
	Y5lvfVmqG9JWG3CnUaHTbN+/wbtOobKtsO/PvjhmYlqnW6kCDo0nmK5sgPfUVXZ7pqWoWhZhsld
	YdWsmCvavh2xxvEHzW8siNUUCnqEuYceFglQiRul37LWUUuck6/6+F5bvxtKfxXwts3ihU0+C3w
	Bcl1zugrckIsEK7x5aW5D79WidxfnWOrS0hZY=
X-Google-Smtp-Source: AGHT+IEAnGQva3AzMqzJIs+veptFvSaLDO+4Otmy0KyHaoebB8btAc6NalxMdu3A253C7i70rlM1zw==
X-Received: by 2002:a17:902:ce0c:b0:20b:4875:2c51 with SMTP id d9443c01a7336-2118352a6damr243041825ad.27.1731435249956;
        Tue, 12 Nov 2024 10:14:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a388sm96639035ad.245.2024.11.12.10.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:14:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net 2/2] netdev-genl: Hold rcu_read_lock in napi_set
Date: Tue, 12 Nov 2024 18:13:59 +0000
Message-Id: <20241112181401.9689-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241112181401.9689-1-jdamato@fastly.com>
References: <20241112181401.9689-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold rcu_read_lock during netdev_nl_napi_set_doit, which calls
napi_by_id and requires rcu_read_lock to be held.

Add a helper function which calls napi_by_id and sets the error code and
extack. It is used by this commit and the next commit to reduce code
duplication.

Closes: https://lore.kernel.org/netdev/719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com/
Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/core/netdev-genl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 934c63a93524..2a04270e9d2d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -361,15 +361,13 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
 
 	rtnl_lock();
+	rcu_read_lock();
 
-	napi = napi_by_id(napi_id);
-	if (napi) {
+	napi = __do_napi_by_id(napi_id, info, &err);
+	if (!err)
 		err = netdev_nl_napi_set_config(napi, info);
-	} else {
-		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
-		err = -ENOENT;
-	}
 
+	rcu_read_unlock();
 	rtnl_unlock();
 
 	return err;
-- 
2.25.1


