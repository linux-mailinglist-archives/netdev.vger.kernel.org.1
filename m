Return-Path: <netdev+bounces-278318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FepLgTr3WmulAkAu9opvQ
	(envelope-from <netdev+bounces-278318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:21:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1B33F68CF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87FF230314B4
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602737104D;
	Tue, 14 Apr 2026 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfCdmRFD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D79370D41
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150809; cv=none; b=tIH4eN9fvuFR8QOpa9lQUlbZbrDu2tYRE5JOucIpdInhyxziUCPv0x6h5HFBZjbl+xUdVnO0zTMzlU9CmxuRKoYqRxZ9+NfhQ3QerGYvpva1C2lpyBprDarxH8MeMiaAXTF4nZY2jvi9CXCACWFuy65GNodcNWHycXHUp0uUJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150809; c=relaxed/simple;
	bh=fsj9+YvgQO0AmxG3mtdBbsBPIhzpZ+Jh/dtK/CY/D0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUnHsAGYAxgct4kWP2dULs9GstdwCmUdOlq59C05M/diFpwY7w8zQkEqmxz+5CM0lBh39JKSe89vI2MTJEKVvk0rafpsss7WFxYk1e/xDdRvusYDtcFH+S61H3ke7AymbMg5u5bN8jL0bgfapuYC3NF0lKEbJuUQnrIZoPrZhd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfCdmRFD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so1058194a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 00:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776150807; x=1776755607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d79HgUISkhtoo22RFafauYvd4MagEF+p+1C/yzkS9eY=;
        b=mfCdmRFDXAtW8CHQWQjk8quttQWWIq8+2ZI1DS5mY5XB34qOM0WowkO/pi1faUq4c0
         sBNk0S+D0K0U/HCWsvc98azOZ9UfzoC2lZdqIH+SMURN2YcrM5jrNwQNz6n1V1+Tj1+3
         1GuVW4OAm7234jtCn4hPj8bn1thM3ogUl1AHaFGuFMtE89JgrupyCTrGFP/kBwyQUcqL
         +TyFDNTMTyT64S+vH10PM/lPH0Vxu9XwT30vxkOhLnYvjX/xUtDucrbJK5vngGhxYVYG
         nG4FcbBt/qdOrYZHoKJFSA6eRsg+zBb8DY0qaGLASq5hh+BCQgdESvHO1pgmBE5aNTQc
         J+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776150807; x=1776755607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d79HgUISkhtoo22RFafauYvd4MagEF+p+1C/yzkS9eY=;
        b=qKy6f5BlWKLGVw27cA9HnR1S7JtTCjx7C6JwvFjmkQeRk/oMv7F7x3CvsugIGuU7/F
         N173bWkkGGdA1tZRsGLQ+m73IIuKGtj5E+JIsIbG/CPufzxittiPG4x7/RsJTCIk9sYx
         NTj2t20eOVQrR4DkEzGD5oOZfy43SHJvUUjI0s+IU/qyU6s8tVmPaZK1KdDOD/pUXFXF
         wxYYOgMhVjCe4BeybdB6eRAfFCKOdahQV3PJJw0/tJbmspk2QrIxhw4rTUnj2BgjAXqa
         oyXLrxUV7HHnKxJKX2bP5sFUipt4b+tJNKpCD7px4SEPIKV6cLQZvDx8mw+D1TM04408
         lgRA==
X-Gm-Message-State: AOJu0YxTa60MU/uMD6xd6pf+f0mKkd7LxmiMU5MCWbcYwXz4HTDVyclX
	DRu8h4c8vve4FtQYTa2xaA/WhLKIrnFV7ISvx7KpR4/4qs6e5DHyqfu1FrfRjw==
X-Gm-Gg: AeBDietGytING+4wybkTgUt7sOirIC7FAt/Hq6kv+VWnMUgaMRt4kUA5+maAzIyCH9V
	3A8ynH7De7B+rPrkGzXGR4Ed4926BfsbGEHAfSHkk+z37DlQXj31aOZPJzlLHH0n1tgkZIKwWyo
	CsXC2OsxnFheM5I4crb1vvbvMmddA7rdlMcT+qIPW6qelTLx0rdiZN2w2a/Q9L9JWNAK1VFK5k3
	e4j5aD3vrX6znpiib606ik3icXCHdNHPnOtjPDT20TEvgizSoSNaHb3pULhqlMUyTdTQyLB/OoC
	/gpgVlHREnSkiQqdhrIw33SpeRZ7N+kadJ/MwMnIcmKrJx88MkIZ3ynaF+B/28brhTJsXi+did+
	3J/+EqfFIbu88lXZ7Wj76bzG+ALCesUlUw4RKw5CVaNy1tenjmHOweMnGI9dIU2iuRJ4LwNGbDv
	2MV1pWZjnKC65RCoebGTNxX1JfMQKeoxpvQj15HGzkxzHREJDApIXv231DbOht/hbz8Xpo2MIbW
	ZHKORkQeXGM7cem
X-Received: by 2002:a17:90b:4c0e:b0:35f:b931:d1c0 with SMTP id 98e67ed59e1d1-35fb931d34emr5043694a91.6.1776150807333;
        Tue, 14 Apr 2026 00:13:27 -0700 (PDT)
Received: from localhost.localdomain ([103.129.135.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6eac856sm1120134a91.17.2026.04.14.00.13.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 00:13:27 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mISDN: socket: drop device references acquired by get_mdevice()
Date: Tue, 14 Apr 2026 12:58:22 +0545
Message-ID: <20260414071322.30851-1-shuvampandey1@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278318-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,di.name:url,dn.id:url,dn.name:url]
X-Rspamd-Queue-Id: BE1B33F68CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_mdevice() wraps class_find_device(), which returns a device with a
reference held.

socket.c leaks those references in two places. IMGETDEVINFO and
IMSETDEVNAME never drop the temporary lookup reference, and the
references stored in _pms(sk)->dev by base_sock_bind() and
data_sock_bind() are never released when the socket is closed.

Drop the temporary references after the ioctl completes, and release the
stored device reference from the base and data socket release paths.

Fixes: b36b654a7e82 ("mISDN: Create /sys/class/mISDN")
Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/isdn/mISDN/socket.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 77b900db1ca..9209ee68f9c 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -266,6 +266,11 @@ data_sock_release(struct socket *sock)
 
 	lock_sock(sk);
 
+	if (_pms(sk)->dev) {
+		put_device(&_pms(sk)->dev->dev);
+		_pms(sk)->dev = NULL;
+	}
+
 	sock_orphan(sk);
 	skb_queue_purge(&sk->sk_receive_queue);
 
@@ -387,6 +392,7 @@ data_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
+			put_device(&dev->dev);
 		} else
 			err = -ENODEV;
 		break;
@@ -623,6 +629,11 @@ base_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	if (_pms(sk)->dev) {
+		put_device(&_pms(sk)->dev->dev);
+		_pms(sk)->dev = NULL;
+	}
+
 	mISDN_sock_unlink(&base_sockets, sk);
 	sock_orphan(sk);
 	sock_put(sk);
@@ -670,6 +681,7 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
+			put_device(&dev->dev);
 		} else
 			err = -ENODEV;
 		break;
@@ -683,10 +695,12 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		}
 		dn.name[sizeof(dn.name) - 1] = '\0';
 		dev = get_mdevice(dn.id);
-		if (dev)
+		if (dev) {
 			err = device_rename(&dev->dev, dn.name);
-		else
+			put_device(&dev->dev);
+		} else {
 			err = -ENODEV;
+		}
 	}
 	break;
 	default:
-- 
2.50.1 (Apple Git-155)


