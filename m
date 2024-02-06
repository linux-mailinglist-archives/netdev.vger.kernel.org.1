Return-Path: <netdev+bounces-69389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47484B00D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E2F1F23B53
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 08:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB412BEB1;
	Tue,  6 Feb 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0dTc/hP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082012BEB7
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208644; cv=none; b=t+Hf8sCmTqifJnvYHMK8CtKbC+17ms2csiSRlRAysTT0obUa8qpfn3mn+1Sxv0WacsQh0e14IHAzRmXvHMrX0zKUmKTo2YaR3C4VShakaGVQzyVMDOQ+F1xxOKsc9/jLt1hB4I8C9H0UFXBpKW7OC4stHj1QT6fUhz9c9qhND7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208644; c=relaxed/simple;
	bh=0rF7f8gjhLgfAUkuXdLvFMZrivEGOSznqxGcKYoxLH8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KTxdaWIcsqk6kVzJagxcmjiAH7gkKBcR9u0jmIDgErMxAnL2xlvPnjr5WhxLsWnrypq3knukF02OMA6RkOkOEL6ePVjMV4f/fmYaUu59YxJFxca7twKXa+HfCe5a06+Y7CAtUW7izugaeh062GhBt728TV0T+aB6maO7YEi19hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0dTc/hP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5112d5ab492so7365041e87.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 00:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707208640; x=1707813440; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PbnMyhJUjgqKcPA7Xhcx2j4wYH5txEjKOpXG57I3eF0=;
        b=e0dTc/hPBS7pQIwrekL872yfIekYR9S7ZlksshlHLxoEXwPj0L1iCs2dN4ejCJ25cG
         6RHRj9TmtUAF4rZ/5BdQLQOjISNGJeUTt7iFWYMipG7/mZO7tlRI34IZmwZ1sZOTqJch
         PLIUmE+NNBK6T2+TTHxs312k3PhGDvX0acA42dLP7DALeiKu4ghryKJgJtF5oU63jxJI
         XiS+4VX0HkGCsPOx+0QslXmwGL2JZi5Xg2NwfLEd4tCpS8s5iem0EHvU9IxAZ2X7C1uA
         d1PVxJSBZrNPlcDQDsYICQqbrSeEiHAIxbFNQAWd3GFwvvvCHeDFtLZKdWrvcFiGkG6d
         mgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707208640; x=1707813440;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbnMyhJUjgqKcPA7Xhcx2j4wYH5txEjKOpXG57I3eF0=;
        b=Bai5+t7BxB4ELF/P1w7c937iN8Djq+3Lr5V+eG9b0ryxjbmo6GQ5LqN0mAPKyynF8x
         Yut0bdBalXCu9EY5AKu+EI5rQFB9wCXJQc2a84mRkoHiMgvc8ocF/wU+ysvlde3hKvhE
         0D11dGSaHsIOV42Iky03YPFRfkVluhOsfFN5QaDYvRIky49JH0/6mumK9qWewtbHExNx
         s29TVPpPKwp9qfruHGkrHPsskEjttkVrxHCGiHQC5HTKW1sutO2lbKLDhbknbrzEdT3F
         WajG/u9V4I3KlFwAvWjVw/OkhInGPAs5wQZiBbaX04zonlHS09uZwJXq15Wv/YaDw149
         oxiA==
X-Gm-Message-State: AOJu0Yzq44G8EbqUdRP8rvVVkQ3FdpjRFKdtKdQYl4aUF9wUcBAu1uQ/
	5hgWIEDIRCYa1Z2XXSTe6shT53H3iUL/TGnnubLRkAzjGYu8jzTPnp/QIeNV3ofglluOnvqH3Fh
	c7r/iZ9FCOP0qStxE+H8RjUvydsJM/yUm+a/O5Q==
X-Google-Smtp-Source: AGHT+IGjm5fKNXHtnH81XX3U6ny6yXCnWJ8qkNW5IrLkRFv3Ae6Di/N7fBzBaVOt4O693B2RhMMhabC8S31h81kWtcM=
X-Received: by 2002:a2e:a23c:0:b0:2d0:aa30:4d8d with SMTP id
 i28-20020a2ea23c000000b002d0aa304d8dmr1395665ljm.44.1707208639909; Tue, 06
 Feb 2024 00:37:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mahendra <mahendra.sp1812@gmail.com>
Date: Tue, 6 Feb 2024 14:06:17 +0530
Message-ID: <CAF6A85__pPB_K1iuzVSrKXd+AWXkO4NDYBWbeDfGJEphvvuzzQ@mail.gmail.com>
Subject: USGV6 test v6LC.2.2.23: Processing Router Advertisement failure on
 version 5.10
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

We are executing IPv6 Ready Core Protocols Test Specification for
Linux kernel 5.10.201 for USGv6 certification.

Under Test v6LC.2.2.23: Processing Router Advertisement with Route
Information Option (Host Only) , there are multiple tests from A to J
category. We are facing issue with test category F which is described
as below.

Part F: PRF change in Route Information Option.
 Here is what is happening:

Router Advertisement sent from router A with PRF low.
Router Advertisement sent from router B with PRF medium.
Echo Request.
Echo Reply expected to be directed to router B. However, reply is sent
to router A
Router Advertisement sent from router A with PRF high.
Echo Request.
Echo Reply expected to be directed to router A. However,  reply is
sent to router B


We tried introducing delay in the test case between each request to
allow processing to complete. This did not help.

Has anyone observed this behavior? is there a patch for this issue ?
Please suggest how to go about finding solution for this failure.
If I need to post this to other linux network users forums as well,
please let me know.

Thanks
Mahendra

