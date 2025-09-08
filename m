Return-Path: <netdev+bounces-220865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDCAB49457
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336DD188F1A0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2A2F546E;
	Mon,  8 Sep 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zs6Uazwd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380A2E8E11
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346896; cv=none; b=rjSbM95ydEaHNJDlUUvBR0ARCS/AMRUnyxNYQTjMXn2e0DIpEeiZP6oAR2DRbjrJ4jo+UCNj4oJjo1+J21tMrVtmqa4v+gZx4KDWy1Ui3SaNw49S2pG9JNxkAErXj53EjGV1MmXCnrpp2HW8+pM2K2uP9y2YPLeXJKIRDHu9WtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346896; c=relaxed/simple;
	bh=rhtTPXeqjUx/d+E2waaOQ3KLGXlWXpzJB3H2mBI0qJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pz8EkV54aemnFI7oSkOo31OlSwNykGsLAuVpD9EI6dMzPO8nLhimYMR1DRn5sYkUGX4X43gzKeuhwvuGVWMqApUI8P+RVDXBDjFOCkciHpQOCIFPjj1kcl81xUDnKDGDpvly3gwCEgsfay28Xh677WW4pqdRBT/h0DJt3mfqHLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zs6Uazwd; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-32b70820360so3517927a91.2
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346894; x=1757951694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NRocUMS0GDsW+ct35Z1NB+LIQVu236juAVg0bqfUsYM=;
        b=fQG/PKsO6lYA6+2noDdmYm/fSnvesJBkERbZmfmfzpAbmslbNV6+zQB9g3Oy0NkSSH
         ktw9hAfDXxNBIYIuIl33cT47wMWZM4lQowYCmNIDgqow8Y3O1Bfb3wSJrnOgdfXOo102
         19r+5M7ObBmBiV3FfYUeZaWk7Rh64S010AF7tQXwftyT3QRF2MlZK7YJESfk2KEhPHxg
         tF9mRTT9xIdfqdk7p2VitSb1XXXvQSQQusGAsIlPIEG5JNPoecEpybYCHdUR7xF4dVQ1
         BOxepYrSg9UENhq0Ly0cdypUPaDHVX0nfuk6frcoClpeveCI6hV+SvdkQiWA+zXR6nuY
         i9LA==
X-Forwarded-Encrypted: i=1; AJvYcCXeBxCCfXuRRCwpBySs5KGhRleswXeyti9maq2c7mXIyD/jrvEQb1rLRAfwml1yAHS0KQ3L1I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAbouiJ7ebz9ByavSOWz0GGEE0CZwnBc2VgRarZca/mJ7fxJI
	6qvsPhmQgixu/iDwdHHpSnMOuLyo8kG9wqCtDTaIVYtjGNcGWRVKY68PXjg/qKFyif+3bPsHCRR
	i/RA4S6QKx36ttafIwabgVQWbyWgAvWfKUdsqc7c3GXfuOBwwQuknBO7zOjkKNA4AG6Ahlx1LzX
	LJ8EO78wUmhgkU4wgA+YCOcdeOxQWBIZMUv4OmUGiE1dyIQOXNku6DUrJVReEWcePLpJJr6YoKM
	JSe0diqEUo/BfTw+c7HCU0T
X-Gm-Gg: ASbGncv5EIPm2IzvDc/sjptfbk+2YEOzrFWaRJ0fC+Sl0WsINdaY6MFWt6fMcExF/OG
	Wu6MBApR3Tai/3Y1APv6JdikRRVx1U2xdYsBDAvMkDf0lrLRJz44wHWRngOk5zDNQCuGqEi0CK5
	WqIaEZBshOgZGo+roldYL4qeYU7nPwYiX/AUEnICw/CYLSWxUxh4sqqOXt5p0/2uIqQLts2Gb4D
	Vfym0BMuE7EgPRgLvCWTv+wGi8lRNsgDmcwMVn/l/uor2fgupw0CI1wNAGU+hKVJZc62qFMoogb
	RS6rfGHC5dkhvyCZGFSFNhCrt8eb36MLybbBgtJRIQvjJsbWTfVGbrIy9kD3NwdkMhG2s/FSs7Q
	ErMD0MiwI34JPAel4DZuhT5c6NKrrjYdxY+xVygP5m8AvJoSiVGU8F9EomF/XbKToiG2jK0sBTI
	yL6pX6cli/ADSqF0I=
X-Google-Smtp-Source: AGHT+IGfViXnAV+dz1RE/vCOPN+vwL8GgBLCJKRCZGtNZH7Uh+AG+RACxN8UN8BX4S8RFvrmzIaCMiGdxU3T
X-Received: by 2002:a17:90b:1812:b0:325:7845:fc52 with SMTP id 98e67ed59e1d1-32d43f7c115mr10798360a91.25.1757346893634;
        Mon, 08 Sep 2025 08:54:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-32b6d064c13sm1319252a91.5.2025.09.08.08.54.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:54:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329dfdc23d2so4219556a91.1
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757346891; x=1757951691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NRocUMS0GDsW+ct35Z1NB+LIQVu236juAVg0bqfUsYM=;
        b=Zs6Uazwdlkk6hft1+aXyk0l50b+IN7gxksFZMHTkzQDvDkBqQ8x3Y/00S1UHsiZT96
         SefU6go6qbj8r4gUAsuf0j5sAkScL6Y8WarttTDYubXPpdGWz/28caivl4HJYGKA2Ugc
         4/ZeL+zbyPpf4i67+g+L2rgLca7hMrdmpkKRA=
X-Forwarded-Encrypted: i=1; AJvYcCV9uT0oazuTeZp7JLI6SaG8Cg6hP4a3VIiqnk2HJIPe5kQYBvGwpsFcw3solwkMcOHBudnrEOg=@vger.kernel.org
X-Received: by 2002:a17:90b:4ac9:b0:327:531b:b85c with SMTP id 98e67ed59e1d1-32d43f99cbamr11133166a91.35.1757346891405;
        Mon, 08 Sep 2025 08:54:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac9:b0:327:531b:b85c with SMTP id
 98e67ed59e1d1-32d43f99cbamr11133142a91.35.1757346890783; Mon, 08 Sep 2025
 08:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com> <175734586236.468086.14323497345307202416.b4-ty@kernel.org>
In-Reply-To: <175734586236.468086.14323497345307202416.b4-ty@kernel.org>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 8 Sep 2025 21:24:39 +0530
X-Gm-Features: Ac12FXx3YEn7C6Xz12Tubv-IWQXGMfwafg6SZ5dYN4z6O413nX6iIKomcnRTTj8
Message-ID: <CAH-L+nPP+UU_0NQTh_WTNrrJ5t9GraES0x2r=FyvDMW_Wk2tEg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 00/10] RDMA/bnxt_re: Add receive flow steering support
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	michael.chan@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003db014063e4c3522"

--0000000000003db014063e4c3522
Content-Type: multipart/alternative; boundary="0000000000002c41e5063e4c3516"

--0000000000002c41e5063e4c3516
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

It looks like you have merged V1 of the series. I had already pushed a V2
of the series which fixes an issue in Patch#10.

I can push the changes made in Patch#10 as a follow up patch. Please let me
know.

On Mon, Sep 8, 2025 at 9:07=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:

>
> On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:
> > The RDMA stack allows for applications to create IB_QPT_RAW_PACKET
> > QPs, which receive plain Ethernet packets. This patch adds
> ib_create_flow()
> > and ib_destroy_flow() support in the bnxt_re driver. For now, only the
> > sniffer rule is supported to receive all port traffic. This is to suppo=
rt
> > tcpdump over the RDMA devices to capture the packets.
> >
> > Patch#1 is Ethernet driver change to reserve more stats context to RDMA
> device.
> > Patch#2, #3 and #4 are code refactoring changes in preparation for
> subsequent patches.
> > Patch#5 adds support for unique GID.
> > Patch#6 adds support for mirror vnic.
> > Patch#7 adds support for flow create/destroy.
> > Patch#8 enables the feature by initializing FW with roce_mirror support=
.
> > Patch#9 is to improve the timeout value for the commands by using
> firmware provided message timeout value.
> > Patch#10 is another related cleanup patch to remove unnecessary checks.
> >
> > [...]
>
> Applied, thanks!
>
> [01/10] bnxt_en: Enhance stats context reservation logic
>         https://git.kernel.org/rdma/rdma/c/47bd8cafcbf007
> [02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support
>         https://git.kernel.org/rdma/rdma/c/a99b2425cc6091
> [03/10] RDMA/bnxt_re: Refactor hw context memory allocation
>         https://git.kernel.org/rdma/rdma/c/877d90abaa9eae
> [04/10] RDMA/bnxt_re: Refactor stats context memory allocation
>         https://git.kernel.org/rdma/rdma/c/bebe1a1bb1cff3
> [05/10] RDMA/bnxt_re: Add support for unique GID
>         https://git.kernel.org/rdma/rdma/c/b8f4e7f1a275ba
> [06/10] RDMA/bnxt_re: Add support for mirror vnic
>         https://git.kernel.org/rdma/rdma/c/c23c893e3a02a5
> [07/10] RDMA/bnxt_re: Add support for flow create/destroy
>         https://git.kernel.org/rdma/rdma/c/525b4368864c7e
> [08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support
>         https://git.kernel.org/rdma/rdma/c/d1dde88622b99c
> [09/10] RDMA/bnxt_re: Use firmware provided message timeout value
>         https://git.kernel.org/rdma/rdma/c/d7fc2e1a321cf7
> [10/10] RDMA/bnxt_re: Remove unnecessary condition checks
>         https://git.kernel.org/rdma/rdma/c/dfc78ee86d8f50
>
> Best regards,
> --
> Leon Romanovsky <leon@kernel.org>
>
>
>

--=20
Regards,
Kalesh AP

--0000000000002c41e5063e4c3516
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Leon,<div><br></div><div>It looks like you have merged =
V1 of the series. I had already pushed a V2 of the series which fixes an is=
sue in Patch#10.</div><div><br></div><div>I can push the changes made in Pa=
tch#10 as a follow=C2=A0up patch. Please let me know.</div></div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">On Mon, Sep 8, 2025 at 9:07=E2=80=AFPM Leon Romanovsky &lt;<a href=3D=
"mailto:leon@kernel.org">leon@kernel.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><br>
On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:<br>
&gt; The RDMA stack allows for applications to create IB_QPT_RAW_PACKET<br>
&gt; QPs, which receive plain Ethernet packets. This patch adds ib_create_f=
low()<br>
&gt; and ib_destroy_flow() support in the bnxt_re driver. For now, only the=
<br>
&gt; sniffer rule is supported to receive all port traffic. This is to supp=
ort<br>
&gt; tcpdump over the RDMA devices to capture the packets.<br>
&gt; <br>
&gt; Patch#1 is Ethernet driver change to reserve more stats context to RDM=
A device.<br>
&gt; Patch#2, #3 and #4 are code refactoring changes in preparation for sub=
sequent patches.<br>
&gt; Patch#5 adds support for unique GID.<br>
&gt; Patch#6 adds support for mirror vnic.<br>
&gt; Patch#7 adds support for flow create/destroy.<br>
&gt; Patch#8 enables the feature by initializing FW with roce_mirror suppor=
t.<br>
&gt; Patch#9 is to improve the timeout value for the commands by using firm=
ware provided message timeout value.<br>
&gt; Patch#10 is another related cleanup patch to remove unnecessary checks=
.<br>
&gt; <br>
&gt; [...]<br>
<br>
Applied, thanks!<br>
<br>
[01/10] bnxt_en: Enhance stats context reservation logic<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/4=
7bd8cafcbf007" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/47bd8cafcbf007</a><br>
[02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/a=
99b2425cc6091" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/a99b2425cc6091</a><br>
[03/10] RDMA/bnxt_re: Refactor hw context memory allocation<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/8=
77d90abaa9eae" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/877d90abaa9eae</a><br>
[04/10] RDMA/bnxt_re: Refactor stats context memory allocation<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/b=
ebe1a1bb1cff3" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/bebe1a1bb1cff3</a><br>
[05/10] RDMA/bnxt_re: Add support for unique GID<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/b=
8f4e7f1a275ba" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/b8f4e7f1a275ba</a><br>
[06/10] RDMA/bnxt_re: Add support for mirror vnic<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/c=
23c893e3a02a5" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/c23c893e3a02a5</a><br>
[07/10] RDMA/bnxt_re: Add support for flow create/destroy<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/5=
25b4368864c7e" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/525b4368864c7e</a><br>
[08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/d=
1dde88622b99c" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/d1dde88622b99c</a><br>
[09/10] RDMA/bnxt_re: Use firmware provided message timeout value<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/d=
7fc2e1a321cf7" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/d7fc2e1a321cf7</a><br>
[10/10] RDMA/bnxt_re: Remove unnecessary condition checks<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/rdma/rdma/c/d=
fc78ee86d8f50" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
rdma/rdma/c/dfc78ee86d8f50</a><br>
<br>
Best regards,<br>
-- <br>
Leon Romanovsky &lt;<a href=3D"mailto:leon@kernel.org" target=3D"_blank">le=
on@kernel.org</a>&gt;<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Regards,<div>Kalesh AP</div></div></div>

--0000000000002c41e5063e4c3516--

--0000000000003db014063e4c3522
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEIG5YSA5ikMyrxNMlyXU+QeRe9ZOVKrNF37rgX2Z/x2/gMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDkwODE1NTQ1MVowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKN/HyOGTl074z5/R5OysO151gob
UBEjsX5G2asR//tRFxjsej8MVab21s3DCPRtcwQ+wTc6z0yWS7cHXzzTQuwbHqWTtA5XzaAX3ABD
UrR03HPCLYC1+VeNrmXN6HU+bfPTWPzD0giUXVm+I9aWSEk0FW7IYKk2APhICDLkvmDXY/7MClru
QWF/4Cc+CiCJAsZxvkQtWnA60W+d8Q73e8VF8dSlkFAR/vbM/srTqtulbwPCeMT6v515B17wb6a+
f9pWIuFdRj13ZE6H2L/KBcK6w3W2x1r+CBWZMYzWqgbu8S0ncHSvc+5412DXv1SHzgsUQkYgEOnt
8IcMm4v/KQI=
--0000000000003db014063e4c3522--

