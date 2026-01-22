Return-Path: <netdev+bounces-252538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Pkd0IMiTcmksmQAAu9opvQ
	(envelope-from <netdev+bounces-252538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:16:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA576DA4A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43ABF300CC34
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0F39BA41;
	Thu, 22 Jan 2026 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTR3CQTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CAE39CB5D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116611; cv=none; b=U06ALQiECiLpfdeRnHFdSVzgn71vc/M3WMrhtgdMLhug3dL+ItqWdXEUEMYzuJHWa1iR+nXNzpTzrYes1u/ef+NNnrYfkYklZuWHFwPcpkf7SbAuCPIleH6PLZNyVMnZP4YJYWsDE0gC5a2smLH6CeIEiFy+zXtUA/qnu1AbBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116611; c=relaxed/simple;
	bh=qEC/5vZ9Ita/+Iyx/7Oe7zdmWu6d2WG8XdK2F5NCUWM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fUYbISctYeTzkNrmoL1WD4nVJ0yAcVCpATEG3y2xSYoeNBMJhdptv2GcoR+5g1MKYrnuBNS8GUqfbP78djVg4u962EkCsN5kC0xpRA1yGCMt9X9qRC35lTfjSvkQzRjo+rLfmWwe8iGSQTVrBLjuNXMRoTGmQUmpponMB8yVHCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTR3CQTu; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso1258713d50.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769116604; x=1769721404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSp3jm85K5YdacDbbZd7b5J1W/2vE97DmXJkJ6AMExY=;
        b=lTR3CQTuuhqR6yyzVL6dm/aZuK3oB6xvutrNY2ek2fX7VPZLFpg6EyjvMYDmr8+xDC
         wRGAgvaD4AWikwW1MAbAnoZD156iJ1Wwfk0x4VCaVMbW0BQNOX644BkjZFGt40Sx0eSW
         Aje6kh4ytf8djFfd2se1zdaE56hS+gBlQNIZQ5Clc51pKE3kcySHmImUVgyIzty5qlQx
         AZAVnz9w+v5/vJTfIKVgYfQJhlm5OxYVdHqSUw6Y1o1GQvF5VabtQaCL97c0GY3iIyNO
         PwxVy1QoLES7sHBGN9Bb/NgsRKaTli2xcu72e7+BCT8grli26J4qnm6wenXav2m3mHai
         RioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769116604; x=1769721404;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gSp3jm85K5YdacDbbZd7b5J1W/2vE97DmXJkJ6AMExY=;
        b=ugkfbMwjNDPY2PGT3qFihgJv+dlzb1K+Do6crVTaIe6gZDVKl3SGE0XHitKPETIxq6
         WDnU3ClAipBeMBuDcrhYbV77wT/0WUC9TnwUdrt6p6gzxuXe3s+lPuc/EwCUunqwjvOd
         rTdRQ3tI/kgs91fzRNMXSShpkC60EER03vc4BkbjKqR+qYu2Peg5/6yT9DYVWkHXEf+d
         1Zo3+ynKylBNuzTSRTdZ+F2PODRWoMWhTYfZECutvfdgeVEPy8HrEWJohpZ6Ufb9aLLH
         fAU1JbgOApjfuf6hkdu5uiksR7vV6aFUSQwIPcyLRY9s2P1+tVMJ0KWhbtmYCgH+u9RK
         wZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVMUwMRYjq3QV01Ibkg5eCCvnTdADzMNX1sNYwxYL2SenW7s5PE9asaYZiOmyBurz4G3sWzQ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvQPTFrw4UxZf/RrJznAPLP0gzjqwrrF4NYseIVTiWXIZHHU0
	h7oXZnD0AX0gmACTa5p0t1x/xE9fq5BZ44lr0ik3EnO8YORtMYWXwO4l
X-Gm-Gg: AZuq6aJpuB9Z92l7SWAOA2H2MI+yffkfVNilxmMpPqNyNeqVPsTDxqBoQ5qzuDzGue6
	O0VTAKTiSULUVjsCUE0/dPsk7YPEDOUHHwaQSEsGn8YMUB3VNN0kNfb1Ai8K285Jv4qnX+NWwcL
	hpuLgvgxAaFd1pJmFPxVG2g9O5jpa6gpvBlu6Wikuw4QqQYelP99A+/d95SW4g2hBVwUObOT/xO
	vbhIRmRDRhxY7ROjHcME6ZCvxiCKg2nOEX4h4RvBhUCUhAISL2+zHZiCQbiNHiicyszUE8rhyu2
	ypP5czE+KlHJWFz79fkuhi/+m1lxUlyQKCo3K8WW2xEPZxjlk2Pgg3i6MzFc/JhE3ckLrwtOh1Y
	Vg5RYs6/xab4TbjKjyvNeoQqhC/WcaiZAdiTqH1a6NYVGeL/ixN3cH4v968/7JwVh7AY3LyOT+E
	AMiKMqixxdv1/i4HRXd0LZh850bQASwoZGalL9uLab7VIlGi0dcoMZfKwjNSc=
X-Received: by 2002:a05:690e:d4c:b0:645:61fc:43c2 with SMTP id 956f58d0204a3-6495be54c66mr649987d50.8.1769116604458;
        Thu, 22 Jan 2026 13:16:44 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6495cfc1be1sm196019d50.19.2026.01.22.13.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 13:16:43 -0800 (PST)
Date: Thu, 22 Jan 2026 16:16:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <willemdebruijn.kernel.166500a9f06b7@gmail.com>
In-Reply-To: <CANn89iKtX7Omh7qXwt7A1=Q3nQ4VgVOAzWfgNBO-t0xWP7RKpQ@mail.gmail.com>
References: <20260122190349.2771064-1-edumazet@google.com>
 <willemdebruijn.kernel.65df45c3b4fe@gmail.com>
 <CANn89iKtX7Omh7qXwt7A1=Q3nQ4VgVOAzWfgNBO-t0xWP7RKpQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: expand NETDEV_RSS_KEY_LEN to 256 bytes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252538-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAA576DA4A
X-Rspamd-Action: no action

Eric Dumazet wrote:
> On Thu, Jan 22, 2026 at 9:22=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > NETDEV_RSS_KEY_LEN has been set to 52 bytes in 2014, until now.
> > >
> > > Jakub suggested we bump the size to 128 bytes or more.
> > >
> > > Some drivers (like idpf) were already working around the core limit=
.
> >
> > Idpf still bounds to the max?
> >
> > Iff respinning it may be informative to explain how drivers intend to=

> > use limits beyond standard Toeplitz. The tunneling that Jakub
> > mentioned. AFAIK there is no Linux control API to configure the devic=
e
> > RSS block in that way?
> =

> How the NIC does header analysis and RSS computation is up to the NIC v=
endor.
> =

> They provide some knobs, but not a way of using user-defined RSS
> hashing for some particular encapsulations.
> =

> Some NIC use a TCAM, and they do not use the RSS keys in sequence.
> Say if one 4byte member of the L4 4-tuple starts at offset 130, the
> NIC will use rss_key[130-xx] :rss_key[133-xx]

I see. That is no longer RSS as defined. But that's moot. The point of
the sysfs interface is to be able to share keys across netdevices for
consistent behavior. For whatever algorithm it uses.
 =

> >
> > >
> > > Since this change might cause some issues in admin scripts,
> > > bump it directly to 256 in one go.
> > >
> > > tjbp26:~# cat /proc/sys/net/core/netdev_rss_key | wc -c
> > > 768
> > >
> > > tjbp26:~# ethtool -x eth1
> > > RX flow hash indirection table for eth1 with 32 RX ring(s):
> > > ...
> > > RSS hash key:
> > > fe:16:5b:2f:93:85:c2:c9:c1:ef:bd:60:c6:e0:2b:99:4d:bf:b7:14:c8:1e:8=
d:cb:31:17:51:da:55:eb:91:d9:9e:f9:89:9b:44:a1:dc:08:72:3a:b3:d6:31:86:9a=
:fe:02:3a:0d:eb:a1:7c:f5:a3:51:3b:08:56:c9:3f:71:69:01:ba:70:38
> > > RSS hash function:
> > >     toeplitz: on
> > >     xor: off
> > >     crc32: off
> > >
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Link: https://lore.kernel.org/netdev/20260122075206.504ec591@kernel=
.org/
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> >
> > > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.=
c
> > > index 05dd55cf8b58e6c6fce498a11c09f23fd56d8f34..0f761d4b94471a5f8bb=
e0810922cf59e009be99d 100644
> > > --- a/net/core/sysctl_net_core.c
> > > +++ b/net/core/sysctl_net_core.c
> > > @@ -325,10 +325,16 @@ static int proc_do_dev_weight(const struct ct=
l_table *table, int write,
> > >  static int proc_do_rss_key(const struct ctl_table *table, int writ=
e,
> > >                          void *buffer, size_t *lenp, loff_t *ppos)
> > >  {
> > > -     struct ctl_table fake_table;
> > >       char buf[NETDEV_RSS_KEY_LEN * 3];
> > > +     struct ctl_table fake_table;
> > > +     char *pos =3D buf;
> > > +
> > > +     for (int i =3D 0; i < NETDEV_RSS_KEY_LEN; i++) {
> > > +             pos =3D hex_byte_pack(pos, netdev_rss_key[i]);
> > > +             *pos++ =3D ':';
> > > +     }
> > > +     *(--pos) =3D 0;
> > >
> > > -     snprintf(buf, sizeof(buf), "%*phC", NETDEV_RSS_KEY_LEN, netde=
v_rss_key);
> >
> > Why change the print method?
> >
> =

> Because the existing one is limited to 64 bytes.
> =

> lib/vsprintf.c
> =

>  * - 'h[CDN]' For a variable-length buffer, it prints it as a hex strin=
g with
>  *            a certain separator (' ' by default):
>  *              C colon
>  *              D dash
>  *              N no separator
>  *            The maximum supported length is 64 bytes of the input. Co=
nsider
>  *            to use print_hex_dump() for the larger input.

I see. Thanks.


