Return-Path: <netdev+bounces-139591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC79B36AF
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB941F2291F
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01291DEFE0;
	Mon, 28 Oct 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QL4KLo94"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD01DEFD4
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133424; cv=none; b=qIgj6Scx5BF/Eh7HIp31XHVYC0FDZpHsIPWBIN6W6rc2rKWjqCGM2m1Y8LIDAuLsXlo6ZwDQ/f8SPNySGn/FBLwMcCIW8w38LBAh3NsTC0RXahwmnUcnONBgH0Ut5oTNdspyF0Wf8BFqPB02BFrlVr1wE1B8hCKffmxDXULZveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133424; c=relaxed/simple;
	bh=A1cFervhOMCuUn1qMqZ24mOHhDxMc2MaSueVuQ58tpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUhhvXu6f8hOJAtgSkek+mr1cE7MjbHbnuaPmg4J/UdnvoSrB20m0ZG1fXiIcUjPi+fEl1Amq4RaUflsH1ARj5aZcpKTCb6R84Iffj5IOJIypcx0RU+WPCVcHJHmfDtXTQs5P9Iys/g+8GjTAvuDDwA/eFQk3XLupf6HnY24qqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QL4KLo94; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e2e32bc454fso4373756276.2
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730133421; x=1730738221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC3jVJVkR0vXjc9v4X5cqN3AeydRxh4u+9f7UYh0hzo=;
        b=QL4KLo94HsXvdRICxiDuQJ3PVBugrW0AUDDLQaUqDewXpA/OdPnUfAoiGRbvoseDpX
         Ohjrfv4wYFXICHSvhpf6RP2hPaocKZeWIyu+NRQ+Ng8SYaetmCBT8xqFqgaJxK4ypo0W
         ympdDK/qdEuv4Fcz3GEL+NermkJosAO1OG7M2+ymGR0t29b4wkmKyorR3Vsa/M0WQHqv
         90VUAC4reIdNd9PcXSUbckPctQJbUGP2voPshCZoBuWpgmYG5mi9zCRV9oUB8By8a9MX
         3Pmq5N+dQhxFeNb9uLmEoi6acyFp3q3T5XeiHr/rPodbB+52REp8o4Hcxa+OfVYq7RhQ
         LQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133421; x=1730738221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC3jVJVkR0vXjc9v4X5cqN3AeydRxh4u+9f7UYh0hzo=;
        b=sk5VMCV7H5e9HJWlh8QsE0BCnzxHWtXrD2ruO2MUSPvTTe+5GR+SVEEJkgbVsifN96
         jJk0i8VnMHMINUvzfcxA1cxcQfHs+tu1GlpfGt/V9NZrPXOsrlqPC9t/5hav11oL3fvG
         NE3dbZxWkFjsBTdpaogmEHXMhHbSgbb8+D+4z1wn2E17w+23Sb8vuOzPkvmWGjikl9Yw
         wBAwbmBLghNdoGZx6rSVcGjWWN289bukCGoRp9RrQ9fg8e6GSRxF/t/ZDhLFAc4O+hgN
         yMgwDi0WQJ0EkrQbic56vMSCLa7xFih3LF6i42FPVPiviCnM1U2mpMkE1TB87g62MEOC
         s5nA==
X-Forwarded-Encrypted: i=1; AJvYcCVRfSCUW67zo6rWrtvUKDsGFmVGrdFohMkwHYAR6Ujt3I3gZvvFgUXjPEOjqmx0MixDnFG/3n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEFm7Hg9vq//rtD/gcisXpV7RxmjcnMeijwbh5jT3LcZ0JZik
	nzeoDVx2v7w6WkX4D8UYT88GNYBl6/42i7V36IBWVhrPoNhJGIntysaEmyXUNB8wXXkEcqHP7dl
	IrT13LbdgIV7CfUhmQYfI4IiFNtgEz97g6hkQYsOKSVNdZrE=
X-Google-Smtp-Source: AGHT+IHkyOUSrZWPFA3y75jsiO35BBFsma2xgU/eoM7XLdj4xLkzEHV54DlON8lAoxScSinKd0bNayTWXt4280H+XTs=
X-Received: by 2002:a25:d645:0:b0:e2e:2b20:492a with SMTP id
 3f1490d57ef6-e3087c21336mr7425173276.46.1730133420732; Mon, 28 Oct 2024
 09:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028123435.3495916-1-dongtai.guo@linux.dev>
In-Reply-To: <20241028123435.3495916-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Oct 2024 12:36:50 -0400
Message-ID: <CAHC9VhTC3OgGy7FrmPTOG_qLoPFbUFqYa+bJvfB2q+uMkQWPWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netlabel: document doi_remove field of struct netlbl_calipso_ops
To: George Guo <dongtai.guo@linux.dev>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:34=E2=80=AFAM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> Add documentation of doi_remove field to Kernel doc for struct netlbl_cal=
ipso_ops.
>
> Flagged by ./scripts/kernel-doc -none.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/net/netlabel.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

