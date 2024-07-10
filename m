Return-Path: <netdev+bounces-110531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27A592CDF8
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42590B21713
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0F18FA15;
	Wed, 10 Jul 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCzC3IWo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA218FA07
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602677; cv=none; b=oujMz5Dpz8qkWIEUWVNUtM87C5MtiQKl6CTBMFfo9L36jMKWBJN1z4DMMaQtGXfJkU9+dZTZZ1GHSdvqIWglzuBkme1r/Sm4UlRxWVy/10lWaTcGOk16CfwuJ2F/1NvaZqnZgu1u3G8Tpk9OXkAlBiBRhZ4LXgmrgI3ytV2erpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602677; c=relaxed/simple;
	bh=sVcVGZKl2xwIdvcTfd9mefZDBHmsqt4J1Ded4unQblk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT/z9mRMZvOnBSRmgL2B/xOnPFqrFmbLyShLZNZjjFTWZMOMoDF6ZUNLzZXze1DUcXwd4Yt/mJTzKgNPtKBcEUmH310vcZa/76nGtieXH44W+M7C6pc/urOxl4SG4L1h7JHCQm/1isiQMrJ3TsWw7WrmOW47FDGjkCyrCGtU3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCzC3IWo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720602674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cQDDUjmr5ak9+joDdULTaEfg0ceo+yAVZe0qbv7s9U=;
	b=eCzC3IWorez0Lj9ZpteT6qRgOOlUfK3WQvHK+6AXVVyk8aS45HveFRA65G/rhBucNH2Rnm
	7Z6JQ6UbP2iYF161BEaMsqxQIVSWQS0vvjPCw8iHXiPUJsOBAAhFPuKjsdvoVc1GhECr4G
	enoBvFKBxDgc3/Q+Po7MZB8hCiiJkFM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-Hp1hFiYqNBiefU4yL7O71Q-1; Wed, 10 Jul 2024 05:11:09 -0400
X-MC-Unique: Hp1hFiYqNBiefU4yL7O71Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-58d24cad85aso4828453a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 02:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720602668; x=1721207468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cQDDUjmr5ak9+joDdULTaEfg0ceo+yAVZe0qbv7s9U=;
        b=jNLiabaV8b35qNJkxLC7gTlr1GRwRR8VP6Ibv8fgSy+EofMrRJ0w0byMvJtjPEelbN
         j3k+X0t2RovD8oam6yINV4ix88GTqK79GNpRqCA7aQgNaFOZ2aeFr+efXZ3Cvx8Q7wXG
         JhuU1YDEgMVj63icvqDKcSu707Z/Opdme7CvLFRN4xs5nAEUZeGbl2AOBJA4foIObWW9
         +7HEqpX53Gk0QarRRAJY18U9rm0obVmYNc5A4jIbNCgq08Makp0Phj00ykb3Hw65DY9r
         UD/GG4nYjwZdhAf1IFqKxybDbuTcG6uZdCaqey/jhV2JjhqAvZDYqgqYKraHM14zS3yl
         bdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Ojqp5Rk/ufAf6bOa2WpPh/nn2B6Nh9IGDyfZFas+FRP/uygB5eBivU6iXbr5y73GtSnuSv1jlqtzo8j0hY4QBBGV3ON6
X-Gm-Message-State: AOJu0YyLod0Ss8nqBLSlROdNUHjWs/hwPEas9buH7deDYzkPFY2l7PUy
	fKLq6xJdTNMouXtO4LY0Kg/luwte+XhvIpUX7crUkCTnEEKO5qdUMCwuf3H/iyWu1C9zSch3yde
	ljjVRRR7qxJ0dML4C5tAONWyhlRfcYMyTnfI6wObyIrpSJ4/uRpSNoQ==
X-Received: by 2002:a05:6402:2552:b0:58b:1df9:d3c1 with SMTP id 4fb4d7f45d1cf-594baf871aamr3923846a12.12.1720602668488;
        Wed, 10 Jul 2024 02:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMHjnifV3M27H8S9u+6/lvaJAWQKKtA/LzTGGDKIijdNacTcJVUCSPqn79d2thZJLRbSd3sQ==
X-Received: by 2002:a05:6402:2552:b0:58b:1df9:d3c1 with SMTP id 4fb4d7f45d1cf-594baf871aamr3923807a12.12.1720602667795;
        Wed, 10 Jul 2024 02:11:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bba548e8sm2009554a12.1.2024.07.10.02.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:11:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:11:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Wed, Jul 10, 2024 at 08:11:32AM GMT, Peng Fan wrote:
>> Subject: Re: [PATCH] test/vsock: add install target
>>
>> On Tue, Jul 09, 2024 at 09:50:51PM GMT, Peng Fan (OSS) wrote:
>> >From: Peng Fan <peng.fan@nxp.com>
>> >
>> >Add install target for vsock to make Yocto easy to install the images.
>> >
>> >Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> >---
>> > tools/testing/vsock/Makefile | 12 ++++++++++++
>> > 1 file changed, 12 insertions(+)
>> >
>> >diff --git a/tools/testing/vsock/Makefile
>> >b/tools/testing/vsock/Makefile index a7f56a09ca9f..5c8442fa9460
>> 100644
>> >--- a/tools/testing/vsock/Makefile
>> >+++ b/tools/testing/vsock/Makefile
>> >@@ -8,8 +8,20 @@ vsock_perf: vsock_perf.o
>> msg_zerocopy_common.o
>> > vsock_uring_test: LDLIBS = -luring
>> > vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
>> >msg_zerocopy_common.o
>> >
>> >+VSOCK_INSTALL_PATH ?= $(abspath .)
>> >+# Avoid changing the rest of the logic here and lib.mk.
>> >+INSTALL_PATH := $(VSOCK_INSTALL_PATH)
>> >+
>> > CFLAGS += -g -O2 -Werror -Wall -I. -I../../include
>> > -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow
>> > -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -
>> D_GNU_SOURCE
>> > .PHONY: all test clean
>> > clean:
>> > 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
>> vsock_uring_test
>> > -include *.d
>> >+
>> >+install: all
>> >+	@# Ask all targets to install their files
>> >+	mkdir -p $(INSTALL_PATH)/vsock
>>
>> why using the "vsock" subdir?
>>
>> IIUC you were inspired by selftests/Makefile, but it installs under
>> $(INSTALL_PATH)/kselftest/ the scripts used by the main one
>> `run_kselftest.sh`, which is installed in $(INSTALL_PATH instead.
>> So in this case I would install everything in $(INSTALL_PATH).
>>
>> WDYT?
>
>I agree.
>
>>
>> >+	install -m 744 vsock_test $(INSTALL_PATH)/vsock/
>> >+	install -m 744 vsock_perf $(INSTALL_PATH)/vsock/
>> >+	install -m 744 vsock_diag_test $(INSTALL_PATH)/vsock/
>> >+	install -m 744 vsock_uring_test $(INSTALL_PATH)/vsock/
>>
>> Also from selftests/Makefile, what about using the ifdef instead of
>> using $(abspath .) as default place?
>>
>> I mean this:
>>
>> install: all
>> ifdef INSTALL_PATH
>>    ...
>> else
>> 	$(error Error: set INSTALL_PATH to use install) endif
>
>Is the following looks good to you?
>
># Avoid conflict with INSTALL_PATH set by the main Makefile
>VSOCK_INSTALL_PATH ?=
>INSTALL_PATH := $(VSOCK_INSTALL_PATH)

I'm not a super Makefile expert, but why do we need both 
VSOCK_INSTALL_PATH and INSTALL_PATH?

Stefano

>
>install: all
>ifdef INSTALL_PATH
>        mkdir -p $(INSTALL_PATH)
>        install -m 744 vsock_test $(INSTALL_PATH)
>        install -m 744 vsock_perf $(INSTALL_PATH)
>        install -m 744 vsock_diag_test $(INSTALL_PATH)
>        install -m 744 vsock_uring_test $(INSTALL_PATH)
>else
>        $(error Error: set INSTALL_PATH to use install)
>Endif
>
>Thanks,
>Peng.
>>
>> Thanks,
>> Stefano
>


