Return-Path: <netdev+bounces-241716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC4C87953
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EF964E0116
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6263D18E02A;
	Wed, 26 Nov 2025 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0otr4jv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9E45C0B
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116661; cv=none; b=lHZfzw2oaVF870ppTLChQvcQCEOfItECI8co6Z+9JjwKtmrPNGTOyjJaZphP8gcElYU5nQD0jfztZeioJ7rW+7DQ9eZ1w6vlcdQj7rkuURC52X84CRQe3NHv3ZA9p6sCY46mUxcOQB8F2PdB54ZwRkVF80OUkD4SLKD7tEc4nYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116661; c=relaxed/simple;
	bh=bcfV/h3aH3+Ozbq5WoP2IHNx7zN+IKQLGmHkiAHzNb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdfeioqJ+OMLiFeGgC4+vUTdUmtoOQPhHx9VckbgHbxqbNyjuo8xHq1RZpQ+cRq/kRjPqTMtkkrBELrcO+kEk2wzIyvP5JpYOXCR8ZfkmHN3ZWacuMesaf6kK5WyntQcvLcLNyHJ4GEogNmaP+TFS3hWBLgr21hLFprHlIKYgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0otr4jv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso4928835b3a.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764116659; x=1764721459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcfV/h3aH3+Ozbq5WoP2IHNx7zN+IKQLGmHkiAHzNb8=;
        b=F0otr4jvtyU1Ai9qv8P4Gn/CFdXp5q+mv01B7G5s0TKQr7PLJDa9U5cbh6h9bRiC58
         l5/Vlnadof0lX9y2nmd9kjlTXibeitIoS/qLaAAxbguYIOMDcsAN3rQYHU1p2+5ZXQSK
         ABsBVI9Lel1eN+L0sZ3DZOFIvU43e5ydS9YzmpLZg8Q3/km3MqDqNDE5n20r+DCbU0Zi
         UDPtzs0J8Uljp5vt5/trmKmlisbJBwSo+LBlynwFWY3lv5WLlsk3KNztBcmObs64IOE7
         pUybbp7oA1PzGhiCxOLeBy6/Y5lzyx7v1K+XeY38WXLzGBUVRWcUAufM28IEqpd61G0d
         foAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764116659; x=1764721459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bcfV/h3aH3+Ozbq5WoP2IHNx7zN+IKQLGmHkiAHzNb8=;
        b=BAPrNoiibtkrHRKGw5FFI8KeFwbdWK+SOsybZcT41Axg1YS5hyMXuSZOUwPRXK99PQ
         igWTG1xiKAYiZFSYFab7sp1JwiCDWNuy08sk2Y07+Cn99ZJiCtbCXCL/tQfPuj+xvQPd
         n2iZV7poQyUee3Oz21P4hfikbx9h3yfigq6y8MOeZ/G3lQVan4EpvEyFzM93DoKpKYVA
         xYDED3vtUNsVZb19LhVCytnutRRmW8FoOe+wIIRn3tbWvRpVXy9rZfiibAlY7xTfJC8U
         hmK29xc/cIibAftih4Fniim9ckGzvqxHCCGsdiuXdhOV0jgQat53paBFTLczv5iOM8+t
         2zRA==
X-Forwarded-Encrypted: i=1; AJvYcCVTnx87/kJBk4oelUPnVqNG3orozUWc3Y5j5aWFkrgD2C+WBiZdgC4k88mNKvZRqXvUDNxSwAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoz6qpyn/5zRwUYiWrR4rf7oQI7ZyEFSF85ZoOvsXDo44xYr5S
	O6RW4lS3hGEC9OMnwpjAql6mkb88XpylP5azpiQGK3q9caVm/H0Vd++GbRGR9gSqn5pLwqRUwKw
	D7GVsELjBc05sVJj4MvGRXAEtjgelLRqiFYFx37S8jJSq4CYPwQMgI9sO
X-Gm-Gg: ASbGncuxVhD7l4OFJfl4a8IJ9skVx+3AgHYNPlwhVl1ff6vKX0kh25mOr83iO2/VXZ+
	cINymZAJK/ubqvdiudZyiiHRsBszVRH2u2B3zHUWCV4w9vftPrOvynMRFxZur1EQFhl8/Ml1AN+
	on2nMnRtWAXeQVkpF+fULOrMeq1DPN51IjZStY+6oez/W9LO1XPFo1mET9AcNpCr6SwRsF7te3H
	UIKKDl3Pn27sqL8CFm+6bxH42Jx4Rjp/oNjrtqNh19Iyx9dDt5fQSQ5msCr1+fgIY0dgKXNqo7d
	I5UCvLT4lc0kX5KTva7AtIqUvZz+hbMY6Uf5MEfC+6QCgX/OtEeXEWXskg==
X-Google-Smtp-Source: AGHT+IEDlAEHYuVsPWLsYFGEOywEpmYgazzOZ5ID6ttyxEIwU471kyHEToWhLXKitrImILfpwMqCYETMRyOK4VTWFRY=
X-Received: by 2002:a05:7022:2389:b0:119:e55a:9c08 with SMTP id
 a92af1059eb24-11cbba6ef0amr3879981c88.36.1764116658851; Tue, 25 Nov 2025
 16:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125211806.2673912-1-krisman@suse.de> <20251125211806.2673912-3-krisman@suse.de>
In-Reply-To: <20251125211806.2673912-3-krisman@suse.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 25 Nov 2025 16:24:07 -0800
X-Gm-Features: AWmQ_bn4XUfWJ5BaH-_XGl1z8zK8dtykaSXnqp56s7Js1e5rh1hf1C93Z6Uti2w
Message-ID: <CAAVpQUBj5q=nq9GaqzEnkygEuSJKX+sm4GMBuTKQUXi_33gifg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] socket: Split out a getsockname helper for io_uring
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org, io-uring@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 1:18=E2=80=AFPM Gabriel Krisman Bertazi <krisman@su=
se.de> wrote:
>
> Similar to getsockopt, split out a helper to check security and issue
> the operation from the main handler that can be used by io_uring.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

