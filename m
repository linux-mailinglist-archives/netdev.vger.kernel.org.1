Return-Path: <netdev+bounces-232611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F2C071F2
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499751C06640
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8947233373B;
	Fri, 24 Oct 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPtnvCtC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10B332EA3
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321724; cv=none; b=H+pyqWD/8nKJodVkOt0zKdqTaonj7r4evTvhQQ5itiNQ7ljx2kS6NU0VxCx1Y31DxSjpF+0JrQPmILPge6pg+bbWJ2fo2l1IX7MAoaiRCIYhMfyemXwpXUjYD0G6wvT+Y1UcSRGH1euQhaWbQ+a7ahNskeSbErMw77Twmele6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321724; c=relaxed/simple;
	bh=2TJy/wmtIjdj1zVG1S49iY/z0Gogb2d6befSBR9re64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud1SFwGNbVdvDSggZbUT7VgCTpi6EC3bJI4vY9V1yMpEY8NTWNiI6bHeD7er75m+WJq1Udu+IQ0n15HPHOujHDTAgL60SMbA0zKe8xfBqX0SAE7EnK0pXdPUpVk7bLn32rrBq60l5JW/0hQheSrxFMSkWhrFHuvt6nGxd7iKHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPtnvCtC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290b48e09a7so27848275ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761321722; x=1761926522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xM7tTJSQFOu7U5Iu9Yae5Rihy66ZaCsrXLLaOr+Jyo=;
        b=IPtnvCtCO5oLLs3RUTFkZ4ZxpTFDSpRgABfAdo05RDophRSYOURe7OB9fwSyxaO9Du
         9JOjwZq0U5J1egQ1NZrRSMA7xqnFmC6paBdyZRVsffLCQV2qAVUTsvuXPyPtlFxOfAXc
         5rP+gpi0lXs/yV9OCTaH88DF1hsJoLH2u5UUDRAZ+1Km8ck8cVkqJULlHq4ctJGVG5g5
         NKs26tNlQ8jG3pG1TsC+Dqe/n3J9zwAmqt7cLEHFpa4mxfeNaohYGSl5LGiUl/6nFIAD
         Uinnck9kACvAiwZFkdX4HaOs6wXSQCi0N/RNTHibqtKLv8NtufS4aikLaAMva8w4Re1r
         rckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761321722; x=1761926522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xM7tTJSQFOu7U5Iu9Yae5Rihy66ZaCsrXLLaOr+Jyo=;
        b=M7Yqax7Pv/HVsOQ+o92gIOfNZcNU5XzAaR3aWLkvJIbNmG/koVMfCv0Dp1lfgCexYp
         EqkawbDlJHzYLrZv4L+bQm9u1zTMY1fD0czP2aJeK1cSW1RXpZOWC/bdSgJbemhqUEQT
         4CQBKOX+ZkwPgMU7fXH6pCn4XXuL974bvYbPKDKSzgr7oCNv8ZOLTa7yFOdT7pfQrD5P
         b8kyuidQu7r+OIorZYOe7rOd3pUP0kE6vF95iANpwSFBbf1JInIJeel43Qq4wJ6fyEaU
         HHlBKn9XdXU3w56Sr7bTHVkYtsJjh1tXCqrLS5WEiCEjD3LNOE9QqFVBoXW8MhgZpn3J
         NjOg==
X-Forwarded-Encrypted: i=1; AJvYcCUMcAcQChP80nn4yhd+KLp4U/QTKDH83HOX7AsSSj/XvtI6uLbTXS6OoEcDagIaRBfO2eTC1fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1liXRlm/oCa0vRwbKPj+PjWxfJDPE1uowgofwb2CNHYl990V
	+ycR5DPvafb/BAjHarK/ZEWQTfa7uz5ghWb5wf4rK1XBSl8IvOxJ2NedF7xktySMUmL4VgK0q0p
	lmg7h380DA2t8yoaBsNhdu0iW31BXEDU=
X-Gm-Gg: ASbGncunzD1ECRDjUlYsJmr0gy7cu8+jw/HNBDl5JJ1LEOGq8yCAk+vHiODbYcUwjfR
	Qa3oU/7DcZvZLx7VmwXpKi7KsvfMKrT7falZNfK1ONb/41VqPAtg0OoLqNUNuZzXYOTxFOPkmYS
	+UbDrhnWjTwDs+DW+AT74jrcNRNSpIEJKHk0CL4W2uOVbPfhL791mgOkP7lsztmfzlce9VV7jO1
	+lj85jXF+0TRXWbmA1veBHPupuP12ak8nvzbttWcvnDTftPrBEtI2nFRlLwsuE=
X-Google-Smtp-Source: AGHT+IFgXNFHDVjsDkfldQ4dCyopGzSqbd+Nl88iTbL65LARzCjGL2DP3Gqq4IE+2wRysqTKhZNrOG4LoGmFkhGa1NA=
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id
 d9443c01a7336-290c99a9669mr358112785ad.0.1761321720729; Fri, 24 Oct 2025
 09:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com>
In-Reply-To: <20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 12:01:48 -0400
X-Gm-Features: AWmQ_bmIoJnrXxWCLQDEdYLWJrHbOfgktULY9VYiQX5d1f0lIXNqyEMWXFPiHDI
Message-ID: <CADvbK_dgLr5dUVqc=hxjj3n8wn8azkAp=K2Jr-pcuzUBk+et1Q@mail.gmail.com>
Subject: Re: [PATCH v2] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:44=E2=80=AFAM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Fix an issue detected by syzbot:
>
> KMSAN reported an uninitialized-value access in sctp_inq_pop
> BUG: KMSAN: uninit-value in sctp_inq_pop
>
> The issue is actually caused by skb trimming via sk_filter() in sctp_rcv(=
).
> In the reproducer, skb->len becomes 1 after sk_filter(), which bypassed t=
he
> original check:
>
>         if (skb->len < sizeof(struct sctphdr) + sizeof(struct sctp_chunkh=
dr) +
>                        skb_transport_offset(skb))
> To handle this safely, a new check should be performed after sk_filter().
>
> Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
> Tested-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=3Dd101e12bccd4095460e7
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks for the follow up.

