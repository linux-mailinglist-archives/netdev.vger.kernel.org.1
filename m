Return-Path: <netdev+bounces-110507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB592CBFA
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF48AB23582
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCC84A28;
	Wed, 10 Jul 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ubq8fPvW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BAF83CD5
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596892; cv=none; b=Z7IGeXQx6ctyuZMUwuIKvMI0kfl++YoBYzjzSdMsasREGc9R3Ja+MDfpjQBNcJ/ccM9BJF6bIl8DjhTvBFtcOj00vRZg9un8Vr8ia7Q0xdlkjGKUQwGU9TSU3NGqwAMJbHFC01eANO1MnaNr2ZOSOZ0b7Mrw1p55XjKZ6Ju5/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596892; c=relaxed/simple;
	bh=NfrfV5Vy+VM7vSghradxFkPpeufS31T/y1I2gyDTmrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA++GRVX8d6KmeZAaLy1gmC2ALSZ8dl2+GE1Vgw31L4rv62+DTfMf9KhwGuCVpTB9WjksnSKgNgs47jJk9iJyTXlvmEL5lpVNdo3EaZTq/382MOV/b7Lv7HFlEJWbOAkuKuof5bnFoiWieYcMUf4Scd3/iJws+pZXhFx2Ok61Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ubq8fPvW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720596887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2M3DvwDrSJcyOfWVtdeker8I2MWaBFXWRzk+di5ddk=;
	b=Ubq8fPvWJB1PnPVejWBJ+vE1Hd6B7K9x4Bfg8ZAh0XaUKQVkFJGqXRHKyy+vHTec7v8ibq
	afoYdAqvAzLDpoi3HrmN+JTFmZ3x37f2UGmoj26nW/zcA143DPV7c74upZGRadRbu+Froz
	VIIplRTvaaOpojzJOaa+U8qrY1sL0Fc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628--2Yqh6baNd-D8OesKSSG3w-1; Wed, 10 Jul 2024 03:34:46 -0400
X-MC-Unique: -2Yqh6baNd-D8OesKSSG3w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-58bee115291so5806120a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 00:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720596885; x=1721201685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2M3DvwDrSJcyOfWVtdeker8I2MWaBFXWRzk+di5ddk=;
        b=ggQhv2bZ6KiZeIHJTIpQ06iLudWBeeePgrHZ90cOyJTvsMeeAceByV2JWsaLAfTDNl
         rngtE2p3I/f4FM5UVQqp9OezXx6KiqXk/h6G7KcbZhy5ORjtFHi56m4FEic5kyl7Fu0t
         44b8jqG+KTIN+6AG4cy7/Jcu0NGymNzBkO0sTIvmwGX0zS/7A3D3ty2z1Fqn822Gy4o4
         zcxBj1uaZBFxLXKhLZ5vrvTuyUp89dLm/TQv+49leX47ZencaPWTkdplHZ3xt83xqfYD
         aeoSeB9JSU6noCOdBrQb5PJTbDst4JACmWz+UILJnvJI2HISk961LHFqo9+XYrQuD5v2
         4duA==
X-Forwarded-Encrypted: i=1; AJvYcCXPUBwCcahA9wNVoblnsCbbystOOSRpyFL9L/MfhN3NH1zPM+ZsOWe6O6Ua8W1rNKGBLQ3WX4q+OoM6IKHBt3OL/BRdusrO
X-Gm-Message-State: AOJu0YxCjrFghRwgY2fOH0JdShFbJKPyW/f5U6Yx5r0sKYWchNouEEKm
	jihw1Id5EoSQERAE/fchdE0SHFzeG/57EtKlykZuithgJSgUgy61xO7OO9dlXuNEUbqDw6lHpES
	xPvuqZwaYjQ7NVkQKaESC8Yv/D6RZ3Ur2wINIQ7jQ135mVM9GtEqJRb4iRFwIYw==
X-Received: by 2002:a17:906:d925:b0:a77:c364:c4f2 with SMTP id a640c23a62f3a-a780b883457mr263385666b.52.1720596884833;
        Wed, 10 Jul 2024 00:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdCK3sPHoX5ymCLdtTzOFCG6cqJ6FCKNdOKjpgNsX4y+qO5d6Ij6ITF6psUTIa6WmxdNi7Pw==
X-Received: by 2002:a17:906:d925:b0:a77:c364:c4f2 with SMTP id a640c23a62f3a-a780b883457mr263384166b.52.1720596884237;
        Wed, 10 Jul 2024 00:34:44 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc520sm136516266b.51.2024.07.10.00.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:34:43 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:34:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240709135051.3152502-1-peng.fan@oss.nxp.com>

On Tue, Jul 09, 2024 at 09:50:51PM GMT, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>Add install target for vsock to make Yocto easy to install the images.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
> tools/testing/vsock/Makefile | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index a7f56a09ca9f..5c8442fa9460 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o msg_zerocopy_common.o
> vsock_uring_test: LDLIBS = -luring
> vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
>
>+VSOCK_INSTALL_PATH ?= $(abspath .)
>+# Avoid changing the rest of the logic here and lib.mk.
>+INSTALL_PATH := $(VSOCK_INSTALL_PATH)
>+
> CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
> .PHONY: all test clean
> clean:
> 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf vsock_uring_test
> -include *.d
>+
>+install: all
>+	@# Ask all targets to install their files
>+	mkdir -p $(INSTALL_PATH)/vsock

why using the "vsock" subdir?

IIUC you were inspired by selftests/Makefile, but it installs under 
$(INSTALL_PATH)/kselftest/ the scripts used by the main one 
`run_kselftest.sh`, which is installed in $(INSTALL_PATH instead.
So in this case I would install everything in $(INSTALL_PATH).

WDYT?

>+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
>+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
>+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
>+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/

Also from selftests/Makefile, what about using the ifdef instead of 
using $(abspath .) as default place?

I mean this:

install: all
ifdef INSTALL_PATH
   ...
else
	$(error Error: set INSTALL_PATH to use install)
endif

Thanks,
Stefano


