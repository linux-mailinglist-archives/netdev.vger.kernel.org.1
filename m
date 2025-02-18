Return-Path: <netdev+bounces-167203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F99A39220
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 05:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C84016A6D6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 04:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B31A9B4F;
	Tue, 18 Feb 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TltOrtvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CF1537DA
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739853151; cv=none; b=TBy9cPlmkgUUhO90rLRXRvo4uyknxrm57C5pGDGAncFSML2RHlLk74hoU7cy9uj13N7duL3TFth6fxO+yxH7Yu74jRVd9rQclIqCyV65cbEO5EQyhDcq0h3Xes+1OY2S+xSlig2YCyIlb72H09DY4Zct2mSPv/N5HH4+E9QAUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739853151; c=relaxed/simple;
	bh=9cx0/eu6P1T5ks4PM6wl4/IHG4kGRc2vpFfqmPOkwto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgNk97SLOWhN+TS9Gku/nFL4UATKX+gCwjIHc8f6AWkxnsl8PNK5Z6VqYiETCG+UcxmYwTPRZ/1bsGc/XH2iRkpMYu32QQBJQ24fQCjElVQcZEDy841A57J+wFvfmUn6g5mcCpMH3sSwTJzDqqlhOYdjCSOWq342kSUY5MgD2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TltOrtvW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221206dbd7eso31887125ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 20:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739853149; x=1740457949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEHMqt+ucWGB42zAlQegd8aAHoZHpwN1ts3CV/Z7IV8=;
        b=TltOrtvWAK7MvUKdwy30itd4EJahDkl9jvLu+Yxx+2g3kfi8ARWaNmIVYtUX9PRhDV
         EoF7OWRktmaw3A++Nzps8k/T8tjRU96BCMKhclEtGqLbHYkHn4TjRrkzkJI8HcDp4zH0
         5jDud8+IicMFExwRYo0OyZd0l3SkLLuWeklUoxMknbogBp/rIm+b+I83BPKJ26YwJIra
         rzX2jI3nhCrnefvfDjg2ePGkXWZUfMFwKkHia6OXPtqbekxULzsMj9BzRWh82oyHh/or
         2S/kMXIuUY6K1Xmx9fE3v4YwNWoVa5+R8K/z1M7eLHp7VxohIB8Ra9tyvGgoImlhcO30
         Orzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739853149; x=1740457949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEHMqt+ucWGB42zAlQegd8aAHoZHpwN1ts3CV/Z7IV8=;
        b=uYxcCLgfRxvpIebn3Hn7Kez62dJEGjqoPkZ+Mv9o1bTSkvzxOfFYrkjsgNzfcpdrZf
         AIbmCQh6lj98kZaD4YYeFxsy1jk6snF9hDRHnOMcXAUG1czQ2r9FeVFYVKHJkc3I88Ss
         4aYzfF2o9usvG9ZI5Py784gT6CqQ5s7cqQ8u0HQyyKmMWVUahFVRfIk6G85x89AVkeu0
         oEdPJd98CAvV4x4i8MgsWUbL93WsUb4H1Y0H7mfhZ7NtNXtUp4MsQV3QfHYDNGSzlA6u
         U9gSH1rhxr43HmxvCku2lddyMP36gTOSPOAJqZMC92oUtznqNK+hfFFRPKju6xrWgBjd
         Hp/A==
X-Gm-Message-State: AOJu0YzbkqEfOzOZs4Ebz3cSO/xmkynVIl8HKR0JpQS+8rhrQMcsdiaR
	Ej2SXMkwSjs1wBOKO58HnS/VKpT1O/tXO0yZzqT2hkwjBI3oSHu+5EZSOw==
X-Gm-Gg: ASbGncufc6z45GyWAP4/CX/YbYV/k7mMBKtgLejPdyrIhljeLdrrMrIDNTW7su1NbCC
	OaVcJbSkjKPXLJXnZ71jVtIXhL37ZlQBx36wNMyFN4+30ort3eanwtDgJ8wG6tsW/DBoZ2WuMBw
	8kucNt+ZEAgRHwLO9TsIbqvSGiHlNcBbbmI24Vfygrj7nj7SQgt1ByN/iLAhSEj4vofnPkVS+q1
	wIDtqWJbeggz62Cfa1bZeAyWnOFNXsyZGmEBhs7z+YCpnKl2AiYq1PUwo0o6whujEXtHTLDpfeX
	J9TALNle8yiDUbrehFMaiC0c18+LeaRl85zOhZc2fjIQ
X-Google-Smtp-Source: AGHT+IFLQO/mxfYjqYZmLesVF796Zfxq4lDRk9JNCH8ScHYq9IPV0ZUofmOtoWLMiZ9vp1HS1baV8Q==
X-Received: by 2002:a05:6a00:847:b0:732:2170:b69a with SMTP id d2e1a72fcca58-732618ba2d2mr21910997b3a.18.1739853149098;
        Mon, 17 Feb 2025 20:32:29 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:304e:ca62:f87b:b334])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326aef465dsm4907501b3a.177.2025.02.17.20.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 20:32:28 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	Qiang Zhang <dtzq01@gmail.com>,
	Yoshiki Komachi <komachi.yoshiki@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [Patch net 1/4] flow_dissector: Fix handling of mixed port and port-range keys
Date: Mon, 17 Feb 2025 20:32:07 -0800
Message-Id: <20250218043210.732959-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
References: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a bug in TC flower filter where rules combining a
specific destination port with a source port range weren't working
correctly.

The specific case was when users tried to configure rules like:

tc filter add dev ens38 ingress protocol ip flower ip_proto udp \
dst_port 5000 src_port 2000-3000 action drop

The root cause was in the flow dissector code. While both
FLOW_DISSECTOR_KEY_PORTS and FLOW_DISSECTOR_KEY_PORTS_RANGE flags
were being set correctly in the classifier, the __skb_flow_dissect_ports()
function was only populating one of them: whichever came first in
the enum check. This meant that when the code needed both a specific
port and a port range, one of them would be left as 0, causing the
filter to not match packets as expected.

Fix it by removing the either/or logic and instead checking and
populating both key types independently when they're in use.

Fixes: 8ffb055beae5 ("cls_flower: Fix the behavior using port ranges with hw-offload")
Reported-by: Qiang Zhang <dtzq01@gmail.com>
Closes: https://lore.kernel.org/netdev/CAPx+-5uvFxkhkz4=j_Xuwkezjn9U6kzKTD5jz4tZ9msSJ0fOJA@mail.gmail.com/
Cc: Yoshiki Komachi <komachi.yoshiki@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/core/flow_dissector.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 5db41bf2ed93..c33af3ef0b79 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -853,23 +853,30 @@ __skb_flow_dissect_ports(const struct sk_buff *skb,
 			 void *target_container, const void *data,
 			 int nhoff, u8 ip_proto, int hlen)
 {
-	enum flow_dissector_key_id dissector_ports = FLOW_DISSECTOR_KEY_MAX;
-	struct flow_dissector_key_ports *key_ports;
+	struct flow_dissector_key_ports_range *key_ports_range = NULL;
+	struct flow_dissector_key_ports *key_ports = NULL;
+	__be32 ports;
 
 	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS;
-	else if (dissector_uses_key(flow_dissector,
-				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS_RANGE;
+		key_ports = skb_flow_dissector_target(flow_dissector,
+						      FLOW_DISSECTOR_KEY_PORTS,
+						      target_container);
 
-	if (dissector_ports == FLOW_DISSECTOR_KEY_MAX)
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS_RANGE))
+		key_ports_range = skb_flow_dissector_target(flow_dissector,
+							    FLOW_DISSECTOR_KEY_PORTS_RANGE,
+							    target_container);
+
+	if (!key_ports && !key_ports_range)
 		return;
 
-	key_ports = skb_flow_dissector_target(flow_dissector,
-					      dissector_ports,
-					      target_container);
-	key_ports->ports = __skb_flow_get_ports(skb, nhoff, ip_proto,
-						data, hlen);
+	ports = __skb_flow_get_ports(skb, nhoff, ip_proto, data, hlen);
+
+	if (key_ports)
+		key_ports->ports = ports;
+
+	if (key_ports_range)
+		key_ports_range->tp.ports = ports;
 }
 
 static void
-- 
2.34.1


