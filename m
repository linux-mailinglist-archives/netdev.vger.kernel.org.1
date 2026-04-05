Return-Path: <netdev+bounces-275427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J5AM0nX0WmhOwcAu9opvQ
	(envelope-from <netdev+bounces-275427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 05:30:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C233739D3A4
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 05:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A657330034BF
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3812F5498;
	Sun,  5 Apr 2026 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqCn98GQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F41FC0EA
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775359812; cv=none; b=BpgNlP9wyv9jhhLMFIbzejhBbjD565wF7aPJJdmRZUa7M4Uq5nS2iXQEeHZRR4/YnPGkTKz7/QEOOefoOo3vQGQ1RjzU5bKgz5TFll+gR7bk1gSMXXIOo3SefmoZH0t06TzV7/Dh7wcuhtKooynBkJenYbOI0HKfEjsH2dRuFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775359812; c=relaxed/simple;
	bh=6VgXMf1dbZIEFJ+BoZ7O6EwYBpyyfjLk5p6wRIkkWvU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hAyJBVHrPcGB593BrKmGGDhCZQnP/9bvoPso9iozf3Fb5JqD+L7XB8VmHJdt7Rt583DpuG3JrNs8Br1XJW82Z5n6GSyTNdi8giCf+BLrmrqhqNFq1+HJvYXESl3TxviuxjZHFgauKahhj4Ys1vAIZ3V+bXM9B4vIR0rElG/V318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqCn98GQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78fc4425b6bso27495857b3.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 20:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775359810; x=1775964610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIhyqVeQcmo1jb/qAoAPSAYd8D2Hnw0/pgPPvAap7Ok=;
        b=OqCn98GQWDz9jI20hI4x9a44Il9r2ZNPJKo0lCvR+piaBWaH1uxYHEu53ikpOMNBxl
         VJGcbOKCGB8gQkzqRzK5PBi2g5FkkE4fjDWBQayLLMt5DmXr8CwUV7u4TapgSBl9wvQJ
         AE/1ROUDrWuSs/R++4EN4BjAsNu6G+7SKM8XCDSctAqLGfl51PsCp7sQqwBLvm6gAHfH
         /CRlRThl58sA7kH9NZIYYuM/uStCQTSnHa5rez+1QIFULRNb2vwD52X2+GLN+U4w7Ojd
         ryMnrkP9Nyoaoat8hg+3AJLMGYXPOroo0Mtz+7yiqXdVFSHVhnsKdEz4NB66i9aFgGpo
         zC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775359810; x=1775964610;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIhyqVeQcmo1jb/qAoAPSAYd8D2Hnw0/pgPPvAap7Ok=;
        b=sPO33zbIWAjLMzL1aywHWcF9F4lr84YtfZQ1VeY83Y8kCfkx8819hMaTbo8QEI8w+H
         C32Ln2IDHOLh0K+mJliNGNT/TllTeBnVwWG23R6nYGU/Y0St1SiccrbkOCVZZjNjPehd
         QErWNxlopsDmIDmEdPHqLTfvTokOP1MW+y3LHq3YPQaPIG/UtySNf6KA+peP927vK1s0
         9rWEmdPcg+Bxg1CcEq8Gv8tc4BgHDauC8xHuP3avTQicDBl6LCY1d8DXK0wieqLfOEAt
         bBuYvHt6ysDX40MUvm9tKqkakoUBKosLbUB9KmSZ/Rh9RfbJmQQ7OP9Dw8LVEMI6tjaX
         ZB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmR3I5z8mlv+217+4j+slfP3VX448/oRmE8Nv7OpF4zkhUIZlDde/dPYL/vKsQrDLKwe5isRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfWuSPTFOabjIs5eb2U0AvsHDvsQo6lh78MHMWCByPG4tV/QF
	V0wEpttNgCBdnXfecP2mArOHVGJUoatJ1U/dK9ecG/3tuk4aIcfaL/Hf
X-Gm-Gg: AeBDieu50FXYcMjxePeJ7jhoc0nd5cpbYFqz8mtLisJ9tPgpHA7IqsgfnGTtPmWUZhq
	h9tC2HHngl2HrUl1Y+WklyDVE6wJsscLAgTljPqXkpNiTmgRy7WQ81bq0VNUJz4x6giyNOv5Pyj
	BLtk8MPtU5n+RcVjKGFzsPtKQ32ru/IEGi0ywdwCPY7oZQhFTRSg97a6UBslO/Jwt/EguGJ5erV
	aVqgke8X/s16zn5nDmoIhcEhnq4h56yQMCO7AFWBJoMRfNsEMGeTUe1dDjnu2vvJ35jujo1zPKF
	4EgyeUS0bLvIvIj46MZ4WCzwmsNWD7OMNPZY37uBZJIM79rD7ly3w5B3gWg7aFL+NpZOD+8xgvB
	Z2PZCwXBMzDnfZ8Ql3o7538pJjMr18ONlgLc9C8X0JlqQn5AO8dgi+ywfziTnTnAAPeji63XxMx
	rGJiOVvSPSTpS92r1shzmeU8/WStxdAt7xnJMgH7oIgWPP8Yk1eKsypeCaSeYdqmzrlvLi4gLjv
	YPI
X-Received: by 2002:a05:690c:660a:b0:79a:5ad7:b9ae with SMTP id 00721157ae682-7a4d61558demr90426747b3.42.1775359810385;
        Sat, 04 Apr 2026 20:30:10 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36ea2872esm38036227b3.19.2026.04.04.20.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 20:30:09 -0700 (PDT)
Date: Sat, 04 Apr 2026 23:30:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 dalias@libc.org
Cc: andrew+netdev@lunn.ch, 
 linux-kernel@vger.kernel.org, 
 willemb@google.com, 
 Joe Damato <joe@dama.to>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.14a8e29bbdc9a@gmail.com>
In-Reply-To: <willemdebruijn.kernel.400d24decd7d@gmail.com>
References: <20260403233240.178948-1-joe@dama.to>
 <20260403233240.178948-4-joe@dama.to>
 <willemdebruijn.kernel.400d24decd7d@gmail.com>
Subject: Re: [net-next v2 3/3] selftests/net: Test PACKET_AUXDATA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275427-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,dama.to,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,libc.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C233739D3A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Joe Damato wrote:
> > Extend the packet socket selftest, adding a recvmsg path, to test
> > PACKET_AUXDATA. Check basic attributes of tpacket_auxdata.
> > 
> > Signed-off-by: Joe Damato <joe@dama.to>
> > ---
> >  tools/testing/selftests/net/psock_snd.c  | 67 ++++++++++++++++++++++--
> >  tools/testing/selftests/net/psock_snd.sh |  5 ++
> >  2 files changed, 67 insertions(+), 5 deletions(-)
> > 
> > v2:
> >   - Add is_psock bool argument to do_rx.
> >   - Factor out aux data check into its own function for readability.
> > 
> > diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
> > index 81096df5cffc..5464317c1764 100644
> > --- a/tools/testing/selftests/net/psock_snd.c
> > +++ b/tools/testing/selftests/net/psock_snd.c
> > @@ -40,6 +40,7 @@ static bool	cfg_use_qdisc_bypass;
> >  static bool	cfg_use_vlan;
> >  static bool	cfg_use_vnet;
> >  static bool	cfg_drop;
> > +static bool	cfg_aux_data;
> >  
> >  static char	*cfg_ifname = "lo";
> >  static int	cfg_mtu	= 1500;
> > @@ -279,11 +280,54 @@ static int setup_rx(void)
> >  	return fd;
> >  }
> >  
> > -static void do_rx(int fd, int expected_len, char *expected)
> > +static void check_aux_data(struct cmsghdr *cmsg, int expected_len)
> >  {
> > +	struct tpacket_auxdata *adata;
> > +
> > +	if (!cmsg)
> > +		error(1, 0, "auxdata null");
> > +
> > +	if (cmsg->cmsg_level != SOL_PACKET)
> > +		error(1, 0, "cmsg_level != SOL_PACKET");
> > +
> > +	if (cmsg->cmsg_type != PACKET_AUXDATA)
> > +		error(1, 0, "cmsg_type != PACKET_AUXDATA");
> > +
> > +	adata = (struct tpacket_auxdata *)CMSG_DATA(cmsg);
> 
> Sashiko had another interesting observation that this access may be
> unaligned, as cmsg_buf[1024] has 1-byte alignment.
> 
> That is not new in this patch. Indeed most tests in this dir just
> deference msg_control as struct cmsghdr * and CMSG_DATA as whatever
> domain specific type.
> 
> The man page also warns about this and suggests using memcpy to
> access CMSG_DATA. Not sure why it does not warn about the other
> cmsg_.. fields.

The commit that introduced that has more context

https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/man/man3/cmsg.3?id=36d25246b4333513fefdbec7f78f29d193cf5d9a

It points out 32-bit platforms where cmsghdr is 12 bytes.

At least one example given, ptpd, uses a union to ensure alignment

	union {
		struct cmsghdr cm;
		char	control[256];
	}     cmsg_un;

But at least one other example, ssmping, does not. So I think not even
the 4B (on 32-bit archs) of cmsghdr fields can be depended on.

> Indeed I can trigger this, e.g., with ipv6_flowlabel.c with
> 
> -       char control[CMSG_SPACE(sizeof(flowlabel))] = {0};
> +       char control[1 + CMSG_SPACE(sizeof(flowlabel))] = {0};
> 
> -               cm = (void *)control;
> +               cm = (void *)control + 1;
> 
> and compiling with -fsanitize=alignment. That triggers warnings for
> all fields, starting from cmsg_len on line 78.
> 
> In practice this does not cause issues, because the compiler appears
> to align char[] to 16B, even though __alignof__(control) shows 1. This
> seems true for x86_64, but I am not aware that it is true across all
> archs, especially those that cannot handle unaligned access.
> 
> I think the x86_64 source is the AMD64 ABI Draft, e.g., v 0.99.6
> 
>    An array uses the same alignment as its elements, except that
>    a local or global array variable of length at least 16 bytes
>    or a C99 variable-length array variable always has alignment
>    of at least 16 bytes(4)
> 
>    (4) The alignment requirement allows the use of SSE instructions
>    when operating on the array. [..]
> 
> Makes sense as sizeof struct cmsghdr == 16.
> 
> cmsg_len has length 8 (size_t). We'll be hardpressed to find a
> CMSG_DATA example with a larger alignment requirement. Indeed I did
> not in this directory. So satisfying 8-byte alignment for msg_control
> will suffice for all tests in this directory.
> 
> Unless we're certain that 8B alignment for stack aligned char[] is
> guaranteed across platforms, one safe approach it to add explicit
> alignment:
> 
> -       char control[CMSG_SPACE(sizeof(flowlabel))] = {0};
> +       char control[CMSG_SPACE(sizeof(flowlabel))] __attribute__((aligned(8))) = {0};
> 
> I can update the (other) tests. Unless someone knows that this is
> indeed not needed in practice on any platform.
> 
> > +
> > +	if (adata->tp_net != ETH_HLEN)
> > +		error(1, 0, "cmsg tp_net != ETH_HLEN");
> > +
> > +	if (adata->tp_len != expected_len)
> > +		error(1, 0, "cmsg tp_len != %u", expected_len);
> > +
> > +	if (adata->tp_snaplen != expected_len)
> > +		error(1, 0, "cmsg tp_snaplen != %u", expected_len);
> > +}
> > +
> > +static void do_rx(int fd, int expected_len, char *expected, bool is_psock)
> > +{
> > +	bool aux = is_psock && cfg_aux_data;
> > +	char cmsg_buf[1024] = {};
> > +	struct msghdr msg = {};
> > +	struct iovec iov[1];
> >  	int ret;
> >  
> > -	ret = recv(fd, rbuf, sizeof(rbuf), 0);
> > +	if (aux) {
> > +		iov[0].iov_base = rbuf;
> > +		iov[0].iov_len = sizeof(rbuf);
> > +
> > +		msg.msg_iov = iov;
> > +		msg.msg_iovlen = 1;
> > +
> > +		msg.msg_control = cmsg_buf;
> > +		msg.msg_controllen = sizeof(cmsg_buf);
> > +
> > +		ret = recvmsg(fd, &msg, 0);
> > +	} else {
> > +		ret = recv(fd, rbuf, sizeof(rbuf), 0);
> > +	}
> > +



