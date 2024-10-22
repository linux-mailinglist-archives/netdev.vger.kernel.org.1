Return-Path: <netdev+bounces-137698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383AA9A95BF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 03:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D127283602
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827ED12CDBF;
	Tue, 22 Oct 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdpsbvUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709584E11;
	Tue, 22 Oct 2024 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562059; cv=none; b=g8pFgkXrTr85VjDQb5oWT9gNSP2Y/F6OrJlmeA4MrstC0kwDtze2Lgb9guOOqPmA9wC//TW3eMfVaRkaUTVgdMllVYRcJ+JjGoBkYVuFIMTHGX1V0yytUvf30BLVfnwkNmWK6jGpNjgNVJ2s14nOYR+4Fld2Qbk5H19JbBPYvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562059; c=relaxed/simple;
	bh=6bnD5a89H0ka6IkNa/kaRsRVl5uxcAA0X4uwUtxHOcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C522Jc/Aq7XkFEv+GziD1qtcCSNIccKAxj9iKkhmVIFc0Ly7BI+ulPF0iLWL7ImGTQAP29+J2hEbRxuP6CuzRYMBwvTJS3GSpS0VFJ4aCsjoHmt711kLOSPX/kTgfdXj2BqqnjpT7/qoHCEE8ia9Zo8NBFAzBmXXjulxGdvVit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdpsbvUU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e7086c231so3850181b3a.0;
        Mon, 21 Oct 2024 18:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729562057; x=1730166857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JCdfHyckjC3R7H8wnx3yShAwMrDQcCGjf7SsvmeYhDI=;
        b=fdpsbvUUS/dvj1pH5vnVmi73zUdcFVRm9uPGWHFM3lNzTgSXpuU6nsmvDh+9Kb55SK
         ipBipTui4DqmWFlMu9ZkspbHgpHBAvtPkRuf2iC8L1ozod0jHWGCe7W/odxOZnSQOKWW
         KIStLdbW9Km1JqRpsxeUONDuo18dPcuhEMTBxFnYkpy9pjTX6f3V6K1kNxaCuOje/m3t
         vEXl+vl9wWehXqm1ItRW/J7K7gULXNlGtizS/8JnhumYeQYSOOLzXkW9GraIl8C5duVT
         RZAQvt+iLIqKAQt3XnL/f5WmryKxj4dYY/pudSvwbM1WyefK/Q1XUyuTsPwJCszwmDI1
         161A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562057; x=1730166857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCdfHyckjC3R7H8wnx3yShAwMrDQcCGjf7SsvmeYhDI=;
        b=OFt1YTh8W6A8Yfr8jk4ttgk165FNj75bIl2Ok2mwvtT9+W4wdkH3L2mioFKzJCDjq6
         mxANWE4WMZ2pd+loHXQ/SoRB8cIirv5/19zBPko2Tint104eXSYt+avXZTCTX1jac1Nx
         7DQaPAU0JqICIQezOuz8sXjcboa9NB8MqMxOgQLbwVIX2s9skSfXpHF4uhQvgXOCaxo4
         FcsN/utvKngpjSpBdr9Ln5svzwwuuD6SdAhG3bJoi4W1pPAJ1Lpw6WUfuwwYZboas5rz
         XeN0Jsw5GlkQEdofZS36WJsURLPiImTNYV0M3rXxiLUbDWPTVGvy0b3XaL6Cmi7qqgIT
         65Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUCK67No5G5LXjoiyfPTlnUKl192w4pNEB1Or++b/tusdffxIMuMO6mvo8aBvVsHE9jFzg0AvRI@vger.kernel.org, AJvYcCWdMGtu6G5OzQ6pRvIAy1QJERE48dL0qQOioVZ6vG6ugpW73zMNFdDeFgX2YKeG1o/I6U5h3TCC8PjH14G5@vger.kernel.org, AJvYcCX1in8nCajh9do0ZcnTucsQY+ydkHnEH38C4sI0K1W/VRURG6/5L6P/NzNnkZF4GKYSRW7lqEXfAPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7EMQf7+bpG8zXolPDf9UuCQbgIFcGC2Jh8qRfFukGKEilBBg
	utH830Sn6iAFw0KZK6GjBWjQRASPEXIxEtHcH5HpcTkr6BVAHHvf
X-Google-Smtp-Source: AGHT+IFPTmihNK+AQ2CrQcJ+9qy3A3ihoWuZYosOY1eCQBikwEf4E92hGMMpi+7HrXqUQRwPeFm+rA==
X-Received: by 2002:a05:6a00:3d43:b0:71e:4c18:8e3b with SMTP id d2e1a72fcca58-71ea3192bfamr20066087b3a.2.1729562056867;
        Mon, 21 Oct 2024 18:54:16 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407ea4sm3566037b3a.201.2024.10.21.18.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:54:16 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EA5AD425A747; Tue, 22 Oct 2024 08:54:12 +0700 (WIB)
Date: Tue, 22 Oct 2024 08:54:12 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com, arnd@arndb.de,
	masahiroy@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com
Cc: kernel-team@android.com
Subject: Re: [PATCH v4 1/1] binder: report txn errors via generic netlink
 (genl)
Message-ID: <ZxcFxFfQM8gc5EEz@archie.me>
References: <20241021191233.1334897-1-dualli@chromium.org>
 <20241021191233.1334897-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZQ9idZBCwrcv4Hah"
Content-Disposition: inline
In-Reply-To: <20241021191233.1334897-2-dualli@chromium.org>


--ZQ9idZBCwrcv4Hah
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:12:33PM -0700, Li Li wrote:
> diff --git a/Documentation/admin-guide/binder_genl.rst b/Documentation/ad=
min-guide/binder_genl.rst
> new file mode 100644
> index 000000000000..48a0ceab6552
> --- /dev/null
> +++ b/Documentation/admin-guide/binder_genl.rst
> @@ -0,0 +1,92 @@
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
> +the Linux kernel to communicate to the user space applications. In the k=
ernel
                                                     "... via binder driver=
"?
> +binder driver, it is used to report various kinds of binder transactions=
 to
> +user space administration process. The binder driver allows multiple bin=
der
                                      "The driver allows multiple ..."
> +devices and their corresponding binder contexts. Each binder context has=
 a
                                                    "Each context has ..."
> +independent Generic Netlink for security reason. To prevent untrusted us=
er
> +applications from accessing the netlink data, the kernel driver uses uni=
cast
> +mode instead of multicast.
> +
> +Basically, the user space code use the "set" command to request what kin=
ds
> +of binder transactions should be reported by the kernel binder driver. T=
he
                                    "... reported by the driver."
> +kernel binder driver use "reply" command to acknowledge the request. The
"The driver then use ..."
> +"set" command also register the current user space process to receive the
> +reports. When the user space process exits, the previous request will be
> +reset to prevent any potential leaks.
> +
> +Currently the binder driver can report binder trasnactiosn that "failed"
"Currently the driver can report binder transactions that ..."
> +to reach the target process, or that are "delayed" due to the target pro=
cess
> +being frozen by cgroup freezer, or that are considered "spam" according =
to
> +existing logic in binder_alloc.c.
> +
> +When the specified binder transactions happened, the binder driver uses =
the
"When the specified transactions happen, the driver ..."
> +"report" command to send a generic netlink message to the registered pro=
cess,
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
> +drivers. The user space application uses a raw netlink socket to send co=
mmands
"Userspace application uses ..."
> +to and receive packets from the kernel driver.
> +
> +NOTE: if the user applications that talks to the Binder Genl driver exit=
s,
"Note that if ..." or .. note:: block? I lean towards the latter, though.
> +the kernel driver will automatically reset the configuration to the defa=
ult
> +and stop sending more reports to prevent leaking memory.
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

--ZQ9idZBCwrcv4Hah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxcFvwAKCRD2uYlJVVFO
ozMsAP4z+TRLgNiahdgfPND5nkXQU2GLM1ALLk+ik+9Zd741XQEA9wchTxd3r+lf
DEteoADKxlz4JRd91xc+SIsbMI6oCAQ=
=5+26
-----END PGP SIGNATURE-----

--ZQ9idZBCwrcv4Hah--

