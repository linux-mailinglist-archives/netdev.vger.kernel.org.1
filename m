Return-Path: <netdev+bounces-181759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1AAA865FE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882A99C15B2
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BE278159;
	Fri, 11 Apr 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0c0cTYG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9D25C716
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398893; cv=none; b=mP6jtp6mXht7auPIEjw7Ik0WymIaAbNNDqBWa2OFi3aVwUU/d+wXpI5pd7D+3CZDloHGd2XAyOED+VWvW79d3Qp+E0FRknpwJc/8wXwh6NFeGd5Cb5l2xgiaycJtyDqXhYV2PkOLNyTBHFweSRGueY9HIN4Ah3ZwOKHQOvWMEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398893; c=relaxed/simple;
	bh=ew7G7nUzJHLDTCLZM/6FKEFOKCNCWkL2tLpyxx1BaMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU7rBorg4g6rv5j1qZ/xJuh1auqIs5KqkjXp6GUfpD3HfdkFjT8RGQOSIH3liOGDE9S/tS0eCENRcozFo+b/4k6zB6W3nMGVler1l1nIYXq1Wr0eHHwcFVFAyiKwZbb9u/X0J5NKiPBeJE1BSIQ91XulD4vclsf/iTY/UTLXugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0c0cTYG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf7c2c351so2500705e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744398890; x=1745003690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0QGGpkm8jXMLW9ND7pujumQ83GWkKr2keM5EXPaDmE=;
        b=N0c0cTYGxTD30DxKYyiNIX6I2pgtE+agd4kEjfWjVkkWFGo16JU3mBc9OpXsITEyQw
         YGbBbT6q+jDNmqxez3KiSoTm9S7MuWBaTF5qBl0/+QtJOHX/q3o3CDoIMyDk1ZuN/8na
         7wJO0GsqCPNLruuPsobb7NXX6J5mEB18NuTY1s5fHeE1oebx4PaK7cSvAffk7CV7LAVN
         gd2MyHmXo1Hs1DhjuC6lg6Axo/2lXhCBBFNwfEko06O65eSGQWlQ6MUFgdkdCrXLWnu0
         IbiuhJKjoRNVCwtNmo3oRrwLLzLPHR+VftbwVvwN13lPLIMxdm/O/HMwn/rNJ5pelKNX
         fQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744398890; x=1745003690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0QGGpkm8jXMLW9ND7pujumQ83GWkKr2keM5EXPaDmE=;
        b=AyCZ0an77dfRgFIIhGcEks3PRDww8O/38szrM/sIKd13jwlOcTwdlkwbnTSYLzH59j
         RvW2sX6yD440cGQ2wqYzHd5QCLfwBy/HltFH8sqsuu9/NSBOTmbDhXous6NRkjf+lvvA
         bUqWubhqq0tacp+wOPudhWIFCo+QLXlgOEhQaIdMoJS9fJEyB51yEda9cWfTwxuLwI8S
         m6YMAlOJtdk1Ogfnf4+puRlFP9xvXJu1DbZDNBBGKlLOMNQcnXQAZjLnH/nu6wkbD2jx
         r3HfJ8ctDuiYNaYSo2Y5cpvNcwyKwdGMkYrIH6egb4mR3w8a+cD1YmLiwf8JvGHO7iGn
         J8Ow==
X-Gm-Message-State: AOJu0Yxne8Xzzjaubs724u1SoTFPR/4NpZlcygSBsKSRYy0sHu86iScI
	hKggockPA0R34GeCJQvbCQFvqIVVfjpHv9+BNTN8YXpITkO7wSCCtxVTkIUo
X-Gm-Gg: ASbGncun5W340K37WSXWIq+pWHMNYSUp3BNemr/S9FHok7cEjbvS3wu2E1hLT3lGwW5
	O1MTaS5uTf3dEfR5WP9yR6gVOFr2GvE3268kehAVOgkOehG1qRR+Gmz/zNbRXUX/ChMAXcJIvNB
	5+X8QFEUojchh5MJNLuizz4q1f8VHuz8Da3f/8TAoI0prMjxhyBytJj+Ohhracq7Y6yA49lK1vv
	eFePLXKgR+pBnUj3lYoufOhvlxaSyLQuDATnv3Uj4AShJOqXXQnsWnBVPuJfAp9qrVg46+k2Cc/
	Dp4EvKsQfU6TecO9gR5PeZLPD64u
X-Google-Smtp-Source: AGHT+IGTbGUZLMYsomwqsQDmfPdIJyUecJYiNvQT9TE4TF7C/REi4x9jPe88/5EsgVcuAPFaUC/bJg==
X-Received: by 2002:a05:600c:1e02:b0:439:a1c7:7b3a with SMTP id 5b1f17b1804b1-43f3cc812c6mr12391055e9.1.1744398890280;
        Fri, 11 Apr 2025 12:14:50 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm91417185e9.23.2025.04.11.12.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 12:14:49 -0700 (PDT)
Date: Fri, 11 Apr 2025 22:14:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [BUG] unbinding mv88e6xxx device spews
Message-ID: <20250411191447.b3p3neasoxk5bz6e@skbuf>
References: <Z_lRkMlTJ1KQ0kVX@shell.armlinux.org.uk>
 <20250411180159.ukhejcmuqd3ypewl@skbuf>
 <Z_li8Bj8bD4-BYKQ@shell.armlinux.org.uk>
 <20250411185430.ywnlnkba4jyb7rie@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411185430.ywnlnkba4jyb7rie@skbuf>

On Fri, Apr 11, 2025 at 09:54:30PM +0300, Vladimir Oltean wrote:
> > but... of course there's another issue buried beneath:
> > 
> > which seems to be due to:
> > 
> >                 WARN_ON(!list_empty(&dp->vlans));
> > 
> > This is probably due to the other issue I reported:
> > 
> > [   44.485597] br0: port 9(optical2) entered disabled state
> > [   44.498847] br0: port 9(optical2) failed to delete vlan 1: -ENOENT
> > [   44.505353] ------------[ cut here ]------------
> > [   44.510052] WARNING: CPU: 0 PID: 438 at net/bridge/br_vlan.c:433 nbp_vlan_flu
> > sh+0xc0/0xc4
> 
> No, they're not related. This is the third one, and I already know about it,
> but it's relatively harmless.  Since I knocked down 2 already, let me
> just go and take care of this one as well.

Actually, I think you're right. The WARN_ON() that &dp->vlans isn't
empty should be a consequence of the STU issue. Please let me know if
this WARN_ON() disappears when testing the patch in the other thread.

I was under the impression that you were hitting a different WARN_ON(),
just one or two lines above this one, where &dp->fdbs or &dp->mdbs are
not empty. That's what I was aware of, but it looks like you're not
there just yet.

