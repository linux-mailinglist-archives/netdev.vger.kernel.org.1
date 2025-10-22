Return-Path: <netdev+bounces-231802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5CEBFD918
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C43ABB07
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E628CF4A;
	Wed, 22 Oct 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="kixgYPs8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52E2737F2
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153659; cv=none; b=nLOHyvr2nt0oiyfRz09G20gYvbePqG4/ejDWrfXMMIAbtZl17vIUOZWFjZLvbADJ+cAEgXAv/dtCGGyRCAkDa3Djz8i0fi/44EmbgvYz9WGQ7GoPc5BbS2X9DQoFIreqdk7l9JOZDqHDU4L66uW7qQ32uiJmR44KPDqhRejLbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153659; c=relaxed/simple;
	bh=RDxBhDccQNTTmUuAIxDyt/eux6gk25H3gXgQVVgZ6NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dFTTarN/1K306ZKnIDz05bhnQIUoukNllQz0MMoB+P8Tl4g5jqNpxlWIsTcz354ky9C5CBFdLNdX2cQHBOOUSxqmZIeOLA1Xj5/ZiQDmOcjj7B4VM65SU94EaUylWSqNiw2PUATXq7ZbrMZiHQ4YUxbEWpICQ3BkXaSAHiianpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=kixgYPs8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso6394508a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761153654; x=1761758454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJlYAnYJCsQ5KZ0qHSI39aoyPXSaqMpg4SB26b2+5nQ=;
        b=kixgYPs8mdn6hl57T0NZDFEacJGf4SCs+7G2oojNpGhle1SiUeIfER8P28dYCx8Vg8
         xnkuJTDubH11d0FYKR79c7VmGDKh4QfWj3OuoQe0CgrprRniPNEFsBl/5F9vknbUevrm
         VwjwrkW/j+G3FGABVSZqUCb1nh9xIkEVjoPAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153654; x=1761758454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJlYAnYJCsQ5KZ0qHSI39aoyPXSaqMpg4SB26b2+5nQ=;
        b=WZ4DUPdoeS8TQ2VR6Ym+PVZvwJNtxu0ak7nNACQUHUIut7qQr91w4yWI1lPazLjeJ2
         n/kAhXMf4f3Rgm4TLuZ5hsH8ateizKo0YjOaYq4E4mJc9f2JwsLJA6QJxWhCjCtOAacv
         aaOIcZi07EPhFcCjpg4nS8XJHix8F74EiI97U9DhpWPqvk1o0VFXP48X4KKn46ydLJNK
         7zWXUbas6DVyc14jxpWH71P1NrbBU4PPA1uXtXiPPSZxeCWLiwbvcddlfyald1Bgxy+U
         GITWYzloWBJpMp4OIfGnSskfj8+1uqD+KCHUr2/NeUF7T1gm7qC4gh1WCL09iwjm+8Eq
         DJWg==
X-Forwarded-Encrypted: i=1; AJvYcCXljPzBJm2L7ktlcbiIhm/IJYrOM98cUUVE4F968RHEb1r+Eh5uf/uWhUed4BZNYPxwO0mkrRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LzjOn+lggENTqMYT71Uoax69R86SQkw8jmf2nB/Pjy9JX2WN
	z+4VZp52YqWgbfeXX+wTEKJ2LE8tnHhV5AEHT+SYlxWuEG0VBfWP2TWdUNFAOXpuI4wHATF5Qyo
	cQRtv9wvDhTtwBmHKN7hno//p89YUoPkxCR9AeHc0TuPnHY74DdsevrmfwX6FUcKS9rzxRA==
X-Gm-Gg: ASbGncticUWefkq4y7JWrVEudf9qSrAGpXrxx/TKAEPn6AYouJihfzxQRs8GI57S02V
	m5xO5jiYXeWQFWT++5WgxwSzrp47XdmCfv3FhpKtlKM4LWWpyhrbd3omrfjSCihRp8+gV+zz5Rg
	DpHMW7teD0FG564Q3VUBOyFl9tR5/KKmV7E53RNL6yvKL4VT87vD8fIPqaezC6FmPzlAljxSFTH
	++qlp6CFCo8+JlRK4DhUqdAiAM6PNe/xNe/3koY5A832IclV9AunDsYmS7Z0oUfApvUige0zaS3
	qsc1bEPbK2uD1r8tr/97inZCTXz1u5AcCCC8OIk/vmzdVgXUvLkyJY8hUOufmpr10Ml/7GMwQB6
	JT6reNuon49l3oKJIAOmsR3umlUDZ5utNlKrBaU0GH0Hj1f92OJMrXNB/yNZfQAyLowT5wI6FT+
	IILP2Q2DlpoJzY9B8LGhulUXAeoba9KLv8nV0FjY6GEyEWDAUZ/TKyfcb2ro8/RZC7zTgL48wVf
	yc=
X-Google-Smtp-Source: AGHT+IGwPZD6AsalYCzJnHEYLUjuY21HqxLrzheuD67TroTDroqc/7a3AGzGedrnuVb1Tzxscx3Hvw==
X-Received: by 2002:a17:90b:4b51:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-33bcf9237b8mr23362914a91.36.1761153653245;
        Wed, 22 Oct 2025 10:20:53 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:e15:111c:b0e5:c724])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2c3bsm3133625a91.20.2025.10.22.10.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:20:52 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Date: Wed, 22 Oct 2025 22:50:45 +0530
Message-ID: <20251022172045.57132-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"

net/llc: add socket locking in llc_conn_state_process to fix race condition=
s

The llc_conn_state_process function handles LLC socket state transitions an=
d is called from timer callbacks and network packet processing.

Currently, there is a race condition due to concurrent access to the LLC so=
cket's state machine and connection state without proper locking. This caus=
es use-after-free, array out-of-bounds, and general protection faults due t=
o invalid concurrent state access.

This patch adds socket bottom-half locking (bh_lock_sock and bh_unlock_sock=
) around the call to llc_conn_service() in llc_conn_state_process. This ser=
ializes access to the LLC state machine and protects against races with LLC=
 socket freeing and timer callbacks.

It complements existing fixes that lock the socket during socket freeing (l=
lc_sk_free) and timer cancellation.

This fix prevents Kernel Address Sanitizer (KASAN) null pointer dereference=
s, Undefined Behavior Sanitizer (UBSAN) array index out-of-bounds, and rare=
 kernel panics due to LLC state races.

Reported-by: syzbot
---
 net/llc/llc_conn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 5c0ac243b248..c4f852b2dff5 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -69,7 +69,9 @@ int llc_conn_state_process(struct sock *sk, struct sk_buf=
f *skb)
 	/*
 	 * Send event to state machine
 	 */
+	bh_lock_sock(sk);  // Lock socket bottom-half before state machine proces=
sing
 	rc =3D llc_conn_service(skb->sk, skb);
+	bh_unlock_sock(sk);  // Unlock after processing
 	if (unlikely(rc !=3D 0)) {
 		printk(KERN_ERR "%s: llc_conn_service failed\n", __func__);
 		goto out_skb_put;
--=20
2.43.0


--=20
::DISCLAIMER::

---------------------------------------------------------------------
The=20
contents of this e-mail and any attachment(s) are confidential and
intended=20
for the named recipient(s) only. Views or opinions, if any,
presented in=20
this email are solely those of the author and may not
necessarily reflect=20
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form=20
of reproduction, dissemination, copying, disclosure,
modification,=20
distribution and / or publication of this message without the
prior written=20
consent of authorized representative of SSN is strictly
prohibited. If you=20
have received this email in error please delete it and
notify the sender=20
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain=20
ssn.edu.in <http://www.ssn.edu.in/>

