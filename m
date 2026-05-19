Return-Path: <netdev+bounces-289392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP4MELE+DGqPbAUAu9opvQ
	(envelope-from <netdev+bounces-289392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:42:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C496757CAAA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B694C31069F2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67B4BCADD;
	Tue, 19 May 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw0uXmx8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1924BCAC2
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186207; cv=none; b=a5wgERdHCnSsv7tt7LncHmbINI/laYuy7NA77ala4l4GmuXU2jCiad5aijF0EBOYUFLmH8T/nnlM0lUnY9IzX8gmDgc9Sh37ESleokn5t33RpDyh7n9bWanfd5REd4OyXyIe29gKWbHmvIwE6fO+Cncw9v6xPKimh8uoucOJCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186207; c=relaxed/simple;
	bh=DO0Gh9yEyPAdPj/ANVn8igAk2S/1BupY7L+OcOzpdyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjqcdeXigildMpwDnKESF/U+9BLZtcFk/BYm66+n76OFQrWjE1qOQ9bvxpVUhng3v1pGsL9RfjI34hxdEv0GbUOB6eZI9/vVPMWCnktU+UEEei7prIGxT6OPhoLSAr2z6gXdartLFZvvHZDbtMhfDgm2/hvly2/9sVrmRPe74Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw0uXmx8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36974221f93so1602389a91.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779186205; x=1779791005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wI00RqYwNVXaarsJLcvON/gPH4U7fY7Oeb6rc01MfGw=;
        b=dw0uXmx8wfhvQErBnHKHsyXQmIHBpuoHrvL8TmqDp6nVpzUDm+BgeFRVfEX808Ufr9
         gsO/JCrPk2ijFo0+nlgSyVDB1VEIodsDol1ss/gybvby+jGmdT2oKEMSiEIZXi66JgU1
         ZwJ1g1/oHI0Qyks7ewwGrnWR+bwwjUwQpJebi5Oit0CmgjUx9gm4RnX6W3p5eFm7caXB
         iXWTdAcIVphJdAc7uJXHTbl0mbGRKRSoGmJYEA+V+zx0NwAxElx+PNtxyVRZGdgVTRDA
         S8Z8nY1OzbZj9TUmvGzQI4iIDOG6hxj4LkjoxBk0pqXfxDPmyVgQ17ExUvkaB/3+488O
         lgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186205; x=1779791005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI00RqYwNVXaarsJLcvON/gPH4U7fY7Oeb6rc01MfGw=;
        b=pQ2Brr26ymGbwx/eKSBfVyqMxHNwhrODQt+cc7gHlSPk9QBi0QYF8p5Ci7JzhikgFe
         3Hz7XP3QbDQLti6CqqnDp1MmzSaSX/awSS5CkOfQEAnel57WCkA8eeOlPK84H4DnCyku
         0JjCXuwPlO/hj1RB3WK0XfwkIhhG/cqu0kNOhqXntaJBfqn9SGZbi6uLVGCSqzkA8fjt
         TBQqWecDsVp86R6Nl5Uupz0Yod8wSUj3QJPojlAmdKwGSEsobZ/Y35AAzNbTN3QbYx6+
         l8q80Vq6pzzDkgMDO0hSG3V9QlmJndeFainegaSOqxXlIjQDEIbTO13SJHSO6S9OZvRy
         VGbA==
X-Forwarded-Encrypted: i=1; AFNElJ9zMyiHrWGt28sC+vGunA4QS31VxFau5ep5LeSWdTq1W1ZuligzGtjvln9qitClDzfNpBWlDtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpGTHrg6gWiDtq6BZ0uZD7Z+w7e95u+YgvpTeZ+ZaXxR5MY1v
	1ApVPO+masFKjgXqLKLS3nY9IaoPIDp5aUAa2ThILCTth4u2BpGmEbZ/
X-Gm-Gg: Acq92OEegG8AnPrgRtGTOb+E0mbFRhMH2ysQxkBKtUEzc0laHmyBylVVxUJzSLWjVqX
	HEE9yPTD0Gvpp3SVCHfEv5+GXtSjf+ukWmfB29cTmduiKkzRtw9YE0Khd/0n1K0g9PAMSYSKg5z
	W8q15SVcyxA75hcM0ynNOGQiikWNrcdPL8Y7r/G0XfTHB+fMOgAuLJ0tCJcsbjsfjLv9LvYOeLY
	bntKlNZCOQdlKl95uo9W64lXlmGJPKUEEweVm6sHoIeUJi1snnB8Sa/lD2+U33cG3VLzB6lr8ZM
	BcHbgO2OpvQoNKYp5i+UWtOsKI4t/x5uzBreAdsW+Z/1O/sEJKni2GeTAH6NBUH2qRJXISosXEB
	wBPi2ckc3i6Hk/eZjILoIu8nicl4FMRBz26e7RQOX9hMsJ2lg0GbT736ALfdJsBiETn/aml7P9M
	zmt36CpaiKRKNduruROiTbXJB9qA==
X-Received: by 2002:a17:90b:5290:b0:366:1bab:c3d6 with SMTP id 98e67ed59e1d1-36951a02b73mr18385801a91.10.1779186205288;
        Tue, 19 May 2026 03:23:25 -0700 (PDT)
Received: from fedora ([171.243.49.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695148d53asm13708947a91.15.2026.05.19.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:23:24 -0700 (PDT)
From: Minh Nguyen <minhnguyen.080505@gmail.com>
To: pabeni@redhat.com,
	bryan-bt.tan@broadcom.com
Cc: sgarzare@redhat.com,
	vishnu.dasa@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4] vsock/vmci: fix UAF when peer resets connection during handshake
Date: Tue, 19 May 2026 17:23:10 +0700
Message-ID: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289392-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C496757CAAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmci_transport_recv_connecting_server() returned err = 0 for a peer
RST in its default switch arm:

	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;

That made vmci_transport_recv_listen() skip vsock_remove_pending(),
leaving the pending socket on the listener's pending_links with
sk_state = TCP_CLOSE while destroy: still dropped the explicit
reference taken before schedule_delayed_work().

One second later vsock_pending_work() observed is_pending=true and
performed full cleanup: vsock_remove_pending() then the two trailing
sock_put(sk) calls -- the first reached refcount 0 and __sk_freed
the socket, and the second wrote into the freed object:

  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
  Write of size 4 at addr ffff88800b1cac80 by task kworker
  Workqueue: events vsock_pending_work

Treat peer RST like any other unexpected packet type (err = -EINVAL).
All destroy: arms now return err < 0, so vmci_transport_recv_listen()
removes pending from pending_links synchronously and
vsock_pending_work() takes the is_pending=false / !rejected branch,
dropping only its own work reference.  This also closes the
multi-packet race Sashiko reported on v2: pending is removed from
the list before any subsequent packet can find it.

The pre-existing sk_acceptq_removed() gap on the err < 0 path of
vmci_transport_recv_listen() that Sashiko also noted is not
introduced or changed by this patch.

Tested on lts-6.12.79 with KASAN: 52/100 unpatched -> 0/100 patched.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
v4:
  - Resend as an independent thread per netdev workflow (v3 was
    incorrectly posted in-reply-to the v2 thread).
  - Drop the inline comment expansion; keep the original
    /* Close and cleanup the connection. */.  No functional change.

v3:
  - Different approach to Sashiko/Paolo's "trading UAF for leak"
    concern: normalize RST to err = -EINVAL so all destroy: arms
    take the same err < 0 cleanup path -- no special case, no
    multi-packet race.
  - Sashiko's secondary observation ("while not introduced by this
    patch, does this error path leak sk_ack_backlog slots on failed
    handshakes?") is correct: the sk_acceptq_removed() gap on the
    err < 0 branch of vmci_transport_recv_listen() is pre-existing
    and is not introduced or changed by this patch.  A separate fix
    for that gap is needed and would be welcome.

v2: https://lore.kernel.org/netdev/20260512025851.189140-1-minhnguyen.080505@gmail.com/

v1 was sent to security@kernel.org on 2026-05-10 (not on lore).

 net/vmw_vsock/vmci_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4296ca1..d257938 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1164,7 +1164,7 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 		/* Close and cleanup the connection. */
 		vmci_transport_send_reset(pending, pkt);
 		skerr = EPROTO;
-		err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
+		err = -EINVAL;
 		goto destroy;
 	}
 

base-commit: be48e5fe51a5864566307998286a699d6b986934
-- 
2.54.0


