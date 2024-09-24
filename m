Return-Path: <netdev+bounces-129523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2131498446D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECF6B270FC
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7DC1A4F30;
	Tue, 24 Sep 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsuJmjzO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1621A270
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176908; cv=none; b=b1HM0+Pzu+Eh7a2J+tIpZvojhKq3vxg6dm1RfCoLuq/G0ZzMc83jB+QgMwzpg+TYNXmWfB3vSP4vxM5/KRD3tmTwvt0/Jhn+6m9rsvUhyUbJ1ghTBXa/CrvjrqvVBFJnCBaT5ycdGPadyLLNTc5ywWLXt0QFq1lOfAPNBQXpTqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176908; c=relaxed/simple;
	bh=SMqzVhG5SdaonHmaAq6rRj2N1TQoLv9pnExCxLW4ek4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grryJTwcRmpv1peytdadBYp82+S+wewqn0hrM3T41iFkgBLsXY67RhBUlzRadKL4qoWAk82afRCY3FR4+dVjJkBm4Og6kkiTw75bAT3WQf7nzl+yx7Qmb8iFqRlAoeSIeza5WLNgdZ79qMVKILExxoVkwf9ijNmAQoVUnAPPJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsuJmjzO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727176905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMqzVhG5SdaonHmaAq6rRj2N1TQoLv9pnExCxLW4ek4=;
	b=IsuJmjzOVoC7R5y2bcR372GNeQYoX9tDrpLWd2HJVTq52d/FctSYGI/iFG3V+eYoIhzr6o
	vVjbaxDWk+4gVxewseSjJYTkYu7iYQ5mWzi4JGPsWTvn25btqCJHLs+UgLJJhlO6xHyNa8
	joR59uVnlcHr5FW6nSbxkGX+IKEKnlk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-tZvc_ox7M9SZJyFDBuuQJA-1; Tue, 24 Sep 2024 07:21:43 -0400
X-MC-Unique: tZvc_ox7M9SZJyFDBuuQJA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5365c96f06eso3687454e87.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 04:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176902; x=1727781702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMqzVhG5SdaonHmaAq6rRj2N1TQoLv9pnExCxLW4ek4=;
        b=d7R1UZtaIanNGXOB2KPCFfRqN0GHVwyajtpJ21K3ItR+BMikC7VFZRFfIQMnZfuWRd
         uSCc5BT0CY5xI6+PKB7V+kKKCTqOwtUi/3QBspDo+m/w0lLKualKJxmtOFMY7UhG8D8t
         ymbAJjzzI7tcGAoSbLm+koaVFKJTVy4uYcTo7U2t43CWhPPSoYZ9krhBMphpGh30IPbn
         dLUo8N71PVqV2CH+R8dXAk/+vd2ipGGd2+Kk8/vXAzEbrFRDZkxjN4IY+wndoevYLZRS
         83KqqTp8rhTtKeefU+35YefVtpS3qMVo2qc24rf+QEiR5RR9F5jpcjeul3bSO61soDpl
         CFKg==
X-Forwarded-Encrypted: i=1; AJvYcCVPVFOWCP2pivy79vqdzcKhOIvtG3CdFCkJAGegu26s1JNwWefM3BOani6y+k1FBqYPiTuvMDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Xt0nLjdNkGgBkBEOTjP+6yep5j8cBOu249vywvFyoLCgObu/
	1Show3YYi82u9BVE2h/vpMg/0cJu8+5rcD6hMQVY+eh6TMd9hcqG2K7ZPzDj6gIYcGslRBxob32
	SOnGOeeZ+tf7YKGbNpYB1lV2lldkXiQkNWooW8LlE1/v5lUlukSqVBCCk49+G2auJsf0dXkWfe1
	h7kv1VXMidYYGju5B0Ry6jpPaI5FEf
X-Received: by 2002:a05:6512:281c:b0:533:44a3:21b9 with SMTP id 2adb3069b0e04-536acf6abdemr7539253e87.1.1727176902193;
        Tue, 24 Sep 2024 04:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCJLTsjiLCDndre4ai+QsmabLg00scLxW4mqpYCR/Nr6z9gFp7Mfekj01pgzF+20w2ueRN1Yg+hqwbsOwhBrI=
X-Received: by 2002:a05:6512:281c:b0:533:44a3:21b9 with SMTP id
 2adb3069b0e04-536acf6abdemr7539227e87.1.1727176901734; Tue, 24 Sep 2024
 04:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920185918.616302-1-wander@redhat.com> <20240920185918.616302-3-wander@redhat.com>
 <7e2c75bf-3ec5-4202-8b69-04fce763e948@molgen.mpg.de> <02076f9d-1158-4f3e-85cc-83ee4d41091e@intel.com>
 <CAAq0SUkeVkiit383065nhfCibn-CG701uvaM6UHpWu9RaZE83g@mail.gmail.com> <8702d2c1-faf0-44bb-93e9-e905f077b6c0@intel.com>
In-Reply-To: <8702d2c1-faf0-44bb-93e9-e905f077b6c0@intel.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 24 Sep 2024 08:21:29 -0300
Message-ID: <CAAq0SU=n0Qym5EmpimHb=6ayEeURYpHgoYxX8ZxuFbXziKHprw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 2/2] igbvf: remove unused spinlock
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 3:44=E2=80=AFPM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
>
>
> On 9/23/2024 9:46 AM, Wander Lairson Costa wrote:
> > On Mon, Sep 23, 2024 at 6:04=E2=80=AFAM Przemek Kitszel
> > <przemyslaw.kitszel@intel.com> wrote:
> >>
> >> On 9/21/24 14:52, Paul Menzel wrote:
> >>> Dear Wander,
> >>>
> >>>
> >>> Thank you for your patch.
> >>>
> >>> Am 20.09.24 um 20:59 schrieb Wander Lairson Costa:
> >>>> tx_queue_lock and stats_lock are declared and initialized, but never
> >>>> used. Remove them.
> >>>>
> >>>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> >>>
> >>> It=E2=80=99d be great if you added a Fixes: tag.
> >>
> >> Alternatively you could split this series into two, and send this patc=
h
> >> to iwl-next tree, without the fixes tag. For me this patch is just
> >> a cleanup, not a fix.
> >>
> >>>
> >>
> >
> > Should I send a new version of the patches separately?
>
> The patches apply to the respective trees when split out so I can take
> these without a re-send. Patch 1 will need a Fixes: for it though...
>
> I'm seeing it as: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet
> driver")?
>

Can you add the tag when you apply the patch or should I add it?

> Thanks,
> Tony
>
> >> [...]
> >>
> >>>
> >>> With that addressed:
> >>>
> >>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >>>
> >>>
> >>> Kind regards,
> >>>
> >>> Paul
> >>
> >
>


