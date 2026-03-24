Return-Path: <netdev+bounces-270819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMzaEofXwWkaXQQAu9opvQ
	(envelope-from <netdev+bounces-270819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:15:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A632FF708
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 187013047034
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5C1D6BB;
	Tue, 24 Mar 2026 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwQoRUpz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907AB17BA6
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310899; cv=none; b=E6BaCdd4xIhivHBsy8zfGaLx7hAkY9OfrXSDdVl2Tyzd5/63c2Fs+Uz3yso8HKioxJWHolfZ0JLzA1UJQMyO4KMIfN3T6Z9S+1aRMYd3MnIo6LdkI6QBQJengTAV4nd7f154W3evsQP6792M0iweKQQswab4CZ/tTMlWxc1JY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310899; c=relaxed/simple;
	bh=PoxhREItMiVwYnkEXKtVFcww/YwazBVr+OkJBMvEIww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ohmXRUEHqvu2QvqUwAFjAqlJlcfqGnNX+BSb1l4/87Xqt8HpX9FL+oCpCmEZBw15xxEQ6d1xWhza1fmoPfeu5SR4qL1DBoBlQ1K/udrUG8kK9BW2cHcSZ0cg0B6+FR1AVJfccZTyJ69Gi1TREHn+5d/6rbJ7QSzodbwdNmz1RyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwQoRUpz; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64acd19e1dfso3983791d50.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774310897; x=1774915697; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZxQqoLlmdcOW4F+vMCkFDwmluwovP2vTt1WDIDQAmY=;
        b=DwQoRUpzxl9jEwO6r1KjQ83UnvEgf4RUrkd5428wXXHynq0TuiOvF1GNbjy0p7lv4W
         wWK5EBcnaBo8r7THs2MBHeIshwPwBroyNIEdIrqV7LxGYDFoW3l2PmLGSRSQiwPyfl0I
         Ig6q2R797Pt+/uNwMvUbw6PaAll8GvIkM/7txdQp/82Qk2H+VuUciW1jgJHgqpXxRIYC
         r7vylF5/HgIXZFPQJTsaEYDVwh+upb10pW9RjTr6L7mNToDaXTbrG46XbpiCkEA6oFOc
         hTyjI4vPVR2Pj5p6S/fXmm/KGgtM6LPXaG4JKOFNmnzELxTFyhFbg3Ual3WZcR01RshD
         RWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310897; x=1774915697;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZxQqoLlmdcOW4F+vMCkFDwmluwovP2vTt1WDIDQAmY=;
        b=knaPKpHBglgS2hqsLp1kizu73IWX3YLbchrYohlt8xpckwo01XJ5OtZB7TZhxhjV40
         eNC4KfV0z+wNyQjumt/mYxjOFT+F7jKbAfLqrXEiuBy9+twZci63a4l+5yJJfArMdTPX
         lYGPtTp8wHT9PkTooLe5Oo6cNfq+UzQ4lFhUPHW+EjUivYPtaCGtln2pElrhwbzSro+1
         by6X+RPqZvSWHdEjFFAwbOv0cUzjgTAKUoFRf6tjVvJUYOBE2dZmL8eoGJlccjq9IeDo
         p5aL1jMsPSbhiwHa06eZx5l8Nzj49c4CP5QiGE8NjJRnFSQH5NHR1yXruEQhg9WNR685
         KfNg==
X-Gm-Message-State: AOJu0Yw9nJ6AGotyHyhGGw4CKDFru0Tf9aRnWPh3GOuLWH8zpJNjLajQ
	FGoRiP4UUngl/fXwRX9MZLM37/xiILZkkMYBdk9cEx+GncL3KwwbQjXE
X-Gm-Gg: ATEYQzx0Ni2eNmEiMSiPSwjJ5E/YKsvlZFVw+XtheJRfPGvzNxz5sRSREYmaAalSK1X
	pknnJ0i0h8B/HEvDV7/qKVyo8bj9YV9yPmi7/1kCNDZo0bCr8PlikqqZhblIyL7SfeSrFdk83Vl
	PZUBKa03KiSz8RYzAQmDx+wWDSkQ7CbdhpJqw+Z8w9jTXcITB6iiJhpb1kdKZYseAHz4WAKZTTR
	yNlMpVKubTvOFmYcOk+mj7aVQsoq0OYa7lFF4P4oMRx/JzQrs2h4x5P75+1VqXoAjmJNBrCaRHA
	mvbw63JegJ0UMKagIUq3nprp3I/QBVbkCVdQ4RdgI3eiDdu7JAc1kpjWQSYN0WCwqi4wTd1W9yv
	juA7IzxgqAEBV3RRXxGJWn0sywiv4rkuZBC0sm3MBIjXBg0XA4/dc9IVIq9L+BwrvGnK/a4NIip
	yYoGT+AHVnMuiz+zObICHKQQ==
X-Received: by 2002:a53:acc8:0:20b0:645:443d:10a2 with SMTP id 956f58d0204a3-64eaa6de975mr11313981d50.26.1774310896621;
        Mon, 23 Mar 2026 17:08:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabe7e34esm6912892d50.10.2026.03.23.17.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:08:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 23 Mar 2026 17:08:10 -0700
Subject: [PATCH net-next v2] selftests: drv-net: add missing tc config
 options for netkit tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-config-fixes-for-nk-tests-v2-1-6c505d83e52d@meta.com>
X-B4-Tracking: v=1; b=H4sIAOrVwWkC/42NQQrDIBAAvyJ7zha1aQRP/UfJIdU1WUq1uBJSQ
 v5eyAt6nmFmB6HKJODVDpVWFi4ZvLKdgrBMeSbkCF6B1XbQV6sxlJx4xsQbCaZSMb+wkTTBoY/
 OPd2tdzFBp+BT6bTAqwdkaphpazB2ChaWVur3nK7m5H/0V4MGDVlNYYgxOLq/qU2XUN4wHsfxA
 41u3gjLAAAA
X-Change-ID: 20260320-config-fixes-for-nk-tests-64d77b7547df
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270819-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5A632FF708
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

The NetDrvContEnv env context uses tc clsact qdiscs and BPF tc filters
for traffic redirection, but the kernel config options are missing from
the selftests config.

Without them, the tc qdisc installation trips on:

  CMD: tc qdisc add dev enp1s0 clsact
    EXIT: 2
    STDERR: Error: Specified qdisc kind is unknown.

  net.lib.py.utils.CmdExitFailure: Command failed

Add CONFIG_NET_CLS_ACT and CONFIG_NET_SCH_INGRESS to enable these tc
options.

Fixes: 3f74d5bb807e ("selftests/net: Add env for container based tests")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- change tag to net-next
- Link to v1: https://lore.kernel.org/r/20260320-config-fixes-for-nk-tests-v1-1-1e20ec6ddc7e@meta.com
---
 tools/testing/selftests/drivers/net/hw/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 235c0a1cd21e..dd50cb8a7911 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -6,9 +6,11 @@ CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
+CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NETKIT=y
+CONFIG_NET_SCH_INGRESS=y
 CONFIG_UDMABUF=y
 CONFIG_VXLAN=y

---
base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
change-id: 20260320-config-fixes-for-nk-tests-64d77b7547df

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


