Return-Path: <netdev+bounces-212233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 732ECB1ECCB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7977F1AA6B98
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476F286D56;
	Fri,  8 Aug 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08h+MgoT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBB286D60
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668960; cv=none; b=K72Ly0YG2sppiugbcq6c3U0V0um117W+HpNqgMZa1v4do5YNf3SETg8olJqsDQL+Yu8nAxH6ulsjlDSEtlPOU44sMvpLmSyJzsHQmVLhFsBVilIbatVxW/p2/+RsRzDfB3RLNVK7onr3FFgmIBAeEc26RgjGmGR9kPoYAdsIMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668960; c=relaxed/simple;
	bh=ljdj6UHE+j8CFBtwoGbGspjYtW2EmUCw1YaRvbruT2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IizDIs3MNYRU+xvZF3CvzmRviIUuHWz0aVjkMz3egkt3MOUBDUzJhX4ZzArDzg5WHo9DDBNs7+VkR8aYxnNX92pdnOQkaJsFMIUpa1toWtAgFJFdQOTWFMn4P26ItNnp+fw6labk5oXMFJRN8a8SZMWv123MkoILqeG8YbZefZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=08h+MgoT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bddb92dc1so3089704b3a.0
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754668958; x=1755273758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru7APTVYUUEPtXp9S4opMw5Xnjxo+/r3DAhDBG9Rc14=;
        b=08h+MgoTWg4HibDHf0GHx9oUTjhdNVqWZ3CUmiJfpdx/OP0Y+Z45T7ryPPAgJC5V9b
         VVymLRANzdQHoa1ef6IsJV1QdIJe5yY0Ye+RCdtC2aGk336v6fshh+cZdPrsH4FMHvuu
         PK7wx6x4eRdfp8Iout2xm1j5K9eYlChsM0th1r48gdNzevPWnsOQnPJ0cDjZLNnMF7ld
         ZrFyO/O2PhFp8yt28oGxaj7CWPhspCt9CpL5JVfMw2pJJND1Hp7fdQ0yDLuOsIAUujPm
         cXqXA9Of34CDz0coYOlkUhQJ2v0RvDX6L2LQAxBa8Gx79RQK/gSPfGr120oABS7EHsWK
         6RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754668958; x=1755273758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ru7APTVYUUEPtXp9S4opMw5Xnjxo+/r3DAhDBG9Rc14=;
        b=utWaC/kBNIE12wc23Oy+nZkrrmyidhucbYsWjRpCY6P2Wn0x6RVkFSjfR3J66q+hFj
         5zZF7LgrYfTZ33w3AVikRQuZh/SCwrCEfLqLDdoh4Vdj4m+Y+TBXxqTxRhKlBF//umFp
         sOV9o6fWSsaz2ObGejXhV1fVnVRETLHi6Yg46ER6jhRd/fG2Qg3FIrpA6tvaL/IEUR2i
         BgLkF3uQFu9zQwPjk+WDWCp2XoSFiCkgqXjmTWcSl/ag5yCRTyf/uj8fqyNHv4z/5bz2
         TAscTKWT9i/RofvK5WtSifXjy98LrMkUtDE8FUKpisCK80JOuxDKvv3X6SkKCYGDOlNW
         VKog==
X-Gm-Message-State: AOJu0YxR7b9065WZ0PiJVGh3XOw0ws6dpRBXOZWUiKXF+TY/LoFGz/x0
	pdVHEzkVdB7MpdDmrC6/Bx75NgmH8HDYqH64Qpw112MA4QYjAmZYpZUxnpPbkX/ZXQYSc5OEgHw
	/ZMisPO/kfT6VxTeJgxPYRfhyFXa5W51r50V5/QAg
X-Gm-Gg: ASbGnctSqiKSXKKtbqZnlkVk5KGzxodUgzL52boUCowga5j8QYOOvHDwdbTHDllMJce
	0TodKj+S8KUWgvA2XKitulmce8Tm23JaI8HgB7pCzhoeGuqPo2y2FlDOb4Gu3AbM5yYNhr2H88r
	2/Vfw5z/ZyJe9Qc9kQ2UlH1/6OV8jMdCJGrhSI/PaAc+mpnDoQZ8E7Suh0cDJZOYxPjiPKdJ/48
	hJb6Ctb/XR9K6aYOFDn20IfFoLUgO/Z63MnrFSw
X-Google-Smtp-Source: AGHT+IGmcelazqSJaJn1c0T6dzS2Mbs/brxOLD4FQ3amBhUjjUvHMv1zfTtsbY6sf0Pnw8vRd591t7m9jBd/nph1XRM=
X-Received: by 2002:a17:902:c946:b0:237:f76f:ce34 with SMTP id
 d9443c01a7336-242c200831amr57738895ad.15.1754668957562; Fri, 08 Aug 2025
 09:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808152726.1138329-1-jordan@jrife.io>
In-Reply-To: <20250808152726.1138329-1-jordan@jrife.io>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 Aug 2025 09:02:25 -0700
X-Gm-Features: Ac12FXwl2SxhpbXXwKtFiwnJX2OjLbXw3y6ryDQiDbwB-8IMHqFKhYq3RaNGkME
Message-ID: <CAAVpQUCRL8iz5iz+8FBKr5rJyhy+J99gK54BO1B5y1-Q3qPUMg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] docs: Fix name for net.ipv4.udp_child_hash_entries
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [PATCH v1 net-next] docs: Fix name for net.ipv4.udp_child_hash_entries

should be net instead of net-next ?

net-next is closed during the merge window so it opens next Monday.
https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-=
flow


On Fri, Aug 8, 2025 at 8:27=E2=80=AFAM Jordan Rife <jordan@jrife.io> wrote:
>
> udp_child_ehash_entries -> udp_child_hash_entries
>
> Fixes: 9804985bf27f ("udp: Introduce optional per-netns hash table.")
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> ---
>  Documentation/networking/ip-sysctl.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index bb620f554598..9756d16e3df1 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1420,7 +1420,7 @@ udp_hash_entries - INTEGER
>         A negative value means the networking namespace does not own its
>         hash buckets and shares the initial networking namespace's one.
>
> -udp_child_ehash_entries - INTEGER
> +udp_child_hash_entries - INTEGER
>         Control the number of hash buckets for UDP sockets in the child
>         networking namespace, which must be set before clone() or unshare=
().
>
> --
> 2.43.0
>

