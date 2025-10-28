Return-Path: <netdev+bounces-233404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526EDC12C5B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632E41AA698B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BD27EFFA;
	Tue, 28 Oct 2025 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GW4gqep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6AA222578
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622710; cv=none; b=lN1QCdUCfn8SCkK4Syaxhq5rVjZ8PGNOIMK+c3lEbBlM6+MZjXLv//aHc8yJuO83t9xdnZ63qjE6dXNBXjhoVGdeQfm5hIfnj3pwWLthXjDwDBzxqrWybGR9I+HXeagQjwTEMzZRtpgaFHHm1/92eJuZ4475SL+Xsb7+SX664t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622710; c=relaxed/simple;
	bh=eWSq7MSVmTWK5fjLBLRKwzc20yij69/qveXhJcyuJMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gjHbiarpbkoXjA2Db0+AfZOSbT9CCsbW7VvDyRyDZjDRHg7qUdnhEQfoO/p9wofZ6U5rLMGOBX+ynvxlhC+lXsy2dspfDdgYNKlLRhlD1pw9LtzF2O9eXhi5iXEp1QezKTvovOBmjapiFzgGWVtBWBRp+qQJO2c5bsEkjLiuP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GW4gqep; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befc08so12687597a91.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622708; x=1762227508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DrYVzHYvQSOgbEJpOroJFcvcNUpTFnwF3ij/GMX1c8=;
        b=1GW4gqepBM8xOrCsEk09Cr1vvrp144gTtHh8rVE5L2TlRsDkcFf06/mOiEbuta01s/
         Y1DGxNZyNkNogKO3cTFm0V7PSBltlJzDaZRdVqWu2mZsyzdE9Icj+Ff0v/6Rqxkgpjtd
         3vCMMA2UUlH85PqPkWMy2wCj8p1xI4+PClsSYWegWBlaSpWqAXzD993u69707lOzNWre
         YCBMRoFZFzkO/qeVxQ0oXlNN2O2MgQG3K+iVZTxDy0B5numUvkMXei4ARTTlfl6JtsW1
         vMBiXycK/g96rTD6Bq46qf6zGs3An4o5vPj5weAANOgl7bLBO5CIG5MtiMyAt/2gkjGa
         yj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622708; x=1762227508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DrYVzHYvQSOgbEJpOroJFcvcNUpTFnwF3ij/GMX1c8=;
        b=DM6eSzGE3wBY83EGae95rmIN51edwyDG3GbftFTSUmdVLkhqvce77Hzelh7udKdBCH
         AMR+GzPME4cD+YVqbYSRO/r6DJ2SIoSGNCoNAJMyCr5bzXdhHQjYgjcjhTPtXwbfrlSG
         blrgnmuj0otMae3KYV/4sjkOSQVCqxpsaeyZv3S0/+FFo36IwHuWTKsqA8jg8WpRqocM
         +dsOEkDDq9AVVFywQ/xdHKpMXQSP0fVFZyHDo/RzKZ8SS3EDxJuM62Bx/qdUZ/9x+6fH
         V+vrxtm3iLr8XIgZmK8+7asiSMpTBQhGyyFP7Jook0QPPN35LNwu6qyL5Zter4y5LzG2
         Litg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Lo5UzN63vu1I+f2Ds49KE6ywvfPQbGrueZfr+9xHhOvO+SkblgRZ+WHgR56XKo0aJKXbzP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUL4dQCW8JY/T3noadZunQ4U+38O0Cm6Xf7sJ0KeuOnY67Ch0
	yxmPm1OvJPivFVc7a4HvRVv+Hx8L1Lot+Pcvd6F38ItuQgRy9AhmOWo/MFHf+fOnNMpRxNADevf
	lLrbBeQ==
X-Google-Smtp-Source: AGHT+IEITJVP8bvNmIEFi7IMBVlqNt6ZTt5CmavfNcnQrfWwBSQL6jfHoKyjCMwcxJy4BgvOZSyILLUXf7M=
X-Received: from pjbta5.prod.google.com ([2002:a17:90b:4ec5:b0:33e:3ae:9d68])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b84:b0:33e:2d0f:4788
 with SMTP id 98e67ed59e1d1-34027bcba8amr2378690a91.18.1761622708086; Mon, 27
 Oct 2025 20:38:28 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:36:56 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/13] mpls: Return early in mpls_label_ok().
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
2.51.1.838.g19442a804e-goog


