Return-Path: <netdev+bounces-184281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB542A94329
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 13:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C4A17B927
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5197F1D6DB9;
	Sat, 19 Apr 2025 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OFycQHSA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975613C695
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063097; cv=none; b=f9UUinu0tQQF+SxyLvxzDZgQ4cX7xH52Hiwpm5mitsG1TCWU4pOYooXDOhMNw0duSmls7i5ObEaSo8qFcPHbKGere0Q85wJ5GT5HQUMWks0bfh3qeltV+m5eZ2zzdVrBrrtGxWjwGZ0hW40iBzjNE2iqzUWALNmUTm3O7x6gauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063097; c=relaxed/simple;
	bh=jRvWtqa3IIEYwZeCGnqgaOJ8z+O5VH/bduBt6HwZJAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkCzZy4wZQka8nfmpNKpt1y/kpYiepc0SXprWJJJWkxoWHYIETQ7IdnVOr70yACQtZnMJqmuwM9rzWeaEuK0TKfVK4DOVzRSm9SYdEaxXrziJRfChqeqEOXlVh7kj3eNNAsap3mqS7I5cZ5ydxLqyjdUzZc3RXrv71d7PFDQfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OFycQHSA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JANqcO021173
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 11:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5EPxX4JdrLzmQ4HECvt79Cirr45XVjnXqHejUgFoNUM=; b=OFycQHSAYem22JjL
	f8Ap1w/lkIV6PnOs5bIEhJJ18jv2KrECI3UKwPZvEiKjBgLReMtPgkiElPwbLXSH
	DLMvjXahiRbdEQqZIq34x0AUiUGYQPy4BrmJ2L3gYEdvwfvZ1VF7f56TDSpt7/Jj
	A/PU/itn+uZU66mharRzbwDfXehgIXqX1owmacs4a893xQzhB/Rlq8I/ce4slpML
	vrI38b/kfi/tggzbVlsqnnoiJpmbIPn89a0GVcQqQQewjikE29fX1Kwboow08W02
	LNbpd0XaBrlGkIA8zniCw2NfC8V6YS8nCZGr6bETyiXtJWvWFbo19PRLPFkZ/e7q
	437toQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4642sv8hc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 11:44:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c544d2c34fso343459785a.1
        for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 04:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745063086; x=1745667886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EPxX4JdrLzmQ4HECvt79Cirr45XVjnXqHejUgFoNUM=;
        b=YumCPBTVfkEjVGD4rX9qec43HS1finzYA3ligNeI1FoioL+5CBXPjGYwfatd5g0Mjo
         2un1tA2v9xwfBVSaTRAvuUv9FHKG0fCpi+ctWOcqBJhbv1wxpBrTx3jZO5rBhD3PK6rM
         PG8ggrj9HtBL4UtVTEBeiqb0qp/EuyO8vKLwN8dqRgRyZLPjXT8k6C6VflvC4cmfPaQU
         Mk5dpphgHPQPfJqJrgQBvxCmiG3gjdNw3YTemFk2SR4wt6rW9xhjPDTKHa/XD1vX/TDL
         BcmpVTyLeDL9risYrXqPZOICyKRAYH2oiUoPADLkqcKhOylv7l3XEFNPpgjbpvW8gOqb
         /ifw==
X-Forwarded-Encrypted: i=1; AJvYcCVZgyDNFT2rApkzZpn5YXH+zfbujVXTuJ+YmhaQpEGOUIdNm/lE720RZhJWlZsjIYqaIk0c8cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyga4ec3u8Uko9yAF4eOdoAqxnfWxBWN91udHeWfa6/S/57y6jS
	jkTWNqhWfsHWc6Jn8Xf+kTmW2flMMFozKp20G6xnsWcOfq/gOZkZwWETAHzMNc5Hny4rEAwLBrF
	/J0XJOFibVdnDa5DE3nvgbeQLBJWRbkl8FMDHuJgBwqwU3zbPLG6eCsxB238/nsQK3J6EN72ff1
	sRXTOjyDzrDrbNICA6q5lOzmv9H7pJHw==
X-Gm-Gg: ASbGncsMthuAbi25zpbsLzSvXrc7Lp6QBPKvQEj6MvP4eMRb8ldonnzgqXggtXd8hRs
	esuPe8CiuQAqZY+oSwqZtsVDFjDbQkQ8xTKHKK5bjTdnPoRwC8PypRv3vfyqu9Q5Q9O5w4mQ=
X-Received: by 2002:a05:620a:4551:b0:7c5:55be:7bf8 with SMTP id af79cd13be357-7c9280185e7mr826170985a.38.1745063086390;
        Sat, 19 Apr 2025 04:44:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCGqWEFqS5KUl7ShkS2cBtOsuVX3tkgBApN/1MLl1tp3WM2NgoxpxHh6V6JAuFDpqliAcFIP1kn+Ere1fV34g=
X-Received: by 2002:a05:620a:4551:b0:7c5:55be:7bf8 with SMTP id
 af79cd13be357-7c9280185e7mr826168385a.38.1745063085953; Sat, 19 Apr 2025
 04:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
 <20250408233118.21452-3-ryazanov.s.a@gmail.com> <CAFEp6-0kBH2HMVAWK_CAoo-Hd3FU8k-54L1tzvBnqs=eS39Gkg@mail.gmail.com>
 <a43d7bce-5f70-4d69-8bad-c65976245996@gmail.com> <CAFEp6-1veH3N+eVw2Bc+=2ZhrQAzTcU8Lw9fHTmY2334gaDBSg@mail.gmail.com>
 <9b36d9b6-c2da-43ef-a958-167c663792e4@gmail.com>
In-Reply-To: <9b36d9b6-c2da-43ef-a958-167c663792e4@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 19 Apr 2025 13:44:35 +0200
X-Gm-Features: ATxdqUFgeB8qmypZY6Q80hOkVGU_mX3q_C1mXztuREHS3djd-sfg7MGoVjN3jvI
Message-ID: <CAFEp6-2n13+Q5sjatgjjgG0vFP28PSiH8PoOJBNB-u9HX04ObQ@mail.gmail.com>
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
X-Proofpoint-GUID: HFLNhgSLC-Fh6ucMkdggUkktFCxoxCB7
X-Proofpoint-ORIG-GUID: HFLNhgSLC-Fh6ucMkdggUkktFCxoxCB7
X-Authority-Analysis: v=2.4 cv=QLJoRhLL c=1 sm=1 tr=0 ts=68038cb0 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=fHxVcCfG2Z9CPQV0kHgA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504190095

On Sat, Apr 19, 2025 at 1:04=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gmail=
.com> wrote:
>
> Hi Loic,
>
> please find one extra option below.
>
> On 17.04.2025 23:35, Loic Poulain wrote:
> > Hi Sergey,
> >
> > On Mon, Apr 14, 2025 at 11:28=E2=80=AFPM Sergey Ryazanov <ryazanov.s.a@=
gmail.com> wrote:
> >>
> >> Hi Loic,
> >>
> >> thank you that you found a time to check it. See the explanation below=
,
> >> might be you can suggest a better solution.
> >>
> >> On 14.04.2025 21:50, Loic Poulain wrote:
> >>> Hi Sergey,
> >>>
> >>> On Wed, Apr 9, 2025 at 1:31=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@=
gmail.com> wrote:
> >>>>
> >>>> Upcoming GNSS (NMEA) port type support requires exporting it via the
> >>>> GNSS subsystem. On another hand, we still need to do basic WWAN core
> >>>> work: find or allocate the WWAN device, make it the port parent, etc=
. To
> >>>> reuse as much code as possible, split the port creation function int=
o
> >>>> the registration of a regular WWAN port device, and basic port struc=
t
> >>>> initialization.
> >>>>
> >>>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> >>>> ---
> >>>>    drivers/net/wwan/wwan_core.c | 86 ++++++++++++++++++++++---------=
-----
> >>>>    1 file changed, 53 insertions(+), 33 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_co=
re.c
> >>>> index ade8bbffc93e..045246d7cd50 100644
> >>>> --- a/drivers/net/wwan/wwan_core.c
> >>>> +++ b/drivers/net/wwan/wwan_core.c
> >>>> @@ -357,16 +357,19 @@ static struct attribute *wwan_port_attrs[] =3D=
 {
> >>>>    };
> >>>>    ATTRIBUTE_GROUPS(wwan_port);
> >>>>
> >>>> -static void wwan_port_destroy(struct device *dev)
> >>>> +static void __wwan_port_destroy(struct wwan_port *port)
> >>>>    {
> >>>> -       struct wwan_port *port =3D to_wwan_port(dev);
> >>>> -
> >>>> -       ida_free(&minors, MINOR(port->dev.devt));
> >>>>           mutex_destroy(&port->data_lock);
> >>>>           mutex_destroy(&port->ops_lock);
> >>>>           kfree(port);
> >>>>    }
> >>>>
> >>>> +static void wwan_port_destroy(struct device *dev)
> >>>> +{
> >>>> +       ida_free(&minors, MINOR(dev->devt));
> >>>> +       __wwan_port_destroy(to_wwan_port(dev));
> >>>> +}
> >>>> +
> >>>>    static const struct device_type wwan_port_dev_type =3D {
> >>>>           .name =3D "wwan_port",
> >>>>           .release =3D wwan_port_destroy,
> >>>> @@ -440,6 +443,49 @@ static int __wwan_port_dev_assign_name(struct w=
wan_port *port, const char *fmt)
> >>>>           return dev_set_name(&port->dev, "%s", buf);
> >>>>    }
> >>>>
> >>>> +/* Register a regular WWAN port device (e.g. AT, MBIM, etc.)
> >>>> + *
> >>>> + * NB: in case of error function frees the port memory.
> >>>> + */
> >>>> +static int wwan_port_register_wwan(struct wwan_port *port)
> >>>> +{
> >>>> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent=
);
> >>>> +       char namefmt[0x20];
> >>>> +       int minor, err;
> >>>> +
> >>>> +       /* A port is exposed as character device, get a minor */
> >>>> +       minor =3D ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, G=
FP_KERNEL);
> >>>> +       if (minor < 0) {
> >>>> +               __wwan_port_destroy(port);
> >>>
> >>> I see this is documented above, but it's a bit weird that the port is
> >>> freed inside the register function, it should be up to the caller to
> >>> do this. Is there a reason for this?
> >>
> >> I agree that this looks weird and asymmetrical. I left the port
> >> allocation in wwan_create_port() because both WWAN-exported and
> >> GNSS-exported types of port share the same port allocation. And the po=
rt
> >> struct is used as a container to keep all the port registration argume=
nts.
> >>
> >> I did the port freeing inside this function because we free the port
> >> differently depending of the device registration state. If we fail to
> >> initialize the port at earlier stage then we use __wwan_port_destroy()
> >> which basically just releases the memory.
> >>
> >> But if device_register() fails then we are required to use put_device(=
)
> >> which does more job.
> >>
> >> I do not think it is acceptable to skip put_device() call and just
> >> release the memory. Also I do not find maintainable to partially open
> >> code put_device() here in the WWAN-exportable handler and release the
> >> memory in caller function wwan_create_port().
> >>
> >> We could somehow try to return this information from
> >> wwan_port_register_wwan() to wwan_create_port(), so the caller could
> >> decide, shall it use __wwan_port_destroy() or put_device() in case of
> >> failure.
> >>
> >> But I can not see a way to clearly indicate, which releasing approach
> >> should be used by the caller. And even in this case it going to look
> >> weird since the called function controls the caller.
> >>
> >> Another solution for the asymmetry problem is to move the allocation
> >> from the caller to the called function. So the memory will be allocate=
d
> >> and released in the same function. But in this case we will need to pa=
ss
> >> all the parameters from wwan_create_port() to wwan_port_register_wwan(=
).
> >> Even if we consolidate the port basic allocation/initialization in a
> >> common routine, the final solution going to look a duplication. E.g.
> >>
> >> struct wwan_port *wwan_port_allocate(struct wwan_device *wwandev,
> >>                                        enum wwan_port_type type,
> >>                                        const struct wwan_port_ops *ops=
,
> >>                                        struct wwan_port_caps *caps,
> >>                                        void *drvdata)
> >> {
> >>       /* Do the mem allocation and init here */
> >>       return port;
> >> }
> >>
> >> struct wwan_port *wwan_port_register_wwan(struct wwan_device *wwandev,
> >>                          enum wwan_port_type type,
> >>                          const struct wwan_port_ops *ops,
> >>                          struct wwan_port_caps *caps,
> >>                          void *drvdata)
> >> {
> >>       port =3D wwan_port_allocate(wwandev, type, ops, caps, drvdata);
> >>       /* Proceed with chardev registration or release on failure */
> >>       /* return port; or return ERR_PTR(-err); */
> >> }
> >>
> >> struct wwan_port *wwan_port_register_gnss(struct wwan_device *wwandev,
> >>                          enum wwan_port_type type,
> >>                          const struct wwan_port_ops *ops,
> >>                          struct wwan_port_caps *caps,
> >>                          void *drvdata)
> >> {
> >>       port =3D wwan_port_allocate(wwandev, type, ops, caps, drvdata);
> >>       /* Proceed with GNSS registration or release on failure */
> >>       /* return port; or return ERR_PTR(-err); */
> >> }
> >>
> >> struct wwan_port *wwan_create_port(struct device *parent,
> >>                                      enum wwan_port_type type,
> >>                                      const struct wwan_port_ops *ops,
> >>                                      struct wwan_port_caps *caps,
> >>                                      void *drvdata)
> >> {
> >>       ...
> >>       wwandev =3D wwan_create_dev(parent);
> >>       if (type =3D=3D WWAN_PORT_NMEA)
> >>           port =3D wwan_port_register_gnss(wwandev, type, ops,
> >>                                          caps, drvdata);
> >>       else
> >>           port =3D wwan_port_register_wwan(wwandev, type, ops,
> >>                                          caps, drvdata);
> >>       if (!IS_ERR(port))
> >>           return port;
> >>       wwan_remove_dev(wwandev);
> >>       return ERR_CAST(port);
> >> }
> >>
> >> wwan_create_port() looks better in prices of passing a list of argumen=
ts
> >> and allocating the port in multiple places.
> >>
> >> Maybe some other design approach, what was overseen?
> >>
> >>
> >> For me, the ideal solution would be a routine that works like
> >> put_device() except calling the device type release handler. Then we c=
an
> >> use it to cleanup leftovers of the failed device_register() call and
> >> then release the memory in the calling wwan_create_port() function.
> >
> > Ok I see, thanks for the clear explanation, I don't see a perfect
> > solution here without over complication. So the current approach is
> > acceptable, can you add a comment in the caller function as well,so
> > that it's clear why we don't have to release the port on error.
>
> Looks like I've found another one solution to move the port resources
> (memory) release back to the function allocating it. It is also a bit
> hackish and I would like to hear a feedback from you.
>
> The port is released inside wwan_port_register_wwan() just because we
> release it differently depending on the initialization stage, right?
>
> We cannot call put_device() before the device_register() call. And that
> is why I've created that __wwan_port_destroy() routine. What if we make
> port eligible to be released with put_device() ASAP? Internally,
> device_register() just sequentially calls device_initialize() and then
> device_add(). Indeed, device_initialize() makes a device struct eligible
> to be released with put_device().
>
> We can avoid using device_register() and instead of it, do the
> registration step by step. Just after the port memory allocation and
> very basic initialization, we can call device_initialize(). And then
> call device_add() when it is time to register the port with the kernel.
> And if something going to go wrong, we can return just an error from
> wwan_port_register_wwan() and release the port with put_device() in
> wwan_create_port() where it was allocated. Something like this:
>
> static int wwan_port_register_wwan(struct wwan_port *port)
> {
>      ...
>      if (something_wrong)
>          return -E<ERROR_TYPE>;
>      ...
>      return 0;
> }
>
> struct wwan_port *wwan_create_port(struct device *parent,
>                                     enum wwan_port_type type,
>                                     const struct wwan_port_ops *ops,
>                                     struct wwan_port_caps *caps,
>                                     void *drvdata)
> {
>      ...
>      port =3D kzalloc(sizeof(*port), GFP_KERNEL);
>      /* Do basic port init here */
>      port->dev.type =3D &wwan_port_dev_type;
>      device_initialize(&port->dev);  /* allows put_device() usage */
>
>      if (port->type =3D=3D WWAN_PORT_NMEA)
>          err =3D wwan_port_register_gnss(port);
>      else
>          err =3D wwan_port_register_wwan(port);
>
>      if (err) {
>          put_device(&port->dev);
>          goto error_wwandev_remove;
>      }
>
>      return port;
>      ...
> }
>
> The only drawback I see here is that we have to use put_device() to
> release the port memory even in case of GNSS port. We don't actually
> register the port as device, but I believe, this can be explained with a
> proper comment.

Yes, that's a good alternative, so you would also have to use
put_device in gnss_unregister, or do something like:

void wwan_remove_port(struct wwan_port *port)
{
[...]
    if (port->type =3D=3D WWAN_PORT_NMEA)
                wwan_port_unregister_gnss(port);
    /* common unregistering (put_device), not necessarily in a
separate function */
   wwan_port_unregister(port);
[...]
}

And probably have a common wwan_port_destroy function:
static void wwan_port_destroy(struct device *dev)
{
    if (port->type !=3D WWAN_PORT_NMEA)
        ida_free(&minors, MINOR(dev->devt));
    [...]
    kfree(port);
}

Regards,
Loic

