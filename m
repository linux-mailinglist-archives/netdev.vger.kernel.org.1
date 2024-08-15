Return-Path: <netdev+bounces-118789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C0B952C92
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820E7285135
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40051D6193;
	Thu, 15 Aug 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnABYyfx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E41D618B
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716911; cv=none; b=Tt44hxiNJ6DloLOQmfOBhgJctqlpbwK3PoL151ecjo6/Zy/ByT2iEPj1MR6RI8caEeeU8Q5wjbxRI3x2R/RICq8z0VWKKficAdRAf7LEvCbnC3itMpziE26VeYrX9veBkmcdTu08497GC4AZnoxeBSRxKpFzMatU4Fs2BIVeeU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716911; c=relaxed/simple;
	bh=4VPEfJTvmfBgqpWEmhZGfaI0okNNuQ9tbPIdnKzIPNs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BC6naRL6TnP/sueDZ/Y18XRCItet1P3FFaInPwGpMksMW3coq4NBZ/8cAPexuVcZW4a0A0qngpQiFSJgx2IQ6ZHQewTbbAVi7hjQCAQjmr268Tk5nyLZKkZzYBQszP2Us+5j4vZqdKD8Or9CCgggsfUZE8BxmQ69AFQ22sj5T4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnABYyfx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723716909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VPEfJTvmfBgqpWEmhZGfaI0okNNuQ9tbPIdnKzIPNs=;
	b=WnABYyfxs6ibJBFfRqfsU+LNAO6efovBzMp0/wJBBtM2w12Zy2hh5YHbjG2Q6Y39+OlxKz
	3gSpkZ+QUgpzQfrnmWi0aT5Mk0Lw1FA3eHVsMRPVTU63HCIfnU7JmQjLBC0rstSEvbVtbt
	QsSH6ut9FPnWenSj3Zq5t+N34yLBSM0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-dZSLeQjwPjy6AkrdkZZ9jg-1; Thu, 15 Aug 2024 06:15:07 -0400
X-MC-Unique: dZSLeQjwPjy6AkrdkZZ9jg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718eb22836so18775f8f.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716907; x=1724321707;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VPEfJTvmfBgqpWEmhZGfaI0okNNuQ9tbPIdnKzIPNs=;
        b=AEbNjxtn5mfXRbKdlmQvMC86cExcMG5zfNhHS2JulJp25hI0Ya8ZqUJLuWnpdxC7Hw
         x12pPV0ZB4PeO33yk0dkiCDbl1bk9+yN9HdPeIIu0KGH1x7TY1Mby0MLdlLCliTfEx2Q
         kwe8+iMtW9uogc4HDfNSoIEv/4HhRo6lYizrOftRZvzmtJ/AAgq5Nwfx6+AHs8nW4Hpy
         iOqMOwOp+SRsGvcAGLpd3pgJItFLYIRqXO3dKtzo4FMoDKgkWw/SwpKp0jBQtlwWBGss
         99KIPV2+3XvBw1vJ71s33nHRX/HY7uHuwgJ0qrt5stwecgs3wwlzm03GvRwX+O9e5Fp/
         N7gw==
X-Forwarded-Encrypted: i=1; AJvYcCWyVORSTlWOVBcwbNvSkcgspBHvbAZ5TlfMXoQOUSK6DcWvyNXHQEja+yeZfnYDD+MwSGQ0L7WwpLEr/LiRu31f1ab9jkOZ
X-Gm-Message-State: AOJu0Yx6l1h04Ap7O9IAGkdAvy2zhsNvrkMjc9ZsqMLTQsJ8/H+DwOkY
	iaOKaUkgFKBRiz9A/dbHXx8EbwFiEtktyp7gV9V6+MGWAfKvIkzaMbkW83PR9DT86DSlYWcwOqR
	s56cw17A2HQojK6CeTidS9STqq6+LSe8OFSb750t44ztW31Lkgma0gQ==
X-Received: by 2002:a5d:69c6:0:b0:371:8d47:c174 with SMTP id ffacd0b85a97d-3718d47c283mr514289f8f.30.1723716906707;
        Thu, 15 Aug 2024 03:15:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9xiZ0Rp3LP6sBcNq0A1flnPS/fGarKdASNjYgytk1FrZTuuV1rFMPXAlRStkxIzOmMDD8+A==
X-Received: by 2002:a5d:69c6:0:b0:371:8d47:c174 with SMTP id ffacd0b85a97d-3718d47c283mr514263f8f.30.1723716906191;
        Thu, 15 Aug 2024 03:15:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a184sm1113408f8f.14.2024.08.15.03.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:15:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6FB3E14AE03F; Thu, 15 Aug 2024 12:14:48 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: bpf-next experiment
In-Reply-To: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
References: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 15 Aug 2024 12:14:48 +0200
Message-ID: <87bk1ucctj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> 2. Non-networking bpf commits land in bpf-next/master branch.
> It will form bpf-next PR during the merge window.
>
> 3. Networking related commits (like XDP) land in bpf-next/net branch.
> They will be PR-ed to net-next and ffwded from net-next
> as we do today. All these patches will get to mainline
> via net-next PR.

So from a submitter PoV, someone submitting an XDP-related patch (say),
should base this off of bpf-next/net, and tag it as bpf-next in the
subject? Or should it also be tagged as bpf-next/net?

-Toke


