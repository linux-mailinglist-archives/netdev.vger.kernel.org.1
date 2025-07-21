Return-Path: <netdev+bounces-208572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC640B0C31D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98B7188AA89
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F2E2BEC50;
	Mon, 21 Jul 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5XN1cyQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE452BEC24
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097657; cv=none; b=apelTwaRBhznCKVkzRxyPxdsN96DvPPTCJAnwrXNwwSASezGj/lGT7SwpZlmDUyyHAdXqrZ5d9q63pxXR6VSiyJXV0+kcnwVkcmU/lXgn+l7wulk9NEppV0FGqqTQo8T4J6HrOfb6LATI7JFjSSN/asY/riG91QOdkpQ/GYHnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097657; c=relaxed/simple;
	bh=D/3TRU93QDlnGqM8rs8fsEt1nNdoNWfnlTe/xWO88dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvDwGNu9S+5BotUXs1uvDSxmHaNkYjUrkWtkbE1RAWyH/WivVP90+AgVqG0D4VCb0QcuBoFMkm9hZfvbffu/0tBUvwFEh7UDEbYdMJrcqpNgP7xw1Q8L3Q3Tau8XvGRt7IOROzvxEB8v+2aJKitRoo1H6pVeC2cnWiCHG6sycWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5XN1cyQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31329098ae8so3553713a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753097655; x=1753702455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7NvsUpRwHEpiLn/u1yLLyuPoU1r/z6Q2UVm6GiDEfE=;
        b=h5XN1cyQ6RqfOoOLqyg5WmqK2DF4KkjdHSOJVV0DzfjdCwBFr+IiXsFlFqLO8DGg5S
         2e1jJBKFpDYMCJc0wjyfov0LS1Desa7tRfbMU+gJFH2pWz3zvrMZmzKQMSldg/i70OVx
         HsQuhzycQqUzGOgx7ag6VcLvbrJ8H6WNfoStSatks97ofI0E+RZJyi/pa9M4PpOL5dOk
         UDwtDtaoL/wLOvelc4n6VhlWraKvIZOuVwDyf1jXCBWpd6d1WD2TgHxK1QT+BMtzlG1b
         HA6JhvjMuja07q8fOQqn+1TbB34MhT6W4PEruhyd3vjr3y6EfeqmVTMc4t6IgmryEZCD
         LDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753097655; x=1753702455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7NvsUpRwHEpiLn/u1yLLyuPoU1r/z6Q2UVm6GiDEfE=;
        b=Vp99foSPWQkjmVwBMZbv1Gs9+Nifm9HrC0Qaws546ybBZPJI/8+dKDtVCNDBcP98UV
         MVnk1SgK9oAd9HcWuInfS3mjeJjX1a4yde57lg4EdH3o7J4Z+O9BVqfHjsF1tTpvi5sR
         kQMV4aeBHPjHFqwTNcZFfHx7Eu5gw5d4CS738wJRjWKJWFvYivar3k35NCTn2BZrKTYV
         9a21d2aSE9+kBo7UkocY+mRoHAA/zbMun1Kut+IHmnKW/htgvh5Ib7ECGKnqYM3X7P8t
         4iSB0PVKf62z788aJ69+brCHJQNGUmV22ojfHwmw7OWJwrLnxRq3NUBXcFbU6K8hli1W
         LLxQ==
X-Gm-Message-State: AOJu0YzIUEXmX+lp627+iMaC5HZIbaLryc8XChbQmkIsbr2fRFutQHnP
	+UprrdkDfX4X87cqvGEdrkltUybAERRyii84FJ5TTQVmNHSSnoCdfDb2QcyxmlXHkVE68kb3aHQ
	gTZ7vQB6sPkgWRyJVKqswwBG/yAIuI7g=
X-Gm-Gg: ASbGncshx/ufTnCeXKFzkye7zaFAso+YSGBqiOXubWRA5W0ELnjgUsD0khV0dQYFjzm
	jhfxKduYSQTIKk0p98Gr57RvtwlnLScvK+EhSaZWORRTjqq2vOJ7SipdGSG5nPSgen6K4KGfqZC
	1uE0nvvWt1SLpLBflWQy5OJue51kQpQUuXUWLfdzHogRiiHSrPL87dzE5EH/ygGszdKAGAZ1zsZ
	Aw60fk=
X-Google-Smtp-Source: AGHT+IFUPQtFegKyekMt55UmhbndBliKZCkdQ2lEkY+tKDYKl0OLdQUYg4czXBRWKB6RbEPlCsK2/fMMi8++32wKqFw=
X-Received: by 2002:a17:90b:57ec:b0:31c:39c2:b027 with SMTP id
 98e67ed59e1d1-31caeb7769emr25497514a91.7.1753097655198; Mon, 21 Jul 2025
 04:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721031609.132217-1-krikku@gmail.com> <20250721031609.132217-2-krikku@gmail.com>
 <CANn89iLXMK0edE0xdZgD9aqLkGr32tOjOyyHKAnBbgCYhZt+jw@mail.gmail.com>
In-Reply-To: <CANn89iLXMK0edE0xdZgD9aqLkGr32tOjOyyHKAnBbgCYhZt+jw@mail.gmail.com>
From: Krishna Kumar <krikku@gmail.com>
Date: Mon, 21 Jul 2025 17:03:38 +0530
X-Gm-Features: Ac12FXycnAeoAkB3LuXJeIMXc6tO4PgAsAsLGuYmOdJVpO09EkYiNHTlhi4xRUU
Message-ID: <CACLgkEbBFCoUBMu5x3Gezx8nihSnn3BB9cH51T3LahVii1FspQ@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, tom@herbertland.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com, 
	atenart@kernel.org, jdamato@fastly.com, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> > +static bool rps_flow_is_active(struct rps_dev_flow *rflow,
> > +                              struct rps_dev_flow_table *flow_table,
> > +                              unsigned int cpu)
> > +{
> > +       return cpu < nr_cpu_ids &&
> > +              ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_=
head) -
> > +               READ_ONCE(rflow->last_qtail)) < (int)(10 << flow_table-=
>log));
> > +}
> > +#endif
>
> This notion of active flow is kind of weird.
> It might be time to make it less obscure, less expensive and time
> (jiffies ?) deterministic.

My first internal attempt had this approach (not submitted as I felt
it was doing two
things in the same patch - fixing an issue we are seeing in Flipkart
production servers
vs improving an existing function):

struct rps_dev_flow {
        u16 cpu;
        u16 filter;
        unsigned int last_qtail;
        unsigned long last_active; /* Last activity timestamp (jiffies) */
        u32 hash;
};

I had not considered removing last_qtail or its implication of packet
reordering at
this time, so I had both last_qtail and last_active in the structure
(have to understand
this better).

and:
#define RFS_ACCEL_FLOW_TIMEOUT (HZ / 4)
static bool rps_flow_is_active(struct rps_dev_flow *rflow, unsigned int cpu=
)
{
    /*
     * Check if the flow is for a valid, online CPU and if the current
time is before
       the flow's expiration time.
     */
    return cpu < nr_cpu_ids &&
              time_before(jiffies, rflow->last_use + RFS_ACCEL_FLOW_TIMEOUT=
);
}

Please let me know if this approach is correct, and whether it should
be a separate patch.

Thanks,
- Krishna

