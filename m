Return-Path: <netdev+bounces-69654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B6A84C113
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 00:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1D228770B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 23:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204421C69D;
	Tue,  6 Feb 2024 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFULrf2P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A31CD1E
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707263703; cv=none; b=axMyZTtlrcKGGcpl6Ovab9+CBwpErkeG4tIkG3NDqHc5x/Xl1ZD5sMQXHnQ8diPPApryAdB2eFCuqXp5Bjn29ln156lZMLH5V0gK6WkzYA9sOn/7KkGtw3d1mkCDxVd6b6+C4B4Gy4dlaoC7nl7cO83m6ilj+y5es20X+9pLrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707263703; c=relaxed/simple;
	bh=NqwhsTBBzR5C1CdmeRPVlqXqdQ4/KFKUaeCioIoZEZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XxfRZEqED6ExTW2+SNy2eDocJUmJEpQCD+nhNy4KOZcu7eDt0PzJ73Ahs0YYd6nTjgdV1DTE2oMbsqC5hg+N+BK8eiK8CkwTZLZZHNDPyF9v8J00llq4Ex8JXweKhpT3XqVZ7ysyPxnlFb6Ce7a+Fo5ms6xnWvhfrf+1Yd5S778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFULrf2P; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51165efb684so43503e87.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 15:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707263699; x=1707868499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcax2EiamieY77c2eBWDtUS/Fdjm+At1i2RYmPQQ914=;
        b=SFULrf2P2cJc0fXERlLrKV6lq1Nxo+w1JpFkTPn7GN/w/D86o5kP1G/5OMic5H4HXJ
         AVJ/d093Xp3TzYGHgMmqGCHYYgZgnTKcZW8yzknZOuQxSGkHsgiN2OPaNKTrMnpI5gBL
         JddVvg9g2kZsuNMf8kA3XFfqrSV5ibSbqeS/Q8d6o4gAk/tnHdcBRdNpm28OMShi9dFS
         GWkxqPZKJcXCPzGNNCyqD4t05bi/Wvhr5AP/ddjNeOLI55w1KjZ3pUCxxM0pGqLa6LK5
         Hm5Vf3CSEvSjt43A11sAPLTQkYzBxN9L3t4L2w+CgG21Cm7xvD+Xxe6sz7xbfv38Qe5/
         wp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707263699; x=1707868499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcax2EiamieY77c2eBWDtUS/Fdjm+At1i2RYmPQQ914=;
        b=t/PXiNbo6BNUs8Sr2U1j23KAGs631fh8EndLsuyu3fUtH/3qG8FJYjqPyVVmzWYdpq
         e0vx8rBXdxZBRaU28DrxOfEJk91X62zol46cLWMtK3gNC4v5cgQEnkJxJ80kbzy4mzaU
         fPsq8l/1hMVr6vUIOd6/3GI/lQp585AW+WFFqvxW9krXWWFK9hLlfcdFRbauXs/8SSVr
         W2HdxjNXGHi5Agzfn0jvKbiNqN7aoSlvhwaLGYL2BW/KB8y6lUfRWzzKmypChoKPzVE+
         t/IdAqrBVDUOnCEjmZhv2H1jBUuMki1W7fli9DgRekhAXTCGxrmbzSM99hJz+uLOFE7b
         8blQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8IU+w9kWH1dllTVhD9lBbDhmAIggYUe7m4hlNmgWRjnazJa8vrKMkXPSCq8C9pHnb+cIBM0CzLL8ESvHjobgI7Blvuzf9
X-Gm-Message-State: AOJu0Yy7Sg2gRUFLyAQ9SvqN42H4tACa+XMoRpNsSGH40udN+5q7NKvq
	SN7PzrpdlWBazX5/z2XTY+hjf1oM4+Eczjw3WPd1xvR33R6OzWm3
X-Google-Smtp-Source: AGHT+IF5TQBf0/9TjpLcqbCF5sIw9uu8wG9S0JdGCx/LkB5+55PXOm7mBP68iuzaVbkLVTUNKLZzug==
X-Received: by 2002:ac2:5b85:0:b0:511:fb6:b1a0 with SMTP id o5-20020ac25b85000000b005110fb6b1a0mr3237145lfn.52.1707263699101;
        Tue, 06 Feb 2024 15:54:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8Q6GzvsLKxrL7PN36q15yj+vKCYX/G59pPauVHc51jOvnsZC+Qb6n6G3RpOyKd5pVczY5vVydZlslqwHs05QpxbdnhSMM
Received: from mishin.sarov.local (89-109-50-200.dynamic.mts-nn.ru. [89.109.50.200])
        by smtp.gmail.com with ESMTPSA id 2-20020ac24822000000b005114f6294f6sm2691lft.73.2024.02.06.15.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:54:58 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] ctrl: Fix fd leak in ctrl_list()
Date: Wed,  7 Feb 2024 02:54:03 +0300
Message-Id: <20240206235403.17977-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 genl/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/genl/ctrl.c b/genl/ctrl.c
index aff922a4..bae73a54 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -267,7 +267,7 @@ static int ctrl_list(int cmd, int argc, char **argv)
 
 		if (argc != 2) {
 			fprintf(stderr, "Wrong number of params\n");
-			return -1;
+			goto ctrl_done;
 		}
 
 		if (matches(*argv, "name") == 0) {
-- 
2.30.2


