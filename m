Return-Path: <netdev+bounces-178150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A2BA74ED6
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 18:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292D51889091
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E085F1D8DF6;
	Fri, 28 Mar 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1aE5jd4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1953C0C
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181464; cv=none; b=INi0HCI8YZ8mzD6SFcMMXTGTjxeloI5wQbA11XCAeKdsqWHd11bWhCKaYlJyKM4MDCOu1mfbylIjq2h3615QPKj1VSXYvuABhGBqt0qSNd6bzvC6jKkzzKTpogTEyAocEF/rQ9VuMDaYWWX0haKQJir/ak6r5ffVVGZQWkhHnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181464; c=relaxed/simple;
	bh=0pA/SM5vUVjtrhYy3C9THY0qsW+TLTBN5B1vYvvH7/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggWlskm29CbGjCkj+0L7rC5kpHKauiVyNaUjePxSjAK1dWSXcdMqwfFpUNy98qPJiMIB0h5zLdRkVsO+qaPJh3ACzXJLP5V/JGy5W0o0PTnSZwObsxZIE2xRwPf0MLgGTYxfitArT10M1Xa2iHpu53RZXVNIV6HgTjYO3r2BBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1aE5jd4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2263428c8baso4965ad.1
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743181462; x=1743786262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pA/SM5vUVjtrhYy3C9THY0qsW+TLTBN5B1vYvvH7/s=;
        b=L1aE5jd41z+h1L9/75WOOMVBCCypWSX5JLPVv8YvylIosUdZDrzLt13/rXh1Cw193j
         BdDPRQj3fahjWZryrOgo4keXYkQr48OCRzyAuW6vYW6y90QnLhzrgK6YqU09Fy0KfkQu
         59utEyoqxDF77c/Uu/9uQfT7vaS6j6yYNYjNmXEI4S8gyGPFilGSF4WWzJCqnir3kxrY
         RRYvo296x7+lxStWSLt23kkyghIqSmZG7OjpuvPjGjC97OIpvYI3F9gdi404hqfgy+RK
         QFq9iR9W9m+POMkjTPO+tWQJDHs/eXtY3HFHiM1eSbcY3WgvVgsGyZAO+1woIr3a/B+U
         ztiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181462; x=1743786262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pA/SM5vUVjtrhYy3C9THY0qsW+TLTBN5B1vYvvH7/s=;
        b=RVIzdP4JRvG3cojVsRhw24Az5S71nLKs2tfWNDLX5+2TchkvcX5otM+tYkoQH+i+aU
         iBx+H2HeEcLG+CHfBaptEB47T6fxxZwb4ejTo2KEj+ZYZysA+R0U5Ul9ZA+SIDeQSgFe
         2HsaZixLUTXF8zjSQuNZtPUfTQsyRmv4RVkznCqvnP6aWjSSOIUyqFqyeJms6jsnVPvT
         nevzm5zR32wJp0TQpf3rN1jaaszFN9vxaP4QMiCT7eXgpfPi6wg0+LpK9lco+RTcApgg
         ILRdJSqrmfRvjYXj1p0D/K/YsCkFhNszbV0MSS30J8rPucJrXLouNF7R47/uE2XPpU0C
         5aGg==
X-Forwarded-Encrypted: i=1; AJvYcCUIVcIQnOtRmZLudBpLlNi1kk1T4pVrZWmmf9/58eelNvJl9929ZtCumsazwhLu4PBrpFV3wuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QTWWZ4nLkxe9Pou2ydi2AeAYCeWZDeSyEH/AKcDVR1/RWs8V
	x9KQ3GyKp5uLVnI3qd3Y7LgQR936YwAiE8SdzqtSQcseflXyroo3R/WjWEMxT9AYnhW9BzrybMH
	SLYzwzq+utKhTg8XAz8ikilvs4No/RzJsBJEO
X-Gm-Gg: ASbGncvEVdg1KgfFcz2eSWQ+0iIHUvBSH7qH3RZZHez4YcyOBz4qGWMwB8mXJTLBlGX
	MN8NWUw3NxgIA5I12NgfwJPFJia2EFSfIU7r75GWYGtUPyiz69FtHhkhoAgm+XM1QlyP19FvTMo
	PPZfmQuP8F6ueJp5tsSAP6NkyExMw=
X-Google-Smtp-Source: AGHT+IFfQjOm9OCOOh6ex7QXOjj9khEp+UqyWkCt9W3SuGdPn5TX24kfJyruHGATBqccsTggPzsws0Fnb16kCs1TF+4=
X-Received: by 2002:a17:902:d490:b0:21f:3e29:9cd4 with SMTP id
 d9443c01a7336-22920e25925mr3189545ad.20.1743181462246; Fri, 28 Mar 2025
 10:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328062237.3746875-1-ap420073@gmail.com>
In-Reply-To: <20250328062237.3746875-1-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Mar 2025 10:04:08 -0700
X-Gm-Features: AQ5f1JpiD-o1d_Au7kTv-Jv8e8tnU7oeZIW27v9hxFzqZ9jJLGwqdNng0dp-sXk
Message-ID: <CAHS8izM9oCg7-1ENzvR+tri4TiPsmQkQki8JG4taJ6XE+RJM4w@mail.gmail.com>
Subject: Re: [PATCH net] net: fix use-after-free in the netdev_nl_sock_priv_destroy()
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, jdamato@fastly.com, sdf@fomichev.me, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 11:22=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> In the netdev_nl_sock_priv_destroy(), an instance lock is acquired
> before calling net_devmem_unbind_dmabuf(), then releasing an instance
> lock(netdev_unlock(binding->dev)).
> However, a binding is freed in the net_devmem_unbind_dmabuf().
> So using a binding after net_devmem_unbind_dmabuf() occurs UAF.
> To fix this UAF, it needs to use temporary variable.
>
> Fixes: ba6f418fbf64 ("net: bubble up taking netdev instance lock to calle=
rs of net_devmem_unbind_dmabuf()")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

