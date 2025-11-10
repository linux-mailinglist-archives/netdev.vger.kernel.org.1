Return-Path: <netdev+bounces-237103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A581C44D28
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 04:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 316F24E2683
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 03:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93FF25BEE8;
	Mon, 10 Nov 2025 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1D43oya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6421C163
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762744496; cv=none; b=guhurHwc85TbflOGIdUhwAs06cDgFa0NtZo0HhZPGFqS5tn1JHRnnnjQ+BUpkcGAC/hv7EIuAkNgW+7NOrtLu/nuxAdoL15K9/nsvQab9k8Yyg3i63Yg3dEKF1VgMnloslz242aclpTy40n+g46NzeXypRN90vlPFf22fTRjkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762744496; c=relaxed/simple;
	bh=iTFiTub1Xde/RhASHjc5IgLFmYv1p4qDZAcfT+00kVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLFFOmdsIwRV8VybTr8DqXZvKump4c2QIah1DVKMf5M2Y1Hf2jKo3Iri3FniTZ3UNkVPjBjlEN3cuzGJ7Q4yCBj8RmZ+KmiL8Qax/mZtJ4OBC3H519X1bd55zij7JChkpgTToWkqsngGef6sj3JN+URozBYCNRR94+ywCM5PMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1D43oya; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-794e300e20dso1702931b3a.1
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 19:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762744495; x=1763349295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3WT/IMP1k6RazoMHt6iRqiU/B+AjvEdlVGE4jbrnBc=;
        b=j1D43oyapOB8GgsG39+xJdiYTAvyYICK++S3qAPWUCnqmUOXOZsRjTEBzkaJWYcVxn
         Odrz5da46OnjDr2oScUemdRk/6rdPbr3ObtshQDhKqnFZZGupqoEPULPZ7tDHhc6rLYK
         3t9TQQBXRb+AbsscQ6PcZU3ZY/TIxvNKXuGMps4shG1Qghl1E84FumstwK0WRzElO4QX
         JWlC7cIDLewQXk1A5NT7BEz+RziUY+B84f3oH260TqaAwEF/871PUCFtXNI16URJ7SAG
         Xg4QO7z3EF7f02MaJfy/0sPAD0bJjDu8MS5rDlGmGWBg6ILbUgAUh4nqK5z6edEp6JpK
         ErpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762744495; x=1763349295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3WT/IMP1k6RazoMHt6iRqiU/B+AjvEdlVGE4jbrnBc=;
        b=EpdpuzOPqR0EAYPXJAE4A1MvUhBCBZTLl2paUjV2xKNp5De2uIfOw0pXEryp2G+ntZ
         amCEle5Qeop3G9PrmI20kaONUAvjGTy90AvUrhKihZdyq/HIz59Tj8OmX/QY5RhqK8aY
         mWmBb8ptCmHuUM5UIXDyUHXcUwk2Rg1da1slB86elwNmyUeHFPPrQm4fGOib4pNd7gu5
         4N2U5N/kK4EiCgYjtuubjFJP+6GG419yOh31er1usxk52OJ+8hO985jipqaBQaqbssX5
         VU7WHLlb8CMGNodMVvq58yy5isgcWWX3H7sxrI6STZhjzuEJ0NtF1AFs+5mw71HWhDN0
         /obQ==
X-Gm-Message-State: AOJu0Yy7HHj0qRwde3SayHiJuGSk9GK5Ut5bAbcbEmZ42jXxwpXl295x
	niWLcCRpYDSmLGHxP2Ex/je4IC1hxsbUyRwX/dDM7Xv61Eat4CkMQpRt
X-Gm-Gg: ASbGncu+wPdu+OMUEzWKGtKX746mH7/AfJVIMX7cK6jeB9eBq3ZWUJpliVh+c53G8Is
	lKJUU66iCgRgecwhehuT4w7RD6jY2a/0mdWzIePrLayzPgdms4WE5Tx2Z8GotDXOeLSdal+3RuG
	gsZet+qjvnJGAH4JvOYw1tj7UCkaL4dfPiUUZ8Z4GsMY+XLu6wkjsMvHn4G6DrXYlYyAGKXd5SY
	R+oucrP+PtJ3n+/ZnvGeyP1XyfC00UDZCqmkMWfmhUgliUPL/0SQt78fzd8JxVtjz7/IG54QmK+
	LMIvqBhF2YeBgG4fjQCePWZqWZ+EfaZHykBdem2DqXuCKjZjXa+gb1mTbXYykbwtIyzkcsPYHf/
	XcATUm54wNOCAePW4R9qj+xrsN6PQvlIODURL8odgGpdWJygq6tXvW6FJuP1LadlCYNy9kOOpJO
	D/1F5f6Oa0AVos/VA=
X-Google-Smtp-Source: AGHT+IGlswncx2UKLON//wZQ47eDwFbz6R05stN3os6R2S3EJ39ORoCql2JfAQY48ZZr7jrwa2FsLw==
X-Received: by 2002:a17:902:f601:b0:294:fc77:f041 with SMTP id d9443c01a7336-297e1e6fademr81743795ad.25.1762744494645;
        Sun, 09 Nov 2025 19:14:54 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297f5621556sm43915235ad.42.2025.11.09.19.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 19:14:53 -0800 (PST)
Date: Mon, 10 Nov 2025 03:14:45 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv2 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <aRFYpTAnlvnobQN1@fedora>
References: <20251105082841.165212-1-liuhangbin@gmail.com>
 <20251105082841.165212-4-liuhangbin@gmail.com>
 <20251105183313.66a8637e@kernel.org>
 <aQwKmZ6vF9dWZzqa@fedora>
 <20251106064512.086e9cb9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106064512.086e9cb9@kernel.org>

On Thu, Nov 06, 2025 at 06:45:12AM -0800, Jakub Kicinski wrote:
> > > And how would we run all the tests in the new directory?
> > > 
> > > Since we have two test files we need some way to run all.  
> > 
> > I didn't get your requirement. We can run them one by one in the test folder.
> > 
> >  # ./test_ynl_cli.sh
> >  # ./test_ynl_ethtool.sh
> > 
> > Do you want to use a wrapper to run the 2 tests? e.g.
> >  # ./run_all_ynl_tests.sh
> 
> Or make run_tests, like ksft

OK, makes sense to me.

Hangbin

