Return-Path: <netdev+bounces-179822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F5A7E945
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C477A32F7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7621517B;
	Mon,  7 Apr 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aIrQeNZ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075B21146F
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049021; cv=none; b=MYT8FBzzhurqx7ucxOoTnL6U7BRXJCGRA2kk4zIHjr9ZFCfHbX3zrqPY6rVunlNR4scReHZrohOa/BpncqDrA8EgxnYaMsRnAxEpEwpfh+mhpA2YMLD37Bb1YIfNo5LeiAweBGJrmf0nDyZU3x3sUhKZWQbBim8DI2p7IjXvEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049021; c=relaxed/simple;
	bh=thSvgXieII1pK1BCCT312jxPBNa3dLN6hCdp36PT1uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QN/TVxp2ej5Zmxitnf/R4YS1UOka71vKtr4OcKUNv6IHsar7Vdi2YQPNWhBDAw/H7pfEn/oAPjzF5um0jJsKsTzfuNm6UtqzJ8rfXrQTU/mEox0zRphYEY4EB3TTJrbzJlX45pP9tKX9TT3j4sFgVc7KAXdpE0ewWjlOjjS0xgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aIrQeNZ7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30c0517142bso44224971fa.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744049017; x=1744653817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZFg5Dbx/uvjjWlVNXsW7gz1mzs7nER5koYQxwU0ZzU=;
        b=aIrQeNZ7jL7XXN8H5Yll/Y5QNTVTSybGj2skWCm+T3xOQdqT/Etwr6NPxHLTsiK7jm
         /Dt3wu02jhWq6RfTb20HjZhM5lJWSRRLcUAXzjoJmDo1mkqkly/Aio9ORX72tNja5MPP
         N137TuEOp5tOGvz8LYG7WS6ERCVfQiDMToGJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049017; x=1744653817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZFg5Dbx/uvjjWlVNXsW7gz1mzs7nER5koYQxwU0ZzU=;
        b=XEQFMUhYvX0Ah6du7V9NOR0J5LjGyTkMcmDFndiEqA9rHq5Zi8gsRWF6OGE7eoVYK+
         04x6o/LECRiM2g7CQM0amPfmAQDpXmVMKZwQXSplQmiqhRPCuRNW5j3/JiiyoN8kBVG5
         Xr+RHWKwaiUGZ9zZmzWczupwSM9/oKQerviEMo0NZJufk2ZSvaxPnX/lQrAAoKX27t6j
         OY5xFzqyBnWzc+4EkltJHVOQTDWtp8QqZvzKxIG+kMXnwud5NaCDkAdxUXTS3AvjYGmj
         Y/5lJsHDhNGiv1MRDJx7N5d1kvz13cInkcWT77n4FEBtfAubkKW0BzwoLXGcnYYFjTa9
         2GFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX2TbJgmM3H6QPh0+ITVl2lEBsw5z69POSn4Ox7+JhRFlUzEgLxV0nKZc8+sBSyR3n0ld9iDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypbEHlPJALfKQ+t3onNaVQfI0rYQtWicuOs/jAY+4XUOLCZsTn
	lVCWwToXG1DysQatk9iIGV/YSw1u3291u7IwLUojPYSmp+RyUBvSzIsXD/4UiTSOxLkrGO9Un7W
	r9v905/PDdDKUhM4tsE1Ghlt2INlDeVKldhDKj5Ts6f8jPnPGgzpaMAJfnz5FSlogiem8lJojFg
	BZtvCCyY49xTFoUvlt0w==
X-Gm-Gg: ASbGncvLHEpVg37kipwEJhxxMznviMQcwX4olb/d4/2na57wqbkm9qNpKfRB7Hrj9RG
	RepTBDqws/zF8Ld5panpz7U/r/JcUmLED61Hh7S4GQjAdhQwIdQpH4O49C9+Gl+V+/VTmSvngUb
	p1wOfB8OCoksjBPtKgRWk4dNfcsoPbaB/Aps0OPg==
X-Google-Smtp-Source: AGHT+IEMHAXb99BjzHl/wEwdDDt2d7xQ0XWjBG79hzOR0um9okB3fpKHrXCsVp3Ag+pZPG43NpifcFpL+DO3yaRryZ8=
X-Received: by 2002:a2e:a80c:0:b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-30f0a12ef9emr37546341fa.18.1744049016851; Mon, 07 Apr 2025
 11:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402183123.321036-1-michael.chan@broadcom.com>
 <20250402183123.321036-3-michael.chan@broadcom.com> <Z-6jN7aA8ZnYRH6j@shredder>
 <Z_P8EZ4YPISzAbPw@shredder>
In-Reply-To: <Z_P8EZ4YPISzAbPw@shredder>
From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Date: Mon, 7 Apr 2025 11:03:24 -0700
X-Gm-Features: ATxdqUEMpejtNFuRWBongDAY12pDD7EomyYfxf39a0IaxcDxFb-UFWZx18rOz2k
Message-ID: <CAKSYD4wieiozwaQ219HPOQUzGwYnA8aZjvskU_fKLTiDjydmpw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ethtool: cmis: use u16 for calculated read_write_len_ext
To: Ido Schimmel <idosch@idosch.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, 
	horms@kernel.org, danieller@nvidia.com, andrew.gospodarek@broadcom.com, 
	petrm@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002881220632340ec0"

--0000000000002881220632340ec0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:23=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wro=
te:
>
> On Mon, Apr 07, 2025 at 08:09:56AM -0700, Damodharam Ammepalli wrote:
> > From: Ido Schimmel <idosch@idosch.org>
> >
> > Adding Petr given Danielle is away
> >
> > On Wed, Apr 02, 2025 at 11:31:23AM -0700, Michael Chan wrote:
> > > From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> > >
> > > For EPL (Extended Payload), the maximum calculated size returned by
> > > ethtool_cmis_get_max_epl_size() is 2048, so the read_write_len_ext
> > > field in struct ethtool_cmis_cdb_cmd_args needs to be changed to u16
> > > to hold the value.
> > >
> > > To avoid confusion with other u8 read_write_len_ext fields defined
> > > by the CMIS spec, change the field name to calc_read_write_len_ext.
> > >
> > > Without this change, module flashing can fail:
> > >
> > > Transceiver module firmware flashing started for device enp177s0np0
> > > Transceiver module firmware flashing in progress for device enp177s0n=
p0
> > > Progress: 0%
> > > Transceiver module firmware flashing encountered an error for device =
enp177s0np0
> > > Status message: Write FW block EPL command failed, LPL length is long=
er
> > >     than CDB read write length extension allows.
> > >
> > > Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting C=
DB commands)
> > > Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > > Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.co=
m>
> > > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> > > ---
> > >  net/ethtool/cmis.h     | 7 ++++---
> > >  net/ethtool/cmis_cdb.c | 8 ++++----
> > >  2 files changed, 8 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
> > > index 1e790413db0e..51f5d5439e2a 100644
> > > --- a/net/ethtool/cmis.h
> > > +++ b/net/ethtool/cmis.h
> > > @@ -63,8 +63,9 @@ struct ethtool_cmis_cdb_request {
> > >   * struct ethtool_cmis_cdb_cmd_args - CDB commands execution argumen=
ts
> > >   * @req: CDB command fields as described in the CMIS standard.
> > >   * @max_duration: Maximum duration time for command completion in ms=
ec.
> > > - * @read_write_len_ext: Allowable additional number of byte octets t=
o the LPL
> > > - *                 in a READ or a WRITE commands.
> > > + * @calc_read_write_len_ext: Calculated allowable additional number =
of byte
> > > + *                      octets to the LPL or EPL in a READ or WRITE =
CDB
> > > + *                      command.
> > >   * @msleep_pre_rpl: Waiting time before checking reply in msec.
> > >   * @rpl_exp_len: Expected reply length in bytes.
> > >   * @flags: Validation flags for CDB commands.
> > > @@ -73,7 +74,7 @@ struct ethtool_cmis_cdb_request {
> > >  struct ethtool_cmis_cdb_cmd_args {
> > >     struct ethtool_cmis_cdb_request req;
> > >     u16                             max_duration;
> > > -   u8                              read_write_len_ext;
> > > +   u16                             calc_read_write_len_ext;
> > >     u8                              msleep_pre_rpl;
> > >     u8                              rpl_exp_len;
> > >     u8                              flags;
> > > diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
> > > index dba3aa909a95..1f487e1a6347 100644
> > > --- a/net/ethtool/cmis_cdb.c
> > > +++ b/net/ethtool/cmis_cdb.c
> > > @@ -35,13 +35,13 @@ void ethtool_cmis_cdb_compose_args(struct ethtool=
_cmis_cdb_cmd_args *args,
> > >     args->req.lpl_len =3D lpl_len;
> > >     if (lpl) {
> > >             memcpy(args->req.payload, lpl, args->req.lpl_len);
> > > -           args->read_write_len_ext =3D
> > > +           args->calc_read_write_len_ext =3D
> > >                     ethtool_cmis_get_max_lpl_size(read_write_len_ext)=
;
> > >     }
> > >     if (epl) {
> > >             args->req.epl_len =3D cpu_to_be16(epl_len);
> > >             args->req.epl =3D epl;
> > > -           args->read_write_len_ext =3D
> > > +           args->calc_read_write_len_ext =3D
> > >                     ethtool_cmis_get_max_epl_size(read_write_len_ext)=
;
> >
> > AFAIU, a size larger than a page (128 bytes) is only useful when auto
> > paging is supported which is something the kernel doesn't currently
> > support. Therefore, I think it's misleading to initialize this field to
> > a value larger than 128.
> >
> > How about deleting ethtool_cmis_get_max_epl_size() and moving the
> > initialization of 'args->read_write_len_ext' outside of the if block as
> > it was before 9a3b0d078bd82?
> >
> > >     }
> > >
> > > @@ -590,7 +590,7 @@ ethtool_cmis_cdb_execute_epl_cmd(struct net_devic=
e *dev,
> > >                     space_left =3D CMIS_CDB_EPL_FW_BLOCK_OFFSET_END -=
 offset + 1;
> > >                     bytes_to_write =3D min_t(u16, bytes_left,
> > >                                            min_t(u16, space_left,
> > > -                                                args->read_write_len=
_ext));
> > > +                                                args->calc_read_writ=
e_len_ext));
> > >
> > >                     err =3D __ethtool_cmis_cdb_execute_cmd(dev, page_=
data,
> > >                                                          page, offset=
,
> > > @@ -631,7 +631,7 @@ int ethtool_cmis_cdb_execute_cmd(struct net_devic=
e *dev,
> > >                                    offsetof(struct ethtool_cmis_cdb_r=
equest,
> > >                                             epl));
> > >
> > > -   if (args->req.lpl_len > args->read_write_len_ext) {
> > > +   if (args->req.lpl_len > args->calc_read_write_len_ext) {
> > >             args->err_msg =3D "LPL length is longer than CDB read wri=
te length extension allows";
> > >             return -EINVAL;
> > >     }
> > > --
> > > 2.30.1
> > >
> > >
> >
> > This module supports AutoPaging, 255 read_write_len_ext and EPL write m=
echanism.
> > This advertised 0xff (byte2) calculates the args->read_write_len_ext
> > to 2048B, which needs u16.
> > Hexdump: cmis_cdb_advert_rpl
> > Off 0x00 :77 ff 1f 80
> >
> > With your suggested change, ethtool_cmis_cdb_execute_epl_cmd() is skipp=
ed
> > since args->req.epl_len is set to zero and download fails.
>
> To be clear, this is what I'm suggesting [1] and it doesn't involve
> setting args->req.epl_len to zero, so I'm not sure what was tested.
>
> Basically, setting maximum length of read or write to 128 bytes as the
> kernel does not currently support auto paging (even if the transceiver
> module does) and will not try to perform cross-page reads or writes.
>
> [1]
> diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
> index 1e790413db0e..4a9a946cabf0 100644
> --- a/net/ethtool/cmis.h
> +++ b/net/ethtool/cmis.h
> @@ -101,7 +101,6 @@ struct ethtool_cmis_cdb_rpl {
>  };
>
>  u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs);
> -u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs);
>
>  void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *arg=
s,
>                                    enum ethtool_cmis_cdb_cmd_id cmd, u8 *=
lpl,
> diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
> index d159dc121bde..0e2691ccb0df 100644
> --- a/net/ethtool/cmis_cdb.c
> +++ b/net/ethtool/cmis_cdb.c
> @@ -16,15 +16,6 @@ u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs)
>         return 8 * (1 + min_t(u8, num_of_byte_octs, 15));
>  }
>
> -/* For accessing the EPL field on page 9Fh, the allowable length extensi=
on is
> - * min(i, 255) byte octets where i specifies the allowable additional nu=
mber of
> - * byte octets in a READ or a WRITE.
> - */
> -u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs)
> -{
> -       return 8 * (1 + min_t(u8, num_of_byte_octs, 255));
> -}
> -
>  void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *arg=
s,
>                                    enum ethtool_cmis_cdb_cmd_id cmd, u8 *=
lpl,
>                                    u8 lpl_len, u8 *epl, u16 epl_len,
> @@ -33,19 +24,16 @@ void ethtool_cmis_cdb_compose_args(struct ethtool_cmi=
s_cdb_cmd_args *args,
>  {
>         args->req.id =3D cpu_to_be16(cmd);
>         args->req.lpl_len =3D lpl_len;
> -       if (lpl) {
> +       if (lpl)
>                 memcpy(args->req.payload, lpl, args->req.lpl_len);
> -               args->read_write_len_ext =3D
> -                       ethtool_cmis_get_max_lpl_size(read_write_len_ext)=
;
> -       }
>         if (epl) {
>                 args->req.epl_len =3D cpu_to_be16(epl_len);
>                 args->req.epl =3D epl;
> -               args->read_write_len_ext =3D
> -                       ethtool_cmis_get_max_epl_size(read_write_len_ext)=
;
>         }
>
>         args->max_duration =3D max_duration;
> +       args->read_write_len_ext =3D
> +               ethtool_cmis_get_max_lpl_size(read_write_len_ext);
>         args->msleep_pre_rpl =3D msleep_pre_rpl;
>         args->rpl_exp_len =3D rpl_exp_len;
>         args->flags =3D flags;

Yes, your change works and here is the diff.
From the comment "before 9a3b0d078bd82", I tried
updating your comments on top of edc344568922. I should
have asked you for clarification.


diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 54916c16d13f..4f5ad34af3ea 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -75,7 +75,7 @@ struct ethtool_cmis_cdb_request {
 struct ethtool_cmis_cdb_cmd_args {
        struct ethtool_cmis_cdb_request req;
        u16                             max_duration;
-       u16                             calc_read_write_len_ext;
+       u8                              read_write_len_ext;
        u8                              msleep_pre_rpl;
        u8                              rpl_exp_len;
        u8                              flags;
diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index 1f487e1a6347..56c6130fe010 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -16,15 +16,6 @@ u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs)
        return 8 * (1 + min_t(u8, num_of_byte_octs, 15));
 }

-/* For accessing the EPL field on page 9Fh, the allowable length extension=
 is
- * min(i, 255) byte octets where i specifies the allowable additional numb=
er of
- * byte octets in a READ or a WRITE.
- */
-u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs)
-{
-       return 8 * (1 + min_t(u8, num_of_byte_octs, 255));
-}
-
 void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
                                   enum ethtool_cmis_cdb_cmd_id cmd, u8 *lp=
l,
                                   u8 lpl_len, u8 *epl, u16 epl_len,
@@ -35,16 +26,13 @@ void ethtool_cmis_cdb_compose_args(struct
ethtool_cmis_cdb_cmd_args *args,
        args->req.lpl_len =3D lpl_len;
        if (lpl) {
                memcpy(args->req.payload, lpl, args->req.lpl_len);
-               args->calc_read_write_len_ext =3D
-                       ethtool_cmis_get_max_lpl_size(read_write_len_ext);
        }
        if (epl) {
                args->req.epl_len =3D cpu_to_be16(epl_len);
                args->req.epl =3D epl;
-               args->calc_read_write_len_ext =3D
-                       ethtool_cmis_get_max_epl_size(read_write_len_ext);
        }
-
+       args->read_write_len_ext =3D
+                       ethtool_cmis_get_max_lpl_size(read_write_len_ext);
        args->max_duration =3D max_duration;
        args->msleep_pre_rpl =3D msleep_pre_rpl;
        args->rpl_exp_len =3D rpl_exp_len;
@@ -590,7 +578,7 @@ ethtool_cmis_cdb_execute_epl_cmd(struct net_device *dev=
,
                        space_left =3D CMIS_CDB_EPL_FW_BLOCK_OFFSET_END
- offset + 1;
                        bytes_to_write =3D min_t(u16, bytes_left,
                                               min_t(u16, space_left,
-
args->calc_read_write_len_ext));
+                                                    args->read_write_len_e=
xt));

                        err =3D __ethtool_cmis_cdb_execute_cmd(dev, page_da=
ta,
                                                             page, offset,
@@ -631,7 +619,7 @@ int ethtool_cmis_cdb_execute_cmd(struct net_device *dev=
,
                                       offsetof(struct ethtool_cmis_cdb_req=
uest,
                                                epl));

-       if (args->req.lpl_len > args->calc_read_write_len_ext) {
+       if (args->req.lpl_len > args->read_write_len_ext) {
                args->err_msg =3D "LPL length is longer than CDB read
write length extension allows";
                return -EINVAL;
        }

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000002881220632340ec0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGdjCCBF6g
AwIBAgIMLn8lLzdNn3iuIRSnMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDgxNTEwMzAxMVoXDTI2MDgxNjEwMzAxMVowgbkxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEdMBsGA1UEAxMURGFtb2RoYXJhbSBBbW1lcGFs
bGkxMDAuBgkqhkiG9w0BCQEWIWRhbW9kaGFyYW0uYW1tZXBhbGxpQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKTOTiEM9VXocEeEqNwSSCInX6pzIDka9Ux5oY37
MzNBjrka0eveof2NigzPwsVrOLiIxbdWAGwTg0Y8CJGLhW2oeaAMvR4DRiNKoVkAlq87iA+0Lt+b
UlOWZ9GhhdGiyoKgyiVXVoHNE+qaCdiA7jSt2IiKNwtbrJ5ORhhVJhVO7TUWSA+eHhxxX6YVobyW
h8I72UXTTrWfZrpyVpnzcjRD46GJDB0p0KU/2mY7wE2nUvT20sCt1G9JQTq8fr+CHG4DXJj3HFyr
xucep3rDhxi6mbVTlXY3GuQSPWjJ5b/MtvWL3b02wY85/WEzAw5yP1QoxWyfCvS9C4+QlRgMwVcC
AwEAAaOCAeIwggHeMA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUH
MAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAy
My5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIw
NDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYD
VR0TBAIwADBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2Nj
cjZzbWltZWNhMjAyMy5jcmwwLAYDVR0RBCUwI4EhZGFtb2RoYXJhbS5hbW1lcGFsbGlAYnJvYWRj
b20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UY
sKCSMB0GA1UdDgQWBBQPTiO195ramjDswK3B4QGsKDTPRjANBgkqhkiG9w0BAQsFAAOCAgEAk/bL
jIfng3rwfvQM0w6iGYjLlBQUSPgjuJMjshP/aADrjnHhcxKKImHh8mmWGxMHY4POjHmYAIbQrFHi
yG8aVI2kLKc3/0zJOKqGqx7NvyKmwerKKELVOMdDBXEnXExqAMOj3rYACeJhZqYwqGaK1BcLvTgo
hbrXTFXUvlU12mx0OHcc0GGEQu90+qFwFFPiGcJiHu0pAMH0d2e83iNeJ3ply+KhDxw5Wc/pqAEy
XOcuERQuTAGZH1NY+UVFxxIrr6pvquPAABXaXGU3QG36jWtGPPSjL+1Qf2Jmb3KKm0h4BAHRka1c
KfrM/0EF+/7YszLeeA7o2bpqhcahprLZUuiy7dgCRQs9b8wN+kJBpV2Ql7bBDj5Cm0avWUtGxjkR
LxqSIHo8rccZJskrJx004QmEwKVnkChGRxZ8LrhNKLy8ikzmrxpA2eK7cPyGewmFKhxBoGDsGCfy
CMVthgjbMyh2cVbo7cIXrnx8rf7q9S0aAPt9yHX4+GtXPw44iTsJmD/EOmwX2QLPjjdBKbSgi55S
nUnMFar9lAhGDw826s0j4dQooqLC1BX/jGH1VapU8AGfGAWbsGhBG74yjHfRC74KkFuOj2ORU+9f
ueOdPBxQH3SIl77cHdNp3NWTwFAdBKpdDLMyGf79t5bgpNRYDZ/szNAxW6aH6PhnUMBtD0gxggJX
MIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYD
VQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwufyUvN02feK4hFKcwDQYJYIZI
AWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGFP1G4QxMak/J4EZcm/ThJa/r3gLUSH3G3RldXc
tcgjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQwNzE4MDMz
N1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIB
AI+lZ+N6NCxvoRpAy/WLBOzSwx6ImAQUg/HsvmXhUP6QDFa6NwIZzRU37rRnVAvn/1JMhYt2rEzB
O8rbIPHJ17BZrJCDWbEqQU+1gzxcr4l2qwiWaCsH7ub1D5knx38Gg/0QqFn89DK8GJVbJsg3zDkt
ekOjA7W1Q81QH8VdLW0V/ypuKDLiF7Umbcfo6aMS6KhR9SuAcdyi8tyW3i9QPK8ds7Bq6cqlFn8U
in4CeyBBR1H51h9EyT7yul2Y4vcuNmQMa7PMquafVBppMISxcidbV7E3IRMum/SvAC0RxBzQ5jL7
oCkE6455zuWxGie1IjdNatG3OakpXk/3sBFjJZY=
--0000000000002881220632340ec0--

