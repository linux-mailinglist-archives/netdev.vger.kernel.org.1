Return-Path: <netdev+bounces-183491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C54A90D06
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D2D7A7FA3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E45A22A4E4;
	Wed, 16 Apr 2025 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l6tl+LfK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFD21506C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834928; cv=none; b=BepZO4OPbTTRTMXuktRSf90mvc34t97eLDOprAuxuvINd4hJ0ALL4zZYmWwuMC0b4Lsa31W7KJQ0hcDY5nSZEO1lYe6tkfBIDUcD21BiqmzEHBg5kXiDWfiI7xLwUeOVz5/ZWgnbvTqXc7JXMUjKFLOmWbtDr9P7KI4NZr3beZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834928; c=relaxed/simple;
	bh=YVNHzuF/FXivch+ALQNRCf8wamVj9nSiQ0vXbzvFBLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBQhYdtyuZDQ7TIqSdIaKOkNn1sg8KlDDLQtcOTu4Eg2+OaNGdCbBXCJQ7ShLnsZDMtVnL/vzsdA5qGaGhBEFFHDyja/h6WQeoKVjrYbWTkplT6+OWaq92/vgIsVHRzMU7fLEGmKwX/DxOYedg7XBoYnk8sIWHE/DhUmjMufgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l6tl+LfK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9mJr8003636
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4nWdh5ji9JkbTEF4QgyJQmaNVYWFSQtMEy/xVq3CxYA=; b=l6tl+LfKddZLhr4j
	qgeNiBYdZ8y4QMhxdprwajlq3ZQ7YZU2NsgmsEdsE5ui0Q3y2MRWBLH1lCp9MkEi
	n4ElNvylXByAoR7l2fdYApHpXFe2HfpHzK8LZfAvDQQt0daDa4H5y1VYwiMDJEBC
	woYYV9HpGBfpZDDY+6jCmuHi1/KAlppnrAwshjaAUCeWOFKmyjEP3FDXdpqXdiGr
	ONwg9T62Bnn2iVjRbjKWFn6zd04dmZ1bKAvhaDWFvFbJKqEaMb4uXkkPGwITWdrf
	+u3cSvaGJ2OtgfEcBedfRnwcc50rL8rJeyaofdkQLeHpn/bynKBMNlapxCwHZiRT
	+Nxbew==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rv9yx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:22:05 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f2af3128b0so1848526d6.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744834924; x=1745439724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nWdh5ji9JkbTEF4QgyJQmaNVYWFSQtMEy/xVq3CxYA=;
        b=bej7y6kiBW4jXaGGjqFKjZmpQk60FaxR7vg1SjIGcH88rG4XhoZB1oAvIppdg1tiRS
         2FR9LzHzXV1DBbN72tn+0waEaqriyG7JXqx44oxbqoig/sktWilHD109VwOwVDm9E9jL
         1BQcwjF+Fc2KF5dTzhcAR3WDbarP0d6N0hgGR7bWiqvqHQXKxvwY3aOwh3y65+iy7DrX
         QvyxXyXO7z5bdgChIBVOIFVtMVkPqzSQ1PtkATp/BDayuRdOBfqLbQxoALZgN0Bh0CzK
         9RUg/o6RdgHKgdjb4MJSivOBnZtpndrxNxKwesAZREucJLVksSLHd2vdM+1/xFL8uEcr
         AtHw==
X-Forwarded-Encrypted: i=1; AJvYcCWYzXy9COPC+QPXQ7YCqabt0DBzEoO+0cLmgTpFodC/3lRkcSWiceT+UYInNq97pOgLLiE0a4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbfQ7S8ngt9KF53vPGZFbskxMG1tWMLJQniR4SavRaVzHPewvB
	f1T8y3z4KSpLSIa3+0FRpLFRnmkR9VKX7rvYOGet1cSM6m6SPK0dexeEbJdrdiUgxCmflAxN6T3
	i7G0u2tkeJKGgjTxoEdlRK4fDWcSYSYM2zAK2dTk4GJnASjM3zBQm0ZphMr5E6R2CkOTFN7AIVd
	CVvL0o5FelMs0UX73OzkRGGuM95ZWjbw==
X-Gm-Gg: ASbGnctZAN0BlAOLhSwrxcWDn+17KXY7CYHbwc84jZN2wU/4AV7GhFuLgahkw3gD7uN
	vtBtB3CvdJrkzKdNvnhBsqnneoGeV5C/VfK4Z6wIDpabyv9u/87v2cQLUwxnG28Bes4re2tph3T
	RgBE3xwDidMMc5S0wAIAsNDVM=
X-Received: by 2002:a05:6214:2349:b0:6e8:9bcd:bba6 with SMTP id 6a1803df08f44-6f2b2f23a80mr46433616d6.7.1744834924250;
        Wed, 16 Apr 2025 13:22:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeGLdGR0YgFgD2FAz7aWV7l8ut1T8Q2JdrmnAC3JUhfTtg6DgpkAKUxMRdrbUctmQFbUtWk2kUQU2IvJXuUk0=
X-Received: by 2002:a05:6214:2349:b0:6e8:9bcd:bba6 with SMTP id
 6a1803df08f44-6f2b2f23a80mr46433326d6.7.1744834923950; Wed, 16 Apr 2025
 13:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
 <20250408233118.21452-4-ryazanov.s.a@gmail.com> <CAFEp6-2MxMohojOeSPzcuP_Fs0fps1EBGHKGcoHSUt+9fMLqJQ@mail.gmail.com>
 <0e061258-b7d1-47ca-b0d2-5e8a815136af@gmail.com>
In-Reply-To: <0e061258-b7d1-47ca-b0d2-5e8a815136af@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 22:21:53 +0200
X-Gm-Features: ATxdqUE6R9UxUkBhSDL7fk5XCpoXaZE6IkGKkYSqYFHTxAb6hW1ZwPRfqb9s6WI
Message-ID: <CAFEp6-0s21Xo7bGW9OYwwBGcKE7-W8hv8BUbh_CQScPfbrWniw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] net: wwan: core: split port unregister and stop
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SOP-I2L8_fv9uY2S5XtxT3u6UWwHFAwh
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=6800116d cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=8tMkpneb8U_0UXTVT7oA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: SOP-I2L8_fv9uY2S5XtxT3u6UWwHFAwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_08,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160166

On Mon, Apr 14, 2025 at 11:33=E2=80=AFPM Sergey Ryazanov <ryazanov.s.a@gmai=
l.com> wrote:
>
> On 14.04.2025 21:54, Loic Poulain wrote:
> > On Wed, Apr 9, 2025 at 1:31=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gm=
ail.com> wrote:
> >>
> >> Upcoming GNSS (NMEA) port type support requires exporting it via the
> >> GNSS subsystem. On another hand, we still need to do basic WWAN core
> >> work: call the port stop operation, purge queues, release the parent
> >> WWAN device, etc. To reuse as much code as possible, split the port
> >> unregistering function into the deregistration of a regular WWAN port
> >> device, and the common port tearing down code.
> >>
> >> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> >> ---
> >>   drivers/net/wwan/wwan_core.c | 21 ++++++++++++++++-----
> >>   1 file changed, 16 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core=
.c
> >> index 045246d7cd50..439a57bc2b9c 100644
> >> --- a/drivers/net/wwan/wwan_core.c
> >> +++ b/drivers/net/wwan/wwan_core.c
> >> @@ -486,6 +486,18 @@ static int wwan_port_register_wwan(struct wwan_po=
rt *port)
> >>          return 0;
> >>   }
> >>
> >> +/* Unregister regular WWAN port (e.g. AT, MBIM, etc) */
> >> +static void wwan_port_unregister_wwan(struct wwan_port *port)
> >
> > Wouldn't it be simpler to name it  `wwan_port_unregister` ?
>
> I came with this complex name for a symm>
> >> +{
> >> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> >> +
> >> +       dev_set_drvdata(&port->dev, NULL);
> >> +
> >> +       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&po=
rt->dev));
> >> +
> >> +       device_unregister(&port->dev);
> >> +}
> >> +
> >>   struct wwan_port *wwan_create_port(struct device *parent,
> >>                                     enum wwan_port_type type,
> >>                                     const struct wwan_port_ops *ops,
> >> @@ -542,18 +554,17 @@ void wwan_remove_port(struct wwan_port *port)
> >>          struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent)=
;
> >>
> >>          mutex_lock(&port->ops_lock);
> >> -       if (port->start_count)
> >> +       if (port->start_count) {
> >>                  port->ops->stop(port);
> >> +               port->start_count =3D 0;
> >> +       }
> >>          port->ops =3D NULL; /* Prevent any new port operations (e.g. =
from fops) */
> >>          mutex_unlock(&port->ops_lock);
> >>
> >>          wake_up_interruptible(&port->waitqueue);
> >> -
> >>          skb_queue_purge(&port->rxq);
> >> -       dev_set_drvdata(&port->dev, NULL);
> >>
> >> -       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&po=
rt->dev));
> >> -       device_unregister(&port->dev);
> >> +       wwan_port_unregister_wwan(port);
> >>
> >>          /* Release related wwan device */
> >>          wwan_remove_dev(wwandev);
> >> --
> >> 2.45.3
> >>
>etry purpose. The next patch
> going to introduce wwan_port_unregister_gnss() handler.
>
> The prefix indicates the module and the suffix indicates the type of the
> unregistering port.

Ok, fair enough.

