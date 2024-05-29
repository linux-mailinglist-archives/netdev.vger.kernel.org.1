Return-Path: <netdev+bounces-99065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B298D3910
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F0D1C225AF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7E1581E6;
	Wed, 29 May 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzEFmOaG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FB157E9E
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992680; cv=none; b=Jzpsn/muYepR+rp3Cu4PB46Qsc8d1umZw9NILxYFSlSemTI0iieX+jgrqeLbsbhPFbjUKJcS+t7wMsThbZiZxL1/LZTa/GIm9BxczTommcMBmF1+HlccxMiCHiebyUslFrWGjF0w0mDBknbN+XQVE3PjRc5aiovAQULX2JLnEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992680; c=relaxed/simple;
	bh=JAxbuHoQBZ49w41Mn9Exw5TKZvwkktDZUEKmSaoKOFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lr/eq6iRnEXIs/Wz9tn5Ay9YNvkO8K7EFO3wt9EdrFIqi2nS7r41N2u2A1cQoPuH+rihoK8xT7+lRjy1DHSTUmQ1VFw5gMQ1y2Q7Bekk/JbAAhL/nDDAiLuS4mXutuUR2X2KXOki2xftQ/TO0p5lZbILiL+ibjBsv0NTFhX322k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzEFmOaG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaOh1l0Lu41LPYOrXz2nXavJQHgEuj8sHreCoqbxNhY=;
	b=FzEFmOaGCXkqxhm7fCBba5UnkYALl43qLXF+V8HJ2UrDth5YQTYjXuQolAMSVYHjjTTHaT
	w3yvTxaAVCZ0LoaeH5SrWYNou439nfpg+/O8y+GsWa1CmeFvXmyMx/mYD6nNL+ZxhMTGpe
	tTr7q1bivPAkSYBEaoU4aUHX4P1a7PI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-ec3pu3XiN-KEIQq79vxKnQ-1; Wed, 29 May 2024 10:24:36 -0400
X-MC-Unique: ec3pu3XiN-KEIQq79vxKnQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5a812308daso108176466b.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992675; x=1717597475;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaOh1l0Lu41LPYOrXz2nXavJQHgEuj8sHreCoqbxNhY=;
        b=bTb67VrN2iKDtFrEfiwFd7gl0DovaZe3jiQ2oqkJ3V8fI0mPo/nckRvsBJ8JnkcObA
         usMegA4eOaXKaSQxOrVycq02JXR+0XpDW0xyRzSLRRQSKUZUMqzUkRAZDVsnk0EggjmW
         W1F7eG5M/IqQRjQge0NFapxemEpqJPBKCvGbDj3t3mS3RQszVfD0WfGE2+VGDm6Bih+d
         FUliwsG01QWuU8uS5g3p32lT4xThMJ2GoO77YyIWcd6EiC+eu4mCirj2VLdRXjMU9Kox
         6gh6op0lkLr9RD1CI15E3l1HoV6qlSIC8jT4RsoFHMIeWKLxfa9F/sJORt0Q1700qANQ
         uDMw==
X-Gm-Message-State: AOJu0YzZCI4/vElk3ImB7PYR5Z9TO9Wy0uBLzJ0bCHkl/IoLndMdzjXo
	KSBXA5Cg8lLoUG1xVL/C+YVs3m0UiIBGo4qWHUvJ/gQ9SahNEBsV/QUznCuELpXK2XG01HD19Jf
	ZRLTc4JQwVDEv0xXMZhlLiEmbN4zoA9+UEJPfL81bvhnOSj/1CF6vsA==
X-Received: by 2002:a17:906:413:b0:a63:4e95:5639 with SMTP id a640c23a62f3a-a634e95579dmr280208966b.47.1716992675169;
        Wed, 29 May 2024 07:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoMcMMypUJzk39vMbEP225084t98GDv20PFArbG9E2Gd05mxwJZaA+E/zvafN6DVb5r8Z9aA==
X-Received: by 2002:a17:906:413:b0:a63:4e95:5639 with SMTP id a640c23a62f3a-a634e95579dmr280206566b.47.1716992674677;
        Wed, 29 May 2024 07:24:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c8176e1sm715455666b.8.2024.05.29.07.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:24:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EFBDF12F7EDE; Wed, 29 May 2024 16:24:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH] bpf, devmap: Remove unnecessary if check in for loop
In-Reply-To: <20240529101900.103913-2-thorsten.blum@toblux.com>
References: <20240529101900.103913-2-thorsten.blum@toblux.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 29 May 2024 16:24:33 +0200
Message-ID: <874jaghf1a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thorsten Blum <thorsten.blum@toblux.com> writes:

> The iterator variable dst cannot be NULL and the if check can be
> removed.
>
> Remove it and fix the following Coccinelle/coccicheck warning reported
> by itnull.cocci:
>
> 	ERROR: iterator variable bound on line 762 cannot be NULL
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


