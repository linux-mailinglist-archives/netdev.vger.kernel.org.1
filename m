Return-Path: <netdev+bounces-175950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36BEA680DA
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1689017EB22
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C14208989;
	Tue, 18 Mar 2025 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDoEKJ/H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782F2063E2;
	Tue, 18 Mar 2025 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341498; cv=none; b=RI1NgUp203YUVGAhcBaZpq4JoTDe+XFC+Z7DSPiejtQ5qGb9yIuVvKSXHhe89Ylw3k1OopPD401yup21JKbyQH+Ev8ULVOHkyU6ofZNsz9xWFqWJSMdia1aBay0kUYAZEw9aAtWZFBYm5Kb3WjXbDBvXmOiBgSV12GrZHXQCVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341498; c=relaxed/simple;
	bh=PPDImG+tenmpOKpR1XdgpEvmLmyLphwsMUh+utHUAlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8c3bB2deKf0fSPptOLFSnXu28ui823AfIIil/XNuPmiLUcmG6WDU16Ac9D7XOifN0EBSg0AN32nw6YcS3Z0YNBoV95Ez4LbmWPWlwtJBnc5CnkzR7dTDzP9Z90KzlHEC/ryzu1G825wh0tJTl2v5kzIInjPEuiv3HCI/2IiYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDoEKJ/H; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso33040785ab.1;
        Tue, 18 Mar 2025 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742341495; x=1742946295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPDImG+tenmpOKpR1XdgpEvmLmyLphwsMUh+utHUAlc=;
        b=mDoEKJ/HsMWi/Y5drfFGiF4jCK4vZQ5hMT/pU7urGl29ysWkPW3e4givJoKLRRe7FG
         gBAfAJxOaJCqpAE1QhI9qThBumS6V80GXAeqitSQZqMM8oqftqYYINtXnLJx3DlZ+YLc
         e76g+EDONgj/vuQhKXNLMPqqPd2ZVAeJRdLOEaaKaPzb9gKciDh9X+vHXYzKMCLFXyXH
         Qt4P5FhT3EfF87PnQZEti9KCwkIbYbvqjCsHfl8/uM+X5LiytLN11DV6u8f+9PJjtKqK
         iFjugAJi+GrR9w4xvY5dQlvq2UUnI+OuHegCYWdy5tTtKkIA9SAXZY4dKKtP/qxcFc/S
         CvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742341495; x=1742946295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPDImG+tenmpOKpR1XdgpEvmLmyLphwsMUh+utHUAlc=;
        b=VaavgZPtbzhbQSuRXTSCr7Cx5hDXIXmpSHVOgSbSJEPWGMUlsnl9mOBHlFkNbtRous
         kTJwU9v73+S1E/G9yeuN1OkqigqlCqu0RGLOgU0Tm7N4TfFRcMgvxe6dDcjZZfg/2eCC
         x2dcsUsvrMVw9ynVwRZlX4PnCcTXRa/7cCcTU7KQ7ipkznE7/kgj8ztJMXcQPvh0k5Xb
         2DrH8ngAjukunNKNgyfgnGm6XBLKMPV8GUerkJe4EbDxJBi5iBv2qLYsLK8AjWlnDYwa
         TxEEencLkCao3CzcPbTVbyyWI2UaHX7lv7+LlgsBeRq0wOL39Aox5LGsINOLe4s3m+A3
         sJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUcLMFcaQP61yY7ZPIsZ7dQMYJfG3XmKSpixAjOJUYtiI1Nq4ZCa4C+ioJqnbVKsrO0wwHQm0FdQM8HZMY=@vger.kernel.org, AJvYcCXEd6ls/1sjWjBhWvrKuT6F/oJyHTM+g8YTC49B1ah2qCHeUNmCBKRjxK/6AKFMXlGQ7vbh3nS/@vger.kernel.org
X-Gm-Message-State: AOJu0YyIx5QNC7p5u+0B2WeUK9lvvb+PfhUgb1+Ilo5N8cMUzY5ncRR7
	tFdY9oB7U4uc7VJPAjIM9Q6PcJIjT0kt1UkNfThgHoIJ1oIBwUWXJrIGjZRKIyir8xSH+dADt/D
	6JuSEBBz85KcOPxX147bo7F0Znz0=
X-Gm-Gg: ASbGncvKrB0XnrRG1LqGe74zjq4zhG4ejWhbfQtoCo5fS3XFEswQg/gREIWupwXpOV4
	8F7YzPwGJsCWr5kvHc59UM9Cwg8pvpl2bjlRQ82LutXidmtyEYdSSoCYFoP/EpJV+Hw74At0z8F
	igvMc947XR9gO5vchbQzwdIVRi
X-Google-Smtp-Source: AGHT+IEWFbm0QYEqa+DzDof8jvHVel5MDHzSw0XpPDJ5JJw/+dKfdRLo9tPahK3cBDqkTNX/yT7/wHd7i2O89/qnEt8=
X-Received: by 2002:a05:6e02:19ca:b0:3d1:79ec:bef2 with SMTP id
 e9e14a558f8ab-3d586b40a19mr5059135ab.6.1742341495441; Tue, 18 Mar 2025
 16:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314214155.16046-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250314214155.16046-1-aleksandr.mikhalitsyn@canonical.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Mar 2025 07:44:19 +0800
X-Gm-Features: AQ5f1Jq-68RXuNIzvyR61dZcmWzG8JRgXWglTI9KqGabgNXrIBc--nvZli8bc9Y
Message-ID: <CAL+tcoB0fO2hsAgwjmEVMY1FS+vv616TRtcJU7izcnT6Z8gjvg@mail.gmail.com>
Subject: Re: [PATCH net] tools headers: Sync uapi/asm-generic/socket.h with
 the kernel sources
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Anna Emese Nyiri <annaemesenyiri@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 5:42=E2=80=AFAM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
>
> Accidentally found while working on another patchset.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> Link: https://lore.kernel.org/netdev/20250314195257.34854-1-kuniyu@amazon=
.com/
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>

Now those two headers are synchronised. Thanks.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

