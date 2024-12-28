Return-Path: <netdev+bounces-154406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD709FD8CF
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 03:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0275B3A1C42
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 02:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346001BF58;
	Sat, 28 Dec 2024 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu6pQKLu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA78A94D;
	Sat, 28 Dec 2024 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735351984; cv=none; b=IwhfUcgpiVyHaAvCnVOxuKoBUrNLdFV4FbrwXypnEMtMqmws1QV7bWYxIgDKsSdfTcScjNG4Su5zpNIL5QIhLEh63HQn6QQJCNyRqvesxSfndAi4uOyrs2jCZNWiDrU/WIr5ahz71ISOAyla6nVbSplKt3HPkWjNOEgadyxk0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735351984; c=relaxed/simple;
	bh=8k2ycm6WzDL53A2YVzeAhYZDwzfKmBlRp1okTYpuJGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N76tjAB2cksVBoHHh+rbEV0zChboHESy5sWXG9ftFpR0e2KeoavvhXRFlsPCKIjMPmIFlK4jdoulqS57PGF885bi9Hv2TwAD2Z7z93NlY278ejhreAZNz441EZ5aad7fYhpfxJ2lUABkvHktWIlDfu6gzWMBGHUcAx5htZVaqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu6pQKLu; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844e10ef3cfso635906039f.2;
        Fri, 27 Dec 2024 18:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735351981; x=1735956781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HckcGp9Mm52HEKboKooKICK3xGgVXhZaS0c6B4YoKDQ=;
        b=Mu6pQKLuBLbwSB50+JBjov+Tad3MX4jZMzBaw7o1rmTCRNGa7u0ahdUhETC23yoqwn
         oAVXobcGTzn3uZ7BF+Xafa8UmobtNWvitT43hm23/G+pkUXofL1+J56ajyp7zOzYCaDh
         miYK+aHLt1cZ62D+eKlzwtLB4/Wl1LN/IsHojJVX2Qtc6Ro5IysGp7QiXpHaNd2Ztt2q
         RODunUe8T9ZMhfM9EJWXeJTMdkjbdIK9OAjA9ko/1OwrhP7VnWH9ZgRr3WM3B5AVKg20
         9bjDKHsk16CpMfGM3vgj1X8pEFfMH//+fjErA/OIpbp1WKnxXFFfk4QYXIweiB48UW7z
         bV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735351981; x=1735956781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HckcGp9Mm52HEKboKooKICK3xGgVXhZaS0c6B4YoKDQ=;
        b=qRvB41pEMy14d6fZjPRWvSM6tihfJ6nQFNfkeD4kxrtinWdwCx47PuvcXdR+Ho2xqw
         PkpoXTqHEEYn/qGtS/puv3vmPkgbJD4XDIjCeQPRqnLlzUt8cCRbkKLEHxEiKKnu3RPw
         fGmU4CymSHcPGlgzdb4AVl7AB3pJ5eNvZ2U2aGYU0tF5MC6m0LeK4IRdhsGVc1nhhcMm
         rPwwo4VYSTP/L7UvZBEmyorRjrORjACgt7IdkvudrA/5JEGLU8XPZBfEPcFppaI0e9vL
         j4MB7hF50LYrRZjehyZNcoybql536nK8HBPhHxxO4Vf2QEy+xar7ZvY8GBOb6MFhbHVR
         Sy9A==
X-Forwarded-Encrypted: i=1; AJvYcCUMH64Mf2ial1zQV8EbrfohR+NiW0VnW3T1RcHEkNfUyaEYLSEBa95hl4AkzePgGSXdTcCuMbiPnbAj8Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJoxf0LiLn5xH9g1B4eSBz77Mu+z7M74eWLw19bQN+fEwT6SH
	WRyr3QrGZulTu/G6h6pHOSYoZ6i8yAFRogbOSel+b4Jik5SSUT+B5RSYKwwY
X-Gm-Gg: ASbGncsa5eCMdB4dEzQYZ1QA/daZHbQBOwbWMLnQESqF3Hlr0qrLwFNUkUjs8qHfF/s
	vEvDy8zPghDJ5ThwgYGF4KjEwr1Uc9KiS5w49/WP9eDp0RzLc02Dm1SPDVrQPv2WMAB6PeWU+Uu
	4eM8sNHS5zwspF4TLmhpX5ZH3k2ay7LkH4gl0ZPTAQ97VeWrerGZQKhxfm1yZHc7DI7YOZoVoma
	lQOiJz69UCZt46L1Yy0SEa0WAQ3/TyM0zCbtovpgJ8amGvuJDCo0GU1WxYrSGA=
X-Google-Smtp-Source: AGHT+IHHXgo9Q9MTc7kIfYDG0P8LQ8WTksc6z+9+2m0n83tppCr267aLudV1zUV8D+OWCQPZl/wB7w==
X-Received: by 2002:a05:6602:1611:b0:83a:a82b:f856 with SMTP id ca18e2360f4ac-8499e4a7776mr3070904439f.3.1735351981482;
        Fri, 27 Dec 2024 18:13:01 -0800 (PST)
Received: from T490s.eknapm ([174.93.21.120])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66f47sm4398555173.40.2024.12.27.18.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 18:13:00 -0800 (PST)
From: Antonio Pastor <antonio.pastor@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: antonio.pastor@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: 802: reset skb->transport_header
Date: Fri, 27 Dec 2024 21:12:16 -0500
Message-ID: <20241228021220.296648-1-antonio.pastor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <38130786-702c-4089-a518-cba7857448ca@gmail.com>
References: <38130786-702c-4089-a518-cba7857448ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

802.2+LLC+SNAP frames received by napi_complete_done() with GRO and DSA
have skb->transport_header set two bytes short, or pointing 2 bytes
before network_header & skb->data. This was an issue as snap_rcv()
expected offset to point to SNAP header (OID:PID), causing packet to
be dropped.

A fix at llc_fixup_skb() (a024e377efed) resets transport_header,
addressing the issue. This patch is additional clean up to snap_rcv()
so that it resets the offset after pulling the skb instead of
incrementing it to match the pull.

Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>
---
 net/802/psnap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/802/psnap.c b/net/802/psnap.c
index fca9d454905f..252006f81afa 100644
--- a/net/802/psnap.c
+++ b/net/802/psnap.c
@@ -58,8 +58,8 @@ static int snap_rcv(struct sk_buff *skb, struct net_device *dev,
 	proto = find_snap_client(skb_transport_header(skb));
 	if (proto) {
 		/* Pass the frame on. */
-		skb->transport_header += 5;
 		skb_pull_rcsum(skb, 5);
+		skb_reset_transport_header(skb);
 		rc = proto->rcvfunc(skb, dev, &snap_packet_type, orig_dev);
 	}
 	rcu_read_unlock();
-- 
2.43.0


