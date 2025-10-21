Return-Path: <netdev+bounces-231165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C1BF5EB6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EB63AE4AA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6540D32ABEF;
	Tue, 21 Oct 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0q1hG6+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C72D2488
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044355; cv=none; b=nOaTTteMB1bxXhlcW+TA68i/a4zIPciQsXVQJsY2c0gv63uT7pdc1Q2XjAgeY/CLojXy90myAZSTq5xS6/Ta6NJBXiLaovYCIZ1oBw6HgPfb9IyXG4j2TtfDLqwwbBWIqGZlrJD5YfJp5hpb4+4qw4MGfsacqZ4qW4ne41EYOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044355; c=relaxed/simple;
	bh=wJore6SkdiUigz0m5hCvhNRwbxLLvUZhfIf8ib3aDOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKnsEJ596IJaXRXVYcpW5zC4/BTriQTfMZYX9IQ181X0kPoRkaPNddsExB/0KGBGilu5Zgsqz0x3iLmA1/qgQwSYeWbMEkn0jXMUel95PQ9PuMQLHgE4VcmAlItlR7WzZGiWVkkgiuhOODpRcWPIKuW6km4vKGB1XNgOim9oTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0q1hG6+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761044352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tLu0P37OAGAyXjDXsy8rw7Ys47RNWwlPbkWxUF81WlI=;
	b=F0q1hG6+SdFo5Xl3P8nONHiAPjI+3U7Edx4wMh6Cgtw0Xm18kz9qf7W5/s6kNRofdcD8iw
	gSCkIhHRzM5CgsK5Gw0CPr9StTpPko2ds/cHXNduLerjUCCz/C7pA8rZifOmiHg0yskE0s
	0CPVtko/SQwP4hJDtfMFquZiqpFCKtc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-vl5qH47uPNmmurmR48mt5w-1; Tue, 21 Oct 2025 06:59:11 -0400
X-MC-Unique: vl5qH47uPNmmurmR48mt5w-1
X-Mimecast-MFC-AGG-ID: vl5qH47uPNmmurmR48mt5w_1761044350
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e39567579so32782825e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044348; x=1761649148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLu0P37OAGAyXjDXsy8rw7Ys47RNWwlPbkWxUF81WlI=;
        b=iH6fva6DQM32XoUpeK0IV/+f1jNg5uwQY5QeS0j6gk+Sd/1ba8hOd3G8NJSjxYSJXr
         qo6R/QzDic/6r2aKpVdRZ7h9Usmy8uDfas16n8wwa+6j1A7fHMIsBbV1rlJ5FRuPt91Q
         BzgyElc6xEn//mPS9Ei1upvvTpEPB820esshTgmZz7/ZvY6UAsHsRGAzElkWwIXTPD4j
         qoXU8RegXbmcizEQO9cm5147a/B84t4tu/jleuLAZvlxAHnUzPA6fUR8RHCcXelcgesv
         a5UGXvSHUam/y7FKpMWSJ8+Bf67nXz+y6gLr8ChpuiRs33QjUL6ZuKpcyrH2vO3CC1/L
         A/vg==
X-Forwarded-Encrypted: i=1; AJvYcCUiHg8BSkA70ZspmAhGZatGeD1lAz+7wxhyt8TAvR8HTRdqJFEwuEBgYX6ZAeZMyGVNUH5eaXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/+Aieha3QIyvJy+tJAMwh2VCys6HS7WViZxxl5n4ZxRn7rAr
	GjlTQ3XKVGcgMhzmawHB86zozHyDJxcrzqla4f/IwlZuFDdm7ZDU/2OGZNhOqMJQgMDAg59taJf
	LQ80LjSXpiysBiJo8mypWEwqTECmgRjSFZ6LLlKxRAEw39v6F7TqRnkhFtw==
X-Gm-Gg: ASbGnctjLFk0SgQBLI2EI/xGAzKKsKzF9Mq9pvVNWiWBaw5MYbXkR71GYvopdS4T7Mb
	EM+5ne6TbCBxgbNzDw7JhqEDz83nDicLmtIH1Ttoy5tLzDRKXR2/nr/RHQ0uvF7YvqTKiR/esit
	BR7vVYEvURDUExY0yYy2KBRb74U0tsMahWrDQPIhsG14iL0NTmESIpVHxSN6xXBFxRfQydt5Myz
	cLXpO7OUoLpr2phRwUUrZ1uj+KFpVandurzdRFRpTdHL/Cp4vcxBqBvk8XKzl8glcLBYbi5qV+S
	KuodLIc2EVxX0r/WyqH6AiMzgnExWK+jyGz30DyRHzZWnc+TSBQyJFBGW5mStG19K6Os6HccVqS
	L66GRmsPw7rCfeSaPc2IXU0O30ckLJR5KeGj36iEkbMQ2sm8LtUM=
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr123011165e9.25.1761044348694;
        Tue, 21 Oct 2025 03:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElT2F8lQ+p8bxtIuwKf2xRtiJ6w0kOux1TMQx/TUc2Rs90xo8tgHVCnbIlBYxYvSBRdYtGnQ==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr123010905e9.25.1761044348244;
        Tue, 21 Oct 2025 03:59:08 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba070sm20000648f8f.42.2025.10.21.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:59:07 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:59:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <jms5wjabuhoohobldv4zzfa6gurpnbw5xb5ejeha7md4z7atpj@r5b7mk5mn4n3>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="smrpmekyls2luon6"
Content-Disposition: inline
In-Reply-To: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>


--smrpmekyls2luon6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
>git tree:       upstream
>console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
>dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
>compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000

#syz test


--smrpmekyls2luon6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-TODO.patch"

From 456534cbdbc7312fa1cddfb7aa50b771725c0a53 Mon Sep 17 00:00:00 2001
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Oct 2025 12:51:45 +0200
Subject: [PATCH] TODO

From: Stefano Garzarella <sgarzare@redhat.com>

---
 net/vmw_vsock/af_vsock.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..89b4dbb859a5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,12 +487,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -512,20 +526,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {
-- 
2.51.0


--smrpmekyls2luon6--


