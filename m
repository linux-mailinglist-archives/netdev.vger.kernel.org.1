Return-Path: <netdev+bounces-190989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42DAB9951
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A5118993A1
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047E722F768;
	Fri, 16 May 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LcXKJZ4t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099E230BC1
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388928; cv=none; b=q3uNwX/MutpNamjeKrjNygTIrvH9H4z/CZZWK4efb2LSKx39X9Tec1b7hNqQbSsYvxG4UQ/YEF5nRkuvkUZAxhU16vKS8HJGgbh2Q47YYc4R3FHwWoh8zPJ//VSVZON2J0jJ0cILK2Gf+imV8rtjfTqBV4jePLBd0V7x3MrhKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388928; c=relaxed/simple;
	bh=Qo977XGgG7v34uoxD9Tovy9QN0HMoF32/dkjeVE6yr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMl1cLbqUgvAWp7NYGz2SugTTd4juf4qpm9Yk8jlNXI7w6YF8hvzXyFpvAkOiN+w/LR/ZvzUiYumXrGV5Z94IrPUGu5cXJfBCX8eiI5el+EPevSlaYsNH0UsubQp0OiYNQhxw5lNyve1T3wA5jA82kYT9uzeIYZf/l6beTS7f9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LcXKJZ4t; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6144B3FC4C
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747388924;
	bh=os73Fv5dyqXqqpAvu7HzafHqtvu6cpi8sd0sMXDbjWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=LcXKJZ4tK5EtOsIi4G8f9oPjGQpE6TUg3sJBWy26F3GqB58w9CiaLxu8cCHed3cbr
	 XENxzbShuFjyjPhynu/Zloqwl9coiWFcs7GQ3MG2jr5ULNOPYQle6mv9of92/Y/Dtt
	 +Lgvx+M6LyPSNCNl/MeAL0CO9gYoVE/sulahoupT5jHKi13AtQows7Pj8gWUvvxDli
	 fn9Aq+m36xENjnQUWQ9sl9OE2RQjtrqOnHAbqSbu8rJ9ZcilndKsMD9n2xzPHNPUYb
	 MBO3+skTSWVGEZPceSGwAUGmAZ7dEC4Fkf4IS2vZzQeO7GoUZcUvVf1BMIas6Uthru
	 VdXLLcVMWj1RQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5fbf91153c5so1981778a12.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747388923; x=1747993723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os73Fv5dyqXqqpAvu7HzafHqtvu6cpi8sd0sMXDbjWY=;
        b=t1lLQT+9TBharF4dFhAQln/RqsHdTRlmsnBdK4CmBkcJpsmfPx+rIWMVTCqCOiznQ6
         2n/XA/7U2bRN6OoyP0jT7GplVipPsyKrHFbwEx2cOMgvwYEZ2NLLhDSHHWkz8T1/3VYZ
         hMzzuoNSD/PDFpQajkNmchelmgsZAwWv//DT3vAPoLat4OUX1JMWOAEGaqNNWtJPB8fd
         P7Zs1o+QF+AtVI6ypJmJ1FNPDH5ovwDAJm5hrFEtehpCJe9S4GffGZCKYpZ5uTLbBDna
         qV6nlKHlg6+aF6Wtpykwoi0Qa6Md6lds66HtMtCQjK1DUvl37ljINboq9lTatguLgm+y
         VbpQ==
X-Gm-Message-State: AOJu0YykhsMLPbdLsaWsq9e38knWkZh7wLcRcl0MDOX/X18YpcWdcFLz
	LcLkO28swGPI288dNLQkHBquBvZ+ZEwmg/YroytuSCZCt09GeIQnBgTHJmxn/ZPOyKBpAQmnfr8
	RNfGtJg5UUMy9aOQxZXKd+kMocJ5aVfvYL7oBcnzV4wVLjC4oNx+PGwPeDBiAbyTcfl7WFbsiot
	ORK7Dk4UKMFDVNt6WNrVhR1Hq/nBadSw29KgNhXiQ3JZJ3qGH9
X-Gm-Gg: ASbGncvnMgWMA014cTCBMyYbqzl0rYXAXH7o64NGR6Qd2Mz/MjUr5Bhw3l/sQ+of/9P
	j97t8FA/zjyect0URJX3PxXp4YGaQe/ykmKIwrpEURoyXc+AxwB68PQT0RNWiWpoE0b4+Wg==
X-Received: by 2002:a17:907:7b97:b0:ad2:39a9:f1b8 with SMTP id a640c23a62f3a-ad536f3867fmr178677966b.57.1747388923360;
        Fri, 16 May 2025 02:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjlz0pShlD+rWAV89gS8KIz+HoZeHIdmI5xKxGlkhwEtwqyull9K9qQ9xnRAnU0PTsJff/CwFG41SXRc4j8Xg=
X-Received: by 2002:a17:907:7b97:b0:ad2:39a9:f1b8 with SMTP id
 a640c23a62f3a-ad536f3867fmr178675466b.57.1747388922975; Fri, 16 May 2025
 02:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514145720.91675-1-robert.malz@canonical.com>
 <20250514145720.91675-3-robert.malz@canonical.com> <fbf72244-873e-44f2-8974-76be6f7118e6@amd.com>
In-Reply-To: <fbf72244-873e-44f2-8974-76be6f7118e6@amd.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Fri, 16 May 2025 11:48:31 +0200
X-Gm-Features: AX0GCFu3yAoLyjsy7f1ZgWGyedybKqFtqEYT2WelD-OPoIkfTxAFdFs8oq-Pi4w
Message-ID: <CADcc-bx=0eAQmndocG4B+PWnzLKOajDT=9E6kM_XLZ4XR1rekg@mail.gmail.com>
Subject: Re: [PATCH 2/2] i40e: retry VFLR handling if there is ongoing VF reset
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, sylwesterx.dziedziuch@intel.com, 
	mateusz.palczewski@intel.com, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 12:40=E2=80=AFAM Nelson, Shannon <shannon.nelson@am=
d.com> wrote:
>
> On 5/14/2025 7:57 AM, Robert Malz wrote:
> >
> > When a VFLR interrupt is received during a VF reset initiated from a
> > different source, the VFLR may be not fully handled. This can
> > leave the VF in an undefined state.
> > To address this, set the I40E_VFLR_EVENT_PENDING bit again during VFLR
> > handling if the reset is not yet complete. This ensures the driver
> > will properly complete the VF reset in such scenarios.
> >
> > Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on anot=
her VF")
> > Signed-off-by: Robert Malz <robert.malz@canonical.com>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drive=
rs/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > index abd72ab36af7..6b13ac85016f 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > @@ -1546,8 +1546,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf =
*vf)
> >    * @vf: pointer to the VF structure
> >    * @flr: VFLR was issued or not
> >    *
> > - * Returns true if resets are disabled or was performed successfully,
> > - * false if reset is already in progress.
> > + * Returns true if reset was performed successfully or if resets are
> > + * disabled. False if reset is already in progress.
>
> You also changed this wording in patch 1/2.  Let's keep the
> i40e_reset_vf() description changes in the other patch where that
> function is changed.
>
> sln

Thanks for pointing this out, fixed in v2

Robert

