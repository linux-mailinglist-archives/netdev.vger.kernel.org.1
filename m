Return-Path: <netdev+bounces-157405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD6BA0A337
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 12:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C65164DDF
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5941990A2;
	Sat, 11 Jan 2025 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1HDTN4f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57F196DB1;
	Sat, 11 Jan 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736593358; cv=none; b=EzTzbnLzQOhZURNH+BCFl6VTH+wvKma7Je7j4xKMng4Q59QKjDQqB9ze9LpHY3nBGYSdRhmbgsf9zn3wbblWWhQrZEKKS7Vi8541ZmvzUrHaj9Zr5hDk8Z9V3kx5IW4I4KcH0hNEXY0KqBfY+495Lk7cpWJtRCuaG219q+jf2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736593358; c=relaxed/simple;
	bh=g1plMfCr/KZ7IBvMVQwPmrzTZcvB3wmnei1/XJFEVUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctYX79MM87J4sLYED/ZayuDBGNbAixArJX9ZcH7JOiDT8kaUQl4pIN8oM6jLX6BZ5O5hbn543kYsJlFYIgbBFfLuUHNLhXfHwAQad/qtvYi+AJjIa0woN7swoHi4uY1wn2rHZs8fbeNkNn/44wn/XGxSlTAI/eqi62JA2b/8DXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1HDTN4f; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2165448243fso56401005ad.1;
        Sat, 11 Jan 2025 03:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736593356; x=1737198156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hznsovtp48mZgcdoUSTo4/nC6MJBeww+RfciQ1pcFtU=;
        b=E1HDTN4fHmAFSPwFz5BUNZnGzFUhPyaPzp7xsvHB447Yxsn1Hvj9wapGvSgjfnC57N
         IlSBYXZV2EoqU7sD6ZyArMLNh+PRj4zSAhUWHReU8dgkF+kDKd6w2oD2C2REub6FgG9c
         dycFzUgNPodyYpOyjIjtPtQbDU1/4i8XpMhuQ0sd3vNT9mqeBU0LHzyJuSRKni1BRZUT
         HKlYDgHa9RbwN/PbPFuatuQYUESPXa5dvAGKrSOAdoZmNqMZGyjtL2g4tj03Sfkek7Y1
         YBHovpEgFY1sV02ojT5YikdjzJT+skQjqgD2mhp8o9mdrz/mrxC76Wn5koppZZYbn/i7
         zeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736593356; x=1737198156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hznsovtp48mZgcdoUSTo4/nC6MJBeww+RfciQ1pcFtU=;
        b=jdD9X0nakhP7VQZLLyitdSnJe2y2euCam60zGMSAm/8H53ZYvqWbHkFJ+PD4AzH9DT
         tdkSfvW6SG+hdwtdk23cjDGI7/T2wsecqMcma4t7ZP2UAEONOSKHsJkq2Q63OfHk+aZe
         +742KeXDzv3PdnjlgR/vXEqQJywdhCFtvotpGbhKIqbM7L15VHFyEkUH7BBJuB+dn9ej
         27lrRIIgWz97HiVQspYKEKYeUyUul7ph5jdeFNVsBMTWYG2tl1Eb0SyAGmhoqopsVM0i
         Unn/SUmqrf2AUYCnrYiSKe+XIzOF4PuKcIJ095T0P6XOfLrquSZXJ7Vz12AwaGC4uI32
         TbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnw5o7a41UwQmI9kHzWpg/bFEnh6urQzcEnShBAsIRJsnTDNGn4AOnN6UgqKIPzzdeY8TuME2VFH3h3dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvpZ0WQgseK4DdZ5g9K1kfWWON/2wgffgbYVqUN2bBYDwIwUG
	e8gpuDNSIRLrMks7+o79hcTduB/2FHALaS4FKD0UzKwegb6qiFBzFjmQMA==
X-Gm-Gg: ASbGncvx6FCjgqczF0Xrfg0X1dek766Vird3SllDO+PR9b2aTxuvaXuwlI2yxI1BjIm
	GOVvlUOtbYxaXujgtw/8lVf1R4tXsnBMdOg2x7ih41KYh9soa7xVd/9Q0vEGwOFuBlylCVz6QMl
	BdjpM34DYYAjvEOSnXuHPUZ5scQofY4pA/VaLYzd39wk4xL6Q7t4VeZpHju2U3NSircFAo4WYaN
	/1dRdzsn2gAp7r7dQ0SkUHRSfCjkyFJkSaJtRrZuAhPP123J6ghtOWFoX419ujoc5SwhNBw4cLk
	iA69JcTwUNfo0zCvLNUowyX+yKAaLu+a1Q==
X-Google-Smtp-Source: AGHT+IEO1EaHEHKE/A+yERXvHhAh0jP8E2h0S1d3mbQXpZhiG8Q9RA6jWHW1HT93x/lGN/78vwSn7Q==
X-Received: by 2002:a05:6a00:1909:b0:72a:a7a4:b4cd with SMTP id d2e1a72fcca58-72d220025bcmr21352985b3a.21.1736593355921;
        Sat, 11 Jan 2025 03:02:35 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40680e5csm2953826b3a.143.2025.01.11.03.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 03:02:35 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Sat, 11 Jan 2025 18:59:44 +0800
Subject: [PATCH v2 2/2] net/ncsi: fix state race during channel probe
 completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-fix-ncsi-mac-v2-2-838e0a1a233a@gmail.com>
References: <20250111-fix-ncsi-mac-v2-0-838e0a1a233a@gmail.com>
In-Reply-To: <20250111-fix-ncsi-mac-v2-0-838e0a1a233a@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Paul Fertser <fercerpav@gmail.com>, Patrick Williams <patrick@stwcx.xyz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>, Cosmo Chou <chou.cosmo@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736593346; l=1082;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=C0KcSY/p42mPHtdSbbuqbciMoVgNxzz4Cv1O0zA8RkU=;
 b=/hyKLPCb91qtlVx4N7/5m7wSmTB718JNnDTAEsWdOw3Ru3OHSrXweQf5Dyid3pU+Ast+CvWu0
 ZZxHFlcFRbdClAX1xFXBVgWbW8dfZg3UnwirlV9DzWgZQEaNv2pE0fs
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

From: Cosmo Chou <chou.cosmo@gmail.com>

During channel probing, the last NCSI_PKT_CMD_DP command can trigger
an unnecessary schedule_work() via ncsi_free_request(). We observed
that subsequent config states were triggered before the scheduled
work completed, causing potential state handling issues.

Fix this by clearing req_flags when processing the last package.

Fixes: 8e13f70be05e ("net/ncsi: Probe single packages to avoid conflict")
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 net/ncsi/ncsi-manage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index bf276eaf9330..632281816f11 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1491,7 +1491,10 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		}
 		break;
 	case ncsi_dev_state_probe_dp:
-		ndp->pending_req_num = 1;
+		if (ndp->package_probe_id + 1 < ndp->max_package)
+			ndp->pending_req_num = 1;
+		else
+			nca.req_flags = 0;
 
 		/* Deselect the current package */
 		nca.type = NCSI_PKT_CMD_DP;

-- 
2.31.1


