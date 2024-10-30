Return-Path: <netdev+bounces-140254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92D9B5A9E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 05:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7061F24932
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 04:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8F1125DF;
	Wed, 30 Oct 2024 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="NDj2WF3i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590063CB
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261749; cv=none; b=HgSCvPHPuqdtnUnkWv3lI6cPYK51wXefjpY3Q08PQJpRwjONLXrifPhIJx2C4r32ISCLoix29DgGJeAASGtVHq0YtNV3amfTqmc2gg9XcSBLuzPhDZ3HRY1pLdvWcVq1uB9+f0R41kfzkEOBIQ5I5EWWTMZYX4DaYwkTM/cLNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261749; c=relaxed/simple;
	bh=3S4h6lYW/FOoq+w+464gqUty1TGhWFUvW37Z8Cglu+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiQppAFJN1tbRLbQ6r1IT2JAKsdb8yxaJkH3Wt88YDjovbzt43Lsd8n2WaiBOsH3F7LDn/uaCDictdtr3EWOhjgktGZnnCyjqgb/fscABtNBecFQyglgbxknaZP9lbmw/s9tTrt1MhDLb68QBjILwKn/aLBg9BX5XG5v/GPn2pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=NDj2WF3i; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3S4h6lYW/FOoq+w+464gqUty1TGhWFUvW37Z8Cglu+o=; t=1730261747; x=1731125747; 
	b=NDj2WF3iW0RUOiHPg5k6N32jZOLElYl2xpZ9cvZw/Js7lf6DexD5OknR+FcUn8fVoQ32CEyhMvq
	/FlaitVzC6UcdPw5SwtwRFgMUWp6IMUweXfyZuxIiodHpH3/aVS/2JNGJYwzk3NFxvmV9M54QIwDz
	PyEMeW1ELX/BeQt/mLd1+asfETH36J+IKsSmZGBytVsQn0TUUjskB5ybKMGWbI34BRG/6Ls8OeHlU
	iy7UHC9rhIB3x71fEyREExrkL2xRoD17pHtG3sAZLFZd9/HMwb1kkPrx8xtiAXznkXwxp6vBAuoMX
	a50HvXt3Fabp7aYVBIViLyuV6ZYVFIo6MoTg==;
Received: from mail-oi1-f176.google.com ([209.85.167.176]:60621)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t607W-0007ah-6x
	for netdev@vger.kernel.org; Tue, 29 Oct 2024 21:15:46 -0700
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5fcf464ecso4080159b6e.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 21:15:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YyndbEtwmZG3TxO+Aip+V0tRg8FREEAiiMz1Vq9QfaoeZ7N9Z2B
	aP9pd4hBOyCZmX5mVR8TtSyuddV//tnf9lOKjM/wXjhEuk4VUDcIQhoyHXd4VfPpVJAZr5rn5xv
	W/PRAWNkLg8L4Ma14Yxj+uoFi8uk=
X-Google-Smtp-Source: AGHT+IG7eAodidXwQoHoJZT/y+6PyIogdkFzTNAyCp262lt6AFux6nY5AKmBeyEaJ0KJIdmJvQDl1YNjwVkoRwcOY5g=
X-Received: by 2002:a05:6808:2288:b0:3e3:c86e:94fe with SMTP id
 5614622812f47-3e638482adcmr10044892b6e.38.1730261745628; Tue, 29 Oct 2024
 21:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-5-ouster@cs.stanford.edu>
 <dfadfd49-a7ce-4327-94bd-a1a24cbdd5a3@lunn.ch>
In-Reply-To: <dfadfd49-a7ce-4327-94bd-a1a24cbdd5a3@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 29 Oct 2024 21:15:09 -0700
X-Gmail-Original-Message-ID: <CAGXJAmycKLobQxYF6Wm9RLgTFCJkhcW1-4Gzwb1Kzh7RDnt6Zg@mail.gmail.com>
Message-ID: <CAGXJAmycKLobQxYF6Wm9RLgTFCJkhcW1-4Gzwb1Kzh7RDnt6Zg@mail.gmail.com>
Subject: Re: [PATCH net-next 04/12] net: homa: create homa_pool.h and homa_pool.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 126b1dc68df40fcb6eeab1e6794671ae

On Tue, Oct 29, 2024 at 5:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> > +static inline void set_bpages_needed(struct homa_pool *pool)
>
> Generally we say no inline functions in .c files, let the compiler
> decide. If you have some micro benchmark indicating the compiler is
> getting it wrong, we will then consider allowing it.

I didn't realize that the compiler will inline automatically; I will
remove "inline" from all of the .c files.

> It would be good if somebody who knows about the page pool took a look
> at this code. Could the page pool be used as a basis?

I think this is a different problem from what page pools solve. Rather
than the application providing a buffer each time it calls recvmsg, it
provides a large region of memory in its virtual address space in
advance; Homa allocates buffer space from that region so that it can
begin copying data to user space before recvmsg is invoked. More
precisely, Homa doesn't know which message will be returned as the
response to a recvmsg until a message actually completes (the first
one to complete will be returned). Before this mechanism was
implemented, Homa couldn't start copying data to user space until the
last packet of the message had been received, which serialized the
copy with network transmission and reduced throughput dramatically. If
I understand page pools correctly, I don't think they would be
beneficial here.

-John-

