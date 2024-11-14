Return-Path: <netdev+bounces-144835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FC09C88F7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3486B28F8C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735931F8920;
	Thu, 14 Nov 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WxSZM8rL"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A241F8186
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582004; cv=none; b=k7N3Zvx1HE6ok7LhVwSnsefpZUpG0zLGQzfMGGCOAft5cnnZ5zg9cr2KBeFQWR54GiMU9UmmKOkiABD2kkyrgTm6r74WGTcWtbGzrXhlPEsUQxMogBtz6H+pFOCubRKAsyAoKut1nXurUClqgPu6PSjn+Lv3Z4UP0vOxslijK3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582004; c=relaxed/simple;
	bh=klyHup6LoB2prBz0BA9bP3n/O8dmmwaPO9zs8zcu6qs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spcQSq4eERQKs7yYg/mWxk6aetKpYir47XLyfiywqT4QLh3pBYl/BpVE/ibZEqMY2h4FkGXpWv61mUcXDLQtsStIopMWOo9BPyyJaWfBSi4+aURRs3EXXFKhHTEguHKOmUrRBqmfz5vrg6Y3ZYrlEQmO4IVkV8a8hH9sZ7IA6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WxSZM8rL; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B6253207B2;
	Thu, 14 Nov 2024 11:59:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zXWT9g20GDWH; Thu, 14 Nov 2024 11:59:59 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 36515201A7;
	Thu, 14 Nov 2024 11:59:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 36515201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731581999;
	bh=diSd0AoapfaDM9x7ogakLWTt/W28tCfzyFjJN4s0XB8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WxSZM8rL0swUzElwyzuCiShHw6w2ITUEL+jUALp8WgCMacnn0wtgQPiOptrlgvFnS
	 f+jE+VPlUvAurg8Lh104KTrABbtStmVb/ADbhscxhN4O/4GLbrezdzU+tyX0x5B3YC
	 SWolxaKVZPMq1rmzFW1R2pdIkMubnwpMJRZgM37aL7OxqEx2y6BD23THTZPt4f9V8j
	 pZv7PzCA8d/MEED4RxzLAmCFLnPi7Yf4rxX/h6rieG5iaePp4HqCWLDRqor8s0IfE4
	 pxayi1y0zHRPeBRU1OoHWyC4aSsQWGSrre1+Q64O2hzLf6DqJIuEn0LhxLxPnCZR6e
	 9RtVngBLpe2ag==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 11:59:59 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 11:59:58 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A074B3182B52; Thu, 14 Nov 2024 11:59:58 +0100 (CET)
Date: Thu, 14 Nov 2024 11:59:58 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kees Bakker <kees@ijzerbout.nl>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/4] xfrm: Add support for per cpu xfrm state handling.
Message-ID: <ZzXYLhqapqtJXek0@gauss3.secunet.de>
References: <f9eb1025-9a3d-42b3-a3e4-990a0fadbeaf@ijzerbout.nl>
 <ZzM1/S72Qj0tBCC0@gauss3.secunet.de>
 <d514ef1a-bf56-4949-91f1-c64e3f599922@ijzerbout.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d514ef1a-bf56-4949-91f1-c64e3f599922@ijzerbout.nl>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Nov 12, 2024 at 08:21:07PM +0100, Kees Bakker wrote:
> Op 12-11-2024 om 12:03 schreef Steffen Klassert:
> > On Mon, Nov 11, 2024 at 09:42:02PM +0100, Kees Bakker wrote:
> > > Hi Steffen,
> > > 
> > > Sorry for the direct email. Did you perhaps forgot a "goto out_cancel" here?
> > Yes, looks like that. Do you want to send a patch?
> I prefer that you create the patch.

Someone else sent a patch already. Thanks for the report!

