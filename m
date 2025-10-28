Return-Path: <netdev+bounces-233345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5945DC122C6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AB854E9CFE
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE0A1BBBE5;
	Tue, 28 Oct 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0KJYVbFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40501A3179
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611649; cv=none; b=dPQITrh6BXNiDqDA4WIv7HjmRtILnG76V9ce9CGo5rvtB7VnW4jn0PipRDmdXb8mUxJZaTJWapA3LT1XrZOBg7THQ66nQ40NXf6n/cGwwWzwXYQocivgpxT1DC3wU3M5Xj0gerkI3NPqWwaQHGGVaIK6qpzAY0g/QVVZOW+35as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611649; c=relaxed/simple;
	bh=np9MHnvkGUDtn32mHRigCmaOIGhYbItN3DN6jEpgT4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVEzmoIsEMDlazdv0cVFcOWUfmPJNJx/exvOR6fISragLlwCvYEpBBOQE7zN/z764nCAELqz88NJre/JfV0fVbKl2mU49V5+crgquf7uGVVjft6Sx/4Soyz1vFwuTPQ0tYT+2vLwg6lHdLaNTOaq5PS1UN1dCWdj03Wl8GcyDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0KJYVbFc; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ecfd66059eso158231cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761611646; x=1762216446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np9MHnvkGUDtn32mHRigCmaOIGhYbItN3DN6jEpgT4g=;
        b=0KJYVbFcTrpGpo8qv399sSGsoBh0XICxBm8H0NXzCe4jFVymDIj+26neKMMjn9Bw9C
         Xn8aMwprzdqCNgWzetXXQLq96D9k8ezsFH5L8v3AEzcar2BQ9ehqTlUIXqNYM+xSJW3e
         l4kkqRioC0/LwSSD/LFh/4W3mBBdUeQ3R0ID42GqeWVJj/litLxsg3SJEHJ46EqjkNAB
         H6FJJXbmA1p0+GdFC1pFC4DJ3yIQ91lno1CjP7Dj+0+0RtmGuvrZv1RJuSXR3vSQ98cX
         aHDZRGNlppk1K4cfiuGCVS98uJ+GgG1F1FASLeWL7F3zK8aQ0hQz73tEJLQLZsFKYTv0
         C0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611646; x=1762216446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np9MHnvkGUDtn32mHRigCmaOIGhYbItN3DN6jEpgT4g=;
        b=c/KgRwoEDs3KKdNnXeN1cw6WxohJMBOUsjvvV2IlLMbe4c1B2Gd3i91SeWpNs5G+VO
         RG8ZRBL7DlpmGTh8DAlJRwOHL4u0ou2PBR4/6GDkxqc4aE6WmuFJ0VQ5d9D2CAwumRK/
         p1RtI8r6D8rXYnFBzLdKGUEXJLlPCqswoaSjlW/KfnBESeeaJ8YndKgCU9XvA/3UMYUW
         /5DLUwjYJtQDgrlE1BPMps7RGCAZqWDRaGRGY+I6ak86VGgupnd+2ImU2zqRla4DrLUy
         cCkQWVXdq7PChUzeZPeSxqDuqpnIkcqbiTEmiQYDYIeqV8k/lsXoNsnTQonwB1xBhR7V
         J06Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhh7MQgemdyW5yqe7a9Fyt1c0u3qzpydn43uifoB+U0lAnTDIsqYS118r+e0TeiqF3Ur6j06E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9q/73yNjhl4PGdB/q9oYRmCe6atH8yr6SJDIEXfzhzDbDVIL
	gC1ss3kYBRK9IPo/lTmrowKli4zAHw0iViG/SJL/ZqPL6BQAbyXGo6tZtuc8402q0/IjdZESsnj
	dal8n5At8T9M2fzrGsybiJTWFvNl0H5ZAzAmA38b2
X-Gm-Gg: ASbGncte9D2nu2GCJiQPiVjA3kGQGnh+cMJZ0NKIP2ld0UoABBW+lpSPFM1AOkk4LQ0
	Abiuj+AXEJnPquEHiaLg5X3Ci89erQkkQxf6LYPR+mZ+0SgNqi+TFe6mownelA79Radx4rRlkPp
	NSvyieqK/ZlAkb4odPl7t1mUaAi2azxqCXs6rOCywho6zsKg7heSrpR2PyU4raqK606N5ps4+iF
	OkJt9BXAl469d5cETLjLpBazb9ID5i4gvxvXbFlPRAVipfKSN1ssIxRehD7
X-Google-Smtp-Source: AGHT+IGtobyKZr3Buf1Y+gJy9ka3rDheXwEbcoUOoOvotxlR0nNAoWhJDpymKwu6u/e0XgHLkC94HPaBwWYZ4rty/j0=
X-Received: by 2002:a05:622a:4ccd:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4ed08e325a7mr3265881cf.2.1761611645431; Mon, 27 Oct 2025
 17:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-1-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-1-47cb85f5259e@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 17:33:45 -0700
X-Gm-Features: AWmQ_bkh5rEwLV4cV0XCq-XK-tFW86EJg2CGfpJXDPMaZ1YEH67NgQRLYqXDCEI
Message-ID: <CAHS8izNSO-4efu8x6OqxHdyuyqQgS_t6EDh3JjjC1k4R_Gtm2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/4] net: devmem: rename tx_vec to vec in
 dmabuf binding
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:00=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Rename the 'tx_vec' field in struct net_devmem_dmabuf_binding to 'vec'.
> This field holds pointers to net_iov structures. The rename prepares for
> reusing 'vec' for both TX and RX directions.
>
> No functional change intended.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Looks like a straightforward name change,

Reviewed-by: Mina Almasry <almasrymina@google.com>

