Return-Path: <netdev+bounces-221601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA378B511E3
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517784616D5
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D71C2BE02B;
	Wed, 10 Sep 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aN12IBeL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WFCvfnlz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2631D39A
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494642; cv=none; b=V4b7SHDECLDjTuHTAFBIJqu/4c4p1+UrBL7CKaEG2n7hyTvkQLwCJkCeDZGjwyp+uP9Fpd22MIf8SgDmzlW2fvFIf0CVt4l/nxoI6V+JKdpdC1nqro9/7BmxDEQiwl1ak7g94AVydMxicb529S0xxZ95O4Z7Ze1YRMQGAZZUOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494642; c=relaxed/simple;
	bh=n6HktFMvXlEZfA1HoDdBO9d4w2msy3IhJMr13Fd8rE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l0SxQlodaNPONm5HHzx2frjjk4QgR/U1mI8S8ID74VFTdRdGHpGrEyr5cnoLSGSHCUTULwHirbrc8ALi+WpmBd8nl2We0rgYhKdyrZGYes1HVRfc4lua72iE2cAZPyI8mJ64GXyR0iYLMcbIJh7rTmjXSJFsb2ir/Yj2DR8Fqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aN12IBeL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WFCvfnlz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757494638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pc/v+5JWAGJNdou9DYjUduiOh9htdW77VarGrhFdsfU=;
	b=aN12IBeLmQo21aQlVNThc1EpUhg4L6W6cmFgCOYjrLiqDxPjUtGrkon8xZNAPN8MEXAy7R
	lD2oKJgqBLLBRiL5MXb31XQ0yuZgcg8qbddr9eXJi2P6vmR237Ur85UXXjuNlf8HFq6JPX
	n3ca4ktYKETDtKQb6LnFoFN90APMWGEQe5USGhq5seuKSaYWoH7StFVBhgFPmmpmRfRlJu
	x5Jg7iyjQv5jHLQYD84yBiDn4NVhr4U0UWVjzkKihnxsh+0dZYZkYlAnElAtpEwJ8C6uPi
	NUTlravFNK/cbpbvtoV67XhBWkDmiAXwSgliq+NNNiS9Q8U7UOhfXdGB9m7n0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757494638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pc/v+5JWAGJNdou9DYjUduiOh9htdW77VarGrhFdsfU=;
	b=WFCvfnlzo33gNofzRk7Wi34l4vbkWKvQU4gIuAvAiaGKiRKxYd14v0T5F3nbVz0xR4LYCT
	W5PIyc3HMkDYMOBw==
To: Kohei Enju <enjuk@amazon.com>, vitaly.lifshits@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, enjuk@amazon.com, intel-wired-lan@lists.osuosl.org,
 kohei.enju@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igc: unregister netdev
 when igc_led_setup() fails in igc_probe()
In-Reply-To: <20250910075231.99838-1-enjuk@amazon.com>
References: <15453ddf-0854-4be6-9eed-017ef79d3c77@intel.com>
 <20250910075231.99838-1-enjuk@amazon.com>
Date: Wed, 10 Sep 2025 10:57:17 +0200
Message-ID: <87cy7yk7ma.fsf@jax.kurt.home>
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
Content-Transfer-Encoding: quoted-printable

On Wed Sep 10 2025, Kohei Enju wrote:
> + Aleksandr
>
> On Wed, 10 Sep 2025 10:28:17 +0300, Lifshits, Vitaly wrote:
>
>>On 9/8/2025 9:26 AM, Kurt Kanzenbach wrote:
>>> On Sat Sep 06 2025, Kohei Enju wrote:
>>>> Currently igc_probe() doesn't unregister netdev when igc_led_setup()
>>>> fails, causing BUG_ON() in free_netdev() and then kernel panics. [1]
>>>>
>>>> This behavior can be tested using fault-injection framework. I used the
>>>> failslab feature to test the issue. [2]
>>>>
>>>> Call unregister_netdev() when igc_led_setup() fails to avoid the kernel
>>>> panic.
>>>>
>>>> [1]
>>>>   kernel BUG at net/core/dev.c:12047!
>>>>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>>>   CPU: 0 UID: 0 PID: 937 Comm: repro-igc-led-e Not tainted 6.17.0-rc4-=
enjuk-tnguy-00865-gc4940196ab02 #64 PREEMPT(voluntary)
>>>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debi=
an-1.16.3-2 04/01/2014
>>>>   RIP: 0010:free_netdev+0x278/0x2b0
>>>>   [...]
>>>>   Call Trace:
>>>>    <TASK>
>>>>    igc_probe+0x370/0x910
>>>>    local_pci_probe+0x3a/0x80
>>>>    pci_device_probe+0xd1/0x200
>>>>   [...]
>>>>
>>>> [2]
>>>>   #!/bin/bash -ex
>>>>
>>>>   FAILSLAB_PATH=3D/sys/kernel/debug/failslab/
>>>>   DEVICE=3D0000:00:05.0
>>>>   START_ADDR=3D$(grep " igc_led_setup" /proc/kallsyms \
>>>>           | awk '{printf("0x%s", $1)}')
>>>>   END_ADDR=3D$(printf "0x%x" $((START_ADDR + 0x100)))
>>>>
>>>>   echo $START_ADDR > $FAILSLAB_PATH/require-start
>>>>   echo $END_ADDR > $FAILSLAB_PATH/require-end
>>>>   echo 1 > $FAILSLAB_PATH/times
>>>>   echo 100 > $FAILSLAB_PATH/probability
>>>>   echo N > $FAILSLAB_PATH/ignore-gfp-wait
>>>>
>>>>   echo $DEVICE > /sys/bus/pci/drivers/igc/bind
>>>>
>>>> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
>>>> Signed-off-by: Kohei Enju <enjuk@amazon.com>
>>>=20
>>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>>
>>Thank you for the patch and for identifying this issue!
>>
>>I was wondering whether we could avoid failing the probe in cases where=20
>>igc_led_setup fails. It seems to me that a failure in the LED class=20
>>functionality shouldn't prevent the device's core functionality from=20
>>working properly.
>
> Indeed, that also makes sense.
>
> The behavior that igc_probe() succeeds even if igc_led_setup() fails
> also seems good to me, as long as notifying users that igc's led
> functionality is not available.

SGTM. The LED code is nice to have, but not mandatory at all. The device
has sane LED defaults.

>
>>
>> From what I understand, errors in this function are not due to hardware=
=20
>>malfunctions. Therefore, I suggest we remove the error propagation.
>>
>>Alternatively, if feasible, we could consider reordering the function=20
>>calls so that the LED class setup occurs before the netdev registration.
>>
>
> I don't disagree with you, but I would like to hear Kurt and Aleksandr's
> opinion. Do you have any preference or suggestions?

See above.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmjBPW0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgmfSEACerOjOXk+2Y8gvMjauZVEXuS1cMIaM
Ej18mKnpkGLjVUjPdBNzXM3G3PcE4XZnl191D3QBpAHnopTaf9dRdSS0WjeNa1sY
QlXkINq9DF+rNZmca3vGIyEv+DHHl+/r9APfWJKBE82gpg/+3tjbip18NIVQfes3
kCQQiyFJfiLVTXSsZzQnF3/JQLjuahgM3ysXzq+jEPLq25A5IOma+cksRFi2nW5d
uM4D4ArgTvX5eVP3Q2bQLJvoaqUd2pkdywquIKcboSMuKiSmVz3CQFUuZooiV6kq
1qbwsqyo694SUgMCTN/gwvGTPuyjEHOOiXQs6lgR/4ba/3AHUv9ncQsJZYd0+p/k
hDKypy7/JhV0HUjvOLqwFV8BvPqYwK21D6IFogbO4kYqzwx5++CL0JJHvDweP9Q0
6une76DEbGMgUG3KJBMBv5w6oszPsH1PwBSLzPE7Lh+Q41hOleJjy9UOB2jzxqpb
Fp0TYZ4619VNCppChwGzo9BA9fbfkIXiW+rw6mKXTUHFXckrVRvlwVP8ixVwlvto
CHzPoOeCKcBYeN5g6rrEkfiQn4lMQwVROyY33nJbK/ycY3qGYmRR/v0TMTZ4R8O2
SV4PYIDP8ul3VK+Cf55+LN0VrDM4Po1H9vgPgCcOPTh/LL329z1T1u3RQgG+BBac
jAEsDZ20sajB8Q==
=qkE/
-----END PGP SIGNATURE-----
--=-=-=--

