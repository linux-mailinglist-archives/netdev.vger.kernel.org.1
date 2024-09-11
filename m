Return-Path: <netdev+bounces-127536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507F9975B38
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14302284483
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194CC1BA888;
	Wed, 11 Sep 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufwNgHM9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7557333
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084865; cv=none; b=qvqggmsmyJILRNMbBiGnqXRUIn6wRoyIpXa2k6FCNs8jYKrDoMp6E4xCkMjRVYlLo/5At5hEDuRtythyhKUwqvmICfh39/C0gP050K0Sr4jtaA670SJDQ+W+6IQFQCu45jB+ZsiMwBDVVnoI2DolKfyL6MMgYFJTNjhnboDlrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084865; c=relaxed/simple;
	bh=k7YGE/HAplf0XjvHfK2+m8qOpcTrVatN5s0xk5zu56w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIlkCRb4PgaGOH++LaSxY4GtW8yH/lXDVnYEJRsk7jkzeFus9qECRJOQnSLx/RjLtx5s+otjLZoPj5Y8AiwkUr/EoR+PO69UU39cSOUUrJngsKX58mMB7Lo1u/PeYbCWPmJ06kwRolzPCZFyTnUZyIpX7FLiXJl0h0HpXR3gnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufwNgHM9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso25622966b.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726084862; x=1726689662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7YGE/HAplf0XjvHfK2+m8qOpcTrVatN5s0xk5zu56w=;
        b=ufwNgHM9a67+FTxq3UR8QLaUak1ZKhWQ9NRq5lvWnlLY4p2ltCiS7QZquO/S3UK9F+
         oTQshTCFhpurcX0wMPcaJnkiPESLkh0DEyjyChNSn7DsCC9lWqiPj/ugLsJcocT+3C2P
         ej2SW4ClYCliYPwVQRpcrGgjJMG6vf0pZKpn5XE4xsJTiCROuIqoeBrPPXBsQsDSOb2H
         WFJDjbfiT9zJEFGrTq3ljzqcWcwkUO3m0zlhX43p+N2P5YEI/o7cBjYxE0EJZ9uZdiuK
         3LzlgXWlyUGiBZIGELeyHsho5VxvRi3uu/gIiObJNOROBK9Vj4sMZX4KQshtMEae+lWF
         opSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726084862; x=1726689662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7YGE/HAplf0XjvHfK2+m8qOpcTrVatN5s0xk5zu56w=;
        b=kK3+gIZozUWvBCJT1YWCFz8TuslEptowvkVktb8mBfEO+t1h1OC/xVd5+BCGmvWk76
         wKaxtq/0qKUUmRLBdU8sEk7HZ3e5cAh48p6XRja8TpcTA2bi50S0SRmZPygsUiscExeS
         5+7t7Ja4zTfE3jXrc0lmO8WVzvkrlLh8Z2dQIsDXCdUDDGQQeggEFVEMKMfkVBKbtyAs
         0vkmLWGL612FY5yL4+kYFPUd/rmBBmNUnnsMvek99LO/zR+xTDVUSz1di+Y3XGH2wdCV
         noc1gvwdLgu4PQ0E5NRnq9VSFcxNuPRcBVu5GS1H2IXtDqOD6I7vKIMPl5ipVjfmT1ZP
         uApQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlzENOLvCHopNY+vTqp6mzUDPdz9qvFx/SyFlq+b17X8C9TFNhYKEq+HCy9X1eSxsKTfynXLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOzWa0tesFXE0/rjEkK8Rhe3hqlaMnSi9dphHbsj0LIbV8RYB
	kMD9Wsr4U98g7BdAgCnM8aGnuhyzqk4g/0axDFbCbZuNgg/E86jVm0G99v6cCgKBjZ75G5p2cuK
	Dy9fx43hnZcdZYO4qZUOvYON/zRa2kwOiQ7M=
X-Google-Smtp-Source: AGHT+IHdnj3Vd2kpmZXK/IoEHXyuSQsbsfirlzCGNIRsUhRhpvqYGr4h4+fdQxF4LXx9mZr5/7PBgtujMvbJoYbmWlE=
X-Received: by 2002:a17:907:f783:b0:a77:e48d:bae with SMTP id
 a640c23a62f3a-a902949aec3mr59308866b.28.1726084860628; Wed, 11 Sep 2024
 13:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-6-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-6-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:00:48 -0700
Message-ID: <CANDhNCq3MU=hGyWZWcVvRkAubEq6jYO5a61VwQi_e+ZtvK5uxw@mail.gmail.com>
Subject: Re: [PATCH 06/21] ntp: Read reference time only once
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The reference time is required twice in ntp_update_offset(). It will not
> change in the meantime as the calling code holds the timekeeper lock. Rea=
d
> it only once and store it into a local variable.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---

Nice!
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

