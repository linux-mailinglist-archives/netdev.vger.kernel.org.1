Return-Path: <netdev+bounces-257899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMCVMtCBiWkg+QQAu9opvQ
	(envelope-from <netdev+bounces-257899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 07:42:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181F10C2F9
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 07:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D2433007502
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 06:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289731329B;
	Mon,  9 Feb 2026 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcIp51Zd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SL2/9lAP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820730FC17
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619334; cv=pass; b=grdQpaxpIPAHQPnLGEicWO/LiUyQH0/KvWzd28IUCC8061CgmBIfjrCHWv6AHDH+X+EghFvYcS5dfR5OBZBY6k3Rk1eKrQUfMdLUMJlwKTnCnnSnsS7nhSVjHS6RUMHlGoICqa7PL/bCe1e2kZraofm35B6C5JF6U4InmhBBArU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619334; c=relaxed/simple;
	bh=O8cJ6Kj90NvIyQjjqT95QHWqU8SDK+V3+SP8mwmcVYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lux7NHfQjkaXMHHvuONxzrLBqJEUU+/9h77pzwN0s3adwFkfL7eQetay32Q00rb8R64j2cGkPftTZRx8uDx8K+/RkobEjBeH5RQOAFwXTy5oVOTpoLEBYDRdlpTvhldAtW1GZi25rN8A/VLH0IhWHcQ5bXYh88eD6B2Pky0qPIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcIp51Zd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SL2/9lAP; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770619333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rAEkP/ENKOKGthOaBA1iQpwk+zp5uugkrzm6gZ8wcU=;
	b=AcIp51ZdvrrSeSz2lLcTJPB35s38Mze4+WmTjAMRhySO8xZ+l4KGYThx8QzW3nQD/5QlcR
	0lO+Zscqy0VOUAo5xrz7uVji6R8Z4XQr1YaTx1VI6Sc5r6Sq1w3kUzzNq9YMljXZNO4i5u
	swUIRdua0OsCSywz7wqLDbURzq8OgR8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-V71HAy49M_iTdlZ5Zc-rjw-1; Mon, 09 Feb 2026 01:42:11 -0500
X-MC-Unique: V71HAy49M_iTdlZ5Zc-rjw-1
X-Mimecast-MFC-AGG-ID: V71HAy49M_iTdlZ5Zc-rjw_1770619331
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5f55092e3fdso11928508137.0
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 22:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770619331; cv=none;
        d=google.com; s=arc-20240605;
        b=kZfWraAwbDz1mzejfnE5rSFx8YK0jMLc9qaWsLw0t+AGLwZg5hg+HEYEZyEgR9QP46
         HjlphfGzME0ngd34XFP+3aO85vt5AirPJKDACrwzw+jzMa22ZGZfdcIwv9RoidQ45pI8
         ZOSDqhTEYTUOc9Xw8ru3Qx/HhvbomstmCczYmwRtyjk4fwp0qK94vwLGmWTlbc9QgMLp
         xLsWKbUar8tn1Z06fHlciqxA0Smu+N90NzyQTSJVtFF7vgQpFw3OQeo9E7x70v9WPQD5
         uBB0/p/nAHtTOf5WimXcy12Ygs65iLmeLCVUVEbsm1jzHVf35HRZzQ6wuZ4VO9KcdhWu
         Z06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+rAEkP/ENKOKGthOaBA1iQpwk+zp5uugkrzm6gZ8wcU=;
        fh=ye92V9tKlnlhMYjj2pYI98Rv8z62w1pvsIsQpr1/TgY=;
        b=Wa1vKuF+N6r5ARoPF1XS2pdaVoXf0vAv8ZCyUEXHuOYhBuTPISkdkrER9TpUAbxDrE
         ISRGgcMYGv7AA/xEPg1XyErzgvC9yNayKyZGSFiSGc+Ylj4HhRdlQ9gAJXI6rau4OPtz
         0NpNQOBF5Kj60L8p1teqgqoUzttqAykrBMDPzRtzEGvaIECnTy4bhMh7y9sFRcU3Npjc
         2Wg6NNZo3z0OStIlmzpMSspYxvbbm/ji2Tbc7qxFuTWP78iYEg1lFPM4QQGxiK6LKXiu
         fu4esTE6PUrmM5rBhzJZW1NO5Ru5nPbH3dYXXze99bFwBEbCFR6EvgbRodR54Fz4+dfS
         Bnpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770619331; x=1771224131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rAEkP/ENKOKGthOaBA1iQpwk+zp5uugkrzm6gZ8wcU=;
        b=SL2/9lAPYkmcyzw1pHxouL+AgTG+qAmi6/pDxi4Zp1UqjlVHm23AKzp2D/7IXLe26U
         +XKwu5uyuqso08OiAoStwDyIN0IVjwBeJA1quEh97fldnKC427Qoy1dwkHph318NaApd
         BqWbiAkh80AdEAcD6IfGYCRbK2Ka5I9QI2j2wogf2yOfXqPQUAblIyZrXbeL8ZvXWDLa
         faXEuaZfwe8Ry2eO/Dd9u3DalOYnqFrmKwa0/Y58AdwWBaTjo+4yBd2h8EQyW5lZ50zi
         1z9MIIQrThBYytgwOREuMaezsKCRGCouLArJciHEZ/LXb8kVMSA78nSdaXw+d9JzOm88
         celA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770619331; x=1771224131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rAEkP/ENKOKGthOaBA1iQpwk+zp5uugkrzm6gZ8wcU=;
        b=LHG1Mq90IDp6reyizCsvOGWpDgrcucNccSPD4U3SQ+34Ze825j9VTH11i3KDEiYATl
         69WBlMJXE+3/97yXc3E7bvBQLTamCmFM8Mrq93Sidl4s2B/n3hWFSA5u41IXUPOGRSFx
         VJs13xgjbqfp1249MEWqYfiFkvIl83zIsNM60s2xa3yp78MXrg8VF+zvO/GQamE4pDzp
         6sIQrB5y9aWdO+N9zn8dvRyY+1EJS18T/nehL5k+xeeWdo2lzCCAdiHweafCq7sQ2pj3
         iNIf7bVbmUukUO9kIm88wh0mAj0SZ4EeiwArla9ABbDszUm/3fU5UMnF2pXF8XJ+Dl68
         mx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhsR+rFny7DT2YaqIW5fweqB+GUvD1Udsc936qMhJVOQ0/OkXTZLGWSWVwWSG1JnHV/KJyGxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxkqt5xEG3cOeH1ZrMs+RHLGARNwczxhEwZqVZsTWCLvhs0I5
	TNqT+zdiPfVYThF/4vAgNpxUxgI8Eg/BMnOnQnvspKt0ll2gsSsuWQtf45gGDUF1gY6rkjkTAoM
	WrA5PaSHx0PVBDbS7yuRhH1fICbPPzPeO4jnr2Cqq9ZwsTrGgCX6sdZqHWchOfBzPfZxVxk0Ids
	GD0fbItcR7HJuCYlRVeNoK4R8UMI8vVNtg
X-Gm-Gg: AZuq6aKQRg9DXENBk48jny5Rv6dWayI3YwL3HNtCaGqSi5EXiZB+XOhGHDYflaxgs4E
	2kjXtY1if+1yYt0sK8v0MVf/mauv7+EaqnoZEjWrlaFcDPD3Ei3jI0YTkoQsc5ru5oPXnrTa+EP
	iEFOd3v7hvbLngDIVrhMmGUcbaUynNDXiUzTATONnVKRmKjhP3pEeX8SWvr8vze2mZMsU=
X-Received: by 2002:a05:6102:5108:b0:5ef:af68:e6bd with SMTP id ada2fe7eead31-5fae76bedd7mr2971618137.2.1770619331278;
        Sun, 08 Feb 2026 22:42:11 -0800 (PST)
X-Received: by 2002:a05:6102:5108:b0:5ef:af68:e6bd with SMTP id
 ada2fe7eead31-5fae76bedd7mr2971613137.2.1770619330991; Sun, 08 Feb 2026
 22:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208143441.2177372-1-lulu@redhat.com> <20260208143441.2177372-2-lulu@redhat.com>
 <20260208123029-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260208123029-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 9 Feb 2026 14:41:27 +0800
X-Gm-Features: AZwV_Qiz8bHINy5XI2QvLVezbxk6iTbCBvt72uLxPgwE6Zaly7hURPFi-VGLC_8
Message-ID: <CACLfguX6o5Uj4SKsPAsX53wjuNtvCxsCgK5AzfffHpdt1NrZNQ@mail.gmail.com>
Subject: Re: [RFC 1/3] uapi: vhost: add vhost-net netfilter offload API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulu@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7181F10C2F9
X-Rspamd-Action: no action

s

On Mon, Feb 9, 2026 at 1:32=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sun, Feb 08, 2026 at 10:32:22PM +0800, Cindy Lu wrote:
> > Add VHOST_NET_SET_FILTER ioctl and the filter socket protocol used for
> > vhost-net filter offload.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  include/uapi/linux/vhost.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index c57674a6aa0d..d9a0ca7a3df0 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -131,6 +131,26 @@
> >   * device.  This can be used to stop the ring (e.g. for migration). */
> >  #define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vr=
ing_file)
> >
> > +/* VHOST_NET filter offload (kernel vhost-net dataplane through QEMU n=
etfilter) */
> > +struct vhost_net_filter {
> > +     __s32 fd;
> > +};
> > +
> > +enum {
> > +     VHOST_NET_FILTER_MSG_REQUEST =3D 1,
> > +};
> > +
> > +#define VHOST_NET_FILTER_DIRECTION_TX 1
> > +
> > +struct vhost_net_filter_msg {
> > +     __u16 type;
> > +     __u16 direction;
> > +     __u32 len;
> > +};
> > +
> > +
> > +#define VHOST_NET_SET_FILTER _IOW(VHOST_VIRTIO, 0x31, struct vhost_net=
_filter)
> > +
> >  /* VHOST_SCSI specific defines */
>
> can we get some info on what this is supposed to be doing, pls?
> it belongs here where userspace devs can find it, not hidden
> in code.
>
Hi Michael
We plan to add a new feature to support zero packet loss during live
migration, so we=E2=80=99re introducing this new UAPI. Thanks, I'll add mor=
e
information here.
Thanks
Cindy
>
> >
> >  #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_=
scsi_target)
> > --
> > 2.52.0
>


