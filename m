Return-Path: <netdev+bounces-214719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F990B2B024
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB55F5653F0
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443D32D249D;
	Mon, 18 Aug 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGNArSgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFC32BF51
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541373; cv=none; b=fz0Ky6RlsfMKfdsRHX1ZVATb+K5GhHmZJ59tgwvXDGEYFzG5cMCFnhmnATXnkXcieQNXWU/2/Y90QFRvLWlUWfSBMa86A/vx3U+zLl008EnD4daQEgA4mkIUiRH6X+PbmH+VJ49olyjuuaAO7QV5S+jdmWcvqx44s7Wi+HlEu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541373; c=relaxed/simple;
	bh=DT4bocGlF2j9Ni322/TBmOHO3AL56WqHF7f/9O9uhPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1b97N8QF+hRn3KLRSq4bBx1WWnx8Bbydah/oOyC1S/j98ZFEiFeyVW3NBmVpeKK2TGBB82fuZFv59Ax1VhRKXKjGM2AblKSd5na8yBIYyr1TzkGxGZ927Wbbo+5gZD7gN89WBQWh9Iyb4IwQI8Fpm/pid1Zsuipo/3ryX37eYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGNArSgz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55cc715d0easo1293e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755541369; x=1756146169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT4bocGlF2j9Ni322/TBmOHO3AL56WqHF7f/9O9uhPY=;
        b=wGNArSgzawI63dj4Uld/U5lCcb1WVdko8j7tbt1K0xmoUz01hRIs0ldByjP7PdmkEu
         /2wsoCQ63u+NLC8gLEmLOSmYcH/qtt4MoQ2c4gb9IGTXwEYMiQdtWTaczuAl3uIMq4vV
         iYSSK7l7IvsFG0xT1BEZMPQLMPBYCU/yRWYtQdFdZegxcQjJLD9NgtLJ1NCv6WTW/dsT
         J1mWk2iisTUMiEmM+iVdpLXTJFIHzpPbSMpQAbc81UOJcj8jsxo3XfMlDS+t8ABC0VYR
         H1O4JE5iGI0tnKhATbGsDjQv3jqOsEGwV8DB6dSplNh+l6w6vl24M4lMcIdat4WkjGtq
         nEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541369; x=1756146169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DT4bocGlF2j9Ni322/TBmOHO3AL56WqHF7f/9O9uhPY=;
        b=vYfnyvfaedKZoS1W/ahyj2PLn8lHuUtHCQbsdFl9sHCk/Wmb9BMkQw3AwVNkoaOdpD
         vLJmF9MQ9rXMA2aLJHDLFZ0RUApM7ocmH7fzWqISor2KvidneRx1+XUeriygKrVomQaq
         6sbZjTmGljxwndLShhjtekoUlHvG/8vJJryznZ3V2Ii19qw0yvodTPzAdUr3RFRrEg1J
         66/YPEObV7/S/5KFkJg3gaWyD298opzGXSmTvIeKke1WHxngjnZhgc7TmGqAOTaHhial
         PZwFO6R60qBYEEhoR5Wgj4SR+H16/pxuh69FocwugaxhHtpLlF5nCELXiFhL1DRBNE7o
         pP/A==
X-Forwarded-Encrypted: i=1; AJvYcCU7+9DezBfJ2OMKJvDoIVtShA06Zrm+4itJnugQUl+3IOCTek533Qzk17IorWcaHAqg48CjRRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVGSF3f3J9l2cXGb+kZp4yejdLZiXUg9/um74BMJ0wnlYdvJ4
	10mHo3vz8EfDvCe3oFDdHxKx5c+JNl661Gcz53Ex/RcoT49zUsTfrWRRrQ7LyXzE6Kb3jb6ewoy
	zGmiamlk0QYS2tFiYjedWN4kAIgD1/EwYE8ljTxS/
X-Gm-Gg: ASbGncudaTF0MjurBPvgHCrNZ3ZLxSx6z1vBQSrwJ37r+xTWS5KD8a7sgmWBcBZhDCE
	DOL9MgboKRZ2DROsrQlAstyw51/1CQGkLB0zUGy6wwcnyBCw7rPyXlhhnLQkKUfZ9OCGxEXnNhB
	IRniehV9u2BkzEBleQ3/E0su/FW/r/3TiuWA8EKsOnRjuazG6dZwzJgeHYKfs2c/my/r3GYVlg6
	ClaS8m3NV+dJi1+FZLt8FAbx1i86VDDcc3RRA==
X-Google-Smtp-Source: AGHT+IE/ZypGD903Psnz6sgZwBXeLKnJ06+8qD7CmCx7MVRcdInxK4pxAypFIbDfggBhfCkhl5iLUbK0SD2EBRPwbow=
X-Received: by 2002:a05:6512:4406:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-55e001b1b0bmr15322e87.3.1755541369330; Mon, 18 Aug 2025
 11:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-7-dtatulea@nvidia.com>
In-Reply-To: <20250815110401.2254214-7-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 11:22:35 -0700
X-Gm-Features: Ac12FXzkAeLodaPcBrWTY9tocxP-EHC3O1a5Xv_mbMxpvvGeCp-LCxHvluNIGic
Message-ID: <CAHS8izPjyZHDigixCZkcTiNd2JLdgzTMBUZ9+kT_M+SO-uAS-g@mail.gmail.com>
Subject: Re: [RFC net-next v3 5/7] net: devmem: pull out dma_dev out of net_devmem_bind_dmabuf
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, tariqt@nvidia.com, parav@nvidia.com, 
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Fetch the DMA device before calling net_devmem_bind_dmabuf()
> and pass it on as a parameter.
>
> This is needed for an upcoming change which will read the
> DMA device per queue.
>
> This patch has no functional changes.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

