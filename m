Return-Path: <netdev+bounces-160048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9EFA17F2B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34C8188135C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8831D1F1301;
	Tue, 21 Jan 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQJ28ILK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259FA1494D9;
	Tue, 21 Jan 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467429; cv=none; b=EBYV5oESjyoCZuM5NyluMq6ckd9fdDMc6Y3nT3Ne8GnTrfHHt38UHY5XJKdO/mGXC9QNMyx3mrUt/zY0bDcrtm4ON43o+N7FMTccgi4zG+WyykhzYbBDwMJJUxiyPpb/1G/076+yyqxkeq11BeFJK9B4TDAoX+CM83G9VN3HRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467429; c=relaxed/simple;
	bh=Uwt/RkUdxKy1sadP/fr/MOCM5cXoxOyVAGQazLM3GNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlPyKo/bHdtjBYhMUuOD7KbIO6ITzSxpwUjLrKF4rE2QGSnjIFRlWP3lmXDgBXz+9S+G776sQLk6GCSK5jD0QpaZNN7u8H2kBXdD4senjTBa/U7f4D6l6Q9uYdHNYhU2gUKQFgeCqtsTEKjuxE27MF4ttJUzK0BWGJRwbgBU6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQJ28ILK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165448243fso121778685ad.1;
        Tue, 21 Jan 2025 05:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737467427; x=1738072227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vG50rxpHrJugvxAxIhPDCM0UI0nXxZum4EQEHShr8Sg=;
        b=dQJ28ILKkFD+KcpiQsgmvhveamhEUSlPkINp2YMPTeXf7SuAU8TMXRzL8/UBAQvZH2
         OJPF8MwS15eFNSMF1WUq+8BHwPbNTudrDvOYtWRP1psp15O6ucxB+Vd3yBMlMxVR/P4Y
         oxtin+QPfpJ0hUzPJDJKisEUgn5WpkYdrvB96hFVMuQ1oQAA2ohJColu/9XZgr4z09SV
         d7epg/QJJKwbEMrzRyzPyR72UmjG+B3qPBPUvWPxXuYXsfHlk40aRwFvKNem4fHC+XVR
         sSUaNCXTb4kcBaG5ZVweRiDkr2NtDFwJWeJ1XWiuqT92V6SstpDluUHRQQOsGI5l76SA
         eU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737467427; x=1738072227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG50rxpHrJugvxAxIhPDCM0UI0nXxZum4EQEHShr8Sg=;
        b=nDKK+hoqHUVRfWt6TXasVQ+vxfy/98acEt2LV3tMJMcCyy8fi771iIiJ/phpLgCCEd
         rT1NjcIOp8ZOVMIkBBwdfGCiNl8FR7De4QbsDiaWARLhBb/PJJvOPpeRHFm2Mysx9ziE
         Llt3BWvndlsvSdevW6JI0LxaDBO4m7h43t0wBDWr139rJG/ay50iR4U0bnjQ1Yu+VPuH
         bbWqMoTpXMmc7fvWs8XHWiXanInPlhKDABdDfSzdGsQ6A3TIVyiM36/t2IgvnvNvCJf4
         wgTA/0kGq9+hcgTaB1jzwBE9mLW6WAEdhNfgjMnaet+fDVRx72Q6NbCBYaPFwUNY6/PD
         74nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAy+TeR1Pgl4pF1mQh8SFICA+397YbI3v5Xc5AxTPRxty7/eysdTa4hnM5DZlIwoYFtc4LixAs@vger.kernel.org, AJvYcCUFP9DNyvzMQ+ShPjwFB1x0HXKugM4NCDMrnqRa0C5oONuTZvLuoA4abPRhBvcPZC3C3EgP2+nov7cyHRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEn67L5uBgxcydxsNNlLrV5HlRoFhk3P00uRtvqJcXAUdim4i
	uu1Awokrgrui6resehnqVtTx2B9Mau5bhjOI6jbvgZbuA91rklkuVsRWRw==
X-Gm-Gg: ASbGncu/RuHtDSr4Lo3MSQwn4KC7NsISBH2Jq+NlTHO3KzgICIOzqjDtPPdN1UoYCho
	hRj4OCsZQmCCOdyYGuyz3NQP9eLhoU8sMxFg756wEN9D09JEyz8OiXSPjPVsbG0h283CeJlOq3B
	1Z6f8utLwjIE9wJFB70TcptLzKKsegeqCoI9EPsuLdA/H56PV8PAwEem7rvmy0bM0k6tMCgCYmm
	tqtiDtbSCWgge2Uf6ox0omQKPXr340MxcSvu1euKQoRPdgxb4P3WVdOF2t3GIOnhyBeHPViEw==
X-Google-Smtp-Source: AGHT+IGt9998Bygq9uoW7YN8PkN0KrPx7K1Vo/TqAl7CuWy+dD5Cx5aGSGpWfh1fBmtBGsdnEPyUUA==
X-Received: by 2002:a05:6a00:4c18:b0:72d:8d98:c250 with SMTP id d2e1a72fcca58-72daf9a5535mr25259429b3a.4.1737467427037;
        Tue, 21 Jan 2025 05:50:27 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab8157f3sm9291546b3a.55.2025.01.21.05.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 05:50:26 -0800 (PST)
Date: Tue, 21 Jan 2025 19:20:23 +0530
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>, michal.swiatkowski@linux.intel.com,
	anthony.l.nguyen@intel.com, piotr.kwapulinski@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI
 descriptor registers
Message-ID: <Z4+mH7s/YnfdXgJ5@HOME-PC>
References: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
 <20250116162157.GC6206@kernel.org>
 <fe142f22-caff-4cab-9f6f-56d55e63f210@intel.com>
 <20250117180944.GS6206@kernel.org>
 <e3aebbad-42ec-44e5-b43d-b15b9cd0a9ad@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3aebbad-42ec-44e5-b43d-b15b9cd0a9ad@intel.com>

> 
> @Dheeraj, do you want to hone your minimal fix to avoid sparse warnings?

Sure, I will update the patch to avoid sparse warnings.

> follow up question: do you want to proceed with a full conversion?
> 
> @Michal is going to send patches that depend on this "full conversion"
> next month, so he could also take care of the "full conversion".

 I don't mind sending a patch with the full conversion. Although that
 would have quite a few changes. To clarify

 1. Are we updating both @reg and @value to be __le32 ?
 2. Should we also update ixgbe_read_reg() to also handle and return
    __le32 values?

-Dheeraj

