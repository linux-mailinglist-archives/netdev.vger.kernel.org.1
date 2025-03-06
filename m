Return-Path: <netdev+bounces-172676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0344A55AE9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08138188D669
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F672054FD;
	Thu,  6 Mar 2025 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1MbmFkl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC7A13D897;
	Thu,  6 Mar 2025 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303891; cv=none; b=o7t0yPtQKEn/oIvizTQV7RBvqNFbPqkK5KmuAp10mdrH5HfBSS8C0m4JFktNqPJTSMd1ijbmNkTlOSGZcypWQUjrbwPC+BmOOQvZ1fVmFpijarLSR8a8wORmJac2fnDNYgDR2fJgfmG9azPOx1z1ssRQ6KPGP1A4+G7ESklCYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303891; c=relaxed/simple;
	bh=/5/X9nock4B043zzYIA4QiRQvzW6OTYeIzbvrLnt+FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyVoYzHHT7vri4Qhvfs4YIF0uv2uhzPgLXEkFmQghTu9v2cRQ2lgQHA1Xr3RQ+NGbXWnF0695zvAev9Pii35UhZVFIUzwCYzv2aT3Dr2+kT2wgrMnhR1vGBMJIhUQ9OR4NmalWRbQk7jEKQD291GY+Ml4EWdF2455O6ijQMhXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1MbmFkl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22185cddbffso46476185ad.1;
        Thu, 06 Mar 2025 15:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741303889; x=1741908689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbc4B5Qc7VlyIxPME83+2R4N0whC72xFyy0kP6DWisY=;
        b=W1MbmFkluUdgiccOkJKKzkqut8QuyC9Q4CMrC9jOpbKwRs1b3NLlGaMVnujgM6rEeg
         aNAGe0cjF6l97l71moPlQFn4MZdXOJwFBxsO9augVcwsi3IgXPZgiPk1s2R1DSNftdIt
         bYDKzg3ZQgBLyZK5n1QV3hAyozw8GMUoALI/0hEzj2SZ/v7KW71V+kTp/4DAR8Ztu1Mw
         E+CpvGB7RPMh6z/hb2GImWYfJAMXctPuq0tUct3oWxfMOtRWhl2NH5WNUIBJYxEL7EmQ
         l1Ew32/KE3wyvFDKqAtHsPcEQTNo00S3MHp9tKtOS/j9w7OxzJ7BM0Tq2Eq8a1QIqgx/
         jB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741303889; x=1741908689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dbc4B5Qc7VlyIxPME83+2R4N0whC72xFyy0kP6DWisY=;
        b=Y3pZ4OO+l0V7b9D2AhQFPWH9cX/j1a9+FVLvv5gvMiiEH5ks1RRYCdj2eh4T6XW8MF
         ZyX4OYVZqn3TBGjgW7aZ6iLFVkaW9XQ7v22Eh0FpYbehKjcHxqxqm+TjcTRY3966odrm
         E5ud0Zfy06+LPxXtUKDJ79PoYTYsAr/3V4UXiTRfQCXj6NQTH9rRKEuy8Vh9aApZHxqA
         jP18mfbdO4QmAxGCOOtuM9S3Vq4Yrahy+2/wZHGVabEUihczFMc2Itd0T6+iOzF+KEL3
         fYKeAqadRJi+7x4Rg69JoOJjoXWayopjj87ZFoNXc6ZDjCu4Mykeg4d1iXXmRISAMT1A
         ZH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWanskpoJDcaMOKTIMwKfrSdzOMs7Wz1e2TpygW5jM/GDyd2VSnmZXNDwQLWYYU7r5jWRKNij5k9AA=@vger.kernel.org, AJvYcCXtG0LnyiDNh327HWJVMeN85nMn+kku/TrqubaQIdsDXL5uDWJwcvtbGIpbe+PR30O2W8fYoqIs@vger.kernel.org
X-Gm-Message-State: AOJu0YwQEHNIJQyx4N7bLX/7Posl4ZuCuU7fSgXoEU2CV37SZNglS9m9
	ByGEFDobkCo4RO8ejVLAnJq0t26PRHBdng/bACICHV2OVfsAASYZ
X-Gm-Gg: ASbGncsroeI8wqoYO9Zya2UIXgPqW1/bkOR0MEUEpnkbVJ3OoSV0pMnI06EuHldJs9i
	M/AVa6gnUiq8B1JoRyi1M8XrclTsm/hOnHZtawTfmn7ytgAZ1f3PRUDnUGWHyvEo7r0KynTEMSs
	JSmoBQEXDJGFCRTnBcpFjtq6iJjrKDVP6xWA7F2lKzYSe2WswdQBGGmkvNp5Qej6B8j3/zkGTjx
	Kw/x2rvXUoPUWelVS6KZJ9BJi2Pgnd096/ULbU4AEV7KmYSUXAKXZUl1L9ufzRR6mHvQP80W1Me
	tmdOf5MbJRNm+z+8Lb2zBByuC7ji592B+yvNe2dUrO0efPEX
X-Google-Smtp-Source: AGHT+IG60Qj1lBt3UFNXsq0ITCVFXlNx5c3ljnnSaL3XA0bGKrMMMSlCS7bNbKJ8/dlRbu0edkhNOg==
X-Received: by 2002:a05:6a00:2fc4:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-73693e294dcmr6538691b3a.1.1741303889346;
        Thu, 06 Mar 2025 15:31:29 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ae20f4f0sm59148b3a.134.2025.03.06.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:31:28 -0800 (PST)
Date: Thu, 6 Mar 2025 15:31:27 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netdev: add a note on selftest posting
Message-ID: <Z8owT1glLf+436yv@pop-os.localdomain>
References: <20250306180533.1864075-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306180533.1864075-1-kuba@kernel.org>

On Thu, Mar 06, 2025 at 10:05:33AM -0800, Jakub Kicinski wrote:
> We haven't had much discussion on the list about this, but
> a handful of people have been confused about rules on
> posting selftests for fixes, lately. I tend to post fixes
> with their respective selftests in the same series.
> There are tradeoffs around size of the net tree and conflicts
> but so far it hasn't been a major issue.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks for the effort!

