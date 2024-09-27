Return-Path: <netdev+bounces-130124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD429988730
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67271F229EF
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65314D71E;
	Fri, 27 Sep 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBEOitx8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768714D6FE
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447752; cv=none; b=qte2OnfYAonEJI2IpKDMED6VCFkRzYvnh/QE9nAf5AndjjTXSNjor5BVI1gpT8d+BqOcBybsGYJ4XUT1RXo4B88i3m6jtXdV6+YZq+gOpznnsaTXKpizXoHgqr4Yj+nRi6dHjLJk4Q5nzROtxxm+zWlOcAopBEHBMoUCrB198r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447752; c=relaxed/simple;
	bh=sMSnstDuarZo/fLAE7dnvT8Ixh1W5YCJOfqHsgzAyGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u1uPJx4sM+dYsebr2y7O1DLGZcL+Ep21rzG8uGZj1Qq9BpA80yiMhf+jYrCoAx6JFpxVpB5ERAipJXukadK33/iyPVb8zctHqxdQeC91FVX/mgphhPlU2hs0rrmw/niPNyCADjM/x2qOAPk6Yi2D69fJPNUt4XA2AbD1nBBl29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBEOitx8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1d10fde51cso3626678276.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727447748; x=1728052548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AR9xFIzxbK4MT6syD+Hm8ktqytTgjsmedmobgAO+DzM=;
        b=fBEOitx8O84ovwqnsmcBcihKZYzdbruGb67Wfl4IH3C20viasP6erbtUuUAK2VLZdp
         Cw7kd8cfyKWnm7gBLR8CUkkZYZ6WtMDlLG1fJ+SUcuI/iQ5AFPuzq1I+Smh0LqkTrNIa
         KA8jAW4h/B1NW8lUxMLNCbMM0f/0xUlFJ3LUqInWJgTLJs/HYfJ1xoIGC3mggCZcwQ4J
         izIxmNaMplgV7Yh0m19mQxmiopazDgyrBV93ynQe+UOMZQLE3llwZn6bWM6nZsC1qfKe
         kK8dK7PnFeN6sivFdiosT5y2Ii40oTGSTyRSfAw6jDS4GIQITcc4UchD8skcoAklj8nQ
         VTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727447748; x=1728052548;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AR9xFIzxbK4MT6syD+Hm8ktqytTgjsmedmobgAO+DzM=;
        b=tc11K0gUwofsGsCFCMFZcwbJ5tTVzRRmoBQ6UCgwpLPzS70xxVT3Pav0XJgJ0JLe37
         nicnADLOCQR8s8xgwURs90si5JAOtfexv0S8tVrvn0Wk4+jCBKnXAibISPJMWYNmBNYk
         MjZ0NBe9fPAZf9hGhTxVbm864VRdqFnYh6wU8LAfu70GUaAnsu/kWvvVhPpP4B/e6qDf
         Hd0E3chJ6jaD6iZtNfffYarqEFTr3v8NOJXDpP7196pP/LioY0JbZFj8fovfPO2HFw2J
         /CmStlIqcx9MEFKMgqUFFa8GVhF1M8FeATzju+2R+kPKu/9Kx3OJGK5cOdvSHQVmuNW1
         9B7A==
X-Forwarded-Encrypted: i=1; AJvYcCWsIEmXOTFeNqdsz6YYyd0JZCQFOpqGkEGStJZBCzt9BqL8H1kCJobm2RFDMSk5W8GDG9Dwipc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jk33SKH+66ncDMuB4GgauuJmM45ukn08weqoFwQE1VBt2Z4h
	oCeaMVCoDMPexSxVjl2eEz0xAE0iUwJOZWKJz7NtdUTtaKPT0ms+uvHSbCspnKmoRzHlZ2BO/DA
	pqg==
X-Google-Smtp-Source: AGHT+IGMGxg1nP7iD/zXdernlW+jMECrmoQpIGHVaArH90qRv2xQFC0KpuRHNW6ZQGB6T5MI8oMQi7yx7y4=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:b19b:0:b0:e25:fcb:3205 with SMTP id
 3f1490d57ef6-e2604b7f408mr11889276.8.1727447748413; Fri, 27 Sep 2024 07:35:48
 -0700 (PDT)
Date: Fri, 27 Sep 2024 16:35:46 +0200
In-Reply-To: <20240904104824.1844082-16-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-16-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZvbCwtkXDakYDVD_@google.com>
Subject: Re: [RFC PATCH v3 15/19] selftests/landlock: Test SCTP peeloff restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:20PM +0800, Mikhail Ivanov wrote:
> It is possible to branch off an SCTP UDP association into a separate
> user space UDP socket. Add test validating that such scenario is not
> restricted by Landlock.
>=20
> Move setup_loopback() helper from net_test to common.h to use it to
> enable connection in this test.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>  tools/testing/selftests/landlock/common.h     |  12 +++
>  tools/testing/selftests/landlock/net_test.c   |  11 --
>  .../testing/selftests/landlock/socket_test.c  | 102 +++++++++++++++++-
>  3 files changed, 113 insertions(+), 12 deletions(-)
>=20
> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/se=
lftests/landlock/common.h
> index 28df49fa22d5..07d959a8ac7b 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -16,6 +16,7 @@
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
> +#include <sched.h>
> =20
>  #include "../kselftest_harness.h"
> =20
> @@ -227,3 +228,14 @@ enforce_ruleset(struct __test_metadata *const _metad=
ata, const int ruleset_fd)
>  		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
>  	}
>  }
> +
> +static void setup_loopback(struct __test_metadata *const _metadata)
> +{
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, unshare(CLONE_NEWNET));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	set_ambient_cap(_metadata, CAP_NET_ADMIN);
> +	ASSERT_EQ(0, system("ip link set dev lo up"));
> +	clear_ambient_cap(_metadata, CAP_NET_ADMIN);
> +}
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/=
selftests/landlock/net_test.c
> index f21cfbbc3638..0b8386657c72 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -103,17 +103,6 @@ static int set_service(struct service_fixture *const=
 srv,
>  	return 1;
>  }
> =20
> -static void setup_loopback(struct __test_metadata *const _metadata)
> -{
> -	set_cap(_metadata, CAP_SYS_ADMIN);
> -	ASSERT_EQ(0, unshare(CLONE_NEWNET));
> -	clear_cap(_metadata, CAP_SYS_ADMIN);
> -
> -	set_ambient_cap(_metadata, CAP_NET_ADMIN);
> -	ASSERT_EQ(0, system("ip link set dev lo up"));
> -	clear_ambient_cap(_metadata, CAP_NET_ADMIN);
> -}
> -
>  static bool is_restricted(const struct protocol_variant *const prot,
>  			  const enum sandbox_type sandbox)
>  {
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index 67db0e1c1121..2ab27196fa3d 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -11,8 +11,11 @@
>  #include <linux/pfkeyv2.h>
>  #include <linux/kcm.h>
>  #include <linux/can.h>
> -#include <linux/in.h>
> +#include <sys/socket.h>
> +#include <stdint.h>
> +#include <linux/sctp.h>
>  #include <sys/prctl.h>
> +#include <arpa/inet.h>
> =20
>  #include "common.h"
> =20
> @@ -839,4 +842,101 @@ TEST_F(socket_creation, socketpair)
>  	}
>  }
> =20
> +static const char loopback_ipv4[] =3D "127.0.0.1";
> +static const int backlog =3D 10;
> +static const int loopback_port =3D 1024;
> +
> +TEST_F(socket_creation, sctp_peeloff)
> +{
> +	int status, ret;
> +	pid_t child;
> +	struct sockaddr_in addr;
> +	int server_fd;
> +
> +	server_fd =3D
> +		socket(AF_INET, SOCK_SEQPACKET | SOCK_CLOEXEC, IPPROTO_SCTP);
> +	ASSERT_LE(0, server_fd);
> +
> +	addr.sin_family =3D AF_INET;
> +	addr.sin_port =3D htons(loopback_port);
> +	addr.sin_addr.s_addr =3D inet_addr(loopback_ipv4);
> +
> +	ASSERT_EQ(0, bind(server_fd, &addr, sizeof(addr)));
> +	ASSERT_EQ(0, listen(server_fd, backlog));
> +
> +	child =3D fork();
> +	ASSERT_LE(0, child);
> +	if (child =3D=3D 0) {
> +		int client_fd;
> +		sctp_peeloff_flags_arg_t peeloff;
> +		socklen_t peeloff_size =3D sizeof(peeloff);
> +		const struct landlock_ruleset_attr ruleset_attr =3D {
> +			.handled_access_socket =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +		};
> +		struct landlock_socket_attr sctp_socket_create =3D {
> +			.allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +			.family =3D AF_INET,
> +			.type =3D SOCK_SEQPACKET,
> +		};
> +
> +		/* Closes listening socket for the child. */
> +		ASSERT_EQ(0, close(server_fd));
> +
> +		client_fd =3D socket(AF_INET, SOCK_SEQPACKET | SOCK_CLOEXEC,
> +				   IPPROTO_SCTP);
> +		ASSERT_LE(0, client_fd);
> +
> +		/*
> +		 * Establishes connection between sockets and
> +		 * gets SCTP association id.
> +		 */
> +		ret =3D setsockopt(client_fd, IPPROTO_SCTP, SCTP_SOCKOPT_CONNECTX,
> +				 &addr, sizeof(addr));
> +		ASSERT_LE(0, ret);
> +
> +		if (self->sandboxed) {
> +			/* Denies creation of SCTP sockets. */
> +			int ruleset_fd =3D landlock_create_ruleset(
> +				&ruleset_attr, sizeof(ruleset_attr), 0);
> +			ASSERT_LE(0, ruleset_fd);
> +
> +			if (self->allowed) {
> +				ASSERT_EQ(0, landlock_add_rule(
> +						     ruleset_fd,
> +						     LANDLOCK_RULE_SOCKET,
> +						     &sctp_socket_create, 0));
> +			}
> +			enforce_ruleset(_metadata, ruleset_fd);
> +			ASSERT_EQ(0, close(ruleset_fd));
> +		}
> +		/*
> +		 * Branches off current SCTP association into a separate socket
> +		 * and returns it to user space.
> +		 */
> +		peeloff.p_arg.associd =3D ret;
> +		ret =3D getsockopt(client_fd, IPPROTO_SCTP, SCTP_SOCKOPT_PEELOFF,
> +				 &peeloff, &peeloff_size);
> +
> +		/*
> +		 * Creation of SCTP socket by branching off existing SCTP association
> +		 * should not be restricted by Landlock.
> +		 */
> +		EXPECT_LE(0, ret);
> +
> +		/* Closes peeloff socket if such was created. */
> +		if (!ret) {
> +			ASSERT_EQ(0, close(peeloff.p_arg.sd));
> +		}

Nit: Should this check for (ret >=3D 0) instead?

I imagine that getsockopt returns -1 on error, normally,
and that would make it past the EXPECT_LE (even if it logs a failure).


> +		ASSERT_EQ(0, close(client_fd));
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_EQ(1, WIFEXITED(status));
> +	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	ASSERT_EQ(0, close(server_fd));
> +}
> +
>  TEST_HARNESS_MAIN
> --=20
> 2.34.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

