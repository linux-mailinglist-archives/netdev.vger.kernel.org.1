Return-Path: <netdev+bounces-139738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8465F9B3F35
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B5F1C20E4F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784724A28;
	Tue, 29 Oct 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="QnPyrZ8W"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53108B661
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161921; cv=none; b=oEiGb2TIIekbX7HpjlSOmBDvzHKzvvljWAgAmqsH1KGLaLx9SLHHbqt0m8KiOhDWqm7ABjZ7vnij5XQiDJfGS2zilPsUjHd4PvgNRGSf0+VrzKwfsrmHiZeJMFU/QC+gcdoXWP0M9AeiuPBV/6yvNzr1tEraWG69ymO1o/1Svtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161921; c=relaxed/simple;
	bh=p73brWklUbxC7lgEBXfu949V7Rw7kzgiB9eqmjh0/eM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uBFkbopzr1D7NBRKCMAdYeIQhCQvc82jajRoVlthIguAElBUf7DrqOJINpPotc+NTVQrz5IxOMqwV18TYKNXyKUocOwtVPc/POn/to6e5L44IZ8K3cJh5IiGVQfFe5sLDetdeFy4XqpUOULxfWee+ZDcZYCXvxxNZd55vgZszG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=QnPyrZ8W; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730161917;
	bh=XUQrrqej6zThFmH/cZQ2fkaboM1NbeexmiMvLng8kdI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QnPyrZ8W7JGiHrEUho+rHiPgCVyFxziqB02ud/svdCPibRCpcVNjQNPPDZhkCVrtw
	 fKdk9mXeGwp5lTceRvcHnXjEeZe/YQ5E3gncBNgMQL5hXfVB2svSjZoIAvQesixKTR
	 J7Ot7/oCxemBei/W3vqSwmRQWnehDnwZNJuyVoJJg774j/ddDuFYVTwo9VMrrqaPzH
	 fWL4T7czl7SqAP/0hroTgOA+IcACsmLpL3Y2a7VDt1HO5+T+BLdQXvEcQ7RCH23zCF
	 0rcV5divgy86a3OtqX0yr53+EFFJIwceM+n3KrZ927rPJ1Cgv2zHjhlCb3zFLRPCs4
	 Motjb1Y7f9XxQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 54FF267728;
	Tue, 29 Oct 2024 08:31:55 +0800 (AWST)
Message-ID: <e6863bfb99c50314d83e2b8a3ab8f1fabe05e912.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] net: ncsi: restrict version sizes when hardware
 doesn't nul-terminate
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Vijay Khemka <vijaykhemka@fb.com>,
 netdev@vger.kernel.org
Date: Tue, 29 Oct 2024 08:31:55 +0800
In-Reply-To: <286f2724-2810-4a07-a82e-c6668cdbf690@lunn.ch>
References: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
	 <20241028-ncsi-fixes-v1-2-f0bcfaf6eb88@codeconstruct.com.au>
	 <286f2724-2810-4a07-a82e-c6668cdbf690@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andrew,
Thanks for checking this out.


> Is this defined by a standard? Does the standard allow non
> nul-terminated strings?=20


Yes and yes. The pertinent wording of the spec is:

   The string is null terminated if the string is smaller than the
   field size

However, regardless of what the spec says, we still don't want the
strlen() in nla_put_string() to continue into arbitrary memory in the
case there was no nul in the fw_name reported by the device.

Cheers,


Jeremy


