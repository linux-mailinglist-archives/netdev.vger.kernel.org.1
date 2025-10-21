Return-Path: <netdev+bounces-231146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5445BF5B42
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B31A64E41FB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A822EFDB7;
	Tue, 21 Oct 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeEAuQZm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250A18859B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041380; cv=none; b=kLU9G+enNSkChwuGxHanRNJBilXvSJgbfSqC4sSuIzBsa97M9CKMZvwBox6y0BlZP4S7D/N3tKgo76tIzEQoNGgj80pjVE3hGNm+DlAO019mPG/LsbNO9NUflTc7TekWsMoEJVoNbp4y1x8A9WFVl/tBIz8I8beLAvGsa7jZATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041380; c=relaxed/simple;
	bh=qoH56t7LT6g6R7/qe0J5UEvQjGQX9Eg9cPbyxQT+sZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHbj+Y7VWRbsqSSCw6U/imn7+bTirhdrKnlWJnCtQOMxTXUFP2fF0JzIfdSnQz9Pdl59s2NejO5v1w0jWH13EXEjMciRw7Gmyi9q4+kug1IjXHdAfEtwxq4u3Ylmoah1OxnW3nT9EG+Sn4JNrJK3By1vJKVEgW4A2uiqWkJZvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eeEAuQZm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Smx6c92DDCn6W6yHcZqgijD0yczmTJbxbgpAffJprT8=;
	b=eeEAuQZmC+zI6puzF4u4BMC0vNveGpG4Dvss8gplc1BpcEL432VOotAQ5ei7qZoYNUwkiP
	zmiaLKBsH6Jw8WzgVCMbsnFdmn1QhrSF8+gTo37RUqdyaeaUv0HmeIAkU9czDOiyeBDlgP
	r5YVtODlehMaDpyqUCDuRiZhPzggO1c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-OL9nJuxsNqG1r0dHe8Ttng-1; Tue, 21 Oct 2025 06:09:35 -0400
X-MC-Unique: OL9nJuxsNqG1r0dHe8Ttng-1
X-Mimecast-MFC-AGG-ID: OL9nJuxsNqG1r0dHe8Ttng_1761041374
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426ce339084so4778835f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041374; x=1761646174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Smx6c92DDCn6W6yHcZqgijD0yczmTJbxbgpAffJprT8=;
        b=ap3gIv67aiu2mJxVMWrzzm/ZMMHY3Rx/01/BRgPtzv6BMUjATd5jrqt9e4HCJ2pf9T
         XVePgohym598ph5iJ76z1fYcTn/bGCMH/YGcu4G5OdpXWCC+BoC/p/7gK+HBs7Y8e9UD
         BsuTNh+YtJPWAc++vN3bbHeEb2idaCoBdFkR5YDLUVbOzgiLm7+DA9sTb3WS9alVo2BT
         UTQOpLFOq/UJFR2Ynnu2o9IdCTMpKeMCeVk5arvBSKybE/1/zSNFOzHrZ3AdIo/9IS3+
         m9B362UYlU5NSYv4MYizaWYmpwWTjbRblBVMPb3t9DxYZMfa9xP1xdd+JHF/G0s8kVPe
         LCjg==
X-Forwarded-Encrypted: i=1; AJvYcCXVVAr8BswMPtycoAIkBR4MzFH8Hi9M4iihC3IntOsrpQjMeLvaPtpliT/CY7pee+95N8LUnis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCnIuLC1af6dtfX3eaHGQZFMQ6+/fy+vBAnU4vLOs8aa2vI6C
	vDHuMGB/h6StKbyl3D3TyNncCv+95pm63xbtut1iwtjmuNP/q+k0ZrC5cUSCYlSn7dG2Elmo85u
	4GxC3cZ2esHhee3NvQzlHXp1pTj0xh0AaeXqWCgUstrtXwlxuUCJSKyOJDg==
X-Gm-Gg: ASbGncsWL2rFFg9n1mtOdLeyqUmCwuYiT2mMSiXl6qJ9cETKEVAyL7D7StdNQiujhl/
	Y1ibIQM0j+PLhHoNNIIvW0Lm9Tz7ETKAgI4noSB5SEUCq+bRlso4n3DBfNro3caMECZEst87gv2
	qDym2tpzcMVVPuJUHTi+mhI250eMgTukxzSiqwjehgn02oPaOpDUTok6VgzXUWLi6i0+fj5TLzX
	Y3UPDr0tL2Kzf30iEoTRvQuqlzYIkwLcvLjTynmtpzyuefHKZ23XxawB1GMwV95RphaPLy3ybDz
	om3y/nkVSnOUT3mlrCquzighNGAjv615A1hbVVCVWLTombbAc5xv69GwF0Z8h83ACeT+rFHa2Ss
	YP53qj+tfZCBZWBLphCR1sqzZ5knB8WEFYTGNo7UQSJnqPixaKYk=
X-Received: by 2002:a05:6000:1aca:b0:428:3f32:a947 with SMTP id ffacd0b85a97d-4283f32a9edmr7496025f8f.58.1761041373982;
        Tue, 21 Oct 2025 03:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG3vsiZzr/8K6/PVlmWld696ekgX7HFbOE3sJab5hvSA8I4JhACaeH9zgeRKYP34Ujun0gUA==
X-Received: by 2002:a05:6000:1aca:b0:428:3f32:a947 with SMTP id ffacd0b85a97d-4283f32a9edmr7495998f8f.58.1761041373485;
        Tue, 21 Oct 2025 03:09:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm20168191f8f.28.2025.10.21.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:09:32 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:09:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	Michal Luczaj <mhal@rbox.co>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <mpv4ljrxyucr23x4hj7k7s4vmtvv3bgeq7uct3t44ghaw35l4r@wanp7mklhw7x>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>

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

--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -565,6 +565,11 @@ static u32 vsock_registered_transport_cid(const struct vsock_transport **transpo
         return cid;
  }

+/* vsock_find_cid() must be called outside lock_sock/release_sock
+ * section to avoid a potential lock inversion deadlock with
+ * vsock_assign_transport() where `vsock_register_mutex` is taken when
+ * `sk_lock-AF_VSOCK` is already held.
+ */
  bool vsock_find_cid(unsigned int cid)
  {
         if (cid == vsock_registered_transport_cid(&transport_g2h))
@@ -735,23 +740,14 @@ static int __vsock_bind_dgram(struct vsock_sock *vsk,
         return vsk->transport->dgram_bind(vsk, addr);
  }

+/* The caller must ensure the socket is not already bound and provide a valid
+ * `addr` to bind (VMADDR_CID_ANY, or a CID assgined to a transport).
+ */
  static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
  {
         struct vsock_sock *vsk = vsock_sk(sk);
         int retval;

-       /* First ensure this socket isn't already bound. */
-       if (vsock_addr_bound(&vsk->local_addr))
-               return -EINVAL;
-
-       /* Now bind to the provided address or select appropriate values if
-        * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
-        * like AF_INET prevents binding to a non-local IP address (in most
-        * cases), we only allow binding to a local CID.
-        */
-       if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
-               return -EADDRNOTAVAIL;
-
         switch (sk->sk_socket->type) {
         case SOCK_STREAM:
         case SOCK_SEQPACKET:
@@ -991,15 +987,33 @@ vsock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
  {
         int err;
         struct sock *sk;
+       struct vsock_sock *vsk;
         struct sockaddr_vm *vm_addr;

         sk = sock->sk;
+       vsk = vsock_sk(sk);

         if (vsock_addr_cast(addr, addr_len, &vm_addr) != 0)
                 return -EINVAL;

+       /* Like AF_INET prevents binding to a non-local IP address (in most
+        * cases), we only allow binding to a local CID.
+        */
+       if (vm_addr->svm_cid != VMADDR_CID_ANY &&
+           !vsock_find_cid(vm_addr->svm_cid))
+               return -EADDRNOTAVAIL;
+
         lock_sock(sk);
+
+       /* Ensure this socket isn't already bound. */
+       if (vsock_addr_bound(&vsk->local_addr)) {
+               err = -EINVAL;
+               goto out;
+       }
+
         err = __vsock_bind(sk, vm_addr);
+
+out:
         release_sock(sk);

         return err;


