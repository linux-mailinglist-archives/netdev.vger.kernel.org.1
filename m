Return-Path: <netdev+bounces-123508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7839651FF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9FEB20A4E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6B18A6CA;
	Thu, 29 Aug 2024 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwitmZCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8B1547D1
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967046; cv=none; b=tklNLNEwPlZc2vX8ydSa4tjc+buJkQO5btfGaCc7WsC1RkOfQpOT2mPMYRG908BqSeTQpJ/6gY/Tdcdbb/O/mtU7KgLxDFEuoImajFPJXDNVQz2sTUG3nOg2SHLhpAc1jqNphpBw2Gi5QrzHIqXHgpxWRm975M+pp047s2OqS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967046; c=relaxed/simple;
	bh=veTdfPZjJhhiiO7OPKsSN3BVQlNZ1W+lFi4lmp1JGB0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 In-Reply-To:To; b=R5XqWDnRcj7ke5g1O0gWS+mEi7kOtuHtBvWUIsKMAk6YRj2q/I5Ry9NtpenKedjU9DJqULEpsxW7gADSoB4JCIfd8iDaJ8H9UtKPXKeQ/5TBzC7ihEeIuj6bAExoX+B1NmDBQQHw75YvBQPtcwDKypes0VQGkTI+8n7EE+1YyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwitmZCH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201f7fb09f6so9171705ad.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724967043; x=1725571843; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:date:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdtYFY9lq4J4X1j/u/Lg+YpD+R3sglqSN3k2waoouWc=;
        b=UwitmZCHHv+2HaUcvtGQXK6GocP7MtllGxFoapEa221M0F6y0mQwHUG0wmemyW1ym+
         LndeyW+VlW/X1LZP7xcvD30LewmMPdA2sMdnL/wSiA3XemdZtlsHIv9fV2GuBaCaDT3o
         +T1SWTGjYjHPA6efrKyr9IpN7RFh7HPbREFg+V6tUqcrRexjEQWqfXTuQzZKRuW/QWqd
         fpZGjOm3nuXrNi6+df45kEZVtagw8sox7Xr+l2vz/iYdc/AyCEJsgZpps3HVl/t6v8Je
         8cOqb18pp0yVb/5eQYCpKI2BtGpMGKHfgYP6cfjm+fMazEr0o6lyFxc7F+GpR/iaACiF
         y47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967043; x=1725571843;
        h=to:in-reply-to:references:message-id:date:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FdtYFY9lq4J4X1j/u/Lg+YpD+R3sglqSN3k2waoouWc=;
        b=ZHleirbI+/4vX8hUXQq7Vsm8TR8dPEWArFgZqBskbpew8iP9buZOsJPwtUUBHoE7Ks
         ChLSmAblzAbP7cORl6OUvjjynH3i+XAiUhJaiedqgrZ02MxveEc4JOfEX3/VK6TQPzEJ
         xlv0dmHRLSBcq1iQH6ESrwYCGrUxKiYPd8q5Bhm/zIr4/aJ0bOQluTpJj3cFJxI5Qx8Q
         LOty8Pzlar05JQYNeLPHQGaXBYs0B2zIUn7K0c1xMjEYO6a6lD7kCFCLqSowTZ1pbX0x
         TLxlGNfvW8TrxXqDVJVS9h9AY0yJ6J8u/KMxLpekMtc7nSHlQEwXDYoDfKHOgLWgUt9a
         bsiw==
X-Gm-Message-State: AOJu0Yz1ro3wgivV06y63DIFIe4C9Jy3A6jTuFbczUr5gcDV9suVmj9u
	pac2Ea4Hdkof2Xomu7sDN9oZ4w9pbkl13A2sJmfn7Ckf14X+EzSxXwTCeg==
X-Google-Smtp-Source: AGHT+IEExDYKtnvCFqTf8yh9ILU1APuPY58UzOQrlWOnztgvQNrXzM0LgcxmramLjW8mvJbd9rvPnw==
X-Received: by 2002:a17:903:2444:b0:1fc:6a81:c5a1 with SMTP id d9443c01a7336-2050c215b42mr44033985ad.12.1724967043365;
        Thu, 29 Aug 2024 14:30:43 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:a500:a491:1cf6:afda:929f:5a3c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b332dsm15836575ad.37.2024.08.29.14.30.42
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:30:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: SIMON BABY <simonkbaby@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Query on sample configuration to test network trqffic between two different networks with dsa enumerated ports 
Date: Thu, 29 Aug 2024 14:30:31 -0700
Message-Id: <9C4B8EF8-004C-477D-9816-666A19501390@gmail.com>
References: <B4EB051B-5E69-46A1-8A72-AB3D1F9B6736@gmail.com>
In-Reply-To: <B4EB051B-5E69-46A1-8A72-AB3D1F9B6736@gmail.com>
To: netdev@vger.kernel.org
X-Mailer: iPhone Mail (21F90)

Hello Team ,
I am waiting for your help .=20

Regards
Simon
Sent from my iPhone

> On Aug 26, 2024, at 3:23=E2=80=AFPM, SIMON BABY <simonkbaby@gmail.com> wro=
te:
>=20
> =EF=BB=BF
> Hello Team ,
> This is a basic networking related test for testing DSA enumerated ports f=
or traffic.
>=20
> My requirement is .
>=20
> I have eth0 as the  dsa master port ( cpu port ) and the slave ports are l=
an1, lan2 =E2=80=A6. lan7 . =20
>=20
> I have two PCs. One (PC1) connected to lan1 and the other one (PC2) connec=
ted to lan2.
> PC1 and PC2 are in different networks.
> I am doing a  ping test between PC1 and PC2 .
> What changes are required at the system to route traffic between lan1 and l=
an2 . Do I need to configure a layer2 bridge or we could do with L3 routing ?=

>=20
> Regards
> Simon
>=20
>=20

