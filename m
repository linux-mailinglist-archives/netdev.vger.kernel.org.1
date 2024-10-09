Return-Path: <netdev+bounces-133899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B66FC997651
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 22:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B0DB22AA2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E31E1A34;
	Wed,  9 Oct 2024 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXMb2NAX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6961DFE2B
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505168; cv=none; b=O7oirSwbPDJrsioFguH/WgeUXajzrL2XVT0T44nM/iJOby7V6S9o3Dx4XOC6eOJgduExY2DcEyuymPzG27y5i0F7s4DAO7zQbK/icTrhghuil75+hLKq8htku5XAR8aGUt7dD2lMiMV+BoMhnZpwthW/lmvC8Q+hm4HPOVXSovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505168; c=relaxed/simple;
	bh=wbKfmr/ZzZ0zcPbDJCjLCYSu8fvlkLgHwSmKN6bz87A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzP+YF/VyW/v2fddLu5Gp4JbNQ30CTdV7C07czf7WkrIGY4ytx/KkE9VOieqsLse+EHlIl8UYMD20hb7BZ4x748NxEXjDVhVu0q0e1j/LvfH9j/pXL/4yb38PnnCuLfgPj5myRz184N4rEs0CDMvZ2bteD2rAs2iQ7Zn9hw1m5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXMb2NAX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4603d3e0547so74901cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728505165; x=1729109965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbKfmr/ZzZ0zcPbDJCjLCYSu8fvlkLgHwSmKN6bz87A=;
        b=NXMb2NAXxu3qh5WNBIJ3WcVr708oBR2NohNtTHAIxtgiN9iWKv11gh+yBDeweb6FC5
         cmfIJHJzzsyCWLeQi6jxfuXmsQjzc00DLCUol6KbO03AknDhCg0kj2JbgrsS3f61da05
         06YodkHQ7YVxzY06rkbk7wsgt9YD3MlWQA8s1+RW2Qzi+J8jKNQWUIEGfiFEt2Qgc79i
         aazUT8+z04NmC+/DapAVP9THlFw/KzTmj23K+savhbl4phTZ07VmJG27qRiPRfcvGUc5
         ShopkVrIINmaIW/SWyk2j3QhjFsTmebcswpSyWp/WbEWMwfhlWyAZxeJyt56oTgaMBgC
         233A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505165; x=1729109965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbKfmr/ZzZ0zcPbDJCjLCYSu8fvlkLgHwSmKN6bz87A=;
        b=I7e73u6fWCm4F7BHUXxgIsbiCNxyHqQ7soMQ0TNA62i6lNjYBZS8//hVel9jtW3DYi
         jihO3+Uz0hqCEo4pldEBvaY7INp4v3brcdobmUkX96A6luxzdDulJiH26o/hjKYgOzer
         PUvLxkVjX3kCs/Vjtmdf9TK6ER3ne0hKUIPuR0wwhwSvp2VFVzJzHaJvgIjviuYTyift
         pBuiLrysTCbtlhAQR5/o1f4JrJLNM2DDnJIYdmrR8Dl1j3qkK4kNEZwVUhwn4M5HyPI/
         hoTtJcTuHjaNM8ivb2ZqgKNXmbUtJm1FyaNnE0Q7vA13CmbV2oEi0jiCl+W0qfmnOCEU
         7mMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZvuCfd34jNfAh4rQ8yE4wFd86MeDUUxxF2sMpGSYF2zR6ZddFf4SAnxyY/heKW+CBxVEx4V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgIXjGLTJoePX5zbYN8amRUjQcNR7dvDUMrWmWHzcT3mODRnGX
	8tOeNpAiCgR4feHD7vGTCOWg0KnCSDoIAPrD4Ay/pvMwpecyrtEhKPL+vWHY8IohUHpw0mXlDfi
	6ATUdXP1cm+hKyImQ/aVd4613yYzdQ58f1m6f
X-Google-Smtp-Source: AGHT+IF4+iYkIm7we6CcSbNvjBz3PbvQiC2C9feaZjjA3RZNL/HktZRO9B3jO/+II9dpRAqKJdwz4QJZg7JLrDqqu2c=
X-Received: by 2002:ac8:6507:0:b0:45e:fe4a:1f95 with SMTP id
 d75a77b69052e-4604035c3dcmr876651cf.14.1728505164758; Wed, 09 Oct 2024
 13:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007221603.1703699-1-dw@davidwei.uk> <20241007221603.1703699-3-dw@davidwei.uk>
In-Reply-To: <20241007221603.1703699-3-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 9 Oct 2024 13:19:11 -0700
Message-ID: <CAHS8izPDC-puGLNWmP=iQ+skLPTuP9Ydu_T_h58Vd5x9kmhrww@mail.gmail.com>
Subject: Re: [PATCH v1 02/15] net: prefix devmem specific helpers
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:16=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> Add prefixes to all helpers that are specific to devmem TCP, i.e.
> net_iov_binding[_id].
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---

The rename looks fine to me, but actually, like Stan, I imagine you
reuse the net_devmem_dmabuf_binding (renamed to something more
generic) and only replace the dma-buf specific pieces in it. Lets
discuss that in the patch that actually does that change.

--=20
Thanks,
Mina

