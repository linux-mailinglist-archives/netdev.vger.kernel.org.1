Return-Path: <netdev+bounces-230008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09457BE2F3D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 308B1540B69
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E69343D6D;
	Thu, 16 Oct 2025 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="cvE60C3D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21E343D60
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611692; cv=none; b=S2yCO+EVewucXK8tYsk5vJDiMFkUyC0c0lI7E5WZaZyo3dJ19PfFDZTKy4TNiX+L6hQ0eic/HYliZniGxIUQZZ83JhpMQ+jgU/Gw4Kh5an4GfuQsYwdzEM4I65tcMbBi9HpG3UOf4QpgHCFIysi9mBXgmtEcK31y4/3Jf4erPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611692; c=relaxed/simple;
	bh=Vai3/5mXUk3m0FpPR7C5HtKBEkwbvUE6m2tIfTpywf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxRzGuWuFoempGbjk8BPmxs4rvbfgWMN1ghsclgoF36oi4a9SQJaiN+pzl8fH4MpW8JfsVdERpDIhEQWV5bN1dJbyZXbS1oKdVRD7KQOth32gklpx/1WW/knwZin61luSvANC9cEdvnh4Y8adJ5BB2+NcmL5uyMFr+bz8TSJe14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=cvE60C3D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so5221755e9.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1760611688; x=1761216488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSPV9AzBq9pw4Fv1WhOpeCc+InkklHxwfYwRGxtUKjs=;
        b=cvE60C3DFX4y7L9IC3YnW3PHe0dKXP2BmldViINck+3iqtEKFUGZx4dYKGyh3wT+Qe
         lCDMh48KaO1P1NMM3Jp1eoR+8pILH5eT6w0TUWaADBPP8QArL1dpqLHrcs+5BunfRIFP
         4Lpg9GZi8ocsK4M4YM4Csap5Gaa+Uis0gj5hKsOdu4JuNZVxP5Z/Ni9rmlAXfuBqf6jp
         DsK7ZxFIbX4FcjvI4VZUHChiUBaG7WidRJjtrkGqxLkacpm7a0bLqtythGvsIzEJ2+Te
         aKacVT4fXjco4HzBZ3nd3bG/yPc6wDZb8IjPcTOFRrt+0cfk5Ywa7ACKcsZRQW3QrCMG
         I2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760611688; x=1761216488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSPV9AzBq9pw4Fv1WhOpeCc+InkklHxwfYwRGxtUKjs=;
        b=xM/BXe2k9dlyvciucmPOiLWTMmm41BXFgQaQ5+aaDGOHEpRLfj1MD/UP1sMHPbj3ov
         TKKzfKT3y0/0S5hWjqrkme+SEOyLtT/kXK7l3PcwZetZeo/Xb1frBNzEdcm+SYpFviP/
         6vJhcCMrhGyuxeFB7Cia9WKzg79NJdjAUeGDOVVpProeIho7ydvaAFRxkjys0jkppZ9V
         84EqPLmqeNm4WOx3DFkiJTi3aAo9WfZckUew7mGzm22dMpNhB931XUP64Q6hin5Gu6m3
         wVu8Le497vPCAEA2lasFyP6pcPGeVQz+gNOY40bVUM30GSkAhZbaRIglLU6EyGlnWOWw
         7QKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV18gMMIoTudTpwJt9S8EL7gOuWuvThV/GYDsqZt0IIo8cenpYAWOfmjEhPxmkLV/2LjFORmg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuo0EJ2qNSKnuw0FQnCbQ9gk0+aoi/5ayPwGvma4xIIfHJNv7x
	PvvVaDsR5DkHaQeV3QFEJn6ESJEY9fT/ltnl/T5hJnY95VLlbDu5nrgzK8FHHibE7bk=
X-Gm-Gg: ASbGncvAejcsnS3/Zo3ZJAuEh5hWvRcmSixrBfOi73HwBzQvRRXQgXbAoIOF6iAvoTR
	FO9M4awUoZSeaxP6C8CrlrtbnGkU5er08MY0xMBzszjDCdj4wGbjlBOTqPnycJZa4xiQ+Vg7f0L
	sHBie9npOMkTEpx6aA9Vouh8gwYcmdz7j/rEb3xdgvSfEUH4yvlCveaUxWgBtw6i4fTBNaka1Kg
	OjTeb2Yd7ag+j1pNAgyzgFY99JRGjCsdjex4WfbkdX9aw2YaevBBc6YHFsjOHoNkVPmo4qkLWZs
	GsDTVdtSWJeJbnb9HVLPRgmNbEZHSSPLFrAI/tOLuKk9qugY7gVVdC731hDzHePoy97p2cNg6ec
	Gy4hEXCop2Az4FoSmDp0CrHB78Su5F6pUkvcPZlimznqXmyjns1cK/yKjEc1vSv37D/FansnqTF
	QKCrYrjgQlpkwzVV6WlxSNoYRmFjCPW9k9URbQEj2jMwChuVrd
X-Google-Smtp-Source: AGHT+IFqjy8uQiCs0gAcUHUVVI+lGBAyvoChddSQYZFbSWwhwHhgv7ATDM7DOPjRfdHKUNXdqdAqVg==
X-Received: by 2002:a05:600c:3e87:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-46fa9b17df1mr270864595e9.34.1760611687717;
        Thu, 16 Oct 2025 03:48:07 -0700 (PDT)
Received: from VyOS.. (089144196114.atnat0005.highway.a1.net. [89.144.196.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ff84cbb7sm2729374f8f.23.2025.10.16.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:48:07 -0700 (PDT)
From: Andrii Melnychenko <a.melnychenko@vyos.io>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] nf_conntrack_ftp: Added nfct_seqadj_ext_add() for ftp's conntrack.
Date: Thu, 16 Oct 2025 12:48:01 +0200
Message-ID: <20251016104802.567812-2-a.melnychenko@vyos.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016104802.567812-1-a.melnychenko@vyos.io>
References: <20251016104802.567812-1-a.melnychenko@vyos.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was an issue with NAT'ed ftp and replaced messages
for PASV/EPSV mode. "New" IP in the message may have a
different length that would require sequence adjustment.

Signed-off-by: Andrii Melnychenko <a.melnychenko@vyos.io>
---
 net/netfilter/nf_conntrack_ftp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index 617f744a2..0216bc099 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -25,6 +25,7 @@
 #include <net/netfilter/nf_conntrack_ecache.h>
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <linux/netfilter/nf_conntrack_ftp.h>
+#include <net/netfilter/nf_conntrack_seqadj.h>
 
 #define HELPER_NAME "ftp"
 
@@ -390,6 +391,8 @@ static int help(struct sk_buff *skb,
 	/* Until there's been traffic both ways, don't look in packets. */
 	if (ctinfo != IP_CT_ESTABLISHED &&
 	    ctinfo != IP_CT_ESTABLISHED_REPLY) {
+		if (!nf_ct_is_confirmed(ct))
+			nfct_seqadj_ext_add(ct);
 		pr_debug("ftp: Conntrackinfo = %u\n", ctinfo);
 		return NF_ACCEPT;
 	}
-- 
2.43.0


