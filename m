Return-Path: <netdev+bounces-65185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB78397D3
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 19:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D351F1F246F3
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC72664D6;
	Tue, 23 Jan 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qVA3g3jD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A550A64
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035046; cv=none; b=BFytbvmeDLoco0CuLzkPHlI6yA+CAMIqXG9yPYBNZOxm73U6SxB9ALelNfDJlk9GkMG2f8uQbP3a2IGc94TtKm9Jclx3e9baeAJXos7Gg3eHL8D84U2QKfTgBwMsQMa5ecAcKRpcJAvLzZvB6+OQrtiVgf+GaokEbVahpvKnsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035046; c=relaxed/simple;
	bh=5hmoJYcbxYC/DMuJvWLEbRHwstzxBbKCbzKdquxm6JM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=AXOODNBN/+Vv/XYlo8kEj8cQxS3aj5W1h37S1v1p99+HiJY/iks8X9WCLkWPcyGhq3POQL8fGvwFvC5bCyTJgMhFTWmeTS8oAPg9fjTlsoEBB+b8ldVVWuWJg0KRhLg0nuA7Fz29NBGUEQoEuyi1g1BcTMhNvGlHDv41okzm+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qVA3g3jD; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B920B4032E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 18:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706035036;
	bh=gyqyrQAXMB5keOkxLiDw4Lf1z+ZGYfQOoYRtUzAmmGE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=qVA3g3jDKbJ5KjguIGjd4TMXAC90Dc7ycdsbCEXW0Jdpj/HAHf61ye85zr29sOKHb
	 XOjOS7XAHIoda7MI9kJkjqKgpeehwDCu7QtrjXQiMNYAnPiWqv9kehp7eWmK6iVO7b
	 rm7Hy3LPiTZPGVwWSMOMp0S0K6GKGsQHoK/KpVZXtOfCDTqmXUxy3q+Feu+juGefdf
	 YRRY1S12ttXl0XRqDAkeeyAmTnHZN/jywRrHbiK4RoxwO36+wS/9ylDxnoqiNiNxko
	 gowjG5IhHxIsBGP/o1pcHQWVVuUStuYn5pXo+yCXoVSp73OGE73vLKSfbJ/Eagd5Qg
	 jCvEVHPV0Y3lA==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6dd81eb1d43so743067b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 10:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035035; x=1706639835;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyqyrQAXMB5keOkxLiDw4Lf1z+ZGYfQOoYRtUzAmmGE=;
        b=a+aQf7BnUS6PLSzYZUGrG0TPfI5Gwyv9IRp6dHirYA8kww4nyoVU0teSrIsX8Le6l8
         jehgVXNSF1eEzyGjB5mQg+5rc+sv3LgPuoR0ejJqBn3GbJs1GFsqO8M5GwJ3iUiJMvNi
         iMPqSb+iLlR77kO0tj3QGgR/toKJNbvu7O6iSeVUQDRyiAEZhtzz13jlSEIi6LtPzFvN
         U+pVuMf0hKeHXFfLoHsSwhuUVMAgiJguUhXvkiA4idagWCAmOGh/4zTc9iFGi8zsze15
         sCrExxJjvEjiYxhaBbvEXlNTjXdlF22ZUI0BINrinyp6K0WaaXj7m+9umOcG2VcNdmzg
         Hj8g==
X-Gm-Message-State: AOJu0YwF4Dmbv3oGrHT2erWCYdDaPNWsfEuWR+OrEyXw6fWQ2MNG3q/T
	z/BPOgBbpJ8bBJFpm+N3roFhLbBag4uolxxgmlF9B2OfpCubPoiQl6WF0enjQ4syRaH3mMBm0w1
	npIrPP+O7y3QTToT/2RT9AcpJgHlDEzHQFqmR4ONDgufm1r7gKOugXMtzwwHaH1/0NbWurVGTz+
	G6gA==
X-Received: by 2002:a05:6a00:188d:b0:6ce:6407:2264 with SMTP id x13-20020a056a00188d00b006ce64072264mr4479675pfh.56.1706035035185;
        Tue, 23 Jan 2024 10:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMPgR+R7LP+FtJ7+PbKq7/BdFHeTo550Ul1peDUot94cYIfVDmgBsiA8wDh3hVQisK8iuWdw==
X-Received: by 2002:a05:6a00:188d:b0:6ce:6407:2264 with SMTP id x13-20020a056a00188d00b006ce64072264mr4479667pfh.56.1706035034906;
        Tue, 23 Jan 2024 10:37:14 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id it11-20020a056a00458b00b006dbcd7b4d19sm6539888pfb.192.2024.01.23.10.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:37:14 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 26A275FFF6; Tue, 23 Jan 2024 10:37:14 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 1FA299FB50;
	Tue, 23 Jan 2024 10:37:14 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] selftests: bonding: do not test arp/ns target with mode balance-alb/tlb
In-reply-to: <20240123075917.1576360-1-liuhangbin@gmail.com>
References: <20240123075917.1576360-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Tue, 23 Jan 2024 15:59:17 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2393.1706035034.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2024 10:37:14 -0800
Message-ID: <2394.1706035034@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>The prio_arp/ns tests hard code the mode to active-backup. At the same
>time, The balance-alb/tlb modes do not support arp/ns target. So remove
>the prio_arp/ns tests from the loop and only test active-backup mode.
>
>Fixes: 481b56e0391e ("selftests: bonding: re-format bond option tests")
>Reported-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>Closes: https://lore.kernel.org/netdev/17415.1705965957@famine/
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>


>---
> .../testing/selftests/drivers/net/bonding/bond_options.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh =
b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
>index c54d1697f439..d508486cc0bd 100755
>--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
>+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
>@@ -162,7 +162,7 @@ prio_arp()
> 	local mode=3D$1
> =

> 	for primary_reselect in 0 1 2; do
>-		prio_test "mode active-backup arp_interval 100 arp_ip_target ${g_ip4} =
primary eth1 primary_reselect $primary_reselect"
>+		prio_test "mode $mode arp_interval 100 arp_ip_target ${g_ip4} primary =
eth1 primary_reselect $primary_reselect"
> 		log_test "prio" "$mode arp_ip_target primary_reselect $primary_reselec=
t"
> 	done
> }
>@@ -178,7 +178,7 @@ prio_ns()
> 	fi
> =

> 	for primary_reselect in 0 1 2; do
>-		prio_test "mode active-backup arp_interval 100 ns_ip6_target ${g_ip6} =
primary eth1 primary_reselect $primary_reselect"
>+		prio_test "mode $mode arp_interval 100 ns_ip6_target ${g_ip6} primary =
eth1 primary_reselect $primary_reselect"
> 		log_test "prio" "$mode ns_ip6_target primary_reselect $primary_reselec=
t"
> 	done
> }
>@@ -194,9 +194,9 @@ prio()
> =

> 	for mode in $modes; do
> 		prio_miimon $mode
>-		prio_arp $mode
>-		prio_ns $mode
> 	done
>+	prio_arp "active-backup"
>+	prio_ns "active-backup"
> }
> =

> arp_validate_test()
>-- =

>2.43.0
>

