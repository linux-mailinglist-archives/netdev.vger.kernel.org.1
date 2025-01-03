Return-Path: <netdev+bounces-155059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E0A00E1D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42807163DC2
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C21FC114;
	Fri,  3 Jan 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuEcth1i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DE1FC0E0
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930559; cv=none; b=cXRlamOEasWRjv6BC5y52zMFaW/ADYTemItDoef6rf7PNGOddgVuZsktCiDa3dZZZCGh6Pb7hu0f317ZgU1cDgWOL4Fb4v7H1hUqFX2cJ/I/V4o6LdjxSsnEVXS+fQ8IXLBOaVNyMGUMqV+hk1KYS/K12L2TleV2dKDTYqfnA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930559; c=relaxed/simple;
	bh=nN0+bF36XDHHIXnsjhCnezeIPfJiQXVmqxQd0qvn/ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SR7hGZ1gvfLjOx7leunsWg7KxvLO8wZrxFR+NWpxb5gO7gEMKkwXLs2lwHlUoyaazwb4rllicEVCK7VpOjOpVLfh81c4/Gh2Vxd/X32DbmEfbwIcNhTpV8D+/weerU+g97G+1cf+lK2O/sZXpwaLXcLXk0pIu5jv9PmbIWIBIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuEcth1i; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso20746175a12.3
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 10:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735930556; x=1736535356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN0+bF36XDHHIXnsjhCnezeIPfJiQXVmqxQd0qvn/ZE=;
        b=BuEcth1iUWCJa44U4oyhijzl5+pmfqFqZfpC2CPfQv0qu/B1wwaS+aLUWHTGPDneDp
         BTXYpkVwGj0KxTFID+ZWfkLFoyt4bW8XW4i64Ids2zdTbseSAbFLKmyoQuEQIaMrDV2o
         tctQnVepqPlwb33RMqn7FTJPET1DXYfrl1EX+Dr+CpIkKd6DJePN8Vv7q4s9KYbMnrkh
         /kn8w2RUrXH183YCMJW5+UeRHMJ2leMV8PCvLiqQ94tNJ9psvjQzE9HII1ZIz7Rre5rw
         ne5xLQ/FtxH0J2xGFJJPiSCvYyqkKe8tVLfHWlCJ5+FZDN4djFhcDRqBGBvRTPhRC3cc
         iZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735930556; x=1736535356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN0+bF36XDHHIXnsjhCnezeIPfJiQXVmqxQd0qvn/ZE=;
        b=UyPZG29n9B3CpusQRHawDMeShlBhzqFLAOhj7rl1f+4WE+AmQNe9dqvCNdWUrt3VJE
         FjGTM3KQlq+4Tz9jc1CxnYS5sZURMaSgmIJCN9sx/nxH4SywmYoZnFeb80H1o+oOFFml
         t+C06h2RuWJdnlS4AHvzHz3/aqQFWW5mk/nlI7ADrolbw3/b+MsVU2hTs1PxOoSIcvt2
         a7dYZ/0yQfMzzyxMCdTH+3X8FgKjZ9KjMaKNl0cO3iy76nCd1rAbv0F/vYPjSI61CA+a
         /Fii7M0299BUo23OmqSP4UN2oOWxVPTIl55omdbbkdKneZFhV5Np8rKKLLc162ZAfv+a
         D+lA==
X-Forwarded-Encrypted: i=1; AJvYcCXZp/5ykCWNGJsmvHwe1H7tMc5x1bAyhhVJ6f7aJ1+cQMsCo0E41o38pWQpaK8elL13mBY0mvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKXi/BMDNs4hsMkWBaG9ryCKcmhU6RhLc+khxogfOeZjitFrv
	hKuSvtoA9jEMfipXSh+Th5YkbKzeM5dyuiXkQXsz99AoRp9Dti4QjehNF2UwFUgOGvOx5eHJUok
	kk8rCENnq6BcMk7drylkvZz3Q6tflBXRBYO5U
X-Gm-Gg: ASbGncuw2QoKVmkUzOFv0fCaCC8lLBYluYY/g8OculpPx78UfZ+jjVBSrDUBVyNRyDX
	9bsJ8yC67V/0Tr8WsBPxrythhsrSen3/dn/tslw==
X-Google-Smtp-Source: AGHT+IGKVf8vzrepKHCVvvJ2psrGfRzbp5F01o2/flhLYKR6xlrD6MIQsppYh7RYmlYShFWBVQvrVyjxEyCJQjCHNuc=
X-Received: by 2002:a05:6402:5189:b0:5d0:81f5:a398 with SMTP id
 4fb4d7f45d1cf-5d81dd846ecmr111537192a12.1.1735930555718; Fri, 03 Jan 2025
 10:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103183207.1216004-1-kuba@kernel.org>
In-Reply-To: <20250103183207.1216004-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Jan 2025 19:55:44 +0100
Message-ID: <CANn89iLTTC-W-CzcbZAuxNSr1DNnxJfMnSH9Qeo1sdAZOSp=PQ@mail.gmail.com>
Subject: Re: [PATCH net] net: don't dump Tx and uninitialized NAPIs
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	jdamato@fastly.com, almasrymina@google.com, sridhar.samudrala@intel.com, 
	amritha.nambiar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 7:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> We use NAPI ID as the key for continuing dumps. We also depend
> on the NAPIs being sorted by ID within the driver list. Tx NAPIs
> (which don't have an ID assigned) break this expectation, it's
> not currently possible to dump them reliably. Since Tx NAPIs
> are relatively rare, and can't be used in doit (GET or SET)
> hide them from the dump API as well.
>
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for na=
pi")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

