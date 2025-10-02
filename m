Return-Path: <netdev+bounces-227610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B2BB36AC
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 11:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E05176C45
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE703009D5;
	Thu,  2 Oct 2025 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsUIbsoN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635D2E8DF7
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396497; cv=none; b=gQTF5apDC0pveOKZ8aC0JN55Lo/+m9XWPxwBwx9vWudHELWnMIGzB7ZloHoqSQaNgDJojWamxT+JGYvv32SgbqmFVSWbGgcgIcYuWkmEgtgXV1F3XsciU6qKHR1V/0I1w28pbHn83zbOjMFT4qJBi9I3bPY8Q0WEGHNAIGhSwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396497; c=relaxed/simple;
	bh=siG1bgYonAEUTQ2s8Ux8Lu0beD0iJQSpmvEU3NcNK3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYOS9evfYRE9RcyqePbOQlhAxOAEjPjPmQxl+MNJL2UzL+5gQWaus7mEjOPiAdXNGnobCGO5cWHQ9ipTugbq84AGuEJqL/pzQFPe/aB8CpPxSAKqaxsby+bx3SVGL29VAocH/1OKQ+19Bwv8snvsbHUWPubveaukM5p7IpXq5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsUIbsoN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5818de29d15so897826e87.2
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396492; x=1760001292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSM6CM5P15ezEZnt0ve39/mjKYvov3ryn3t/1wlMyQk=;
        b=fsUIbsoNTfjlJbuyLjKLE8zfqVBn7HLAH2HxmR8m2ZYR62jezqgXFgm7EXvQL6h8GG
         Q0SiyOnqGP86GBDy+LjUimDYiul6PtHaA+m0vrHXxJJ44R5ugVcaw+mDQwFCUcgdXOUf
         NjZzQXzdAHT98PNP2mG3avIWxGExCasOoJwCXboycJ+ZgUmUPfw9KdOlvAzVw0Qv3mQV
         Cwx/a4/h05AFU1+UUVe4zylZDfu6Ptw0liLtnE3uOKejOGsihp7581jRqMHH2/Ov6gkM
         safgfZ0aLGwB1HnciSnw0+ItWQas3vP4uqThMdLGhlpLFmFcX04dgIhjDj5AP5JF2RpJ
         9HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396492; x=1760001292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSM6CM5P15ezEZnt0ve39/mjKYvov3ryn3t/1wlMyQk=;
        b=VeCIZst2oALdOk25RYcmJtnUIQokZWNeP1PVzvglZKkFUkt9NxD4AOIu32PPYoZTgg
         57QQkVHxX2HjV4jeunlmff9+eYBaGgaFa0sjOsbsceIdtt2hWiDmuLqfXqMZUrtBri9i
         WwKmdeuZhyLo6PYmDS+SEEa2bUc0uHTYQoYmeMHQH+RcQ8BbAqKY/wwPPgatULwQQF27
         gXUX1o0aC0DtLLw7hXcNNjYsIbI2I82X35tvzGnrhS0Uj6A98PNZDmDhSmcm1IFb6rgW
         V8VXMfDDqRMlPr6TEZYM6gG9hWP7DDt08fYahjBQtbH1QE4qF5StGRNJDpSV3UT0ZXHH
         zRJA==
X-Forwarded-Encrypted: i=1; AJvYcCUI8JMkrj7NhuTY5IZkX6a4/Xk6nMp2YbTTgKxJJ1YOr9iSyI+p7cknxJEwhtrfTsrqngQiRQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Fi0qMWtySXN4Aigzu1l4QtYqZXyb0phQXdAe1Xf3KGGzkGe6
	fGyZJuyOmB8FfMduENjiGnWFeYDM1lALprAtqwnMv3b0xYPLO2qtHIdU
X-Gm-Gg: ASbGnctwGwlroiM0yqLtagrsAC8cc4SvGe0s8Yv3fUiSQFQPGCUeNNN7L5IPG57xpiW
	HiT3ohw8WidEpXUlzteO/dAs6u1lO0o2/k2Qyhl06c++OeTl7veg/gCbAf6Vsj1VVUmgiK/37g7
	wvu9j1Wqrf5Km0E2Go1LdUf7S2QAJhsg9r8h6/u99gICfLmW56sAJmh7JrotxCvcMbTpjRC7FXG
	AGzCf1g2QXharBBicgtvpbpcyZ1z6b5d0ARfyQOgPPYLZRhb7FK2e6/7FO9rFiQ7XV59+gifQt1
	GciNcoAvYWIYufU8h1gZmxf6+wi6VWhWBAP75InKTGkd1TUcieqegk/eXXU2UIiKchdevn13joV
	AWTS6azE8GAqPIZUQpal4jRiB/9BOG2gXYsYNla/H2CJKJU5/phdLQX345JzrTQLn6/FYdp5V6B
	ZkCaBRC99gQROY5ngMQCa9fQOmIiAexSRKT2exuXumBbiPevoU2As=
X-Google-Smtp-Source: AGHT+IGWYt7Zzu4cL1+wVfYqBSH7iBbYGrSdD+ADAvQhIvYKCsdF8o+ver4QC9QADVpDHqDv4CErAA==
X-Received: by 2002:a05:6512:3d9e:b0:55f:71d2:e5be with SMTP id 2adb3069b0e04-58af9f4ea35mr2108491e87.52.1759396491883;
        Thu, 02 Oct 2025 02:14:51 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119e4a5sm650494e87.93.2025.10.02.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:14:51 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()
Date: Thu,  2 Oct 2025 12:14:47 +0300
Message-ID: <20251002091448.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

If new_asoc->peer.adaptation_ind=0 and sctp_ulpevent_make_authkey=0 
and sctp_ulpevent_make_authkey() returns 0, then the variable 
ai_ev remains zero and the zero will be dereferenced 
in the sctp_ulpevent_free() function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 5adf0c0a6c1a..056544e1ca15 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -885,7 +885,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem_authev:
-	sctp_ulpevent_free(ai_ev);
+	if (ai_ev)
+		sctp_ulpevent_free(ai_ev);
 nomem_aiev:
 	sctp_ulpevent_free(ev);
 nomem_ev:
-- 
2.43.0


