Return-Path: <netdev+bounces-248277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71657D066B2
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 23:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBBB230275B7
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339552F12CB;
	Thu,  8 Jan 2026 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiduMBaU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D31E5702
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910803; cv=none; b=VDRxIUbymkMfNKNM2EFi+5Xb381DQFVvxAi0gvEAYE3P2NFy9dc+NWFf8MQkXmFYLRPuWQd4sm65R1fzPXwH09pL08gY9b+QY81ot6dqP9mDtA2d+K7jPILuOGUL4Gb333vLbO6ahYW2ro6NEMMM4jPEGGI4ZberrQ9qPqzItWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910803; c=relaxed/simple;
	bh=+wSVc2IT5bsrbZWZdITGeeRuH5v05cIZtgKBrisJhGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7y3kdti0OyhMFW0G/Zn4EKAgRpTwnQmGtMeZJUcZa73AXQZ+75crcjV3lKWtHTo8RvKo8/AxTfI3kqg7SodQ12T8r+DHZqD+JKa69ta/7CmPc8BBtcGACnrsCZO2TrCHx80Cc3K0SvEPrtrGO0sLgg71P4pb/ID1mZ3bUeYOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiduMBaU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d67f1877so30883605ad.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 14:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767910801; x=1768515601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eSpvqBcCMdUnYFu5r+IbcRJ+Ycs9RPex6ZaryNeYwM=;
        b=LiduMBaUtvatD5wq2FLyHAQk1vgB0NTDSSHFfstiRLFFpeeuvjpy5QSiIWnFq3iZ/p
         yfUCwHBzhDfDMsWPBOuP9UN4JeKF+OHhZ+B5Ss6q7J5VKkBCMDIcIu7JyXaCZJNAsqlm
         aYlLpNhVXNVsnqws5yLkCuA8tWKvBKvDQdeLzluerI3ZIqJdnSVKNMLTJZoRLNCEQkqw
         mb58YRIaGvYsERKsn5x7t2cO73A8YCtbN9+6Lsqw7UM5OUo/kWb0eErE7gdWP47uaxrF
         pgpiDPCYHD8CNEqnwKHkOcnTV4Wpw7q8QazYcRc9xiWWhfXE/NS8yAwA3xa2aRS8JS0Q
         cVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767910801; x=1768515601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3eSpvqBcCMdUnYFu5r+IbcRJ+Ycs9RPex6ZaryNeYwM=;
        b=eYJFcm3xX6SYtkcc+admBHtgRRJvu38EZv+IGAc2o5E+JEVPfzxPovfpkBHEc+826s
         /Ds5XiQOlX1ubLnxFsl4FmILl1MFkT4woWAeHrEjf5+Vuwf11WwFkLtpQB3iXC0ONe4e
         OM9o0mjVQ3j2dCofUxUN/nwaGhsc/1TGheKLQ3MCdN7/uzeO9QY7e4g88FBBs3kMBdh1
         7Niu7yl9v7vREnYYhWK/Y3Y2LIR4bkS70QTmNmhBGrqT7FWoS58jT0eMcQVpxGDpBS6r
         EDRYEogeXxPliOpgFxtIO08LOdrcadhtLxjF3ilosz+CyMA199CgQzLefLCAqdIeWJNr
         WsDQ==
X-Gm-Message-State: AOJu0Yxx0P8oKb52MrrIwt9t1jIqfM1dXNXMfJ/H6uSGAu4qA/Sx5FBc
	fiSXht12q3XD9o7b3b/2w8IDrFDpTj3zMjoyDCZoFnURPG3qqX3c31jukKCusRi5Go9td6gyJCI
	5WYl9anngYI4grdCd0bgKFXFMYlKPnX4=
X-Gm-Gg: AY/fxX58Cg0SDMnVtcjVjViNkrQqLt+jLqb9SsMf+g/QJasQspU6pupQ3AkkXjPoPVp
	IGI6H9HcKeZlRyBLkyfvUPIHPtZBPZ43plmBNwN6dCbR4PQFFvYkMbN9y8+yBMQpIO/QCHbzIJc
	m93g0XN15oIL6I9J3h9+5HBcd/vfYYmx9BDGkVsmjyUtb2TNiu5/ttL9+QK5ic9alsxeFDD7zhj
	80V3C9B5mt+tFoMomcfr+bv3iuc+JAmup3wvT/qCHO+S1RyoT9atOob+4DaOkUe/bNXDYE=
X-Google-Smtp-Source: AGHT+IE6kkegFDt+9XCzD+S56azqAPTIJarvZtVAkqkfUkoYB3glBC/TJm42hBLD2pQUlnWfdjMc3cigjDPJ1b82sgo=
X-Received: by 2002:a17:902:fc43:b0:2a0:ccdb:218d with SMTP id
 d9443c01a7336-2a3ee442824mr75598785ad.17.1767910801242; Thu, 08 Jan 2026
 14:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767621882.git.lucien.xin@gmail.com> <d5e0dce5e52d72ed2e1847fe15060aa62e423510.1767621882.git.lucien.xin@gmail.com>
 <0df97c1d-aa75-4472-aad6-33eaa919ce28@redhat.com>
In-Reply-To: <0df97c1d-aa75-4472-aad6-33eaa919ce28@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Jan 2026 17:19:49 -0500
X-Gm-Features: AQt7F2oQeSaDlFSlRPZRuDsHDmuOmu--yt6QSCtiFGQnIoBOFFX8SGhuo0gGWpA
Message-ID: <CADvbK_eVM5T3u7hiXR=S3ydHCAneCP_wLM7Q4Tc=D6eJ9tv4sA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/16] net: build socket infrastructure for
 QUIC protocol
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:40=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/5/26 3:04 PM, Xin Long wrote:
> > +static int quic_net_proc_init(struct net *net)
> > +{
> > +     quic_net(net)->proc_net =3D proc_net_mkdir(net, "quic", net->proc=
_net);
> > +     if (!quic_net(net)->proc_net)
> > +             return -ENOMEM;
> > +
> > +     if (!proc_create_net_single("snmp", 0444, quic_net(net)->proc_net=
,
> > +                                 quic_snmp_seq_show, NULL))
> > +             goto free;
> > +     return 0;
> > +free:
>
> Minor nits: I think an empty line before the label makes the code more
> readable, and I would prefer #if IS_ENABLED() over #ifdef.
>
Will replace all #ifdefs with #if IS_ENABLED().

Thanks.
> Other than that:
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>

