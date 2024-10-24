Return-Path: <netdev+bounces-138895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6FA9AF530
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 00:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 179FFB217AA
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EAA217912;
	Thu, 24 Oct 2024 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLp30uKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E5222B66F
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808323; cv=none; b=jX5NM6vdmMy48nLefQdYRbynv6mwhTzPtHQnr3hgXiJDE3SUdsI6t1ofoADhco6oQBOuClZDC/y4H8X8pxaxgV9q5vMALi0m44kR0Wb2n/aoM/4PjZ7lPYTHx7rWu0QRNkmMkqyOmJ/QSvPlCRsUvSJF6G2lm9w6RiHt6Jtdvh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808323; c=relaxed/simple;
	bh=TcLZugAwWK7ixIAO3PjyY8c0PzVveSS3sSYYVTDgJfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYqeG4eLv//s9WYlWKGSupzJbeiF8sZi+xQ1mZWKNgF/YgoXQ9eUOhavWB7WC1FIMGc9/1Sgsys/a0GGxk5sqojiFu32tQDYKSFe3TFg4B6fgeAxlOw9C//0EWyALZC1pti0jTaqJTty5KAtgKz99gZ07lJvx4faUQ4yjhLcz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLp30uKM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so2003326a12.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729808319; x=1730413119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcLZugAwWK7ixIAO3PjyY8c0PzVveSS3sSYYVTDgJfo=;
        b=wLp30uKM35ok1bKIqrANYJConIZPJ9SMRNQagEoNenGFnOxzwqplm/2FdT3uUDISgD
         e9Tl+AknabXGONMESNF+iGlKJRRvQGlvD8hiXRupgUORd7o4HJ7ubsASGsBFG62gYtgT
         /7QgaEX94GbIQ4ZDoBXvAUwqOCTefKUXxomVcYo7BGUzmv1ZSXZgj294lnY7YhAoaBu4
         eY9COsQyRd7AbwIgd8Ze8UGRK/TLhPw/8iQuoNIofseharM2KB8okiQjnG+otU1PUdF4
         1GuGC9LA6pqiKqH8t8ELE2WYlS4vT99BdxNC8DDHlBWRofsbM+Z1AiF+31Ym1Ugloiiu
         ixiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808319; x=1730413119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcLZugAwWK7ixIAO3PjyY8c0PzVveSS3sSYYVTDgJfo=;
        b=pd06yLH6nYJ1quBKdy022qgZObsgTHy1thmG1HW9B0SEgA6t2B7CrKG94Bhbbaamx8
         hNsV7bDZGi0bN0It/HquLBG4QPjSTXI0OzPGNwJs/aFjs2JrfUsCDzm8t5M+PMyXnQyE
         02jAW22JPqwnj0qqVPyDtGUiIMy8yWbDZdWBGlejFrRbmuKaA8S1GOR/5kvmcgJpGsuh
         hdTE5ZgQtxscbUSxKOnqWpYv94yjl8TeNZi9Lj6QiLqkoUBBgV1AjWINLIOUD6oSfu5E
         kbibu8FCu2/Q9KuT++5cQDcGjlmRSRzcpWRXiXsIv2Krq8ZMC+1wE8gkPKoauVxFN9I7
         dHOg==
X-Forwarded-Encrypted: i=1; AJvYcCWBtlbD03UVvDJH6LBpzzzy4x+qe19MH2XZtVzyv8YSfglLCzXCRpTMzg3nAlU5c6ZAWQi32jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzepP7niEhSOr9Ik0ZLgNjTv7m8S4voV5o39ZIcRIBsWTKkmd4u
	Awj1tfv7L+fCYa3UqRtjg2h9wQ9+vb7IhQ9Enm3GJVeJ5c1/mlCqiQJmR0FxRtAJCa1hg31leF4
	sr70CSiTvUvhMG6/c3nZnL0QUczWuXHeNfFM=
X-Google-Smtp-Source: AGHT+IG8WcpUNaUJgr/vCUTSA4IgLgHegvHGRYXt1LGoLXuH7HRCblDWr1DENfI60f4lVD7sQE5UHJkgnOpL3M2ynTA=
X-Received: by 2002:a17:907:940d:b0:a9a:825:4c39 with SMTP id
 a640c23a62f3a-a9ad27375femr332100166b.20.1729808319342; Thu, 24 Oct 2024
 15:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-21-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-21-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:18:28 -0700
Message-ID: <CANDhNCpGPfuLYj_jPPV7Vj-ncEqV36K7-PLPeFufF1MuCJMJBg@mail.gmail.com>
Subject: Re: [PATCH v2 21/25] timekeeping: Rework timekeeping_resume() to use shadow_timekeeper
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Updates of the timekeeper can be done by operating on the shadow timekeep=
er
> and afterwards copying the result into the real timekeeper. This has the
> advantage, that the sequence count write protected region is kept as smal=
l
> as possible.
>
> While the sequence count held time is not relevant for the resume path as
> there is no concurrency, there is no reason to have this function
> different than all the other update sites.
>
> Convert timekeeping_inject_offset() to use this scheme and cleanup the
> variable declaration while at it.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Other than the tk_shadow naming nit from earlier,
Acked-by: John Stultz <jstultz@google.com>

