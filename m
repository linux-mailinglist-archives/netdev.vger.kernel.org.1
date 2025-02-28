Return-Path: <netdev+bounces-170686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9E9A4994C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB023AE7B9
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F6626B0A1;
	Fri, 28 Feb 2025 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="arJtUswu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118126A1CD
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745734; cv=none; b=ayUPUVI3Oc6oe7YFVV+TJaDlpksG/1Yv0ymbhIqg9/N4ZXX936rQ0xvuUPunw724DtFIMUttYjz2wvEiLpEplSoBT+dqD5vviHmcNP66GS8xiKtelT8zQJ/QinwIMnl97/zt//sl/MH/RvMlkEfv1Efh5f0AzxrdTGrLrnL2Ieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745734; c=relaxed/simple;
	bh=dm1L2wKB0z2EWey2phj7wx7/Z77CtK2PGpa+bwO3ZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3bR0g+JCS4t+znEot3WaqLKQrlXLJSp4UIIN4VI5Gqvt4PiF9LSTqEtPQhyAI0ArvPQ1ebdiItaQCWLNVijAA1o4/fABo8lVatr6AshAipjMUqzer+VIakS+VftnVu8hFJPfwBbR95WgaoK9FcYb2+mKeSCm0II+9zcMdQgSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=arJtUswu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaecf50578eso394178566b.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740745730; x=1741350530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMDBEWFAlSazDWvEnLIWUhKoprViCd/FBtt1Cw03Vw0=;
        b=arJtUswuIvMCKa3TUljdlpjnxuxMKoX7+Unzl2BrgXuxjEzHR2aHcVf9s2JyP88k/g
         oAh3bQNGUOQgYdn1gCNNbIb0pw/dwwgpFIFwDyq3hJG16RjGN3CPhyUjWoDzKetl4w1H
         Kx84jJGUZmD5ohshLgaSkpOqf6ZTDAp9aJGRslH9ET4okepEOC35F0EFLnTm8BaTWymk
         7o1quJ2lM8IaRojFLKpOK5zl9+DR8LYm218VyWU8Qd653VIUOtzLdDLQlN5alMNiMRXY
         Uci2zGfNN4uW9JHa/d4li/jizKCzOkt1GzHT6O/V9oVS5xBshUE6NVW2B3UPhWvB+J5k
         F5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740745730; x=1741350530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMDBEWFAlSazDWvEnLIWUhKoprViCd/FBtt1Cw03Vw0=;
        b=qh1/WeP+R4TmMb4ftRwIkpNa/AzDWn03B1dFX/mWGr+sPd7saUlaiB+hODfvKre6kx
         vS5AZti/lruy9ToOX2KhKGmfHZmJYltcyRaR+TeV7Bx6a5XqEXNfYFYEWAbmpvmXosVN
         EzEFJmCQFvrcp70FbIZlPni2yJg1ngS/Lb2q0gWmh415lJm7N8dOTratVImTWSzM7oTm
         bMmZANMDlA5k2w6L/TLWinvJolL9aU0bTocVVvyMfFdfDBiZ4fk+IV8UlK44ZJE0WKeZ
         Tmvxb6sbHItHVmvqTXyu4Kx7qxBhsEQTFHlzqpZFl8rK3vybrcRHBGcGWzV4Cyjn7pcV
         PVPg==
X-Forwarded-Encrypted: i=1; AJvYcCXgcFsHoJEKkJaA5dndIfPmVW5k3BJv3ZRGmdlUxEabJw96ESyyY18TGkaUjv9khSUg+uDzUsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2B7nLslE6TnpkORvkQ0CfxquRg2J+c086FDOBcA3Kj98x8ia
	CoM87p+XtkrZNr/TFcs+fYbJQkTLzIK+dvmQmrk/khzzjJwQ6SAIQgkuCvWWNOA=
X-Gm-Gg: ASbGncuHHo4PckHCt3IVH+IPUiGQmMMJ5kzwo7Da8zwocC2qeqMpjW0D3sb4P1ZI9GV
	Ebwa5ClRqDxCYVdzVRMXM7Wvr6g6h/ZXxn6hZanGgWWfGOoOEfjnOl1xr6Ip7a0rlJriz9vfRVa
	Jd9DSeqLLW/nx9fzA7VfEvt2Xl5u81JhBFx/AYpfmPNjj2qIvOxbZQvA+QGpeaGdxp04IXrZxxE
	GMPB1ENeh41SfyvC5Wa2AMFGkdRmp7Uw70Gj1mCdFIh3LNA+WxPJHo8ERZ/dV4QZBgz0Q9OYP/V
	FjJoZl0gSyJQSkGqsO3DgCTko3FQVmIk6RwWIrIN9hke8zD+MWCitA==
X-Google-Smtp-Source: AGHT+IEu3m3agMJr8cwe0JNDxL/58cjFFWWEQ/7ZN+AsMdYriaOzXBJEdDBBPlM6IWMlMMb2viuqBQ==
X-Received: by 2002:a17:907:8906:b0:ab7:6d59:3b4c with SMTP id a640c23a62f3a-abf25fcf2aemr319474266b.21.1740745729904;
        Fri, 28 Feb 2025 04:28:49 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0fca17sm280745266b.79.2025.02.28.04.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:28:49 -0800 (PST)
Date: Fri, 28 Feb 2025 13:28:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 07/14] devlink: Implement port params
 registration
Message-ID: <oqeog7ztpavz657mxmhwvyzbay5e5znc6uezu2doqocftzngn6@kht552qiryha>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-8-saeed@kernel.org>
 <56581582-770d-4a3e-84cb-ad85bc23c1e7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56581582-770d-4a3e-84cb-ad85bc23c1e7@intel.com>

Fri, Feb 28, 2025 at 12:58:38PM +0100, przemyslaw.kitszel@intel.com wrote:
>On 2/28/25 03:12, Saeed Mahameed wrote:
>> From: Saeed Mahameed <saeedm@nvidia.com>
>> 
>> Port params infrastructure is incomplete and needs a bit of plumbing to
>> support port params commands from netlink.
>> 
>> Introduce port params registration API, very similar to current devlink
>> params API, add the params xarray to devlink_port structure and
>> decouple devlink params registration routines from the devlink
>> structure.
>> 
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   include/net/devlink.h |  14 ++++
>>   net/devlink/param.c   | 150 ++++++++++++++++++++++++++++++++++--------
>>   net/devlink/port.c    |   3 +
>>   3 files changed, 140 insertions(+), 27 deletions(-)
>For me devlink and devlink-port should be really the same, to the point
>that the only difference is `bool is_port` flag inside of the
>struct devlink. Then you could put special logic if really desired (to
>exclude something for port).

Why? Why other devlink objects shouldn't be the same as well. Then we
can have one union. Does not make sense to me. The only think dev and
port is sharing would be params. What else? Totally different beast.


>Then for ease of driver programming you could have also a flag
>"for_port" in the struct devlink_param, so developers will fill that
>out statically and call it on all their devlinks (incl port).
>
>Multiplying the APIs instead of rethinking a problem is not a good long
>term solution.
>

