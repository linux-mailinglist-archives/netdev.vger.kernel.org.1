Return-Path: <netdev+bounces-235313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB19EC2EA93
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3791718947A1
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3E52F88;
	Tue,  4 Nov 2025 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y46HFNvk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F027456
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217301; cv=none; b=dbQnJGbh0+XPP3cXSok/WiWX8Kwc7mIgfxrmt2CkcNelO76+2d0mBY4bMvI0R6GtXf4AMAmRvh+Z4/r+vgnbuDdiC/P0qT62ZLS1d/kUJpRJ+db5YPE+vxwwDrSYnCxX7WJCUZv7DC2YuC3t8eEKPujTYzCGWZdSIaQmI/cdbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217301; c=relaxed/simple;
	bh=4Dpf1kT47SVRDtpn/cSznt+bTK6v0hS72U9THCinuJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm98cscDrCnZOjQd+Jq/cyQ8PRjH3EfbtDg76wHf+WKM0l7GmsFoZUrfZJJWSYunwWYdyCrAKnrajNB6lN4J2CN1OsR2ZvVhuZqRDYpgfPWLT79FKG9rOdbn2SUW8Ozwwk2pFkFVN+S1BRxpP2HtTAbzbaGu/qlFGkplku5iXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y46HFNvk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so4595722a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762217300; x=1762822100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3Zyvcg6HsP3kuXtclPYWjtOPlsZtk1ijNjr2zUai2Y=;
        b=Y46HFNvkTPBg5b97zhudNQihhbjaHqqC+xgZqT3JVSXieiwtvO0z9VjZrrRienSijr
         nJRTvUKm+aqA9LpQbOQlEyITV8WXG59sl1/DPm1u1131nKJvUCSZDbtnQRpfREW05mkf
         7Tzi/pFmVcRBjejo3MvQ/Uqa8EiIYGoQMM1siPuSDqvuiFKepKn7419qWYuXzxA2Jn2f
         LuhJ11ESFNgRbNi0CeAQWZggcGRdbBuQ2nkT3/BVSaPVmSw75l01rbpUUn1KZtyMVZKM
         93nn1S/ruTOatQVMNOEGxzrbNzyeuvsGg19RYUankThYaM1wx7H4YobIL1qpIlyEUdKO
         k/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762217300; x=1762822100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3Zyvcg6HsP3kuXtclPYWjtOPlsZtk1ijNjr2zUai2Y=;
        b=mOlMQCZnBPaMz+fxJa2PU7dS+IH/K5M72Pk3BS50yGDqBY2rX2qzmgsa/iaJtG2IK8
         vuHM1Uc6aytlqpg25IHrwCQxfZSqBI9kED6g0d0MoI99llGoIYw3VVp3se1hLWWC3jAt
         dbPa6TcTBsKxTQ4YUHFvfNU/w1TX6bASIbNjtRUGhkqqqBo1pTmj7v84XfL1Eiwlk+mw
         VL/TuPqeZthNON2pZNvrKhk4Un84ruxiuDN9cJrKi8zhBIBZV8ZDTbqcRF2Q4BQRwgep
         oM0xDEdQw21baeJCQCvwfTc7DxaEkpMXHusD7HIPRwf1EGvaKvCXakP0k2rNlGwkgDq5
         0ElA==
X-Gm-Message-State: AOJu0Yz1NTumV+3tyHjRknd3Z+r61ImLs2m54QqZnalGU1wzeh54ugIc
	lWpsZd/S6YDXz+9VdaynobKevxohoQQgeOO29w0gswnmK7m2O0bHPUyp
X-Gm-Gg: ASbGncuJz8e/hUkBYozPwIdjYkffUJUOroJJ18ix1MbHsmaUp1LWT5zfA83+teL9l/j
	8sUXCFrLah+SXWytsdirqbVHYvE0POUHn7MJQpdo286BErEVc1YEGWrzKahUZEe+VcZVT+6jiIF
	c1kB6sVIDGSG/+GEXDU64JsWK1RpNbB7F36/mL6AzLddKYvxdg6sZ3xsha9XLwOVJ/74dWnSx5D
	ZuIM/Yc1cq2x5bmi+vEHE934REsf0vlfeJqdZ4SKq7MI0IIbaRBAupqPLnz1E3q43RJlqPbR7XZ
	SV0kybbpMyDRJzgUm9jlz/pJPvKI3U/Y/G/4Jg7rqT76Gr8SFoYBkB6Mkq7LTzWgh0Q4F/wmfXX
	gqLGHnsTm9kDzUQj0mBpvcjCwxt008zoRrz3tSW5vd+8oKcG/YvJ2MhMWirFguorI1DfBkMAw42
	6GXsY2GOempgFRWVA=
X-Google-Smtp-Source: AGHT+IFrD3Dj5D8+I2H1WbW5AULK93SPkl4SYUCS4JiL0AXyHtpWOTY9OaOZmnvJEPJswkxWa0+Zwg==
X-Received: by 2002:a17:90b:3c06:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-34082fc413dmr19660243a91.7.1762217299693;
        Mon, 03 Nov 2025 16:48:19 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159fc0e19sm2400662a91.4.2025.11.03.16.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:48:19 -0800 (PST)
Date: Tue, 4 Nov 2025 00:48:10 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: net: add YNL test framework
Message-ID: <aQlNSkaJQLnd-RQM@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-4-liuhangbin@gmail.com>
 <20251029164159.2dbc615a@kernel.org>
 <aQL--I9z19zRJ4vo@fedora>
 <20251030083944.722833ac@kernel.org>
 <aQQVYU1u3CCyH8lQ@fedora>
 <20251031112406.403d1971@kernel.org>
 <aQg5y_Feg6YQ7Odl@fedora>
 <20251103160527.2813b61c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103160527.2813b61c@kernel.org>

On Mon, Nov 03, 2025 at 04:05:27PM -0800, Jakub Kicinski wrote:
> On Mon, 3 Nov 2025 05:12:43 +0000 Hangbin Liu wrote:
> > 
> > Hmm, how should we execute the script under `tools/net/ynl`? Use the cli.py
> > like:
> > 
> > ./cli.py --spec ../../../Documentation/netlink/specs/xxx.yaml
> > 
> > Or use the installed name `ynl`
> > 
> > ynl --family xxx ...
> 
> I think under tools/net we don't have the kernel selftest infra.
> This is not great because we lose the integration benefits,
> but it gives us the ability to.. do whatever want..

Yep.

> 
> I think relative paths would be fine? I believe that if you run cli
> from its directory you can use --family and it will refer to the
> in-tree specs automagically ?

OK, let me try it.

Thanks
Hangbin

