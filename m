Return-Path: <netdev+bounces-145908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8BB9D14C6
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9791E1F23446
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C3194A70;
	Mon, 18 Nov 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLzD8jex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A401DFFB
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945210; cv=none; b=Hc1BmN4uGytBxz9TRYzdjeJu+tQlIiIA+9cdFErS3MM1qGuJBidSBa6u9OE/88Rq29fyM6YYFppKYyf7ljR6XENNn1TD4VQO5HwwvQ3SFFcTlOZtGDGJl8F/T9E/nscB0ucMe6U5+2lLI4F7PR1w/Ar6X559legqnsiFQace+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945210; c=relaxed/simple;
	bh=yRqXzEnPwFaa+auWM6yefjwq3R2Ids6AUNnZwvuKrg0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nwB9mNrYVIa3sPR+Mt0lh2w88OBaOcXbTM7lZGN/soNfmcveAeHLCbR5bonVeui67VBt2EOGxGt5HUSa5TpLzZXzbUGrRQHTCeyM6GLpBNr+gYbRjICzeAkrV0kKe7L67uSspBj92j/qQtnI8GwsEPnyr28tzYm/eNt9MLGuJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLzD8jex; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc349204cso818180eaf.3
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731945208; x=1732550008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/HD3lzDxW/S30+fMzUpHxo+jEkPmHoNwk80gvA5gJc=;
        b=dLzD8jexL4Q756d5OscIoUFARhlc4KipqyZxDvEl7XJ5EXBeM8EYeCuN68ky29QIif
         /c+sA6ke2LHXW5jZDl0MzBGoZzokQ2fSbti6h7IHs/KNjzOyc9/9MaJW+V4An+faDkhJ
         iMfpCPDYGu3HskT1cna2gn5HP2iiEmA4frL3YF4lqJF2yhk5YioEXkn/9dhHi01BFTO0
         jhjtmVJvpBhB+wWeISVwKqKAUgwqZprPtTUCs5gCiIKTv6VRi6D6Fwnml1LLQbQ7kZm7
         +VvQifg+kfRbRhRw2eLZK1StnUtnXXtVRnb1ejzY0dk9iK+X7hQ3UYUH6CWHlOxSsxPf
         G4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945208; x=1732550008;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M/HD3lzDxW/S30+fMzUpHxo+jEkPmHoNwk80gvA5gJc=;
        b=warl53Vue0EXR3uPtvZF871UOXoO0gjY9s6iE69Aq118cQd2SmV6KPWMlqeMPgGoBh
         u8BBEdvIJZNkZnOZz3Sp4p3+61CwP3v4AC7/OzZV1fMIHephWoYGeNCLAWIiDaqGdldW
         0E+3P22YyAtD5wIHLGTdkFAoU7IQ7qPMzmFeEtPzWv50mejgvkj3oa99m+YK+VS6vNTG
         u+toxxvbJ6nVt3uDf97eS0mRW47/Mor64LU6q+BxYdDgTABx50KSNxKPlsshdsu6BjoC
         GtMt+5aRjCNykwMRoQfCPt3LcpcEDdQ/zFPbDof8c+CN+OX2kWh1A705e+ltyBnvEu7u
         FIAQ==
X-Gm-Message-State: AOJu0YyPozsOymHvI/2jaWe1qvPDKw9AFIt9UqCfNAs8HOIKK/4Th9b9
	Lcb0rMR2LQlst5iAoEWq9nueP8GUNoBaJf/fNLoeoWDs13paUuqh
X-Google-Smtp-Source: AGHT+IGBblPeWVmYqY0+g3oeZh+7/MykEkGilBfqBjewhDhKjWpH9CS4DcH3IQmBWMMODCnI3pZJkA==
X-Received: by 2002:a05:6359:7602:b0:1c3:73ff:511e with SMTP id e5c5f4694b2df-1c6cd15959dmr461468955d.21.1731945208205;
        Mon, 18 Nov 2024 07:53:28 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dd1fe49sm37443956d6.79.2024.11.18.07.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:53:27 -0800 (PST)
Date: Mon, 18 Nov 2024 10:53:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Olech, Milena" <milena.olech@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
Message-ID: <673b62f785bf3_1d65242948d@willemb.c.googlers.com.notmuch>
In-Reply-To: <PH7PR11MB5885EAC3A3687F97267F072E8E272@PH7PR11MB5885.namprd11.prod.outlook.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-10-milena.olech@intel.com>
 <67366352c2c5b_3379ce29475@willemb.c.googlers.com.notmuch>
 <PH7PR11MB5885EAC3A3687F97267F072E8E272@PH7PR11MB5885.namprd11.prod.outlook.com>
Subject: RE: [PATCH iwl-net 09/10] idpf: add support for Rx timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Olech, Milena wrote:
> On 11/14/2024 9:54 PM, Willem de Bruijn wrote:
> 
> > Milena Olech wrote:
> > > Add Rx timestamp function when the Rx timestamp value is read directly 
> > > from the Rx descriptor. Add supported Rx timestamp modes.
> > > 
> > > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > > Signed-off-by: Milena Olech <milena.olech@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/idpf/idpf_ptp.c  | 74 
> > > ++++++++++++++++++++-  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 
> > > 30 +++++++++  drivers/net/ethernet/intel/idpf/idpf_txrx.h |  7 +-
> > >  3 files changed, 109 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c 
> > > b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> > > index f34642d10768..f9f7613f2a6d 100644
> > > --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> > > +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> > > @@ -317,12 +317,41 @@ static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
> > >  	return 0;
> > >  }
> > >
> > > +/**
> > > + * idpf_ptp_update_phctime_rxq_grp - Update the cached PHC time for a given Rx
> > > + *				     queue group.
> > 
> > Why does each receive group have a separate cached value?
> > They're all caches of the same device clock.
> 
> That's correct - they all caches values of the same PHC, however I would
> like to have an effective method to access this value in hotpath where
> I'm extending the Rx timestamp value to 64 bit.
> 
> For the same reason I cached Tx timestamp caps in
> idpf_vport_init_fast_path_txqs.

Oh to avoid reading a cold cacheline in the hot path. Okay, that makes
sense. Please make a note of this in the commit message.

