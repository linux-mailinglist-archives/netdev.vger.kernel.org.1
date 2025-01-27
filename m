Return-Path: <netdev+bounces-161157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0BEA1DAFD
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A127A1918
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369DA17C224;
	Mon, 27 Jan 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="mSv76u8O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047217C7CB
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997518; cv=none; b=SHy5XFdE33qt4miRApU67e+lcfh3yOuLUomzCJ+yr8rv9Nyq76mx1Lv9kDH/9bQ7munXEUIdSdzzdteve6MRZ3QUDmdVhnG252sIc1lEuLepYrCB2SXKbYtVZvtqqtDzcSAI7OA/WlF0jy6k9NcfTPy+ADR50N6PTnCeCe3XJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997518; c=relaxed/simple;
	bh=JoF08KpodVUvGI5SfauisYIFbcxjaTVxFY5tPF9zJXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ns5V3RorLwA5mzylSc3psJ+ZeY67qhf1zbq6bcXe2ue2nBrGrvy+LNWPFQoT50SDdavntl19AfbU25ctoaPJVh3VQIWnvzZeoC6gCbFV3e8QSoQ4j+JJ1+bLvPEqSFoLScQSBkMPiauCB7ixTj3/4Poahe7KmIi8SHbmhAgQus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=mSv76u8O; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C+HMyQ2n28Q7kiTYMy2f7+MO19MzQ67qCMQL1vog7BE=; t=1737997516; x=1738861516; 
	b=mSv76u8O88WWXoVIqb1IXWwX93c+sOyKQRSdcPKpjdPLIW5O1iYQuigvCggGEKl2AnVxi/TtoFG
	FmUosd+g1W6BE+R8w3vSHG0gNa69JYJJrrDB6gXQNE3SIpn7apnAqytttwfXHUcJUS/bBXxX3/5Ok
	VtKm9iyl15QZMuZQlWqy9CFGE2fU41SukgjqNtGLyQr9HMDcDeR83jp2uvaF/dG889+futSp5ASGP
	KlX4+Q/9QyrkVLlpOzIKjJCGbzct2MgR6pDAskNuYJe9Uj4WGRQW2C37m4hDe0Jitp78s97AecI1w
	AdgOFS0PT9Ws10ivPLfwJMXlmIP1TynItZzA==;
Received: from mail-oa1-f54.google.com ([209.85.160.54]:55695)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcSXt-0004Yk-Os
	for netdev@vger.kernel.org; Mon, 27 Jan 2025 09:05:10 -0800
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2a8690dcb35so1513838fac.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 09:05:09 -0800 (PST)
X-Gm-Message-State: AOJu0YxGg+r17qDxV12Q/Ns9IblAlfrzD7jyXmjFVgbArcF7dR0yY2x7
	6TEzLUAT2MgWsUVfj9Ms2ObmYjtn6Dlpvb+mL7QSwEOFEIqVpCI0jRkBWBwHcJVJeKKwoxVIqXh
	y8DbHjy6Kqn2SKNAYMhgR1V4RCYg=
X-Google-Smtp-Source: AGHT+IHsB1BPZc2o3q2O1ZcoYSM16p87qxG7SuN0+BLdRg5z1ZPqje25Wqn+F/ZC4Pcm6YQCprT+eWwCcPp/uB25rZw=
X-Received: by 2002:a05:6871:aa09:b0:29e:4a6c:4010 with SMTP id
 586e51a60fabf-2b1c0917445mr24928092fac.6.1737997509115; Mon, 27 Jan 2025
 09:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-4-ouster@cs.stanford.edu>
 <08c42b4a-6eed-4814-8bf8-fad40de6f2ed@redhat.com> <CAGXJAmzcifEeNthmE2J0epFYUhJYH=XxoJUSxQEqPCjkbhHdBw@mail.gmail.com>
 <a08e9235-7452-417c-a308-b062c4ce510d@redhat.com>
In-Reply-To: <a08e9235-7452-417c-a308-b062c4ce510d@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 27 Jan 2025 09:04:33 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzfzdGijC4wxhC7FMeuXR-d-DVSOAxTyJVPPBVd8YeqUQ@mail.gmail.com>
X-Gm-Features: AWEUYZkOVnMtVjqIekWI9Rjdzl4iexRzXWneTY29Q5G3NnVad0i3AXhvj4o5OcA
Message-ID: <CAGXJAmzfzdGijC4wxhC7FMeuXR-d-DVSOAxTyJVPPBVd8YeqUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 03/12] net: homa: create shared Homa header files
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: dcedbbeaec314583a5a6d4e37e27e533

On Mon, Jan 27, 2025 at 1:06=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/24/25 10:21 PM, John Ousterhout wrote:
> > On Thu, Jan 23, 2025 at 3:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> On 1/15/25 7:59 PM, John Ousterhout wrote:
> >> [...]
> >>> +/**
> >>> + * union sockaddr_in_union - Holds either an IPv4 or IPv6 address (s=
maller
> >>> + * and easier to use than sockaddr_storage).
> >>> + */
> >>> +union sockaddr_in_union {
> >>> +     /** @sa: Used to access as a generic sockaddr. */
> >>> +     struct sockaddr sa;
> >>> +
> >>> +     /** @in4: Used to access as IPv4 socket. */
> >>> +     struct sockaddr_in in4;
> >>> +
> >>> +     /** @in6: Used to access as IPv6 socket.  */
> >>> +     struct sockaddr_in6 in6;
> >>> +};
> >>
> >> There are other protocol using the same struct with a different name
> >> (sctp) or  a very similar struct (mptcp). It would be nice to move thi=
s
> >> in a shared header and allow re-use.
> >
> > I would be happy to do this, but I suspect it should be done
> > separately from this patch series. It's not obvious to me where such a
> > definition should go; can you suggest an appropriate place for it?
>
> Probably a new header file under include/net/. My choice for files name
> are usually not quite good, but I would go for 'sockaddr_generic.h' or
> 'sockaddr_common.h'

It's OK to have a new header file with a single ~10-line definition in it?

-John-

