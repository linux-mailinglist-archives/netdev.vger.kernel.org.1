Return-Path: <netdev+bounces-221071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB2B4A1A6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8703AA426
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 05:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9E2FC036;
	Tue,  9 Sep 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QcTIIYB/"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-47.consmr.mail.ne1.yahoo.com (sonic306-47.consmr.mail.ne1.yahoo.com [66.163.189.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29DA18A93F
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397364; cv=none; b=lFkfD20XtfIYN8KTdPnuQKV+6qGyz1VZqGw+DtX3RV/ey1Hv5pUR1Nqci2vzk4pv9GCcoM4ZWMS0HKs3W7qFGnMWs/JZyxwqBoxCKcNTYYYITInr75kDYuwRkVD4eNgKAauUMowtrfAesaMo/tHL9CW3/rIpffCSqWJSc6P5GDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397364; c=relaxed/simple;
	bh=3hJ1hPow8u7qiqeeRV7ahH049BdwE7zqO7bFBfqWiI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Dfd+lhpY7yZwsAp0XgFNmZY4fmor1Sj5/H3dlM76Ultdp+W2zfkXK63Diwj5+azQ5cImSZTkptXSP9auRqnlHqj1rWoPRCqAHMFCpfZhf3dpbUE15Pjkmme2OjB8n0AV4ki4fdJOQIfdOM4Q1WQkBYnBtmvbvL2+wyvOQzKSijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QcTIIYB/; arc=none smtp.client-ip=66.163.189.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757397362; bh=rFRSaLirJTEgqBx01ju490o+oxzXA/ObHdPNIS1fWR4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=QcTIIYB/CfL1DOXZRXYaphJ1aM8BZvWmEsAvnBdLdNGVo+WnO2cpSJiEHuiK/S5jD9xs4MAKgHrA9IrJ27onS3kCDkotFHACtn7m260yuZ0mAx6y4ZFE3cHlErx0J4pifBUJ4aLZiUiIW+olo308Q4V1I4JUhT/vJtkld8JD8qTxFGRZ+/YkBssrTcRoaL2Q1GjCmwPL0Afda5TkLdg151e1KnnPmLRJ3uwWndY7tfycsOIFvH5S6y3X9S5n1GeR9Zvr9gXxi0nVmAnb3nTtmfxU0MUZ9UH+pgLwh6U+X4uX8knhU+GUleWnQcubBu2u6irgrwHSSOmqQ3tyF+xryQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757397362; bh=dp5nhxedkfBoBW6OMbWiBZgHJi7BztLXsoBVvsvqSbd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kYKqGp6Ei6BcxI0Mv1OYjXsVHhqt35skSVQchxD4UIlkPayg4JjAyDilV6vD74v8vZSKBtVtFZK/cWwcjSHtuy5CZLkHDDrNYkPcVinLNs7p+Ilc+iz+yqTu+0tSZR7h9m+KQDDXiPe0ULeKg65wnoAKUjritgoQO7+Mda8DrBIN2jxgRDth/DgHY3cGewlOez4LTVk5YebXI9LvZSez8zaAGanpJH0s03v3Tqj3/eaWeqQtb1XNlhRN8EV9ZWARMPMXVz+dlR/2SO6tQIRBJ0gYVOzalqu0MCoYFXZsOZ9tv2lIkg+bN15Ah+Jqh0oebyQYvft3a34HbdgRwq4f1w==
X-YMail-OSG: QesTo_gVM1nzZA7wzM7moBR6eFaK3omeaLg05gniS1ukx3r5JEJzK9eJA.GxZQj
 qh4VwJC8bX3DfTYUTT8v8Q31VRTITkDAU9O5qpcMw8b0o6uJhIzn9PzVtYR8KU6JZJfH3D5xMiZI
 PuzPAEv1_QMVhty3RXhiXavGbNEsoIbwUzUGHy8wEiOkq6FiRb9vAi9rroJ_r9d7V83Kv_emC8dk
 uEZWk61u0wQHBfJcfK6PICw1VQbROyvCnygx.87OnoWi8YtK1bZI9MpG3o6XAQRxRDsZRUwHbLVS
 p_yBxCt9m3rf4GiqF9mr969ZNfqhsSuxwZjzJq26_S0dWeE9W.jj2f0LjMM8FaZU_JquWy658Wyv
 S3EJuHwL9MivHYmYtscmV7XOxY3HXFyz1922xhGouWfYfdjOqXpjWUKhMCK7wIV4J.UZuwUzyZJj
 FEPLyCAmVDEOEp04W1gOHlYsNdnJrcEXIyO99o47WO5z4ujsywim9KYFhzU3JQzIYl51zzSjIQ2W
 nJ.mPLr1xdeXNiG_39.62N2HBNgdwMRXXQQLolv3flqPbD4GndI6zM5Ue_cLhCH1POslToerZhRQ
 vmCTbfqfDysL2rZnxFSvO.cqrwO3Jl46CRmBhyL9zlGsYkdC_Xk4n_8AtcaCNeFTW.uSw7dmNscv
 Ag8TmYjURw1i2oWdEGXfMnykBVAzYKvHrxvN2U6Ax6K4v55W1eFRAGs7v9ZSjh0CZ_5_ajUUU6gi
 EGDwbd8jhggv8hgZKGPWyCeidnkVOF9_x2Dm7THpiIBAfjMqHXL7gDnoJKHYGX4_xl_bplvvsu1M
 oWzVZKBRYbf9YOGIGG7kteewcc9uBRTBYApe98eShRE6PkmDe1bvdupIR0MGIEGslA2EMzXxZSRE
 fDQ0g64KUfP7Uvh6ligI8txfi1aKNqDKvocj9j6iCbaVgJbaIQ3xkl1Lkm0IsBLQ_0ftlexCsBUd
 fuHIDI6LfCq4giHY86WEBwR3qylPsOrw34BDiw1Xe1yQN0jdiIyqiDsRWygMkImqbFPEOYYXLamq
 QiTiOJkF.Q6Hqu1d1E40jfSGLs76WHEwIEIMoZA7dVLFC6pXlwypMDViEAMAa6gnPkPDGNf360mj
 T5DdBL2VhNkF27.7WcoLUU7sy5cahbs4SxjaFnQFlOc3hyR3QdCMTRt1sWAWzbWhrcde_PsjYZJ_
 XszpBhozEznn1twHkBbx0_sm12xSzQIVzZ3rcJGr7AWWI_Da4Sn_NXKBBOFSCh3kPAyv7scoAHSa
 UmrBZsKv2ootcBuuild6fZd4IJR9PxtMvfsJokdXFGxwFNntUTyKlhOI2zz3KFw4pSjLBTn3zc4_
 i_aLBN7Joj0tzSDNQ6giuQm0lgRlaSv5v9t3X8Htt3OrLBzx9jvUkuiWpyuxdjfS8NtlEOb2eQ6j
 6xpwREfEXaBDpSmm1wHpv5g5d6svn4CTeyrmWpBrM5e5llx44JQWFzGe.KkMaVuTnFEQgF35RN20
 Kx.Bopwwv3b1H5_0_.uV2oO9xnbLP9WPwM3mjUN3Rd8Def9e0AzPKgAdL730uSIgiLpTW8Kx_5le
 TthqxT6ao1la.ZcQhD.m0Ho2YSUfHYnxFKRCvacECfKtY9sYTZlw2nnkh2ucJldc8.hVqrtoxsmj
 KWlmrod.bFr4tQ8Xjrw6E1KBSXZdKQE0YX9jSSuG9B2uiVyUbkLmbVPSbXyPNqxxfBxEK7MRh.vD
 HVv9er_glF2JhF2iLIw8ZEF726TqT9eDxOe8HYspYVDCHC1X3S..An0OBafoNUwZfc7FXdWwE_iG
 Coi.HAuyTRnFTKoQV3fhEipe1DyeAd5SlaEWBj3QIwjVEHhjMknEcAbgF3ISemn.MAD68QaRhpzu
 lIf2p2wCGb_8HMxBkFm_l5FiPRQayZKSBwsSN_7n_ffZvWgH7CyUCNNMUOUJn7eDDMSA1Vm4wtvo
 LNYVFC0bXC2hknpsnVpazH6c2cK.m5NREtAl9B01KYix8lVTFjwAKxl9KoUYPfTldhtG9MnPTxOp
 fNbrUVVL9YDsEFjqQErtmVk.jL1.WmDL448yK40UH6BbZDjVHoo0q7KfZvOzZGlO3X_J0KF9CZYF
 17LvmG3BoCsscHLXxfmTCsGxlyzqsTMRpUASxjz3YVy_S8w28xKeqkjQI.sJdHWhlTD54U1eBa6b
 GGN69OaW5XTRhjX_NY7NxoGvP1QyK5c8nrPkTT594wtLk2qfRrl1Kj72.fOja7hmADChJjqQRosj
 qutGr9QtRxW8WxLWVQ4d6tbHApg--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 0e35831a-744d-491f-972c-8130b488a602
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Sep 2025 05:56:02 +0000
Received: by hermes--production-ir2-7d8c9489f-9tl65 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 06aa482699b918a59f317ba4e6d13960;
          Tue, 09 Sep 2025 05:43:52 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	antonio@openvpn.net
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next 0/3] net: tunnel: introduce noref xmit flows for tunnels
Date: Tue,  9 Sep 2025 07:43:30 +0200
Message-ID: <20250909054333.12572-1-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250909054333.12572-1-mmietus97.ref@yahoo.com>

Currently, all xmit flows use dst_cache in a way that references
its dst_entry for each xmitted packet. These atomic operations
are redundant in some flows.

This patchset introduces new noref xmit helpers, and incorporates
them in the OpenVPN driver.
-- 
2.51.0


