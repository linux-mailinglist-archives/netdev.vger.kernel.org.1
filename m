Return-Path: <netdev+bounces-23627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B8E76CC80
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83379281D6F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB1C746F;
	Wed,  2 Aug 2023 12:21:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ADD746E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:21:12 +0000 (UTC)
Received: from mail-ej1-x664.google.com (mail-ej1-x664.google.com [IPv6:2a00:1450:4864:20::664])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCF926A8
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:21:10 -0700 (PDT)
Received: by mail-ej1-x664.google.com with SMTP id a640c23a62f3a-99c47ef365cso84770266b.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1690978869; x=1691583669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrNzIICG8qTOKNKwTpWMsAjtR+/c8US07CWmXigNAyM=;
        b=fHYXNcVOhdR/7FH6J7G0r2LQcNAp1FVyB9XdgBRE+iEeavQVvMNf4ffpzYPDkORFXi
         IXJC7gn50gp/rymY/8kGGRU1gHLfz5sxdXtkt/RxYlGlqrAYZMWqwE7UpGsLoGAYmtaB
         itSF7NXItQLdSJgqFAjkhS4SrEdzuNrQ660+9eddLza9rCr1RpmFyzmeO2bkro31ckk1
         0of8IyNbY61B8bge1cwM9mLiaedKNp24IBa/Wha5OvcVr8StfH5S0MqDsXdhQxzo00dM
         KWXLIuUi6jbqiGqjX0+E2jjcER/FzhnohaUEfe/4lrxxz/RuUquElWP9rxSH5aTn5Zk4
         iIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978869; x=1691583669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrNzIICG8qTOKNKwTpWMsAjtR+/c8US07CWmXigNAyM=;
        b=BTx6bwQ0UhXfMyqRaWles8WKfL6jwLY7+y1HOcqHWNatedY1tOb+YhMALbwonOkD7P
         JgmJpp6y3UPby5pg+44My/vKczt9oobwonBcLuLYJUOia0KSOLcOS1JbgrHMiiIs6iZR
         dZFRVF8M1Z2LQq0T7QJjMsgyEahUG2hFbznlUyVPe8l0xE4KqDMsDmMdmriNSzebUo+6
         xXc3AnPQs9QO2yFDlL2QpODAdiEosqZGSYOW8dOZUEZ4aSvXreK7ZD7YvLyib1AnPK77
         +dWZGWJplG3zDL+P14uj37dz2BlxWgaXTYwHHP9+L398BTPmXQA2jEl3EO0isUoNyYZt
         yYIw==
X-Gm-Message-State: ABy/qLZzKxoWDHz6wH0tOwox3iUkQLe5hiffqVm04p0MKSz+NRa07Lyn
	eJj5upU9p9NNmZZcEnJeJqlGVlOnrWEmAqPMilPFWb9sfc3j2Q==
X-Google-Smtp-Source: APBJJlGIEIkB2PhuqBTTOaBiGs4N6Ks58Bs+FekI9vndNgxTSInymxMmFj3f8DEQHlL+4uCiZQRTjtAGCM1w
X-Received: by 2002:a17:907:7633:b0:99b:c949:5ef8 with SMTP id jy19-20020a170907763300b0099bc9495ef8mr4869671ejc.54.1690978868758;
        Wed, 02 Aug 2023 05:21:08 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id v17-20020a17090690d100b0099bcaf23d2csm1931414ejw.25.2023.08.02.05.21.08;
        Wed, 02 Aug 2023 05:21:08 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 6D930602BB;
	Wed,  2 Aug 2023 14:21:08 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1qRAqi-00Ch1d-4i; Wed, 02 Aug 2023 14:21:08 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org,
	Siwar Zitouni <siwar.zitouni@6wind.com>
Subject: [PATCH net v2] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Date: Wed,  2 Aug 2023 14:21:06 +0200
Message-Id: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This kind of interface doesn't have a mac header. This patch fixes
bpf_redirect() to a ppp interface.

CC: stable@vger.kernel.org
Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
---

v1 -> v2:
 - I forgot the 'Tested-by' tag in the v1 :/

 include/linux/if_arp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index 1ed52441972f..8efbe29a6f0c 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -53,6 +53,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
 	case ARPHRD_NONE:
 	case ARPHRD_RAWIP:
 	case ARPHRD_PIMREG:
+	case ARPHRD_PPP:
 		return false;
 	default:
 		return true;
-- 
2.39.2


