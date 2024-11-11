Return-Path: <netdev+bounces-143751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8E9C3F39
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03083B232BF
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8E1A0AE1;
	Mon, 11 Nov 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDJNk3Ad"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAB19F130
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330311; cv=none; b=tL/5fqPbnmQ0bZJXJ+lVGxcG+4aVx5A9UK5Uckg/CyWEryveR6d0QmexVqMjLfvfQPaYno+D6886uEQGbVvvC6hMl0bFBNJBtZUZmGBXKYP+sY1/ZUgzHQuj0inbXmQDJLblPldjPgakSCfme2b/I/V2+R6nlFTWAdXFA2LOXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330311; c=relaxed/simple;
	bh=SVHh1fatO0oQO4UReWs7wXWXGCXs6Dml1ZS/FKUTm/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=maOdAOpml5zFFvSWNBqNL8eVAe3w4qnJphdX51qLq0QiBxqsHNSJrLo6286VqGW0Ggm3UW7SnqkZXYih0hN0Dal53uHVVzdp7IqqjuuAcc8EfFdvkQq3ykhDawqAQBar/DdR5jZ89+Qpms1NHZAHR/HCKNBQUnPp7e6xD5BxFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDJNk3Ad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731330309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cOooKZkaMPDXtuTp8ptu0pElUOFrvu05o1tdMQaEFY=;
	b=LDJNk3AdO/6IXtgWTqGtAHzDvLKcU0Neq1cL7YGGBH+OFxh7u5a58XALTLvlGeI0chiSc0
	FMp4GBnr3O8lldr/SmF1vqhxXY9rTOY+/7SgJYOkOA/d7oKmvpOIrwcHc2F/z7ExS5S3Jo
	iTgVCEgbcMEGklytjZiGbyqKupkvcCM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-ppjqHuYlMm2SY4kQiRg0TQ-1; Mon,
 11 Nov 2024 08:05:05 -0500
X-MC-Unique: ppjqHuYlMm2SY4kQiRg0TQ-1
X-Mimecast-MFC-AGG-ID: ppjqHuYlMm2SY4kQiRg0TQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8950B1953945;
	Mon, 11 Nov 2024 13:05:04 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 723E31956086;
	Mon, 11 Nov 2024 13:05:01 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH 1/2] tools: ynl: add script dir to sys.path
Date: Mon, 11 Nov 2024 14:04:44 +0100
Message-ID: <97c08d1fdbd374ec6216a59d3b08f03d376ce2aa.1730976866.git.jstancek@redhat.com>
In-Reply-To: <cover.1730976866.git.jstancek@redhat.com>
References: <cover.1730976866.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Python options like PYTHONSAFEPATH or -P [1] do not add script
directory to PYTHONPATH. ynl depends on this path to build and run.

[1] This option is default for Fedora rpmbuild since introduction of
    https://fedoraproject.org/wiki/Changes/PythonSafePath

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/cli.py       | 3 +++
 tools/net/ynl/ethtool.py   | 2 ++
 tools/net/ynl/ynl-gen-c.py | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index b8481f401376..873463dbdcc0 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -3,9 +3,12 @@
 
 import argparse
 import json
+import pathlib
 import pprint
+import sys
 import time
 
+sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily, Netlink, NlError
 
 
diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
index 63c471f075ab..ebb0a11f67bf 100755
--- a/tools/net/ynl/ethtool.py
+++ b/tools/net/ynl/ethtool.py
@@ -3,11 +3,13 @@
 
 import argparse
 import json
+import pathlib
 import pprint
 import sys
 import re
 import os
 
+sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily
 
 def args_to_req(ynl, op_name, args, req):
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 717530bc9c52..a86e88019e22 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -4,12 +4,15 @@
 import argparse
 import collections
 import filecmp
+import pathlib
 import os
 import re
 import shutil
+import sys
 import tempfile
 import yaml
 
+sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, SpecEnumEntry
 
 
-- 
2.43.0


