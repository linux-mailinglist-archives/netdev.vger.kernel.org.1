Return-Path: <netdev+bounces-117783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71194F517
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AEE1F21B47
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669C16D9B8;
	Mon, 12 Aug 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOnX5TlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3D15C127
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480828; cv=none; b=CbeNE1ngnkX+JqEPFm/ngoPDHjov06pQ/0CKBEi3UTEL2ILkuFDsrq3gCMkWkS38e9g5a6sh670ZEHBtFWTpeVpcSxeJJMit/4fcDq7hRW9MdYaRKyeqPKPHf4Tb6VZckL3wTgE5FTON8iEwIj7yghzhXinEq+DI/KmRQrXUPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480828; c=relaxed/simple;
	bh=SGek9QlRAF+/hJAjl8ub6fs3BS8o78fLtzb6s0haEsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy/KR6Yt/BM5Rdmi7f9y2i4s3QVngxcO4ZTRGedFNHSbStRC3QQcx9SN9kQLHP/E3t5SoamNhT9trm3EHVaEgQTnI4LNQZ7Zn+z53qOLQEepzhjbWk7eCPTG94qMzmFw4AsFolpCMhNXbDeUQ20RupgN/XhDmKk61tQWdeT2e48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOnX5TlN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3685a564bafso2091219f8f.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723480825; x=1724085625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/WxfHz/b6gcyEcd5GVbgkSfTi1vjOrSZQLMndw7bqQ=;
        b=nOnX5TlNtm1I5tkKX8h3cw4xldK9m2JnBJE+5iEkN0KgyiZFaOiYaDkUpJuBGHTymA
         5xc9y2mt6h6S0Ql/dPWCRbd/GOGmPqTKfKachoqNKLVrbNNNLwNeKFTYmrIRfVGRRuES
         bl8fB0VaD30V2Yz5sBLkHOgMQrOpZ9SN904hyjzwQf4pbqCNjr6uIw5eANulHPud13XY
         ajM6lrQCd+XWj3z2Va2dTG9Zakn1rPQh0IPl1/uxaOFu3VeOkW4jVxe+PPrXoWVyXcnh
         KvS118qr8twbnXpehFaYcakyNSvVd/sOpn3ddOTrtECNf4TUZmiyl0CD2ZLJi28n7wES
         lnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480825; x=1724085625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/WxfHz/b6gcyEcd5GVbgkSfTi1vjOrSZQLMndw7bqQ=;
        b=lWgMlJK8Wn+uUbXgV7aI2J8pVN09mX7clcXctgrY0nRSArhEoYKPqw+5AvM2FaL/8h
         YdArkVemk36kzA+jjEnPnTChPBK8QkRFNHTq8ATqdMR5ysJhWVim4E/Rc3+cg2SbwdG2
         tucXQ8Q9pqqPz6pwDyKQlBJYv7dzfRnuCVoqgHqrBxRl3+PdGrK5mkXr5gnGkezNoMHg
         ri+eO2f1CUxqg4afvgpuvk/K/KoN4gePG2RZxRphYxN/f2jlkM6ffra5uT5pQ8ltAkad
         GqNnl4alca1V1VZLV2Q1f2h+LF5zLKaW87bClBhrUc55lq1ERyxf03nPmJDqw+FRaJCZ
         UpUA==
X-Forwarded-Encrypted: i=1; AJvYcCVEtkxTppshr67YE0eUjUgwxxNGL6jy+F/HoBOvZpfZ6VplMInc0ARLY0pophWD3d+id5qNj5lhhhC3JFZ5p8HWsYmv7hAj
X-Gm-Message-State: AOJu0YxHh2Cgnh7cIOWO3QSSftyHSNZxUH91eAWyu/PNkje8ltJtSe1r
	IhwVB8k/uqJl1qlI3Kq06tug3BjlkksMxWB/2u0VCqQJHZAucmmFSbitu73TI1Fc5uOtaQoVWV3
	TFWjRiY2SWlEQ4cw5VEw/ty+4fytSSP52rZK5
X-Google-Smtp-Source: AGHT+IEy7y1vJZ6e8BGSxa/NkdPr9/FJbx87bLlNeiwxwVBFC9BMxSRQVRqCNFT6jzGzQYx+FnR2dfSQD9WhLCVU3tg=
X-Received: by 2002:a05:6000:45:b0:368:6f30:ddf1 with SMTP id
 ffacd0b85a97d-3716cd2ac73mr608345f8f.59.1723480824808; Mon, 12 Aug 2024
 09:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808205530.726871-1-pkaligineedi@google.com> <20240809222226.42673806@kernel.org>
In-Reply-To: <20240809222226.42673806@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Mon, 12 Aug 2024 09:40:13 -0700
Message-ID: <CAG-FcCMT+bdJg+R7rY309GbwhLTXefd3EMh07TH9yp1mz-Kt+g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] gve: Add RSS config support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, willemb@google.com, 
	jeroendb@google.com, shailend@google.com, hramamurthy@google.com, 
	jfraker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu,  8 Aug 2024 13:55:28 -0700 Praveen Kaligineedi wrote:
> > From: Ziwei Xiao <ziweixiao@google.com>
> >
> > These two patches are used to add RSS config support in GVE driver
> > between the device and ethtool.
>
> Code looks good, thanks!
>
> Unfortunately the series didn't get into patchwork.
> Could you repost?
Should we add any changes to resend the patches such as changing the
version number or add a RESEND tag in the subject line, or if it's
okay to just send the original patch series? Thank you!

