Return-Path: <netdev+bounces-74737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B70A86299D
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 08:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C271C20B3D
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 07:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA9AD2F0;
	Sun, 25 Feb 2024 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e+HRpC9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27B8833
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708845487; cv=none; b=XX8foVPv70Zk073eW10P+5LDDSPpTywieyxd64rvGug7y2X6ufUUWI7ee6/4uLXG3uKYgvDSjSX0g2kV5aNWO7hKSfG6TayeNVox1L9xlnDS+yTFLDKOSiNAZVu0OW208GIEvKjb3HoSLziX5XOzCXIyoiylqxNAJpV42OfMn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708845487; c=relaxed/simple;
	bh=zZeR+n7PWvpkQ2JHycsa1jX0C5jjNU85zAeYoCrL7/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMbxH5WmnPnMtH5khTbUkBJw6Vs3QuxJ4Ix7OwPRsuGtxnOEVx3r+K9g6FK/FsOHUFOAK3tl85SbskCA0AeLPt5OWJEL+dGUrfkLdJ/kJNSo86ZHaf8z38zcTlAikt1uOsRbz6Pcb4CzZceMHru9+bvMr8VZ/m1oIQy4xkcb7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e+HRpC9l; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d23d301452so29462171fa.1
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 23:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708845483; x=1709450283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrE6SPjvHEFxjwPlVIy+3LIJdPdKbmsIWC5aSbnqvCA=;
        b=e+HRpC9lSCGPhJR3647j79z1VEilhRzZcX/hs2XXyW6MFsgXxVCScPypGOSoVsoA1s
         KzY3ILSJVwRoKL2R2L6NLELohEWJKkC9t5QzbIm/Do13qAsNRwSbifsWQ9Dlc+1H+lYi
         j+T1Zm02+KOpbgAARIrjuVSqBRBuZvfyn9qhqtpx5VDOTOlpFM5M0o2PcrOp3ZejaUE+
         HE2zN1Xlo0muITdtar6YmpUm56fbSjO3rhH9LGz7gEJjtyiPgmSB1SqcxnnoJeZawXvU
         LU1AYrQDWNgz+W9n03AkbjomPWk4s4GHXzijwTKCd6798KX5l9Xj2qKhiOcjazodFyFm
         8Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708845483; x=1709450283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrE6SPjvHEFxjwPlVIy+3LIJdPdKbmsIWC5aSbnqvCA=;
        b=RLKf8ASp/vaDA+v07Ym+x8UDjghHJiabiBs3cOClIUqvOAV08A3i2DBcuFq/vExrnd
         v03C1fvL0ZIu0Cx+I5ME0XF39gXBY7msO1ipS9vV0i69RWahTcjKNpxy3G0VeZ+o+nPE
         X9TWLKxPTRDIwAk3eR5NvZAoORebQm40qRMMGd2eM7HKh634sH3Z25BaRXzt2IN61yNh
         QmhcuJM6IT8dXeC5MUqXbFokWS7Vgoh1TgmsfRrDnkbIA3hgeuLlsUsMe9EO+wF6Lyoz
         nddaJ1tEstqs/22WOHHs90Z96aUEkxia4CCs6N/0F3vwmlDEMLmuDpLfS3GhyTBJeOnt
         mrtw==
X-Forwarded-Encrypted: i=1; AJvYcCWY46AoIN4Y261USjUyFZ3XXLRSX34lleWZdAXLujyo5OC88JQEEzSVFKoni5KOvusvm8x5lOciF9C+EDqkNlYk/Dhwh3Ux
X-Gm-Message-State: AOJu0Yxoj62arZh+ZdMBMulP/mUaGL32TsitqhmPH/WqUMeqgvohWgIC
	tuFwzrrXCGZUMtdm+yKPD4FtcFQalJj9tcCshT3APU00Sqnum6J3hJ/Fcs27OnQ=
X-Google-Smtp-Source: AGHT+IGcbdy4Bs2kvvhSFmFEX1zM6pEjLy9i+beyz5COb8QRME+qrUAGr7Ggv7xa/c46aE3AhjgdOg==
X-Received: by 2002:a2e:2201:0:b0:2d2:6c74:58d6 with SMTP id i1-20020a2e2201000000b002d26c7458d6mr1976900lji.44.1708845482789;
        Sat, 24 Feb 2024 23:18:02 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6786000000b0033dd4783058sm204275wru.9.2024.02.24.23.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 23:18:02 -0800 (PST)
Date: Sun, 25 Feb 2024 08:18:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, przemyslaw.kitszel@intel.com,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <ZdrpqCF3GWrMpt-t@nanopsycho>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
 <20240219100555.7220-5-mateusz.polchlopek@intel.com>
 <ZdNLkJm2qr1kZCis@nanopsycho>
 <20240221153805.20fbaf47@kernel.org>
 <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
 <20240222150717.627209a9@kernel.org>
 <ZdhpHSWIbcTE-LQh@nanopsycho>
 <20240223062757.788e686d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223062757.788e686d@kernel.org>

Fri, Feb 23, 2024 at 03:27:57PM CET, kuba@kernel.org wrote:
>On Fri, 23 Feb 2024 10:45:01 +0100 Jiri Pirko wrote:
>>> Jiri, I'm not aware of any other devices with this sort of trade off.
>>> We shouldn't add the param if either:
>>>  - this can be changed dynamically as user instantiates rate limiters;
>>>  - we know other devices have similar needs.
>>> If neither of those is true, param seems fine to me..  
>> 
>> Where is this policy documented? If not, could you please? Let's make
>> this policy clear for now and for the future.
>
>Because you think it's good as a policy or because not so much?
>Both of the points are a judgment call, at least from upstream
>perspective since we're working with very limited information.
>So enshrining this as a "policy" is not very practical.

No, I don't mind the policy. Up to you. Makes sense to me. I'm just
saying it would be great to have this written down so everyone can
easily tell which kind of param is and is not acceptable.


>
>Do you recall any specific param that got rejected from mlx5?
>Y'all were allowed to add the eq sizing params, which I think
>is not going to be mlx5-only for long. Otherwise I only remember
>cases where I'd try to push people to use the resource API, which
>IMO is better for setting limits and delegating resources.

I don't have anything solid in mind, I would have to look it up. But
there is certainly quite big amount of uncertainties among my
colleagues to jundge is some param would or would not be acceptable to
you. That's why I believe it would save a lot of people time to write
the policy down in details, with examples, etc. Could you please?

Thanks!


