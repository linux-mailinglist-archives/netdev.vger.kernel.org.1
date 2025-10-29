Return-Path: <netdev+bounces-234096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8270C1CA81
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5D15677A7
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6170350A1A;
	Wed, 29 Oct 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5spCwDP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812E34FF4E
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759230; cv=none; b=C4gaKn3aewvrV8rh0Gf7xrQIQT4KXkjSN9Mw/B5JSvJ0K/XWGnbm31KReIqtsNyVKOdLsH9TpzwcZhfSVa5ow5YYjLdBWDr7JOs2+srgEI84kDpJr7TyGjf+C2mecQ96QCl5nEIlc4qISuwfSR/EDf+I82PwWFmMLgYcL9vZ75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759230; c=relaxed/simple;
	bh=q/CXDsv1qCL16uMSHV+WMtYTigSUf3yNcvZiKpfSz+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ndqcGNcR2KmZaO2pO+tMM5UrVtx8Mx4HyTJqFEhqTxULoTTxgSamQx8Ivs5flLIRaiYCn92Oz+h2xFrq5FWPa4AfPlT6QrOx95M1Oi49j38tqwdqgGsAkKJ8zpkq4bf66Ohn9y86d80cBOWMOffZOIqVJygL9G07JHvhxvhnL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5spCwDP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bb4d11f5eso162677a91.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759229; x=1762364029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=evg/GJpg5NDKffS3Q8V90YbIWVDreueo/ov47IuZYcc=;
        b=C5spCwDPI1Bwj1mgwWq+oe735ySyFnh3qAdm3AjHH3H7gkgq79U0IRftiBRikVMnBS
         zdkszqkXF66Ulq9yHYomWecYCHTjKfk1x6Y0q4jyOU5NSfmeVldBHT4tF5vYPTLQyiij
         XnmEjxt67GZIK4ctecHh2+lhtjAR6iW/LlocPtXlESHDnvC9KqzA0Zfa2zwZ9ZQd6R/5
         7bRQ4+vhzfBVAV/jt+EjbQ8eB3TFrwjMFWqcCoQQduD/RF9BSZbBBGsC6T56+RHD7Ub3
         +Mw0Ad7wI0R7UKgVnGr2fNaXTYVwPVyoi+MqbXaGWhh7u6qHIoYaNUkmiqgipGgeNlfM
         pz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759229; x=1762364029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evg/GJpg5NDKffS3Q8V90YbIWVDreueo/ov47IuZYcc=;
        b=OZFBgtmt3HCqKer3/JTjyCTVJw3GYBepetUXU2mmW6vogYzhh7nM0bAQd77DbZ/UCz
         YdGGkJvZ2cV2re+XyHmkdeaJWs9E0YibReovMzIHuHgjEQsNsPeKLviv5997fTIxyJ1J
         2xolri6/r6jIfX7PpNteoILs+EQygDjWrYQD4vzXlyYJq3t/HVUqUFDrbGez76JOVbKX
         A+43znKQyMbPb9OxiJuPS+6wOUE1HusWP3AhBxPQl59wixmEJu1PGkRfSxTZgJGjmb7o
         Rg/fT+GAuHg6UcVb12U+WQ/3EZ3qohwS+GPdNJBMoHSGGl0qulK8zwvGBIyLPDvEcPuH
         q92A==
X-Forwarded-Encrypted: i=1; AJvYcCXKWzpAwfr+pyiKOrRi2Q+Z+xEAXcclBhOZXATrMBi7OiovCSddEXsNWL0dBL4oUjuHMxQtPEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIfTlby7ysnlPIHrpefF2g4ul1cbzU3n4uCVy4LeRBTFiq3r8C
	iRiQv6fZCFiOL0ulU0muY3uE8HdKXly5sRZuFEMiTuntuXLvkTOWKVajBw5tv659lPtXh7QxnHu
	fd2OOlA==
X-Google-Smtp-Source: AGHT+IFMHHw0laZuqLMCHrDspW1hULMZqaMhpynZtwC8WqCzTCo3XMLew0OlwGkuXciizcaw3YLcfxbKYWQ=
X-Received: from pjbgi3.prod.google.com ([2002:a17:90b:1103:b0:33b:ba58:40a6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d83:b0:340:2f48:b51a
 with SMTP id 98e67ed59e1d1-3404c41ca8cmr208889a91.15.1761759228578; Wed, 29
 Oct 2025 10:33:48 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:32:53 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/13] mpls: Return early in mpls_label_ok().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When mpls_label_ok() returns false, it does not need to update *index.

Let's remove is_ok and return early.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 25c88cba5c48..e3533d85d372 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -940,24 +940,23 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
 static bool mpls_label_ok(struct net *net, unsigned int *index,
 			  struct netlink_ext_ack *extack)
 {
-	bool is_ok = true;
-
 	/* Reserved labels may not be set */
 	if (*index < MPLS_LABEL_FIRST_UNRESERVED) {
 		NL_SET_ERR_MSG(extack,
 			       "Invalid label - must be MPLS_LABEL_FIRST_UNRESERVED or higher");
-		is_ok = false;
+		return false;
 	}
 
 	/* The full 20 bit range may not be supported. */
-	if (is_ok && *index >= net->mpls.platform_labels) {
+	if (*index >= net->mpls.platform_labels) {
 		NL_SET_ERR_MSG(extack,
 			       "Label >= configured maximum in platform_labels");
-		is_ok = false;
+		return false;
 	}
 
 	*index = array_index_nospec(*index, net->mpls.platform_labels);
-	return is_ok;
+
+	return true;
 }
 
 static int mpls_route_add(struct mpls_route_config *cfg,
-- 
2.51.1.851.g4ebd6896fd-goog


