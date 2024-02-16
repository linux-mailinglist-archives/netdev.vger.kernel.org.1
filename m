Return-Path: <netdev+bounces-72260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3059857392
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 02:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76521C209E0
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 01:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1EBD528;
	Fri, 16 Feb 2024 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QZsifzZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967FC2D6
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708048390; cv=none; b=ZLDSpavONk++dB7UmXHiGVQOJi77dj1RVrTVmfJD6PbVupGqD6/t4pqJBlyJ/hu7Wx+MYc/+ndBx3eEiVn6ttTZ6CUQTF+pkVoG4It3/Zji2TtONZSzsXZZqFqfkIEGSpfg6K3/9RdSa2ExJctB22jzNs8+aXJjuxW3GYUb7MHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708048390; c=relaxed/simple;
	bh=4tAe3a/pCqIp+ipGGXY390MEbNWwzoRA/6ItmjybyRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtKv2Azok4lxN+yvzRa6dsd/Cn0N4/qSi43s+1WOLUT73cOf3uf8AArArRfAxM76/AE6Br39y3VE3ajDVEhE/egVyivqDfbhVfNgGM/xIgzU+AN3MU7ET+o/fMPbZYkaEnQDStU0drrf0pvBgOkJmZF3pkP7Z2ok3skFIH41wK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=QZsifzZ6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e1126f57f1so934555b3a.2
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1708048388; x=1708653188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LW7JPyG1zlm2FoXGiaAcpoc/ykQZ/tHU+berzVsOPCA=;
        b=QZsifzZ6kqn6CroTA07fs/gA2GBagdtZ5HvfosR216klSqpvRdoy388W9Tja+pCbFN
         uOLlbgEnuxHQ+Skm/3+NfhiHqYEWg9FSIYmFFj/m36N11yJwYLx4g+fZaWpKJdfGg5E2
         3hqHJaSRjoIiwFeIyAY9UmVj1BisuMKy6J1ZnNN9yDsS880Wcjot+KOWLTWmd5hJMHIe
         jFbJyIpJuhlHXyKKmxjmdQ9NWbrDrBm73+kk0UaojsCJ2Wmh1VUebfPnXvAvj0PBPJSC
         OlNRuXWjdkHeCPbHL+18nKIt/D7IebdyH/oG4sY3SCaHhA58WXQs6FLR0rezTxTHp88r
         2XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708048388; x=1708653188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LW7JPyG1zlm2FoXGiaAcpoc/ykQZ/tHU+berzVsOPCA=;
        b=FmHNbs0QPPUIglw73dbhnVM1QuRxX6flFOqUZg3bqXgjuOcijcr4O7ADu44PSuAbLD
         GVpOT+C4YuOzOGbJoqa1MgyBsyqlxHhngeV7v7qZ+ikqQmqdSVRYkBMQ64iA27LC8TlH
         tR+aovcwQPf7xb32MiTDHF3AU/oJ05EuWx4Ks/Yl6w/hMB3pu2D2ilIuX6z6rZlP+d2E
         s5zZD9nz+eXTLsYhhshQ1GC61Hi0V1X0D18fG4mi6AI2jHc1pWs1cJfTJMo1JRcLVkx+
         hngLsaddJU/jflwxmz/dcDD+A38JzcxKmZL3CM49ms/9/lYZVDEFdiJdRYzYtfII9qH1
         1eOQ==
X-Gm-Message-State: AOJu0Yxy3YlxFD2szUujVRc4TiSKWiigZlV/ddBvTV82YCv3N0S3iDFu
	NPUgibF3wVZtoE8uBB1rpsrP7hBtTL9O0gHRkrf0WNwQA2rQ8XtlJoucD4KD1p8/fWu9HqIplmr
	s
X-Google-Smtp-Source: AGHT+IHIBtSdWhDPOgjCwAt5/t4Xsrd5ARHcuqEcbQQ1SxHpQx/ifEbgKZGL9psdJjwA22Wg/GudiQ==
X-Received: by 2002:a05:6a00:938d:b0:6e1:24d4:a9a5 with SMTP id ka13-20020a056a00938d00b006e124d4a9a5mr3734503pfb.18.1708048387987;
        Thu, 15 Feb 2024 17:53:07 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a0000c600b006e0cfe94fc5sm1974117pfj.107.2024.02.15.17.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 17:53:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] netlink: check for NULL attribute in nla_parse_nested_deprecated
Date: Thu, 15 Feb 2024 17:52:48 -0800
Message-ID: <20240216015257.10020-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lots of code in network schedulers has the pattern:
	if (!nla) {
		NL_SET_ERR_MSG_MOD(extack, "missing attributes");
		return -EINVAL;
	}

	err = nla_parse_nested_deprecated(tb, TCA_CSUM_MAX, nla, csum_policy,
					  NULL);
	if (err < 0)
		return err;

The check for nla being NULL can be moved into nla_parse_nested_deprecated().
Which simplifies lots of places.

This is safer and won't break other places since:
	err = nla_parse_nested_deprecated(tb, TCA_XXXX, NULL, some_policy, NULL);
would have crashed kernel because nla_parse_deprecated derefences the nla
argument before calling __nla_parse.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/net/netlink.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index c19ff921b661..05d137283ab0 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1322,6 +1322,11 @@ static inline int nla_parse_nested_deprecated(struct nlattr *tb[], int maxtype,
 					      const struct nla_policy *policy,
 					      struct netlink_ext_ack *extack)
 {
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "missing attributes");
+		return -EINVAL;
+	}
+
 	return __nla_parse(tb, maxtype, nla_data(nla), nla_len(nla), policy,
 			   NL_VALIDATE_LIBERAL, extack);
 }
-- 
2.43.0


