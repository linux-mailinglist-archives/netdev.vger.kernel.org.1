Return-Path: <netdev+bounces-197945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B938CADA7B4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 07:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82837A461F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4436515A86B;
	Mon, 16 Jun 2025 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfZkF65t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F82E11C1
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052064; cv=none; b=djhr9wgRMKkXv5jw4UGpo00yB6nqwIs/9qnK75HZy/t13qXocMriVilKYYE/PysJZoQSYPdUMSRpmJmt9A1OnF/q4IEn3TsbPgEE0ou6i3N6E/PHP8gSlI4tw8opHnvPj+rPPVoxKq/e/ttxpWRra54cnkEhQrMio/ce3jCyTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052064; c=relaxed/simple;
	bh=xfNJTgN9TCVMW6n31UDUcTok0Hdz7AP7jf9CRclJCFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIAyrNcrh/ZcxH/bP6Fdy5qjsxNiEXIbTc9aCIz5YAEGb+xFjZiOI0ympjDd6F88mPRTu+oIEipcgQobGOyccTLCreGdzQ8hgNehEuwtFPAV7V2EwhM0mLPX/dFdOKRAwU16flGqHgCm+Kprtr9bbRNNfjISnknZmnpKvAkRqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfZkF65t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750052060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CBjMVseHPazdD7nsVj7nsvjyAW5v2qbrVd83qIb1EM=;
	b=gfZkF65tgakmHhDMdc6odY26Bz/JWp0nwYOskkta1xxJdWzwZBQolRY8GAC7RbB4ot1lhK
	pXZXNi8loFodFac404r49UtjNp9RRRVmJw8gI0WTwdAU3F1oAqYC66C7EU1n8Kcae771JM
	qDtQrvDDAW6VAzSNVfldwBy1WSHKffA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-t9hZb38uNKmXlmXdh7ScDw-1; Mon, 16 Jun 2025 01:34:19 -0400
X-MC-Unique: t9hZb38uNKmXlmXdh7ScDw-1
X-Mimecast-MFC-AGG-ID: t9hZb38uNKmXlmXdh7ScDw_1750052058
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b1442e039eeso2502233a12.0
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 22:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750052058; x=1750656858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CBjMVseHPazdD7nsVj7nsvjyAW5v2qbrVd83qIb1EM=;
        b=omBf/EyqDJo1BukQKIS//V8fIYHt0JFO0JsWrV1Wqesi8NGmW5qiddhIcBGz9jwSOw
         azMuSKJTjpxhs0Mll2EZOp+zy2smFz7V/9LXioETSgnARw838WqjBUs0uFA6ElmgV53l
         ExMBAF8CqJUpkHtzPu5/fKb1d87QNNnfnSVT62vyL1lymkLqgsq6BLk2dCF5lTLFRHiD
         sTfbAVXEfNU/tLGqx958hyEHDrYNLGVtVbtANAjX544gpO619rYOXOScrqLoLpSynK0J
         m2621nTPIk31jWsIVNBBO4ShLrPz56fPGQ8gpjDMa5JM5Nx5YRXS4dAwEllYQgeyzXPH
         ohVg==
X-Gm-Message-State: AOJu0YzLSBainAQ/bUkJxWcFhpgZBCcdx/WAdX8lmwS2WTo1neOMPqlG
	P7f1ph1BaRDPx7JdKNqfLztfFUcuwV54PgoB2ADPJJ8IeT6TIlrq1+Csbj+gUFHHsFA64kDxR9W
	RoSdVIuGSwi0axxzu7ry2Jx7kwa8Cd35mB46KqiIw3QggBsb8Ex+trCTpWuERJwiBYPVpcvHV0L
	fEILQ9OelKYcJab4C3Y4fzig4ApajI75aj
X-Gm-Gg: ASbGncuE1ZDZAopsJLlEdyY1rFw9ZvMJPJcp30iwrCaseFC9f1mP2GB/WGO1KpUxKIz
	IW2JgOwIVyb3NT8V3j8+XPUF6l9txMc3aGTTxeaqkpTmMN6O+oJ+NhYzlV4iMU5qeQHFzYrfjev
	ejog==
X-Received: by 2002:a05:6a20:7287:b0:216:1ea0:a512 with SMTP id adf61e73a8af0-21fbd7f9364mr11757189637.38.1750052057895;
        Sun, 15 Jun 2025 22:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI0Ns9agvuk9A2FBajJhBx55VqIHpcqEKH7wf9vC83YXOkKf0yfvwqi7kwWT4LmHQ9XTpkAdtWiTku5a6Sn9Y=
X-Received: by 2002:a05:6a20:7287:b0:216:1ea0:a512 with SMTP id
 adf61e73a8af0-21fbd7f9364mr11757154637.38.1750052057524; Sun, 15 Jun 2025
 22:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
 <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com> <3da348e2-9404-4c6f-8b94-1c831ff7e6f9@redhat.com>
In-Reply-To: <3da348e2-9404-4c6f-8b94-1c831ff7e6f9@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Jun 2025 13:34:05 +0800
X-Gm-Features: AX0GCFuqPsB177cV9IA_WOSqrUZvhAHtkJp8389wrLX86jq4IYeO3Kj0PPpfpHU
Message-ID: <CACGkMEs9HLYakHZiJbvTv=nWnVhCzPwywh-nB95tTCyAZ65zZQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 4:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/12/25 6:55 AM, Jason Wang wrote:
> > On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> >> index 287cdc81c939..79d53c7a1ebd 100644
> >> --- a/include/uapi/linux/if_tun.h
> >> +++ b/include/uapi/linux/if_tun.h
> >> @@ -93,6 +93,15 @@
> >>  #define TUN_F_USO4     0x20    /* I can handle USO for IPv4 packets *=
/
> >>  #define TUN_F_USO6     0x40    /* I can handle USO for IPv6 packets *=
/
> >>
> >> +/* I can handle TSO/USO for UDP tunneled packets */
> >> +#define TUN_F_UDP_TUNNEL_GSO           0x080
> >> +
> >> +/*
> >> + * I can handle TSO/USO for UDP tunneled packets requiring csum offlo=
ad for
> >> + * the outer header
> >> + */
> >> +#define TUN_F_UDP_TUNNEL_GSO_CSUM      0x100
> >> +
> >
> > Any reason we don't choose to use 0x40 and 0x60?
>
> I just noticed I forgot to answer this one, I'm sorry.
>
> 0x40 is already in use (for TUN_F_USO6, as you can see above), and 0x60
> is a bitmask, not a single bit. I used the lowest available free bits.

You are right.

Thanks

>
> /P
>


