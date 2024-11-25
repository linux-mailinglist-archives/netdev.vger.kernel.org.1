Return-Path: <netdev+bounces-147271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A99D8DA3
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 21:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A161699CF
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 20:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4ED18130D;
	Mon, 25 Nov 2024 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DozZRfbr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0431552FC
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732568215; cv=none; b=ks8bKTW47tzI6jWmTiUzaBKZ89wqxY0WbZ/Nf5ne4poCBS6aHgLcamQGNggK2uvX+L8aJ1T8xYJg9T5LQn5j15Vm8l276BmNihyYY9QNRuT12DtBa4dzaor9Ao7nnN89dcsOsg7yzyy9K3aIedkPjTW/UESxAiFPy6UgbtBIgTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732568215; c=relaxed/simple;
	bh=/hsEjcK09GCipmp+jR2+xhUvheP3LVttjRjEftq/SVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ix5IxdfpndaeONLihSLJ935pv1cmC8IpDVtBuJdLerm1H5G7Q3REncRqBEhaVRAgbWRWuXwlLv982IaPI3KpW0Gwg68aKFiUV8SeZRbJkZaUiVLVzt7TyS8GNU27s+Q1aJ3wUJ/mV65sAoarw/AK4kx69dScUU9jPzVUExIA8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DozZRfbr; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-84386a6669bso14405739f.3
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 12:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732568213; x=1733173013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbxw1A0k5fe+ASi6rShndrrNduDYVaxs7kGjhs/QnDU=;
        b=DozZRfbr51rPoMLJOTfEL8CCFFHR4ZHchq45syLwWjnjQhc+kNyPQZR8y1PTY7ymvT
         zDkyK02CWJHWtwdbIImQRLdHe3XDfm/rjBgQkV7E7N6p3NuqSQRiOsytaQ0MEn6spTHM
         1v0WqivvyzJz3CDOcBXLFjNce2We0yy8x7Pz6gOu/6tbuybHZWNTY2V++vhcHCyWi4bo
         6mmg4rNVCul5qE046xo1DkWGqypK6dhq+bDiqRZCHdNw9mPyAvNV5anQ18QtQIYI61Tx
         oNUPz3ENMJDcTb2jsFFR8XQiktsEX16J68bzDqEEftjCWMSCHxayPFMNRWnK7y48qeRj
         3X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732568213; x=1733173013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbxw1A0k5fe+ASi6rShndrrNduDYVaxs7kGjhs/QnDU=;
        b=BWSQQVURKPIQ6xROF8XFNMLkCgn/YHNphWu3GdoffhvcUL2hwQBUpLZkBRcaH9TSQK
         C4TYvfT7JqqNpGLh+RUe2eaFDO30090s9Dk6Ax91wujypHEJ/yAx5ulP9h6Xpjuv5ZjV
         GwpCztDyOWK820wymH1WWLITMGIflCd/ZyEtkJlb42GCSQ7iYuiHgB8AsztOBHSYq7L8
         cnBANFJJ5uBjjo6Sb4WkOE8CI2wghhnYrb6ojVIq5aYcpl9Zv/kiU9aWJTW/R/sb2FSv
         B/9Ume9EcKJWuQG+na8bWCRpqOt1OzK6tdjoS7iXV2r/XP+z/eMxr2bFFygx0e/EygXA
         rEKw==
X-Gm-Message-State: AOJu0YyZ6s+RXbbyXFL7SSX4levalH+3Y1haagCzzb/spmcVtWLszB3n
	1i/jjhCNi5EK4Q0w3lWuuvhy8juoLKZMPPYdclk40chYii9vDXB2UPHOqreo
X-Gm-Gg: ASbGncvLl+6Ii0Lna1iaynZ1q78/TQ8ac0Nw5hMN6SdCxdsNie08ENq+NxD8QphlWrC
	oOLKetCRDu+/gh21Ue6acPWoIf7IIyBf2jdize0zqDleqoL1B/6iBrU7vx5QaXs+cSIKvCRg/HU
	+dF6fRNs3FEDa9yVNjrnQ/3mmbxrQMCebAmyQgH9l7gh8QqyI+6AbMbOjvyiaeifuRAmUM+IP0o
	4QsIuk4wrHwD9rYGCJe/Hne1u9+58uyjU7iBv1dlNX5IZUxtDymQIDibXkRgo+jjLbtbt8KDbzF
	T6Sh92WeOg==
X-Google-Smtp-Source: AGHT+IESKRcKlMz9ecu9HXwHFocAEzK7gJnslfT6l4ESUMxrfQVhro1PrjUqn/41AxaAIutp7BvcPw==
X-Received: by 2002:a05:6602:2b8b:b0:83b:a47c:dbfd with SMTP id ca18e2360f4ac-83ecdc50c2fmr1807410439f.6.1732568212922;
        Mon, 25 Nov 2024 12:56:52 -0800 (PST)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfee836esm2345928173.106.2024.11.25.12.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 12:56:52 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Davide Caratti <dcaratti@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net: sched: fix erspan_opt settings in cls_flower
Date: Mon, 25 Nov 2024 15:56:51 -0500
Message-ID: <1e82b053724375528e82a4f21fe1778c59bb50c0.1732568211.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When matching erspan_opt in cls_flower, only the (version, dir, hwid)
fields are relevant. However, in fl_set_erspan_opt() it initializes
all bits of erspan_opt and its mask to 1. This inadvertently requires
packets to match not only the (version, dir, hwid) fields but also the
other fields that are unexpectedly set to 1.

This patch resolves the issue by ensuring that only the (version, dir,
hwid) fields are configured in fl_set_erspan_opt(), leaving the other
fields to 0 in erspan_opt.

Fixes: 79b1011cb33d ("net: sched: allow flower to match erspan options")
Reported-by: Shuang Li <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sched/cls_flower.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index e280c27cb9f9..c89161c5a119 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1369,7 +1369,6 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 	int err;
 
 	md = (struct erspan_metadata *)&key->enc_opts.data[key->enc_opts.len];
-	memset(md, 0xff, sizeof(*md));
 	md->version = 1;
 
 	if (!depth)
@@ -1398,9 +1397,9 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 			NL_SET_ERR_MSG(extack, "Missing tunnel key erspan option index");
 			return -EINVAL;
 		}
+		memset(&md->u.index, 0xff, sizeof(md->u.index));
 		if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX]) {
 			nla = tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX];
-			memset(&md->u, 0x00, sizeof(md->u));
 			md->u.index = nla_get_be32(nla);
 		}
 	} else if (md->version == 2) {
@@ -1409,10 +1408,12 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 			NL_SET_ERR_MSG(extack, "Missing tunnel key erspan option dir or hwid");
 			return -EINVAL;
 		}
+		md->u.md2.dir = 1;
 		if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_DIR]) {
 			nla = tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_DIR];
 			md->u.md2.dir = nla_get_u8(nla);
 		}
+		set_hwid(&md->u.md2, 0x3f);
 		if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_HWID]) {
 			nla = tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_HWID];
 			set_hwid(&md->u.md2, nla_get_u8(nla));
-- 
2.43.0


