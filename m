Return-Path: <netdev+bounces-88962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FEB8A9186
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 05:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14712821B4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35B4F889;
	Thu, 18 Apr 2024 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIHvaJyL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367585244
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713410717; cv=none; b=O3lEKk6b82RiJ7qdCarzWp18zbfgjWHyOYHLtFDGsn1U0AY1FrOCgoA8iIQfmKeO0jjewAfT3bqsOpSOStK9hZF8mX7uCDu1K7TUz06NvlIDYWJj+xMjbOkgRtXqSmHGaFfh1+Kf+Eod1C8jNUCspzjqk+l1msHcf1zn8CiTyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713410717; c=relaxed/simple;
	bh=LVkM5g/dL84+7y5855gmxpHEyRk+2EwTGWS07nGwotw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkIQrGcWovhETfZ/DMGSayae9USi8y5YdPMRisiHGpVGYFNPvc4tfs2M9XrxMtqS2s94NO8DodOD+U7PUCI1ODRqzOS6q2v9PMUbuxAGVBgQnjWBqAMQkdh9AGSpzf8MIZmanqKkkBiUz5IktTeQSUBOfxmb5pMaixpWw5crJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIHvaJyL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a52582ecde4so26175866b.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 20:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713410714; x=1714015514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGS1VtPch1oC08xqsJYQk2qbuR770Ab6Oz9tsV0ha7k=;
        b=nIHvaJyL8ha8htL0p+2p3EaLzioMDTCQTd22Ce0Q+YaBUPmnvGFQqJtFhsnVQAGJp8
         giTywm5THbEs5OoHtMXAA/qIdyFak9ywxS96VsUooXvG3PALZu/bViSXc6FOiSb7rgrw
         XwdMwbKaxcYlk5wZHCPCaEhWYbE+hqhHONgI1oBj4bD6SWb5ihhMLi8exOGNqxCy1DiT
         zkcuQMDOzeB2bOENwoXf9qsqLhhPX2sOR477xMZ/vln5Gp8cZ/1uT/nY3RhOCjvxQuOb
         SxmPJ+6XswVoVMiLKk40nCb1f10a2deulqJhUzqbc7IChJW8ChpVzKbf+XTcQssixu0w
         cCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713410714; x=1714015514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGS1VtPch1oC08xqsJYQk2qbuR770Ab6Oz9tsV0ha7k=;
        b=k77wz3bu6eyUjYPT8QwOsnQRUJ11gsqZjZoUi7ryPvP+mnPneI8bX9/f65ABNne/6H
         ACEp5GH0e/e91mkzTC/abKRE9q+paQk/oc92/Xs6JjKyEkDlDdraqhBqzx1KeBFydLeW
         WVwpvJvuTwv53MFItHUEwjKG5tWnIixiwfjXjBQ7EDAL5lVGAqaiizydeB+VshpguR33
         YVa5nK+hxGHNMRYgqSESh+8M1stCzBgXghHQmK1csLzvjqltMs7qIxVir5wmLZpY9CyM
         IWmulMNIe1/nEOzChKdhMpaTAXWnd+dmcREYADI6E2obrxHZcnxZ9Z0Za9eBTkQmHsdL
         SNvg==
X-Forwarded-Encrypted: i=1; AJvYcCWGJdd5xngOWdp8zslACwFJUfeeH64Y8pt0O0aewaP2J33FKeZ1l7oATjRiAZvRRYSoZ9mx/Ruooe58coSR6ZtjOig+fx50
X-Gm-Message-State: AOJu0YyozZUtUbffzrAY3+u3rvueO3CW7emLotEf6I21qMMlbw+GcuY3
	RPVjWiMl7uN84SIWHgfI28/Ew5F4Y6LNaQqUUMBDNSV8EpAjuSmHID7jmJihoTjfSO+ezCDH/Ms
	AC5aWSLj2CxAb9k3Co2TP0ZcGjlwcXJ9Qj5w=
X-Google-Smtp-Source: AGHT+IHG1T2+CRGTuhQQxDkt3eF6Med/s5rnCtUd3OqEvOinl/0HMbsYjBB+Ou0FRBB2fqaeuy7iGpTOX4PhvnoHjGk=
X-Received: by 2002:a17:906:3059:b0:a52:3eff:13f1 with SMTP id
 d25-20020a170906305900b00a523eff13f1mr775624ejd.2.1713410714386; Wed, 17 Apr
 2024 20:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-3-edumazet@google.com>
In-Reply-To: <20240417165756.2531620-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 18 Apr 2024 11:24:37 +0800
Message-ID: <CAL+tcoDntffvPAMKM1vCxCuLhOt6bPgcJ=40Pq4eRqwtKOU20w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: no longer abort SYN_SENT when receiving
 some ICMP (II)
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:59=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Notes:
>
>  - A prior version of this patch in commit
>    0a8de364ff7a ("tcp: no longer abort SYN_SENT when
>    receiving some ICMP") had to be reverted.
>
>  - We found the root cause, and fixed it in prior patch
>    in the series.
>
>  - Many thanks to Dragos Tatulea !
>
> Currently, non fatal ICMP messages received on behalf
> of SYN_SENT sockets do call tcp_ld_RTO_revert()
> to implement RFC 6069, but immediately call tcp_done(),
> thus aborting the connect() attempt.
>
> This violates RFC 1122 following requirement:
>
> 4.2.3.9  ICMP Messages
> ...
>           o    Destination Unreachable -- codes 0, 1, 5
>
>                  Since these Unreachable messages indicate soft error
>                  conditions, TCP MUST NOT abort the connection, and it
>                  SHOULD make the information available to the
>                  application.
>
> This patch makes sure non 'fatal' ICMP[v6] messages do not
> abort the connection attempt.
>
> It enables RFC 6069 for SYN_SENT sockets as a result.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Tested-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Finally!!

