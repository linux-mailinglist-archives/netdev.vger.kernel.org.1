Return-Path: <netdev+bounces-53019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5213280120F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3886B20C1F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C464E630;
	Fri,  1 Dec 2023 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="WD0wS3yU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D15AC
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:50:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2839b922c18so2154840a91.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701453033; x=1702057833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dZMHTWKZMoxoQs0cVr6KRd9m5G2En2sdYgF2ar58rg=;
        b=WD0wS3yUmPWSHbM/2QFAszra6nSDtbkwL5asI3JsK2OHFTUhQkIONi2TGYvX2Yniml
         Qedfl6sO29wOKfVAL/JwpXDTX6TrGyBoYXfzPi/v5T51ldWzOyFHyXY8O6reAloYdnz9
         LzVUUH+CT+hJqjdRrLd1d7OaVZQjT7ipXzeMmYhW3BxbWujTO3Z+9iFDRWtEbdDAUd9O
         M6GMip4jZyNeMdj0C1GCqI+3AfCewq2U/n9zVjNoPKpCDqRkG4g4feajJWuVyOZbA//8
         EMCYqW+EHamSB8zyVKBDHQjE31YN5ta7hdKWRJ5w1BAoIVmT9gRQKDC4QW8HJzJodf6o
         091Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453033; x=1702057833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dZMHTWKZMoxoQs0cVr6KRd9m5G2En2sdYgF2ar58rg=;
        b=TNddw+KsDmv3+0Y6BHQsA17W4oaz0NcJ8mijDIWqIRWxPR6kTkkbhX8+eyu3A34Hl9
         BlCnvZscHpejT1u/jv32LoMP9dHGf4ZyuMEZRXyKqyXQeUKC+HWYC2ETcrVuH98SzoVR
         JbjBbLggApt23Zm25rFVqvW5DinxmnPCth2UVYJlP7sWL419iZI6DDiLhf7/UJoPzI2x
         w3vJbwGbO03Stbl7QaE+4piwArBD6/phyzaYgJyhEPKb37nXwTDHLcWUdcCrVBOVzefU
         61XsqELdrS69HMbj2lrqevjvUg1vlOk+vKAKyvERhqimyh9eJqsmW9Go8vS888u6MHvs
         Qp4A==
X-Gm-Message-State: AOJu0YzctQjlrpcAEhkyFNmQnPKLfRC/G0KdkaCKyMZvRwLG5vtHH3iW
	kOOZFWO1JZSOr2jIa3PyD01tJ6WVXI7YP9rtl24=
X-Google-Smtp-Source: AGHT+IE7saAIaaBnMeGgCQpjxWYcIDNbnAeO7OGpEV8FbBtmvy5anCzTQZlgftf6eZ5FZphSE5Dalw==
X-Received: by 2002:a17:90b:1989:b0:27d:1862:a494 with SMTP id mv9-20020a17090b198900b0027d1862a494mr26282680pjb.11.1701453032908;
        Fri, 01 Dec 2023 09:50:32 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001cca8a01e68sm3619729plo.278.2023.12.01.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:50:32 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	mleitner@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 0/4] net/sched: act_api: contiguous action arrays
Date: Fri,  1 Dec 2023 14:50:11 -0300
Message-Id: <20231201175015.214214-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dealing with action arrays in act_api it's natural to ask if they
are always contiguous (no NULL pointers in between). Yes, they are in
all cases so far, so make use of the already present tcf_act_for_each_action
macro to explicitly document this assumption.

There was an instance where it was not, but it was refactorable (patch 2)
to make the array contiguous.

v1->v2:
- Respin
- Added Jamal's acked-by

Pedro Tammela (4):
  net/sched: act_api: use tcf_act_for_each_action
  net/sched: act_api: avoid non-contiguous action array
  net/sched: act_api: stop loop over ops array on NULL in
    tcf_action_init
  net/sched: act_api: use tcf_act_for_each_action in tcf_idr_insert_many

 net/sched/act_api.c | 57 ++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

-- 
2.40.1


