Return-Path: <netdev+bounces-236152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB258C38E38
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48703189C6DE
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7066F21E0BB;
	Thu,  6 Nov 2025 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA3dyg0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119D4414
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396836; cv=none; b=YJOWs+zfAwS9k4dGHqArFwUnsz++VQMNH3YMWQEznBhDnUzYBU3ZGjWNF1hbLUaOnapo3J9GCUD4lHCrVNyk0wk1mRy1tLAGLxF2f0ZbNnNxGo+MBwrAaGWVJBuEdr0XVCnb+EfmKw1a5+zqfXgRpLNfm9dx0hOMQ9CMoIYcUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396836; c=relaxed/simple;
	bh=tH5X5VJRwVanumOc8ecWQzj676gehjlrX2chNBWouGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW477ZZVIJRuutMN0TaU9BRWXRUwByPdqse+LkWlOqf3Cn9hi1gAm8KwpSERDeUWT0O5G8jH9AHvpPhOGk3MM4D8A0gxmoKUUjxW2hc4ui5LTTUh+xuYfe7Wex4FTuPOcidnF9lX3Wg+49wQKWCajPxLo7dTr/afLDFFt0XO80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA3dyg0c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29470bc80ceso5547835ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 18:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762396834; x=1763001634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYcb6F7Vd5gH7Q/qnDZ4+pKlbt0OoJMRahPMh/hD46Y=;
        b=LA3dyg0c/K/HIXqiBtrolLuRxW9FNoWd6XG30D3Sga56Ob0uWaSbR7X5sGQHl4cNaU
         i1kMBnsIV3lv1iXhnhf7KZitbT0cabJi7vKnU4Uo0gin15wr/UJKYhZEiKn8XpiUMlD7
         ZsnLsB0eK0pi0nD4J7O3PPu03bWzKHFlNuJ9Ew/QV7b2sFOExXCi4FQsa0te8GF38lD4
         A0XJlU8r9ITr88Z0xgz9Lp+/gt9l8x3t/Qkdziq2UIYWsKicE6pDEBIWsSAQbN87FWNu
         pMmpFPJiqVqpgakKh/JtUf0dsziuxp35CN638WmOt4fFGUTu54xHpYDthdsXFsHlmtCF
         N0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762396834; x=1763001634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYcb6F7Vd5gH7Q/qnDZ4+pKlbt0OoJMRahPMh/hD46Y=;
        b=tB+F5Irs/lq0fvKcVHv+ELeNhT/jlocyhJSWJOpAF70/mwQJQtNW1QLYd/VRAF2Nho
         lCXagJz4RkPUhQoKO4v30rOeowZa9FQFCKv9XvBPLdGTrVVAf1kJd4M1YCC+2E4bw3XC
         2kW32MDmNA+EjNiCY1Z6685DOGs92FGjUAYIIR1tQthaMknkgKJnYBiMx3BSHgA3EL+i
         21gLJdnQAeE5B3WmNk8TDfxQgHmCmgcO2YbDXeynKZidN7R6F4VL+0vosC7Y3545282m
         gGwqEOSGthHV4A98wA9UnhPWMau4wDB/ngLf671rxeiZht1fAM9LxEWVmdI/NbP9CMXr
         DCRw==
X-Gm-Message-State: AOJu0YzfV7DCHSxqo2iFv/GQW163bDxovn+v1Bv21RxJt0ek5VldGSVq
	CuuLygGQLqj54BsqxsOAJiTwJKb4qohet3Ye0QT3n77di/XW7sKZt2t+
X-Gm-Gg: ASbGncte1jHz+I8uWdKGJP3b7zfWuk1CnN30vIjlNCL74duSqwtfalsJS2JAJMdsM0p
	nAvCq3WjNn2Y6TBsp9rC3cZhAOMbZOAPd/cEPaCBE/EJiJlQoPQaoMWtcwnEVupVEpbOOD+lhh3
	uCGKdTkQr/6sWAmfCX0x6TB5Ruk9/Y5OKRlGjlRjNAhbC9xXDzZtF40jvV4OcmfM7gi60rHFioA
	VQtwuvGaLr6DKyGTzUbz/efYPencDJedZL8YEOyk86qn/eWk1GijiTpjRNLizUtdRWYymLpaBCi
	wOvp79U2ginVuYZRHtUPbbRaM1PKLNRNHTsek7z38UU/ikHGuSrnPDRlnCPpxGt89yEsSC+a8VP
	3cOJ3E427EdD6H9z9aeI8sOuD79dWF5nfhTkWoUpTQbCL/o7dhbtvITGDfEgcrO57q3SiRm+Knm
	2/dG1vInvCL9dBlxE=
X-Google-Smtp-Source: AGHT+IFg1f9YKVqNcDJjdE5djlauaWuB8kYdGHnH6Vlz2BqVvMZaWOIP+teUJ2dfUYH4rYcTcZHM7Q==
X-Received: by 2002:a17:902:ce02:b0:272:d27d:48de with SMTP id d9443c01a7336-296510437admr23106325ad.18.1762396833325;
        Wed, 05 Nov 2025 18:40:33 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm9420305ad.108.2025.11.05.18.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:40:32 -0800 (PST)
Date: Thu, 6 Nov 2025 02:40:25 +0000
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
Message-ID: <aQwKmZ6vF9dWZzqa@fedora>
References: <20251105082841.165212-1-liuhangbin@gmail.com>
 <20251105082841.165212-4-liuhangbin@gmail.com>
 <20251105183313.66a8637e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105183313.66a8637e@kernel.org>

On Wed, Nov 05, 2025 at 06:33:13PM -0800, Jakub Kicinski wrote:
> On Wed,  5 Nov 2025 08:28:41 +0000 Hangbin Liu wrote:
> > Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
> > ethtool functionality. The framework includes:
> > 
> > 1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
> >    operations
> > 2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
> >    feature gettings
> > 
> > The current YNL syntax is a bit obscure, and end users may not always know
> > how to use it. This test framework provides usage examples and also serves
> > as a regression test to catch potential breakages caused by future changes.
> 
> And how would we run all the tests in the new directory?
> 
> Since we have two test files we need some way to run all.

I didn't get your requirement. We can run them one by one in the test folder.

 # ./test_ynl_cli.sh
 # ./test_ynl_ethtool.sh

Do you want to use a wrapper to run the 2 tests? e.g.
 # ./run_all_ynl_tests.sh

Thanks
Hangbin

