Return-Path: <netdev+bounces-94419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3F8BF6CA
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A761E1F22232
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFF2561D;
	Wed,  8 May 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYSdhQsQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73D24B21
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152322; cv=none; b=g2ifsZYCxQnlEHQ5yj7wSH9znBHgUn4kXszutVmQ503V0Jssl6+BI1Xt3lEDKNVESTnuoUprvbSleSckCnFCVs9ahaXYbMQa52tNASUm3zypISh+K7ORx2Bc83RTTDKpxIxHVMiXL5qm76ff2hLb55GZmRSk2KFuZVIGYPz42RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152322; c=relaxed/simple;
	bh=EECYBmeowsEM9QAMxkOX5cI6KMRFf+aN6TKibBIl5e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5agpWe5i38zGCIP1lbAxyve/m1Xe8XjLs2JPnzUdL5zOJmD4eikDVW1fEGS16024YgXBqTjhTRgeYD6RS5spYUuL8Ww3YHS2y/qR8lIPiNMPqq0jSYE2e2hsm530Gz1KA4rcaHs6j8RYWlIJunvmnGZA4hj9Kz2WPASZRZ8MB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYSdhQsQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso6644a12.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715152319; x=1715757119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFLnG0J+oQmKDBlznHjvioaqBMv9WOmRiyhgyzt7qjo=;
        b=xYSdhQsQYkJjTU+tgGkRL+iXgE66ekH5ij7bmgSaDs+/bGgbzqMvXg/rywuWDY3e6e
         P9Z5ASpPSCWTfREoMSfBqvvZUSoiV8MVeEFFlqzrkglpK4dyREaz328HHa3GQWF4WoJS
         B+HE7HOdxtfCs1s+UimsvDu7ojj/ySjTA4eRvqIFGdjq5LPjzovS3QeSz9UXiaCpynmF
         YLtDJJUTO5TNAZgnFFKxfvCd6glvHqd40H/xvUBDA0BHdI6msGrRaWzIzfYMWHvyKhl7
         ET5qpatpx311bgi2gNP/0qXrNsVAhtycCDGQJT2q6iBdItrLF9xWZKLcO2iAfj67ViRA
         YqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715152319; x=1715757119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFLnG0J+oQmKDBlznHjvioaqBMv9WOmRiyhgyzt7qjo=;
        b=J3bm79NOlBs5OqcnTtT0VpzqwyTAk9H/G9+6RzKhXzmbOYxs1UjKLhLsw2paCyT6vL
         J7FQ7VS3Go8O0IekTWT93Zy0NPeEmcJc1bVNE+OXSEbTvCF661ifhUCjZWjeXCnISN0i
         0P+AOtrf1MWadrOF8BOyrEZNOVpRSm3NLfPpk7G0ZYdTsCIxvYxgHiNf3tLoRopwhZiw
         qAuBS0qAxmaAPMJ8Yx+wZ99HXMfre5slAk3GutY40ZzxkVnoPdpO+b7D7OcIQpyTP6U5
         5M6ZUVw6TNcwWEwqbH+/D/bcbOn1gYhB2JwUK/0c/cMfDX0xzO7KTo3SbVyGpJySRY0K
         GZCw==
X-Forwarded-Encrypted: i=1; AJvYcCUOKxrQ8AJbDxTn88pJqaClCYim0xT0eV/x7wWaQ7C4GxK8lAzMiwI8LZYY3HyfLPR8QKyId10O7FaZ/49t1UKbhoGdD913
X-Gm-Message-State: AOJu0YxKRq/64BEQyPS5z79XhxUF+BMqRxkFCvRoPlizsy8pB4RgcNLr
	U6QviuETAlc/2JfIST4g/YNMxAcQRkFPs4QmPdeMVRe5u5ZbghVYKA7gzy3OUNX/jn1feBQATUv
	0f//9mo2oCIk2D0XNePkORXBMwRCee3119I/A
X-Google-Smtp-Source: AGHT+IGKV7NntvnZda0g7YDQmt1Qa4mft2JhpTkWD4H+su1I/KgJp1e9S4NzCDRnvXRjYxfMB4RL0SfLCVgVr0lTrlU=
X-Received: by 2002:a05:6402:348b:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-57321028182mr90182a12.3.1715152318344; Wed, 08 May 2024
 00:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506142835.3665037-1-edumazet@google.com> <20240507174151.477792ac@kernel.org>
In-Reply-To: <20240507174151.477792ac@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 May 2024 09:11:44 +0200
Message-ID: <CANn89iKG4XE448P-AjQKkoK9kJkdBCXMP244biHbcrSA_zDmKQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: usb: smsc95xx: stop lying about skb->truesize
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Steve Glendinning <steve.glendinning@shawell.net>, 
	UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 2:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  6 May 2024 14:28:35 +0000 Eric Dumazet wrote:
> > -                     ax_skb->len =3D size;
> > -                     ax_skb->data =3D packet;
> > -                     skb_set_tail_pointer(ax_skb, size);
> > +                     skb_put(ax_skb, size - 4);
> > +                     memcpy(ax_skb->data, packet, size - 4);
> >
> >                       if (dev->net->features & NETIF_F_RXCSUM)
> >                               smsc95xx_rx_csum_offload(ax_skb);
> > -                     skb_trim(ax_skb, ax_skb->len - 4); /* remove fcs =
*/
> > -                     ax_skb->truesize =3D size + sizeof(struct sk_buff=
);
>
> I think this one's off:
>
> static void smsc95xx_rx_csum_offload(struct sk_buff *skb)
> {
>      skb->csum =3D *(u16 *)(skb_tail_pointer(skb) - 2);
>      skb->ip_summed =3D CHECKSUM_COMPLETE;
>      skb_trim(skb, skb->len - 2);
> }

Good catch, I will revise this patch accordingly, thanks !

