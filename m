Return-Path: <netdev+bounces-141586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6289BB964
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7971C20973
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4F11B6D14;
	Mon,  4 Nov 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ4EQGdQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7770816
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735475; cv=none; b=YVRsGmIoDtb2/VnAW93ccxEJWxdkIk7dgEpaa8vJ7/4q+yc4b7VcP4/vihVZGCDGn22pYtzCJ4TVdTiWGXqpOe1K0FcvMq6p0z8Qzd/nXxhAekmnAWGmBS9ChMyf/h+Jd1i1S5PqAQ4Jq07EO/KE3w7NAk34icGRJhxCxg7Jwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735475; c=relaxed/simple;
	bh=t8dak0VK6rK4EY2nAcpBuTfFm+KGbqhaFYNHPFex83w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5V5D0DXsx/oXy6uUvioFbSJJ1tCpu3w/b1mjq21ktB8AxTTN/gQQoAsCo9V1Vn7pU3F2nR9qZGPgThzE4/mxuB1aWxrOhDzweK5/isEi19bZz9bZjTRkQZGViWAZgvzoYVWJ5csTWqy+tj+i/Lqms/mbNTy1y7UpACXZ4Vn7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJ4EQGdQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730735472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f573NGxGwwEcpEI02aRs9Mv6MPzHTm8n3DIYo90WOAg=;
	b=fJ4EQGdQXr5vGVKGr4yZxrsIEfkbrT0mJQ3JEn3X2voiU2SYPCmUXGO0jA5L1Wm1BnaSPP
	HijbCm+dFR+aaHAhvNk+kfpfAsT5qSQRKmEOiFUudFPO+Akl/dt8Zhb/Malx7FOWpzBDe/
	w64wQSGC/LWRuiIyK9xqppSrLU/cU/k=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-I6yhx7WMMxWmnOgN8hXRnA-1; Mon, 04 Nov 2024 10:51:11 -0500
X-MC-Unique: I6yhx7WMMxWmnOgN8hXRnA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5eb87df274dso369017eaf.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 07:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735470; x=1731340270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f573NGxGwwEcpEI02aRs9Mv6MPzHTm8n3DIYo90WOAg=;
        b=fZvKI7qfjVNFiOfyxLQyMKZpuWqdAOo5oeobDyX3EFo3qvBgrjM5UFs7mnsrxS8gix
         5Uz7lIQTDeMBxFnvNGrVtTBZrNx5HXc6W+7h/Hpmfhrxw2qOm7+KgiiZgmanN3GIeBNW
         fd0xb6gW+xUwMdDn6wzalqiVhGq4SOSa+wsgQbYRIMT+As7pXRqr1E+cvRcYJd6EqB8m
         oc9JfuA9on6qSBwMwPose8WDqd561yWdMiTvNimmj9YZTFMDz6rQdUGA8gLNbDfDdwXG
         vg26GzmPkxuGbXXYgJG0KMrBh2FnM7acv1MM2LLoGXCBKKO1+eiUncgmvbrjRXFQv/jm
         ZtPw==
X-Forwarded-Encrypted: i=1; AJvYcCXTKahwVRAv7zsAa4RBQW43fHPHxlJ4LRXuig8XZluc4i+UVN7oRpbeBExmRVBtxWHj+SPz2GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NctRTpmZ2bqpPQonYINwTOngHmrQr9IOAbRnZpZaK+3SYaw2
	2hBtkM/6nuNS4wQJ7XKWTbBi19G+6uVx4lo4QihsZonhZGvqg6+6BsXvLR/KTpJ6NbYomthy0xo
	WMtft6fZJmtctvz5Y5kTnUfypcoX3b6iSzwcFMKUc+2wfPL9qO8ftkFd/mhDF+jnMd8jtVfteP5
	aiGsQb85UTju+0eEawZmpqOfCUipB4
X-Received: by 2002:a05:6871:3a28:b0:27b:9f8b:7e49 with SMTP id 586e51a60fabf-29051ed2e07mr8128950fac.11.1730735470677;
        Mon, 04 Nov 2024 07:51:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPHhMtv9li+aLKBXugLstxd80vMrdlAgTUr2ut5C9X79h0VKy4FqWxhiv+7Ma6OH4h81v54eHfUtX8m+iMlO4=
X-Received: by 2002:a05:6871:3a28:b0:27b:9f8b:7e49 with SMTP id
 586e51a60fabf-29051ed2e07mr8128940fac.11.1730735470357; Mon, 04 Nov 2024
 07:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029123637.1974604-1-aleksandr.loktionov@intel.com> <CADEbmW1rJdFZ0ccpo-YLv0W8zQsr9-2eMnncDgR-tE+On0TX5g@mail.gmail.com>
In-Reply-To: <CADEbmW1rJdFZ0ccpo-YLv0W8zQsr9-2eMnncDgR-tE+On0TX5g@mail.gmail.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 4 Nov 2024 16:50:59 +0100
Message-ID: <CADEbmW0r4BCU_qWHRrvAPQ-kwA-xMDj2YD_OdiGotRnfEMtpoQ@mail.gmail.com>
Subject: Re: [PATCH iwl-next v4444] i40e: add ability to reset VF for Tx and
 Rx MDD events
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, Jan Sokolowski <jan.sokolowski@intel.com>, 
	Padraig J Connolly <padraig.j.connolly@intel.com>, maciej.fijalkowski@intel.com, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 4:40=E2=80=AFPM Michal Schmidt <mschmidt@redhat.com>=
 wrote:
>
> On Tue, Oct 29, 2024 at 1:36=E2=80=AFPM Aleksandr Loktionov
> <aleksandr.loktionov@intel.com> wrote:
[...]
> > +
> > +                       i40e_vc_reset_vf(vf, true);
> >                 }
> >         }
> >
> >         /* re-enable mdd interrupt cause */
> >         clear_bit(__I40E_MDD_EVENT_PENDING, pf->state);
>
> Can you remove this 2nd clearing of the __I40E_MDD_EVENT_PENDING bit?
> If the interrupt handler detects a MDD event while we're still
> printing the message about the previous one, we don't want to forget
> it by clearing it here.
>
> Michal

Well, I suppose the race I described cannot happen because the
unmasking of ..._MAL_DETECT_MASK happens after this.
But it's still redundant to clear the bit twice.

Michal

> >         reg =3D rd32(hw, I40E_PFINT_ICR0_ENA);
> >         reg |=3D  I40E_PFINT_ICR0_ENA_MAL_DETECT_MASK;
> >         wr32(hw, I40E_PFINT_ICR0_ENA, reg);
> >         i40e_flush(hw);
> > +
> > +       i40e_print_vfs_mdd_events(pf);
> >  }
> >
> >  /**


