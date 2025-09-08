Return-Path: <netdev+bounces-220703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C78B4842B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668FB3B16ED
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 06:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27222D7B5;
	Mon,  8 Sep 2025 06:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4qo1JKGK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pF4zonKh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9F22A817
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312779; cv=none; b=QFvplWjR0l1C+mwEOKSamUbp+iR90B4ChfHKxzaQwDgBZCOGfcc0SWDEEQJTR3EaTVA8bP4CKUU0HQiqEWVaRNr88IVoFnfRfiF5ZWiAH0IQwCF3Ws/ggsXftmjCA4fazSFxn3wbq0CsP3Ibw/BMlygBFmMUHdVnVCZhCMWIYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312779; c=relaxed/simple;
	bh=cNeEGO2qeRPk7Y3v4ju+lunlIPdLEF6Me6/Qd6mXzbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HY8tyrONqGR4I8hKz8dIZqHJuvhlBqWC0dIhYFRbHjQEgfov4YlFADaJRnsneP7ZtmbLwlfxRtYBJQ5NbFn/EuW3Qiw53lhZGrX/cOV85QA4iC6vXpHyzZbkJ0aHvjKWsF+V4ppzmMqK0daH+Jk8/2vVUmgN0SBYh5FmKbPJ1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4qo1JKGK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pF4zonKh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757312773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bBqlMJnbWGXcmUBtE9PTudTuxx/UefA7GFyXkZGpvA=;
	b=4qo1JKGKfc4m9J1ccMlKLIidd6d4Ri5vxJjAvTeZabJNXQCmaBEh+REgLXSGSNy5h2mii5
	tBZW9eRI0zYa5r/i3GvrKZOELCOUzqet5E65QeQ3oRyFK/gfGiIHXfgz7tMGmDhXKV1EW/
	/2HA95Xf9CVR7MIYU4p+VOpTfFEtX8NXRMX27QHtCR5X4Sha4Q2m7eRA1gjWlt/sgFTQ8H
	AY0MIG7U9jMyosM/EGYuy37AsSWlfdd+O86/sUP6H2AHRQ22bY5eRKfiwYJzWhzhGMnjnf
	7/AvtW4qYqsLAhhmewgjsCfi5oZ/PXAqqZJVpdU4DYKny1Jv7oYZx3QagdW81A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757312773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bBqlMJnbWGXcmUBtE9PTudTuxx/UefA7GFyXkZGpvA=;
	b=pF4zonKhlnCDDbr7IsNBTtEWjdQnqtuoR+n2vFMFv1eZLbY0K7DGdfPuEHE0togKWtbSMT
	jKzYqlA5ChYh4uDA==
To: Kohei Enju <enjuk@amazon.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kohei.enju@gmail.com, Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH v1 iwl-net] igc: unregister netdev when igc_led_setup()
 fails in igc_probe()
In-Reply-To: <20250906055239.29396-1-enjuk@amazon.com>
References: <20250906055239.29396-1-enjuk@amazon.com>
Date: Mon, 08 Sep 2025 08:26:10 +0200
Message-ID: <87ikht794t.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Sat Sep 06 2025, Kohei Enju wrote:
> Currently igc_probe() doesn't unregister netdev when igc_led_setup()
> fails, causing BUG_ON() in free_netdev() and then kernel panics. [1]
>
> This behavior can be tested using fault-injection framework. I used the
> failslab feature to test the issue. [2]
>
> Call unregister_netdev() when igc_led_setup() fails to avoid the kernel
> panic.
>
> [1]
>  kernel BUG at net/core/dev.c:12047!
>  Oops: invalid opcode: 0000 [#1] SMP NOPTI
>  CPU: 0 UID: 0 PID: 937 Comm: repro-igc-led-e Not tainted 6.17.0-rc4-enjuk-tnguy-00865-gc4940196ab02 #64 PREEMPT(voluntary)
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>  RIP: 0010:free_netdev+0x278/0x2b0
>  [...]
>  Call Trace:
>   <TASK>
>   igc_probe+0x370/0x910
>   local_pci_probe+0x3a/0x80
>   pci_device_probe+0xd1/0x200
>  [...]
>
> [2]
>  #!/bin/bash -ex
>
>  FAILSLAB_PATH=/sys/kernel/debug/failslab/
>  DEVICE=0000:00:05.0
>  START_ADDR=$(grep " igc_led_setup" /proc/kallsyms \
>          | awk '{printf("0x%s", $1)}')
>  END_ADDR=$(printf "0x%x" $((START_ADDR + 0x100)))
>
>  echo $START_ADDR > $FAILSLAB_PATH/require-start
>  echo $END_ADDR > $FAILSLAB_PATH/require-end
>  echo 1 > $FAILSLAB_PATH/times
>  echo 100 > $FAILSLAB_PATH/probability
>  echo N > $FAILSLAB_PATH/ignore-gfp-wait
>
>  echo $DEVICE > /sys/bus/pci/drivers/igc/bind
>
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmi+dwMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgjOrD/4qyV9TBth01mlwn58WqE8vBfJlONOe
DEpsPViibjk9BIC5L0H0gtHfGhn7mST2PN8rH6BSlLa5/wXJZjv6Il0go6kkdzEN
MGeYSZF+JRf2gf6rj35ILThlbN0z9WdM+3ezZqd89v5nXVBZ8PgMLXcsNAZOlPEu
iChtRaXSYXU8JVqT+AxYje4k90qDXJcXz/j7OtDpw7cV5swdLLiIJ+6rBjzudN9m
q0hG2mkQPq9zlBScBocrZXOIDvOw1mk1s0h6W1UwnQPDy/0YUJxFdPsea4M99mKn
WoW5YC4zMkDfXhYdfSVesqRHq1nxM0gv2QiLu11oo3TQYUyzkZHs6360ury7lezf
pHJHfS0+g2WPzUuLxe6bijAHCv3fHIzsIjpswfezyVcQs+kGUWBOosvPWfuBf4qH
uzSk6+tlwlGccroAHMaCSFfzgiV91nn/KS9F6Q4cI+0ay+4A7oUcRHHNrvfmk4nK
eLuznh5E9p8D8IsE0lkAAj/YZsOotLe191bCCVHSEWQLLzDeQQNR8ZcQsBweVifS
jRklktMfyY5BfpohaOr2wNUb/Q+f4eusSBghHGF6F7AFbPY4s9F6zMzwLAbBkJhh
LE90hCQfZ2fG4KUxGqoezKplfM1wc16HE+gC+Qluk01QPrkmY2KTcC/OLvtFThQu
KXwFMmOLdZDBeg==
=GFLf
-----END PGP SIGNATURE-----
--=-=-=--

