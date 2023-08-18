Return-Path: <netdev+bounces-28667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F31780369
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C281C2156F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0D647;
	Fri, 18 Aug 2023 01:37:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444A39A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7F1C433C8;
	Fri, 18 Aug 2023 01:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692322672;
	bh=Bh5spccamtzHLoUmXeOIpW1XMXkFhUqPZ0TzEoOACAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sXkJEXzZ4PI/kujyzPDj/r7yD8X7AYZKGex8C27tRd84jvnY4/Ks3ufKXX9OMfI1j
	 uXs2rjTVPrry6vi6qnnvnfqJ8t+GCVcjJlLY6CKE0xIu17F9dyVzwgcHWP/v0mgQvU
	 H8R1JJWidKgwfaYVjey2h0A2IAie9aOlfyGhpLRnTTmgyAbgSsU7o30rdMQllbWEvP
	 JHPt991IUBtPGMyu4t9xnkqSTykHOA+nX8JaFg3j8nJUnMHGeIAA3SUgq3wMHtJhuZ
	 uHlkikncBbQdD8hkOqgsjJRESEz2NeSUYKQaI2nyTEsoGbbKqdjnUnduA5dLAMPy+w
	 d3ap4a4EtQWLg==
Date: Thu, 17 Aug 2023 18:37:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Stanislav Fomichev <sdf@google.com>, Arkadiusz
 Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH net-next v2 05/10] tools/net/ynl: Refactor
 decode_fixed_header into NlMsg
Message-ID: <20230817183751.194d547a@kernel.org>
In-Reply-To: <CAAf2yc=C4N=QT6hpxmLi-uywc+MhuLdAsbfPRORv5ms9k1JAfQ@mail.gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-6-donald.hunter@gmail.com>
	<20230816082030.5c716f37@kernel.org>
	<CAAf2yc=C4N=QT6hpxmLi-uywc+MhuLdAsbfPRORv5ms9k1JAfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 16:14:35 +0100 Donald Hunter wrote:
> > It's a bit of a layering violation that we are futzing with the raw
> > member of NlMsg inside GenlMsg, no?
> >
> > Should we add "fixed hdrs len" argument to NlMsg? Either directly or
> > pass ynl and let get the expected len from ynl? That way NlMsg can
> > split itself into hdr, userhdrs and attrs without GenlMsg "fixing it
> > up"?  
> 
> I agree, it breaks the layering. The issue is that GenlMsg gets created at
> some point after NlMsg, only when we know the nl_msg is suitable for
> decoding. The fixed header bit is quite well encapsulated in NlMsg,
> it's the genl header that needs pulled out and NlMsg shouldn't know
> anything about it. How about I add a take_bytes(length) method or a
> generic decode_subheader(format, length) method to NlMsg?

Why do we need to fix up the .raw of NlMsg underlying the GenlMsg
in the first place? GenlMsg by itself didn't need to do that until now.

Another option to consider which would make things more symmetric
between raw and genetlink would be to add a wrapper class for old
families, too. ClassicMsg? CnlMsg? That way we could retain the
separation of NlMsg is just a raw message which could be a NLM_DONE or
some other control thing, and higher level class being used to pull
fixed headers and separate out attrs. Just a thought, not sure it helps.

