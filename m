Return-Path: <netdev+bounces-70857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E5B850D37
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 05:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899B0B226C1
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 04:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5A15AB;
	Mon, 12 Feb 2024 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wU93G+P3"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCF538D;
	Mon, 12 Feb 2024 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707712427; cv=none; b=VwZpxW8HAUDwlV+N3hX+By1z1QyiAqq1xT44QKnrMssvtSZ6WhperPvj8onML/OOX4nmbSLH88AtWziH2D5phWAXOj3ZpVJyzLBpQ2+Q/U12RO8vnYcbf/78YEMqT2cNqYuW+JjMW0lJ70vKnaaYmpiSMKAZYMZZ0aBOmoefNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707712427; c=relaxed/simple;
	bh=srSsx91Wo31ggQOZduqjok/gOOdh8ghgynV5L1e7wYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FsfAdMUA+6jnC+dGzSr5ew8KNhnmdcct60AebjcRiqarx0ktllY10/ilLOT6Hf1n08Rad1hh4MVcZ7+6ajn0CU9a+S4H8o/eo1qf6cLt/5iwKVGNsbMQQ8CYyeqLQU+mCxmMZqQ3DCmfKXL1SOC9/Fs/NauvH2Y1po2ijAF/aAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wU93G+P3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=AHn3rT05hPddMNDYbUFVZGVPvCrbbUb4a3zWRfdPlCo=; b=wU93G+P3553dUUk8f/m/qLiODb
	R299PfzeVpE1/2Gzo2LbPWj+I1lEkJX4JgzyLIWxasGLXiHflr9X8iMRxBh+5wOnb0YAEJPOVSGlj
	Oq/roz/j23QZOxOFNR37KcCgPJ30BhUSGU4FRNksiyBllj5920FbWKIko0Oz9j14qSxZzI4ecTmYn
	IdNX+h35hFy9jB5BqONk/KSSj5yVpP3qRdLyw0ucL/8RxOECzqvIxi3jw7YMbCZsdF07ertNAxooN
	e8f5faeheKSQP+3RTehcY0BydQr39RRn2itTAz0cMNjEKhEFlV6ujTcbn8yR2r6Qr1aNjbN36eJ2E
	4PDCdEAA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZO0j-00000004JTa-3iAa;
	Mon, 12 Feb 2024 04:33:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	v9fs@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2] 9p/trans_fd: remove Excess kernel-doc comment
Date: Sun, 11 Feb 2024 20:33:41 -0800
Message-ID: <20240212043341.4631-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the "@req" kernel-doc description since there is not 'req'
member in the struct p9_conn.

Fixes one kernel-doc warning:
trans_fd.c:133: warning: Excess struct member 'req' description in 'p9_conn'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: add Simon's Reviewed-by;
    rebase & resend;

 net/9p/trans_fd.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/net/9p/trans_fd.c b/net/9p/trans_fd.c
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -95,7 +95,6 @@ struct p9_poll_wait {
  * @unsent_req_list: accounting for requests that haven't been sent
  * @rreq: read request
  * @wreq: write request
- * @req: current request being processed (if any)
  * @tmp_buf: temporary buffer to read in header
  * @rc: temporary fcall for reading current frame
  * @wpos: write position for current frame

