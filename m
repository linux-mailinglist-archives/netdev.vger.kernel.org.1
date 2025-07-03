Return-Path: <netdev+bounces-203939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC6FAF834C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 00:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A1C583481
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2C2BFC85;
	Thu,  3 Jul 2025 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wa3hAirJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C72BF3D7
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581420; cv=none; b=SSzcXHFRg3W4ID1EcYvf0JNI5VnuklLGKZPg/juqYbWDZHLP2GkgFtkpFFTaIFmMMKjzyvbiiGYo7mTm0f02ICF2VQZ4JGz5aySscyXpDk8rFyKcF7cR1RNC9Fidno4wa1UO+IMYEYpTcJ0VsPL4IQ1IPWfJCHBR45MqYmTTOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581420; c=relaxed/simple;
	bh=bHvpc94HXYih2FMFgeA+sRP/r2c8MhvpzQoiO5z8z9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsAY1J2brIUYT3wepZIzF6ILEb4tuRTalLNinnTAq11a5sLAuvtS+MIYrNeETxQ7jnxm09mXPNnURAkA7hDOpj9YBtbPPjKLjWPHJWYlt8kmdYThQ959eoRj8ZBqIeF2+QgPvYL6rbJVA+LtBi5L4lHO+iY+cz17qnZCEMASCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wa3hAirJ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C1D063F5D1
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751581416;
	bh=isC54dUAY8UhtPmgzK1RBnnEBnnC6mxj6C9AzalU9ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=wa3hAirJ53gNQa8GMigVmLo7QYVtXHD0WVOOWggFAxccEPHiFL1DHwE+xyTe2rnMp
	 mHp3qLWh8Y4JK6iXB69UsDKBRb7moXR/sE4NX/lUd2ohEu6nPrCf5u1xmi4O5uyIjh
	 FipZbnurLhos6LTrV2XGNxAsKXNyntlGE/q5kp/oxb8GeideelVKwSPndRblwWG0Ea
	 BzOiDTqwv/OqL5Ad5bC9KS2fNYHzVf5fo9p1B3qdOLgluwNU2ARAlUI8zWH/XPzndW
	 O2kZa/Vxr65MB+GpLd4IWJ5PdV2F9BxClXwaTIZl3Ia+Sv8/N/vvRHfuY/9q7z6073
	 uwNMuFEXqN/JQ==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-60c4d1b0aa4so231877a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 15:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581416; x=1752186216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isC54dUAY8UhtPmgzK1RBnnEBnnC6mxj6C9AzalU9ag=;
        b=cC8yDIgMyJBuHDhLe0QNfJ7/HNjvpGiid4eYJ+LN03BCpIDIK4mGUZCQT6w1d/tbD6
         QZvuV4PZgwp8spqjd2GZz4sQaqqKKlHDyvSV/vJbNR6pu446YCmSs8wlSH7MetwZjvcG
         baG06YCwkGgf3uQvNvVfcT/+M3p4PHLV8xrLWmsF7NKyyBtfThaFduYp0HlpMHWhbIhN
         nwAfpq1NvdxMldxdz/nAeED282j8l3jmjCerPa0NMWpYx2o1aWeBY8N9MYUSIqvJwytT
         rG1GJ+5oNH0HPN+6P0y/Fbr5ZLA/k33S4oYW2InWDV0/YAF3bu9djT+YBDNRmVmDf1U6
         hDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHofdxIoVvZN1hV2T4bJwmjYKrV5z5Cdaa22RageG1HN51uXGxn/F2zFlpYZJWZKKe7QFgRk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xnE4bdJzx37Ehsgkgo2hePAlhJ9MIXzQolkXG1Q1A4pSwku2
	vVzgD2aeE1cNBV+Nu38i6t1bTrBS5AeUfLphP1pe1WlrbdFVSVRkRC0XDSme+qn/HLsr3L+1pYn
	X9EHpGu4UEzicAkm3EzDuVVnbhDTHby5LSIo9jIt/H8HwAy8hGqAZoFytDlwJ4kAB0cND779wEA
	==
X-Gm-Gg: ASbGnct/UqwstfYIcwxJG4EtP9NcxatfpS4ubuu8gKdj2kswA35bzjvAsuHg8qyJyAa
	cotlctpyVPgohN78hoOu3Yn0GA+/1Q+814XazWs9jCykmJtLAuDlQRyacQMsWd82y6nOS6fv2hr
	EPz9g72tQy3CI5cxZco8u2wLXgKW4yOBWgmY0/Q7TxoQDMb4d9/F5HP+raLh5Kif+kw/JP06b1O
	MorrRAWw8YaAnm4bPAp8s03UiIQPE0e9WqP5IIhSYNwdWcRj1zSy6Tc598eAEWNzLX+2V5mehGo
	OBkH+KXSZSCb3a6UtE+jIvriniUXzpzP80vN+t5VZy80y0EhSg==
X-Received: by 2002:a50:d690:0:b0:602:ddbe:480f with SMTP id 4fb4d7f45d1cf-60fd2f9d71amr169525a12.9.1751581416182;
        Thu, 03 Jul 2025 15:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGikx8qQxNwagCh+XgkCJ/7+ysM2PBsMOnRMyCiFbXNruisPLa18BsRHMovC3NS4od+dFHc9w==
X-Received: by 2002:a50:d690:0:b0:602:ddbe:480f with SMTP id 4fb4d7f45d1cf-60fd2f9d71amr169501a12.9.1751581415803;
        Thu, 03 Jul 2025 15:23:35 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fb083sm355164a12.62.2025.07.03.15.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:23:35 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next v3 2/7] af_unix: introduce unix_skb_to_scm helper
Date: Fri,  4 Jul 2025 00:23:06 +0200
Message-ID: <20250703222314.309967-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open-coding let's consolidate this logic in a separate
helper. This will simplify further changes.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 net/unix/af_unix.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fba50ceab42b..df2174d9904d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1955,6 +1955,12 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	return err;
 }
 
+static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
+{
+	scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
+	unix_set_secdata(scm, skb);
+}
+
 /**
  * unix_maybe_add_creds() - Adds current task uid/gid and struct pid to skb if needed.
  * @skb: skb to attach creds to.
@@ -2565,8 +2571,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 
 	memset(&scm, 0, sizeof(scm));
 
-	scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
-	unix_set_secdata(&scm, skb);
+	unix_skb_to_scm(skb, &scm);
 
 	if (!(flags & MSG_PEEK)) {
 		if (UNIXCB(skb).fp)
@@ -2951,8 +2956,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				break;
 		} else if (unix_may_passcred(sk)) {
 			/* Copy credentials */
-			scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
-			unix_set_secdata(&scm, skb);
+			unix_skb_to_scm(skb, &scm);
 			check_creds = true;
 		}
 
-- 
2.43.0


