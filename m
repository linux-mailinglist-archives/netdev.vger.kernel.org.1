Return-Path: <netdev+bounces-195774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80CAD2307
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA003A65A4
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE9C211A2A;
	Mon,  9 Jun 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/tXHG6t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBFD3398B
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484579; cv=none; b=g8NX1NBcA9pPBgOivWOL9zojp2Rj9RtaBbx97INySaAwvXPUJsHgbS6ei+HesieZYi7PlWqx4mndB8KIf8kzfbrndiHol0QSVcFrspp/hkkuYKI9eTkyYkZ7GHaoskOhiZgyj2YLEUl6A4XsB6ncueNXFJVvDJb51TGXk+LJbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484579; c=relaxed/simple;
	bh=kHNb7XB8U4bRPOwCidHXiLPM3nTXojLJVSAZ6OwruZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzgxJk4ehpZNCvxik0cyuvjLUdxAHHNT/MD/RfBxjFOFkbMHj0CP1EWjPwda5SM2UaetOqN8XTPfyLFzuC+Q+cWP/fdiywueQIBnXE9yx/nA+FeWkKxo2MAgkuUTtMMjYxlziLo6WpHq61OOEgDJLgslc/Y7/TANvS4Ex/KDDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/tXHG6t; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3109f106867so5401474a91.1
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749484576; x=1750089376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7V4nXx/XmgwThi98aHNzgXMp4D6yqP9h2En083awTA=;
        b=R/tXHG6tnPLS6ovOA7WiWweZMORKpFAh4SCnb9PbWiZWgogOSeZgxe5nN44MxMXQjD
         gPs+tbbhP0AHQLpbIvNOQ5vUgHmS6iQTl5x4uV1C0uhKcAHoWaotEd5ni9dFWObDPHmK
         4/Vm0sgV9ZgFL/fs/uNv0IPjnbDGPtULDZDKzrvzRKT0KMvD/4SaL5xUdmBvqiKHNugz
         OV+gjhnNhAZbcuRKOycC6I4myQpba+YvWfCPe7NfRZAUVP2xcMtsIgjec7mGSMlgQY68
         GJaRwDo3IMgxwpBcLzplaLhZKTrIQkm+02h+KMRLP7VtOIqVk2bEPtVsC7TKM+2vOL1O
         ETqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749484576; x=1750089376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7V4nXx/XmgwThi98aHNzgXMp4D6yqP9h2En083awTA=;
        b=xAk8XbYUTdJOxxs1N7JfNVexJ5bWRMxvEQlBML9tHKDGAYMKdoPJITXGrJK966BXPj
         9ZjRzAcMQve+rh2hE6bhOraARKKouRbOcxG+hZY/O64QL8rdKF8qoSWf5kD2hTFQzT+W
         zEn1pH2xm/9rCkwYPmwFrxMqi/LP1G2xyROeEDJ+yyjRa2EPWDR4hWy0qgPzbrfBJ6X3
         7FR1JwsTrYN8nsB/d4RiAjCYcJch7JCSrinsH8hyUc2sTLmWlc19NWYU7jRHCESajUl0
         00SEJZZ9ZXeQj8umhRmhU4qQpVQI0JWS9eeBrXlpEcmxcUBdGOEh219oVDBmGGU4ErwW
         G/IA==
X-Forwarded-Encrypted: i=1; AJvYcCWYSHsDMJDqndHgOPZhs3qDueZdJvvQvII7nnvTsbKUMHaI+7JfgrRan8mucOL5h522dxBh6RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmlKPL5ALh0ejBBondaRLzdkoG7FzJwjM5ctL9gLgkWFo2n82
	zxg+dUAAPEGkP34rDJ485Ii2RLnyMFx5X+UO0uG90v3NpP7O2LCd7/w=
X-Gm-Gg: ASbGncsB7s4+/3CEQ2hAuG3YsEpDfHyBrwN/FA7xyytcjamaCg0UEfsL+2CuwMgKvXI
	JWwofSEpbVGOVcQ3w4r9rJMDb0OSarRbd9JLjP9+A1q7Z2kEj+cd5Sc0r2Wd2X/ygaTyS1BDzeC
	ZvE3nMDHBrASOuYswgzg5OfFgTMQjjd4OfLIPZGxRo/QT5yPqyCVhjiR+i0rE4a7O2Fmb3XWeST
	gUfgwbd848qJzgXAFTM0nE33oim15jezkh5cYbD/TjOR0+0zpTCE8q+fZPugC73PMS7jpc/MwqF
	vQK5DOM6iGmaPtlqReodY+YzuK48xHHHixfJTGU=
X-Google-Smtp-Source: AGHT+IFuWtJ8iBC7bteFs9SGuS9RqjXkKjhVG0KUCTWkok0jOHP406wEQ7OEE0FFz1yKJuXCmdmVRw==
X-Received: by 2002:a17:90b:4e83:b0:312:f54e:ba28 with SMTP id 98e67ed59e1d1-31347057c9amr21774261a91.24.1749484575838;
        Mon, 09 Jun 2025 08:56:15 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b128dc7sm5849842a91.23.2025.06.09.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 08:56:15 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: bluca@debian.org
Cc: brauner@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemb@google.com
Subject: Re: [PATCH v5 net-next 5/9] net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
Date: Mon,  9 Jun 2025 08:55:36 -0700
Message-ID: <20250609155613.563713-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <eb38a7d139a9c0854e2ed7122ee5ea5153227b41.camel@debian.org>
References: <eb38a7d139a9c0854e2ed7122ee5ea5153227b41.camel@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>
Date: Mon, 09 Jun 2025 12:14:51 +0100
> On Mon, 2025-05-19 at 13:57 -0700, Kuniyuki Iwashima wrote:
> > SCM_CREDENTIALS and SCM_SECURITY can be recv()ed by calling
> > scm_recv() or scm_recv_unix(), and SCM_PIDFD is only used by
> > scm_recv_unix().
> > 
> > scm_recv() is called from AF_NETLINK and AF_BLUETOOTH.
> > 
> > scm_recv_unix() is literally called from AF_UNIX.
> > 
> > Let's restrict SO_PASSCRED and SO_PASSSEC to such sockets and
> > SO_PASSPIDFD to AF_UNIX only.
> > 
> > Later, SOCK_PASS{CRED,PIDFD,SEC} will be moved to struct sock
> > and united with another field.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > ---
> > v3:
> >   * Return -EOPNOTSUPP in getsockopt() too
> >   * Add CONFIG_SECURITY_NETWORK check for SO_PASSSEC
> > 
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index d7d6d3a8efe5..fd5f9d3873c1 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1221,12 +1221,21 @@ int sk_setsockopt(struct sock *sk, int level,
> > int optname,
> >  		}
> >  		return -EPERM;
> >  	case SO_PASSSEC:
> > +		if (!IS_ENABLED(CONFIG_SECURITY_NETWORK) ||
> > sk_may_scm_recv(sk))
> > +			return -EOPNOTSUPP;
> 
> Hi,
> 
> Was this one meant to be !sk_may_scm_recv(sk) like in getsockopt below
> by any chance?

Oops, but the next patch happened to fix it.

Will try to reproduce it.

> 
> We have a report that this is breaking AF_UNIX sockets with 6.16~rc1:
> 
> [    1.763019] systemd[1]: systemd-journald-dev-log.socket: SO_PASSSEC
> failed: Operation not supported
> [    1.763102] systemd[1]: systemd-journald.socket: SO_PASSSEC failed:
> Operation not supported
> [    1.763121] systemd[1]: systemd-journald.socket: SO_PASSSEC failed:
> Operation not supported
> 
> https://github.com/systemd/systemd/issues/37783

