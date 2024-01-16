Return-Path: <netdev+bounces-63734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C235C82F17F
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534032811EB
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480FE1C28A;
	Tue, 16 Jan 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4gQm4Wg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41381C281;
	Tue, 16 Jan 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so7197581a12.1;
        Tue, 16 Jan 2024 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705418961; x=1706023761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8IPdmfr0Sg/ejrT+ejxI5BlZajlxb0SYpoPn+/Vm08=;
        b=L4gQm4Wgh0YFryyr0dr7hPhuYOFH67vHXUCKFlhGoHSYYoCF1BucL9gjD+aDR/D5uE
         v4MuxYmq1VrI8cCrY4uKTsa1ivFjkQOs9OKqQbDRJi1vrhue70eBEgDqLomT39RxPcNB
         oszKfomhdbaUWbsgMYhGHc1bVo2F7gaejZwXswMnUu+rOKyMHXkjEx+EPl1IAB11oDoa
         R4Iykx/caTJBOTEX0kdOCkY0kSQUMXNq4xkz3EKd1iJz0NBCIQLpCiJObuo4Pw91CzOW
         e56x6YS3bz8SNr+CTO03HH4QChs85jLnqw5eYNPJUYyrotWY4RvNjuiLYZjn5O50JOFb
         kGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418961; x=1706023761;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/8IPdmfr0Sg/ejrT+ejxI5BlZajlxb0SYpoPn+/Vm08=;
        b=qlldQCP7aU0jZBY+Ao/hrOCnzw1+ZEI8P/sVW5z6UhfwAIxNLsiACD4UMn+y3wPF4/
         NfcIZamXrGM0yYnPqfl7rjlNjIwJSMbuv7wzaXhXRWBEpgaPuoPwW4+9C2eJiBkjH9A4
         HGq9CRQRudpTsY5irkkDJ88VoPgmPdtHo/93PlZmK89wq6q/6SbMlf/pfWMVtGbPNbr0
         3jAsGCsmnlQius3v7UJavpvOQJPNvgVbCOE3BVSsXfHh3T8jsiyv9GqRs5JJ15z8JVYF
         iOv67MTwngvwCyQAD7qX+eaCcjiYP+YtMh9grJJGUrN77TTOTKebWotN29tGm6e8SLnK
         /gUQ==
X-Gm-Message-State: AOJu0YyGm+YDkIqUAMHCS68pbvbzUp0kDvG2AeSpJ1NcGyAH9b52VSsW
	ezOoyGOtTBRn2TGszEIqg5c=
X-Google-Smtp-Source: AGHT+IEDktScQbeaTG7Wzegvpae+QehMx7fmXiaTu6SLDY9fJlvVSlt6QSip6DO0/gWQUeLQp4WIfw==
X-Received: by 2002:a17:90a:f691:b0:28d:b7d6:1117 with SMTP id cl17-20020a17090af69100b0028db7d61117mr9729136pjb.3.1705418961212;
        Tue, 16 Jan 2024 07:29:21 -0800 (PST)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id su5-20020a17090b534500b0028cf59fea33sm11925011pjb.42.2024.01.16.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:29:20 -0800 (PST)
Date: Tue, 16 Jan 2024 07:29:19 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
 netdev-driver-reviewers@vger.kernel.org
Message-ID: <65a6a0cf8a810_41466208c2@john.notmuch>
In-Reply-To: <Zaaek6U6DnVUk5OM@C02YVCJELVCG>
References: <20240115175440.09839b84@kernel.org>
 <Zaaek6U6DnVUk5OM@C02YVCJELVCG>
Subject: Re: [ANN] netdev call - Jan 16th
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andy Gospodarek wrote:
> On Mon, Jan 15, 2024 at 05:54:40PM -0800, Jakub Kicinski wrote:
> > Hi,
> > 
> > The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> > is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
> > 
> > There's a minor CI update. Please suggest other topics.
> > 
> 
> I would like to discuss a process question for posting a fix to a stable kernel
> that isn't needed in the latest upstream as it was fixed another way.
> 
> This is related to this thread:
> 
> https://lore.kernel.org/linux-patches/ZZQqGtYqN3X9EuWo@C02YVCJELVCG.dhcp.broadcom.net/
> 
> Thanks.
> 

If you send it to stable with a tag like,

  CC: <stable@vger.kernel.org> # 5.15.x

or whatever kernel you need this has worked from me. This has worked for
me if I understood the above question correctly. The relevant docs are in
Documentation/process/stable-kernel-rules.rst. The following bit seems to
explain it.

 * For patches that may have kernel version prerequisites specify them using
   the following format in the sign-off area:

   .. code-block:: none

     Cc: <stable@vger.kernel.org> # 3.3.x

   The tag has the meaning of:

   .. code-block:: none

     git cherry-pick <this commit>

   For each "-stable" tree starting with the specified version.

   Note, such tagging is unnecessary if the stable team can derive the
   appropriate versions from Fixes: tags.

 * To delay pick up of patches, use the following format:

   .. code-block:: none

     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline

 * For any other requests, just add a note to the stable tag. This for example
   can be used to point out known problems:

   .. code-block:: none

     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.3

