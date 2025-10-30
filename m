Return-Path: <netdev+bounces-234281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E25FC1E937
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D9F04E2E20
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 06:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746E2F7ADD;
	Thu, 30 Oct 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF8UAmLy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE3FC1D
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806129; cv=none; b=YYua95HCOZUJMgRY9cy2Bw5+ydeaeKP2rxv9FBTEeXU8nCmAvzh2BkDS6l/yowZ3UFC5IoNB9bv/9Nkd+W+nbauaHL5jnYC8ItVmmwdiAnnsmJ0XABzIADcxlqr34SlqSCW97LjR1LmVizNi+AjM6yKx9jbqx4aRJ02rejNMlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806129; c=relaxed/simple;
	bh=jnkRr/o96U6GB+V6Jok5Aq8jZFjNnKuWb6LJxrZjtX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9sQ/m4n0GZclWHMkWMN+zGzVhD1N/lo1ClVgQwWqYCIpOoFn4D/Tkfkd6WZXQ+c5gw1SCxK2kqyjSbSqUuUAmT3g2NlRFSK/pbezXYWg7FIy0FnoXAygj0jr0ve3d6pyPc6pjgN5vIMkV4qn6NgJWn3EOtW1nsR8UPJtFPm7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF8UAmLy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29490944023so6130345ad.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761806127; x=1762410927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GH2hPiy7GhdUU4HV6KSqVEBs6Wse9wPYwwUBAC7Ots=;
        b=IF8UAmLycFxeSDoSdb7algvfNTnolzHQV8iSx2nmB2Jh5b3B1OuTEvOea8TL3biBn+
         YI4BQB10so8lU0lXhPMoI8Rvp+a008QZQzVOfgCjinKWO3kfG6/zEx8xGOOWJ3X0mOl7
         vYKq3aiABVoW9jqtWE3YO/RpNLIpCHloo6KhQfhjlGsUTehxVjn7qeMYKskH5ZUQXx0k
         s2VRBGtDCIM+QupGA+fvSMVQlSPWV67vZy8wFRH/w2i/PfkMHMHzeh9MDYOfIWXhd4/I
         x6Lme1juOvHn5nfAsBFs4qK5uftLI/KUizyGWwm/lntMEy6ItbscHOLsXe4eFc5bltb4
         XmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761806127; x=1762410927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GH2hPiy7GhdUU4HV6KSqVEBs6Wse9wPYwwUBAC7Ots=;
        b=pHluC3C9BPBGS8rUpxU4y/1WSVPlGIAz4Q6d7srQIxiraK8rXwHCQj/RAKWv+spGot
         kJRBJzSf9frm2P/wDLop9n2JxfeihwaFToMNXVfDzhsXqSJPQndvuLSzVYEUjV+eph2m
         K9geHgd7AxexHDNH9DJvLo/pe87hMOOKedjwdTcFeRYnsKuF0Gk86ob7dn5T8h3lgsGq
         I29hruHNW9ywB/RyS5Di8a/J3diFDv3t58bEgFmBxctFx7Um05mUgULALFlMp4UHrMhY
         SfZy4q6PdITPVlqyfpuYhVXRPosN9BaSjSSNOR3CKSUta6ZCVwMpkKrsG0Ks7vr2V4hA
         ZLng==
X-Gm-Message-State: AOJu0Yw0yNiCC/saR6nuY6CICmtDuyN4bbsK+O39B7DLtDKZVGrnnQjr
	XyOENWWulJBqUmcepOcbn8HhVLMBZYHqFP45c41wZ5RK8/zD+FPiBgx5
X-Gm-Gg: ASbGncu67Gp/A4tMgEMWvbL9uRh2HTFHj9s/IBcZP0srSc/63VVp8nlnX8JjWqQrCPg
	g4pVqN2zlTBEnUhGD5gOhhL2cIT090oyPWFXgUl2XSZBc8rP6jOsLbGUXeYkvT3v5P3j4wIl8WM
	g8bM6cCRM/QfJMayQX7+BIG0LzQ5YHVqPvth7bTAjfNDORgjTH4WptD/3ZW47t1PA51yg9oIF/a
	KJtxCa5+xrggnglPFGrzRmV7k6oBYGLntf60S0M+krmLduzvRKi3bIbzNWLnPgqIiZXqb2vsQCT
	M553WQqfwjV7oyvUShDAYNUS9kmkojrLOIzX+gUWEr1dRZ5FBKhlj+BTz4llh47wZ2gO84fLEmX
	k+Bmb1Eo2hkLyRMxcxpcAEiJ8+k6k5ejH3UufkS7yaLh9f4s1zFTBmcUa2B1EqtLkP/LrupiGMx
	8eNfbMgbP/6gLbjPc=
X-Google-Smtp-Source: AGHT+IGY5r22edQtye/eJlYxvm5st6DLjzGYvCRNGgRUU9gWKlQ9aub02V0VpjYCGi8gMJd4CPzbmA==
X-Received: by 2002:a17:903:1c2:b0:293:57e:cd70 with SMTP id d9443c01a7336-294deea93bemr69108265ad.28.1761806127417;
        Wed, 29 Oct 2025 23:35:27 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340292c0d81sm3657855a91.3.2025.10.29.23.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:35:26 -0700 (PDT)
Date: Thu, 30 Oct 2025 06:35:18 +0000
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
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <aQMHJlwcchqtoAa7@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-3-liuhangbin@gmail.com>
 <20251029163742.3d96c18d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029163742.3d96c18d@kernel.org>

On Wed, Oct 29, 2025 at 04:37:42PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 08:22:44 +0000 Hangbin Liu wrote:
> >        -
> >          name: dst
> > -        type: u32
> > +        type: binary
> > +        display-hint: ipv4
> >        -
> >          name: src
> > -        type: u32
> > +        type: binary
> > +        display-hint: ipv4
> 
> This will be annoying For C / C++, and you didn't set the max len 
> so I think we'll also have to malloc each time. Do we not support
> display-hint for scalars?

Ah, I didn't notice this. Should we convert all the

 type: binary
 display-hint: ipv4

to

 type: u32
 byte-order: big-endian
 display-hint: ipv4

Thanks
Hangbin

