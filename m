Return-Path: <netdev+bounces-278817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G2xAE6q32mOXgAAu9opvQ
	(envelope-from <netdev+bounces-278817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:10:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28460405B51
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99A933008C9E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B523D88E6;
	Wed, 15 Apr 2026 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrGg9Jb+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ss/WZkPg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007203B2FD2
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265786; cv=none; b=TCXqelBMrFsIksMqmTshIzjLyi0hlbIN/TYpXTSF4hM49qcGkwDIHmPnJu1uRz3CVJcjbKcvOV4ZcNXtTT0a2O9uU23ymYaoWWSdnztDewmQFy6k2dkl46c4uLjSXdFVCReBBs4TuRHA761v3DBVBnGRKNRFlcY+rAT2y/Qi388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265786; c=relaxed/simple;
	bh=B5WKSuazSjYIg6pXvSVj3VKZEuyDVABRTNFWpy0TJsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mo7PvpRMWzOrhpL+5h6Gsqjr04wU6bpdktZEjNvDXyU2hgSyG2DgZEiWBVkUGJ2HMRe+WwqKa81hROQ4TzbW84wQoUSOl8AkAyFBrUSCMFnVhUltE5FmuMhhfHlNva/3NZGlhiXt3gD109OeL0hNVMtpzGR+DL7PrfvvUFQ3gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrGg9Jb+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ss/WZkPg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SFZ1c4j1EFVbHkK0HGQBwId3xqOOHFTPClHfmjw9dVA=;
	b=QrGg9Jb+XofV/2WXVRRL3Uvjf2ZVn0c+vg4Ii8C39aule0y3je859puq4xgfucnx2mr8CN
	gcvLmHBqS2JoZXKfGqHwi5RwTQet45iRagYdakPToV4G2giRC+dsuB6sNWOPVWVlr65NNN
	nj4WsiLGqnrBmrrWOqq22FvL/qTA5u4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-YXAnZfcgNT2wP4FdIB_hJA-1; Wed, 15 Apr 2026 11:09:41 -0400
X-MC-Unique: YXAnZfcgNT2wP4FdIB_hJA-1
X-Mimecast-MFC-AGG-ID: YXAnZfcgNT2wP4FdIB_hJA_1776265780
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d03db814eso7109336f8f.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776265780; x=1776870580; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFZ1c4j1EFVbHkK0HGQBwId3xqOOHFTPClHfmjw9dVA=;
        b=ss/WZkPgQ00Ewmq6HAhvkQILiKp7EPKVX4vuMuE7LLDAqjLS4ty2/IsfHFhn+QgxZO
         aY25rMpvw+ywop6bwIaIMHc7NNllpHqL21tKsVugMgyqOgp4kUGUfaxWWMatbGaXTRX1
         Y9LCwOHOdtqWaJvqyE/fB5oSYNQaFbcYeaidBgmSOcrq/LVVmdbeNulE36gJMzuFIkwY
         IQMQI71diKi5c8WMj7lt8HsrSZLy5byx0UMMI31fUMk/oojTBxQvgV7MNojBhXMOjvjq
         w6sWVSmt0INE98V8XDNETWSLt6B7r8IZYUrYBPg7kjRrtkFpfy10GuYE9DvC5Or3WhvH
         pYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265780; x=1776870580;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFZ1c4j1EFVbHkK0HGQBwId3xqOOHFTPClHfmjw9dVA=;
        b=IO5iwRWj3/UAV5+O4cTWItmBWPVONbRbI5BGft1QTFguORWPCkLIWVx+eGx6SjcmEb
         oRKG9wZGtdLLpuGMQgqMyCvnUAP2d8EdqB5R2WoNm/4HAq2Ml1ahxzl0wFO9du2LfPQC
         h+ac/wc3kkj6p7wAZMriFKbd3ueBhiia9bw/OBMl8V1oRM/naj4VwAh0VI/vNU0F7h1i
         4gGZbwLQFvgvj6SrQwuKYPuhCIYUDoQEBTv06GyLVfKfoPwURTQJwv8h6POnrpW8uHTv
         Dn8VSQqZvAn5+PQOQiQ2rkr9+G2tIowl7EigXKzVHypdOAJLtNa34QvGOAKwtYawo7Kh
         pLXA==
X-Forwarded-Encrypted: i=1; AFNElJ+iOLOsjJqanNBwu/u4iluLRejYK1qAhCC8aAIUOTMFGwgzQIX3DrrmfZlPJdvg0MwBCAuGDbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jmKXXsQmUYQWvVVbiDvr42mhcRAFFIu1pEYQ6FcPAMoCyjbl
	rtJNj+DNg6nha7NnCduK35UmCWy6DwhYQ6ODZOKUgmIQ/qpleCFOPjVAOQUliNoGAWy5tN/npCx
	1TvgSmHqN6GAIF9g8OLOXrlFdQUnXgqfZwBYkz8umTPnun8H75MVL6asWhw==
X-Gm-Gg: AeBDievfW50iX9vIu77tI+bozhRzDi8liHCx3lEBgdGW4ux5yF+WWLL2jsX1EC33ifD
	18DbXs4JiW+oJvDUUWKlBYWaeC76J/0123eQaXte8q2KH4yUP9n+4Ok7LMqXEb7gsFtxyA45WSc
	SYCIywt0AOalNpLMJoiCFEKa7YXmm99YYEkE6pepnJ7yaPoric1R+ezJE/S/ZFbHgBx2FkFtzuf
	Xycw7kE0Mcah86oQ/rgwuDYzvPodmtBx92dgHDXSIWJ69v+E9yaRXvPPr3OxMnExYK7xbnJY+8v
	luXwI+HjYjYVrf0jpZqdpW06BdBilo9O9df1z8iCAUBNXBgU0dm9RfLM2ORbkiC+ypnN6FDfJ0T
	KY4LyWu9WSWCw6pDbzTjCDxncZJAhtmpohx5n4SHr1nsDiU1ccwW1IGzjRY+U
X-Received: by 2002:a05:6000:1a8d:b0:43b:3d4f:e17a with SMTP id ffacd0b85a97d-43d642cd287mr33797814f8f.37.1776265780105;
        Wed, 15 Apr 2026 08:09:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8d:b0:43b:3d4f:e17a with SMTP id ffacd0b85a97d-43d642cd287mr33797739f8f.37.1776265779553;
        Wed, 15 Apr 2026 08:09:39 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:38 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v4 0/3] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Date: Wed, 15 Apr 2026 17:09:27 +0200
Message-Id: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XM3QrCIBiA4VsZHmf413QddR8R4fSzSbQNHVKM3
 XsiQUaH38/zrihC8BDRsVlRgOSjn8Y8iF2DzKDHG2Bv84wYYS0RhGLnn9cZ4I5bxWWvuGg74Ci
 /zwHyraTOaIQFXfJy8HGZwqvkEy2nT4l9S4ligrVlUjgDTsr+FMAOetmb6VEqidVSVpJlyYAdF
 LVG9dL8SV5JKirJswRpNWgrOqf4j9y27Q3PqHqgGgEAAA==
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
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-278817-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28460405B51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`virtio_transport_stream_do_peek`, when calculating the number of bytes to
copy, didn't consider the `offset`, caused by partial reads that happened
before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commits.

Commit 1 introduces the fix
Commit 2 introduces some preliminary work for adding a test and fixes a
problem in existing tests.
Commit 3 introduces a test that checks for this bug to avoid future
regressions.

For disclosure: this bug was found initially by claude opus 4.6, I then analyzed
it and worked on the fix and the test.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v4:
- Picked up RoB
- Increased sleep time from 10 us to 10 ms
- Minor changes to commit messages and comments as suggested by Stefano.
- Link to v3: https://lore.kernel.org/r/20260414-fix_peek-v3-0-e7daead49f83@redhat.com

Changes in v3:
- Addressed reviwers omment
    - Dropped test client, reusing the one already existing
    - Minor changes: added comment, improved commit messages
    - Rebased to latest net-next
- Link to v2: https://lore.kernel.org/r/20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com

Changes in v2:
- Addressed reviewers comment
    - Test now uses the recv_buf utils.
    - Removed unnecessary barrier
    - Checkpatch warnings.
- Added new commit that allows to use recv_buf with MSG_PEEK
- Picked up RoBs
- Link to v1: https://lore.kernel.org/r/20260402-fix_peek-v1-0-ad274fcef77b@redhat.com

---
Luigi Leonardi (3):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: fix MSG_PEEK handling in recv_buf()
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++--
 tools/testing/vsock/util.c              | 15 ++++++++++
 tools/testing/vsock/vsock_test.c        | 50 +++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 15 deletions(-)
---
base-commit: 35c2c39832e569449b9192fa1afbbc4c66227af7
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


