Return-Path: <netdev+bounces-231160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0EEBF5DDA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDFE3AC014
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EE0261B9A;
	Tue, 21 Oct 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV0b1/D9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD12A926
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043654; cv=none; b=pEUKFlbBt3sckja0B4qZgUO7Q+IbmKJ3JO3bZmePhfMrdzrVFVK2mPXdG80TalYUIDQ4JV9tzoeshzG+mN+wlCNIq71nFs+nEqOYe5lTXJy5ATNOjLXsJXVd3O1NDXwAkWXRsrCB4TaN4wgKG8C+Mw6UE530TMkOUVOriRW8mBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043654; c=relaxed/simple;
	bh=u3x+mZ9WYaMzDykMD4wrOaaWSHSxUpyWrVYfEbgeV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRDOgwnskmBdrod7Ak1tssns46VCGyL8j3X2xc+ewFf/vA98fr7RDtwGlK2+Q/qwfvyO2F4gzhcwb2miOpGioboWjyUVxDXg1AIvbXKiS+vLdC1oAHM8zouAexjVz/y3XEDGRqKTBOl8hBuBuRFiqRBQMrU3enQhBRvMuD/huio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV0b1/D9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3f5a6e114dso98026766b.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761043651; x=1761648451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYQSYXxT3vBEQ3060Gmkoau5FySMDvalsTXJ7MNV5UM=;
        b=LV0b1/D95OJkJLKTxOL0hM48Qp9nyNgkGGl0y2QALvRjfJOVW65LHLubfJjLT7XdKV
         yt7yWfZfGL30LuOe/jTElJFWM55nwk5w/Z1FP4li/UyJu4nB7tD+ZYByotrXkDcoJQuT
         AMf9OkW1rWNJ5Ot2/F8hMOHKzhkwc2NjyWIUeakRq7U0cclGwUv99S9QS5CsyuOnmfN9
         rh+GvZHS0597r8iYDzBP6lZCYM/KcHPdBacK14QoIJ/MAKsQBn3NekmwuuGADvdyEYPL
         T++csfR2qqXSh50+Vyy671WVM+byd8Z7ZZ8x/e+g8lsMl0eSAPNMlnXMGMlyYJggZAvw
         j2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043651; x=1761648451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYQSYXxT3vBEQ3060Gmkoau5FySMDvalsTXJ7MNV5UM=;
        b=b4BBATHCa01TgCj9xrVn3oTM2gPrK3njGKr2dGtaDoABOdoc1FfDycJAGcCEY3Dih3
         QO3vIRJ+NLi4XvbuWl++8A+UtBEN+kCfKoHwRxu+Pgd/82cFMO6rqut3oIe1v5v6IebU
         k0XHhjRG05tgRFiDynrT4zeWhP0+JFZMxtTspAxrqnNzzVwi3IybASoTxaRaFUGHCUnA
         vyhDBWCA5Fw/DdkJz/MyHs2oEJSPwEGHuma45h+E5WEtiZGxWSov9J0n6cqyCDhFUMki
         s8wCxVhAEECXBPegJ4NiywAMaUqRLp71m1orGwOEUMuG75bg7CN1YTSSP7rRQLSjTudG
         pfKg==
X-Gm-Message-State: AOJu0Yyvr9cfqjjrpyq8Yuokszip7Y9Xz/4L/nAhidVsgmKLXWSr5o83
	tNUmmtzidJeNbQTpsaWISCLqGGQqc1r4ikXZwzNU98tMyi6G2JFFUwCc
X-Gm-Gg: ASbGncso9PBSwEvMCucksB11dIEzNa0DbvLKqWYs+Eil3f7EMMoJYA8PuW/Ymu2+Woh
	CldMea+L4zTbhxZjJn+Zyr39HQct5bCeNDIyIa4SX3Sqh8r36PV5nKNrlmGm4tIE59qgomafPOk
	0Gj789rMaurUMqCcLHyn3XXSIJORedRx/vHWUFFnxA4noZkR64hUNXhAidBZL49HuX62l9szEEa
	gvQTebLavVhrd7/71GiWGv9QXWYC+NILScTEP4aNAfG2sxTuOb4kK7s6Ptk+tyu+Ov9HuM8VRhT
	1ev1cnSj507xxFzfnFWwfQjx9/AV2/7VdJmcHMj0/hVrb55NMqZ+iaFiKuGGhHV7a6ublAG6y/S
	yBRRtUVL54X//c3osKYz1Z0EUmCfzFZdZr1/a6X5OFDaxwgTQ5ivWQa3lRY9OCcknX/zcQ4WZIw
	roAfu3/F9qL4dQ
X-Google-Smtp-Source: AGHT+IEVgz7zYtsnpcehMAmhlB3OUMARV4++YtUV332nKXGeBC2HoEB9fppwF5GU/sp0jIUet5ebFg==
X-Received: by 2002:a17:906:4fd5:b0:afe:a7e3:522e with SMTP id a640c23a62f3a-b6c798e7a68mr191581266b.8.1761043650805;
        Tue, 21 Oct 2025 03:47:30 -0700 (PDT)
Received: from bhk ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da2c5dsm1029123566b.15.2025.10.21.03.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:47:30 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH bpf-next v3] bpf/cpumap.c: Remove unnecessary TODO comment
Date: Tue, 21 Oct 2025 12:41:24 +0100
Message-ID: <20251021114714.1757372-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After discussion with bpf maintainers[1], queue_index could
be propagated to the remote XDP program by the xdp_md struct[2]
which makes this todo a misguide for future effort.

[1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
[2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes from v2:

-Corrected the new comment

Link:https://lore.kernel.org/all/20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com/

Changes from v1:

-Added a comment to clarify that RX queue_index is lost after the frame
redirection.

Link:https://lore.kernel.org/bpf/d9819687-5b0d-4bfa-9aec-aef71b847383@gmail.com/T/#mcb6a0315f174d02db3c9bc4fa556cc939c87a706

 kernel/bpf/cpumap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..ee37186fea35 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,8 +195,10 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
-
+		/* RX queue_index is not preserved after redirection.
+		 * If needed, the sender can embed it in XDP metadata
+		 * (via bpf_xdp_adjust_meta) for the remote program.
+		 */
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
 		act = bpf_prog_run_xdp(rcpu->prog, &xdp);
-- 
2.51.1.dirty


