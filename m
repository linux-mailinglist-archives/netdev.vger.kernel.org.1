Return-Path: <netdev+bounces-135495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F4599E240
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3ED1C21707
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22E1DAC8D;
	Tue, 15 Oct 2024 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKGXRtcE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41B1D9A7F
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983254; cv=none; b=iHFOA7u0SbuRHaOwO1ZPHLKwRKTEt4vrMB1apQrmO1alcuC59My3R7PStoSyuc5ajVGbJ/i/A1DifiGj9O/xgOGwPB1lLG8Dq8y4q/mi7692K/2XnRT5TyhJVVFLzrjVgK5TpPNpBVjnQy2SUG+3bC2O6yxq7i2SP1Se4cETwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983254; c=relaxed/simple;
	bh=oCjWOF503rcT4c0Xx5RdN6ucpRfwbJjuYJBlNO0Cl3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hm0iiBXvhBMEZCtp+etAKAD3jP0LbNSxv52sMNLqQEI/BpoSR4kzBvFAh7819oYip8kyE31Qu3FYBBLn3vXB332naRCa3d6VQi6jVe4vM3iDSl9eQ7dkn3jZA1k9cGiEFoBFLyhcY4cUmKiGddKLBW+FgO48QgHlB8rVvzP5o0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKGXRtcE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so3264337f8f.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728983251; x=1729588051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAqE00nuYG0iOJRr3q7L1x6bg2EAu6mZzcRTFTFPvds=;
        b=NKGXRtcExB7TDGhugYpN0+CbQ2d02xV7I9W7IXPxPQqr9rojm97wqkXl2HAnIt0ZDv
         YPZU2w0c3AyMb2T0crr5tmd4jIXef7tQKinbkePNIkfZHBcyBeqete1rcsit6Y3pZpwc
         yxx1y9pGZnK8FbA7+WBJRP5jN7Sx5F7+yDdvRfmq9dLL7ulm7oMG/CYwtZ+8nvv8vZq3
         SZhZQYpqJftoIox4Ilbc67xnH8FbLJ3KebpCnf1JXuq++otBdVpM35qo+AoHu1zIAVGk
         zVeG81P/xOeI/2Ye6VFcKbvjV2uNMDIi5b7fXQu0GfSan4kWKvNHbN3/tQ09P8yN6JR4
         k1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983251; x=1729588051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAqE00nuYG0iOJRr3q7L1x6bg2EAu6mZzcRTFTFPvds=;
        b=umhXjbF3vEDiJQgabDd6CLtPJLnp0boxIxxBIC0ynPk6tpoVnoKQmyAuQfehSQ1qHU
         WEn2bwFuAkda1Qsb2Pv8Xlk2H9moRjugp5brJ+uTyeluadOkQSfDo5QxRpVf5t09fyL8
         Fe2fOFXvsVpzr+Z6TZluMLg5y+3MmIcLxFOe05R2/7ytzaDuWJTKuroK702YFnFC2sPz
         qxHNEOmMy+/nG8GsZ9x01ZJbjM7nBiH6w9UdDC8r50x6iMC3cTIeNCvlBI7J5yQwm5v6
         bvxXqe38xy357Xxc9X0fY1G5w5WZL+R01U5R7wYooTS/YXveqTA5Gy35u8p0u6dPitwp
         pbzw==
X-Forwarded-Encrypted: i=1; AJvYcCVR/ctsbskdTDkC5j2wBo4oWB++b0ymhN09JJJh5zaqUS6V8YLhU+ptUGN8yFyzsqhR+CI0HcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOIMn+Bk9qBIqHurPmwf+zHkThUtpe9rmECZbmPEFsmz41EmDe
	jsN7sEUK/z4GvwZ7gOQq3FsdkYF3mrSFYKQl+e1F2YMTTrMQisWmD4s8etaLp2VaSdiTYQhRJGf
	d+2aOek3xcxRhDwWGOrgtyLXCthY=
X-Google-Smtp-Source: AGHT+IEyB5sgGFX19G1WkwbkJ6DEhVNR0E+9zcEg8bKChGAkw9U7Ses4mrvVVcLy7VqJ2CjQA4BFOCYbQqDux5NAC+M=
X-Received: by 2002:adf:ec4d:0:b0:371:8319:4dcc with SMTP id
 ffacd0b85a97d-37d55184d55mr8723913f8f.2.1728983250604; Tue, 15 Oct 2024
 02:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011080111.387028-1-shaw.leon@gmail.com> <20241011080111.387028-3-shaw.leon@gmail.com>
 <3ad78fb0-4aa2-424b-9e91-8c32b1c266f5@6wind.com>
In-Reply-To: <3ad78fb0-4aa2-424b-9e91-8c32b1c266f5@6wind.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 15 Oct 2024 17:06:54 +0800
Message-ID: <CABAhCOQ_EYqsdrAH+aDKvK3h_s3cBfhrYsmAuqCeGkpgx3WUZg@mail.gmail.com>
Subject: Re: [PATCH v2 iproute2 2/2] iplink: Fix link-netns id and link ifindex
To: nicolas.dichtel@6wind.com
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 3:45=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:

> > @@ -618,20 +653,25 @@ int iplink_parse(int argc, char **argv, struct ip=
link_req *req, char **type)
> >                       if (offload && name =3D=3D dev)
> >                               dev =3D NULL;
> >               } else if (strcmp(*argv, "netns") =3D=3D 0) {
> > +                     int pid;
> > +
> >                       NEXT_ARG();
> >                       if (netns !=3D -1)
> >                               duparg("netns", *argv);
> >                       netns =3D netns_get_fd(*argv);
> > -                     if (netns >=3D 0) {
> > -                             open_fds_add(netns);
> > -                             addattr_l(&req->n, sizeof(*req), IFLA_NET=
_NS_FD,
> > -                                       &netns, 4);
> > +                     if (netns < 0 && get_integer(&pid, *argv, 0) =3D=
=3D 0) {
> > +                             char path[PATH_MAX];
> > +
> > +                             snprintf(path, sizeof(path), "/proc/%d/ns=
/net",
> > +                                      pid);
> > +                             netns =3D open(path, O_RDONLY);
> >                       }
> This chunk is added to allow the user to give a pid instead of a netns na=
me.
> It's not directly related to the patch topic. Could you put in a separate=
 patch?

Currently ip-link already accepts pid as netns argument, and passes to
kernel as IFLA_NET_NS_PID. This patch converts it to fd for
simplicity, so that it can be reused in later setns() call (before
opening RTNL in target netns).

