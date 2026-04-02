Return-Path: <netdev+bounces-274418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMQ9IUomzmnElAYAu9opvQ
	(envelope-from <netdev+bounces-274418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:18:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F069D385C88
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8053019518
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2DE3314C2;
	Thu,  2 Apr 2026 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm7t+OgM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6UBu7Yo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F432ED24
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117889; cv=none; b=L4lVLI0LrH6GINl+BZnoeG1i3DdacFZ69laViXSWGLxUkNPy+h4VkGq+mPZvgl18bGDJbSAV3VD7gYCFT1olWTQ8vq1D4FcmcgEFtwY8svmUN57UnhcNKwCEns9NYiOKtJ5ksoBdJISUOblkb6tES+yCsaQkv/6GCUTCiZTvRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117889; c=relaxed/simple;
	bh=Gv4j5F5kmYPN2toSNOT0NUM+Ds/EorTosVmZDSuDh0M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AERaxQEeAXaPxOuBjt6Stj4F9DhYnaCjDyHbyjKyut1/WdM3MXNv1p/fRX7mqc8UQUzayIXnMJ36JBqannt2rrtUuZqm2xXTBVMv9iEGrqSSzvHZinsU4ixNq0+CtsUeRWeJUwO4L9GUaZOuKKMgb0zN7ScuBX4VlAJ/IyLNdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dm7t+OgM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6UBu7Yo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775117887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t6mFCTOwHARpB/AAY05EQ/dyhhMmoktNcIHAMGcB1vg=;
	b=Dm7t+OgMdQ4Wfg5ug4cdghgZ8DGPzHtltpKN0EhpcO12jf4pb4/nO08+P/4a3aIPDGsb9a
	4pmkz2vTE1Qj4DO/AsorIs+sNbE0YFGts/duPvfbBUeMkF9stlRi0qPwzAJcVODw6CNW4n
	AZ27i2tw+aKj1E43UR4rX2/wWn4hY74=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-XBlXxOXtPPWGIsQOrshcuA-1; Thu, 02 Apr 2026 04:18:05 -0400
X-MC-Unique: XBlXxOXtPPWGIsQOrshcuA-1
X-Mimecast-MFC-AGG-ID: XBlXxOXtPPWGIsQOrshcuA_1775117884
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836abfc742so7098635e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775117884; x=1775722684; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6mFCTOwHARpB/AAY05EQ/dyhhMmoktNcIHAMGcB1vg=;
        b=W6UBu7YoWWWnVoXkcpjZxrWDhOCU111Vcd1eLd+fAvnPiSoIUADdCdTneNlQsZ99bv
         CSA3FrdSG6GTVNk1pRNNp4lgpvP9f+sBl9leKwW9EkVCflqFkto2xPPDe+g7rN3l/Aug
         evn7y+tG6QN6bedZsCJ2r7znGrwR345Ci1UvxFnqFIRrDr1ycgY7EFTK1OhScKCAoz98
         eRPjCHgrMp6q9z+CzBwNy082JHjxLeFQbkw25RZ3d9B1fLV3s9o9Z7FV6dfd1HpsLY0g
         +OZuI72Tqy1PVoRPGYQ6Xny1YCtIGJV78FsnZlL1MvK+xnSKhovAdli3n5W96Bt+Gm25
         BcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117884; x=1775722684;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6mFCTOwHARpB/AAY05EQ/dyhhMmoktNcIHAMGcB1vg=;
        b=sgI27wYefTm7jZqutPGxaC2PCVek8DuDlpL9RQt4TAblzYagAeBdf7oghUdGJtX5ql
         HIEpbTQESBFX6ggf9/xyo28Z3S8NI3t3z1JyM+FiSCjW1NgvcHlYo+xFxMVS1yrW1boW
         JNZ0XEXcytHZ0Qt0PWyy1qoFMCaXcRf1JVVAaNluO/pAtBoUbUatFbktyj/epCm8uP0Z
         Ib8ZKJWwl/rHReo/hPg9BUUj6dW0tyU7KJNND43koyP3o3eMD1MR8KfXpXGS24MueYtQ
         drvl6tWiDsYX39cqfeXeXsJRCDcpx+ViiymUrVryNieQGuDLpQDkEhXxTo60vybFWOTv
         +d3g==
X-Forwarded-Encrypted: i=1; AJvYcCWvr7y15XwLN5vNALCC19s6OmaQKZxqETqcJEY0IpForzdy8ixWv3e0MAHmPlr9k87l1XDGPDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlabQdiRe1Rv/RK2InUZlJgW0VN5CC3xDxErip2bcq9be7FTHw
	YIONFttPqNaBIJjU3c1fXVCpMhRS4okjd88zqi1v41Z4nnbyFw3HoZkJHAEYdjpunNUj8wP+QWs
	4vgk16esV+W2TuKD92xL09DoWylgJ22rvyW843yVgZrTMKp0ro5SmO94SYQ==
X-Gm-Gg: ATEYQzwhRxRMA3rt8IgtxZ3Iefc2JkFojUkru3Z2RH1iruZeWG+gLFyhH2fsVSPcQ3Z
	ILz2LZ9cgtqT/534uqroNUgWcextGmarChzTdSG4OqSWo7qgVumnxg2I0qsX9bjg5FPNGICg+HO
	NcJZbi93MPVIkGwGbsFy8G43doqsJDi5M3x9FDq0L+LClHpWBF10Q+XvNWFdMvQfppGPAFVJH1U
	nVGUxyE/thhQLt2nyXNgDG41wrRhs6yprvFK2+5ZEpEiiTlPRX8TwPdfPi5G8AceY0MDyn5HhRd
	uHqzDcGsEeELPu9mmUYFbGGMh88t8Nr8q7ntV2cnHvA6ALUh0XunjPD0DVnHSjMSlJnfRnoglo1
	wOUeM3G89v3Rc1CX/92Y5tcA5R37FPAl8dvPpUlcpwYKdyXuT9o9+C6LjpzHa
X-Received: by 2002:a05:600c:45c5:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-4888356a036mr110318905e9.3.1775117884403;
        Thu, 02 Apr 2026 01:18:04 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-4888356a036mr110318555e9.3.1775117883944;
        Thu, 02 Apr 2026 01:18:03 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm214476005e9.0.2026.04.02.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:18:03 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net 0/2] vsock/virtio: fix MSG_PEEK calculation on bytes to
 copy
Date: Thu, 02 Apr 2026 10:18:00 +0200
Message-Id: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3bTMiviC1NRsXTMLY/MkC2MTM8tUYyWg8oKiVKAc2KhopbzUEqX
 Y2loAioNizF8AAAA=
X-Change-ID: 20260401-fix_peek-6837b83469e3
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-274418-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F069D385C88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`virtio_transport_stream_do_peek`, when calculating the number of bytes to copy,
didn't consider the `offset`, caused by partial reads that happend before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commit.

Commit 1 introduces the fix
Commit 2 introduces a test that checks for this bug to avoid future
regressions.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (2):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++-
 tools/testing/vsock/vsock_test.c        | 64 +++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 3 deletions(-)
---
base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


