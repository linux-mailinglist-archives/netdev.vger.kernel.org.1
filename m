Return-Path: <netdev+bounces-143187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06219C15B1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CF528184D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653E51D0F68;
	Fri,  8 Nov 2024 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="uOBRNlD3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4B1D0DDF
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041679; cv=none; b=b3la6CgMCKgAc6hoXqmd2dHI+FocYkuZCL4gccpClR/pbhOFu6FabAqzv3PDlkkXee5cgQ5Bu+NQHGs5XNuBq5EAfi9jEPD6TO3Ws0QrFATIyf6WhxfkA7MKdQ3DUAOuSKOlLNlUQe9A4MoMiqS1rHTXyeeukFl7jDbqm1v+A10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041679; c=relaxed/simple;
	bh=QMGh9V+fCN/j+D0uLjcnIHw3s7shm5dxlUbsYTeYPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AM2gyKwmCuBffKwWHSRf7ngI/DSPlMgwgiLekwyvDplndzO8g1ZvAXf5euoKZ4v4dFPbV2o/Lwmf6GUv4uZjyI93yrMdImwUWkiYhDfT5Yo4derGDtahw8qOY63WcOApIbmu6h7+5xjYTGNy6NRZtF8zg9XVnb4zRYPyscHe148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=uOBRNlD3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso1571619b3a.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 20:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731041677; x=1731646477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=uOBRNlD3YjT6Nqi6l5UXnY1lblNHzzzEaOWmekCNRm7Ma6JcoaRW86L/vI3WG/DJAh
         EemzSXZ5EQ/oYjl3omt9tnEF1MR3Eo/4ms70fqiz2QYIVnoKtbEMc9rdu4TBQbjx9aHb
         4hfQcBUyMSdHYqiMYpMIDNXLZsV3AaQYNtk0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731041677; x=1731646477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=hqtrioXK5o06rneSgWm4WOsHuqscon9kyNRP3CiQkUhx2IA/CSrFI9vf9sSUJ/v5Jm
         IeCS0mvHcNmyReV6/c1hMPPZ06/lbog09g/Ecf3Chn4hurnZ2ZPENKh6NmZsP72uHVB5
         LSyWvJpc3cYHPprkQ6lrnRWmEEPDiFcH9taAPvlECqES/lj/ZtRTYOmzE1Uk+djKcUgv
         0u3Uwq2qolWiq7BPOcSVhGMM15qLDudBXJIU2iiwCMGweI4TxX6hTM21L9mskPMuECpe
         iPQ4cOmaB3Nxjw924A74myYA+P8PNOwbQ73zLl1VYKPbl4HK043epMe+Lk8copWkCnv/
         1guQ==
X-Gm-Message-State: AOJu0YzzXFBmn+r1+7DS84++bfxj5MAuEZklA6eFf8OQl1r2eg1jpyRY
	o1sEZ1CHxd8GaJVjxX1Wz7fpHoIm9ulkxA0gAsp+grlyRbyWWijtZOY5aHL4uPCXcRuzkdNjQAb
	wXsHFaU3XgtIcRXYyi5NJ0uvxuYoqhT0sGXtg0uuyLfQM0focM+fCfGTToNU+HdTwxMDV0tU7nh
	h3Rd1TF8z6lA7cewdxH7e4VhVrIPw5Mt7lVOU=
X-Google-Smtp-Source: AGHT+IGYzAbiAwauRFMMboqJSm+iCwXrgDOyCYgQe6F94CT0DzPWv4Q9veac5TXYOYehAWs9ZfUyEA==
X-Received: by 2002:a05:6a21:3d88:b0:1d9:1971:bca9 with SMTP id adf61e73a8af0-1dc22a47884mr1473874637.24.1731041676722;
        Thu, 07 Nov 2024 20:54:36 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c76sm2697476b3a.48.2024.11.07.20.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:54:36 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v8 3/6] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Fri,  8 Nov 2024 04:53:25 +0000
Message-Id: <20241108045337.292905-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108045337.292905-1-jdamato@fastly.com>
References: <20241108045337.292905-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

Setting prefer_busy_poll now leads to an effectively nonblocking
iteration though napi_busy_loop, even when busy_poll_usecs is 0.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v1 -> v2:
   - Rebased to apply now that commit b9ca079dd6b0 ("eventpoll: Annotate
     data-race of busy_poll_usecs") has been picked up from VFS.

 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd8..f9e0d9307dad 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


