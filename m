Return-Path: <netdev+bounces-69408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921884B0F9
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31291285FC4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60EE12D14D;
	Tue,  6 Feb 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpRcaBo3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB012BF2D
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211293; cv=none; b=MTzENpqgiUwdWEodQqX1Mt8d0vq33UhUDaeNRvAvt0rED9k+2Nk5wlDYnMfwEuFW6hBnYvPAOjk+EDd4MnaOITm41K98ILeydk0AvN3mwD0lPjibY4PoiNONNYHQ7uzUwfVihdGVBT2zI1fmxfGp6qzBrv8UFfvGRFmXOWjBJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211293; c=relaxed/simple;
	bh=h6NyNEL1z1sFlAy1MHdMLWgOdXW2w/cMoZZ7xTp5zjU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=h9TkyoynLfJayfmUCVEo7Sr2S/IiPSWztv4SKrxsfQSzDBOrSQIVGfZcWsqvgTt7mtNAbhOf7g2fkUrj0z2z0+fn5F1ItGsNYUZe9pqvTBpU8M4LUvOrfZ7FbUXf8kOxAslO46wrSbjNoW0ehllMehniKbS5mojOKfTP3dDJntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpRcaBo3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-511234430a4so9401189e87.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 01:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707211289; x=1707816089; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/pBl6xsOOoriuvKRwHFW0xSDEzNCYmlvk4kzh5AeUhs=;
        b=hpRcaBo3Eobc9RrJwG2GH0+bnGSBc8hWyt5uEz6eR4DZJgyXQd4vmuUZhB3oX8xX8D
         NRQOaVow4hghErwp+TyaKuvHJ4HZG0l/lYUhbSDKurVVnoI+X5M1+jmHprRJnftM9fQb
         Me7f1jOgKbCUW3h4h9OmnSUScW2pBXoV5YZ3tOMKKt1z1fxLpsGvE2vkw/G3VdhcA1tp
         U7cFiIvdkdAeuQTeY04mmFCTkikYVMxPeGb/sZ50ZK/YRpj6l/BjYn78HALC4dbYfYrZ
         nLTwnWoBytO9RpORqDmeFWVKb8/TdFHiaRfsnYNEGf8+LO+xQhJ6Hkq7rjnlDnGWgEHg
         Cm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707211289; x=1707816089;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pBl6xsOOoriuvKRwHFW0xSDEzNCYmlvk4kzh5AeUhs=;
        b=XO8ZawwB4RNuDhzL4kLTPujOp4o5Gpl7YEjlWcAILWjhMj4COfiQZyozZzql05vymf
         yDZVjTrMBy2C4S803KS9zGfSjcuQzZLkcDsSKjjZU0tsX93svQImz565lvvHTeGEz2gB
         IUpl+LWIuiSLP3+GcMGH7DLPMUuUkDhYW7fYXorumKh/Uw8gQhJSByLULZ8yMC7yMavM
         V/iSd8ygV7z6CL3kF42oBUTjduXWMojwauNbbBwFI1IzEAqeE3Tp/GF5VqTxjKcOu2Eu
         I35sg1wnQtv2rwnirTPoTwtYdNDk6HRediOJQSqzXHPrOdeLC8kXQOqVj15/xFseol1T
         4UNg==
X-Gm-Message-State: AOJu0YxaHet7mj0yYN9FYXplCR2PQNJa/OjuWSdGM6Ab6EfxDv4b5GI4
	9IRLRHt5m8BqnnhfggHWw/vxwXQlnsVDpuUPaVhoVjA6IN4T5J4/5139Lb2Eh56DC575iS1haXj
	hoZmuSfemtKEhsc01ARFVqxISdaGpR4vvd681ew==
X-Google-Smtp-Source: AGHT+IHrqoClYymELZDpvVlpwDdLrswxTATEDiAkUHiP6e7dsdrAUwL3yhdfFIrnCiCHT05c1BEcOXYGPI4PPg6SxtQ=
X-Received: by 2002:a05:6512:49d:b0:511:5411:1144 with SMTP id
 v29-20020a056512049d00b0051154111144mr1151097lfq.14.1707211289226; Tue, 06
 Feb 2024 01:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mahendra <mahendra.sp1812@gmail.com>
Date: Tue, 6 Feb 2024 14:50:26 +0530
Message-ID: <CAF6A8582QOWc1k7c9sgeX5ebwY79SDAmXzfbBumW6qGoyu6HRw@mail.gmail.com>
Subject: [Kernel 5.10.201] USGv6 conformance test issue
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
Please suggest on how to go about finding solution for this failure.
If I need to post this to other linux network users forums as well,
please let me know.

Thanks
Mahendra

