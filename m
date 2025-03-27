Return-Path: <netdev+bounces-177982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78DA73730
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 17:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9883A41A4
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1F1AA782;
	Thu, 27 Mar 2025 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSvA+87D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A985B19CC11
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093789; cv=none; b=DoX/Nl5s76n/Bf9hE6/WnD4J49dM50RMOE+W+Jb70yVJpm28T8VfjbQKqDRon+HvXEvi2fJoRHBW2M6kv4MLoYReGEJEx6XaHbmCfEFX14e3oMmKFC5z1ZcpUhia6Izdv7Zt1G6GFv8Rf5SvyhryUtZrBXHHgbvjft6+M+OMYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093789; c=relaxed/simple;
	bh=WtTjh0X+dvaIJq5h1EK6KMZ4PmYitWpCFd9YeBm00wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LtPuPEo/IornXmOo8dHKyiAMzS//WD8N8uBbkydheXzC8Ya9jHZ+Dg4WB+34SuGqYc6I6sv403m5cBdggGieAQOV5+NmKe1wKIX4eIFXjjU5QlH48o2ROk5fSkdaIwkpDj2ykd+9yRSdNdKpPK7wvNymYv77dMaVOFUcSs0kELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSvA+87D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2263428c8baso185ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743093786; x=1743698586; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtTjh0X+dvaIJq5h1EK6KMZ4PmYitWpCFd9YeBm00wg=;
        b=fSvA+87DRb2ZvUxYqNhc8f9oRgDy0/UFUiQelqHFw3cB1vPRLbjdLgTko8b9+IxGtG
         M9reLlABlLf3gtmwdaCNT3LHnie3svT6X9hF4+zIZQhvzb+NoPGWbl6CubWYL5xkeAYu
         VkdS68bksdwgVcmUxu5c1omZkEUuFLs6loC9uh4BIox8PNlPlelmn/z2JfmBzdb2LOx0
         +e777KkRlztgCG1GgbU+/3x4lP+Pr8NQ1R0bFUO1JTMe22B2anyHKnXXJtbvudC+BujM
         wXZgdo5Rek8+p43nyg2NF5ZO47iz4D0GKL7vdQifKsfTTQ+bqLJm5bKEUhwVuksIPIKH
         pLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743093786; x=1743698586;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtTjh0X+dvaIJq5h1EK6KMZ4PmYitWpCFd9YeBm00wg=;
        b=F5F9VCDrNQE3gzVrMTO9IRdTptdD7KBgZ/6zpevrdkW3LY73JMsq17W+Vb6vG2dimQ
         ADAGMTJ++AIUp0fD0NXSqJUVZ8qWfbZEGexNXFj5R/ojWZHel74LsdBHH1F9VWKEp9Tn
         XQQ4RGNfatoWAShLnRB+1aOiBTvhmeHk6ykFx8JLFhnFdHga/jU/0bJfyeMs/9NOuGz3
         3WiDOXhPs1mFSlrrPmSUZR5WhawYP9CRLj4be+Anc2AyV6BBLTc6FMLTGlgwN5N9+uLK
         2fJzO58s9+1v7XN/7vK8ReoysCfzvKQbCoLRq7nX9fUOX8HCHY9DYNSmsKHzRY2M1gcW
         Noaw==
X-Forwarded-Encrypted: i=1; AJvYcCV7Qe3gx0M1TIHw9YOhCrl4751FVF09y0YQPSqJ4GloQ0sOiXK6J7+lslEX6uPgd4dbdqPYGjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpr6vFam7Gt4QHEQ5jFtdHHhEXqfJtFNEmInWofvWsJcC+vRK
	MdwgpD62HBeX/JTnJ9YswbEkAjmKb4hC0QXfP5uT/x5rh91CwDoWt93yAsQCv7i94hfCIbdzrKp
	SQ/hZNIeehJFoB/UNjD+O/lKp3QCDAsEIo1eF
X-Gm-Gg: ASbGnctI3p1rR+7B+2PKmR/bz/xAbZ0q/7nd3ruRcMbUQuXiTgZF50tnWVen13P7Ksg
	iiC6nx4YQH7anwGFKqkKuHCeyc/o5k/v24xJKAtM+F2iNIAanFWjehmTK9RQNeGrj3ZzRTXILu1
	4FoWJRx4Flc7zBP1rwEtqN9XHE8cTKPBtId1syhW3hMaTMdVIWZEI85TfpTA==
X-Google-Smtp-Source: AGHT+IExXRH5LdkM/NTRM73rB/SS23JWUn+R4JP+vnvkuEsfYEaHBVxp2CFl9+/8VtcRNw0Qvm7sceZO8wiZe8ovZfw=
X-Received: by 2002:a17:903:3e28:b0:216:201e:1b63 with SMTP id
 d9443c01a7336-2291fa727f4mr80655ad.11.1743093785532; Thu, 27 Mar 2025
 09:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com> <20250321021521.849856-3-skhawaja@google.com>
 <Z92e2kCYXQ_RsrJh@LQ3V64L9R2>
In-Reply-To: <Z92e2kCYXQ_RsrJh@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 27 Mar 2025 09:42:54 -0700
X-Gm-Features: AQ5f1Jo2fQKABTN0IH8xAn7gJWxQrO470BWPkZjAfrB-qZ-rLmimDUmV1ht9Wfw
Message-ID: <CAAywjhRKL+iriK6X5D4UPHAZt4-rP7_rwYRAjjM30voVDaxmqg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] net: Create separate gro_flush helper function
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:16=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> On Fri, Mar 21, 2025 at 02:15:19AM +0000, Samiullah Khawaja wrote:
> > Move multiple copies of same code snippet doing `gro_flush` and
> > `gro_normal_list` into a separate helper function.
> >
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
> As mentioned in the previous review, I think this is missing a spot.
> the instance in napi_complete_done was not addressed as suggested
> previously.
Oops... I did that internally, but it seems I missed that spot during
rebase. Will send again.
>
> Is there any particular reason why that feedback was not addressed
> in this revision?

