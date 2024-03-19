Return-Path: <netdev+bounces-80668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825EE88046A
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 19:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6061C23147
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BDC2BAE7;
	Tue, 19 Mar 2024 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aRkqSSzE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C72B9D7
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871874; cv=none; b=pV3PES+bezj2uj9dOe44rACD1GBMct+1WgEZk49r1eUDOvggjH7a+yLq5y2g39d4aDY5KtktIDNlly6f6yJfQSyE+Z4/p8QJt4XGV3BiovK89xtIR7ryBjjGj4yn2xIBQhCuZP9grXdMoEL/fCn26YJ3vGkqJc309Az1QCayNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871874; c=relaxed/simple;
	bh=DFh9J+u2qXCj6UQ58/J1xPY8J+BLfhUgqiTlzbpfEoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVz4oj17IPIPrwrKUg7KzA5+zpZEWkZFOQtujjYsYwaG0+3ZcQFeSG9Yb7bzokLojctLf9DuYIWZJ2zr3m3opclLJguI+8AmYtCVw+p/dI6C3fUOGPMRpL9F5aO/TA9zBo5ZrLpylHaYaOJv9jjj6P3gOUYTKSDjKpmn8hmODek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aRkqSSzE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b93b45779so1455675a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710871870; x=1711476670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EQCbsWamaqb8otc0jtHP79rNp7jzLPKKgSbrJldR67k=;
        b=aRkqSSzEd/D8B3NSJRMytqok9IArEUFrIAKwE29WUZ2OWSsYB33wGbx0HrUGbtAESU
         UiMgdM0wb9p49daN2gAPp65/qtvM9cHw4WE09rBxEIBuVckh+EFMZvpPi+Dn9MXOlrpF
         y8CMjCCs1p4cdTMSLUL7S4VPw8r5XYqeNqMrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871870; x=1711476670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQCbsWamaqb8otc0jtHP79rNp7jzLPKKgSbrJldR67k=;
        b=QK/7ntIvJcHWnHV71NI5T74rUSY7XbD6fuIqGLacydTVE6QxmzMj067QZ1OQK2R7wU
         EhW4bcm1FXt6uzlsYG1rj7hBDWO85nu0iNPaZUB3OvpwCtFbLkUN6shu6il7PCgiEwIm
         LDEEmSigdeI+WNay6yIzVdXZUYMknaMYDDWWAgZzpIs60wA0kRONXYozfeYOrY/SY4+1
         1NlN68H12wGNMQQ/c7umIL1FDNeYg6SAy+iprnzQzSc96Jg+2L256ORJjDZpF9jvDnQE
         A+E2H42gp+T8dhW2PJOCO+ze/BHtZSbpBXtE2VIMlzcYeBQ/G1Cdoh0Cm/D+bMgpz3Gr
         RF/A==
X-Forwarded-Encrypted: i=1; AJvYcCXeLk/YonDATUdW8D5vHsAEMD4rOYqC3O28IhEEXL9kLpfU7vwST13ruoat1ZT95rBNc8GtT1rjuHVuREMZ8pll2uNHwb3T
X-Gm-Message-State: AOJu0YzfF0Elxd2VDzxJHAPMFiA1FgY+DrHLhW01XjKWpOThCePf2saM
	zjULx50EAAGzEljxgLUePnvYD+mqE9sKPth4UeNijn3cw/FxVWK4Eo66T2cSLdgcLzEoWPu5Kc2
	gCZ/0PA==
X-Google-Smtp-Source: AGHT+IGltAIFc57KcHVxiZ1BX93leLe9xfS8JOm+sPkJ2zBjBF6ffPM7FIgkjaaBL0utzTDbb01jbw==
X-Received: by 2002:a17:906:cb92:b0:a46:24fd:4a75 with SMTP id mf18-20020a170906cb9200b00a4624fd4a75mr10475567ejb.29.1710871870539;
        Tue, 19 Mar 2024 11:11:10 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id gf8-20020a170906e20800b00a46d9966ff8sm1266073ejb.147.2024.03.19.11.11.10
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:11:10 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46ba938de0so378847066b.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:11:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUC4ZNlYM7JMqANJ2Y615uMBO707+XOjL1xNQ63yn9EE2uZPqiMSLMmEqzoWV2/44H9nlr4uQG1plelxKpImMeDeTbS0eY
X-Received: by 2002:a17:906:1352:b0:a46:7ee2:f834 with SMTP id
 x18-20020a170906135200b00a467ee2f834mr9239613ejb.11.1710871440743; Tue, 19
 Mar 2024 11:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319034143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240319034143-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Mar 2024 11:03:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>
Message-ID: <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alex.williamson@redhat.com, andrew@daynix.com, david@redhat.com, 
	dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com, 
	gregkh@linuxfoundation.org, jasowang@redhat.com, jean-philippe@linaro.org, 
	jonah.palmer@oracle.com, leiyang@redhat.com, lingshan.zhu@intel.com, 
	maxime.coquelin@redhat.com, ricardo@marliere.net, shannon.nelson@amd.com, 
	stable@kernel.org, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	xuanzhuo@linux.alibaba.com, yishaih@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 00:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtio: features, fixes
>
> Per vq sizes in vdpa.
> Info query for block devices support in vdpa.
> DMA sync callbacks in vduse.
>
> Fixes, cleanups.

Grr. I thought the merge message was a bit too terse, but I let it slide.

But only after pushing it out do I notice that not only was the pull
request message overly terse, you had also rebased this all just
moments before sending the pull request and didn't even give a hit of
a reason for that.

So I missed that, and the merge is out now, but this was NOT OK.

Yes, rebasing happens. But last-minute rebasing needs to be explained,
not some kind of nasty surprise after-the-fact.

And that pull request explanation was really borderline even *without*
that issue.

                Linus

