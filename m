Return-Path: <netdev+bounces-275425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mtRQAjbR0WmWOAcAu9opvQ
	(envelope-from <netdev+bounces-275425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 05:04:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5711139D2C8
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 05:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA823300998A
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F396332EA2;
	Sun,  5 Apr 2026 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr+1Iwjo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86B270EDF
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775358259; cv=none; b=FGS91euWrBBKNtlhz9Yw0tjYhOxKWr2FwGfV/OttPp0g1WdoG+MC17HTFWK35pA+ZXZRX32beVlhf8IhKSpqUpEcdr6kkvnTr7dsvUGtUGrk+PwKbrqCBxzFvazSry097hQruzSUVfXgzm5CgxZF9vScdflvLxSOGeUIqfg1aq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775358259; c=relaxed/simple;
	bh=yEEngp7KMalharel9krZjkWbN0/Aha54Mek6b7Gatgs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p1qSUJd2g+YZC4nKnYn4OUusuduxZFZoJhF+2wnQothxBCCTlz0DYHj6neb0xOaWwi9DOOtTP2oV/WySxJNLOhA3dVYJ3DF5Cc7pejwVTPzUcEDcrbBS6cNdLl/Ld23xnkxZr4TIfyQzRdPC8Lc2oMzkBEjMC/G8jbeo0Uycc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vr+1Iwjo; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a46ebe2beso27861117b3.2
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 20:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775358256; x=1775963056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUZgKANrOkAQxf/MKhOniIP53GJxYrHO6dhJcPyazRk=;
        b=Vr+1IwjoN6QHsxtJjlUtZXUfbZDDAxb52rttzn2VGzvGLkcyCc9ynrvaUUhYXIM+NX
         oHnfiAYsR2uBCnVqSy1w/RPzbM/qvYIW0b5355qkVYxfmAYed3WyoSfx/iN1xp+4VEw4
         H/aNvLME0Dn0qIV6XtuufieUQfq6nfN071FW/YdpXVkjMR5ckarRCQTrzA5MVjXhh3I0
         xIO4HISjF8lWlsKq9MskU1/w0R9N1kH2GM4PJ/56PnWrke10zM0ALBwh4NmhF1wRhaI3
         5YxMr3QIvdpp8Rj2iTqTbyQJg3rkqfLGfQTKzFPlQiFa5TcZgf+PH6N5+659HAbF+B+5
         wfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775358256; x=1775963056;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUZgKANrOkAQxf/MKhOniIP53GJxYrHO6dhJcPyazRk=;
        b=kTN7dn2ugmu37ONadAXuCHA9N5bieethWfQjFhgo9iQlCr9eKeTW9ns2zoP+U/5iz2
         IlFGqXQ031+L9RgoTQKpQwTNPQUu6hXbXwFpn70TV22oTdcSuXa833VnFnuH+susuSbk
         qGLDHcOmCRTKbVYo2UP3dD4pLJffvCPV3KQ/5hdtUkyFqXoEkfYQGkmOt8GUbNVAwjNz
         O9d5DuoatJv1sgf6DqdNy9LmzAXatp5aS392ifzhvtQlM+7SIrkXJ5vZ8rH2T5gepepx
         Xh3qoGtfytW8zNr89+G52wc2bgc9EIJa2itgUV4jlUefzUynjqg5AFewLN0MCrqI6Bys
         yLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCPEBgnsun+JCm1GSHII2+Q0D87tKmGvqmKyVuhm+aGZD1TxVBUNkSq5Sg+llIyVJ5Eo8KzxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLgfyrZL1606NWLkvN/5ntjR1gX2VcVKuSOZQDU4mYJo7ToW7
	7Nyp9vMUEUkZ5yt1IFrQFjCZKJxBneNhIaU9j7GIlEJ1xiCbHCzryPPE
X-Gm-Gg: AeBDietCAsmiDHcfw5tTqZvNxpcMTEvV6wAmXPQzwzmFPdcPSfJOBeCQAolTGzlLl+2
	28up8eFG0//SgeEjVTx+SlTF9Luq5awWO3AONxivPMYPyQ5US8ONQsXG1BVBAZe80vQUdAn/8lg
	5ZQC7yBPvf80Lz3Nn1LfOSvYA46yh9I5lAfdlmRUvPSEfgRNS1VQXCGsa3FIg6BVdtb31WjFMKi
	/yoVJ5r5b5Sr1giGvpsUINNm3ep1YlNjYhcpFl58JQCYtOP2gL9bOMkeCtgTuCloDE4KxHdCEBn
	vWLychKwbwoDzhf2Tf72kQirZ8237KHijlfY6rOO+4PsGc/PixI4bP1wyN7347x5XPYdHgJ2CfB
	0iJB+9v6HYw1eyXj408UdfK6KqnYxE4WzxcrYAVQQnGov931MqQuGm72eJT+5QjMyeR4x6zOMgU
	VIayq/J0gBtGV76DpZ6djxwdyQVID2mGl5zEBdL6szdFdsZWAi+PfPCBhPIH6i5ao+lL6VSLpv8
	kZ9
X-Received: by 2002:a05:690c:c183:b0:79a:c40d:b73b with SMTP id 00721157ae682-7a4d604f231mr71869457b3.46.1775358256085;
        Sat, 04 Apr 2026 20:04:16 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370901513sm38076957b3.29.2026.04.04.20.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 20:04:15 -0700 (PDT)
Date: Sat, 04 Apr 2026 23:04:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 linux-kernel@vger.kernel.org, 
 willemb@google.com, 
 Joe Damato <joe@dama.to>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.400d24decd7d@gmail.com>
In-Reply-To: <20260403233240.178948-4-joe@dama.to>
References: <20260403233240.178948-1-joe@dama.to>
 <20260403233240.178948-4-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275425-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5711139D2C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Joe Damato wrote:
> Extend the packet socket selftest, adding a recvmsg path, to test
> PACKET_AUXDATA. Check basic attributes of tpacket_auxdata.
> 
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  tools/testing/selftests/net/psock_snd.c  | 67 ++++++++++++++++++++++--
>  tools/testing/selftests/net/psock_snd.sh |  5 ++
>  2 files changed, 67 insertions(+), 5 deletions(-)
> 
> v2:
>   - Add is_psock bool argument to do_rx.
>   - Factor out aux data check into its own function for readability.
> 
> diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
> index 81096df5cffc..5464317c1764 100644
> --- a/tools/testing/selftests/net/psock_snd.c
> +++ b/tools/testing/selftests/net/psock_snd.c
> @@ -40,6 +40,7 @@ static bool	cfg_use_qdisc_bypass;
>  static bool	cfg_use_vlan;
>  static bool	cfg_use_vnet;
>  static bool	cfg_drop;
> +static bool	cfg_aux_data;
>  
>  static char	*cfg_ifname = "lo";
>  static int	cfg_mtu	= 1500;
> @@ -279,11 +280,54 @@ static int setup_rx(void)
>  	return fd;
>  }
>  
> -static void do_rx(int fd, int expected_len, char *expected)
> +static void check_aux_data(struct cmsghdr *cmsg, int expected_len)
>  {
> +	struct tpacket_auxdata *adata;
> +
> +	if (!cmsg)
> +		error(1, 0, "auxdata null");
> +
> +	if (cmsg->cmsg_level != SOL_PACKET)
> +		error(1, 0, "cmsg_level != SOL_PACKET");
> +
> +	if (cmsg->cmsg_type != PACKET_AUXDATA)
> +		error(1, 0, "cmsg_type != PACKET_AUXDATA");
> +
> +	adata = (struct tpacket_auxdata *)CMSG_DATA(cmsg);

Sashiko had another interesting observation that this access may be
unaligned, as cmsg_buf[1024] has 1-byte alignment.

That is not new in this patch. Indeed most tests in this dir just
deference msg_control as struct cmsghdr * and CMSG_DATA as whatever
domain specific type.

The man page also warns about this and suggests using memcpy to
access CMSG_DATA. Not sure why it does not warn about the other
cmsg_.. fields.

Indeed I can trigger this, e.g., with ipv6_flowlabel.c with

-       char control[CMSG_SPACE(sizeof(flowlabel))] = {0};
+       char control[1 + CMSG_SPACE(sizeof(flowlabel))] = {0};

-               cm = (void *)control;
+               cm = (void *)control + 1;

and compiling with -fsanitize=alignment. That triggers warnings for
all fields, starting from cmsg_len on line 78.

In practice this does not cause issues, because the compiler appears
to align char[] to 16B, even though __alignof__(control) shows 1. This
seems true for x86_64, but I am not aware that it is true across all
archs, especially those that cannot handle unaligned access.

I think the x86_64 source is the AMD64 ABI Draft, e.g., v 0.99.6

   An array uses the same alignment as its elements, except that
   a local or global array variable of length at least 16 bytes
   or a C99 variable-length array variable always has alignment
   of at least 16 bytes(4)

   (4) The alignment requirement allows the use of SSE instructions
   when operating on the array. [..]

Makes sense as sizeof struct cmsghdr == 16.

cmsg_len has length 8 (size_t). We'll be hardpressed to find a
CMSG_DATA example with a larger alignment requirement. Indeed I did
not in this directory. So satisfying 8-byte alignment for msg_control
will suffice for all tests in this directory.

Unless we're certain that 8B alignment for stack aligned char[] is
guaranteed across platforms, one safe approach it to add explicit
alignment:

-       char control[CMSG_SPACE(sizeof(flowlabel))] = {0};
+       char control[CMSG_SPACE(sizeof(flowlabel))] __attribute__((aligned(8))) = {0};

I can update the (other) tests. Unless someone knows that this is
indeed not needed in practice on any platform.

> +
> +	if (adata->tp_net != ETH_HLEN)
> +		error(1, 0, "cmsg tp_net != ETH_HLEN");
> +
> +	if (adata->tp_len != expected_len)
> +		error(1, 0, "cmsg tp_len != %u", expected_len);
> +
> +	if (adata->tp_snaplen != expected_len)
> +		error(1, 0, "cmsg tp_snaplen != %u", expected_len);
> +}
> +
> +static void do_rx(int fd, int expected_len, char *expected, bool is_psock)
> +{
> +	bool aux = is_psock && cfg_aux_data;
> +	char cmsg_buf[1024] = {};
> +	struct msghdr msg = {};
> +	struct iovec iov[1];
>  	int ret;
>  
> -	ret = recv(fd, rbuf, sizeof(rbuf), 0);
> +	if (aux) {
> +		iov[0].iov_base = rbuf;
> +		iov[0].iov_len = sizeof(rbuf);
> +
> +		msg.msg_iov = iov;
> +		msg.msg_iovlen = 1;
> +
> +		msg.msg_control = cmsg_buf;
> +		msg.msg_controllen = sizeof(cmsg_buf);
> +
> +		ret = recvmsg(fd, &msg, 0);
> +	} else {
> +		ret = recv(fd, rbuf, sizeof(rbuf), 0);
> +	}
> +

