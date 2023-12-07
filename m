Return-Path: <netdev+bounces-55100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1916480957B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB041C20B56
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8670B56B60;
	Thu,  7 Dec 2023 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qU+EYHE1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A45D5B
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 14:38:01 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce7632b032so960210b3a.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 14:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701988680; x=1702593480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNhfnx72PbDv7v1X8Jwhny5ksq2HURuZR8na0czYirM=;
        b=qU+EYHE1ChneRXBwWcHnS1B224uuGgUiSml/gRamyyw4fHJUxgLmFKzPbTVqZ8oa4V
         7SOUAVJjhSTWNyEb/TIjCQCWm0it5wWWmb1joVof9huHdh3UFyOOr+wdUGSBOLk5sfZH
         nxWHNZreNyDQwcyRTtJV8r3GEU1NZv1T5F4AKaVf2U9Dk2FBYlTRjLn+lo/nHRmm1TB5
         oPRGANDq4RhKHG/YY3KB+k3rHsnMnFY9QF4a0ABAL2+M+SOiEwttU1siaCtuGhRhq9D/
         G47Xq0FIMYGAdZ+ZrLHtRnsycpnYSY7UjZ5g5XXkQOqvML/JEAIqfAnfJM0zJYhnuN3A
         aPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701988680; x=1702593480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNhfnx72PbDv7v1X8Jwhny5ksq2HURuZR8na0czYirM=;
        b=D0rLjvQWGsQY/R1SkDLXiHUxeyn1Wytc+HUoTVVrviIJPEDDMP6X9mfGAjwo9T4Re+
         KB0ifWERNTHcJuJw1PDV/ZxaTZ56hjkwuZfYbM2HPrLsal+w4bZaj74zwGUuazizkuyD
         WYF5WNriPAM1/jbcvfZawNATleU8KuWzDu0wakH0/bDlrSYZXw4nwqwb1UfPU70KFUUf
         iNEN6SD9CMRn0uSdN+khizrpk7KDtgs0aub/bIwYV12Qdu6ECYmwNdmF3Q2HkNhFyPBQ
         LUKOY8jHdfU6iFVsmEVIq8XzmzUglCxTBlNP5z7v4gK6q+OA5uNEPEryu3Uf4SCbGFA8
         jLKg==
X-Gm-Message-State: AOJu0Yws9Ee18Q60edooGWHdhiSLlog0civh1uGCzxZYqtP+ovuVkkd8
	742XbIkRVVPDrFEXvbNMP/yjgEGn8b76WWGxcuphzg==
X-Google-Smtp-Source: AGHT+IFdimHuT87AUEW8I2QNQVGvzskt62Uy7XBhe6Y3R1xnCGbjbpYF0FjIRrY38bn11yYVJaIdQQ==
X-Received: by 2002:a05:6a20:a087:b0:18f:c76a:992e with SMTP id r7-20020a056a20a08700b0018fc76a992emr2352740pzj.109.1701988680556;
        Thu, 07 Dec 2023 14:38:00 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001cc25cfec58sm316488plb.226.2023.12.07.14.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:38:00 -0800 (PST)
Date: Thu, 7 Dec 2023 14:37:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Arjun Mehta <arjunmeht@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Rx issues with Linux Bridge and thunderbolt-net
Message-ID: <20231207143758.72764b9f@hermes.local>
In-Reply-To: <C6FFF684-8F05-47B5-8590-5603859128FC@gmail.com>
References: <C6FFF684-8F05-47B5-8590-5603859128FC@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Dec 2023 12:57:08 -0700
Arjun Mehta <arjunmeht@gmail.com> wrote:

> Hi there, I=E2=80=99d like to report what I believe to be a bug with eith=
er Linux Bridge (maybe and/or thunderbolt-net as well).
>=20
> Problem: Rx on bridged Thunderbolt interface are blocked
>=20
> Reported Behavior:
> Tested on Proxmox host via iperf3, between B550 Vision D-P and MacBook Pr=
o (2019 intel). On a direct interface, thunderbolt bridge Tx and Rx speeds =
are equal and full speed (in my case 9GB/s each). However, when a thunderbo=
lt bridge is passed through via Linux Bridge to a VM or container (in my ca=
se a Proxmox LXC container or VM) the bridge achieves full Tx speeds, but R=
x speeds are reporting limited to ~30kb/s
>=20
> Expected:
> The VM/CT should have the same general performance for Tx AND Rx as the h=
ost
>=20
> Reproducing:
> - Setup for the bridge was done by following this guide: https://gist.git=
hub.com/scyto/67fdc9a517faefa68f730f82d7fa3570
> - Both devices on Thunderbolt interfaces have static IPs
> - VM is given the same IP, but unique MAC address
> - BIOS has Thunderbolt security mode set to =E2=80=9CNo security=E2=80=9D
>=20
> Further reading:
> The problem is outlined more with screenshots and further details in this=
 Reddit post: https://www.reddit.com/r/Proxmox/comments/17kq5st/slow_rx_spe=
ed_from_thunderbolt_3_port_to_vm_over/.
>=20
> Please let me know if there is any further action I can do to help invest=
igate or where else I can direct the bug/concern

Most likely this is a hardware issue on the thunderbolt interface where it =
will not
allow sending with a different source MAC address.  Some Wifi interfaces ha=
ve this
problem.

Is Promox using a kernel from upstream Linux repository directly.
Netdev developers are unwilling to assist if there are any non-upstream ker=
nel modules in use.


