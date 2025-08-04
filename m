Return-Path: <netdev+bounces-211539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7380B1A000
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8757179B1F
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1E242D6F;
	Mon,  4 Aug 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuMpNGzA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB320F063;
	Mon,  4 Aug 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304584; cv=none; b=a4Zh7cxrx1i1zTVrwrow1upYPJ0FDBavvoFzgoysoegCMR4H5j9ON8NaqBjLlCaWARkfYcKsiUJ6MXApxr06SuEOAujilScDca+FD6/McAoWrTDAcJz6tfeR3lKq92tHrB1NqFVl8RGfeFx0D+5n0ebuUYDQrCEEyvEeSM9rxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304584; c=relaxed/simple;
	bh=BYwFFiJV4V/E2Ru8AG2PEwqvs2UPmqIVnBQz2HW1sDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM+/PyOvqp4YjMDvt6CZdUfvzsHFuzgDWMNPoDVHwTqZqpWp/Yj25VcWp6DgDmcwIq//K+uyOjxRtCGrRA53pv2lDct8dz9HT65Cc8Bzxi939Zc0ZB4qR5/+gcxB7P2S6D3v6tNQnLz8TPgI+0iAKQhfc7w8H9SzAjpj9cucnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuMpNGzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAE9C4CEE7;
	Mon,  4 Aug 2025 10:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754304582;
	bh=BYwFFiJV4V/E2Ru8AG2PEwqvs2UPmqIVnBQz2HW1sDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SuMpNGzAhAP/Dq5teclu9afjy4IWD6gwByApaDh6NFO2LNV4Nb4Rpg6lLVXpNy162
	 0W71oTL1mw6/SnyxWvejd99xUgsan0liOmUurX19YgMcScK5qW4Fh61+44ggAxzbRF
	 iFrrA4hmCuRhDaFwKlw2+Mf1LE6BJZYljJtDCNqZs1X1WLgSkUpzORaMi8XO2LVVBy
	 A4jLgRYfk+B2m2rt8ZaBlI6egpyRL80PcHYHChWUhK9WN2IJMUyjHPrf98AOcv06EX
	 44bdc9XcdOpOrUTRJD1AU6nIbvzu3iBn6Ma7UVXaFMKBqFIKSjHhdFMStwdzm3oVzC
	 jvPRjTA2f8Erw==
Date: Mon, 4 Aug 2025 11:49:37 +0100
From: Simon Horman <horms@kernel.org>
To: maher azz <maherazz04@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, jiri@resnulli.us,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	pabeni@redhat.com, Ferenc Fejes <fejes@inf.elte.hu>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v2 net] net/sched: mqprio: fix stack out-of-bounds write
 in tc entry parsing
Message-ID: <20250804104937.GR8494@horms.kernel.org>
References: <CAFQ-Uc-5ucm+Dyt2s4vV5AyJKjamF=7E_wCWFROYubR5E1PMUg@mail.gmail.com>
 <20250801150651.54969a4e@kernel.org>
 <CAFQ-Uc-15B7eiE9uFWFzPDhj1sfbuzwmWMEA61UXbumybJ=yzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ-Uc-15B7eiE9uFWFzPDhj1sfbuzwmWMEA61UXbumybJ=yzw@mail.gmail.com>

On Sat, Aug 02, 2025 at 12:25:24AM +0100, maher azz wrote:
> Can someone please do it instead of me just keep me as the reporter please?
> this is too complicated, it gets rejected even if im missing a space or a
> newline
> 
> Thanks for your help and time to review this.

Sure, will do.

