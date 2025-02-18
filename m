Return-Path: <netdev+bounces-167346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5774AA39DBF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762C6188560B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC9522B8B9;
	Tue, 18 Feb 2025 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YnHWD7cu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3EA13AA5D
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886037; cv=none; b=NzS42DLfl/GZjRG+hUgbjw7tpvQpN7LODf0dadV2ZpoBvCMcQqtL3YjOIicQven5CWvdBTcWF/Jze5COijZaOdomhE2iWNrH0YTeIdVAKE7T9k+xFZIg2CalHx4TSrL2MVeBCUTKPPxTLY+SqNqj3xLaO9fZphqRzb5kXVczivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886037; c=relaxed/simple;
	bh=LOrvRScCTvK/gdOTKEkyuePY0dEl+Q2jKlYjYE54OjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPKTT4CSyAurebPs+NFIjzXkloWPGk5ZThx7iLG+3LQrVo9Iv9Okr7S4BU99NeiDyT+YPYh/tKGy1ydEsQX2HWyucNnI/Uw/CSZx0M6M+gpaCJMQvbSNdSe4LhYC5p+YL/Qox6JROspnrwwv2nsLQTK+VzqYCq2RIaLDfsFL9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YnHWD7cu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so6631829a12.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 05:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739886033; x=1740490833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOrvRScCTvK/gdOTKEkyuePY0dEl+Q2jKlYjYE54OjA=;
        b=YnHWD7cum75UbvwTM2acQsMRJGWbAWAW8PCBVT+aJv1UoB1WGMPOt2yhLa0sefuo4z
         OvzCO65IIEjLn4L3+UGDAWbkAaCKBFsQ0+DLx/YAxgme/c7yZeYM2h6FnZE4X6c4apYt
         h+FmWEDiDs5b3ajOz7RuGOIPW5mBjjwij3QNATCz8llvcq37Dw7viZn6ch1ziKrrj3Le
         w1VzhWhyf1CZGmSmlZlA44uEor4s2xiGRwbVAkqGR333BeXs3ynHDKL3yjvUk1K/jw9/
         oN379QYm0jhRjeQ2n0pVhT2nnPeF8ZWQ3YS355mhm3OxjMHdVtH3uAKxPchlFUk2B6JF
         Mtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739886033; x=1740490833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOrvRScCTvK/gdOTKEkyuePY0dEl+Q2jKlYjYE54OjA=;
        b=NJ3h/fHV3g9VWHaX9m3pUU9a9ManfFC32ZSxSzLyHfO8U1fZ56gDi7Uj76iPZONTB/
         J/UXoixM9goRyM7jRla7hGNzkS6sOAtzjoJqVqpn1keUxYorcdxAZuKa9XRmUuu6hxs0
         zehOfUIgwd6rTA6LM7cLo+F85JZS54CU/nW9Sj6ioyPoaM7TNgrUf9qULjSrf12wG8SW
         bLSN163Umm6vYaWUCVQCDy6v1I8yEuPw3KQJ04JM4/H/hfFDZzohdM/mvm/u5VrtxPGa
         QXIlp6tdaUm725x0qwkmuzHd78EJuLqjUI84gsRwdshoZsNFXwDbZPWVzOlkXzBC8a3k
         sTjg==
X-Gm-Message-State: AOJu0YzDZrIllanF/pp4tcwqeC5fSCNQSSzW5pnETS1fLEgewYt10gKs
	+bDqbfgAO0fWaK33F6V82cgjwawbY0Ttqle/Lt4ZXyOuyjdSr4bLDiEAy0oAEt35iWoJBLGnZmW
	jvNA=
X-Gm-Gg: ASbGncufe6Jr9k0hfHKGaCvC85+zsIdg+OmidtHkxDlXqjxDrB5ao69GX0AbTq+6Lws
	nihGskwFCt9Pw68e3EBU76XmvhmCAoHG+BAlsITS9EMPAdfZ3AdAJE3ZP6UrtjfbRucXZtd5m3l
	2RZkYamF/gRz4uyH3n0LtXAcBPoHCSb45Lz/ExzKFdnLfwBQUVhkshSFihMVpm4T6maqqHV4z17
	8dhuCalNvEBnzvcqCPG0PtDEBufn0VusdRmgeaTpDFtUXkm5IdkfJjAr2joa9CHXKtdz+bBtFWE
	m0Nf2c57/SiYwO6lhg==
X-Google-Smtp-Source: AGHT+IFbgzdn+N0V4iHjjlDpDDFZtbgBP57ci69pw7ketdN5bB/NssLV2Quwo8reL0WV2nTOUKgFDg==
X-Received: by 2002:a05:6402:350d:b0:5e0:2d53:b2a with SMTP id 4fb4d7f45d1cf-5e035ff9ca1mr37744214a12.3.1739886032362;
        Tue, 18 Feb 2025 05:40:32 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9d1a0049sm357359766b.40.2025.02.18.05.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:40:31 -0800 (PST)
Date: Tue, 18 Feb 2025 14:40:30 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Davide Benini <davide.benini@suse.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz
Subject: Re: [PATCH] ss: Tone down cgroup path resolution
Message-ID: <3wlkt2o2ghjmqn652745btelzceth6mvhqmj3fbjusonwm6etl@p62u63i2zjl6>
References: <20250210141103.44270-1-mkoutny@suse.com>
 <1818b3c8-b952-4dba-8b46-a3175adaeb8e@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajzesoxw7q4ywdhf"
Content-Disposition: inline
In-Reply-To: <1818b3c8-b952-4dba-8b46-a3175adaeb8e@suse.com>


--ajzesoxw7q4ywdhf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] ss: Tone down cgroup path resolution
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 02:11:06PM +0100, Davide Benini <davide.benini@suse.com> wrote:
> however the cg_id_to_path() will return a string "unreachable:%llx"
> and the output will still be similar to

And I think that is good -- it captures the situation with the socket
like its "property" and not a global error.

> But I agree that removing the specific error message would be enough
> to prevent customer concern.

One can do only so much with sockets of rmdir'd cgroups.

Thanks,
Michal

--ajzesoxw7q4ywdhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7SNywAKCRAt3Wney77B
SQ1sAQDTh0/7SxTiBtGn/9ThswOWALoj4+7dUZUBQS7kJughjQEA8c1zFdrOJ79N
iSt/OpBv7+bB+yC0MUhRyG8m/OAjXQU=
=PXT5
-----END PGP SIGNATURE-----

--ajzesoxw7q4ywdhf--

