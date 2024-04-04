Return-Path: <netdev+bounces-84707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B191C89817D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 08:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF40287735
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD21B978;
	Thu,  4 Apr 2024 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b381UVze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BE1CAB0
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212297; cv=none; b=gf3RHsJi4vcnbiosRknBVDwmnQzYLvcTAUvSLHua/n/ARN5zfJ2pkWHw9YyPtr4Iobo5QDPVlM4t7NywtzU8aPKX26LU0tFIcEbA4r1NYqCVmwTKsxvwouF6P+7se6ermsubQn7FFE6OrdAU+1CAoNwcGQA87qZG875H1WytPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212297; c=relaxed/simple;
	bh=05MzOygOB8XeDWrUo0PsoMbnKPguLQNiSoiSRiLQiwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FajZAvUWeBPt7DDHCCLuqcU2XaxB9FG5hNWjB1OHqD2TQIXIKNo0B3GQaEnOomWXLh0Q3fgxvtT4Cmm2Z+g5X49B1KOlx9y1vFS4mPxZZdo6FvFr3TpUzrCgQCk8C5rXd8vHp6oE75BvW1aiZebgP2v8ow6wJLk/nW6P9yofcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b381UVze; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6b22af648so1400746b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 23:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712212295; x=1712817095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2aCkdIjTfv09I4mvYheNHYeBlNlq6wZwmHsNpE3Gi0=;
        b=b381UVzev7lQWCBwNoAZ0NfwTiQMOaLCwFaq+SsioNoq4oZMN9LdIW1QDFtKrT3l9N
         na/PR51DdJ2nKu0qAAe7BK2ElOgk60+4qxnCohL/bJT08iDbUHJz7Oklr/W80PxpPm6p
         SqFEmScBVhw7dYJITClTMW336Xgju4gJXT4zblyM5cC9jFXhbBZPnFP+3osw4/I764up
         Vf7lZdRJzeNfsmAJ8pqaCIvr74R04208UqT6LxCwe2fHYhJSCX/LrKQV39QOLqN3eMS8
         LBKM4mCRz/FOINHLKlC1Wol5j1OiLY8SgrcjNfASPOTq0vtwFoL8AneJopsm7em2wHls
         jcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712212295; x=1712817095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2aCkdIjTfv09I4mvYheNHYeBlNlq6wZwmHsNpE3Gi0=;
        b=mXiNNcaX+Xh0YNhnUcLDUJ1Zt/IyrD/HT5qGaMZ1JHBiTuN9nzkNr8fB/eBe04dCBu
         zEOuJ7b6J4LE5K7yt3kUC0nrT31kne8mGiSp/dp4ubIGJoFskv9xJPe/JrXz9sY/PQFK
         sr/Vi07XJmSFsFHsA9trUlffDyHGRdXjMR3seqKe30v2RnoHDlPRcY5MaZv9DCLn946z
         UBAVjyCgUB68SoAsAToqJ+Z9auSH/2ELKQOCfEboKHDURWqxWWR/30mXjVlCkLX6tW44
         KXV1XQJpfyGA1W3Ur6pMlkzeLG80O45pfZ3q83iqmHorkVlJS3QfvqO37qqZdNjnNYY5
         wc0Q==
X-Gm-Message-State: AOJu0YxOKnETnHZhxGO5gQNyf9Hy9QYbzPIU7KSowMflKDkDohr7SuNQ
	a3iPROi8pEY9BEYLLaBYElpn513K9ABqwBL3yFQ6isDiafqU/OZaWobsBi81IR+RR+rw
X-Google-Smtp-Source: AGHT+IFmzwAf25y2XiFhpHWw1WyjiJeSvbZAZFIKXlgfKCnVFhp8ZPKz2ZzPpagCV9pivXOX3TCNBw==
X-Received: by 2002:a17:902:6545:b0:1e2:afe2:5289 with SMTP id d5-20020a170902654500b001e2afe25289mr803674pln.13.1712212295251;
        Wed, 03 Apr 2024 23:31:35 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b001ddddc8c41fsm14429558plg.157.2024.04.03.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 23:31:34 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 2/2] ynl: support binary/u32 sub-type for indexed-array
Date: Thu,  4 Apr 2024 14:31:14 +0800
Message-ID: <20240404063114.1221532-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404063114.1221532-1-liuhangbin@gmail.com>
References: <20240404063114.1221532-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binary/u32 sub-type support for indexed-array to display bond
arp and ns targets. Here is what the result looks like:

 # ip link add bond0 type bond mode 1 \
   arp_ip_target 192.168.1.1,192.168.1.2 ns_ip6_target 2001::1,2001::2
 # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
   --do getlink --json '{"ifname": "bond0"}' --output-json | jq '.linkinfo'

    "arp-ip-target": [
      "192.168.1.1",
      "192.168.1.2"
    ],
    [...]
    "ns-ip6-target": [
      "2001::1",
      "2001::2"
    ],

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../userspace-api/netlink/genetlink-legacy.rst       | 12 +++++++++---
 tools/net/ynl/lib/ynl.py                             |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 54e8fb25e093..6525ef6ca62f 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -66,9 +66,15 @@ looks like::
       [MEMBER1]
       [MEMBER2]
 
-It wraps the entire array in an extra attribute (hence limiting its size
-to 64kB). The ``ENTRY`` nests are special and have the index of the entry
-as their type instead of normal attribute type.
+Other ``sub-type`` like ``u32`` means there is only one member as described
+in ``sub-type`` in the ``ENTRY``. The structure looks like::
+
+  [SOME-OTHER-ATTR]
+  [ARRAY-ATTR]
+    [ENTRY]
+      [MEMBER1]
+    [ENTRY]
+      [MEMBER1]
 
 type-value
 ~~~~~~~~~~
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index e5ad415905c7..aa7077cffe74 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -640,6 +640,11 @@ class YnlFamily(SpecFamily):
             if attr_spec["sub-type"] == 'nest':
                 subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
                 decoded.append({ item.type: subattrs })
+            elif attr_spec["sub-type"] == 'binary' or attr_spec["sub-type"] == 'u32':
+                subattrs = item.as_bin()
+                if attr_spec.display_hint:
+                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
+                decoded.append(subattrs)
             else:
                 raise Exception(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
         return decoded
-- 
2.43.0


