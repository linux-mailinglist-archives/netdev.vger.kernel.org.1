Return-Path: <netdev+bounces-183905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F46A92C51
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 22:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2D33AE095
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C537205E3E;
	Thu, 17 Apr 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ay0ss+4b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415041C63
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744922129; cv=none; b=IN7QkAXlDGwxnA8wR67MUThyLaCt98vq7cevaFjex3Jp3Bnefo9ANqdvbee5VFRH7AX+gjWHSVqbGpjhs5l8sDIsa2CMZdVB2RjYym/Fcj7r5d7zsjwCvH1+GDnbZGhOFnyXVuU8hX9DubC3jFfDV+rlgmHNEu029MZuT8/zCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744922129; c=relaxed/simple;
	bh=KbKwOTjq6CzM2OWJudkstek9spd05Yk1JsRoenm8DFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qg2Gijw10VEGJl8FJgk46GbF+YX8lvzmd7Hmrv0ZwlxblQfL9pZDjhc0ly85/zYpLI3EJTrDEyvF8KjPoVJS5vX3MfrxceoFSD13zqssNB2sbmKz0rXpAwIJ5tRgD1O3SyQ533UjiFbhcWaUFRkR0oA9F3Fciwme0OXXc5JpESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ay0ss+4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClNTS015925
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 20:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sXhsefugUjpix/1sUBhHK6UiBBY1obH/vScuV8boUuM=; b=Ay0ss+4bDWzk/Olm
	s9IDxufThs0QZKbRwKcuBBgZtjIKowSgrFgl2Wsq3FsZQz2W52/naoZOqtvsriG5
	hNE+DymA4Ckjgtm6rf/eHBYgkh8XL0OElyHcdNjdSHKCXqPm895Jux4jfGZpkJNq
	4Rz9hNeKp8rn2GQSQQkiysOkwjGyr4oJ1sH8F0Ei0Yby0vvDjMqqC1junLBG7RaY
	t3bsMRV1tPCnKhmA8TFUoMwJFsY7MGHq6Y2s4A7Eg9mhVAwaPN1+GPOwGNobOZHe
	nsUNXi+nBw+tj88Mzv0v0gbNjPe2wjH12FEM6K9GLkuYlLLk6LITCPDowzlEri7p
	Le/uIA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqgdhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 20:35:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4768f9fea35so25894431cf.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 13:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744922119; x=1745526919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXhsefugUjpix/1sUBhHK6UiBBY1obH/vScuV8boUuM=;
        b=Wd4LYrih/qYo+Cju01cRSbmjPrBnqJbIiitTdXJAhJTPoPuBCvmaPTOkmWs/rcLx6A
         dZd2enc1hXnrH+db2ZFH0yTzGQC5qRvGP9S4zYM9Ksnc/QDY5bYAyI+AT0/cJ/3FOjLz
         m4kQ/gfrPDes5v9DTJZI/eHFgVN2OE4W6jl3X8x94W4aUSrhQ8vEtnX73fxSjfzIuu6o
         z7L7Rp8qZ1yagK1Tlfkz+eKgKbwl55TKSJHUdNEfeIvbFNlW5sezUXmHuZYt9S8xjltq
         /Kwzf5ib0F8gsNRdigrM5ni/qwlDPJZiaIKQmrzAq/SfY7Tft7hM3ImnqZvayBJc0iac
         aTnw==
X-Forwarded-Encrypted: i=1; AJvYcCXO3Ur23bYjy2RarXb+j8eiJcffta7eO/9HGSYnlRzy/eiXKBpAFyIVhX7IlsQx6ch49Lfum04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvvoOgjigIeYNcV29o9B2oGx8Oyp4sfb7zAUrNDcglQVyiAlpJ
	sDtgY1Y4F8HNPpBmBDbBZZ2yQBHe2XcQLc57kAGJqboXshHgcNCluttsjOBKowqXD4BBu6djcBn
	mOeSu70x/hSLj1NBqpa6JvCI/tSRTL4M1Hp5VzTILbaO8jg9vQuecWFlHbx7T3b0r027disQaoH
	RtygPbwGb0uHLUAv9MJtcRPcJUQH15iw==
X-Gm-Gg: ASbGnctcab9EZ3GqsnMm9oLCrv1QgRbVEElB1exx7N7Ndy6SUYUeKz4ymaKaN7rjKk5
	sZfA4faD3JgTa1drsHoiMtUJGMQyn9BvMzTb4cOIPj/anAcm7DhEQPU/pz8cOXEEBydOCJg==
X-Received: by 2002:ac8:584b:0:b0:476:78a8:435c with SMTP id d75a77b69052e-47aec3a7308mr3917861cf.16.1744922119307;
        Thu, 17 Apr 2025 13:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3mQvusl6knz/ktKYfXg+rElzPVnvWQTTsxvnEZPYhiVJhCMZiiRuxQEHjpPmt1ObSAsU/eis+nyiTTZT1cOg=
X-Received: by 2002:ac8:584b:0:b0:476:78a8:435c with SMTP id
 d75a77b69052e-47aec3a7308mr3917391cf.16.1744922118908; Thu, 17 Apr 2025
 13:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
 <20250408233118.21452-3-ryazanov.s.a@gmail.com> <CAFEp6-0kBH2HMVAWK_CAoo-Hd3FU8k-54L1tzvBnqs=eS39Gkg@mail.gmail.com>
 <a43d7bce-5f70-4d69-8bad-c65976245996@gmail.com>
In-Reply-To: <a43d7bce-5f70-4d69-8bad-c65976245996@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 22:35:08 +0200
X-Gm-Features: ATxdqUH6YvdA3f6hKjklY5yCfzbw4wGJoItwxDCloBbZLZgkQbciKnofKxxR5D8
Message-ID: <CAFEp6-1veH3N+eVw2Bc+=2ZhrQAzTcU8Lw9fHTmY2334gaDBSg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] net: wwan: core: split port creation and registration
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: tO5MeuEmgP_YD7n1C0il4BlU0pX8CYoQ
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=68016608 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=zUZdmBzElhmFca4KCPEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: tO5MeuEmgP_YD7n1C0il4BlU0pX8CYoQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170151

Hi Sergey,

On Mon, Apr 14, 2025 at 11:28=E2=80=AFPM Sergey Ryazanov <ryazanov.s.a@gmai=
l.com> wrote:
>
> Hi Loic,
>
> thank you that you found a time to check it. See the explanation below,
> might be you can suggest a better solution.
>
> On 14.04.2025 21:50, Loic Poulain wrote:
> > Hi Sergey,
> >
> > On Wed, Apr 9, 2025 at 1:31=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gm=
ail.com> wrote:
> >>
> >> Upcoming GNSS (NMEA) port type support requires exporting it via the
> >> GNSS subsystem. On another hand, we still need to do basic WWAN core
> >> work: find or allocate the WWAN device, make it the port parent, etc. =
To
> >> reuse as much code as possible, split the port creation function into
> >> the registration of a regular WWAN port device, and basic port struct
> >> initialization.
> >>
> >> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> >> ---
> >>   drivers/net/wwan/wwan_core.c | 86 ++++++++++++++++++++++------------=
--
> >>   1 file changed, 53 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core=
.c
> >> index ade8bbffc93e..045246d7cd50 100644
> >> --- a/drivers/net/wwan/wwan_core.c
> >> +++ b/drivers/net/wwan/wwan_core.c
> >> @@ -357,16 +357,19 @@ static struct attribute *wwan_port_attrs[] =3D {
> >>   };
> >>   ATTRIBUTE_GROUPS(wwan_port);
> >>
> >> -static void wwan_port_destroy(struct device *dev)
> >> +static void __wwan_port_destroy(struct wwan_port *port)
> >>   {
> >> -       struct wwan_port *port =3D to_wwan_port(dev);
> >> -
> >> -       ida_free(&minors, MINOR(port->dev.devt));
> >>          mutex_destroy(&port->data_lock);
> >>          mutex_destroy(&port->ops_lock);
> >>          kfree(port);
> >>   }
> >>
> >> +static void wwan_port_destroy(struct device *dev)
> >> +{
> >> +       ida_free(&minors, MINOR(dev->devt));
> >> +       __wwan_port_destroy(to_wwan_port(dev));
> >> +}
> >> +
> >>   static const struct device_type wwan_port_dev_type =3D {
> >>          .name =3D "wwan_port",
> >>          .release =3D wwan_port_destroy,
> >> @@ -440,6 +443,49 @@ static int __wwan_port_dev_assign_name(struct wwa=
n_port *port, const char *fmt)
> >>          return dev_set_name(&port->dev, "%s", buf);
> >>   }
> >>
> >> +/* Register a regular WWAN port device (e.g. AT, MBIM, etc.)
> >> + *
> >> + * NB: in case of error function frees the port memory.
> >> + */
> >> +static int wwan_port_register_wwan(struct wwan_port *port)
> >> +{
> >> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> >> +       char namefmt[0x20];
> >> +       int minor, err;
> >> +
> >> +       /* A port is exposed as character device, get a minor */
> >> +       minor =3D ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP=
_KERNEL);
> >> +       if (minor < 0) {
> >> +               __wwan_port_destroy(port);
> >
> > I see this is documented above, but it's a bit weird that the port is
> > freed inside the register function, it should be up to the caller to
> > do this. Is there a reason for this?
>
> I agree that this looks weird and asymmetrical. I left the port
> allocation in wwan_create_port() because both WWAN-exported and
> GNSS-exported types of port share the same port allocation. And the port
> struct is used as a container to keep all the port registration arguments=
.
>
> I did the port freeing inside this function because we free the port
> differently depending of the device registration state. If we fail to
> initialize the port at earlier stage then we use __wwan_port_destroy()
> which basically just releases the memory.
>
> But if device_register() fails then we are required to use put_device()
> which does more job.
>
> I do not think it is acceptable to skip put_device() call and just
> release the memory. Also I do not find maintainable to partially open
> code put_device() here in the WWAN-exportable handler and release the
> memory in caller function wwan_create_port().
>
> We could somehow try to return this information from
> wwan_port_register_wwan() to wwan_create_port(), so the caller could
> decide, shall it use __wwan_port_destroy() or put_device() in case of
> failure.
>
> But I can not see a way to clearly indicate, which releasing approach
> should be used by the caller. And even in this case it going to look
> weird since the called function controls the caller.
>
> Another solution for the asymmetry problem is to move the allocation
> from the caller to the called function. So the memory will be allocated
> and released in the same function. But in this case we will need to pass
> all the parameters from wwan_create_port() to wwan_port_register_wwan().
> Even if we consolidate the port basic allocation/initialization in a
> common routine, the final solution going to look a duplication. E.g.
>
> struct wwan_port *wwan_port_allocate(struct wwan_device *wwandev,
>                                       enum wwan_port_type type,
>                                       const struct wwan_port_ops *ops,
>                                       struct wwan_port_caps *caps,
>                                       void *drvdata)
> {
>      /* Do the mem allocation and init here */
>      return port;
> }
>
> struct wwan_port *wwan_port_register_wwan(struct wwan_device *wwandev,
>                         enum wwan_port_type type,
>                         const struct wwan_port_ops *ops,
>                         struct wwan_port_caps *caps,
>                         void *drvdata)
> {
>      port =3D wwan_port_allocate(wwandev, type, ops, caps, drvdata);
>      /* Proceed with chardev registration or release on failure */
>      /* return port; or return ERR_PTR(-err); */
> }
>
> struct wwan_port *wwan_port_register_gnss(struct wwan_device *wwandev,
>                         enum wwan_port_type type,
>                         const struct wwan_port_ops *ops,
>                         struct wwan_port_caps *caps,
>                         void *drvdata)
> {
>      port =3D wwan_port_allocate(wwandev, type, ops, caps, drvdata);
>      /* Proceed with GNSS registration or release on failure */
>      /* return port; or return ERR_PTR(-err); */
> }
>
> struct wwan_port *wwan_create_port(struct device *parent,
>                                     enum wwan_port_type type,
>                                     const struct wwan_port_ops *ops,
>                                     struct wwan_port_caps *caps,
>                                     void *drvdata)
> {
>      ...
>      wwandev =3D wwan_create_dev(parent);
>      if (type =3D=3D WWAN_PORT_NMEA)
>          port =3D wwan_port_register_gnss(wwandev, type, ops,
>                                         caps, drvdata);
>      else
>          port =3D wwan_port_register_wwan(wwandev, type, ops,
>                                         caps, drvdata);
>      if (!IS_ERR(port))
>          return port;
>      wwan_remove_dev(wwandev);
>      return ERR_CAST(port);
> }
>
> wwan_create_port() looks better in prices of passing a list of arguments
> and allocating the port in multiple places.
>
> Maybe some other design approach, what was overseen?
>
>
> For me, the ideal solution would be a routine that works like
> put_device() except calling the device type release handler. Then we can
> use it to cleanup leftovers of the failed device_register() call and
> then release the memory in the calling wwan_create_port() function.

Ok I see, thanks for the clear explanation, I don't see a perfect
solution here without over complication. So the current approach is
acceptable, can you add a comment in the caller function as well,so
that it's clear why we don't have to release the port on error.

