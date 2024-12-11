Return-Path: <netdev+bounces-151255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4622A9EDAB6
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 00:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9343168D63
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0DE1F236E;
	Wed, 11 Dec 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="R60Bc3wz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0871EC4FF
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958111; cv=none; b=XWNGbZnixuV/ZvqunuDUXmUTWXIWTVVmbsgH2XMo5AowxQcdJGB0f/JKzAuBaBK0B2J7qtjIU6HzyQwpUJGhSXe+s1u1iFlbiCW1WuakqQk1QxcpMBKCT4Dk98bpNF3ujPLsVd1UrjriYNiZiSh/+xTnG2Gar/FIjdFerRFKtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958111; c=relaxed/simple;
	bh=7702vU6deKDG7UUlM9f7IXMlbtnn4sBDdbyNvy1bzAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5OqmsyFL5C571aMuV1H600vmMxzGPBTCX07eEc5D5uhQyjMEuhV/WN5R1CM+P+etckEK7vUOBPcNfVPHv94xsLQhP+V/n91AlWrao+Lvr43OeJY8sOyXlo2YoVQnSOze9KAGoqhD+x8iFMc3cEaMPwhqTbP2Xkxp4iyGo/1HHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=R60Bc3wz; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aqpj2NOEIC4he92SdwRDRx1lfkZ6BBPNo45E39NFDBI=; t=1733958109; x=1734822109; 
	b=R60Bc3wzcFkvD7zN8dJZHMXEmvWul6xIRhvr+ylllBohFWilFtOfpecLUcXST3ATphCt6QTcFxz
	h4naZocDQa+TyVQoCvtmvfhC0jseO122fu2uJQR7SO0I6yQ0EqRX4SZgIm/sbspOCv+DZkB2kO7cP
	rX8YBF5ZEnhnAtXmLisJW6bzeX4vzBuvdN/g+b7uZUzeI9hvByvXCLTpcQgicSRP9xg5FI2zAQ8vP
	uOfQqpX08vlyNmm9UfOtLR75kfmBvjnBNOK1974t/0jH43xMXPhsAWpVmCgxfmLqOuxVaa95pO7Jm
	Nr5GnZC+hOQjxBBCdOdooZizCNZXyCdbTDwQ==;
Received: from mail-oa1-f53.google.com ([209.85.160.53]:45144)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tLViG-000088-Sl
	for netdev@vger.kernel.org; Wed, 11 Dec 2024 15:01:49 -0800
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2967af48248so3624303fac.2
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:01:48 -0800 (PST)
X-Gm-Message-State: AOJu0YyCJzql56mIlJUyriWdq5OZy1RazKWBnN7x8S5WDwSJLdgqKWrW
	IuUSDEYR+HIH1bvAjsORQdLOrIVuE2Ewr8/zTL6+jEGMeKzBpto7G9fxEX0IsRJDikI3Nb/BZ10
	QL7DtZ+xsajqllfC9AJUS+bcgb1g=
X-Google-Smtp-Source: AGHT+IHMmJbu1mq16kwWiBPDWWfFkW/tJrzU574SuWj5+4lizRoWNVYoOrYlESwnGJnpQZgzr5rD82aQgwvkgXGoS3A=
X-Received: by 2002:a05:6870:2102:b0:295:eb96:9fd4 with SMTP id
 586e51a60fabf-2a012c0f7b3mr2942903fac.11.1733958108304; Wed, 11 Dec 2024
 15:01:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209175131.3839-1-ouster@cs.stanford.edu> <20241209175131.3839-13-ouster@cs.stanford.edu>
 <20241211063914.GA34839@j66a10360.sqa.eu95>
In-Reply-To: <20241211063914.GA34839@j66a10360.sqa.eu95>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 11 Dec 2024 15:01:13 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxC5PkcbXyRuAxa6_uYDPoEE-_RfcE4NmyAHwg_rf9ChQ@mail.gmail.com>
Message-ID: <CAGXJAmxC5PkcbXyRuAxa6_uYDPoEE-_RfcE4NmyAHwg_rf9ChQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 11/12] net: homa: create homa_plumbing.c homa_utils.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: a11a15d02c0ec4233875b3872b0caebb

On Tue, Dec 10, 2024 at 10:39=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.co=
m> wrote:
> > +
> > +     /* Using a static buffer can produce garbled text under concurren=
cy,
> > +      * but (a) it's unlikely (this code only executes if the opcode i=
s
> > +      * bogus), (b) this is mostly for testing and debugging, and (c) =
the
> > +      * code below ensures that the string cannot run past the end of =
the
> > +      * buffer, so the code is safe.
> > +      */
>
> IMMO, Regardless of the scenario you expect to use it in, writing code th=
at
> is clearly buggy is always perplexing.

Fair enough; you have shamed me (appropriately) into changing the code
to use only static strings. This reduces the amount of information
provided if a bogus type is provided, but I don't think that will
matter in practice.

-John-

