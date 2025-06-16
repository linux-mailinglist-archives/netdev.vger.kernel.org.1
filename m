Return-Path: <netdev+bounces-198112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50715ADB478
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C05E7A4207
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0188202F87;
	Mon, 16 Jun 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK/oEMMB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822619D07E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085510; cv=none; b=YcDikqkpf4LGHEcSC2LTy/DKDFR4rvLpeHNq0J0ULK4bibxzmp2QSyodtzrCeDZdffJcTHPikMyn6hzld2fre94b28fjQUnJ7jGvid+UtOLBLGFJFCtzubUVoOM+zEnwgU1cLWjRjabsLsQ6llSC/KmN+fHRAnVUAkkmynqUweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085510; c=relaxed/simple;
	bh=fM5dEQqwAiXD+1IrxGX1Pq9Lhfoon8UuGqtgWNQuMLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcCFqxWfAgahCkRijAE90+EmKB5j+xv4NITJellFUcyeouohV2bahr2Bp16g188GZWS0dqki2BT+gk5h1n4EgfKj/9ubRi8c3KHumMKhZbVxttaaFnpwHAyP42vXFITQoxRHxEwg9ed4Gexa5Ic+B8FBj6X7td08XKnAzB67nzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XK/oEMMB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750085508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zB0/juvTmsIMPjbtAoDAeMzCmECBZlu9WLKm2WtRE4E=;
	b=XK/oEMMBmbaz/mYjqx9h2zUs2WXiwxfZb1QVfCE8XsJpk9oa+U66ctrGRSmRJjYgxYTfuC
	yq6x5Zq5X3e2bfQMChvX8ve1YjHOEcVEDQnChSJEnxVGRzG12DoDOlkHFQwzXUv5tn9dn0
	RYrFcYZWjqcEXo/YJ4HA/kEmsmxSGGU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-YCYRpJyBMSWxjKSG9-9yxg-1; Mon, 16 Jun 2025 10:51:47 -0400
X-MC-Unique: YCYRpJyBMSWxjKSG9-9yxg-1
X-Mimecast-MFC-AGG-ID: YCYRpJyBMSWxjKSG9-9yxg_1750085506
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70e43123ec6so57056557b3.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 07:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750085506; x=1750690306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zB0/juvTmsIMPjbtAoDAeMzCmECBZlu9WLKm2WtRE4E=;
        b=no80CMt3+eH7K8K02AbX3ju4XPY+nEb+lQ8xQ7VbcpE3+F0FEnWrybbNafjlN3DjP5
         OEZV8sCfrHYlai7PDGvyBgzXTLfEPv0wbAwiWabNjzncPQvvLFqDJHTQW8uMo2wCY9Vj
         kFkqpnxAphnxYZy8Rpseb6RFatbvhgzlQ/4QR5Y8FiX4HLoFyULhy8ZC5N83UNAapTnc
         alLYkKQV8tFsiOffbZpIsI/8+eygNIZs11PkUpz+6162owGNYeuicr1WeAIUCaXjGlFW
         iVVN0ADeZbt5ZGpn82Jucn4Mz5dwEiUeiUjm5oOXCR441SUZueua9m3MPZfvXw1CjpKH
         Ow2w==
X-Forwarded-Encrypted: i=1; AJvYcCVzjGO/hnObCcdcpkqdaqYjT58jzIVrj7dlLth5oC8zUtOaPmhmWeVbQ6dPsO3r2Y3JAevuN3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrGoIBYCo45TbXSAX/2UdQji9It5ka5Ql8aCqnGssf+hu8OX0
	uDMekUiXJknjhlZeVkHMhRp/cAO2j/6LkUdgS1eULgzkwmYrHSFNYPwlgHpxJfC9Vzafktjs/KD
	w3TY+wbZ2a8H4woS9XOeC3QtVYWncSl81ePKwa3ZgLpidgWIgh21Z4qAiWJxacM9QTP+MtkffJ4
	UYzH9NQ3fpriaodRRzKFOt+x7zL1hgZIbB
X-Gm-Gg: ASbGncu/QmsRlq3sXLudauuyfPs8jw1q/v1A5hUDW/PZduZD40GGiJuQSwx2X6TEWSc
	wLtFIDTvKk7hk94FA/qGyxdQsLOPACrhfYqXSfcpBbSiQewZokT+X6UdtG8GgjHd4y9hxFEoTCR
	+yNHCt
X-Received: by 2002:a05:690c:c1d:b0:70f:9fcd:2075 with SMTP id 00721157ae682-7117536cfa2mr129054637b3.3.1750085506480;
        Mon, 16 Jun 2025 07:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYU9W5CA6OGz5GV8F5Kca6HL2nfxx98+wK9SD5MXInZikANAipuJ04VBv4A8FLyyEMPh5RPv6YlqBYjCJXTy0=
X-Received: by 2002:a05:690c:c1d:b0:70f:9fcd:2075 with SMTP id
 00721157ae682-7117536cfa2mr129054157b3.3.1750085506091; Mon, 16 Jun 2025
 07:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2oxz7toygswngn7kfmsrbmpikk5qggwbvk3oxb5ucrbq3pcfff@azc54m4hwlfb> <20250616143901.1187273-1-niuxuewei.nxw@antgroup.com>
In-Reply-To: <20250616143901.1187273-1-niuxuewei.nxw@antgroup.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 16 Jun 2025 16:51:34 +0200
X-Gm-Features: AX0GCFtzcxtqSQms8qF31ded0ASL17rZKHWqGZvF6K-bj9-TCcblqN-BEMBZdqc
Message-ID: <CAGxU2F6FtJT1fyZQ9JTExYF6OsJ6J8HRiOetX09JB6rTzVtVcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] test/vsock: Add ioctl SIOCINQ tests
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, fupan.lfp@antgroup.com, jasowang@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, niuxuewei.nxw@antgroup.com, pabeni@redhat.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Jun 2025 at 16:39, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>
> > On Fri, Jun 13, 2025 at 11:11:52AM +0800, Xuewei Niu wrote:
> > >This patch adds SIOCINQ ioctl tests for both SOCK_STREAM and
> > >SOCK_SEQPACKET.
> > >
> > >The client waits for the server to send data, and checks if the SIOCINQ
> > >ioctl value matches the data size. After consuming the data, the client
> > >checks if the SIOCINQ value is 0.
> > >
> > >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> > >---
> > > tools/testing/vsock/util.c       | 36 ++++++++++----
> > > tools/testing/vsock/util.h       |  2 +
> > > tools/testing/vsock/vsock_test.c | 83 +++++++++++++++++++++++++++++++-
> > > 3 files changed, 111 insertions(+), 10 deletions(-)
> > >
> > >diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> > >index 0c7e9cbcbc85..472246198966 100644
> > >--- a/tools/testing/vsock/util.c
> > >+++ b/tools/testing/vsock/util.c
> > >@@ -97,28 +97,46 @@ void vsock_wait_remote_close(int fd)
> > >     close(epollfd);
> > > }
> > >
> > >-/* Wait until transport reports no data left to be sent.
> > >- * Return false if transport does not implement the unsent_bytes() callback.
> > >+/* Wait until ioctl gives an expected int value.
> > >+ * Return a negative value if the op is not supported.
> > >  */
> > >-bool vsock_wait_sent(int fd)
> > >+int ioctl_int(int fd, unsigned long op, int *actual, int expected)
> > > {
> > >-    int ret, sock_bytes_unsent;
> > >+    int ret;
> > >+    char name[32];
> > >+
> > >+    if (!actual) {
> > >+            fprintf(stderr, "%s requires a non-null pointer\n", __func__);
> > >+            exit(EXIT_FAILURE);
> > >+    }
> > >+
> > >+    snprintf(name, sizeof(name), "ioctl(%lu)", op);
> > >
> > >     timeout_begin(TIMEOUT);
> > >     do {
> > >-            ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
> > >+            ret = ioctl(fd, op, actual);
> > >             if (ret < 0) {
> > >                     if (errno == EOPNOTSUPP)
> > >                             break;
> > >
> > >-                    perror("ioctl(SIOCOUTQ)");
> > >+                    perror(name);
> > >                     exit(EXIT_FAILURE);
> > >             }
> > >-            timeout_check("SIOCOUTQ");
> > >-    } while (sock_bytes_unsent != 0);
> > >+            timeout_check(name);
> > >+    } while (*actual != expected);
> > >     timeout_end();
> > >
> > >-    return !ret;
> > >+    return ret;
> > >+}
> > >+
> > >+/* Wait until transport reports no data left to be sent.
> > >+ * Return false if transport does not implement the unsent_bytes() callback.
> > >+ */
> > >+bool vsock_wait_sent(int fd)
> > >+{
> > >+    int sock_bytes_unsent;
> > >+
> > >+    return !(ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0));
> > > }
> >
> > Please split this patch in 2, one where you do the refactoring in
> > util.c/h and one for the new test.
>
> Will do.
>
> > > /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
> > >diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> > >index 5e2db67072d5..945c85ff8d22 100644
> > >--- a/tools/testing/vsock/util.h
> > >+++ b/tools/testing/vsock/util.h
> > >@@ -3,6 +3,7 @@
> > > #define UTIL_H
> > >
> > > #include <sys/socket.h>
> > >+#include <sys/ioctl.h>
> >
> > Why we need this in util.h?
>
> We call `ioctl()` in the util.c. And we use `TIOCINQ` in the vsock_test.c,
> where includes "util.h". So including `sys/ioctl.h` in util.h is needed.

But we are not using anything in util.c from sys/ioctl.h IIUC, in that
case please move it in util.c where actually is needed.

Thanks,
Stefano


