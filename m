Return-Path: <netdev+bounces-300883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vEleEmsBOGoRXAcAu9opvQ
	(envelope-from <netdev+bounces-300883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 17:21:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF36AB2A0
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 17:21:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=dOcAFIjZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300883-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300883-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DCEE300D30A
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66FB23FC41;
	Sun, 21 Jun 2026 15:21:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B86244692
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 15:21:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782055271; cv=none; b=keYQb1CghqXw6Ws5z4jn3MZSRDNdu03+q/wUBRx3fd59V4ZDRmON7CzdybePa7A6r0+fkUZFieoHDwSkEInVy1Qgrp6o3W9OAHTf4h/vQlYNAPqqrEEXlKVzeWEphmD9G/9o1wS+SE7sLkI8uG32BbiiFjomwEjrYKlB9XusfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782055271; c=relaxed/simple;
	bh=V6bJc2kKXX5RxIaafBtpZR7kWXGPc0bhlLETGpoTTV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJeM5wz/sbUxMpcNvAuxLt7/FWXhx++k6QC2YJ46Q+jhxJyH791YHicIL6b/NN9+I7bQhvUiwWWU0Sex2WEk2kCbSnDOwfVpS81C80KAhj46ekcAcovyHaEU3srEA0L0iOnLhAlXA0IsSn5kDtbXNw/CPoRC7hcsnCjJaSVzRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=dOcAFIjZ; arc=none smtp.client-ip=74.125.82.174
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3078e0dcd67so3921027eec.0
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782055269; x=1782660069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C61TURbcQyA/q/iVOI2U9fMYP3vw9DJBaLH5sK2OR6o=;
        b=dOcAFIjZFsD5OfctnYNRmt3ACaZvT2AXdrJLUqiECSzZfh0QGp5Qs2fJF5KvP335J1
         GUy/ROJyaFW3meLRFfsCis8gylyUbXCkvNWEEMGqGwZPHR/JUP0jnH/rlTG49W2PnLQr
         G6LK7l+sHYsUHr5Q4yeyyaZvd+74R4DLZAJ4KohuEOcJ1KD1bX9DeaRjCwdfY3YzyTsq
         tWj99/VHsvglZC7b8ZVQQD703+uhOcvLClBl9NXjdSkig+12wx4kNEjZzF9sZyIe+Qox
         1TK8zXvQkiCx8/TLH6lKUcTYJJEtf5q05xvTUAj0uX/2+mX+p8JW+jikxAnJy3BEtj6D
         pv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782055269; x=1782660069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C61TURbcQyA/q/iVOI2U9fMYP3vw9DJBaLH5sK2OR6o=;
        b=c86wuyB9HiSpu+MlJGbKb14SXdaIa7X93d8Kvom3RqbKO/toVV4prLI7OWkQroktL/
         qRRHMwHa5o/Xxx81P+eA5uMURaZ+fbux/fm4ZmAYCbY7DhIEXeR+3ImefCDaftp70e1A
         QAKdriwCotB/cjfw/V3W5KbxZaVq3NBFKfvIEACRfuFWzabuAH2MQzgClcGt+yXN5b/9
         Q39c5PJJiSWpOSCmRzbQNynPSUpI7gUPQMUNi4SyOyPdpojqhkI+zM4bZOZMnyfMzat+
         h2bDe9BT7DHyYSGcJv2ENQ61zJUaf33uaH3/aKEkh8tR+VFdQHDBCwQsq6qCJGpdK2vo
         NcpA==
X-Gm-Message-State: AOJu0YxxhhRwG3DFgJXkIDYpDn6EAqVtcZjOl4sjcaFblxPW9Wby8ZWS
	7JxRd8XomFOUgu2IGaVld6ICgBsQwlUehc94ua+uKFvuiEN6kf/YlO7D1+L0IcVz11Y=
X-Gm-Gg: AfdE7cklB8jFHaMYLyQAxa0jKkKKNrQ5I3nKp3aGdoh7KAm7+ktAbxBc3F7MQlykAk+
	F4GBVXQcvZn5kTWnnIv5VInvfkCmDhjKAvfgz03Jnb5Dv9t4V7idu+mPdxJoTOqwNYtqe9Fjd0x
	yUhGmy0hBHwiWGJMDL1CEBQV1EteizNmWT1t+vVh+q8P2eiy/36ASCY3Q86gdBzekJNCgW9dGZ9
	/sK+RlgGBXVY2TRopwv6Uv9J0B57jlhyTDlmMI0d+sput0O7Bdasss5MWwJNdmdGPIbzNwH3Jzv
	p768i/B8u5QquUBiPsPUgdF0vEitccqpl+q6vJoYeT7LPxl+iFAl/xN0iSlpbeP63cY2sf+SSja
	CDMGR52CKPBXY8/Md05B0xdnNo1SymPS2XK2B/aVXyYvvDgccnhhDKFG8DYS3qeS2bdV3BGV3Y9
	pMaCIoMwHZlyyM1ixWDb3i349YICHqZi+lTBWlQdiEte7qapwcB7xE7A==
X-Received: by 2002:a05:7300:6c9f:b0:2ea:c085:44b1 with SMTP id 5a478bee46e88-30c071533c3mr7595373eec.19.1782055268963;
        Sun, 21 Jun 2026 08:21:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d78esm6440699eec.18.2026.06.21.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 08:21:08 -0700 (PDT)
Date: Sun, 21 Jun 2026 08:21:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dmitri Seletski <drjoms@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: "ip help" output is an error
Message-ID: <20260621082105.1196ef72@phoenix.local>
In-Reply-To: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
References: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:drjoms@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300883-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,phoenix.local:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BDF36AB2A0

On Sat, 20 Jun 2026 10:36:31 +0100
Dmitri Seletski <drjoms@gmail.com> wrote:

> Hello iproute2 maintainers,
>=20
> I am reporting an inconsistency regarding the exit status of the ip help=
=20
> command.
>=20
> Current Behavior:
> When running ip help, the command prints the help documentation to=20
> stdout, but exits with a non-zero status (error). This causes issues in=20
> shell scripts that rely on exit codes for control flow.
>=20
> Steps to reproduce:
> bash
>=20
> # This returns "FAIL" because the exit code is non-zero
> if ip help > /dev/null; then
>  =C2=A0 =C2=A0 echo "SUCCESS"
> else
>  =C2=A0 =C2=A0 echo "FAIL"
> fi
>=20
> Expected Behavior:
> Since the command successfully performs the requested task (displaying=20
> help information) and does not encounter a system error, it should=20
> return an exit code of 0.
>=20
> Context:
> This behavior breaks standard Bash logic for automation. For example:
> ip help && echo "This will not execute"
>=20
> "ip help |grep br" - this will bring no result.
>=20
> Current version tested: iproute2-6.19.0
>=20
> Thank you for your time and for maintaining this tool.
>=20
> Regards,
> Dmitri Seletski
>=20
>=20

Yes iproute2 doesn't do a great job of handling error codes
with usage vs help. Its a bug and no one has bothered to fix it.

