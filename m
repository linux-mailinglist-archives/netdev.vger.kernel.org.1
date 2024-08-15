Return-Path: <netdev+bounces-118931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE79538CC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B93B1F24E56
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0FC1B1517;
	Thu, 15 Aug 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzVsdFZh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5514C147
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741907; cv=none; b=GRV/ckCiPvpnH1m9hhZctkNOi/xSNtPHluMxIcr93Bt5iYe4KBWuSzRvpZ9COseq3BWRTJTgO5VLt51L8XmBIKPqLKGBWwKFYSdqGNEM8SQtSil80MQ8l0Ua22NlFftTH5gtNUUJaZDY4FPswxPttsXA/WtVcgPajlREOt9cjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741907; c=relaxed/simple;
	bh=5Z8TAq/G/u02vyAAaf+Zg2akHzrDfh6oAqkYCS1m+xA=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=syL1V0VLfd00++waIhI2v3R7xjS3r7cHYQqesFvYgO028lr6xwpzMYQAhRQSXTdsyZU4U87xmLB6n7IwoT/hAk1e5n3GCsAbQ/eKrK9e2n2nENl4TFEEDZ5l11zPVoWzEhgvtxBqQKxvKRJyA4SFiMq90oZRMqlk36gACiUK4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzVsdFZh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428fb103724so11784925e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723741904; x=1724346704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7sE09k+ffSYmOoNPd3YlcO5fyyUm5Inj0TF/sowYeE=;
        b=ZzVsdFZhj0TXJbil16y7vehcUeYcB7syzkYM5zH+EoexJMHpK6vWoSHwfuZCB9Z4aP
         VmnlRaAli4StcIq3JevmvYexw54tmdYGSYeC1SaJ2/4GM4YMNCeMmHWL97KVSHZkwErO
         gVKpOmgWfNwnl0oKV4hnsYem3bFviRvwNETDmu8dDVkMCt3tg4h2qPOYbWCvSOml+3WC
         hTwC1zpvw36BJhSk6W1GXrv48PPbBrEhu3QF20IzOvEkYlC4iPObck8eEcM/vZr013zz
         bu3hD6oV00wPzK2jcBsriVww0Hu34HTwWjIaaaC+X9Mc1MgMcvdCrPaCfrtir6CZr218
         1Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723741904; x=1724346704;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7sE09k+ffSYmOoNPd3YlcO5fyyUm5Inj0TF/sowYeE=;
        b=CiRDQmEG0kF+bXoKq0ixxRNHZbI+p0tv1k384aAuAFUI8Acaoi5Nhndi5rsmCWS9vW
         MLKgEon11DEcRCVvyEGRCV96XhLRiWovgHKrW6TuXkuA1+7ud4ifnWpobLHaRrhEmMtr
         5cFfvcV7WAsl741Cl4QTyN5W+U6McQZYMdM1NAixms6gvX/UbxYQ9+gUSWQ2mNiA/697
         2V2q/5MJpe66uUQ2AF93OjBnzmTOkk7pEWe+NcRPv39CR12xwvIuiPYwjrz8AhtiRB9E
         b6+JdeFtgEbepMM2xs+ytoq6/kKZYMBI8f7+7kbHaun2UlClWHlaBXsSqR8IRRZr3EZz
         rgZA==
X-Gm-Message-State: AOJu0YxEj9OsSvOmCWNjyVTEUoem93FQva/dY2iQqjL/IZigdPPrKzSZ
	Oa2J6MMeUInExqZcJaV4dgjGdum/OETdcSU2x7oENF7pjd+W+GKSIjhtHg==
X-Google-Smtp-Source: AGHT+IEzlvRLFkIaUBz90yszOPCtbL8N9AZ5s3bXRT+6GaBHWg4nwEP0vdD/E5q0vw9VB0XlBbOxlQ==
X-Received: by 2002:a05:600c:5251:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-429ed4922d1mr546905e9.9.1723741903572;
        Thu, 15 Aug 2024 10:11:43 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded36051sm53572645e9.24.2024.08.15.10.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 10:11:43 -0700 (PDT)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Subject: Per-queue stats question
Message-ID: <56a36d45-f779-0c67-2853-6ead9e8f9dc9@gmail.com>
Date: Thu, 15 Aug 2024 18:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

I'm working on adding netdev_stat_ops support to sfc, and finding that
 the expectations of the selftest around the relation between qstats
 and rtnl stats are difficult for us to meet.  I'm not sure whether it
 is our existing rtnl stats or the qstats I'm adding that have the
 wrong semantics.

sfc fills in rtnl_link_stats64 with MAC stats from the firmware (or
 'vadaptor stats' if using SR-IOV).  These count packets (or bytes)
 since last FW boot/reset (for instance, "ethtool --reset $dev all"
 clears them).  (Also, for reasons I'm still investigating, while the
 interface is administratively down they read as zero, then jump back
 to what they were on "ip link set up".)  Moreover, the counts are
 updated by periodic DMA, so can be up to 1 second stale.
The queue stats, meanwhile, are maintained in software, and count
 since ifup (efx_start_channels()), so that they can be reset on
 reconfiguration; the base_stats count since driver probe
 (efx_alloc_channels()).

Thus, as it stands, it is possible for qstats and rtstats to disagree,
 in both directions.  For example:
* Driver is unloaded and then loaded again.  base_stats will reset,
  but MAC stats won't.
* ethtool reset.  MAC stats will reset, but base_stats won't.
* Traffic is passing during the test.  qstats will be up to date,
  whereas MAC stats, being up to 1s stale, could be far behind.
* RX filter drops (e.g. unwanted destination MAC address).  These are
  counted in MAC stats but since they never reach the driver they're
  not counted in qstats/base_stats (and by my reading of netdev.yaml
  they shouldn't be, even if we could).

Any of these will cause the stats.pkt_byte_sum selftest to fail.
Which side do I need to change, qstats or rtstats?  Or is the test
 being too strict?

On a related note, I notice that the stat_cmp() function within that
 selftest returns the first nonzero delta it finds in the stats, so
 that if (say) tx-packets goes forwards but rx-packets goes backwards,
 it will return >0 causing the rx-packets delta to be ignored.  Is
 this intended behaviour, or should I submit a patch?

-ed

