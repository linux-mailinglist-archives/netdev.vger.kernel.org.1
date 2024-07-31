Return-Path: <netdev+bounces-114419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B1B942865
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9251C21567
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E941A4B2A;
	Wed, 31 Jul 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYK5ug9a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04923BB
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412368; cv=none; b=S1cnzefKilABtjB6p7P9RoXqicngGYlkCT+JWgORcRkaRZphuW1HlLIZKBBH9vKALgm7pizdCowkNN6Mi6xypyuPUcd76ZRySJUPF/U5AqBH3fCB5v0ChS2gTTSfke+L10EdT2m0hLZCvy2FpOvDlctEKihvNOLncs6UH+wZv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412368; c=relaxed/simple;
	bh=ONnh5M5S0DlFDhcKvXNYHxA3YvsCrvwQ+s3zqVwpGg4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KYAp4xF0UHwipesTuJBrTlKX4APnfh8igo2JDSe1hj5X45FZtu3R5edbOkZPgyJtlFwqAb2+YzZiSb6hlhcnp38iTvg4e7wDZPvi+yICsz3DSrrVefMlvAhgD7bznmcJUCIRNjHIB3FoTlDYqv7M15iCIaxyrGJK7oT5QJSt8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYK5ug9a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722412365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxcEL5fBlhm4jOeAsHs8xDqWAgTzea7TRTpZX+8zVvc=;
	b=ZYK5ug9ajXCxzMgobvUeptAKyKWF8YY+4pxhDBr5U2cJq/zPK/nx+1O/30AFuSD+Szxi1J
	MFtNWvJZJs0wPrL6ETqc08yadEHF6Q60ir3WT7afbnCJ8aCRW8pmu0RV19EtIdgFx990Ew
	JgdwEkra7mnbJAOwrbktI53k8wEAzyQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-X6Lo6BauMmmC0LBEnue13g-1; Wed, 31 Jul 2024 03:52:44 -0400
X-MC-Unique: X6Lo6BauMmmC0LBEnue13g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f01b609ac9so10513761fa.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 00:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722412362; x=1723017162;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxcEL5fBlhm4jOeAsHs8xDqWAgTzea7TRTpZX+8zVvc=;
        b=GsvijA6SwTusNZ1nILXNy1+fAKbpJ50nWksOoU+pUdD54WRmucBH3UpBoleSrYjaal
         UFgYYzgubmoV1t5P4nNoBigt1Qt3B1dZc5GC7JoWIQq0ydiMS2G7NnJbEzog8Ps0QTyu
         aQSXjkZYgQRv0K5N2Vs+cxUFWoK3l4iB91DWORdNNN+YOIlNEFFYzPzxEnnVyTsLL2Zx
         qd8dQL2bt2x3BXeGBbJsXqjaq3ARzrAfXihVrQQvjRDJnc+B85bsrDbmWmpiqCrhpDXT
         gGtwWEgkInLcpu3GOVIxjrWMOASK81P/3aM1xoiGN/nGlaS4tfie+utiXD3evfD02IOb
         rbog==
X-Gm-Message-State: AOJu0Yzzd2onreeqXyeGJOg346yQuq5W3POw5kPFvn/A6zcGTEh3rjGW
	wSP1ED+/VJrcmA7X7/wQSgeQGvWY+VFrQd8BNCmlUpRi6gVi0PMTtQ6WPJfaFByhgg2oQjDL5Sc
	vLPAEKJeUJq3V86lJPIusdW1w0tjVoCV27HJqsL4laUpvPaJMD37Hx8oFikDIsVulp9SVEUuTsi
	qS4rePvC1ll2ukELnfKloCykx22Go8+JUmbsVlSw==
X-Received: by 2002:a05:6512:108f:b0:52f:cf27:69f3 with SMTP id 2adb3069b0e04-52fd526bd4dmr7417701e87.2.1722412361669;
        Wed, 31 Jul 2024 00:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzLAg0vPHQBqzxVUptDziKByQHBMO3v/6QhxdKwO3FH1/s7y3UNkNoDZht3ymk44+PjfEaVA==
X-Received: by 2002:a05:6512:108f:b0:52f:cf27:69f3 with SMTP id 2adb3069b0e04-52fd526bd4dmr7417684e87.2.1722412361137;
        Wed, 31 Jul 2024 00:52:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baccccfsm11493425e9.29.2024.07.31.00.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 00:52:40 -0700 (PDT)
Message-ID: <29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
Date: Wed, 31 Jul 2024 09:52:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] testing: net-drv: add basic shaper test
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 22:39, Paolo Abeni wrote:
> Leverage a basic/dummy netdevsim implementation to do functional
> coverage for NL interface.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

FTR, it looks like the CI build went wild around this patch, but the 
failures look unrelated to the actual changes here. i.e.:

https://netdev.bots.linux.dev/static/nipa/875223/13747883/build_clang/stderr

Per-file breakdown
--- /tmp/tmp.z9wI8zevoA	2024-07-30 18:26:37.281153512 -0700
+++ /tmp/tmp.pwD35f06q6	2024-07-30 18:26:37.285153598 -0700
@@ -0,0 +1,13 @@
+      4 ../drivers/block/drbd/drbd_bitmap.c
+      4 ../drivers/block/drbd/drbd_main.c
+      2 ../drivers/firmware/broadcom/bcm47xx_sprom.c
+      6 ../drivers/most/most_usb.c
+      1 ../drivers/net/ethernet/sfc/ptp.c
+      1 ../drivers/net/ethernet/sfc/siena/ptp.c
+      7 ../include/linux/fortify-string.h
+      2 ../include/linux/kern_levels.h
+      2 ../include/linux/printk.h
+      2 ../kernel/audit.c
+      1 ../lib/vsprintf.c
+      3 ../net/ipv4/tcp_lp.c
+      2 ../security/apparmor/lsm.c

Still we hit a similar issue on the previous iteration, so perhaps there 
is some correlation I don't see?!?


