Return-Path: <netdev+bounces-139089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E339B01F1
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9201C21C06
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A38202637;
	Fri, 25 Oct 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJYEkvA/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC461F81AF;
	Fri, 25 Oct 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858318; cv=none; b=ugrgt4CLz9IztDXodmY4p0Yp2RrYeijDdJuCnbKsxyFQida8edMZGVpT8/FJhLc2DVr/8k2moDFv06ZEQRwk6Lso6Zd0vMhsmOU+P8dZNrrq6XK3HL3535MikVORNrFOSml/9u0uhOK19jM02VLUD7l5P9SuZ8kkD8ij3FU2ITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858318; c=relaxed/simple;
	bh=zKNMavy3+nxsr+4jmkAd64WKP9FdkRqp71IYsn6Fgtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e87Rj1L4VJx23KquHhto+pt8YrHk5aBQLAtnVmvALn+eO+Kd8h4lSQUggg+3bS7L4lwn/eKGS7ZVg3zeDtP+v1AYvVdPNXBNSeFnInSCm9QsFQCtUG+pzGoQeslf2TWmkow88lUVnZ0I8Tnzv2Gb8zvk7Bo3aMUKMb5cvd3Ye0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJYEkvA/; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83ac05206c9so79024539f.3;
        Fri, 25 Oct 2024 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729858316; x=1730463116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ+x+WkuoiPHnvrducif+nbzvvRjkzMkNuZ5uGzY07Q=;
        b=nJYEkvA/gBl/biqwwFHIFCe7YlOXjj4tRPqes9M6AkF6Aowb7ypd3rX5xZPaHH0Mni
         dOHmUPenPzd4gO/xc8jpxBvPsn3G8DQs1ahYukaB6tKgmYMiZiTrk4sGA8ZjQgqx+JDY
         OznUu47BXKNVf+bnphmV5UbSKzwp1IEVz2aKi0FD9u0sPnl2ES2CNM0mQLQthNVsGasI
         b1jOZq8GmSdPqb+Oldi6T4FJjO8Pr49oK5/m8y+cXME5RQxqS4axIDGmp8xlSPf69sw3
         z1q1W9oxyiADRbBa8Sm5fIyZuJlAPZoNLLZc0e7pNShXzL1M3TBFKzv3OvkLvAaV2Zzl
         05LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729858316; x=1730463116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ+x+WkuoiPHnvrducif+nbzvvRjkzMkNuZ5uGzY07Q=;
        b=BxeAzyxBzBdLfAerpwmh479FJpIqdZBS8emuxvPPYDIZPhAAHXDhj0RuSFwb3bOk6K
         tEJjqrXCf6bG1NaCf7lPoOt1efiJNMfd7yFDUi0jnq5Gw+otkdytc81+Xo44ilE1DuCB
         T/2GgHfDmHRBOuByrDO4H0dpHe0/6Oa8tauBKLv3HksZ4r5ppTUdvmMkmCtP6h/Oz+DW
         dif+m0iizIzf9CLC7qLye+/g5HHW9mz08ltM9948iREcLNOkk14xz+o39QHus270yGjM
         F3AN93Z1WWUlJB5AGPkJU848hLcGwmWaPgh1j1lZr46Y9DJLMvrK33kYSPj82eEiNoC1
         kYaw==
X-Forwarded-Encrypted: i=1; AJvYcCU6azzGu5pM+Pz5Gmnvp4vOFzTrwKyRCJV0W3vNKjyUNZ+/ayZpU4D1hfyRjLNv1/mB52rGXUta2hM=@vger.kernel.org, AJvYcCWvtehnebi3SfbaUrgBfI5Tial+vFrKmO+ox4oNy7JEzivoo/29XKgSVMb7s+LPjk8uGfIrl3i0@vger.kernel.org, AJvYcCXq9Z8BiihCbTrUroiCyYePd4JXwT5JOdU6JybluT0fMtcuHgtF5Ddse//zExN1jy3yrc5/8AZyC9sOwNow@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtJXLVPFl/hHZdww6Vl5bV8wmCknpZAL+6qkDT43fbQGP8e/6
	4L6nR74Q4i4f34KOUzd4q62PCep+GNcKG1iAPC1CxrSQ4QsAk8qpoZewXw==
X-Google-Smtp-Source: AGHT+IEztjLz2el3NkoMYeDqTRp3d78oMh21r2bUTNIEqq9+j3Idharwiz7JWFrGEQoqiou2DPkkTA==
X-Received: by 2002:a05:6602:15c6:b0:83a:a305:d9f3 with SMTP id ca18e2360f4ac-83af61f1857mr1205233739f.12.1729858315469;
        Fri, 25 Oct 2024 05:11:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8660f9csm967463a12.5.2024.10.25.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:11:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5ACBC442B53B; Fri, 25 Oct 2024 19:11:50 +0700 (WIB)
Date: Fri, 25 Oct 2024 19:11:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com, arnd@arndb.de,
	masahiroy@kernel.org, horms@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com
Cc: kernel-team@android.com
Subject: Re: [PATCH net-next v5 1/1] binder: report txn errors via generic
 netlink
Message-ID: <ZxuLBlABwMQf0lpA@archie.me>
References: <20241025075102.1785960-1-dualli@chromium.org>
 <20241025075102.1785960-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9aDi7F2PhdcIKpry"
Content-Disposition: inline
In-Reply-To: <20241025075102.1785960-2-dualli@chromium.org>


--9aDi7F2PhdcIKpry
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 12:51:02AM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>
>=20
> Frozen tasks can't process binder transactions, so sync binder
> transactions will fail with BR_FROZEN_REPLY and async binder
> transactions will be queued in the kernel async binder buffer.
> As these queued async transactions accumulates over time, the async
> buffer will eventually be running out, denying all new transactions
> after that with BR_FAILED_REPLY.
>=20
> In addition to the above cases, different kinds of binder error codes
> might be returned to the sender. However, the core Linux, or Android,
> system administration process never knows what's actually happening.
>=20
> This patch introduces the Linux generic netlink messages into the binder
"Introduce generic netlink messages ..."
> driver so that the Linux/Android system administration process can
> listen to important events and take corresponding actions, like stopping
> a broken app from attacking the OS by sending huge amount of spamming
> binder transactions.
> <snipped>...
> diff --git a/Documentation/admin-guide/binder_genl.rst b/Documentation/ad=
min-guide/binder_genl.rst
> new file mode 100644
> index 000000000000..ecbf62f662a6
> --- /dev/null
> +++ b/Documentation/admin-guide/binder_genl.rst
> @@ -0,0 +1,93 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Generic Netlink for the Android Binder Driver (Binder Genl)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Generic Netlink subsystem in the Linux kernel provides a generic way=
 for
> +the Linux kernel to communicate to the user space applications via binder
> +driver. It is used to report various kinds of binder transactions to user
> +space administration process. The driver allows multiple binder devices =
and
> +their corresponding binder contexts. Each context has an independent Gen=
eric
> +Netlink for security reason. To prevent untrusted user applications from
> +accessing the netlink data, the kernel driver uses unicast mode instead =
of
> +multicast.
> +
> +Basically, the user space code uses the "set" command to request what ki=
nds
                                                            "what kind of .=
=2E."
> +of binder transactions reported by the kernel binder driver. The driver =
then
> +uses "reply" command to acknowledge the request. The "set" command also
> +registers the current user space process to receive the reports. When the
> +user space process exits, the previous request will be reset to prevent =
any
> +potential leaks.
> +
> +Currently the driver can report binder trasnactiosn that "failed" to rea=
ch
                                         "transactions"
> +the target process, or that are "delayed" due to the target process being
> +frozen by cgroup freezer, or that are considered "spam" according to exi=
sting
> +logic in binder_alloc.c.
> +
> +When the specified binder transactions happen, the driver uses the "repo=
rt"
> +command to send a generic netlink message to the registered process,
> +containing the payload struct binder_report.
> +
> +More details about the flags, attributes and operations can be found at =
the
> +the doc sections in Documentations/netlink/specs/binder_genl.yaml and the
> +kernel-doc comments of the new source code in binder.{h|c}.
> +
> +Using Binder Genl
> +-----------------
> +
> +The Binder Genl can be used in the same way as any other generic netlink
> +drivers. Userspace application uses a raw netlink socket to send commands
> +to and receive packets from the kernel driver.
> +
> +.. note::
> +    If the user application that talks to the Binder Genl driver exits, =
the
      "If the userspace application that talks to the driver ..."
> +    kernel driver will automatically reset the configuration to the defa=
ult
> +    and stop sending more reports to prevent leaking memory.
> +
> +Usage example (user space pseudo code):
> +
> +::
> +
> +    // open netlink socket
> +    int fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> +
> +    // bind netlink socket
> +    bind(fd, struct socketaddr);
> +
> +    // get the family id of the binder genl
> +    send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME, "binder");
> +    void *data =3D recv(CTRL_CMD_NEWFAMILY);
> +    __u16 id =3D nla(data)[CTRL_ATTR_FAMILY_ID];
> +
> +    // enable per-context binder report
> +    send(fd, id, BINDER_GENL_CMD_SET, 0, BINDER_GENL_FLAG_FAILED |
> +            BINDER_GENL_FLAG_DELAYED);
> +
> +    // confirm the per-context configuration
> +    void *data =3D recv(fd, BINDER_GENL_CMD_REPLY);
> +    __u32 pid =3D  nla(data)[BINDER_GENL_ATTR_PID];
> +    __u32 flags =3D nla(data)[BINDER_GENL_ATTR_FLAGS];
> +
> +    // set optional per-process report, overriding the per-context one
> +    send(fd, id, BINDER_GENL_CMD_SET, getpid(),
> +            BINDER_GENL_FLAG_SPAM | BINDER_REPORT_OVERRIDE);
> +
> +    // confirm the optional per-process configuration
> +    void *data =3D recv(fd, BINDER_GENL_CMD_REPLY);
> +    __u32 pid =3D  nla(data)[BINDER_GENL_A_ATTR_PID];
> +    __u32 flags =3D nla(data)[BINDER_GENL_A_ATTR_FLAGS];
> +
> +    // wait and read all binder reports
> +    while (running) {
> +            void *data =3D recv(fd, BINDER_GENL_CMD_REPORT);
> +            struct binder_report report =3D nla(data)[BINDER_GENL_A_ATTR=
_REPORT];
> +
> +            // process struct binder_report
> +            do_something(&report);
> +    }
> +
> +    // clean up
> +    send(fd, id, BINDER_GENL_CMD_SET, 0, 0);
> +    send(fd, id, BINDER_GENL_CMD_SET, getpid(), 0);
> +    close(fd);

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--9aDi7F2PhdcIKpry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxuLAQAKCRD2uYlJVVFO
o9XtAQCoxfOyTg5vKYG2oFhYRuQyDAdLSk6/fR4YqjSKcNu0bwD/WFPqSSPLsar2
W9pWvdAO2LlpwY/YC/idAl14atCN2wU=
=46xL
-----END PGP SIGNATURE-----

--9aDi7F2PhdcIKpry--

