Return-Path: <netdev+bounces-197714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1217DAD9B02
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 09:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F6C17D2BC
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 07:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D51EB5E1;
	Sat, 14 Jun 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fOyCDG/P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r9twnhhC"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254A17D7;
	Sat, 14 Jun 2025 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885502; cv=none; b=D6rMmtYEhbfuHJ9ky3QT3zso3DmC1Tk575dBe19s/VyvQqwbP5VJ2hQN/UAKBDpVzj2LjfxDl5VWj1s4zeuZamI+YnOB6PYNJCrPRQvXW+vpcuIVUYoy7X6bMGxj5wKJyu5A9Y+1530KxyBkIddHbJV6ud6f1qkO67qVm2W3IfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885502; c=relaxed/simple;
	bh=DeyVmMWcBcomC3OKRJu6xjE7m9jQ9dULA9WqqNfp9Nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EiO4sjW1ePiDkfVscf1r8R6HC4aM4bH3sfMHaF+BgFlUka4TUDBOMp0Li7WPf2Ko7Fw3JJFzup9LdrFzQMyaKNrNEYiFKWi9d5feXwAh/RXIKRLuvFaCG9mi/LZqltKgBO8rlt+Ti8XopKnkudJ0xz8zSQFLDTtG8iZ2HKndEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fOyCDG/P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r9twnhhC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749885498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmBqqCE2Ltcatww/m8uKRPjbxYr0xerGcV78Bq2aKQQ=;
	b=fOyCDG/PLvpxStMonZ5taMt3WE2eoGSxF0oMRQ62lHNWjqkK0eJ086LPtPKMc9YfHvKKxz
	0rwhy/3RIwejCY/ZrQqq8W2GDb/8zxUO039mH/Njq66cyvZXs3K5r1oFfitF4RJDMoFXVj
	tgvPN7VuxexW7BzN+J7Sa5kbuInUf1YoVMqekaKQa2r+q+sYQZkLTUqBi/VrsvJz/o3bBz
	6aIkkjfKV19J670q0TuJ7dRr1uX5lIzkWwutQCL8OZ8DWj17KV3bLQoSWlP10qll/osfoS
	pirF9CEEfobsM8dhx0HeeosMDoCO6KR/4LbXhoDVbmtwT7VGEh2pw96kdxF77g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749885498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmBqqCE2Ltcatww/m8uKRPjbxYr0xerGcV78Bq2aKQQ=;
	b=r9twnhhCI4HkQV6UCJltzWyyHvmhX9rdFPf2DJjLiRxXoY2wG3qub+gF+9zNPuyZ5JvwLW
	kj3EqA8SdPOmEkBw==
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kurt
 Kanzenbach
 <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [patch V2 17/26] timekeeping: Provide time getters for
 auxiliary clocks
In-Reply-To: <CANDhNCoW3whgp1ZW=Fpw6mFgbYowue2H_RR_Y9UYCTLstLJDrA@mail.gmail.com>
References: <20250519082042.742926976@linutronix.de>
 <20250519083026.655171665@linutronix.de>
 <CANDhNCoW3whgp1ZW=Fpw6mFgbYowue2H_RR_Y9UYCTLstLJDrA@mail.gmail.com>
Date: Sat, 14 Jun 2025 09:18:17 +0200
Message-ID: <874iwipz9i.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13 2025 at 19:51, John Stultz wrote:
> On Mon, May 19, 2025 at 1:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> +/**
>> + * ktime_get_aux - Get TAI time for a AUX clock
>
> Is this actually the TAI time? Wouldn't it be the MONOTONIC time for
> the AUX clock?

Of course not TAI. It's not monotonic either as it can be set. It's just
AUX clock time, whatever that means :)

>> + * @id:        ID of the clock to read (CLOCK_AUX...)
>> + * @kt:        Pointer to ktime_t to store the time stamp
>> + *
>> + * Returns: True if the timestamp is valid, false otherwise
>> + */
>> +bool ktime_get_aux(clockid_t id, ktime_t *kt)
>> +{
>> +       struct tk_data *tkd =3D aux_get_tk_data(id);
>> +       struct timekeeper *tk;
>
> Nit: Just to be super explicit, would it be good to name these aux_tk
> and aux_tkd?
> So it's more clear you're not working with the standard timekeeper?

Yes.

