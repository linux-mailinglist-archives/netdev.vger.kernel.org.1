Return-Path: <netdev+bounces-279608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK4jLMY75WmTfwEAu9opvQ
	(envelope-from <netdev+bounces-279608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 22:32:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F7425760
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 22:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AADA8300461F
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588328850C;
	Sun, 19 Apr 2026 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jWQI6Vwo"
X-Original-To: netdev@vger.kernel.org
Received: from sonic310-24.consmr.mail.ne1.yahoo.com (sonic310-24.consmr.mail.ne1.yahoo.com [66.163.186.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D651D86DC
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776630720; cv=none; b=LAhj58B1yUhanl/Pc8x5CIquRTREkXXdDelEzeqTfiPl8z3oAPIxo4f9vmgbvWnC4j3pyFMJx1qov5pC9QmxR+PVcdUGDC9Vh5pQCTHCg6MhwjTnduEkxXj+h1h7sn9di4tXQjWuF0/zTem9aOMuQFUQlVCe1anGQ7NEtCcxCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776630720; c=relaxed/simple;
	bh=Jx2VwIRlLkTnogfoJs6usTI0xVAZFxC6T8CEvlXZSqk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=tmtJ1kv+DvYqL1XOsDkYeWOZR7SvNcFDe6B/kJ9lAtW2frMJhCChgGpjhtR9QECN0aXjNlcl3/oMB4uSjN6CEjKID3cJGvxiE/TM2bBMtKMRjy5RpG0K4/flZbDUqIHj2ETTRVzg9Tv87xc/OjpnzfT46EzaaQHQ2cZVkQAKfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jWQI6Vwo; arc=none smtp.client-ip=66.163.186.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776630718; bh=C6P01coV17raI675X3Tjs6EKGGKw8wcIYoqXJRLzz+Y=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=jWQI6VwoiorSQSoHCnURX6DGx6yijZu76zbE+rqrUYnanNO87QRM6u8XdwWvHSev8elGf2VIU4WbdCwhkjjCVzS2sqmQVwV9JVb1K7el/PXTA83uIaqSUey8QrnNgr1hCH8LBm4nTD4YuEY1U3dVhpkalYGfiMov/BEdrDwO/anD6w9w04+EowqoFrDmCj4nOxwyZfrx50yjzUCVs8bnMVRSdgVR9bQWu+azR2Gw0hz0+18vAdB1Ge5tRiiF60fSNT3HA7Np9INEGd0x1YOqIMy7JYLc46y59ohA0OOHFZz/OAr9hZjfgn1GD/41Tz9jP6yhdXX+9+kt10oV1k7OTA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776630718; bh=SYNbPQkiqrWwW7fS6OnsoxIQYJpqDhtnNR0DmqHFulc=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=trEv3j/4AEmR3nnwNhDbhXra2MI5Zqnj9ZIh4Rn8bl4tX02KGdF6OTn01f3Wmz0CBPwmXWYgrcZxxo4mvXeu0nDmgmDzaDzkEc2cK7rajUsVK8HTPCGuzU1CoWOuSIm1d176Dg7q/D+VZE6EwuCkSS4OZNSNPyknjksveMCtL06Y1fi+ZUgibv85P71+J9cVuOra9H9el2HDqtGiMNfqh4cZQEyVFxTB6d849Bq0DW/3EoT+hucyAKd99xIv/R/poZriiHO0bqxexFOZPiF316OiF5YzliMJkBSQhfhpoIpDDLBwxXWzy/TZYar9BpESZDaPq+z+lWN7SRh4bIOGlA==
X-YMail-OSG: f1KolfcVM1nr94iZDWkjQmrURG4O8UQlqjUhnYtrSUdflz2XFx6r2pK4sR5.Il9
 E7yOjIdcwjLDJ.kBCSr8doA8avXuSAtVM3FAfXj1KMxecgwYE3AD4i0WbthQ38Vq6huYTvW2FJ0p
 Oy7I1AYuHTrvl6JXKiBZ459waK0b0f52wXEh_2dnnZ5M5Q.Zp5zZoy0zrcP2NdgHcp5OSBKCfGJP
 H1RZyZ46x1ryHfKjG6gT7ETHFeTlj0tbM0LL6nE0gc4BqUMWwBd6jFMKR5x_u6ptrrBzE1Y3lnrO
 wCekc1mYGr870D7h5BLYR1Czpw9.32u992L3WLwoP38ICSzAXo2UIDovhnV_xVUz9htIyh_P3ixn
 X1MnoqBcofpRit_F3b_P5uEw56MAK.dDMj684xZEZ15l.y._cbeqM6X6bGma.Pf.B0p6kXs3kYwe
 wI4dYhtr8iLn4_3s.qLk0KV2HBRqrq.JYHJSyv7iT8tyDhJr115yTij7Bf.IRQ29HLEjs0v5tk6u
 ieSyMzYWHNY2MDokD3JI3wAIAl0u.U_kgIoUgJyOiOXj1ZnHuQjNDXRYqU8sj9ASg0jmZjkC_isU
 24UL72IdccKzCgiltj3lN5phFEJjTxfN1VPEmo7So9Sh_Fd2vQ.NEs3MXtF87dtTAqp7d93Mki2v
 DeyO7QO_54f0Gx0tyJ5FF1reLKR5it2tWSiu7ZBV_1TlXTjYPDDnAH3fTRBp6TeD8S0Dc_M23yn4
 sNdDTSs11zh79CEOQQM7VDGy2a1gSK6C784LZEUPTxCYvUxM4dRHWNJL8bNlNfN9EZKxas_slatd
 TG0nRrpAOLrzzn0xOUXzNphpebdY2eWS.vVNqiK.px1RlWVBXCnuGTdzwnl9keS9YB8b2fsEd5u4
 oKHceBX_63XcSPXQZgZ4GIeGhaUZQNG.LcTW5LMzPTlmPJpSDKMQNKxJuZ60hbww21s7iZiOoZFY
 9VYQ1V1oUCwf7H3nOtpK.9FWA39LIt4C4vF5eRJ2bsgOEvBCxKfOWspq00eZQuDES3o1kpwxBkwW
 DLkdqOAXiUfLUt0DN.3ljtOJ7WPOKQ9YRUA2aG7uUz45fskbevhFRBKVE20tP.deVuuxpcSgWJOo
 tjrlPW1AKDJKE3_pTtjBRQX4NZji4XAa9CMrj9XQPWwQz.Vjx2ehNVjBm_vywDC1ft5aCU6l8_Qv
 xUcu1hJ1JL9mLbxWLRz9RpNmLqkG_RFWcGiouq9BQnfk.9i0l_p1gQl.bguuAxb29p8nDPJebxWy
 TqHIKTtLVKkw15JKrKo.tls2vSB8THIFpgjFWMv0oLwTsNV.o4Q8s25E39m.cRq6BJ3hzqdnBAsE
 NusKRdj2.V.T1cqkm6R_4LTDGTz9NP6ZoGTB5LDmgnY1SB7pxAp0KQuVBMBaD8OjAsZ9Erh758Sf
 Fm_34lq4omGCvNf_oFqHrUpxYEgipydz59DjaiYMFWSSMCijsQiE9Il5KUquORPwxpTc6rhF0TXW
 _rk2CTlyJAfLXnV9q_jRWc.zjem7c.3HpEAe5SDvDm6kR0MeO_h7po6oFzeH3yBeopjGUokHkgwH
 1jm03mHqAuT7.x4cql0BFKqMXct8Wj0vHzmPISGl3HY0usvd4ltJdK.L7XARFeXlfGmHnNdKM2kW
 ZVX1uLNBEmGhsdP9Al5lDTCzbonLIgqylv53GZjOWeXFRyN2oAK0Q1uqgC_IJWtnDTPLenT7l3bi
 U5bUC76ZoXik8X7jSCyv0h9LU6dv7xZw4XBYloRSXKuHKG3vg3xGyzpv8J.QzGqpyf8BRIKExdzr
 8CI6xtcDmRSArRB0CKNMLLkPtXM7kZSwHK.pIvNAHdDFlCmYqAC7VvPL2VGhvpW.HUg74m8ab8aR
 IaexkPUufa.loX__8pGYoqTl8OWxXRD3kJ9sQk0FqODlEHDfW7lyDwbsZsbAjLJfgx5FtDxLuTkh
 mxkC04sm2ZMLdIrAEwTKflo48tRz9Nnjo8f.vq9drkhGXAVPre3_v4JzawJd4M8bP77AXIEcxuPD
 7dUUw5q7z3tpqBHi2.hn_ID31iVQqYOX_4F6G.3Gx8pFSSIION5r9sYtmzUi5cCPQipqij_no7Al
 B5QwJpgqN9Iwpd6hg237ZT2Bc8V_2oAfvH_yjgbOc0iJvSJw..baZYu9HApt.ihLRyH6Lw6fcLSO
 .wpWiIuHiMAKBUzrBK.F3rxQeG5YaxzasGdrFmMOuwoDCfa_wTxHI9_OjbjV0KG2tLqV3Y2SFYlz
 nIbIjOI7sreA1hy7pHWhFCB9FQfBwkus8fWNuQf4Tm84AZYLl57CnCdLuSyqtwTA7Wrpvlbc9v0R
 HM4ttDrMEBA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 39802d2e-324e-486c-b7ce-139a897358d5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 19 Apr 2026 20:31:58 +0000
Received: by hermes--production-ir2-bbcfb4457-sdst2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 637eb63aae13c21f297f7071f341247a;
          Sun, 19 Apr 2026 19:37:11 +0000 (UTC)
Message-ID: <400a6387-a444-4576-af6d-26be5410bce3@yahoo.com>
Date: Sun, 19 Apr 2026 21:37:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH v2] net: dsa: realtek: rtl8365mb: fix mode mask calculation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <400a6387-a444-4576-af6d-26be5410bce3.ref@yahoo.com>
X-Mailer: WebService/1.1.25559 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279608-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[yahoo.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E7F7425760
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK macro was shifting
the 4-bit mask (0xF) by only (_extint % 2) bits instead of
(_extint % 2) * 4. This caused the mask to overlap with the adjacent
nibble when configuring odd-numbered external interfaces, selecting
the wrong bits entirely.

Align the shift calculation with the existing ...MODE_OFFSET macro.

Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
Signed-off-by: Abdulkader Alrezej <alrazj.abdulkader@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index ad7044b295ec..b85c99216648 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -216,7 +216,7 @@
 		 (_extint) == 2 ? RTL8365MB_DIGITAL_INTERFACE_SELECT_REG1 : \
 		 0x0)
 #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(_extint) \
-		(0xF << (((_extint) % 2)))
+		(0xF << (((_extint) % 2) * 4))
 #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(_extint) \
 		(((_extint) % 2) * 4)
 
-- 
2.53.0

