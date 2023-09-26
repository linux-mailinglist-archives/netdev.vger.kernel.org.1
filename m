Return-Path: <netdev+bounces-36303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D78567AED9B
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 15:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 27B52B20981
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B325D28DA8;
	Tue, 26 Sep 2023 13:04:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D902770B
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 13:04:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D55F3
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695733479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pw3uLk1RX7EItsMeljDJQUwIv63n45/6NY/27SYTAmo=;
	b=FOdNHx0O7Mzvr+gNApSPjRGbXufqoyCY6rUhahLgkbA50Qcg8XnOstCw4iz8udCis89Wvb
	jVZ7p9LL8wAWDG5JVgvRDc11Vn2t1JQiwKWPVSOW25VJjhTbemtGVGCSahTuMpsKkdc/I0
	rXPEKg1j+M6ZUWGYWXTcXAqcDgDMc1g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-zCEMO5MHOeCoHwi3iIkp2Q-1; Tue, 26 Sep 2023 09:04:37 -0400
X-MC-Unique: zCEMO5MHOeCoHwi3iIkp2Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99388334de6so753048466b.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 06:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695733476; x=1696338276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw3uLk1RX7EItsMeljDJQUwIv63n45/6NY/27SYTAmo=;
        b=DAq35Bfz2iPjwYJgc/+8nie/MKy0Fq/jIYcvRm54gqsnue4MRu3P+T5H+nuPgp1BGi
         xpxrPAAKtGY5sDh2Ao2aw/H4VVdCMDPMD1hEKbnRpsfTqIl+5kpxFQ4s2AxIS0Woj4We
         hl/E1v+NzuTOZlnS8hHaMj/gi6hX2Kkv+UtTRLf7HJagdi092GWjV/Qr6cIq/4oeQwU1
         6fMaHG743ve7H2IQwSlSYbxfCvfAjuC32ACDzjFPDA6brCfxiN80RBbCC3HdWnFniBjv
         hdUJykmXHJIgcmpLT2R0+cbKs/60SGbA9RFgn7nTeFNiZksXfRHKRVTiYrzd4mbYpHnY
         4ysw==
X-Gm-Message-State: AOJu0YwETw0KeZRo2soLqVjQfDnD7TzVFnCdexmkHnZ+rUKTugTdked4
	9zmIymRFygxsGjR5baYKJi0Kd9UVLphFwhqepE/WZ92t18EFQy7CttgMfnneLfPxSta4KQIH1sU
	9OkvKBvieFSEcR0hH
X-Received: by 2002:a17:906:3299:b0:9ae:6196:a4d0 with SMTP id 25-20020a170906329900b009ae6196a4d0mr8605611ejw.17.1695733476617;
        Tue, 26 Sep 2023 06:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPT+qJWI4CE1FK30C7JELaHKq82GsQA7VABRt7UrHezh/PpcrPOPNsUXvYOw92dsnA/haacQ==
X-Received: by 2002:a17:906:3299:b0:9ae:6196:a4d0 with SMTP id 25-20020a170906329900b009ae6196a4d0mr8605597ejw.17.1695733476299;
        Tue, 26 Sep 2023 06:04:36 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906704b00b00999bb1e01dfsm7746690ejj.52.2023.09.26.06.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 06:04:35 -0700 (PDT)
Date: Tue, 26 Sep 2023 15:04:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1 12/12] test/vsock: io_uring rx/tx tests
Message-ID: <kfuzqzhrgdk5f5arbq4n3vd6vro6533aeysqhdgqevcqxrdm6e@57ylpkc2t4q4>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-13-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922052428.4005676-13-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 08:24:28AM +0300, Arseniy Krasnov wrote:
>This adds set of tests which use io_uring for rx/tx. This test suite is
>implemented as separated util like 'vsock_test' and has the same set of
>input arguments as 'vsock_test'. These tests only cover cases of data
>transmission (no connect/bind/accept etc).
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * Use LDLIBS instead of LDFLAGS.
>
> tools/testing/vsock/Makefile           |   7 +-
> tools/testing/vsock/vsock_uring_test.c | 321 +++++++++++++++++++++++++
> 2 files changed, 327 insertions(+), 1 deletion(-)
> create mode 100644 tools/testing/vsock/vsock_uring_test.c
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index 1a26f60a596c..c84380bfc18d 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -1,12 +1,17 @@
> # SPDX-License-Identifier: GPL-2.0-only
>+ifeq ($(MAKECMDGOALS),vsock_uring_test)
>+LDLIBS = -luring
>+endif
>+

This will fails if for example we call make with more targets,
e.g. `make vsock_test vsock_uring_test`.

I'd suggest to use something like this:

--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -1,13 +1,11 @@
  # SPDX-License-Identifier: GPL-2.0-only
-ifeq ($(MAKECMDGOALS),vsock_uring_test)
-LDLIBS = -luring
-endif
-
  all: test vsock_perf
  test: vsock_test vsock_diag_test
  vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o
  vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
  vsock_perf: vsock_perf.o
+
+vsock_uring_test: LDLIBS = -luring
  vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o

  CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE

> all: test vsock_perf
> test: vsock_test vsock_diag_test
> vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o
> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
> vsock_perf: vsock_perf.o
>+vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o

Shoud we add this new test to the "test" target as well?

Stefano


