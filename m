Return-Path: <netdev+bounces-36845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9807C7B1FF4
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 16:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B5A531C2097F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFAF3FB08;
	Thu, 28 Sep 2023 14:45:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AB3B2AE
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 14:45:07 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D31A1
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 07:45:02 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1704654366b.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 07:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912301; x=1696517101;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91dHlTlXNCIf2/mTTpM1oLN+DVcQdYlY6t1IKajEJ48=;
        b=mAVJjkTRhj6AJGjmtYL8hZDN02Lb4Sl7U9wbTc8OFarD66IpLXFFhc+T7WcA2unRgj
         eKywae3awewfI+0yo7P8QegA5GVhKbhcB5NYMxD1vlgl5VqZeAHoUGv/JQ1c/X6c20RB
         hpoEwBtAGten2wzjJ2zGxWnOX5RoV66erJiVbKStUho0n2n9XQYE5FoyMKW7bIGcFuJk
         eEW2TxR8MydfmLolkRABP1rVNMUC2fYWF8Iq79LtQl9oSvURwcOs+5yMD7wGbIm17IwU
         FjMCDeRW3a1FamGS6JOmAG0Br0j5q0wh/kvkqemcVSrwbnfRGqtaRcKPAPvkou3i1bgY
         yv1w==
X-Gm-Message-State: AOJu0YzdOruiKv19euyH9kbaYX/7gu0mCeGMP1/Ho2gYbIy7cJzlAGAK
	l7VdjeauD36DLvXqq64dxFjo53tdF7E=
X-Google-Smtp-Source: AGHT+IHYqxQxZf8S662gQpm5gCNZbGDbn0SdYAP38R13WnumWtKByWRBZwq7ma/hMwWINnHBsIv67A==
X-Received: by 2002:a17:907:2e01:b0:99b:ed44:1a79 with SMTP id ig1-20020a1709072e0100b0099bed441a79mr1392581ejc.3.1695912300897;
        Thu, 28 Sep 2023 07:45:00 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-001.fbsv.net. [2a03:2880:31ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id bu10-20020a170906a14a00b0099bd7b26639sm11047960ejb.6.2023.09.28.07.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:45:00 -0700 (PDT)
Date: Thu, 28 Sep 2023 07:44:58 -0700
From: Breno Leitao <leitao@debian.org>
To: jlbec@evilplan.org, hch@lst.de
Cc: netdev@vger.kernel.org
Subject: configfs: Create config_item from netconsole
Message-ID: <ZRWRal5bW93px4km@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Right now there is a limitation in netconsole, where it is impossible to
disable or modify the target created from the command line parameter.
(netconsole=...).

"netconsole" cmdline parameter sets the remote IP, and if the remote IP
changes, the machine needs to be rebooted (with the new remote IP set in
the command line parameter).

I am planning to reuse the dynamic netconsole mechanism for
the 'command line' target, i.e., create a `cmdline` configfs_item for
the "command line" target, so, the user can modify the "command line"
target in configfs in runtime. Something as :

	echo 0 > /sys/kernel/config/netconsole/cmdline/enabled
	echo <new-IP> > /sys/kernel/config/netconsole/cmdline/remote_ip
	echo 1 > /sys/kernel/config/netconsole/cmdline/enabled

I didn't find a configfs API to register a configfs_item into a
config_group. Basically the make_item() callbacks are called once the
inode is created by the user at mkdir(2) time, but now I need to create
it at the driver initialization.

Should I create a configfs_register_item() to solve this problem?

Thanks!

