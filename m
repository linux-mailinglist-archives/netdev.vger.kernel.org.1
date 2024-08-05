Return-Path: <netdev+bounces-115856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F899948180
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF0CB20BF2
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B4C15B11E;
	Mon,  5 Aug 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3mJIzJKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD813DDA7
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882131; cv=none; b=s4/f4Z8d0HYyO2wzm9WKxqG+fvO0hy22JUAT3QJ5i/bvHqsfWkQHJ7tYVzTSCNToxJ7i7LkCID7Knfu2r2WgDtuXD7ZQYjdFQRtXv0W6j9Yi0/qTqzuMs2EUJichzr8L6IRqSEdbSgaoT1zk+E87BoggxopTN3oeMzK+3I57VVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882131; c=relaxed/simple;
	bh=Kcl00ahqSTBJQSLUynrE7mJ1Xy73uNtuOsVUcu9Xjjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mfq/oxgB3XR3b8ytEjlhcwv3ogBqNBl/zXoqEZAL6Wd8oIknsjj6EmOD/zl6BUSa0Lf1pTnnpUeCpfZZESYqJcOyC9JUv3LUi6Maf0V/TKhjkLabmUDlSVekM2Zelun/voCsDrpwU0QN0HB45ZV996YPmzH2pxo9coCCx5NEbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3mJIzJKh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05e9e4dfbeso18235715276.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722882129; x=1723486929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjfMa5mWYDMjFPxjBHIXRM5aXOfqSsIFPcFyU5WggnY=;
        b=3mJIzJKh27mhtPj27RgT/JUBYpa8qFN3u+qXm2XAjPArAgNarpwYFohTHG2vKUn37n
         8RL246ZL/50R56jw5Hq7F//Eq8cU1pvqQOqAcW7RlAT5bjQDPJhZvcumXN28ejXYoFag
         LfkMH+zjfDriGRM947/jwZKPPmE6OZhayEnskJhdU31S+KcmLleGSlzPFlq2/yECR6HR
         PkFO7eD9Mqo9KenwJdghmhVtfpU7Kt6wwJqLoZ/+9jptkWiuWCDxyA4Hrx1pXnTMB3KX
         VAYWbQRjiTttcTD6vkScIP7jy2vK2DHzTQ5uasstm+HaliQkq4zjd0k1mHQvBV1tTlIS
         s6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882129; x=1723486929;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AjfMa5mWYDMjFPxjBHIXRM5aXOfqSsIFPcFyU5WggnY=;
        b=S3iW1nfhM2QAzuvT1HFyBejYXlDR03oShufabr4/ZeOuTqe+loEQh7K6WVUx4pNPbm
         kUOSV658fAC/w6i23K02sHagANNray5JqHe0UcpaOLh/mOheJu2r0xFzmjcyvr/mDyf0
         9KzYxmQ4USCsJO2icGBB7+xhRgO8dwqSdJeuM4kBDE5iNno520b19Eo6dPOTgtOSq0fa
         EUeUYImMwRIzcK3sHWvBbtWT/Lr73S+/edmwwDU8GwoALLk+G0jjgRVbR/fgj/MU9Ayz
         xRgqvZ5C/EYTsOjApGM/S8euRjEH1/gd9V86WgC4lm6T+IFEOhGf0KWRd/SBMNaw4fH0
         PXFA==
X-Gm-Message-State: AOJu0YwrNI2Qt+87OERV3lfGie3frj7DYdLWaDy/uDVV72X/7lMgNECi
	GTzLnUa16uAzuIbxi9Rt/JXXWakWyURi0JjkkKIufWMLMVOT+3WzxSlVmRZnuzg2TVxdNb+MRCX
	eVfl5tZQXb6pXFIK1Fw==
X-Google-Smtp-Source: AGHT+IHCPNs9Tiq32TS0Ua7hUS/2gdghbISYZ40wIR/JhPaFTyklM+5Gd2j16SBt7KzmpfHggcEHuQWwCh+QTt7E
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a25:9008:0:b0:e0b:f46d:a2bb with SMTP
 id 3f1490d57ef6-e0bf46db4edmr35101276.11.1722882128913; Mon, 05 Aug 2024
 11:22:08 -0700 (PDT)
Date: Mon,  5 Aug 2024 18:21:59 +0000
In-Reply-To: <20240803182548.2932270-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240803182548.2932270-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805182159.3547482-1-manojvishy@google.com>
Subject: [PATCH] [PATCH iwl-net] idpf: Acquire the lock before accessing the xn->salt
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Manoj Vishwanathan <manojvishy@google.com>
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
2.46.0.rc2.264.g509ed76dc8-goog


