Return-Path: <netdev+bounces-143994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CAE9C5075
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D41F22F34
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274420DD68;
	Tue, 12 Nov 2024 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxUvsXrx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16220C01F
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399719; cv=none; b=pUZSNJvw8e7YH+la4Jm5T5LM8+5Nj/uEX2yXdb0akFJdpcKyBG0IuSdq6gU7yZT25+nPMx+JtU90Vy03MiarIL/9FCKjTVoTy3CubzcI5QP+8+OxJqwuBx052PQkmc1wAZwKWzmE1PQwsmPJMad+fG1n9fhYv9/5Xs7UgmnbJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399719; c=relaxed/simple;
	bh=PU7JIEoj3C6PReAZx2FAED305QA5oLsr9/AVbHM1HuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Vn1AbqsSV3aMdnTSrrksIC+W3lnOmh68qbfW1hnyYgNlyrWLWHUI0FN89uVMDzSq7aNwnJWWJH9p1RwQDPvgota5mzivEj7hc+g01Ft3HMfXiwxyiublTPvccsopY5XOFPibGvxNzkV3q8h+eb66OajD6rg0wCotS4aYR301cv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxUvsXrx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731399716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIBVjlJ0oWfr0OwNtr1DIviMC6+sV+J3Hg8eVl6yUyE=;
	b=QxUvsXrxNVFnWrlJCABF6ShLyJnLTxiOc9vGlHG8H//HEJRjvCeIkEpNofr8PdGVhkjerb
	nowdFkaTErzwK8TtHlMUXA3QkYZ4EVxA8ar++LlSr23N3RZDUPadfP1oS4iqKxTiJS95fH
	NQJB4pFMzYtDCP9B9sY2CkONWHR3nlk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-xbrWpfJ3OXmW4GiqooSs1w-1; Tue,
 12 Nov 2024 03:21:51 -0500
X-MC-Unique: xbrWpfJ3OXmW4GiqooSs1w-1
X-Mimecast-MFC-AGG-ID: xbrWpfJ3OXmW4GiqooSs1w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 116FA1955E9C;
	Tue, 12 Nov 2024 08:21:50 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA45A30000DF;
	Tue, 12 Nov 2024 08:21:46 +0000 (UTC)
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
Subject: [PATCH v2 1/2] tools: ynl: add script dir to sys.path
Date: Tue, 12 Nov 2024 09:21:32 +0100
Message-ID: <b26537cdb6e1b24435b50b2ef81d71f31c630bc1.1731399562.git.jstancek@redhat.com>
In-Reply-To: <cover.1731399562.git.jstancek@redhat.com>
References: <cover.1731399562.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Python options like PYTHONSAFEPATH or -P [1] do not add script
directory to PYTHONPATH. ynl depends on this path to build and run.

[1] This option is default for Fedora rpmbuild since introduction of
    https://fedoraproject.org/wiki/Changes/PythonSafePath

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/cli.py       | 3 +++
 tools/net/ynl/ethtool.py   | 2 ++
 tools/net/ynl/ynl-gen-c.py | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 9e95016b85b3..5e2913a7f3e4 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -3,10 +3,13 @@
 
 import argparse
 import json
+import pathlib
 import pprint
+import sys
 import time
 import signal
 
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
index c48b69071111..394b0023b9a3 100755
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


