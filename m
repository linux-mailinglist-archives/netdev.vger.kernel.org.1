Return-Path: <netdev+bounces-117667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5294EB87
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED4FB222F2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248A170A31;
	Mon, 12 Aug 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFczgtmU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB1170A0A;
	Mon, 12 Aug 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460135; cv=none; b=eNh1wmdWdmGl2TXLRfLhBjATcv10gaSNmkFZzipY8gme81iZtiD8W1f9XphScNisqttBB2GaOPPOcjWJE4qFKJJCr6tnDrBHmGkby1ggDzwrrEGjTluUrZ9Di/ymGRDnkkScLMdgKSzp/4HP1PUMriTXgsr8EEvry/1Qz3a12iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460135; c=relaxed/simple;
	bh=9Gjh8wrH7LLHsrpmI1U+ZYZ/g/67UkGmtuDBq9at/5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcZfGSbxXurspQ5WTnyQ1nWevkJIVhJX8cU4PbMkQn5H3/n6cOoGyXT6y0LUVEkvwh3dTyO/FBJmzgkceriUnqKDb9Kue8Txueu+8Q54fmxiLgYVWePD81c60nsglOb1cBmN5y+RMwjNNVWpME/J2DwKsnT+xGkALZIkiufore0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFczgtmU; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5c7f23f22so2432796eaf.0;
        Mon, 12 Aug 2024 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723460133; x=1724064933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPaRmh24QV5ReZsiiXuFKq2S39iqLXRWYwV4MINhh0g=;
        b=QFczgtmUO0wUsrHi3t4uPRJIYtjYLD912Ri4c+ni91SfTWWPu5AlZ9KF7IR9hTyDlm
         AgdBCUXZa5EMHxcH0wzcadhbABoor9l69umph8j+YvQEPnLdBaQyCAeDd0OyPZzJfp90
         HRC9qXl1xOPKxZkRGmDvR2rivhPYD5tqwMBCFbF2zGNpA6zMZKcJIQe1Q2V/tHuOkSpL
         AxucVcPkehJrgWxmWZXVk8Cj7oLy3XBV9vQowB5mZ/XycwLlmuzUvIxKMsYE/UGoKFa0
         004yOT3FK0zMD4f2GDRFGLj9jZrEwXhuj4NTfsjg4XpaQD1KHwwL+jRsKCscwcxrL9J9
         ROeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723460133; x=1724064933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPaRmh24QV5ReZsiiXuFKq2S39iqLXRWYwV4MINhh0g=;
        b=Snk6SwkcrjuFbeue/MibVQEIZ4gs8gjpNf0olFg4WjK9SEDQ5YqpMoma6RXBKVSKi+
         Rro5zdrXvMqcp4cxEp7LCEA/VDXXoGbj2sTw0FaHF6PoDUGJk03S+2cK7sQjxR7hX3hV
         zvOQTdVQDpeJYXCv6bVfdME6mnvVWWCFIFKne0vvmUd2qJmDSFwnvV2VJIwqz8iYvbnl
         h8tZxBcVtLgHrg7g2Khw7K2AmFLCdKICLOlrK0+02KbrlNktp1ZuvjcT8+MZo0vdnHqJ
         D5Q9N7eM3mzPf0Gyf2goeloeE7l2Zf5oM6LeAbu1pS4QRDOp1Nw5YBkq6OkJDSJtEK3M
         9g4A==
X-Forwarded-Encrypted: i=1; AJvYcCWeBbAJa4ZqzOV/1fRr2xPxCUxIOx304VsL4T8+CugHXwK1rT8igE/59WvCMKmOwXThTm4fiDwI0K2+xwqwi2+RP9/djyb6ydcS+eDY1P0ZLC6IgJvFrCyBVCEVGbp2C+nGGX0LE3rJX2rwV0Hnl5jimu7ozRf08fXvgdk5tMEgwg==
X-Gm-Message-State: AOJu0Yxe3OkwE7Z/0VlO1bDtZ+Llbmf1xjkaftK6/FP5YYvnPumsjoJO
	9Z0HaMRHlfbQ8C8NGi8UysEGRZOgarnSbCFlv46XiKIXXiSxutrkorNfwiyJQiuTXpjyyfCz9jf
	K2UGRma7TBhGIEb4IHXxgeeyOVBc=
X-Google-Smtp-Source: AGHT+IHiSMX3J6K0nI+hNnKPWUmqIsJ0s8DFVtdCGHHR49eP9W5PwH3rX+befgLK9IE9xf0ht3t4nlcSbeueqkPJgt4=
X-Received: by 2002:a05:6820:1b94:b0:5d6:10e1:9523 with SMTP id
 006d021491bc7-5d867dc089emr9011875eaf.3.1723460133056; Mon, 12 Aug 2024
 03:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812084945.578993-1-vtpieter@gmail.com> <20240812084945.578993-6-vtpieter@gmail.com>
 <e93d13b451a263470e93706faa3afbfe2b5cd57b.camel@microchip.com>
In-Reply-To: <e93d13b451a263470e93706faa3afbfe2b5cd57b.camel@microchip.com>
From: Pieter <vtpieter@gmail.com>
Date: Mon, 12 Aug 2024 12:55:21 +0200
Message-ID: <CAHvy4Aq8G2vLzFCCRRQV5kCD4jp8oYW+c=m_foyHXKoeiCod5A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/5] net: dsa: microchip: apply KSZ87xx family
 fixes wrt datasheet
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	linux@armlinux.org.uk, conor+dt@kernel.org, Woojung.Huh@microchip.com, 
	robh@kernel.org, krzk+dt@kernel.org, f.fainelli@gmail.com, kuba@kernel.org, 
	UNGLinuxDriver@microchip.com, marex@denx.de, edumazet@google.com, 
	pabeni@redhat.com, pieter.van.trappen@cern.ch, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arun,

> @@ -141,7 +141,7 @@ static struct sk_buff *ksz8795_rcv(struct sk_buff
> > *skb, struct net_device *dev)
> >  {
> >         u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
> >
> > -       return ksz_common_rcv(skb, dev, tag[0] & 7,
> > KSZ_EGRESS_TAG_LEN);
> > +       return ksz_common_rcv(skb, dev, tag[0] & 3,
> > KSZ_EGRESS_TAG_LEN);
> >  }
>
> This change can be separate patch. since it is not related to
> ksz87xx_dev_ops structure. Is it a fix or just good to have one. If it
> is a fix then it should be point to net tree.
>

It's a fix wrt to datasheet but in reality I can see from tests with
a KSZ8794 that bit 2 is always 0 so the bug doesn't manifest itself.

Please advise, keep it in net-next or make a separate patch for the
net tree?

