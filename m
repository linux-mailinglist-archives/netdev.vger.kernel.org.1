Return-Path: <netdev+bounces-188469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2EDAACEBA
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542413A9BB4
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD9721323C;
	Tue,  6 May 2025 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6a8Vgtt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52212063E7
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746562506; cv=none; b=gWdGQ4yJaNK05KpyTXxTOlqKWZ9TXPCtu7nuEXLDXuDA3Eq8JukVIywv93QdZ/6u7CzY1791/Boz2+VZHSU8W+/upd3lt37bOn/BPFcMsi6MKjP1HnSmeI7Ie7Hj/fHvk/T9mNzi8aJhP6itH3wCx1yUHw4g+GZN9PK05Eg5ja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746562506; c=relaxed/simple;
	bh=DhcXJ2vMtdc2RGN+DqfwOgdHRRVKmrc0Q4P6cwdQuPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKjo6AYQTk49M4kwmIW2dKV/gxS55kAtutorYn5NK3JYPFmALBxCN7at+mak9UpjGfu+ekc7E0smKBwI+dQEgMGxhWaGbvCUhvF4ryTKKn8vbNNGQ81pgpTDrqR9YhmFh+qdWsctBTeuz23wAY2HZCKYuxVZXaYWA5XiL4IYacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6a8Vgtt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-440685d6afcso53958255e9.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 13:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746562503; x=1747167303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5zjeqhKK59gbiwXpAzdFd4gYJHmtBIMy8mAqntCbMA=;
        b=a6a8Vgttq+XigCsuqhNaP5MUReA5HO046YamVLhE8mUARrpCwLchhR1hxU+nRfFPDP
         OFtK8y5QE09UjyQ1ikfbt4eLzsAPu0Y94c3uthfjNS7VJZg+dZwEx6SdGNVhgY7VTDNn
         yKD9gt27WZt0SyLAlSTF125XxAbl0mo3DG/4pJFQl65pJnyMkaf7lkbHLn868CWRkJqe
         O5qQzTLos1Y5u2C7fI+MLz/3dblolCDPvOV4hIeMyYKXY5K6Z4dFXr8ti/iJtWI1/v01
         j2hBGFeEQB3WV8qis+b248HJJlUOoT8nTdSNdM1riLe9MCnXWnqZNn2P5IoOBJPlgmO6
         uI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746562503; x=1747167303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5zjeqhKK59gbiwXpAzdFd4gYJHmtBIMy8mAqntCbMA=;
        b=O+NB70KWO35mSUGZ+bb6KzJ4n+DmmKJS/JTUDlr7hrayq9Q37C+V8KZ6ChZvF/3f82
         r+RhQbvS7IGsb8L2yEdY9Jh1CPpKTvET8tbfrJT9LUiBg7YP3q9xmlnbpnrk6oNIrTzU
         bhv/8h1JBcCNvluxxV4aQG6kaYLXGgHx9ga78tIVUmJUhwqayy+qAf8wD+FrSytk/HYx
         S0junElXJB//h37TU84DYP3k8c7UrQOT769LOTNpyePSJmvV64NRWDqdVYYOeo3aOKna
         /YnwI22+/dNpWftnFYiXIyLyluEJ9PSgPBQgk/WY8xEVtHnYs57zE3buOqKbHVxUPlxx
         zw0A==
X-Gm-Message-State: AOJu0YyVYn3BSOsDx1H1SKl5NDo/GLYD0m1bvZJK7x667L87mXDfCfie
	LYkb37N54y/3NYgkPA3iWkUlH8jhhenmldbKGZq1k6z2iFFJ0Wj9EG2dxYUxxLAviQ6JeX7O6cM
	vY1tlgK8J8pGGhdktuPxnv1YYB+k=
X-Gm-Gg: ASbGncuUBIBU8sZWuT8DMOPWiLgVTXNJvQFFpFvB+Gruh16Ogx7PZgZRDE01Yhu1Azb
	aj9+fcU/PXgNeW7z7kwwsHm+mBmOkkeM5YRBgFlQyOQqw2qY7cpZmKo+3E2iO1de4DCb9ZOcSdq
	Vv3Me7zNst0qHoJMInaHfhtpWzchgEXgJxu3Bc7AwtteWeN5aJ8a1uikY=
X-Google-Smtp-Source: AGHT+IHBiJt8BYwOfNrfUchLd/VkvU5ri/Bp2YEXKAjbHT/ccpXtjDJi35I/m4eWa73/G3Tiu0NGrp9nKOPeDG92AyE=
X-Received: by 2002:a05:6000:2207:b0:3a0:8ac6:d5b8 with SMTP id
 ffacd0b85a97d-3a0b4a6fa81mr606273f8f.53.1746562502937; Tue, 06 May 2025
 13:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654721876.499179.9839651602256668493.stgit@ahduyck-xeon-server.home.arpa> <ffb6bdbb-64f6-4be2-984e-3c8be185f62c@intel.com>
In-Reply-To: <ffb6bdbb-64f6-4be2-984e-3c8be185f62c@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 May 2025 13:14:26 -0700
X-Gm-Features: ATxdqUHlvt8tgneAQMWN8_g_n0_4bBy0iVsjL8QUs6E3KOnPPhdrco4oyBiVIxw
Message-ID: <CAKgT0Uf=ykmYjxywZzQ3f1RhveSTA1_s-8-GpevcGWV37gr5PA@mail.gmail.com>
Subject: Re: [net PATCH v2 7/8] fbnic: Pull fbnic_fw_xmit_cap_msg use out of
 interrupt context
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 11:57=E2=80=AFAM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 5/6/2025 9:00 AM, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > This change pulls the call to fbnic_fw_xmit_cap_msg out of
> > fbnic_mbx_init_desc_ring and instead places it in the polling function =
for
> > getting the Tx ready. Doing that we can avoid the potential issue with =
an
> > interrupt coming in later from the firmware that causes it to get fired=
 in
> > interrupt context.
> >
> > Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of=
 our presence")
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
>
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
> > @@ -393,15 +375,6 @@ static void fbnic_mbx_init_desc_ring(struct fbnic_=
dev *fbd, int mbx_idx)
> >               /* Enable DMA reads from the device */
> >               wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
> >                    FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
> > -
> > -             /* Force version to 1 if we successfully requested an upd=
ate
> > -              * from the firmware. This should be overwritten once we =
get
> > -              * the actual version from the firmware in the capabiliti=
es
> > -              * request message.
> > -              */
> > -             if (!fbnic_fw_xmit_cap_msg(fbd) &&
> > -                 !fbd->fw_cap.running.mgmt.version)
> > -                     fbd->fw_cap.running.mgmt.version =3D 1;
>
> ...
>
> >
> > +     /* Request an update from the firmware. This should overwrite
> > +      * mgmt.version once we get the actual version from the firmware
> > +      * in the capabilities request message.
> > +      */
> > +     err =3D fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_R=
EQ);
> > +     if (err)
> > +             goto clean_mbx;
> > +
> > +     /* Use "1" to indicate we entered the state waiting for a respons=
e */
> > +     fbd->fw_cap.running.mgmt.version =3D 1;
> > +
>
> Curious about the comment rewording here. I guess the extra information
> about forcing and the value being updated to the actual version later
> isn't as relevant in the new location?

Well the "force" wasn't really the correct wording to begin with. It
wasn't as if we were really forcing anything, and really we should
have been resetting the management version every time we restarted the
mailbox anyway since it is possible for the FW to reboot into a newer
or older version after we have flashed the device.

All we were doing is using a non-zero version to indicate that the
mailbox woke up, was sent a capabilities request, but didn't send a
capability response. We use it for debugging as we can identify cases
where the FW is there, but doesn't respond to the capabilities
request, or it sends back a malformed capabilities response.

