Return-Path: <netdev+bounces-275654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJptJSjn02lKnwcAu9opvQ
	(envelope-from <netdev+bounces-275654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:02:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D83A5891
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B487301B70E
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7420338C2C1;
	Mon,  6 Apr 2026 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="rqCEWiOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296933263A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494909; cv=none; b=OdStyZZDG7LtV3lJSZz+XNvyNL5u0eCNZH9gbr+GJ7jTDbikBrxTsU9Fvj0STRTdwY4U0PLqZsNx9HWq8H8gdnG729yCQYKfd4oCgT228bZFnlvcQBlfbxFjnRzWe7P6mzxtw6QeCS9Znq4x+MCvIQJ+zqRKzhnozDfPbBe8iZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494909; c=relaxed/simple;
	bh=G31jsNCNAeiJPwQvK1HAqH3ppSH0aGE0KdNESKrHoMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeHms9lW0HpWTk2sD3VybdI1Dfq9OUs949gRnM5N9u27B3V6RRP9cB3KJ/PJsGQuklyelJzklB8oZkgi7VB9wP36zClQG/VNAllc5dBpqPXEU6yjjEE1b/p6zHX2khupfjTi1XEZeUurVunU8EHhki1bO24zGRGCMI4AHJnERrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=rqCEWiOo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d932cc948so2296032a91.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775494907; x=1776099707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUhQeD6+NwePYBxef6iQ7aiY8XQBRuy8ozLTXfPxIB4=;
        b=rqCEWiOovz4C+DiGzHf4cc3fxgEvTS/5DMoUbFCSautu+9jcBXJHJnz49bVS6uXywB
         7RFDt3n6uVHbTKODkof6Wv9MRwD7/lWzbZ8GY1FhJESsYMojwZMhLde4gCWYByKbim42
         B7sGWSSnarc8fKUiaMMdUqX2vNL7OjW62tasZDGeBsXaVWiqssLKGZ/Xyct+fGjohRu4
         beonmL3T3eHY6mVcW24PcfulFRzJ57vW/Tm6f0LNEporeu7rd4TqH1q8EFqczvFKRXPB
         85XTUunYF48zM6gdcSFApZCydIk58JINbA+Yogc4vAY3CjMnObqBcpBMvSPGZnV+Ic8o
         s8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775494907; x=1776099707;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUhQeD6+NwePYBxef6iQ7aiY8XQBRuy8ozLTXfPxIB4=;
        b=d+7ZkvVVFHhYofj37LmVFq6WqZ98cADpJukTFesfiYZ1JRAIbAChKFnGjYccCvgfV5
         Y9c80M6GHBDsrR1E8uiArrkjtNpDqSd6od42+LJKAFw7eh36TCm7kJ7tjrMaSN/wcRoV
         PkDOTH60tyiT/qCXTi4Dx1CHz9Le/dH6IAXRx10KCgo2qRRagHmLSDP2mrCtTEW4sa0k
         1Yy3sSjzh6gNe0kCCotQ8Q0zmGhjBA3hKo0Q9X/bKtLWXS5B7ypEs90LqRRQ3ue2NCTq
         zvO75CA/TXLK5TY9wrfi0HF82fTG+FLpjYkA1JUBr+JNJzdCokYcU2tWVnPppQOIbBf4
         1DVg==
X-Gm-Message-State: AOJu0YzHzF3CFwd0aRXwVZFYCL0OhJkpiity7VIUeTjm16om7vVqn/Sq
	mim9Nj1qjoMI/ZdPIvdbVnay6x5rkFhgSXs0a6yUpjSRRxDYGxZGuzXD5AKx4UIdr1o=
X-Gm-Gg: AeBDieuZg6J2yHKLt+7cqy/o7AZcC4E4LJCgnl+7IHyet2syc5nxwiQMoLYLgZ4BMZH
	IClxJEMUqKpyoaot6cvPqMTzWjKttiaigMvGw4VEqh815rdPglXlP80dqWDpVaoCxhtcoTqzEqS
	ogNPfR1thO/+vJvXh8yRW6LcYRAF2juSXvJUPriAbcam710j1UIHXhyHodLTYK4gfFEzQ+7PB5q
	6A2W/CXNvxvthIsqFGExWtXPCmWXXWzRT0mKS5zaYGJ7ENnYn0bzVyUX9x4cb3RW/VPM11d7gPb
	4pIbgVmXxYx4xkTqETtMx6aPDTFasXEYdV3DAyBGhay7tuaJA1ZQw/izcz14XnLTnMem8m4zchI
	rZfxqT6Jw3Z0DpOii+CC/zHVVEpC03zON44iae30IYJ67KI42MiV3SaZCK46mj9unmWwhSR6KuF
	YpvrL3
X-Received: by 2002:a17:90a:d2c7:b0:35b:e4d8:bb10 with SMTP id 98e67ed59e1d1-35de6941267mr12737851a91.14.1775494907434;
        Mon, 06 Apr 2026 10:01:47 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe62f5dbsm19677009a91.8.2026.04.06.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:01:46 -0700 (PDT)
Date: Mon, 6 Apr 2026 10:01:46 -0700
From: Joe Damato <joe@dama.to>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	dalias@libc.org, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [net-next v2 3/3] selftests/net: Test PACKET_AUXDATA
Message-ID: <adPm+n8Uw3O2S5bY@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	dalias@libc.org, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, willemb@google.com,
	linux-kselftest@vger.kernel.org
References: <20260403233240.178948-1-joe@dama.to>
 <20260403233240.178948-4-joe@dama.to>
 <willemdebruijn.kernel.400d24decd7d@gmail.com>
 <willemdebruijn.kernel.14a8e29bbdc9a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.14a8e29bbdc9a@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275654-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[dama.to];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 366D83A5891
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 11:30:09PM -0400, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Joe Damato wrote:

[...]

> > > -static void do_rx(int fd, int expected_len, char *expected)
> > > +static void check_aux_data(struct cmsghdr *cmsg, int expected_len)
> > >  {
> > > +	struct tpacket_auxdata *adata;
> > > +
> > > +	if (!cmsg)
> > > +		error(1, 0, "auxdata null");
> > > +
> > > +	if (cmsg->cmsg_level != SOL_PACKET)
> > > +		error(1, 0, "cmsg_level != SOL_PACKET");
> > > +
> > > +	if (cmsg->cmsg_type != PACKET_AUXDATA)
> > > +		error(1, 0, "cmsg_type != PACKET_AUXDATA");
> > > +
> > > +	adata = (struct tpacket_auxdata *)CMSG_DATA(cmsg);
> > 
> > Sashiko had another interesting observation that this access may be
> > unaligned, as cmsg_buf[1024] has 1-byte alignment.
> > 
> > That is not new in this patch. Indeed most tests in this dir just
> > deference msg_control as struct cmsghdr * and CMSG_DATA as whatever
> > domain specific type.
> > 
> > The man page also warns about this and suggests using memcpy to
> > access CMSG_DATA. Not sure why it does not warn about the other
> > cmsg_.. fields.
> 
> The commit that introduced that has more context
> 
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/man/man3/cmsg.3?id=36d25246b4333513fefdbec7f78f29d193cf5d9a
> 
> It points out 32-bit platforms where cmsghdr is 12 bytes.
> 
> At least one example given, ptpd, uses a union to ensure alignment
> 
> 	union {
> 		struct cmsghdr cm;
> 		char	control[256];
> 	}     cmsg_un;
> 
> But at least one other example, ssmping, does not. So I think not even
> the 4B (on 32-bit archs) of cmsghdr fields can be depended on.

I'm fine with adding an "__attribute__((aligned(8)))" to be safe, but FWIW, I
think the key point from the commit message linked above is:
 
  shows access to int payload via *(int *)CMSG_DATA(cmsg) (of course
  int is safe because its alignment is <= header alignment, but this
  is not mentioned).

struct tpacket_auxdata only has u32 and u16, so 4 byte alignment seems fine
and I don't think the issue applies in this particular case. But, as I said
above, I am fine with adding the attribute to be defensive.

