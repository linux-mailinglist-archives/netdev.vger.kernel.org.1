Return-Path: <netdev+bounces-214793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E506B2B515
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB385231EC
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 23:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A412765C0;
	Mon, 18 Aug 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEjs35mY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CC2417C3
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561030; cv=none; b=qIfWcfmplL3aXEk+8TLqn5TVZ89nLzqJRNXYW97FGdsDxxxdRflt4gHlH+nTbX0QJTWSjSDdHxc2vs2VzybBAnj067CQSD7sPmOa7/GYjyJPy6dxuK2yAHAJ3/mqIER5PlhQ2rkRttSTkJyZDNouwsA0OioBFfe3Uqgpj/Igv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561030; c=relaxed/simple;
	bh=LcsNuZAmmSgBbn7Rx/F0jKuldnOTvv9gOB0r7oIHRPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fiw/b614HeKVxeYBpNphzKFQFN1E/SK6DQdUqp5ZmH3/hJu6Go1iK1klzwmeKKveOBm33G3qVlKtEYa6TjXI8FX+6HQ/CadcCpkbjwWS+czSn9Z6/OoUudT2nsxe1SCI7TAF88O8sI6F/UeqZfMJKSG6aJ505ZA/C0e/lvVx5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEjs35mY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55df3796649so4187e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 16:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755561027; x=1756165827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcsNuZAmmSgBbn7Rx/F0jKuldnOTvv9gOB0r7oIHRPo=;
        b=kEjs35mY/abuBvRXcO10QPH8S6ZRk31NPSrdR0MCCAQkyIIOAv/SfHtJ4N/US1LPef
         i/I8jM0Mhxy1gBQ0AzsabvyDg8xjtqck/Nfh9Yx1IZv20xHuokHS7WLRbTNmYN9BUDil
         xwh1f8zGh7cEjQhwq8p8n1PGZ+HMFyvCqzZXCYhunBemhUojKo0yfHyFOvzj2McBqINc
         pPrxjwXNu381/fHTr6R50CLBIJfn7UBbKeDdUxmyAMpMH38GONFiZwgjtAgwDkj5PeA1
         Vz4vhz19VZ2UESv8chQbJ0WP9FyBv1m5C8qBhVDMHHABH9RQd8c46T/ZJ/8Guhbqvf5m
         Y7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755561027; x=1756165827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcsNuZAmmSgBbn7Rx/F0jKuldnOTvv9gOB0r7oIHRPo=;
        b=Smpx+dziaHPhuuke2uUIZ1nZRM75al8RNhA0k1E5FrnZPeFvIN6/4xEs0KU+cVHP1y
         ONImZ0yx8Ipq8vO04WXpuMK9M4beOcy96vvtxg9wdvAORbwiAt2Xu2CPjFn7KhZK/eNQ
         AAKGkJ9aR7+FynNRD1hthF+o1C54+Ny/pdK3/yYATf2AwLYJhHtdppRMWAbQqZibfqnd
         603tuAH05ch5hEf9MovqCYzxrDZ84E/qvxBgw6qWCfxfRh5w3PXuLkdkBBXEXkW+Bgl2
         q6j8dOujM44DgwRZFLz682nTx326ugx0s8RQzbW69kkYmZP21Ww6fxRpvlpi+Swlhy2p
         FaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUakO3T9+F06j/48sz1V2kJSAU8jKYpFyk5CpiJXA01x+33/PNJK5TNs8BFs33DQKnxF1pxEqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxma508Hk/jiur2jq4/gmT/Yb4+12JdyNcNUe2B6kreJoz6YJ/O
	uSwNIlD0jAAuPtyR+erwF1PkwF8F1AgUgN1LQjO+/H1XBm3FdgbQy0y/N72QnyAaKltAUy2oaNL
	7fi+jn5eNOHqO2l37Qg4123eY3h9B4hoYY4c1hy2i
X-Gm-Gg: ASbGncux4C+L92DGUs/uW1Kak8rFOzA7E8ZPy13/W56BuFPE+6b1LUU9Q6uLgYaTETM
	ZvXXhz52uE8WnDZvelMvcd5V0PzfpiJjjUqm3Gsedtmd5OPJM7zjdxeeO24oWSnIs2ryRf6Z5Rc
	GdvcJuIZtB6U1k+PUzhc7om8imw52Y06KrSFCrRWqDHGQDuY2i0QHeTYqdOtkdG6/s/PA+KBflv
	azv9+A2AsEMJihjruw7YSJx0jC150GBz1EXDbQlVXYS
X-Google-Smtp-Source: AGHT+IEz9461t1FLeYjqAPV9IC+YLeWd69snIPkzWT8jdh/N0oHfH1jree3Vr3yZo117hlh5lONNshD+tvF4WSbIHxw=
X-Received: by 2002:a05:6512:250d:b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55e0095dfb9mr92067e87.2.1755561026720; Mon, 18 Aug 2025
 16:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <353e0195a0f44800c0b5aa4a6d751d3655d9842b.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <353e0195a0f44800c0b5aa4a6d751d3655d9842b.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 16:50:14 -0700
X-Gm-Features: Ac12FXym-AdI0-6m9FtombEI_KXbKYd4WM0Qi3aWvTpPx0DSoGpMt0F2tRTsGrw
Message-ID: <CAHS8izNEVecwoh+f1nUBmTOGHKS+A6Up8R-0KTFMSwPn4+VzdA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/23] docs: ethtool: document that rx_buf_len
 must control payload lengths
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Document the semantics of the rx_buf_len ethtool ring param.
> Clarify its meaning in case of HDS, where driver may have
> two separate buffer pools.
>
> The various zero-copy TCP Rx schemes we have suffer from memory

nit: 'we have suffer' sounds weird, probably meant just 'suffer'.

> management overhead. Specifically applications aren't too impressed
> with the number of 4kB buffers they have to juggle. Zero-copy
> TCP makes most sense with larger memory transfers so using
> 16kB or 32kB buffers (with the help of HW-GRO) feels more
> natural.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

