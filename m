Return-Path: <netdev+bounces-128401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0027B97971E
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72F6281F19
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6FB1C6F75;
	Sun, 15 Sep 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b="E3Cqre1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14F1C689D
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410595; cv=none; b=Lr1R2y0GDDrESRZ1ZXjarBvA8ZugAzrOncnnFiTOgeCcFu3aqj8/K8veHrQmkt60g3uRLWZzXOwQhIlsQ7Tfpu7c46dylUTZP0+qBgJRt7HS96d1swxAuyXiuX7Fvayn1/ZD7uvKc7i4fVQ4ut0R1bzczW4lVY34M3oDq/T1o6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410595; c=relaxed/simple;
	bh=fDwZmtc//P2Q2CdWV3iL8VGYYtZ7Lfy4KE3dIScwPWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6JFfUaUEukZ6MXERKd1Upqr04x4Oq7HxBNSYNC3a+0nU/oYFOtEEyk7h1NNML4H6OTn8qfi4zpon7lPjfHwktzQb5Zx476liNpN57sNvUeYKY+CdnX8tyZDK2nwqO5q9YP8pgkrR+SGlp0PLYZnQMYdggWpw1j1acQzmA92gu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b=E3Cqre1y; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-70b2421471aso1501866a12.0
        for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qrator.net; s=google; t=1726410593; x=1727015393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiN1biVjfblfJCNoQE1Fqe/UWwPtym8JKqZfHUuB314=;
        b=E3Cqre1yODiQc1glrsFIamYw5clN7O4XJTuNIwr1eZ7z9oU0dYxGv9Ip84rjdEw1g/
         X1ZbL2GJzyCXofP73mYXd8WAn6ndIhVYff8K4vuE91l7vKWYbHIE1OGVHL/a0Nv62EOs
         4HxzQO7HVHS43AjCIGXXVjUR3PW4ClBOor6H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410593; x=1727015393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiN1biVjfblfJCNoQE1Fqe/UWwPtym8JKqZfHUuB314=;
        b=pdYhsz15DMUsn4LYgNrn0iaRj0omn9DBVBaKQUytQCziZGWA5WHrS2Bsjyvu4fbPbh
         /fai+Rkmsf2kQyRZZX0pvkHWb34YLYZEG30rHYG4Uan8xi4pQawPxspz3ULG8e3TrSQK
         rHtEIwUqZqVk5dFy23TERnEM3wcZjiNSckyhtCjclrhugyHvj1RiLRMVO0kqJ61t6czW
         bc+Qd4jDwiNiZ7Bd5ovMn8czkHwEeI+IbIe4ZqHnMYT4iXN74+CucSUqAxZ38kmVSJRm
         44TxEcU5KXtpNcxO9uXrsTc35seUuU/WC/4gJ8FC8Outrhnni9NtdMhOMdYYLeU5M7NE
         HV9g==
X-Forwarded-Encrypted: i=1; AJvYcCVmuYsrhtz8+O5ZMX5Eb6cypinkIEdopeyxIOWzaLlFZqT6dH2ET6dlDaCLVZpqREh0ZryhbJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu7NdEWN+hQzqeoBZ0aj6NiHQP4rc5ai+TT/w1QqPCov4Ysw19
	qdESIRH/wrOMEuxalWeuen8Onk92hCWku0deh0svEQHTQ4VnzbJftJc1/+y0pdpEBGzs9OQjvt3
	CJAZ4Ene3v34dcCem4j5UV/GodaC3QZSUe4EVLA==
X-Google-Smtp-Source: AGHT+IEmTfcSy2BdcoIbFnHj7Jr0iZmswWCzXnNS3Vc74mJiumfaNvb3/VQsIXzgYHEgrmdiu+CwlJ2gQc7qP9zyBkE=
X-Received: by 2002:a17:90b:1806:b0:2d8:f12f:6bed with SMTP id
 98e67ed59e1d1-2dbb9dc122emr11056192a91.3.1726410593238; Sun, 15 Sep 2024
 07:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622164013.24488-2-green@qrator.net> <Zncwl4DAwTQL0YDl@gallifrey>
In-Reply-To: <Zncwl4DAwTQL0YDl@gallifrey>
From: Alexander Zubkov <green@qrator.net>
Date: Sun, 15 Sep 2024 16:29:26 +0200
Message-ID: <CABr+u0b-RAV9hz25O5a3Axz6s9vYLVc5shr8xAgPsykP_XRFgw@mail.gmail.com>
Subject: Re: [PATCH] Fix misspelling of "accept*"
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	linux-newbie@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I just wanted to kindly check in on the status of my patch. Please let
me know if any further action is needed from my side.

Thanks for your time!

Best regards,
Alexander Zubkov

On Sat, Jun 22, 2024 at 10:14=E2=80=AFPM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> * Alexander Zubkov (green@qrator.net) wrote:
> > Several files have "accept*" misspelled as "accpet*" in the comments.
> > Fix all such occurrences.
> >
> > Signed-off-by: Alexander Zubkov <green@qrator.net>
>
> Reviewed-by: Dr. David Alan Gilbert <linux@treblig.org>
>
> hmm, should probably cc in some maintainers, I guess networking.
> (added netdev and Paolo)
>
> Dave
>
> > ---
> >  drivers/infiniband/hw/irdma/cm.c                              | 2 +-
> >  drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c | 4 ++--
> >  drivers/net/ethernet/natsemi/ns83820.c                        | 2 +-
> >  include/uapi/linux/udp.h                                      | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/i=
rdma/cm.c
> > index 36bb7e5ce..ce8d821bd 100644
> > --- a/drivers/infiniband/hw/irdma/cm.c
> > +++ b/drivers/infiniband/hw/irdma/cm.c
> > @@ -3631,7 +3631,7 @@ void irdma_free_lsmm_rsrc(struct irdma_qp *iwqp)
> >  /**
> >   * irdma_accept - registered call for connection to be accepted
> >   * @cm_id: cm information for passive connection
> > - * @conn_param: accpet parameters
> > + * @conn_param: accept parameters
> >   */
> >  int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn=
_param)
> >  {
> > diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_mai=
n.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> > index 455a54708..96fd31d75 100644
> > --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> > +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> > @@ -342,8 +342,8 @@ static struct sk_buff *copy_gl_to_skb_pkt(const str=
uct pkt_gl *gl,
> >  {
> >       struct sk_buff *skb;
> >
> > -     /* Allocate space for cpl_pass_accpet_req which will be synthesiz=
ed by
> > -      * driver. Once driver synthesizes cpl_pass_accpet_req the skb wi=
ll go
> > +     /* Allocate space for cpl_pass_accept_req which will be synthesiz=
ed by
> > +      * driver. Once driver synthesizes cpl_pass_accept_req the skb wi=
ll go
> >        * through the regular cpl_pass_accept_req processing in TOM.
> >        */
> >       skb =3D alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req=
)
> > diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ether=
net/natsemi/ns83820.c
> > index 998586872..bea969dfa 100644
> > --- a/drivers/net/ethernet/natsemi/ns83820.c
> > +++ b/drivers/net/ethernet/natsemi/ns83820.c
> > @@ -2090,7 +2090,7 @@ static int ns83820_init_one(struct pci_dev *pci_d=
ev,
> >        */
> >       /* Ramit : 1024 DMA is not a good idea, it ends up banging
> >        * some DELL and COMPAQ SMP systems
> > -      * Turn on ALP, only we are accpeting Jumbo Packets */
> > +      * Turn on ALP, only we are accepting Jumbo Packets */
> >       writel(RXCFG_AEP | RXCFG_ARP | RXCFG_AIRL | RXCFG_RX_FD
> >               | RXCFG_STRIPCRC
> >               //| RXCFG_ALP
> > diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> > index 1a0fe8b15..d85d671de 100644
> > --- a/include/uapi/linux/udp.h
> > +++ b/include/uapi/linux/udp.h
> > @@ -31,7 +31,7 @@ struct udphdr {
> >  #define UDP_CORK     1       /* Never send partially complete segments=
 */
> >  #define UDP_ENCAP    100     /* Set the socket to accept encapsulated =
packets */
> >  #define UDP_NO_CHECK6_TX 101 /* Disable sending checksum for UDP6X */
> > -#define UDP_NO_CHECK6_RX 102 /* Disable accpeting checksum for UDP6 */
> > +#define UDP_NO_CHECK6_RX 102 /* Disable accepting checksum for UDP6 */
> >  #define UDP_SEGMENT  103     /* Set GSO segmentation size */
> >  #define UDP_GRO              104     /* This socket can receive UDP GR=
O packets */
> >
> > --
> > 2.45.2
> >
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

