Return-Path: <netdev+bounces-238341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BEFC576F1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BE1C34F36B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4275340A4A;
	Thu, 13 Nov 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1xc6OA/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61694322768
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037230; cv=none; b=s3idKhGD09HW/tNVXKYW0HLrCPx/XZ3QaxbBuXgoalK/9Leo1lR71G+l1T8+WG1ks5dbTDVQC6nL1Xy+3U44/JWdqq8Sn/lwHyylIaRJu+bBRZZ15VHLnY2bb+Em1Ply9RanD5iQV05ztSnVwSRPzVBlWJMlBErCJnTkleK1lFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037230; c=relaxed/simple;
	bh=fW/z+sw7bBv0H9LZpTfPAQLGjnrsBySKmjmtRanqUzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPezp5hvzLHiZKYCuMCzms4J9CLLyRPxgtWf9fY7WQv1XzkeLZtb/Qe6kioiPpZMAkvHLJAi67BkeWyD2wBy/Kr7ik50kDlE20/di0wJIFxmJzusDCmTACg2lOkcBPTmLBop4/Gpj7lZN1iklwhuMR+mzSbGBOfzD+S3LY7+XE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1xc6OA/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b4933bc4bbso704139b3a.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 04:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763037228; x=1763642028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGhdvq+Egyjw4aCqB4AVvYPYjbKVh7IeV/LpLuY9DIY=;
        b=F1xc6OA/IsLJ7wmO2FOhwgUJulVCkj9X+whkA57LPlzgkjXw2dZPL57q3P1Mg4kGgX
         2z6Mut/Go+deFQXKrYOda712dmdu80OKgEtHHSZzOzLeSaX8oVbyFCHbGSOzJSeWc5Nv
         VBIMbY8isjs2VZ4EOWG4wSQLJ/eRRG34iVRCRwfomdzQ8n8xvEtU666XzXefxtJw2GsY
         8Kja7yduVRUpqTaeS5EbwQClSxQhgk1Z5r8lc30KLVkHWmLkwx9WLxnpm5X/L/C1ftKt
         oOPX450kKQBjWAEgq5i3NQVgzlq4prOiDMGiVulkSmBXc0TMNGSbrVB3RF9CHFMsafoZ
         afFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037228; x=1763642028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGhdvq+Egyjw4aCqB4AVvYPYjbKVh7IeV/LpLuY9DIY=;
        b=DwQCSzsGTNRZFFZ8WdCdCTr40vjqQQeUJoUZjpsNmVn+L5YGSlv52lRXzpi5f5ga/o
         kvO9BI6o31XCYSo6B2tfgmyyVMMG4LJzAGIIS6kWJ3LGJEaOFKUP4BvDcmO1oEURvDGy
         lw8/z2NmMA5JoHyW+UT2Jv7cYALh79AhPSzSdo5LF5jbAJq74+bC9CDjHliAWN9DKKUm
         FkBzvHJkAt66yLfHB5QZCW2rUEiVdzPWsGJaxX7DDOLxZ/AIUZfsniLI77Z+4EOOMqdX
         UwpKrUGE1wTn2pzPZinYqJ8zVLlOerrum7xu9tqEUBcjBGt/jaBsPmk9Z/2bJaihJ7J5
         B8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUX+fHsDm1c9D50tCYZ+PnLtvY8vjBPCN/TFDR4ktk27TxSUZOfDgwNCdCYE6NzPF41urnxjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwCwpRwcAYrJutE+1GFpk5JVqKiVeUkGhVhjJrrNfd1JIAHdK
	QnFMrljo5JxcGvW2gH5TTfwTxMKFUhLT0RSbOUqNMTUyKGbZM33L/oIz
X-Gm-Gg: ASbGncuhzCNdL6iGg+Z05OblGsEMQd/iJPbloTg+f1K7wOjBPtMsd7zUjxO3+kzBy8Y
	kXGFQZ0C3iTMzVt6CtKQUG7+30q6o6Cq6TGpi7xuRY+GoT5qPsEjJ2KJmlLdhiquz/1VzFQuFTy
	gBfiR2OvnO2zfJ52uzPoRSw6rB1T8GLty3n1cTuwKlLUhQdEfQ9vF7tpmPuok9AYxf+0qOybmGe
	gJTeuJ36qkrO08PVUdKT9wjj0Zsqfwn1j84b1hmwsX9nC3icWB/f2vyo4KSFp1BwhRyoZWCoOeo
	AEjydPIZHkLhUJ/vlu43apuqM+wIyzIEHswJQjiSaqxpSC84eCSg2tlJhKS5OmR69PTYlAa5iJM
	AEb6AExvI/lJL2gkEAGqbR9wsyaF8a7nRC3EWlGbfl0IlBQieT+JQXGtxBflDL2b9VEowtA1riE
	Qwo5jr
X-Google-Smtp-Source: AGHT+IGjPjnwi6AzyizLdwC7cXuxzE/YoUtWzcXmPZ4XdaN86kNI1KwbPTVrjTpwwSR2DUEaeDEGuQ==
X-Received: by 2002:aa7:8381:0:b0:7a2:6adc:cbe8 with SMTP id d2e1a72fcca58-7b8e214c467mr3105134b3a.16.1763037227708;
        Thu, 13 Nov 2025 04:33:47 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927c230aesm2219132b3a.68.2025.11.13.04.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:33:47 -0800 (PST)
Date: Thu, 13 Nov 2025 12:33:36 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv3 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <aRXQIJMCLTaqIZLu@fedora>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
 <20251110100000.3837-4-liuhangbin@gmail.com>
 <m27bvwpz1x.fsf@gmail.com>
 <aRV1VZ6Z-tzbDlLH@fedora>
 <e63b88ca-ba6b-4a6f-9a57-8d3b2e8c5de2@kernel.org>
 <aRWqKA5nUAySkJFX@fedora>
 <e5c95174-2f6f-439d-b557-6e223f982de5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c95174-2f6f-439d-b557-6e223f982de5@kernel.org>

On Thu, Nov 13, 2025 at 10:59:49AM +0100, Matthieu Baerts wrote:
> >> I know these new tests are not in the selftests, but maybe "safer" to
> >> keep the same exit code to avoid being misinterpreted?
> >>
> >>   KSFT_PASS=0
> >>   KSFT_FAIL=1
> >>   KSFT_XFAIL=2
> >>   KSFT_XPASS=3
> >>   KSFT_SKIP=4
> > 
> > Yes, that's why I ask about the return code. I also prefer use the same exit
> > code with selftest.
> 
> Should you then exit with rc=4 instead of 0 in case of SKIP?

Sure

> 
> >> If there is a need to know which tests have failed, why not using (K)TAP
> >> format for the output?
> > 
> > I feel it's too heavy to copy the (K)TAP format here. I would just using the
> > exit code unless Jakub ask to using the specific output format
> 
> OK, I thought it was just a question of changing your 'echo' from "PASS"
> and "FAIL" to "(not )ok ${COUNTER} (...)" + print the header and the
> number of tests. But sure, if this format is not needed, no need to bother.

Oh, this looks reasonable. I will try add a helper for the output.

Thanks
Hangbin

