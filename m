Return-Path: <netdev+bounces-168432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5603A3F052
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E56E18862BF
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95C11D5ABA;
	Fri, 21 Feb 2025 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c5Nt39+4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA63FD4
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130341; cv=none; b=r40AAiqk2KHOJq5ukFPdzk21KhdaWgI0cBZTnlyzE3r6s67Ur9Z1bsaastjDdQLJii6gusc3uJt8tLNwltJd6GWnNYTXzbzSlwEGys49KqulYFA+06L6hKQ/KCS+PSild10UaaI54aNLLJbNNcmdKZP2WkeZhAQr3bYnivtd+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130341; c=relaxed/simple;
	bh=TnXJmiSGpnjYy6Ey6qAmn46K2jggTRMZhU8Y6PBkjhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjPTUiKJQJXQhQ3UWrzUAtyfrfLSlduwE7K3F/pAZZSe7FJ6y/JsGA8GWhJDkXYl7HTOgscyhiQ/Q/vXVBGN48PllzIVwhQbYWnnwH1zGaCXFj32sWCP9OBRBCQwlm5NrkQAtpnu/X/iIeEFFhwCXkGxP/X3DPxtB8pSdlx1brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c5Nt39+4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so3364683a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740130338; x=1740735138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnXJmiSGpnjYy6Ey6qAmn46K2jggTRMZhU8Y6PBkjhM=;
        b=c5Nt39+4dzoTIxspxYSuVrBAksUWKL9nwhMxareevLcSbjeNIs7baZ8+eI1BJuQ+U4
         eQnPGDfvzQ9cCaMqwY29lupyWd4AkHu8lCwSr93LwuXsjE5j8au43hWTd4RLkaU1p4K4
         9fR59asC3dF/fiQwZMm4w6cEQhNZF2vbNzMXdb7JHTm2P46z4jF2M+FD4KnEuylU4PkG
         IL6e/SScxypKJ2YNjgyuZ9BHPNMSCNUilQvfQ74Zyhp6YPhvmxUt3OD1O0WcHVzmXmr2
         tovbEVamCK6K3PWq8R49UwiKimHyIUzYbvzY7WnPobPVvJOJ47NN97EtSrTxvVeK1PLI
         oBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130338; x=1740735138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnXJmiSGpnjYy6Ey6qAmn46K2jggTRMZhU8Y6PBkjhM=;
        b=qqOwR0M4LPaSA0Yw7yBt0JZxb/s/11eClKo049PSEPSzDchIV4SvUqMJrSNVjKukvw
         a30R091ZU+gtedUefJsqVRC5H2HqqnzbhSwG6Sq0OXO/uKyX4hGWQDX7ThmHxYHsAKm4
         yzl0W+BHH2qwEYgGKl3uNk0iWzyt+Smbgnn8PYMMqaN2gbefGuYLvvT44O2oGOUcxTD6
         N/i8/6RXqVaWMSN3AntBT5dWaXIjEd+qoiCsoae+TV13HewkE7sZuj2xId6xyBoByIiS
         aoeMoP85VoRxHkZGlUV7BefD2Gu0u/XlQ7vyo1vkSXZRNak4Jz3YqxJWEXl74naJR7wj
         IaiQ==
X-Gm-Message-State: AOJu0YyqWsAjTgtQedoHtEcvYYdHqVUEbsSExWCqPE0S51SvB3IYbgRS
	UBnSzgiaJlaw3PRhZtWm7pofzW2HDfmaEyUm9ca9yXB6mOzdimLGXRPMpFr5d9V6DA5bRlEEQ2J
	md3g=
X-Gm-Gg: ASbGnctlvLIasOlonAlPGYRUPewgZCLmSryWe/MWHg+0u6erLgPUYly9SQU4CAFUHB2
	t6ibyq829zd1//P+HaNQ2fFEShSNf9Kx4I9lshapAXUJyEyWCu2jkVC5hpci/8lJgPAY2k/+q7p
	+meEuL+zyDHPeCcTUHMuO6WkJcGvXaBJTf7PHrjVm4Ju0PpN7j9+55imkengwe5CZgaMo2TPp/4
	JwNmdGobuY9QlQY5iKOHmpRHh72mTCsa40oiqOmTEo36fOc0FWyPR8pEtycPNE/9ZnmtfQk4EOk
	kxQ2b+PoU4hJEksamdgaJUGQ4Sy/
X-Google-Smtp-Source: AGHT+IFTSj4kz0hLbVadCLEWUpb00NeUuGEvBAnZVzWMIOja8IUsVgZXA6IfAyJZelCW1JY3Ko1AQQ==
X-Received: by 2002:a05:6402:43c8:b0:5e0:8b68:ffae with SMTP id 4fb4d7f45d1cf-5e0b70f9ac6mr1812927a12.17.1740130338082;
        Fri, 21 Feb 2025 01:32:18 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e0a0310f66sm2847502a12.81.2025.02.21.01.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:32:17 -0800 (PST)
Date: Fri, 21 Feb 2025 10:32:16 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz
Subject: Re: [PATCH] ss: Tone down cgroup path resolution
Message-ID: <2acs3j4bwwiza2ppaguohwuzx2aahiiseyxfsaw2vbmn3g4xrd@235qwlv4kyck>
References: <20250210141103.44270-1-mkoutny@suse.com>
 <20250220142043.21492b4c@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jo7ascbzamitj4tf"
Content-Disposition: inline
In-Reply-To: <20250220142043.21492b4c@hermes.local>


--jo7ascbzamitj4tf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] ss: Tone down cgroup path resolution
MIME-Version: 1.0

On Thu, Feb 20, 2025 at 02:20:43PM -0800, Stephen Hemminger <stephen@networkplumber.org> wrote:
> Patch looks good, but will not apply since missing Signed-off-by.

Thanks.
(Feel free to ignore v2 2/2 patch but believe me I checked README.devel
before sending the original patch ;-))

Michal

--jo7ascbzamitj4tf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7hIHgAKCRAt3Wney77B
SRDiAQCpXAHYfN7UK8TvwC4pqWHgLnQc37Bbwl7MlygCJBLAtAEAmhBW4cP48W5j
qZ/8LBgYFcVaU+jm5lQgQNhl0HYNTwg=
=yirn
-----END PGP SIGNATURE-----

--jo7ascbzamitj4tf--

