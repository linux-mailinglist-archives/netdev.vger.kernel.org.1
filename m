Return-Path: <netdev+bounces-121895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CE95F25F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9591F28221F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D5B17E01E;
	Mon, 26 Aug 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdY29pmE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFC17ADE3
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677640; cv=none; b=rBRkPZrbhghgAjUQm2YoNJVtEpC/+cGU4AkYYwX3p+61AsXHdujqcTHf9FQtbhhGFUe0JHScC8/tB0hA4u58MRSIr+Nz0i6iKMBkvaKbgbE70h7/fcIL+jAHKNeGcS9KRzjxmyZRlwtZ0ENAu2tbFjwdhmTKqEoYmSuWX+G9pZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677640; c=relaxed/simple;
	bh=N758xsscg1j5iUzxcnYV2NuN/BVwUzZ7pjj4u4n0WCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8ugSWGG0XPAAlVnfv6Lt6gL61Zo7kB+jKKnX7/Gbk1Q01AxiYn0mJ5+Mwx6IW1f3/2hAz0e2gXZYxe0B1wB11ClHrWrPjulED0dR5SvOzZrnizBw18LHRzFhaZF9O+nAwXAosYt4kaPB1nSw8ZvfWdDbIzTnPJvfdipW0alKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdY29pmE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724677637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QT8lf5mm9iWDhlz8PS5X1/LO79S+PPvsCnWmobjlCPU=;
	b=UdY29pmEpuLmLZEZTjr8edIhRrHQbRwp+FljPp9BqoLtZkxjZLbMNHNGl7d3oclWbUnfQf
	57lTeSY+djTWo4pNrTZFoTiZnTOrHgeUB1FTlehoTGQXVwhSNxprN/1HIjYJLpOqGUNshs
	oGpOwr0mTnL1PGiPBxB0oB1FhJ1vl9Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-Mf3rFCODMaevJ2XTkPE9jw-1; Mon, 26 Aug 2024 09:07:16 -0400
X-MC-Unique: Mf3rFCODMaevJ2XTkPE9jw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a868b6d6882so626985166b.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 06:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724677634; x=1725282434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QT8lf5mm9iWDhlz8PS5X1/LO79S+PPvsCnWmobjlCPU=;
        b=YTPTA4O8czlg/BkCipc2SKqcKvyHjExy6RdCq5HefZHmlvYYf2xFld2JLj32598HAa
         vaJtANC2cyUGzWuTjbM7K+J73/Ge0G6c2TRduVpdhzfgEzw9z4w6v6BXBuaF8/vh6+E4
         mArjgbcKhz2HealmoeYMRDPSXc0NzbK2zEYxR1Xabjhp4/epJo3mhGHXqAelSUhQzEJS
         i9sHu//mn10WkUEqb/qry7mXrlg8dGTnBRikvtLhkhMzZO/1fOOwkVUUJYXRsM6p+dLu
         VWrDUyCW2PEPz7Lie1dphv/14QOgfPknS6gsRXW9gnz7M1WL50MNw+dYrVZdUbfwMo2P
         0RSQ==
X-Gm-Message-State: AOJu0YxJe9xgUFHN/y5UGT3oGDrdVBd+MO5yp5qSDXOGoPUGeEiGl12I
	qCRZCDjcZzpihKoR9SYnBA8RYR+sjfKbjvDbxW9d07ZLlYcqwpuUcdHPCOxENTmbGbtEykDZtVY
	FZIftImYZdlnSMRSCILCpqk5jnFGYoKvzWcemJ/3UbtqZvuGPJ8VZikiqzpdai8D80MTcAtdehu
	EWeOQOMxmMI7grsoytSzKdhrKh1UnI7RND/3ixtw==
X-Received: by 2002:a17:907:72c9:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a86a309adf6mr1221355766b.25.1724677634381;
        Mon, 26 Aug 2024 06:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfMUDlt8DybpTH0kwcX/XKT6qaULsyhgHI3OUZQq9tkVmm8pYBDmjG4y5t+KIz9vx7HsCF9Q==
X-Received: by 2002:a17:907:72c9:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a86a309adf6mr1221350166b.25.1724677633744;
        Mon, 26 Aug 2024 06:07:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220d16sm664298866b.22.2024.08.26.06.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:07:13 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-sctp@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sctp: fix association labeling in the duplicate COOKIE-ECHO case
Date: Mon, 26 Aug 2024 15:07:11 +0200
Message-ID: <20240826130711.141271-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sctp_sf_do_5_2_4_dupcook() currently calls security_sctp_assoc_request()
on new_asoc, but as it turns out, this association is always discarded
and the LSM labels never get into the final association (asoc).

This can be reproduced by having two SCTP endpoints try to initiate an
association with each other at approximately the same time and then peel
off the association into a new socket, which exposes the unitialized
labels and triggers SELinux denials.

Fix it by calling security_sctp_assoc_request() on asoc instead of
new_asoc. Xin Long also suggested limit calling the hook only to cases
A, B, and D, since in cases C and E the COOKIE ECHO chunk is discarded
and the association doesn't enter the ESTABLISHED state, so rectify that
as well.

One related caveat with SELinux and peer labeling: When an SCTP
connection is set up simultaneously in this way, we will end up with an
association that is initialized with security_sctp_assoc_request() on
both sides, so the MLS component of the security context of the
association will get swapped between the peers, instead of just one side
setting it to the other's MLS component. However, at that point
security_sctp_assoc_request() had already been called on both sides in
sctp_sf_do_unexpected_init() (on a temporary association) and thus if
the exchange didn't fail before due to MLS, it won't fail now either
(most likely both endpoints have the same MLS range).

Tested by:
 - reproducer from https://src.fedoraproject.org/tests/selinux/pull-request/530
 - selinux-testsuite (https://github.com/SELinuxProject/selinux-testsuite/)
 - sctp-tests (https://github.com/sctp/sctp-tests) - no tests failed
   that wouldn't fail also without the patch applied

Fixes: c081d53f97a1 ("security: pass asoc to sctp_assoc_request and sctp_sk_clone")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 net/sctp/sm_statefuns.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 5adf0c0a6c1a..7d315a18612b 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2260,12 +2260,6 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 		}
 	}
 
-	/* Update socket peer label if first association. */
-	if (security_sctp_assoc_request(new_asoc, chunk->head_skb ?: chunk->skb)) {
-		sctp_association_free(new_asoc);
-		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
-	}
-
 	/* Set temp so that it won't be added into hashtable */
 	new_asoc->temp = 1;
 
@@ -2274,6 +2268,22 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 	 */
 	action = sctp_tietags_compare(new_asoc, asoc);
 
+	/* In cases C and E the association doesn't enter the ESTABLISHED
+	 * state, so there is no need to call security_sctp_assoc_request().
+	 */
+	switch (action) {
+	case 'A': /* Association restart. */
+	case 'B': /* Collision case B. */
+	case 'D': /* Collision case D. */
+		/* Update socket peer label if first association. */
+		if (security_sctp_assoc_request((struct sctp_association *)asoc,
+						chunk->head_skb ?: chunk->skb)) {
+			sctp_association_free(new_asoc);
+			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+		}
+		break;
+	}
+
 	switch (action) {
 	case 'A': /* Association restart. */
 		retval = sctp_sf_do_dupcook_a(net, ep, asoc, chunk, commands,
-- 
2.46.0


