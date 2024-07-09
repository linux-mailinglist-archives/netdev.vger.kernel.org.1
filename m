Return-Path: <netdev+bounces-110123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B501192B04A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4098C1F23F50
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDDB13C3CA;
	Tue,  9 Jul 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F33aXuJ9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB66138
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506914; cv=none; b=A4MSxJZ5c/HujBZGALLoV0HHqVErn1mRj7MvZ2MUvz+xS0yoOCPredE6yb7zNQVgZjqw3xoEfpQnyx5McBvtLll+BprTYOpMKXLua52DagxCO1qF4ffX/tuRvUAbQcijZcp2W31SX/Er2qH4CQXPlbi7JUpPYbHO1y4iT69lgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506914; c=relaxed/simple;
	bh=V7pD2vmuldEKTKHZ2bVYOa+O+0Nta1zIdwFNmZG0UKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4C/plHGw/wmIvDPyiYK0veqUsuygp5P8aDbS5nA09ZPjRelw0y5aPgo5VXlzmokj5EsAt0hZijpHCE8Tl/1SEmFuDZaoG547JATVpHLp18QMh2tmhstoho+xAE42mb+S1OSZDzPt5XvpLCr93SbWChF6O97VSdsIuY7uRZjF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F33aXuJ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720506911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4KGMFtZiTPlZMWNRBpD66CxKVVOshfXpDleLTuP8bLc=;
	b=F33aXuJ9ahKLcrhlw1pcK7FNM5BcSVkMjVTGwc8KPnljwLapAmjagdWHQ0s3q/wFmYrm9x
	8dHvB64ZQFsJWrmWrv3iyEThD9OEQWbhLsLcyXs7HEG+4cB3BMkTeExn1IoEl59dQnAHnA
	UnXWhPH95xMbU9o2TdqEh4zeh5q3Sb4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-qWPK9LREOZqUC2NGXPp55Q-1; Tue, 09 Jul 2024 02:35:09 -0400
X-MC-Unique: qWPK9LREOZqUC2NGXPp55Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58b1cfea1f4so4274213a12.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 23:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506908; x=1721111708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KGMFtZiTPlZMWNRBpD66CxKVVOshfXpDleLTuP8bLc=;
        b=bGfh8TeLRUUcX1C0dEGv6NfVkfVU7FLu5v5g07BOsTq7QcM3aHT9jy/XoED3te9R3Y
         VTXOU+hEErJRqUXEIsleuRHhBwMQ6E5Vg3tt/S/uscRVfIkN/srqtX5WUzxwMrBESdI4
         cOe44SncUJ/rjAGZBOgRtfacV52aiuuBxOYBUzWW64wL69SR8Kvt11NJ2RFn+/vkrZFK
         MaOLa12KfAn0Iao7dmdp3TFjF/cXV+q8X/hfDH+Dbv38LUmKyBAEssgLxGYzwt31W9Ob
         jx4EqIsnikvpUAAto7rsyvd4Qz8fjQ4jb2rQEzuSdY4nX5uRNWu7VqklpA3qNQW4vQ8k
         zJXw==
X-Forwarded-Encrypted: i=1; AJvYcCWVKq4TD8hCmWk+MccGXFK0jIy4G1xaApoUMkQBpSkM8hsUEyL56sgpLjMl/6HcMIIzN+VPBurpFtSr40Nbr9bwFojJsiaj
X-Gm-Message-State: AOJu0YzDzdVwChuHiCNyIq+iKHO+g2Pup92dS30NAuIm7/uNzdvrBpG6
	L+a58stlQYwgAM6U0NFEv20QBgOBkJouOVyTxk8ksZhBN+V1DtsGenBsiVAx3rav3xOEhN9yA/l
	f+fZexYe8BPgkdxi8wwHzGBTdNXvufGCd2ucW9f0mgVZ2DyqAlVKfwvPS6Df+eBIBWzIA1pLz68
	S8oVSvykoojZssCu7w1iHr6Hif4ZJC
X-Received: by 2002:a05:6402:5112:b0:57c:6afc:d2b0 with SMTP id 4fb4d7f45d1cf-594ba9974e2mr1097013a12.1.1720506908111;
        Mon, 08 Jul 2024 23:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGklY1mGOFGiDZwpHaWT9IT9TQeoX0W760teltoi5merFq8TGERjX1sy6/WkO2BJsAegPRTi9zGorlxlL/sxow=
X-Received: by 2002:a05:6402:5112:b0:57c:6afc:d2b0 with SMTP id
 4fb4d7f45d1cf-594ba9974e2mr1096995a12.1.1720506907584; Mon, 08 Jul 2024
 23:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709032326.581242-1-lulu@redhat.com> <PH0PR12MB54814BEA4DD2E8CFD434DF4BDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54814BEA4DD2E8CFD434DF4BDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 14:34:30 +0800
Message-ID: <CACLfguUw2KaryX=72jg_N9wqEeKtSPQR+KkmzW=PRReUd9minA@mail.gmail.com>
Subject: Re: [PATH v2] vdpa: add the support to set mac address and MTU
To: Parav Pandit <parav@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 12:01, Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Cindy Lu <lulu@redhat.com>
> > Sent: Tuesday, July 9, 2024 8:53 AM
> > Subject: [PATH v2] vdpa: add the support to set mac address and MTU
> >
> Please fix PATH to PATCH.
>
> > Add new function to support the MAC address and MTU from VDPA tool.
> > The kernel now only supports setting the MAC address.
> >
> Please include only mac address setting for now in the example and documentation.
> In the future when kernel supports setting the mtu, please extend vdpa tool at that point to add the option.
>
> > The usage is vdpa dev set name vdpa_name mac **:**:**:**:**
> >
> > here is sample:
> > root@L1# vdpa -jp dev config show vdpa0
> > {
> >     "config": {
> >         "vdpa0": {
> >             "mac": "82:4d:e9:5d:d7:e6",
> >             "link ": "up",
> >             "link_announce ": false,
> >             "mtu": 1500
> >         }
> >     }
> > }
> >
> > root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
> >
> > root@L1# vdpa -jp dev config show vdpa0
> > {
> >     "config": {
> >         "vdpa0": {
> >             "mac": "00:11:22:33:44:55",
> >             "link ": "up",
> >             "link_announce ": false,
> >             "mtu": 1500
> >         }
> >     }
> > }
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  man/man8/vdpa-dev.8            | 20 ++++++++++++++++++++
> >  vdpa/include/uapi/linux/vdpa.h |  1 +
> >  vdpa/vdpa.c                    | 19 +++++++++++++++++++
> >  3 files changed, 40 insertions(+)
> >
> > diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8 index
> > 43e5bf48..718f40b2 100644
> > --- a/man/man8/vdpa-dev.8
> > +++ b/man/man8/vdpa-dev.8
> > @@ -50,6 +50,12 @@ vdpa-dev \- vdpa device configuration  .B qidx  .I
> > QUEUE_INDEX
> >
> > +.ti -8
> > +.B vdpa dev set
> > +.B name
> > +.I NAME
> > +.B mac
> > +.RI "[ " MACADDR " ]"
> >
> >  .SH "DESCRIPTION"
> >  .SS vdpa dev show - display vdpa device attributes @@ -120,6 +126,15 @@
> > VDPA_DEVICE_NAME  .BI qidx " QUEUE_INDEX"
> >  - specifies the virtqueue index to query
> >
> > +.SS vdpa dev set - set the configuration to the vdpa device.
> > +
> > +.BI name " NAME"
> > +-Name of the vdpa device to configure.
> > +
> > +.BI mac " MACADDR"
> > +- specifies the mac address for the vdpa device.
> > +This is applicable only for the network type of vdpa device.
> > +
> >  .SH "EXAMPLES"
> >  .PP
> >  vdpa dev show
> > @@ -171,6 +186,11 @@ vdpa dev vstats show vdpa0 qidx 1  .RS 4  Shows
> > vendor specific statistics information for vdpa device vdpa0 and virtqueue
> > index 1  .RE
> > +.PP
> > +vdpa dev set name vdpa0 mac 00:11:22:33:44:55 .RS 4 Set a specific MAC
> > +address to vdpa device vdpa0 .RE
> >
> >  .SH SEE ALSO
> >  .BR vdpa (8),
> > diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
> > index 8586bd17..bc23c731 100644
> > --- a/vdpa/include/uapi/linux/vdpa.h
> > +++ b/vdpa/include/uapi/linux/vdpa.h
> > @@ -19,6 +19,7 @@ enum vdpa_command {
> >       VDPA_CMD_DEV_GET,               /* can dump */
> >       VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> >       VDPA_CMD_DEV_VSTATS_GET,
> > +     VDPA_CMD_DEV_ATTR_SET,
> >  };
> >
> >  enum vdpa_attr {
> > diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> > index 6e4a9c11..4b444b6a 100644
> > --- a/vdpa/vdpa.c
> > +++ b/vdpa/vdpa.c
> > @@ -758,6 +758,22 @@ static int cmd_dev_del(struct vdpa *vdpa,  int argc,
> > char **argv)
> >       return mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL);  }
> >
> > +static int cmd_dev_set(struct vdpa *vdpa, int argc, char **argv) {
> > +     struct nlmsghdr *nlh;
> > +     int err;
> > +
> > +     nlh = mnlu_gen_socket_cmd_prepare(&vdpa->nlg,
> > VDPA_CMD_DEV_ATTR_SET,
> > +                                       NLM_F_REQUEST | NLM_F_ACK);
> > +     err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
> > +                               VDPA_OPT_VDEV_NAME,
> > +
> > VDPA_OPT_VDEV_MAC|VDPA_OPT_VDEV_MTU);
> > +     if (err)
> > +             return err;
> > +
> > +     return mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL); }
> > +
> >  static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)  {
> >       SPRINT_BUF(macaddr);
> > @@ -1028,6 +1044,9 @@ static int cmd_dev(struct vdpa *vdpa, int argc, char
> > **argv)
> >       } else if (!strcmp(*argv, "vstats")) {
> >               return cmd_dev_vstats(vdpa, argc - 1, argv + 1);
> >       }
> > +     else if (!strcmp(*argv, "set")) {
> > +             return cmd_dev_set(vdpa, argc - 1, argv + 1);
> > +     }
> Else if can be in the previous line.
>
Thanks will fix this
Thanks
Cindy
> >       fprintf(stderr, "Command \"%s\" not found\n", *argv);
> >       return -ENOENT;
> >  }
> > --
> > 2.45.0
>


