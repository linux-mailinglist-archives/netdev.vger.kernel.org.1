Return-Path: <netdev+bounces-201639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C2FAEA2EB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022DD188DD9F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC92EBBB7;
	Thu, 26 Jun 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzye6sHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8712EAD1A
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952469; cv=none; b=TaZ8kPFBAheGYTS97bk/GwXGAlqBibh0wzDxWILSnP3bhDZYPK7DNwDX74zeW075ED4QEPGZIQ7r00oTdMcvsUPBppgqvPpTcnVIxv7Z07WHNiW89VLcjkbjPviYQC9kGarJ1CF0jcjfvq1uq1g39q5o8T+aTqwQZlfcJG+UuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952469; c=relaxed/simple;
	bh=3SNhbrDkxGmLFifDFSzqm4TbXUlU0zzc9WFevHbvAFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGZyR55zPz/VeCLvmHoQSX4Qcb+smSLXTPU8tLP4E0IhNR3lPPGGuxxzm5wJ/wg0oOpn5yFPR21pfbIAwU4rULpGC+P2avkLoZ65u7y21UESsNp1HiJdvYENqn1fsjKs/JaK5dLDK5AMsvx+AcTDrY+R4iqZuOgKo3iCImnrTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzye6sHs; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso27041cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750952467; x=1751557267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SNhbrDkxGmLFifDFSzqm4TbXUlU0zzc9WFevHbvAFc=;
        b=tzye6sHsxe6h9Uqcw6yvxIKlmkJ64kCp/edoPgDy/dk1hjAPoHMTaJK8D6dxvLuh/6
         GRyzTR72flhIZgN8d6LcOcQRUmUaSVm8K4ZLFiNtr75RcDLnF2XIU/fmLzfMqrtmKndv
         ENU1zFCzRRvTR16mWpDnCqAz1mqPRONNT32Z9Syh5fu7pHJfmbTbY9OU9mPCxCLYQWuW
         GnT+NfCl2JPPiARqKulo2kEDgQWB+GEFG4a0BIzz8WcXyRvRD9PYE9WibTkIwe80FJZz
         wYb3Ir8tuUIijB7IpnVuRxelZtxEESYV9miGsFBle97kNq+2XKL9Z7LSFUfby/eSTr0M
         cNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750952467; x=1751557267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SNhbrDkxGmLFifDFSzqm4TbXUlU0zzc9WFevHbvAFc=;
        b=LhgY5/tBUcUYaYi0n8oRsuNNmikHk7uQAPc8HQtviRoOvokpL0mSnqPpYTDrbgQR7c
         EbsN5Y6huTnHfwFci3cxDGDip0uIQE/EY/0s0wAjjHmdunj9uZYC6laUficsYHB+O85G
         Hgc5gXHMfdS9KqyParzmFgG24BLcHXCmaRB0uBAcfBeRFhT0u9GjSetfVrMNDqGLpDZj
         DvWRKwBzH5V7Y6usmsRKfBmp2XdpIuPV8BjEUYhjkqJUBI9nLiRSANZ8MKYCElCXcJzS
         pYOTgaUG6Q570PwyxB7UpCLHDo+JP5Z1i6soeKk6W2Epmb/4qHzOBE/OCPgXvzBIZmBT
         Q6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw0KC3oyeUUGMPxWCyeUkmNYg88Zvsie2evAjPOe7WojMsFiuCZM418sbAmH7VtuM1kFgnXVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnADdoixKM01sEcztl/kfYewyql39VKD9B0yX6oXUMtVAOWjU
	JfiHT7oVFkTExLtbESCBejA/UtZcvZHjfm0TKc29lA7BmnkKHQP7m1lpMRCceW84OJoltXsMWvy
	9y1E/j8GrPPEYijPYdkpFGoVmrmuMDpzmt7bCGe0g
X-Gm-Gg: ASbGncsjB+5Bo1GbGNRbIkUyxZyZ0JnCEA6GhvNQVzri1CY9+KGRzxtZ+G38KiD0915
	aDqh4U5ZitvbSX9E0/FyR+J/GFz4uVrENvIzOJ4Ukka543/RIcrF1+/9I7JpPu3QzzJ0NS0WhQ0
	PAVlaZMSu8+17Ij6ZGmaHSG7O0fLiQ5bd8xbDNv6IUJON2iqNSDVU+nQ==
X-Google-Smtp-Source: AGHT+IE9c9sLzZ0czB2gRjvEa+YiaydAeX72Ljn8QjrVrnWTlcV4GMZcZXUm+f9ijMeDj03x9u+xpCKOEWUShefhP0A=
X-Received: by 2002:a05:622a:8350:b0:471:f34d:1d83 with SMTP id
 d75a77b69052e-4a7fc92afa7mr5021cf.7.1750952466669; Thu, 26 Jun 2025 08:41:06
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626153017.2156274-1-edumazet@google.com> <20250626153017.2156274-3-edumazet@google.com>
In-Reply-To: <20250626153017.2156274-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 26 Jun 2025 11:40:50 -0400
X-Gm-Features: Ac12FXwtq3Cj1EhBzGDlU5f1S8WgrXSmefUF8u_eTigrHFITFNDkbTi4Pgc8LcA
Message-ID: <CADVnQy=o42WF7M3e1MvYHjS_F4n-m3G=2DJ9G_thKeMTfsMDPg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: remove inet_rtx_syn_ack()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:30=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> inet_rtx_syn_ack() is a simple wrapper around tcp_rtx_synack(),
> if we move req->num_retrans update.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

