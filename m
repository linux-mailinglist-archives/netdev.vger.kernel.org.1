Return-Path: <netdev+bounces-147678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C0F9DB241
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 05:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B0BB22C63
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 04:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98C913777E;
	Thu, 28 Nov 2024 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFSiqpwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DA13B280
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732769030; cv=none; b=AXlYOPex7F6OoWWWB2hrPCMUAhPtaaKgXQIcDhy0kudvXCKwMuiknJ2+j23sOUDAaMoaUAa/2gy24UL/apXY7eW936xTvLjJp4v3gGPOwkkEHaI53T+SI2RA7oYabdu0ICXAGdjC080VoVmf35iQe3IoJWhh9y3tcv/2jvoFQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732769030; c=relaxed/simple;
	bh=/I70TIKEOiFjtL6GrqBD1XbrOYf/MPEEVAypAj3YPqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6lW608zAAVYMRm2ooYwrq2ADkqBXb0Jew3MScompPlt/0Zmch34pHid+eUWrv9cLcp074mFwqbPWKWn1qj13WtJG24NWL7QCWqr/ihHXKuoHM2bD6RSI/BKPLn0t3RQd1/hrVty/r5ytp6BzaW7WI9RZKX03e9gYmFahj8vkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFSiqpwU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21260cfc918so2377805ad.0
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 20:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732769028; x=1733373828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/dKzzKgEinxfqYKLBktCYwXvQ0a/AcqjNjaYQuKraU=;
        b=AFSiqpwUZ382/90KwsOTqPqSTBqB/YYpRdMjF2w4qKPHDPcLlV0CKbNHlYcFwqmkrN
         OzirhEIg7+P+bl6Pp+3JPel1Eb1d3bLkCnrnc6VsY+gFcl4koKL2v5CqV1eHo7ObaRiG
         DMhkF75kfon4wT3E+C0sW1kRMtiuJE+eY3WbG8C1wQdRGg+AUgjBA3QKZ4ecC2U9L6Xs
         Ahhyo5os9yRV7r0tHvWg9COxCU7J0OY+pM6cjEGp8B0BTipNm2wK2pIqb2gxP+Yy5Z9m
         M31w4145HdBVynhcfUdBByQI5/TmmZ9+5NrIxFsGM6zbvNiDTLPpVCNPdusDnTHQqYkX
         0edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732769028; x=1733373828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/dKzzKgEinxfqYKLBktCYwXvQ0a/AcqjNjaYQuKraU=;
        b=CfTClGTJk+AsE4n2LO6VSaIlRWfS2PA95KDrAhaEm3fGGIBuJEBAORx3B0B5n0nyY1
         gNKWoYHTlg5Gtz8FFbTknVR9FunbuiQKLYWeH/wyzdofQyxGSiXpkObNXqRRZG7xwSOf
         t7F/WIuCU81PRYtlnEIgxDPA/9OeUAdyqVxrig3m0PWzZ73lNuwLCOhG0hIy/Y1IH5Un
         LVvRRP6JCUg2XfpQ1wYK5s4SdLaH05Yj9gBILNjVPj0B4gwvoYCog2Mvbst5hANnX/hn
         I8SdgUIbpwJsRZntjK70i3qy/5/x0hi+R+FhrUGOLuJ3iGXDxjdu9RNoYroSk2ZMqXkt
         kgmQ==
X-Gm-Message-State: AOJu0YxGj/4z5upoivyBy6Lo/VCEZjF01ALmDMdV3gb6+AKUwM56IHaY
	LFl891R5E9oYOn3rV2AryAGK0aMA5tH2tJXV6ifvmMy3G+mBlIPuTWMv9A1V
X-Gm-Gg: ASbGncudXlzIpEHspTh4NCWEjOGZ83a5vRAG1/NUUM1Jy+HBRk+NUUALGfWeUkhO1KN
	N8Iixtez2ynpwAHMbkDQ882OqVffXKFDKTWUf6fNjOE01rxQ0DKPWadUH9wywokvEqK+gk1IN+E
	7j/DAn0dML1oc8BELUvxulc8lmRSiGCbCkq3QhwyKbgtWjz8fP3Yzzmtoiw3sMyRJXYrvSDQnG8
	oPgxBoqtyJZEtF0Jhir8ys2ydB/M9iPZF+DaT9/8IxfyPmVhkk3cE+IJ8WtwRVJEELx9Mftb8iq
	ztz+0Wb3M34=
X-Google-Smtp-Source: AGHT+IEY3ImWK37I0pz8g4/Nz/JKCfF6qeJv13tLYoydBPSdNRM1FHnk33KIiahcUDq2xML4/4hAHA==
X-Received: by 2002:a17:902:d502:b0:212:9aca:14b4 with SMTP id d9443c01a7336-21501b63fb2mr76966185ad.35.1732769027808;
        Wed, 27 Nov 2024 20:43:47 -0800 (PST)
Received: from arawal-thinkpadp1gen4i.rmtin.csb ([2402:a00:401:b8b3:f979:38a1:d361:cdf4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219d799fsm3948175ad.282.2024.11.27.20.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 20:43:46 -0800 (PST)
From: rawal.abhishek92@gmail.com
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	arawal@redhat.com,
	jamie.bainbridge@gmail.com,
	Abhishek Rawal <rawal.abhishek92@gmail.com>
Subject: [PATCH next] man: ss.8: add description for SCTP related entries.
Date: Thu, 28 Nov 2024 10:13:40 +0530
Message-ID: <20241128044340.27897-1-rawal.abhishek92@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhishek Rawal <rawal.abhishek92@gmail.com>

SCTP protocol support is included, but manpage lacks
the description for its entries. Add the missing
descriptions so that SCTP information is complete.

Signed-off-by: Abhishek Rawal <rawal.abhishek92@gmail.com>
Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 man/man8/ss.8 | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index e23af826f467433623dcdc639e1023a87e487e81..736c51d11b59ae193a9173ae0ec2a37f4e6c4853 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -167,7 +167,7 @@ Show thread using socket. Implies
 .BR \-p .
 .TP
 .B \-i, \-\-info
-Show internal TCP information. Below fields may appear:
+Show internal TCP & SCTP information. Below fields may appear:
 .RS
 .P
 .TP
@@ -277,6 +277,58 @@ a helper variable for TCP internal auto tuning socket receive buffer
 .B tcp-ulp-mptcp flags:[MmBbJjecv] token:<rem_token(rem_id)/loc_token(loc_id)> seq:<sn> sfseq:<ssn> ssnoff:<off> maplen:<maplen>
 MPTCP subflow information
 .P
+.TP
+.B locals:<locals>
+Local SCTP IP addresses.
+.P
+.TP
+.B peers:<peers>
+Peer SCTP IP addresses.
+.P
+.TP
+.B tag:<tag>
+Tag expected in every inbound packet and sent in the INIT or INIT ACK chunk i.e Verification Tag.
+.P
+.TP
+.B state:<state>
+State of association i.e COOKIE-WAIT, COOKIE-ECHOED, ESTABLISHED, SHUTDOWN-PENDING, SHUTDOWN-SENT, SHUTDOWN-RECEIVED, SHUTDOWN-ACK-SENT.
+.P
+.TP
+.B rwnd:<rwnd>
+The last advertised value of rwnd over a SACK chunk.
+.P
+.TP
+.B prwnd:<prwnd>
+Current calculated value of the peer's rwnd.
+.P
+.TP
+.B ptag:<ptag>
+Tag expected in every outbound packet except in the INIT chunk i.e Peer Tag.
+.P
+.TP
+.B instrms:<instrms>
+Maximum number of inbound streams the association supports.
+.P
+.TP
+.B outstrms:<outstrms>
+Maximum number of outbound streams the association supports.
+.P
+.TP
+.B maxburst:<maxburst>
+Maximum number of new data packets that can be sent in a burst.
+.P
+.TP
+.B maxseg:<maxseg>
+Message size after which SCTP fragmentation will occur.
+.P
+.TP
+.B unackdata:<unackdata>
+The number of unacknowledged data chunks.
+.P
+.TP
+.B penddata:<penddata>
+Chunks missing from the peer.
+.P
 .RE
 .TP
 .B \-\-tos
-- 
2.47.0


