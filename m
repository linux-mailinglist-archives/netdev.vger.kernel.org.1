Return-Path: <netdev+bounces-182474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CCFA88D89
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7839217B9DF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5901DB548;
	Mon, 14 Apr 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O169bNkz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85BA1D79A5
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664615; cv=none; b=Zo/BS4f0BrwEEX4PtUoExEpgn+GY8/dTUq2JhzMs1ypz6WM/Z039XqDL2+/Nzk0eDBmHRIvZ7IPA3AenRfak1TkEa43ne9LV3G5lNkZwSiv7jsu0/GtGyYNncLoofP52s6oPwn4F04AtKQ7bM7RzuI50c7x6DvXgz/efJEDG5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664615; c=relaxed/simple;
	bh=ZUxwPdJHhxQqQuNWm2cp96I1Eoh/jsRL0UFbb3NBotI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdGK9nDpYaw49AoO0qcJgwSKZU/BnNgP78cGdRqzI0DOvhRdNU2DrYu/oWLkIXDPL05ToK7I3BjSoX198hJgImheeXS7urdef0Aguk3GSAeQP/zNFplYxH/4v7pKxTpQP40ZxBBaxQAn2jvilembEdc9/xb40GjElH6Bi526uM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O169bNkz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b061a06f127so1984385a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744664613; x=1745269413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCULBaQwyAisTm5S6Qz5VtpzKHdmP0WCNac7PxMdeks=;
        b=O169bNkzHjX5m3WQf5u0Q7Awsex5L3UGOL35MiYI8ERFp+ckym52OCXNAqiAMrrOil
         dJHhTcyGo5dBR9yIA+vQ/2iqC5Ty+/HZSRWLZ/7L/MYDvAr78cqstxuhFH5KkSQox7PM
         Snx+QJfjXlsBVqdy/duUAPaBmOOkgbftfwz2tTofmTIASKRe+2lDOsvsvr1m3hzXir29
         xoZP5Y52ZZg9ZaAdi7UdGcOy8bvTBKk3S/RUQ72Kosak2ge/4Uc3xRGLvMVJDYrrX2ZE
         DCXMnLRoNDnuKoGx2WCpqGyME2au3KQ4XHHtDO9XCMm0/5r5bT9aPkgCLr8YAUZ4v8VU
         lqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744664613; x=1745269413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCULBaQwyAisTm5S6Qz5VtpzKHdmP0WCNac7PxMdeks=;
        b=b2Ty6TPcP4MIyE6hXfSCZRqP0gcLy61T7FtQADAh35qAoh2N1kbA2yqh+c2f1b6CsN
         +s9MZ/XLTURW33SLrgGjcnbPyfJV3Bo7c2RXGPZu7wdubweXFeW2axNtBagvLSRAnCIM
         H+HfRkdmsP7eSMrGvILEd2u5xa2NHEdP/pVllEm8nCYDbbJdGKqA6Uyd3U0xYFDmrEKE
         XEZe4GlC1QO0a/KnuXeZfVV1g+3gW0AxYgxH3hQVGh7ADkNLobYrXa94ytFx6D33s4s4
         FqC5Nz65cS+tAZiTkeIw5aXXaVBC5Pjwql2CxOU+UJ7y5Vak9P4Q9sHmixSAeqXaJQva
         PnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdCARQguJlhiItLYPUtEsDZEkqhQ2FFBnfAjNN/jKhhd/M1eDk8ws1dm+3+DrTPUqe20fGpAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tkEJ+93v44SnWPaxytPaa47luPspj69dq063R6HYXNh18iDB
	k8MeTlMPaAP5/PUephIKFT+7X309kklctvGsxy/aZqaZJSZjgAIi
X-Gm-Gg: ASbGncv3GnVHR4NWR9zEQR4bvdwBSYLuaAv6DVKfUVYsNN4EFbLDDRSKoTIZ3fxX/ob
	EXbmglvDTtUnv+yYHPp9DpTJcppWkq3dM5bKQhUX4ueGop+5946FCgXmbLQyw1yW8QxDSTy18Nr
	7T0/xEBS1G+EspYT5GEK1gLEm1rMKelja87/v7iXsjHeEfAZI3Z4hNlhvw5Ko/9udVBnS5BXF7u
	SkIj2d57CWP80BO3G4UZ0xpZ0BUE/z6Ir2yfl1g1X5h+ppiBDA7F0ONGq0O7GY8SeoPi3eKHoN8
	bN+lR6l4t5h11Wjl8QpyKXIXhw4aEoaqu0nXUmOLOnda
X-Google-Smtp-Source: AGHT+IHJiWN8bThYEGuBk7LkXijBnGF+LVCcOhY00wXM5lOdSO7svTlzguXcNKB6XGQPh4Oph06cXA==
X-Received: by 2002:a17:90b:2d87:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-3082367e7a7mr20672507a91.20.1744664613052;
        Mon, 14 Apr 2025 14:03:33 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd12b599sm11739978a91.23.2025.04.14.14.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 14:03:32 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:03:31 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tc: Return an error if filters try to attach
 too many actions
Message-ID: <Z/14I68bvZRza6eB@pop-os.localdomain>
References: <20250409145523.164506-1-toke@redhat.com>
 <Z/aj8D1TRQBC7QtU@pop-os.localdomain>
 <20250409171016.57d7d4b7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409171016.57d7d4b7@kernel.org>

On Wed, Apr 09, 2025 at 05:10:16PM -0700, Jakub Kicinski wrote:
> On Wed, 9 Apr 2025 09:44:32 -0700 Cong Wang wrote:
> > > +	if (tb[TCA_ACT_MAX_PRIO + 1]) {
> > > +		NL_SET_ERR_MSG_FMT(extack,
> > > +				   "Only %d actions supported per filter",
> > > +				   TCA_ACT_MAX_PRIO);
> > > +		return -EINVAL;  
> > 
> > I wonder ENOSPC is a better errno than EINVAL here?
> 
> I think EINVAL is fine, it's the generic "netlink says no" error code. 
> The string error should be clear enough.

IMHO, EINVAL is abused (which is probably why we introduced extack). I
prefer to find a better errno than EINVAL whenever possible.

Extack is available but it is mostly for human to read, not technically
an API for programs to interpret.

Thanks.

