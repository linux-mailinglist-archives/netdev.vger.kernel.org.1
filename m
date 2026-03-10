Return-Path: <netdev+bounces-266025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOfKJ9UAsGm0eQIAu9opvQ
	(envelope-from <netdev+bounces-266025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:30:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA524ADB4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5117C306965E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792753876A3;
	Tue, 10 Mar 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF8Uka7d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F4387590
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141844; cv=none; b=K2smdx7MSW6R1bEehzszxm+HA7uAGWcLnwoC1ZQ3Ra4fNQKkYe+twgWycsvwl2wpQUf1oampHTIPPrhS6Qb1jkte5HBXhHkjRMXvPdcOAXPOe2EwcDT3p3Ykpi5jdz1X1y72mzb9CrHgtgNwq68gp0+tmzyKbWqfeFRFzsjQCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141844; c=relaxed/simple;
	bh=oecra2i2xdZ9DgwrUksgYUq/MUi0mQPzUntwho+HbcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKaOPJeADtWldi5FMc9iwcMFtdp6uEWMg4B+Uw7yJrIbDtGom3YDpe1Lz22dfr3S0j3LCs/FaBvlrD9q/icUIsEXj6YPpy42hm/inn5yiiWuWKql1Tg14FjsgsoEdbu8fFiCVWHo3hyVdw1rU9INNY4VJuhZhJEdtm1CJY1r+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF8Uka7d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so8341510f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 04:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773141841; x=1773746641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH3NKRhLXf0mImA7QQXPX6XsanmxWfrU872KpVarcqQ=;
        b=FF8Uka7dwpf9sbfYTS/2NGAgOvpG0foM7WxG21CjGTnR5/2cMtR5Ptw7TyQBkU9Nv1
         Mh/PUNFaWjBiy+o87pbjpx5nkTG5a4dwLhZgMpWaUMtCWK5SxKwXUbZa7+Ol0S+rO9PT
         bJYNd1LyOyvrwxpMmTSa29UYF0Sf4NX4nYxPnmgXY+QJHRYg/88McKXOEAU/RXE9eMTp
         qdOd2iTZyt0lRwkFgO8o4QrSPBUbFDRYrB393XFDVgSMMoXu85wCemr8a76nB6Ywiq/J
         jQTlilc4VKcRG0PapvDXevtEdHXq1ANiryuavFj7UybgP5x2lNBBJze0tzVYJXIhAy6n
         l2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773141841; x=1773746641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uH3NKRhLXf0mImA7QQXPX6XsanmxWfrU872KpVarcqQ=;
        b=REmYnx/cVkWrAFdTVZ7gIpsw9tQX6/LC7qCCgShY7novzEY+fCSJJ6qEN0IYVor9Zw
         NmUd3ssuLD1/4L4Y7/67QxKisLrhiH4LDHN12HsdSITOE0CfQ1nE0KtEavBCaLXopoSD
         J16S9NwFXoXPLvNofSlYsxolXeEiCvUUV6pXbyPIu/LLtx4z7etczzmnVdAYjIYvlAlu
         QH/tVocZ+Xeq+y39g/s+6OXAFGb/KNncw+aMMQ332hgju0JQ+gIXkihfIE3gtKuBn2j9
         SaxoEWKJEgM8t81TLHmZFNWy4YqEFGdICPH/t6y5+dc3Lk924bdcSJOEhsUUxAgqGE+R
         Mlow==
X-Forwarded-Encrypted: i=1; AJvYcCUcV5XfVvr3LkewtMi7CW+kWMbPk32tQJs5rBvDd1e5czjkZqNKqMzp9y0FGdaOhKUMiAlIK08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLyZpMrQ0v23uqClHQVkoWqpFxYqrsifGQBpbBvv4aekIhdQM
	Sh63RGRe6/Pznx+WdGCoPGO4BxArvU+NLsrbJLtwPFbI2TOzbRg9k0rC
X-Gm-Gg: ATEYQzyuTH1M7dYmpFPdyPReIIWxM+8ABRq+wxGPkCv7TbZVHzbV2vYkOYDLhRA2Mup
	zKI7YAnqNawdXJ2YIC762S7ebF3euIYMsuBkbqzZaEt0GHBSFWeJfsoxBhB5QM4PBHPNNphR8Iz
	y1Ko86B4xd/1azyx9H4L0IHBGwb1l/XVA+YvLQ1CJhM0paIT637lXtAek9HJAVxitxjAcFTDBU5
	ASamgXZ8DEr4JAlJR6Zcd9adDi/BJ84GzzSEnPEh7hkQXo6SkXN6WPlJkoy++PCf8C+ZByxNHFJ
	3HmFCJ25ZFq8aoINcY4PF5JP6y/XRF2S9wLPND120uZUAHbmg3VGQMibVRQpjJ7+RqNzyGTVn/9
	T1toiAsEYu9Q+WwbY7uQA233DjzopC9vtdjp2VfOFyLV/VVg0EggpYZLFY7OvJP+apGqNTVhXoQ
	XirYdMXWQJ4SkydrTKhtKjXwE=
X-Received: by 2002:a05:6000:186b:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-439da6569b9mr26978632f8f.14.1773141841285;
        Tue, 10 Mar 2026 04:24:01 -0700 (PDT)
Received: from T15.. ([46.175.113.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad97abasm32238560f8f.10.2026.03.10.04.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:24:00 -0700 (PDT)
From: Wojciech Slenska <wojciech.slenska@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Wojciech Slenska <wojciech.slenska@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: net: qcom,ipa: document qcm2290 compatible
Date: Tue, 10 Mar 2026 12:22:30 +0100
Message-ID: <20260310112309.79261-2-wojciech.slenska@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310112309.79261-1-wojciech.slenska@gmail.com>
References: <20260310112309.79261-1-wojciech.slenska@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19CA524ADB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-266025-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wojciechslenska@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Document that ipa on qcm2290 uses version 4.2, the same
as sc7180.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index c7f5f2ef7452..16851e599fc9 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -53,6 +53,10 @@ properties:
           - qcom,sm6350-ipa
           - qcom,sm8350-ipa
           - qcom,sm8550-ipa
+      - items:
+          - enum:
+              - qcom,qcm2290-ipa
+          - const: qcom,sc7180-ipa
       - items:
           - enum:
               - qcom,sm8650-ipa
-- 
2.43.0


