Return-Path: <netdev+bounces-111015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AC292F430
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDAE1C2207C
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB35945A;
	Fri, 12 Jul 2024 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrXDpaWK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB77C8D1
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752700; cv=none; b=Mh8nbwZJSFHoi7soZ/E6wG/SH0I8rUSbbzdFLy7UrzrJ2Xo2U+DE+eIiyV8RFZUNkqPEM63Fp/yL317Cuu5f0xYZgbtDhXEPKkV+BHhr18em9+27pjqlZtNRbOY9CqGTbiUxbRR2Z8a4xSZCZMZITE5hbckVR//Cyf8sWcbd/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752700; c=relaxed/simple;
	bh=lY42/By9JtdK4d4bhg7ZM1sr2cWBf0pXTfnlotNosUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sq+E3NH8ZENW35LJhGaHcBan9ZH7iZ4DAW8pIJIiUezFLCqPvIfKC5Ealb8+Hf4fOboQSAuuf5GsdfLbS93A1/gX2F9oqQzJ1BXRgbisGFveQM+K0JFdz9BM7r015gzgBnKp8Gk1Yu0skCCwOnK8DPwFlaqjo4eo/h/K9IH8IpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrXDpaWK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6501bac2d6aso18014377b3.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720752698; x=1721357498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wfGIYHAsP0uvUmYT83Hpv70MkEkseiVLdINBjnhZCk=;
        b=wrXDpaWKUrvdO27TNyxDTMYBflIF6PdpfF4iPrNMhSzYcP6A5FL4AJqJJ1hYmx6B3r
         TeKjlbeDv1b3+c95R4lUX8A2RH1bykl4LDdiCqmsXj4Bnj7Ybko3g9z/RdBSpwSDE8Ch
         fVcbxFepnYWZKfrsuI13qFjSTwenNPdFvmhNBV8hWlJWg9fpIbHEP40HvfczN2PgX68H
         +6JpZ4m/XLlKHKuTv1TWI/WD/8h0mGrBYc+G8sG3gKIUN6t0jkP5rRQtxWxDyoDnGAPr
         7iM4BtSXg2hxJt0hKTsaUFwhXde4sVE2VHupo+Iop0hUnef0+Nvte7VVeLfdtJmxsCDN
         G0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720752698; x=1721357498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wfGIYHAsP0uvUmYT83Hpv70MkEkseiVLdINBjnhZCk=;
        b=tAKZ9/dgmjgJ09txfSS5dQ9+Hf/jHqF5ox+M8W/+PD41e514NJztShx1P7eIFewez7
         8OIKbMuSkdBolvZlASqIExBHMK1AVhOTzWrRFAr+yk7O3RqoPjD54R1HxBu3uBvnFA3n
         MyiMfOCI6u1mp1qJ9s86GEHjJZbCieJrSGh02newUjMwkxomOz5EjeDxM12f9VRH5qBl
         ha73wsRonwp26SAMta6SzO8mcHimnc1MlfiZiidtYMU0u4q5ZQPeq6cGEHEURnT+vUBr
         6d/z2V4Zueye+01uyWSDPogltSJMtc2Tq9Y5jc1qdmVfoW/VSS/5flSYdW/dFkTHFJYB
         JocQ==
X-Gm-Message-State: AOJu0YyqL7i4v7wOTlCpO0uTgJcJGY3balQ+V6ewxcRG2mejB4vkpkmF
	i7HTZVCOJ/Gg0SaqRXPa1f81+vH8PGMO1+TkvO5LT/FWqwEXaIJ2sBv4jZI529ZGSQRC8vCr6pR
	EK1T34L+9roOTLdBoHphD995xwwpu8asyXcVqp/fUW2kq6pGaGxOPtgwVg/nx4dyGw317Ma3zX1
	paj2UZndB0vX0jeJVp3WwXDjBZVF01oc0Q
X-Google-Smtp-Source: AGHT+IEMlj+g4IvcIQkRixKXwIJVkhEWqD/XSWjU1ABRg9vQ1jI4xIGpx818oUKDOEIbQzfcXKOlZk/Sg+U=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:690c:39c:b0:618:5009:cb71 with SMTP id
 00721157ae682-65dfa1d7effmr669807b3.5.1720752698062; Thu, 11 Jul 2024
 19:51:38 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:51:23 +0800
In-Reply-To: <20240712025125.1926249-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712025125.1926249-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712025125.1926249-3-yumike@google.com>
Subject: [PATCH ipsec-next v4 2/4] xfrm: Allow UDP encapsulation in crypto
 offload control path
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
Content-Type: text/plain; charset="UTF-8"

Unblock this limitation so that SAs with encapsulation specified
can be passed to HW drivers. HW drivers can still reject the SA
in their implementation of xdo_dev_state_add if the encapsulation
is not supported.

Test: Verified on Android device
Signed-off-by: Mike Yu <yumike@google.com>
---
 net/xfrm/xfrm_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 2455a76a1cff..9a44d363ba62 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -261,9 +261,9 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
 
-	/* We don't yet support UDP encapsulation and TFC padding. */
-	if ((!is_packet_offload && x->encap) || x->tfcpad) {
-		NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
+	/* We don't yet support TFC padding. */
+	if (x->tfcpad) {
+		NL_SET_ERR_MSG(extack, "TFC padding can't be offloaded");
 		return -EINVAL;
 	}
 
-- 
2.45.2.993.g49e7a77208-goog


