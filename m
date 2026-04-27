Return-Path: <netdev+bounces-281464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNW/F/e572knFQEAu9opvQ
	(envelope-from <netdev+bounces-281464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:33:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AB847952C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36E05302591E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15741C2FB;
	Mon, 27 Apr 2026 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PffKmgOB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o1K5FM2G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFA25B31D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318356; cv=pass; b=nb9KYGaG+3c5nTcdge45gQ28Jk96/pjY7Vrx6H9MBWTY8E7OBpF3kiphwSktEW8dbeEbZxhb8EZGWT5P77zLbEYfzv9H8Qn3z4dRF1/T+MJ29cnN9AdFn8fg+fvaEJWFxWd1s4FX/pUX5GGVZvg7QK25KLavfLh9tAhGFAoBrg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318356; c=relaxed/simple;
	bh=2j59Nrxxp/oec99F4a2ilEs2OT3geSCyIuhjDF9aQkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrpDduXKN9S/TS3PgA7IoCa/U1G5H39s04J59c5NlOBBIzj7FNcuAwZJdE/sSpLH2cHsggB1haO57ppGe/RIBVJOzWK0yE7EIHUL9/EXluvlIgLsaEypE+QZzxEQDI5inePqjOtmE0QwLEOLwiDqLXvUfu/eNcrn+iCWRHPL2Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PffKmgOB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o1K5FM2G; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777318354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50dwTOATE1Na5UCaAF9M0vP1RtBQIq5R5kvcUf3ZMyk=;
	b=PffKmgOB/0PXDnihQwZkCtxLfArQHALIEyfJo2LVCmChMFIuSbszw4XCIGgBz5N53vqU9m
	s4NV42jZfNajJxHsyXymXucJjz3MGjqsDG9lPs4ETe08dSxxGttgNjYB6s9WKnNeBEQHwT
	knQnmY67UrpWf3Wm4HlE3mr73ISzXGo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-LOcPD55TN3eFFos_VROOtQ-1; Mon, 27 Apr 2026 15:32:32 -0400
X-MC-Unique: LOcPD55TN3eFFos_VROOtQ-1
X-Mimecast-MFC-AGG-ID: LOcPD55TN3eFFos_VROOtQ_1777318352
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dbcef2b5b9so2676268a34.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 12:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777318352; cv=none;
        d=google.com; s=arc-20240605;
        b=HYMYvKA1D6vMb7/w0zH8uhjuLxWzOaK2PbH85xQU5KiGqeros9tKzCXE1IX4L/yx+U
         Hpw8oEVXowUXg/cSQ+hPiyCD1FDHIKxJGf1LV099sgb7Ld2DcQ1+eDHPnRX1l9fZNDHj
         rq7D/AdlmgLYrDewWb9duF3VtcgBCiI4M9AB6+TQlrkzilZytFPux4E6e/8mZ6EEYxT3
         1lNjhDPTEcYRtdRHfPUMdPhhcXcFxseRsoSr6ql6EpcCGzfDpRNGbnuc5nwxQmL8JFZu
         hX3QRF6qQipWZtzbTmpjxfK6oIS1KD5gegBri7Hwr957xQLHupz0MNqqoDtWkAwNmGkK
         4Dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=50dwTOATE1Na5UCaAF9M0vP1RtBQIq5R5kvcUf3ZMyk=;
        fh=mdmOoZrG2OMvJ0iH+tZrturB1mDIW/azfKB4Nv0tDio=;
        b=cl/ZkXiD6t3OxvE2eFKP5t69N6qMWDwAGjpy2Y5qQy9QLaZUK2PMvP3GnQW5tL6heW
         XF08JFXwSm1KqxUfb0AbadE2FPx3rKar2mkOhdEdpbXpdazykOq1cvIqi6ODjN2vc/zZ
         YEdVUC0orpp4JpmlhXF+A8LXwPcearQacOmQVW7KF06toPbcqiGXjZcvsbyfe9h0OOP9
         WSO0FAe4E5uNAkB+DtQE+JKa3Bi3umT/q2EQFiCh++iOgtcVKe1u5EIdxx8yGYArTFz2
         0myOaW6pPYd7TXkRNtHOatuhW26Ww8wGlfW4JvpdmJMn0gShRWYwy6mzJckmzk2NqqSD
         0CHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777318352; x=1777923152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50dwTOATE1Na5UCaAF9M0vP1RtBQIq5R5kvcUf3ZMyk=;
        b=o1K5FM2Gdz9//1wSnFh9H3YFsC5qtkotr7eh4BzXsV/m9Bb16i4xbKqzpEzAbtSi7/
         rQ7YajO9rTHtUhLWpDyQgNAqh3XKmZTFy0ZMd+nuLnCKcUQJB7wUc4HTRw0xC3QpMdIL
         Ccg9+CDp/+ii/iU8D02TvpAaQdZIryxtJL2guK5pQZC4wGItaYkBdOACnq/+IlRfnGlR
         yjGRqva8gEQQVhuM2N1QtXPHd7+G2d5pvQMZfHWHkKw/kFIRCXhv1xcpnOeX3kuo2WBF
         mKBgL+kRxfagPhMXowGlJWrvZ9YFs4TOvFGwF5YmjpxFAEw4MPBm79R7A6NPyFdiHnLe
         xXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777318352; x=1777923152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=50dwTOATE1Na5UCaAF9M0vP1RtBQIq5R5kvcUf3ZMyk=;
        b=kVkusiQBFJpvtXwU25kZKMK2MtMBSO5jhsC8tFNUL4hmxWoauobB1nyB5VXAbsVOP/
         dMo7nG0qEucjYOVJ1PUXRapuLZIj9dV31s/Sznwql3yqiqSqS4oS/u4P6/PmCb5lvYK0
         kXmaSN/DbaxMXoLuKikS56i9lcZAcD0mKswqGiPHQAGn8L6Hxq0fCX96wlHlfIcuB7bj
         7J27ScoZjYmnGfXlfHf9p4jcAbCWaU+9AS/bue/AUdkLP5qnMV38joqjQpD2mXDLJBQk
         BiPLjbx9S7LvEievVvV6dqXNsCRdmHdQTeG49jZoxpapoa/rwKpLEXg+AilsoHWszAvM
         T9hw==
X-Forwarded-Encrypted: i=1; AFNElJ+pC/Nl+OrGI+qoBeYATwuTzT/TJNw/0Bn86deToGB2QA5Z95i2A6pw/wEWTPBQDQU85999ke4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjJ8/dL6tvOWZxlZkRyq2NzX1XBbt365W9Skk7XasiIKpr2P3
	kHD9BMMfV0NCjN5ruyQwsj1oGx0C8rBwf59TwBocwAnz56Bll6Q5xFtCMAhminql3pJmf84Ad8H
	avlt4K+saG6OeyL2sLs6S2Qk8gwsHwQZADnZ4Ikvb7rut8Bqhve8RsOaoMxy0PSBGzGcPGdS+wD
	ShW+gOLLDbDYpI/KPuaKRSGMhKIfENX0ui
X-Gm-Gg: AeBDieuzEUTA53GmIMM64CUlcsml+ISUSz/bRNgYSVsVRBI64Whqoo1/9d3Xk7izHgZ
	+deLi6l8dXC+UNh4QPbDSWyznJNFgeAHhxzu+Y2LV1rbzzViVuNsWssoZn/tJZAqBavgLGGWceA
	YhxhAQ30TCcZWMp1OZrLc90/O4ql4lrBn88bXtQJ6edOT2k3a3KCK+TIt5nrtXteM8hgJY5+Jin
	GkIf2h/w/gMamiG
X-Received: by 2002:a05:6830:25c1:b0:7db:c389:6495 with SMTP id 46e09a7af769-7de9869a09bmr178310a34.2.1777318351964;
        Mon, 27 Apr 2026 12:32:31 -0700 (PDT)
X-Received: by 2002:a05:6830:25c1:b0:7db:c389:6495 with SMTP id
 46e09a7af769-7de9869a09bmr178295a34.2.1777318351513; Mon, 27 Apr 2026
 12:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427151827.43342-1-mschmidt@redhat.com> <IA3PR11MB898650A3226F812E881C1630E5362@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898650A3226F812E881C1630E5362@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 27 Apr 2026 21:32:19 +0200
X-Gm-Features: AVHnY4KDkbhBcuI8yDy-sLtNrjJxeDvZsewcQGhCAf5QBE6Z9Z8q8TFZ5-P_4lg
Message-ID: <CADEbmW0m_4p9XZZYWnX8RmYjtj1YtV2FRVygac1QH8iN8+FpGQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix stats array overflow when
 VF requests more queues
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Oros, Petr" <poros@redhat.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 89AB847952C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281464-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschmidt@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,atlassian.net:url,intel.com:email,mail.gmail.com:mid,osuosl.org:email]

On Mon, Apr 27, 2026 at 5:30=E2=80=AFPM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Michal Schmidt
...
> > See the linked RHEL Jira item for a reproducer.
> >
> > Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with
> > ice_vf_reconfig_vsi()")
> > Closes: https://redhat.atlassian.net/browse/RHEL-164321
> Not sure are links to local JIRAs are acceptable in kernel?

The ticket is publicly visible and does not require a login.

> Why no Cc: stable@vger.kernel.org?

Apparently I still have not internalized the removal of the netdev
special stable handling from 5 years ago. Sorry!

Michal

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6 semcode
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c    | 2 +-
> >  drivers/net/ethernet/intel/ice/ice_lib.h    | 1 +
> >  drivers/net/ethernet/intel/ice/ice_vf_lib.c | 7 +++++++
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 837b71b7b2b7..fc78176a2a8d 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -3015,7 +3015,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi
> > *vsi,
> >   * ice_vsi_realloc_stat_arrays - Frees unused stat structures or
> > alloc new ones
> >   * @vsi: VSI pointer
> >   */
> > -static int
> > +int
> >  ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)  {
> >       u16 req_txq =3D vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h
> > b/drivers/net/ethernet/intel/ice/ice_lib.h
> > index 49454d98dcfe..6f7da84384e5 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
> > @@ -66,6 +66,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked);
> > void ice_vsi_decfg(struct ice_vsi *vsi);  void ice_dis_vsi(struct
> > ice_vsi *vsi, bool locked);
> >
> > +int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi);
> >  int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);  int
> > ice_vsi_cfg(struct ice_vsi *vsi);  struct ice_vsi
> > *ice_vsi_alloc(struct ice_pf *pf); diff --git
> > a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > index 772f6b07340d..9edb2c14f553 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > @@ -268,6 +268,13 @@ static int ice_vf_reconfig_vsi(struct ice_vf *vf)
> >
> >       vsi->flags =3D ICE_VSI_FLAG_NO_INIT;
> >
> > +     vsi->req_txq =3D vf->num_req_qs;
> > +     vsi->req_rxq =3D vf->num_req_qs;
> > +
> > +     err =3D ice_vsi_realloc_stat_arrays(vsi);
> > +     if (err)
> > +             return err;
> > +
> >       ice_vsi_decfg(vsi);
> >       ice_fltr_remove_all(vsi);
> >
> > --
> > 2.54.0
>


