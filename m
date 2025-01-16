Return-Path: <netdev+bounces-158708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD1A130A6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087363A5469
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A512E7F;
	Thu, 16 Jan 2025 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy5j7mfW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361FB5CB8
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990367; cv=none; b=sq4McCnE5LHUi0TpYU72Kb0oJYunVL4hoI2ilOk3sa7+3rdD6RSOhGQo7X0A6UgFSvg0g/Ilnt5wtG1rPfPTlts/eAqUS6HbcvE1JnC7l2LKDoQP5CKkOrnA/TSqXRDmmqpoUq9ndLIT40MezL531vmcYPpMZ3epfG1z9VtJLyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990367; c=relaxed/simple;
	bh=hxJnSrmBxCeqKglH7i6urJRkRUmnsE97ZV3rrVv2UJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WggXUAcTvCJvtHRuqfvjWgKYAwZOcQm5BQgGtrR53yivGtZZcZhW14qv1An+POVxDzg6xQUVNpw9EcK3ZMviu4bo4hUYnSI2nPUqL8Wx3c+47CDmvZyepoADse550e0E74znOd6IHoPfM3TZVQRYj65+KrCG5geJtJZxWqbxArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy5j7mfW; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844eb33827eso13783039f.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 17:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736990365; x=1737595165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxJnSrmBxCeqKglH7i6urJRkRUmnsE97ZV3rrVv2UJ0=;
        b=fy5j7mfWNpW8JwyML8fLzo5Tj8HFs8VKy8aJeeo/vKbWlYlDvNY6dZbhpxYB30tPu3
         eVkVVQFPX28dvVR+/MGO4OD7a9RHV0u4yZ+fNcn5+awTq4VAL/oAplA/uHpmSb+OBQw5
         7/aoWBBipUb9JPKdVXP644b0Oqtm7M8zIdsyC4N57H0q6Vsh7Ws4nOtClcj7V220398a
         IX8ikvEn7CUngU4AeyYB5oYyI3JQIPSkqEuBCDo709Q7VXMiPAMcd/czmkwiGWFtblmv
         xDDXa0sZJPjVmLwHiSgNX0yd8fLBt0HJ9zx0ejypwmVJNmzEOJG9kUrA9tJOdeE7cvbM
         0ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736990365; x=1737595165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxJnSrmBxCeqKglH7i6urJRkRUmnsE97ZV3rrVv2UJ0=;
        b=eQtk5eOIRaZo8rpV33tV355c0tw01V8qSrkfazJ5n8qRLFK5KroKDZ8K1gu2p0iP75
         KxH7JPPYuYR2345gOevlBTBcQIrqgJnjtt0VOzDJhqfiDjfeGc83rLgBAZ5VrFUAoTod
         pd7vxTrdoGsMT3AorS5K8SJbhPHu7JqHV20qIGzl0Jz3AEXugNA1Y+wxQR1akSrSAPCZ
         oVMrNxWaYktuNOHCY1DFdVkU+muIwSxbMN2rSnTy6v4cwTCAmtHMHDwS5an/QZy1cKDZ
         XGwLp9mglUK8iQVp/JNlJS+hqy9fbhUINQ3ote3tlwbj1N3MCfuATb3Ogcm6HfgGkejK
         lp8g==
X-Gm-Message-State: AOJu0YxKjWDgaHXjoPqBtTDaOCEKKowftgeVJY5lgtYW0s4ZQpBdEj1K
	pqU7CZg0T9EL0CYL1LP3ZovQSTzwWAXPDe5+LF5bie2Aq7afQWm0nRA+YnfG+pN0BI38oJsLUEt
	X1mAgWGagk8uQz7rOAJsiuLmJ728=
X-Gm-Gg: ASbGncv2taObBtwH4Dtb5YjxsdNYroHGHYtiY9czESgU31A1D6q8xzSZRKWu284nD1l
	0tfy8d2v+qVpoAH0kIQ9olTrJ0Ue37fQPOECe
X-Google-Smtp-Source: AGHT+IGTsDUTfI+SuxhNiQ8lKTVbkgTsP6tN9yqHjFnjhai4qaRfaXrvsN3hlJNbM6i/optPCRNJokAz5g32mdQUkLA=
X-Received: by 2002:a05:6e02:1caf:b0:3ce:7eae:45c5 with SMTP id
 e9e14a558f8ab-3ce7eae8577mr76902225ab.15.1736990365185; Wed, 15 Jan 2025
 17:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com> <20250115010450.2472-1-ma.arghavani@yahoo.com>
In-Reply-To: <20250115010450.2472-1-ma.arghavani@yahoo.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 09:18:49 +0800
X-Gm-Features: AbW1kvZVXe-DAxD2l_422hhoF6OnzipnzFYBtKpK6vbOlxt2CLuTN5etEEPfsbc
Message-ID: <CAL+tcoB5T2h+9zk4+c9UFJT3fttD=Wt6cXWj=9MyONhQxLNPEA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start detection
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, edumazet@google.com, 
	haibo.zhang@otago.ac.nz, david.eyers@otago.ac.nz, abbas.arghavani@mdu.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:26=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yahoo=
.com> wrote:
>
> I noticed that HyStart incorrectly marks the start of rounds,
> resulting in inaccurate measurements of ACK train lengths.
> Since HyStart relies on ACK train lengths as one of two thresholds
> to terminate exponential cwnd growth during Slow-Start, this
> inaccuracy renders that threshold ineffective, potentially degrading
> TCP performance.
>
> The issue arises because the changes introduced in commit 4e1fddc98d25
> ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limit=
ed flows")
> moved the caller of the `bictcp_hystart_reset` function inside the `hysta=
rt_update` function.
> This modification added an additional condition for triggering the caller=
,
> requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also
> be satisfied before invoking `bictcp_hystart_reset`.
>
> This fix ensures that `bictcp_hystart_reset` is correctly called
> at the start of a new round, regardless of the congestion window size.
> This is achieved by moving the condition
> (tcp_snd_cwnd(tp) >=3D hystart_low_window)
> from before calling `bictcp_hystart_reset` to after it.
>
> Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detection=
s for not-cwnd-limited flows")
> Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
> Cc: David Eyers <david.eyers@otago.ac.nz>
> Cc: Abbas Arghavani <abbas.arghavani@mdu.se>

According to your original thread [1], I can verify the same
result/output by either applying your diff patch or reverting that
8165a96f6b712 commit. But may I ask how it affects the latency or the
final throughput when you conduct some tests?

I still need some time to dig in it more carefully.

[1]: https://lore.kernel.org/all/2046438615.4484034.1736328888690@mail.yaho=
o.com/

Thanks,
Jason

