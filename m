Return-Path: <netdev+bounces-169800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54CFA45BF3
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12E43A24CF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C8A258CE0;
	Wed, 26 Feb 2025 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exehSgUe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474B258CED
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566243; cv=none; b=E68bb0HDc9J18+NfuEVuHW1x6mcyOO08+w2aDbostwduUZ+6F+wexdbdMIIKY6UF6lvQKHbo7jT2C7BzplsRTyilKZuTuux1TgwYLwXLUku8h2brJrPEE5llZM1SZajgOhUUhPD5TN+KVjY/kBy8MlQSPWoKf617tDtKc9KaPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566243; c=relaxed/simple;
	bh=E3LUXMdZDIrACggr5FFlBCIWHNN2PhuC1SFdQdUfTUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjN91AEVnuFFxK55tCaARiH4rqFkzy45u+EF4CCui5CZDooHrgaTmn+cLXhAQ+8/CwJZweijDandDu5wNrpLIzPU0M8p4Pdi9Lq8xCTaZNLGJjW6OJdirBB+0+mlm7l2GmV632YjYWshNe5D5ersilkkyT4dMlWo8gUlzD7QCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exehSgUe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso11674977a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740566240; x=1741171040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds8UjuCZuBlulW9r5ClgMCR8lsBoFVIVrc+5O+sGChY=;
        b=exehSgUe6LzZvBBosPKjK1xxUoIY189vskNFq14Wk1qXWbVMlPWob97GHga6xwQhEG
         xWMryidtSXzOCaGGN8gUhLKhtsfjDvxaHYE4Kq96XURPHUZcsgysxGEjBlTMTePGvVN5
         tw4Sk9wZw9mwN0hi4w3wvoyXy4CK4BPh0v47x1PDc9v2hqrd8XcYn8T7T+4USdV7532b
         G7IE7Feww+m//P/qaCT4G13EfgkKTYuSJHbBGrSvndxbwov+sJ7N4l41NpHd7a20p77S
         efT+OdvvfK6mmL307cuRHu1h3y6rzwR5p+mWNxujYuzuBvnWGN9A/3bCXESlcXxr+0B0
         I0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566240; x=1741171040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds8UjuCZuBlulW9r5ClgMCR8lsBoFVIVrc+5O+sGChY=;
        b=nMfMATCdYaFlXVPXdGQC7ciPB8NfdueCt1ucC7RInpBZAiowc+JPFr3ULtfPF6x1CL
         6UOIRTe4DPqZdOmrtwr/wpSjCJwB8NoSrphx9XbroSlN4EO0/TBg30qi59L1ahTa16P5
         1tHVcDgWjc5F+68uAJCakBjNqoe63CyxDKcDvvL5Yy4NG/6bgvk9Km6jDbDSt0wppuKk
         6EK2KkFB/Ku75Ns5Pr9TWgImAr7d9nUWRRF//886FukLTMEEDzjA2AycYH148CU9A0sE
         F2kRL7eiiOGaIyzILXZoIiRRGXHYjhQwBBhkg0Sc3M0vYUbtktg1fB9x8kKZmyISvS1j
         ZBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhS/kMx3+jqWgIJe2nLb1Mrq6Y23BRKoukTadDEmiU6N+3f4dczT4XlqJgQjeSlX2ug36vUP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sB0wD1OozMAd9NXSHZx0j8nd/dS8PRTZeTou2fc0d8r9sEMZ
	zHi55jJhGK4y8ycWUjarw5uVfQPFhPwGK1Rm6Jjh5xTOdoAPp3jGzE/z62QnbAi9w6lGsIrREYR
	g/Ct10qZyFAAGfSs5slZ5joS8sUASADR3wohh
X-Gm-Gg: ASbGncv1CM4L6pFi6QJQ/AD/OPUtArcGUqL8upu0gcn/xaL4GID9UdQFqnpKBPheVem
	L+XST52DBxSVj/sxv8usbsm2qcRm8E4oaSq3kH3mAhB+BZ+oAIl9K1Y349QpQqKzV59W8GOvgiB
	FWCJgYp3E=
X-Google-Smtp-Source: AGHT+IHDsRxL99QAE13fvzV0xbVniboWDx9NEbKPvcjBleKGRqyad3yJ//mHmW8GntF8lvzCgRiJabRNQtGvDuruUas=
X-Received: by 2002:a05:6402:280d:b0:5dc:7725:a0c7 with SMTP id
 4fb4d7f45d1cf-5e44448139dmr7392030a12.3.1740566239995; Wed, 26 Feb 2025
 02:37:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225211023.96448-1-kuniyu@amazon.com>
In-Reply-To: <20250225211023.96448-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 11:37:08 +0100
X-Gm-Features: AQ5f1JphxbiWBi_IN8J1OxH1TbBMBpRZyQP1sdwEQaTDtnWIH5AnuGApFeXWpTA
Message-ID: <CANn89iLKeu=fQAyo=jPudR5MQ0ay901xhG+rG=4MWw0fpcDN=Q@mail.gmail.com>
Subject: Re: [PATCH v1 net] net: Use rtnl_net_dev_lock() in register_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> Breno Leitao reported the splat below. [0]
>
> Commit 65161fb544aa ("net: Fix dev_net(dev) race in
> unregister_netdevice_notifier_dev_net().") added the
> DEBUG_NET_WARN_ON_ONCE(), assuming that the netdev is not
> registered before register_netdevice_notifier_dev_net().
>
> But the assumption was simply wrong.
>
> Let's use rtnl_net_dev_lock() in register_netdevice_notifier_dev_net().
>
> [0]:
> WARNING: CPU: 25 PID: 849 at net/core/dev.c:2150 register_netdevice_notif=
ier_dev_net (net/core/dev.c:2150)
>  <TASK>
>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

