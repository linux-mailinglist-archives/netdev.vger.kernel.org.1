Return-Path: <netdev+bounces-195013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B6FACD722
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 06:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0025717A176
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 04:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865782236FB;
	Wed,  4 Jun 2025 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNn720XV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017D22A813;
	Wed,  4 Jun 2025 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749010750; cv=none; b=Nc6ozbDwI9161UoloxwusIlEn4X7sKy1jQduVaNe9Z0JQ30ORlFfTM8A9rMQJ8Q+SqNykKMm6RHL1s3OLYr6YCEz+JzbLetr4RSFJCLyCxvipGcz6cXbCLE8kBKOLkLVh1SqX6G6b2PU4D0w3NMGYVUdkw4uZwAKE2OQsjH7QkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749010750; c=relaxed/simple;
	bh=U5jP+lXXoeXfOXG4BEs/tLNfMJ3AevB5d9zyUYUMwdc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q3LVmr6L2KuC9HzJeN3Lfnq4WI0uNVq0iwYrUkOJ//OxQ4XO/4Z4aXcLWp5Z3FJwcHyV1GotvaxOBPgjlS0xvJ5DaXv204CactSqfwbSGSqx82E7fVgeOd64Rlx1oKWqo2JrOo3wSwo3iEQpwqnERM0kZ3SUzvGg8X6oQ4JKlGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNn720XV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54acc0cd458so7826320e87.0;
        Tue, 03 Jun 2025 21:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749010746; x=1749615546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vwSmbFm9BQLJoSJOmaEVrFb2/yxxwEJVld2ae/xv9LY=;
        b=MNn720XVRMl3BfOp7aGgyoxoF3n1mMzCPQfJMgvN3xSL72d2h1rN0oh4aftSua6UKl
         XeBIe6i3sm531Ks/eAOy8UIU2LWujft8lrmO614CVYjsU8fkfE9O5v0YDjbrr4k8smCd
         mC/a6SnVG7yYUdCZaYfKb8VXDFHzz5c+BCcM6wucVOeBiDPrFrVzJVmuRDAdEabSze0D
         DLTjjIAILAbAPBya+xCCC/jTHEEXu4LlXmC8P3eFUuZxboht0fe41tH+lMWVvtxS+PoS
         MG+/8s72/lxhYito93cZXachO0TYA8OmLuheFlLPZ/dj1UhwsoASoqdVgeD83JyawT5x
         yMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749010746; x=1749615546;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwSmbFm9BQLJoSJOmaEVrFb2/yxxwEJVld2ae/xv9LY=;
        b=OR9D0ca9nEvnLWN2YftKc4jBXQRh1XPlmOaiEbbLU2vRXryPUDlfO+UieLl2RToEyn
         Lm/KRwNnzqkxyUzCMnsvcWhGoJ6PQfkOdgINP8Wo48CoFVwTkLSDQ0x2GMRkfA+7B/Zq
         tTeP7/0djCGEqHH05iIpbY5PK+tF0blGZj00LsH8/iEsxIW0WoXiqrn6wPkxRBiAdXIO
         nSWGpnz/EVoPoqaIXoelbqKsSxFZW/iH/jGDeO6UXCYWDGNSnFc9yLZXER4WyPAY1U3t
         WehfkHScZDFuudblqACNs7F7FdgJwyzAUrEsFsdvv8b+DJeDRU+U+3wpjIhpQ/JNOU1s
         861A==
X-Forwarded-Encrypted: i=1; AJvYcCWe0sjBuEb2PttsxDPqm8G/JwYZRin5F9rGDpRcqRGXREzkrPf8QZ1Z0fwP+MoFqzqpILBma6Ts@vger.kernel.org, AJvYcCXyt5HDQ9UwjmPIqQRmDPbuh6qr6RYq37sFieP+G1KS9h42YXkbLfxMgnh2rlt4S7vsgul4uJVjOKsaTG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO07eqz3cG3Z7C2k66XTRt06BU0e622tnDoqo8cvzCd0akVbGD
	hvkmkvG6apDYkRSrNQAeJ76y8LXAEA7+i8Iz7zPXSuPA9f5ZnqKcDEu4/JXgqGblprABeewipH6
	caP6LXfaKfrJpgefKDUFpawpi0OTfW+XUwZu7
X-Gm-Gg: ASbGncvX+UHoqq8rdwCt67+cFLtizHbR9mEFRdxVwRlinik7uAliA0a3BUapOVISq26
	qxkQnlB+7nTVZKwKUc8MVWUkOzV1MnEg+UPKbsJdv/8+6imThmMGxBD3H6N5VBaSjyRcvqpMdGL
	NO0SqxgQRCdEjbEbawlZ3IMvoUlflNxErcAno=
X-Google-Smtp-Source: AGHT+IEW8wj69/CJqKq7zWiNi1G1ylZSFxN4OeC7JGtrvBnHGNCTYka6lyBv1oGIAYFpr1QpyK+vReP+fnvUdDk6fpM=
X-Received: by 2002:a05:6512:3d22:b0:54f:c074:f91b with SMTP id
 2adb3069b0e04-55356aea9a9mr400195e87.24.1749010746464; Tue, 03 Jun 2025
 21:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 12:18:55 +0800
X-Gm-Features: AX0GCFtdOftKsu9kho5lrbGXwbclP_bIOHXNUOSPcUC05XiyVFuZViyCXsylFCQ
Message-ID: <CALm_T+0emUog-74YTfGnpY4AAgh=jFsYBmttc-uesXFRoyofhw@mail.gmail.com>
Subject: [Bug] task hung in rtnl_newlink in Linux kernel v6.12
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Kernel Maintainers,

I am writing to report a potential vulnerability identified in the
upstream Linux Kernel version v6.12, corresponding to the following
commit in the mainline repository:

Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

This issue was discovered during the testing of the Android 16 AOSP
kernel, which is based on Linux kernel version 6.12, specifically from
the AOSP kernel branch:

AOSP kernel branch: android16-6.12
Manifest path: kernel/common.git
Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12

Although this kernel branch is used in Android 16 development, its
base is aligned with the upstream Linux v6.12 release. I observed this
issue while conducting stability and fuzzing tests on the Android 16
platform and identified that the root cause lies in the upstream
codebase.


Bug Location: rtnl_newlink+0x64c/0x12f4 net/core/rtnetlink.c:3772

Bug Report: https://hastebin.com/share/omisagagir.bash

Entire Log: https://hastebin.com/share/cetuxoduko.perl


Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka

