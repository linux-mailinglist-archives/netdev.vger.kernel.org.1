Return-Path: <netdev+bounces-210638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F02AB141C1
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7038918C2236
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E13220694;
	Mon, 28 Jul 2025 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ks/LWNRP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDE145346
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726317; cv=none; b=lFGSRFUkqdscMbzKE5UQrw85V/15t6lcXmFz5B0fr74xhaNSjei7COgOVwrwEwon6z1To/St8qgY48T9QF+cOXL9bnSo2KAr8aQIcX+TH1wAKU3QdbxGx8szUHE69BK918sRIIuyWqpBJuqksGf5Ck9s+eCqFUD/UnZGOJBnKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726317; c=relaxed/simple;
	bh=E0aZ5ltePXU2tr39eM4OyimHIPNcEOkRmRYfDURu1Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfGzC2/qL9Fu8h7UItwEGMPqbHAO5T2S715fufXmu8MxvMoayVB97ev9zMgfofDtn/KFtfckqY/cR+b/NQnuaL1/KT+hcDvDRGmfenxUqW/1jFcbcv+404pnSM3sIq2PrZQzYMVdqtR2usbXZcQd+860hrAQUN3pWOC6knwxIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ks/LWNRP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237f18108d2so24415ad.0
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753726315; x=1754331115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWrTGKCGEGfsZ4s2TOJbLUNCxakJMocxAgR9drUPZeQ=;
        b=ks/LWNRPLsZmDBzViHD6mXGaSWHc3pDG2oHf6TZut176LCmlFEKQ6Ki0TgQfHcFsUF
         JskzyT7e7jytCF1TEbcvi6PXer0esj5Y+nNQD2sKk9zSu4KeODGaAaDw/t2OHkH12bAw
         U8NTv1st4OPUDfFa55Hh6JmkPcEFlfFH4RKm0Fb4EN3Bgb3uJ5MYnKk1dCCjS9q+l/d8
         2ql3Y1+frATAaFeZnR/+PsFvGQKvwz33ss9BRStcq7lp6mRO5mpyqz+9mF8VLu0eyVaV
         RdpqBCMizeEqk0abIarwCD73PV0p8KXRwjNaClxPVABKyjLCOc4S0CRZtDYhzXglv7UX
         NngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726315; x=1754331115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWrTGKCGEGfsZ4s2TOJbLUNCxakJMocxAgR9drUPZeQ=;
        b=lGqMCD3K5j1dbVbY4iWNaAgum5JEedSUjc83Dj8yzeMhaMCofcMv5R9FW0WV3FzAW9
         iV0+4z3vVGYXs5lJlW59nlwoDiSUn/uaBOH4OG3z96sbdzIeJsqdA/QqmThSC02QFVvi
         hLcZy4StUIMst0rMCbJ1Uxc2eMxbLcbUS45v9qBB+XUuOyTYg+Npw0R5uVQtjozEOkIh
         7wZ/IUo0skTecKwD0qCGZ7wap9ZkxPwJeER0eltEcssP7aivTXXZIms7seUB63O3kkOD
         IadXpxFDRvqI9P00w/A9T8fkamHO+h+fBW8h5oKBfPeRaFZXBmDiakM5iDJkJBlGw6c+
         OJgg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zJ9k4khHhaBeEPAd5YdfIyCwbsXRy8tCzZHX0LoBnfDug+ub5GzQhkZeEF23/Ef0AyHvgfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wlPoyEU+JFlxUep9RerGdZFi9zuZ7GeTgoic1Mxd0ytrtmSb
	YFePZRZMAnYiQ8Zu1ygIIV7kNeVhDq8e24lU6UTMJXU6sOUCVbIM9DJg5WtfLqz/Nsq5uWeiw2L
	gO7SoY6ih6JMZEbdI5DriCm/nJ543KGQnyOtn5w2K
X-Gm-Gg: ASbGnctAu4Lf0XI8G0m5FroJW33xdk1awMMZIfsJBOv/4onOsJ7D0cBYSu+gNc0LBF/
	/O+++vgCRpz/Milb569oVX0vhuyP8qZSmN+/7ScQe5hntrXLTWFAwB9BRlTzSoB12A3bSCYX8kz
	rO0OUNrUnm4Wg+rl3iAVrRlln2N4NZnCCzpXRu+sbbHNRFIHmvGPNo//I4UWpwqTlWYJ5Qyr1Rg
	B3FbLLGwwbnqprBqi4aqwW2l36Kx3+9Jvvnuw==
X-Google-Smtp-Source: AGHT+IEbF6oW+7FfHRssAd7lvdEZmBJqJX7xc2FzdGeBBdXR/cp8CUttG7vSZuTX1Aoawhbozd8z21A/66I2sgi7yDQ=
X-Received: by 2002:a17:902:e890:b0:240:3c64:8638 with SMTP id
 d9443c01a7336-2406789b433mr265765ad.6.1753726315246; Mon, 28 Jul 2025
 11:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com> <e131c00d9d0a8cf191c8dbcef41287cbea5ff365.1753694913.git.asml.silence@gmail.com>
In-Reply-To: <e131c00d9d0a8cf191c8dbcef41287cbea5ff365.1753694913.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 28 Jul 2025 11:11:42 -0700
X-Gm-Features: Ac12FXw5Q6EZZJ_i95sjCdIxpCkEiHb1OpsZvkKkuTR8Kp9jbXcTTEN4sj2bIT8
Message-ID: <CAHS8izO-TyoKd8qu05H3BKrD=eYST3ZKKd3rtdrYZQwuVQ58dA@mail.gmail.com>
Subject: Re: [RFC v1 01/22] docs: ethtool: document that rx_buf_len must
 control payload lengths
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, io-uring@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 4:03=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Document the semantics of the rx_buf_len ethtool ring param.
> Clarify its meaning in case of HDS, where driver may have
> two separate buffer pools.
>
> The various zero-copy TCP Rx schemes we have suffer from memory
> management overhead. Specifically applications aren't too impressed
> with the number of 4kB buffers they have to juggle. Zero-copy
> TCP makes most sense with larger memory transfers so using
> 16kB or 32kB buffers (with the help of HW-GRO) feels more
> natural.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  Documentation/networking/ethtool-netlink.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation=
/networking/ethtool-netlink.rst
> index b6e9af4d0f1b..eaa9c17a3cb1 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -957,7 +957,6 @@ Kernel checks that requested ring sizes do not exceed=
 limits reported by
>  driver. Driver may impose additional constraints and may not support all
>  attributes.
>
> -
>  ``ETHTOOL_A_RINGS_CQE_SIZE`` specifies the completion queue event size.
>  Completion queue events (CQE) are the events posted by NIC to indicate t=
he
>  completion status of a packet when the packet is sent (like send success=
 or
> @@ -971,6 +970,11 @@ completion queue size can be adjusted in the driver =
if CQE size is modified.
>  header / data split feature. If a received packet size is larger than th=
is
>  threshold value, header and data will be split.
>
> +``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffer chunks dr=
iver
> +uses to receive packets. If the device uses different memory polls for h=
eaders

pools, not polls.

> +and payload this setting may control the size of the header buffers but =
must
> +control the size of the payload buffers.
> +


--=20
Thanks,
Mina

