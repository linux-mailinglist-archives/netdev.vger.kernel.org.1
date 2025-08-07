Return-Path: <netdev+bounces-212004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC2B1D170
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 06:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4269D7244D9
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 04:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E931145B27;
	Thu,  7 Aug 2025 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKNFitms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450C38B
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 04:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754540323; cv=none; b=W7reAYVIXMY5v7WlyzRZceqQytbQ/jmIkWcD7PiaRYXHvCRaEUeNFJwB/IW+TBxWjoFFiO64sIb+0VR7Pia7S+pJml/9s9XDbnEtYgwTwg6poNpD+DI0W4j2RTwJMFFV/9DS4r1GB2NtHj1rcf2JwuxbZYMDkIVyZX+bwVWgarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754540323; c=relaxed/simple;
	bh=1aSYLmy6nmg0mnwdgolOHyvzXCU4qbvmNfWk6buHsEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgwgAX39yoC5MfMbvt5gk2wPt46uIE9aKE6idAAQMWMjKIFl+sdAHMOD3gc1SBs9Pn1y4OnxO21bf+CoQuwW8y0X21ey56Hp2+Titcoy/mhCCMbmJ+DVcRmKqUm3vt52DttciA8yQLDTD555VsDjUs46w+Ak6ugH85WwY6vga8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKNFitms; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747e41d5469so710279b3a.3
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 21:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754540321; x=1755145121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxdPCnd6MjQ/q3ycllZoLss2NY/9SdqIIBNXML7trpA=;
        b=DKNFitmsjlgtkFP0nsK6tq4fTisaK0DrDkDEHDksTzMr3vJXgN90oEOUYxTttpMsOw
         ikDfJC+oRXjjgnC/FIscWgyERNeOXpY6K/HCaHpBB84m6E//ldBQR+BuDFJZZbxQhYPn
         4Mxacnc2/ygyXV2AxTVN3AwivHewHW4DdNT0FPVgbo7UTBA6pQLnKV1zxp3Jr/7JaVHB
         HulVF7m2dz9wkhD1gUW8kcISuEcNLoZtGp9eAzD/NEP3fNmsfLY01r/yZNys2gxKvxLP
         9t1m2OqURXgvgpAIwKOsk/UikThnkHZzjTeOL7gm1BEh8qMqODsBf7fEHXFOkkEQqmlD
         oipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754540321; x=1755145121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxdPCnd6MjQ/q3ycllZoLss2NY/9SdqIIBNXML7trpA=;
        b=YLoPc+XX1sry+PnrhO+WV4XFJQ1otsvfZloq/jjLr6DvfDj+yEWrkbblT/Q8DU9GBj
         3hEsJQYI/tBLX9/qEAT07KqzWetmPd3KF0Ykau0tnAanUJqSzaetfLuBF/Up673a0op4
         WpwrEwtJykZuoX05x+SfyqGXZPFGoSii+JKFaKybFAeX7hEIIMiSTxke7l1myYpqfs9V
         FHz1dz4iI0XAP6H/UQxfunkOy+NnGOw2GH0BrK+7AsS2AvD1OYpacDZ04xm+aikKSEpH
         V570qKjCdmPmfPETJOj1Oy/l+CGkhJmoCSIa67ZX55h0jfUtVTCW9F8I0b3OKVEiv+ZM
         RqXg==
X-Gm-Message-State: AOJu0YxIHZgvFJMJhoJQKvLefF0M70z5vhwrOx99YdnxJpO5CdX9GWfF
	rGx8uT4t3h8bwC2xsP/SIvt495MRL+hgRAYF4LYOIE2h0MhP6WiZgoX6vwq7UOgb1Q==
X-Gm-Gg: ASbGncvgAHUaY8CcDsKVB3J4N2n0syCd4734EDi/CjZQecFQlHUKPMhDwuucM2gw8LJ
	ERFrv+ctvJAbuLBwhAvnZVMXMdt+gq3EH/0pvCXex1UgLbe3KPd/5JSyql+S2e3idbPRS+3V7Dn
	LxYLLlJL71LtxhL16jvikWgJC7g4tP8BNy4+nWiYuApW1xYAqJUBWE+963mafLhFYBNBvcOglde
	dsY3z/q2uWX0f8gpAIYgomOW3Tfql7S6ugRSYWCdSZ3pxgH9YJ5MpkQVlTSMIU99RXJfAw/7tNP
	JBjRpVYAkFe4+IsYr8VF17lmvngL5eOstRwynhEd6j976VKmTlct1A+qvsAn2dkcpdKOKF6WCkI
	XHwHEP7RVJ2rQBXtGh0O22MS/ayTz9Eg6RqA=
X-Google-Smtp-Source: AGHT+IFINxA4nd/nxw+I9crVStmSLqQ6lbqz/NzkCVW9BPI0nAWqcEQTRVAbbzvGRKW6Gzh4AHxt5g==
X-Received: by 2002:a05:6a21:66c5:b0:240:195a:834c with SMTP id adf61e73a8af0-24033184fcdmr7161442637.43.1754540320634;
        Wed, 06 Aug 2025 21:18:40 -0700 (PDT)
Received: from gentoo.. ([138.199.43.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm14834424a12.56.2025.08.06.21.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 21:18:40 -0700 (PDT)
From: Budimir Markovic <markovicbudimir@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	Budimir Markovic <markovicbudimir@gmail.com>
Subject: [PATCH net] vsock: Do not allow binding to VMADDR_PORT_ANY
Date: Thu,  7 Aug 2025 04:18:11 +0000
Message-ID: <20250807041811.678-1-markovicbudimir@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for a vsock to autobind to VMADDR_PORT_ANY. This can
cause a use-after-free when a connection is made to the bound socket.
The socket returned by accept() also has port VMADDR_PORT_ANY but is not
on the list of unbound sockets. Binding it will result in an extra
refcount decrement similar to the one fixed in fcdd2242c023 (vsock: Keep
the binding until socket destruction).

Modify the check in __vsock_bind_connectible() to also prevent binding
to VMADDR_PORT_ANY.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ead6a3c14..bebb355f3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -689,7 +689,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 		unsigned int i;
 
 		for (i = 0; i < MAX_PORT_RETRIES; i++) {
-			if (port <= LAST_RESERVED_PORT)
+			if (port == VMADDR_PORT_ANY ||
+			    port <= LAST_RESERVED_PORT)
 				port = LAST_RESERVED_PORT + 1;
 
 			new_addr.svm_port = port++;
-- 
2.49.1

