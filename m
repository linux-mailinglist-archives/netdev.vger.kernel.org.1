Return-Path: <netdev+bounces-181969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDAAA8722A
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAD23B072D
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 13:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584701C1F21;
	Sun, 13 Apr 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7W6rGwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6B1B3939;
	Sun, 13 Apr 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744551878; cv=none; b=Bf6gFz/bXlpkVerIVFw3xdvPWHxBov4UakR9N8QYUHf1+WSjBjWNRirHqB+T0AON2qiaNxAGjBOFYhX7JNo8YElOA6Yfnjcap5uAfyxXjTxFOj6g03ZoB7P5VAhUn953t54Y7dTX79yeZkMEXbctQsG+eCCJIVib6ng2CdhNRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744551878; c=relaxed/simple;
	bh=HsCKoEjoVF9X7MrpzRibSR19+9EqOrKwU2G+OPbjSCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lp6Lb6QX+giQ70JD0EIxXiexfa7v5/8Cr3oZr3MU8aYznFrkPpSyHQsKER8PuEzf8FS0R/ee0hQJCl/2GwayuPeJ28AxpxmIhcIDa9V4epaTGTJvAF/WBrwTB4JpnbT+SFU2QyQeTHvl1jz57kdNKs0JS0qiIw9EAQooVJP0mNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7W6rGwX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so587174566b.0;
        Sun, 13 Apr 2025 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744551875; x=1745156675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsCKoEjoVF9X7MrpzRibSR19+9EqOrKwU2G+OPbjSCY=;
        b=Z7W6rGwXqvbF5BJKFfJQoPDexEmxouBBv+2FJ4lXqHgBdrVXQDPr0EpbGOcPIgj9kQ
         NPNeQZqWOLseW/GwbUBLWF4Z+A9sKSONzUDKNW5n8TFn3T20/EEKK977WEI/beRMTL2P
         1Uz9vCrEefA7uLtpO7L0UzswYuTJG9LmJO3vUWHcGyd0i2BuoaQT8rjX9fmh7zUE4Y0k
         tlCjeCs0/84r5deeRkYASVVQxAPnYuwyifLsxcvMGf7HG/6Kdtf+nDWXGOUuY+vrT2FO
         X/qEszTAu8ZYh7/HNtx2h+H2bLEmdMdc3WJuTCPLSUESzl7Hq6JVHy6qf8Ke4N4AKb+q
         93TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744551875; x=1745156675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsCKoEjoVF9X7MrpzRibSR19+9EqOrKwU2G+OPbjSCY=;
        b=rklIjfnb/u4HC3bBz959VKroFGrrKhRpjvP2ylTzKlG8+0HONssufVKXTNrRdO+N8o
         oIKPJ6qi83YQ3Ot6nRVdDPihO27/GzX6hX1JGZK1ocovx4A7pNdaEw/MPQOKzSUuPytD
         frt1Zj/b3ZhA9PO2dnwUgSfu+oeXwyg5JPKMcyxCH90Iv/dNYFalOasOLtYyvtuHznSM
         AUfbp3lC2otfNiqv46PaJluWFJniCUCpYoRmj5G8uGsLFpTjFYIj2AY0lLmG42Btw4x5
         hFLDinw+mqpmtTjwiyXN9HbJOOSmfOMb20RJkkdBNF/hj639X3QehU/d9RT8nbGocbc3
         g8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUtA17k9BRtSgJ5aDv4nHdDVH0WRxQM1FSJOQf4Ichv2xJVJPQxkTGGd42fA/2nFjRlV2jOXFQ7@vger.kernel.org, AJvYcCVUJIrR707V+c+Ps/JXSz+6NYeWEv69kiOxYhvYVrj7bEpPUiG+BdAVki5NQqq4onhHqYtswbyUTzUQriM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtb0gaYbNSOTdTLDuf7/xHOrx3qmECQto0XOmeqAvTAfdfPr7
	IsfKaD+zpestzfLbx1CxThbd8AVMq09um+Cc9UqMqHHeSBsi/0Vx93mZFTdpZA9WKlw8d1sZ7lS
	BbdtuA4bc0muvtkEKeQGl9OjXmWQ=
X-Gm-Gg: ASbGncvDsCjadMLBCDP396IYZdBMZLXsBrXSKtrtOlLAA7ksfPW4QcVQDFvN0K1/0n3
	xE8enUU3sHjpqbN+m3yTGuN7y25il33Q4gp/2mNjXUhKVcMzBPBioVduaYsRDp5BnKT91N1MjpY
	PFKMFI9H3fUcKdpfo9yTPuOq0NFGsttbtrSniEgX6oJBhcXRMTPuZFA3s=
X-Google-Smtp-Source: AGHT+IGd4PWVNbEeT+ikLNUZcVHpH3WVlhScM3K17yMvZLkWZnCHwfKD0cgqo6Ai+Zx2TFUYOaiikve4HfaLmz0rYLo=
X-Received: by 2002:a17:907:86a5:b0:ac2:a5c7:7fc9 with SMTP id
 a640c23a62f3a-acad36bad65mr756541566b.51.1744551874444; Sun, 13 Apr 2025
 06:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409092446.64202-1-maimon.sagi@gmail.com> <2c779583-bac7-43fe-80db-0dc0bca2e0d2@redhat.com>
In-Reply-To: <2c779583-bac7-43fe-80db-0dc0bca2e0d2@redhat.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 13 Apr 2025 16:44:06 +0300
X-Gm-Features: ATxdqUFK0dtn6myOXIQl9f866sHwdnJt9oQrb2wi-NPksK0sKGw1t_KBsqBRWU8
Message-ID: <CAMuE1bF47TMYYZ0Fe39w=rp=p1faumdkB7ASGq53zQ3HCgyHxw@mail.gmail.com>
Subject: Re: [PATCH v1] ptp: ocp: add irig and dcf NULL-check in
 __handle_signal functions
To: Paolo Abeni <pabeni@redhat.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Paolo
Most of your notes are clear and will be fixed.
can you explain more regarding: "And you should specify the target
tree in the subj prefix"
Did you mean: net, net-next, Linux-nex?

On Thu, Apr 10, 2025 at 1:23=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/9/25 11:24 AM, Sagi Maimon wrote:
> > In __handle_signal_outputs and __handle_signal_inputs add
> > irig and dcf NULL-check
>
> You need to expand a little the commit message. Is the NULL ptr
> dereference actually possible? How? or this is just defensive programming=
?
>
> If there is a real NULL ptr dereference this need a suitable Fixes tag.
>
> And you should specify the target tree in the subj prefix.
>
> You can retain the collected ack when resubmitting.
>
> Thanks,
>
> Paolo
>

