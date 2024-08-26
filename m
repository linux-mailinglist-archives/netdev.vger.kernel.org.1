Return-Path: <netdev+bounces-122006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA20B95F8CF
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD9F1C221EA
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C67619939E;
	Mon, 26 Aug 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lt5E/D7y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275F1991BE
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695843; cv=none; b=CPf+e7K7yrCwH+35+GB5kisbI64zH5NrNtySRbSsi0cxdpWJfqRT2P/3meeyHBrni06aLYyE+GYDKN8XYZ4j5e5QgucnmCBL+8dqIQDQ/FMzo0tDpHEaISaS4b4SR4W9EFIe9mfnKTuirGr9yISCDH7EgcLimPzSnJuM+LibNJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695843; c=relaxed/simple;
	bh=rBirqSx11wJjgEPiT1TIlTne8kGylmF7zSv1EICuWrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=py1VWH2aYvu8wC9AF33WSrNteWUPghS7KhUCbxvZEjILiaKBUbOxrHPZrXBCOlABJwgLxMVK7wsZwZB5w0WTlEkBPnnS7xRBQtbwgf1FMBd3u2dHxxKxaEJWFIgJGSDlrQXLCsE4SKdKZ3oesb9dpTMQx0eYyTU2cMUbTWpPklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lt5E/D7y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6addeef41a2so89084437b3.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724695840; x=1725300640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaxxGv7jFfJqyIYiIuAizJBdptFEUd7hS9a99HmhF8g=;
        b=Lt5E/D7yDFwPY0izU4PU2XH6yhGmTc6L9A+16MCzixBxKkzPoaIebTqtE9fjfhwZRb
         4LgVWUp3aXbKuXmz5tAUeCnVOS7l+FtRAFeTtuL4wYi6e+k4No/crJpykIVcUgw8xs3w
         o0bL9vSwlCSzNc6JjT28m9HBEBRlaWICK36k5m2g7GcnyQTSeGGORmHgwsp8d7kzzks1
         kPMoc+ukZJcxiUZEhxH3c0cvzWvnEMx7wmAMWrmBGrMQChFBIObxUZOzMjHAbcedBgmM
         psVud87NIZ4jv5PJMHJGOIwDhF3jhkVcFR38rv/8WR8pDCZ/3VXuBQV0e3kkU/kMVSGj
         Y3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724695840; x=1725300640;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XaxxGv7jFfJqyIYiIuAizJBdptFEUd7hS9a99HmhF8g=;
        b=XdNB+CPW4v0c2mvkd3wZSOinLOZs8tGsiqqfckztFxQZTI0drBp4+oNVTg8mL+5wKa
         6OITlWTrzsaxe8fHhCBJ6GYae5YI8rW1v/tQX6f2CjIQy5I63Gc4EntBzuQ/pCYhGfZp
         VPQCySPbmHn5vWginWzINE4EonF+ezLIwTNqYHuR6hnrcclpDwQ5Fd5TilWGdTqvL7+Q
         E/ukfHSL9IBSm4gEEQboF3aXC4UNnLNEhyJXEvAyUvvFjI0ctTg3MBaejxRTdmmblN9N
         vInNyqqwEz08P8T42NBovcNpG/8HcwJqG7uefC4oF3z9E1V+2RVi4wGzoIZLIOTutrGz
         32dA==
X-Gm-Message-State: AOJu0YzHlabGr6NxPRD+ArQoFFrH8Yf+SpEAWebR0wgZPugSk6nMl+Co
	f4N/Si/BSM7ooLeMl2FkUTBFN8JcgD3FeXD1w/cmt+fEgUiIcAS0AHUBfpeLeE1tck+IGaY7jag
	PU2NY7zcAzaHdy8yQPg==
X-Google-Smtp-Source: AGHT+IF8ZV8FsZbdR4VjcVdwhThUJ+yFCGwm3hwa2GL7dij+a+kUwRzolQFuh8av8q6i/+SntdPLY+t9PpMbMqR9
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a05:690c:4a05:b0:6b0:57ec:c5f9 with
 SMTP id 00721157ae682-6c61eed1562mr4756357b3.0.1724695840610; Mon, 26 Aug
 2024 11:10:40 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:10:30 +0000
In-Reply-To: <20240826181032.3042222-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240826181032.3042222-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826181032.3042222-3-manojvishy@google.com>
Subject: [[PATCH v2 iwl-next] v2 2/4] idpf: Acquire the lock before accessing
 the xn->salt
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The transaction salt was being accessed before acquiring the
idpf_vc_xn_lock when idpf has to forward the virtchnl reply.

Fixes: 34c21fa894a1a (=E2=80=9Cidpf: implement virtchnl transaction manager=
=E2=80=9D)
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/=
ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..30eec674d594 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter=
,
 		return -EINVAL;
 	}
 	xn =3D &adapter->vcxn_mngr->ring[xn_idx];
+	idpf_vc_xn_lock(xn);
 	salt =3D FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt !=3D salt) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not matc=
h (%02x !=3D %02x)\n",
 				    xn->salt, salt);
+		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
=20
-	idpf_vc_xn_lock(xn);
 	switch (xn->state) {
 	case IDPF_VC_XN_WAITING:
 		/* success */
--=20
2.46.0.295.g3b9ea8a38a-goog


