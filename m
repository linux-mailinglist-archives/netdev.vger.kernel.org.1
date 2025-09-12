Return-Path: <netdev+bounces-222513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741A1B54AF6
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C145118921E3
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BF2FFDD6;
	Fri, 12 Sep 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dK4PQPEk"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D0277037
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676295; cv=none; b=eUiDuC1oZJSWXKhcWA+wi1hO3EesthIJHLmUoU1O57hfcQKYKyixvSLHzPWxLgWAXzhP6RxL/PS1ILE8ijnDm6dQzhc0Ili4uzEK+lMCe38EqoOIUD4+xjn+kOkxjF/LcSLLvnWQlyscBpM+UPq7Hjd7W7A+T5WcG87o6/RSKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676295; c=relaxed/simple;
	bh=coKTyHs1faJP01B5jxo/rppsDtzECKhjg07f9C6ZPm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=FEkvVlu8qol7Kvp6l7qgfTzTDpWqkH/ga0m9MWljAer8nJgS95LxT3q39L61tfYJufGNTy7RcrXo2lVGVUZgsFSRyvY6SsszTQO1o6IDImuBH7PVpOcsrL+YVVPi8xF1fcpvdGCF3ThRloR0Qcea4dTyr/rmlqhPlA5204HSi/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dK4PQPEk; arc=none smtp.client-ip=66.163.184.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757676287; bh=zZgmIYfp7J+vCnl6qxhrxXwtx7T9jAwJl+n3MuwHay4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=dK4PQPEk268uvCKJX2kiL2FPA1M66evil6j4jqZRhn5t+HVo5pOQxa5fmKBOTpgX+dbQledtvcV37EHviOINagS8MqSNlPytcqNmlDCNNDVDe8hEiU2kpakHjZ2Z+nBi4XjiSVqvFf57EpnKGHicEPeppPPg9wQ79Vm/odiP4Ywc0SzONpMcvdIxHoV4tyjlQTuHL/gtCZnB0/XRWi9FOwIqF3zObGY3L0Igq4Bdaw1U29SkbE3XSk/USR9xD/jNzCNw8Eud7xAF/2rNt/NxIfO7O6Ht/9EmC1wP70a3CT1MsrPq2hCtUSEQYTbFnCGJN+fyFbATEV4V9NWeulNfQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757676287; bh=83BOCMwBCZ+/fR25gzlXFDOA73gxdzllZB6MbC8CkhM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=uaAk2auIR9MXr1luPpc+ITgQWbCYDS1LoUQx107mO4pfoIJ+QhpUqD5qQ5VM1TfCuS4VmBEfzCff5Qf9sFvEp2aMU4lFhWYNN9EdNkeNHyTC87iYP1FkQazkrKsxq6luU/hfy05fltPXGkW7BY273s9Z8dGffnDj2w/u51VKG0SK4sUjMyYSC8PzWdE+tNx2FisAzriZon+p3KxdkWIav3G72GEfBwjz3woQ/jd5Jd8ZqjU9FyQ09GUcC/WHXQRje0ljJM9PSCG803xBMNMVOBJdZZA8WdA/aMm1QjenXFQ2nRy2+34ZB47/KNhBRsORUF/+gXtwbAexufqJmmMS1w==
X-YMail-OSG: mAtmWTYVM1mLyXzBvTO7WUoG5u0VFkctOEPREUJtQYnP44rTYFNfsn8ocFDy38k
 OjCwQA7cg0eFZzpevLBEn2FwrKaxQ_NwqROaeyOus21vZcWWdgFwacPgXgZy83CHoGa6OTmoclv9
 njApcHx1XUbaWDe8JsarmcoYAo6nClId7Xvu0YHT2p9iwlW9vIu5f39MKz4FuX4ok0s2PJs3QU.v
 6ibpu.VMhY4W7ElS2PZqDG1EvBjV79xc3GV0RaJM4wDt661ofnXPCSgTAEE4ZwRv3_eqr7WVC2.3
 GbvXcvn88xL2fr5U_PFZHSUaHbSMY4QIGl0u0C8B_zz7GbM.cejaKG90SKo_NNLG5OV7P86mJaQj
 FNareSVb_nW891CwTldPy03Jmyu2F5pf01_1ddyDXsgPRNi.Wke3cl9DyVtQ5rBA2SCUwGZkoL.b
 AuW8PhzeUMj5hi4144dQMoh4Lr7Db05D6UXDqWQgo_c.loVVGIn5Gygd21uo0cL7zqy1Lj9Mn0ka
 UV74tvV3YMaU5qhXFzC5FIZ.7sdbrbMb.GJu3QMP0RTqRy0tvkw6AlirSUrMrDhASsD0RQel2dL3
 vZ1kziACbFB8vovHUL6w.eNLQOYldPbA5rXksdvI8AeNeNVFeTxdjMaienYEa_ls1SaOAJkfhxvf
 i_GBUbh5hWtSzhTlZ6g5DFZYnlhl2g3cJY5XVAmb7xdeu75QVRFq2fwZ7lVx7_KEGFhCyf1IJtfI
 YXBhSz4uSt2.pTxUsmjVDy3Iykfdv9Vo9Q4JPnGsIAY66zuePbv1yrBPFWO4SJrg7HH_bUooC2pe
 6vCLWiZ8.Clz4yMRbotBPdhlHgl1HXQ.WHag9JVfTEk0msreoefaGnUc4WQ7q0At0izRDOx4okB5
 k57EbMa02gkV4JGzGbJP213xx44NwhZRcsSS9Re6kntUh3ArA55e79uaMdRzofwaXrFXlELDz.As
 S9_YSDMsDq4QDEGiN9EJtDTBTlbbqABJjB6WeqOMzEsGLJF0nGAZsdq8AfK904Yj3cO7sxToI4lD
 IrRP.ewwQShrPhFpvBpgmWLBrrIjhPse2fuLZnK4GTOhSmx63ci8hu3aCKEEZCa.pZhzxfHKBPGP
 _JluNfGaLZDCwChrDggJyeT49PtK2qNKKyG5btIqepjmdIgTTfTXo8D99XAOgJXdrVCcDHlePcqs
 Ujnxg_gTGiSwfM6WartjGbk_f1FwnHRC6nDGE12pb_15sQkyIKTMcWuULyPMofAhKO4xBdU0fktn
 tK3w_XGY.eltne1CcU9izwXWtRjC7hj_S4SPPGSsNe8LiXWWHlH1oGnAoQM84rAKb16jPjvUld4x
 EIDcuVa_yl_Qe4QGo7Ydwe4OGUL7aYoO9k7tGTRYHWkv4n62i3jrqzOCLlr6Dq2evuqyreo0m7bo
 07ueGC5Ca9gN.Fb0CZg0oAHLhDqeRkD5_dIyruoeBL7CGRjnByg2B_PQCHnyjq.SS3sKR0C1U6g2
 hPkMI1jRX6IUE4lHXNCqSj8rXNYYhohYLNJJRVSNMKYgPolDEti26l6agP6EQzOSdzVjIoxxJFd5
 Tx5oEkGe7GBxGIyChCANtOLLJw2R4i229izUhw3im.k.OknliW3_.RKsRNfcj8OWJtaMuZ_kOyZp
 pM0CjiLrRAsEOIg_CZePgLw9cHKhtTbhjy2DTQvt1uhb4XtZv_2ihw6CQR3f86yrpG0Ypei6Pu6S
 FBOIGOHh2vxjKCV.AVH0CNDkXjzoHelBbcKos1nHTLoQ8I0blAp8axzJkUp48gKvZy2ThfzacEDd
 0F_k2EMedlQo9YXr8v0US7gEiM5VUx59_gU2PNZWLzTHUEyaFvruJompbIoYfdqH0EUrY79ox9WU
 j2VsZecpbY2dp34ZnCZtG7sBwsFieCU_6gvFiYJNXcmiB6oBcal1.hYuWBrMARObSjfknXuiUFx7
 y77XswzPWcLuaVxdhQcHkXhSXQwLaRKo3Jft4Glc_l5uX9d0.s8YuVGTmYfHR5ZpIPf980E.Qwsa
 Y3EuLbGNICNdRIqedYRTt4QI6k2MRexkd7cgAtXgxdvHQLNnCn1F7aulLNgHItnv84ykS_S3SYKd
 xw4XaGbQLbtA9zVHg3Zi0BDkbR5mGaZxDAjCq39AU5J57_4I9i9mbjKiMxgMpa80po.ivhAHCf7V
 FvoT.iLvPMZM1WdhZG8cv2NVkM3VFxXnSRBhL
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 31139eda-6e83-4665-bccf-c44782cde313
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Sep 2025 11:24:47 +0000
Received: by hermes--production-ir2-7d8c9489f-pnggd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 93cda13a9625b3ea865113cded111022;
          Fri, 12 Sep 2025 11:24:44 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	antonio@openvpn.net,
	kuba@kernel.org
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v2 0/3] net: tunnel: introduce noref xmit flows for tunnels
Date: Fri, 12 Sep 2025 13:24:17 +0200
Message-ID: <20250912112420.4394-1-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250912112420.4394-1-mmietus97.ref@yahoo.com>

Currently, all xmit flows use dst_cache in a way that references
its dst_entry for each xmitted packet. These atomic operations
are redundant in some flows.

This patchset introduces new noref xmit helpers, and incorporates
them in the OpenVPN driver.

Changes in v2:
 - Fixed docstrings for dst_cache_get_ip4_rcu and dst_cache_steal_ip4

Link to v1: https://lore.kernel.org/netdev/20250909054333.12572-1-mmietus97@yahoo.com/
-- 
2.51.0


